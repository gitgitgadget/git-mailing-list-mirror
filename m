From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [GSoC microproject] Add XDG support to the credential-store helper
Date: Thu, 5 Mar 2015 23:38:19 +0100
Message-ID: <CAP8UFD3kHKsUWqmfr3mEtTYwVFwGGqMF_wJgVQyoaH=2i9Ge=A@mail.gmail.com>
References: <20150305215146.394caa71@gentp.lnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Luis Ressel <aranea@aixah.de>
X-From: git-owner@vger.kernel.org Thu Mar 05 23:38:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YTePQ-00053h-PD
	for gcvg-git-2@plane.gmane.org; Thu, 05 Mar 2015 23:38:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753236AbbCEWiV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Mar 2015 17:38:21 -0500
Received: from mail-ie0-f175.google.com ([209.85.223.175]:45159 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751047AbbCEWiU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Mar 2015 17:38:20 -0500
Received: by iery20 with SMTP id y20so27527177ier.12
        for <git@vger.kernel.org>; Thu, 05 Mar 2015 14:38:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=93eA31jiTRkljaqqreGWI10o7Us+l9lyDiPRsy7Ykss=;
        b=xG7sVP2mgpITBM9Fx2SYXCOBk4w2GHH5BRGvUsDDRrqEmwYBXi8bkygb3I56enizB5
         tQqRH5JOHplAX81eP09ngQ1V9Ll2LFPHjNl3zTG0nTO4tdquhioNZliG9hgOCOu18525
         5IKnJ7K09HImZ+eFE4o38AjGREktxRMG2CWzu02IJN+5qsLENrF5O3ENrjevm6tUL9Rz
         zdbuiioYSb05IjvGgpSmpAa916unT5WECo0LKF8NOjDuOhFWKHwF2oRrEiFDFOLnCH6w
         m03rICEkr8h6GMK5zYW1SsvVBZ1+LqwfjGNjLpIqapraJYsKUXTIv4rMHwmIpQ0mIpST
         f5tw==
X-Received: by 10.50.176.196 with SMTP id ck4mr50930368igc.40.1425595099556;
 Thu, 05 Mar 2015 14:38:19 -0800 (PST)
Received: by 10.50.245.144 with HTTP; Thu, 5 Mar 2015 14:38:19 -0800 (PST)
In-Reply-To: <20150305215146.394caa71@gentp.lnet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264875>

Hi,

On Thu, Mar 5, 2015 at 9:51 PM, Luis Ressel <aranea@aixah.de> wrote:
> I'm contributing this patch in preparation for a GSoC15 application with
> the git project. In particular, I'm interested in the two bisect
> improvements listed on the Ideas page. Does anyone have other
> suggestions for potential improvements of git bisect that would be
> suitable for such a GSoC project?

Last year, on the ideas page:

http://git.github.io/SoC-2014-Ideas.html

we also had the following improvement:

"in some cases, git bisect may test too many merge bases, thus slowing
down the bisection (making it closer to linear than logarithmic)."

so you could work on that too.

And if you really want and have time you can also rewrite
git-bisect.sh into a builtin command. There is already
builtin/bisect--helper.c where you can put some migrated code step by
step.

> Oh, and should I add a testcase for the new functionality introduced by
> this patch? And if yes, what exactly should I test?

First, it looks like another student started working on the same
microproject. Did you have a look at what he did? If you didn't, you
probably should, so that reviewers don't need to tell you what they
already told the other student. And if you did, you should tell it,
and maybe explain what you did differently and why.

If it looks like the other student is more advanced on this subject,
you might want to try another microproject. And if all the
microprojects are already taken, you might want to ask the list for
other microprojects, or you may want to have a look at the many merge
bases improvement above. (You could start by having a look at
check_merge_bases() in "bisect.c" and by creating a script or better a
test case that reproduces the problem, see
t/t6030-bisect-porcelain.sh.)

Welcome to the Git community!

Best,
Christian.
