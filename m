From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 1/2] push: Fully test --recurse-submodules on command line
 overrides config
Date: Wed, 16 Dec 2015 14:46:23 -0800
Message-ID: <CAGZ79kZpCPp6CrfknQRDObKvuNnCe2+bZwCAF8XKrkkVNS+e3w@mail.gmail.com>
References: <20151203131006.GA5119@mcrowe.com>
	<1449148235-29569-1-git-send-email-mac@mcrowe.com>
	<CAGZ79kb3XCkabxUq6Sh-aLa=a6kzRZtR6WG+wTk1SQY9_Mehog@mail.gmail.com>
	<xmqqio3yc8yd.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Mike Crowe <mac@mcrowe.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 16 23:46:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a9KqA-00058Y-3V
	for gcvg-git-2@plane.gmane.org; Wed, 16 Dec 2015 23:46:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755074AbbLPWq3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Dec 2015 17:46:29 -0500
Received: from mail-ig0-f179.google.com ([209.85.213.179]:36460 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755197AbbLPWqY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Dec 2015 17:46:24 -0500
Received: by mail-ig0-f179.google.com with SMTP id ph11so165269827igc.1
        for <git@vger.kernel.org>; Wed, 16 Dec 2015 14:46:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=lWuBM41++5bov5nGDf/CgJeOgODz+akqQMZ93QMGH7w=;
        b=m4Oaj6B/qt1gW4WNkMnY2StGmZAqErcRpdahbxyY+r13hSz9ZHmfl+noL+TTORQj27
         /r5trrFpO2oLLktyL1FrnJ2/ZcAB45NQ7W75Z2ZzZhoTsN+f1n+Osu/6e/hQieyPm/Pk
         572KkI63nOkm50ui0a3NviabCOSBpcmYo5lZ9YPp/yQFJwOgocX86wIlxbjEhUyXtJst
         bSGkEK9KvB6ggsEA5WdSxKeDNTwur3AAV8K+y+s7Yx+irrHFJuNWpWLu97pA5AoM24hS
         XZL4QRHHP+5T9NFHNYZ1SX+sTTjoCyaLptAOaszoTVWgCAgPfA2siDSMnvf0wExLjmXl
         2SSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=lWuBM41++5bov5nGDf/CgJeOgODz+akqQMZ93QMGH7w=;
        b=Ue9HAcjZyW6OJWvgSVqaVyQ1sTWgGHia1s+Ze3ok5teo3+9lZZQllifbxDZpJDnra0
         1jTRnFLEbSLzu4+gBq2yLdhbxIuGaFh89Z+ABERq69C+Jryw4XFp0gcB66iG09KCVYaq
         UgzO1RAJ9EJMXodCcax0+DnNNGphROGZBQpLiKSEVINWWSFztQ3nPQZa8lUS0kekD9Ha
         Aq06WypxK24ywYbxPk8fQx0z16BcIQpnKqRUaeZ+uE2x358nDGRBGJHdjJNPpbsQ1W4U
         i9JlJpakGk3TulNh5D9f6b5LBrycaRwwH9jV6BjWutJiFuaUEkR9UxTacSmVXhx/2YHe
         WOJA==
X-Gm-Message-State: ALoCoQmeCE9THi7OWXU8lwJ/QWxxtTuobGk/OxJ/LynlP0n8tp7tcUP8YsL4N0BJZo0tQ6x7pXpEDCPwnnrsYkJvrUJsIS5krbLHThZ22MCjaLIl9jOdL24=
X-Received: by 10.107.168.203 with SMTP id e72mr3847234ioj.96.1450305983404;
 Wed, 16 Dec 2015 14:46:23 -0800 (PST)
Received: by 10.107.8.74 with HTTP; Wed, 16 Dec 2015 14:46:23 -0800 (PST)
In-Reply-To: <xmqqio3yc8yd.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282618>

On Wed, Dec 16, 2015 at 2:41 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> On Thu, Dec 3, 2015 at 5:10 AM, Mike Crowe <mac@mcrowe.com> wrote:
>>> t5531 only checked that the push.recurseSubmodules config option was
>>> overridden by passing --recurse-submodules=check on the command line.
>>> Add new tests for overriding with --recurse-submodules=no,
>>> --no-recurse-submodules and --recurse-submodules=push too.
>>>
>>> Also correct minor typo in test commit message.
>>>
>>> Signed-off-by: Mike Crowe <mac@mcrowe.com>
>>
>> This looks good to me.
>>
>> Thanks,
>> Stefan
>
> Thanks.  Does "This" refer to 1/2 alone or the whole series?

Yes. :)

"This" is applicable to both patches. We had the discussion on 2/2 about me
misreading a line a few days earlier, but apart from that it looked good, too.
