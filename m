From: Paul Tan <pyokagan@gmail.com>
Subject: Re: [PATCH v3 3/4] docs/git-credential-store: document XDG file and precedence
Date: Thu, 12 Mar 2015 17:50:50 +0800
Message-ID: <CACRoPnTM95Sbrcz+s6w9wY5toLQa1WVFDQvi_ZPdaNCXM9PDGw@mail.gmail.com>
References: <1426056553-9364-1-git-send-email-pyokagan@gmail.com>
	<1426056553-9364-4-git-send-email-pyokagan@gmail.com>
	<CAPig+cTvX-yZpwC8BvN2CmgkBrOKUaotvJHdwXwfU8YnqLi4nQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Thu Mar 12 10:51:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YVzlc-0002CQ-1k
	for gcvg-git-2@plane.gmane.org; Thu, 12 Mar 2015 10:51:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753334AbbCLJux (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Mar 2015 05:50:53 -0400
Received: from mail-lb0-f178.google.com ([209.85.217.178]:33732 "EHLO
	mail-lb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752034AbbCLJuw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Mar 2015 05:50:52 -0400
Received: by lbdu14 with SMTP id u14so14723363lbd.0
        for <git@vger.kernel.org>; Thu, 12 Mar 2015 02:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=nnSTP0yiEiyAkwFbzMwQd6CJp4EaxaC8CDDLuM6zdBk=;
        b=R2zAVICuf7lc4tnsqGMoJtRecdAxrHncETeqvSqPza3Cyl4EI4+ulGU7oAMCKDX+45
         L5H7ccLMm69UuRckSuqyLv0YNerNf1ADzoI4jf8+wEE3gYGwZR+aEVd8/bHB0zvRd7XY
         zrPtQ78MGPeUF9S/VOCyhDtWev/GrYqOE+/RKDnCk/r3yNdo+Q9hf3zQ2/EWAGIUxkDY
         JmKbrl6XNIZDCAj0TBjgX7bsv3iTeCi1DeRfboxgZrqCU4K3l7s3q1VDoyKlJ6wbA9MY
         gMSoEoJvpMMaqTungEdRohD3G5d/wLAqzIo4OA+mnRb3tqnDgZHO/Tj3AqTCCLJb4PqT
         w3jA==
X-Received: by 10.152.206.70 with SMTP id lm6mr38994003lac.35.1426153851002;
 Thu, 12 Mar 2015 02:50:51 -0700 (PDT)
Received: by 10.112.130.228 with HTTP; Thu, 12 Mar 2015 02:50:50 -0700 (PDT)
In-Reply-To: <CAPig+cTvX-yZpwC8BvN2CmgkBrOKUaotvJHdwXwfU8YnqLi4nQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265357>

On Wed, Mar 11, 2015 at 3:47 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Wed, Mar 11, 2015 at 2:49 AM, Paul Tan <pyokagan@gmail.com> wrote:
>> +
>> +If not set explicitly with '--file', there are two files where
>> +git-credential-store will search for credentials in order of precedence:
>> +
>> +~/.git-credentials::
>> +       User-specific credentials file.
>> +
>> +$XDG_CONFIG_HOME/git/credentials::
>> +       Second user-specific credentials file. If '$XDG_CONFIG_HOME' is not set
>> +       or empty, `$HOME/.config/git/credentials` will be used. Any credentials
>> +       stored in this file will not be used if `~/.git-credentials` has a
>> +       matching credential as well. It is a good idea not to create this file
>> +       if you sometimes use older versions of Git, as support for this file
>> +       was added fairly recently.
>
> The final sentence won't age well: "fairly recently" is too nebulous.
> It may be sufficient merely to advise the reader to avoid this file if
> she also uses an older version of Git which doesn't support XDG for
> credentials.

I copied this part from the documentation of git-config. I couldn't
find the exact patch in the archives where "fairly recently" was
introduced, but I did find this patch[1] where apparently a version
number was supposed to be used instead.

[1] http://thread.gmane.org/gmane.comp.version-control.git/198837/focus=200552

So yes, at this point in time I think the sentence should be changed
to something like "It is a good idea not to create this file if you
use older versions of git that do not support this file.", although it
would be even more useful for users if the version where this feature
was introduced is stated as well. This patch series has not even hit
pu though ;)

> Other than this minor point, the patch series seems well prepared and
> quite nicely done. Thanks.

Thank you so much for the positive review. Will re-roll the documentation.

Regards,
Paul
