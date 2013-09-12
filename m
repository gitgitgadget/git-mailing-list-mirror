From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCH] Windows: Do not redefine _WIN32_WINNT
Date: Thu, 12 Sep 2013 10:41:29 +0200
Message-ID: <CAHGBnuPXPrpfdQYuwHz-AhLWcY3fx7KoWQ9L+RRz9hPnoQL4Dg@mail.gmail.com>
References: <52309507.1090908@gmail.com>
	<xmqq4n9rtdol.fsf@gitster.dls.corp.google.com>
	<CAHGBnuPdixkH42SNW0enF8C-GFwH8gX8NOXb69VscV3qvA6bxg@mail.gmail.com>
	<xmqq61u7rpr3.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Karsten Blees <karsten.blees@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 12 10:41:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VK2T3-00054d-73
	for gcvg-git-2@plane.gmane.org; Thu, 12 Sep 2013 10:41:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754582Ab3ILIld (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Sep 2013 04:41:33 -0400
Received: from mail-la0-f54.google.com ([209.85.215.54]:53416 "EHLO
	mail-la0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752382Ab3ILIlb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Sep 2013 04:41:31 -0400
Received: by mail-la0-f54.google.com with SMTP id ea20so8424690lab.13
        for <git@vger.kernel.org>; Thu, 12 Sep 2013 01:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=XLeYLT59xge0aRbCtHrtH1aU0mJaozfYrSv/8cTfupA=;
        b=v2ivf6LizYHccS56xvzmq8PeuWFjV3yHuY+Y+oD/V/H7SvQi+q+3W9cxsuKDIfZz+R
         jQnuu8nyvAO3qLHXnQnUJOlaphJolcboEshBQLuWgNt9Bn9iMnX5zKbw05Qyj8sc35TZ
         HYODe2zH1ndBTlQlfQG/WIHR1UT0OoY1wRcy7uyXJREoE1g3eG0tRzJAYOvlmlgRvZiX
         GV0JdkHew3T+np6fGuotBy1jeVG1QtchiEmPHHRwPC34dVWKLtyhs8cR4Jvf7KvoCN4A
         GRgBqxiXiD1MLKKO3ZybDriELmxHGkYeexfvSCeRZr/m16NxN0XQrLb0xrcnAiuKI7vo
         91JA==
X-Received: by 10.152.170.166 with SMTP id an6mr5231163lac.20.1378975289606;
 Thu, 12 Sep 2013 01:41:29 -0700 (PDT)
Received: by 10.114.5.161 with HTTP; Thu, 12 Sep 2013 01:41:29 -0700 (PDT)
In-Reply-To: <xmqq61u7rpr3.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234629>

On Wed, Sep 11, 2013 at 11:51 PM, Junio C Hamano <gitster@pobox.com> wrote:

> It seems that compat/poll/poll.c also defines _WIN32_WINNT (but only
> with _MSC_VER defined).  The change to git-compat-util.h in this
> patch avoids redefinition for both MinGW and MSVC case.  Do you also
> need to have this, too?

In my patch I did not change poll.c because I did only check this
issue with MinGW, not MSVC, so I never ran into the _MSC_VER code
path. Back in 1.8.3 git-compat-util.h did define _WIN32_WINNT for both
MinGW and MSVC, which is why in my patch I had to add the #ifndef /
#endif. But I believe it's good to have these guards for both MinGW
and MSVC, actually.

> Here is what I tentatively queued on top of the three from Karsten,
> and your "Fix stat definitions".

Looks good to me, thanks!

-- 
Sebastian Schuberth
