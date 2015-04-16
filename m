From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 3/5] Documentation: add git-log --merges= option and
 log.merges config. var
Date: Thu, 16 Apr 2015 00:49:15 -0400
Message-ID: <CAPig+cS7aCN5Boevnp_S+rgJP4GKxpMeVSnjEaWEKcNECC-21A@mail.gmail.com>
References: <1428938968-19013-1-git-send-email-koosha@posteo.de>
	<1428938968-19013-3-git-send-email-koosha@posteo.de>
	<CAPig+cQG4NxxmtaQ49xsU3g6UwZb0RqE67PnQBeYrRv=2CGodw@mail.gmail.com>
	<552EE5D7.9070703@posteo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Koosha Khajehmoogahi <koosha@posteo.de>
X-From: git-owner@vger.kernel.org Thu Apr 16 06:49:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yibjt-0005tR-W9
	for gcvg-git-2@plane.gmane.org; Thu, 16 Apr 2015 06:49:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751769AbbDPEtS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Apr 2015 00:49:18 -0400
Received: from mail-la0-f45.google.com ([209.85.215.45]:34177 "EHLO
	mail-la0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750859AbbDPEtQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Apr 2015 00:49:16 -0400
Received: by laat2 with SMTP id t2so48033177laa.1
        for <git@vger.kernel.org>; Wed, 15 Apr 2015 21:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=bQctxfIUkSEgxT2M2sPSkshJ/B9qjIvbjISmp59lOYQ=;
        b=mZ2hjg+C52qtSOib/9x3e/FFaxvqXOMW42G4l4fMtvKm8iAaxg/dcP+CQK7RQIhRi8
         q/Y1Lvx9T1FroXl7FKH2ON6YDPejkdmhvgkjiPPkvysJpE1TnnRjo5niAjh60aTHA3zY
         clvvgLrM1cXo2jDxC3s54OfJ3G8T7xqej6aHM4xE+3cpeobNfbggUp+oEmIQ+tf1hxKR
         SD74YRnU8PLv98oKjUzKfmHrQyHSs6YXOKD7HSKI+e/GpFrQMnXfhD+3evpghVum+OQ9
         51DhvLwWFxd9d97eezosLhoJBT+2JLy5gdU75RGUodbqmy5jb8jGv8VAF45t/5tZx/pA
         K32A==
X-Received: by 10.112.151.211 with SMTP id us19mr26241829lbb.120.1429159755312;
 Wed, 15 Apr 2015 21:49:15 -0700 (PDT)
Received: by 10.114.25.193 with HTTP; Wed, 15 Apr 2015 21:49:15 -0700 (PDT)
In-Reply-To: <552EE5D7.9070703@posteo.de>
X-Google-Sender-Auth: w-DHAi201FH9QFxW3OCRiINa8f0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267248>

On Wed, Apr 15, 2015 at 6:27 PM, Koosha Khajehmoogahi <koosha@posteo.de> wrote:
> On 04/14/2015 08:42 AM, Eric Sunshine wrote:
>> On Mon, Apr 13, 2015 at 11:29 AM, Koosha Khajehmoogahi <koosha@posteo.de> wrote:
>>> From: Junio C Hamano <gitster@pobox.com>
>>>
>>> [kk: added documentation in git-log.txt]
>>>
>>> Signed-off-by: Koosha Khajehmoogahi <koosha@posteo.de>
>>> ---
>>> @@ -96,6 +96,23 @@ if it is part of the log message.
>>>  --remove-empty::
>>>         Stop when a given path disappears from the tree.
>>>
>>> +--merges={show|hide|only}::
>>> +
>>> +       Limit the output by type of commits.
>>> +
>>> +       `hide`;;
>>> +               Hide merge commits from the output.
>>> +
>>> +       `only`;;
>>> +               Hide non-merge commits from the output (i.e showing
>>> +               only merge commits).
>>> +
>>> +       `show`;;
>>> +               Do not hide either merge or non-merge commits. This
>>> +               is primarily useful when the user has non-standard
>>> +               setting of `log.merges` configuration variable that
>>> +               needs to be overriden from the command line.
>>
>> s/overriden/overridden/
>
> Should I send a new reroll or wait for reviews on my other commits.
> I have not received any review on other patches of this series yet.

Lack of review comments does not necessarily mean that people did not
review the patches; it could mean that reviewers had nothing more to
say. In addition to pointing out the typo above, I also made a small
comment[1] on patch 4/5, but otherwise did not find anything else
about which to comment.

Whether or not you should re-send is something Junio can answer. He
will sometimes silently pick up a series as-is or sometimes silently
make minor fixes based upon review comments. Check his 'pu' branch
periodically to see if your series appears there and if it has those
minor adjustments. If not, and if he doesn't answer this question,
then you may need to re-roll.

[1]: http://article.gmane.org/gmane.comp.version-control.git/267118
