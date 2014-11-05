From: Chris Packham <judge.packham@gmail.com>
Subject: Re: Odd git am behavior rewriting subject, adding "ASoC: " prefix
Date: Wed, 5 Nov 2014 22:12:03 +1300
Message-ID: <CAFOYHZAimkSMWC42S_C=OkNuz+cjT3vhsGo6AwuCtt8M2REkig@mail.gmail.com>
References: <1415149921.6634.1.camel@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Joe Perches <joe@perches.com>
X-From: git-owner@vger.kernel.org Wed Nov 05 10:12:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XlwdO-0007KJ-2V
	for gcvg-git-2@plane.gmane.org; Wed, 05 Nov 2014 10:12:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753764AbaKEJMF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Nov 2014 04:12:05 -0500
Received: from mail-pa0-f41.google.com ([209.85.220.41]:32904 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751294AbaKEJMD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Nov 2014 04:12:03 -0500
Received: by mail-pa0-f41.google.com with SMTP id rd3so420305pab.0
        for <git@vger.kernel.org>; Wed, 05 Nov 2014 01:12:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=nMgB7aD8bIxZbJfSRD+fUPbdy/G0cQylYcyRt8UwLck=;
        b=zwpe6ZbQ9F/GXonS7+wOvWtG+qyQteRenh2eGxSfqrsqBdBsJrOZXtaSuLtWNmVShM
         0leLM4AS2JACmV2NerqEhtnxSAu57VJsywWCzpSee+OtISF5p0OSI4tQpj4Czws2tjGV
         Abnm0cd2HVG967tm8oohQdyA5JFPFsJjffFgcrbyrcH1KsuOMykv15JYccgT+le7kCgu
         uto8Iua6CiGhVW2J/Ss/AVwx7SV0792Eyh8AAsqgdBrQ/zbPeoqyNjO4YutSEKQv6SQR
         Jm/kuk/NKGsxYnipR8Y3bQ2TGr7K+iS3ihugNtHdAT478HBaJ36hDwvT18IdiSuotKeq
         sW2A==
X-Received: by 10.70.96.104 with SMTP id dr8mr4193061pdb.58.1415178723422;
 Wed, 05 Nov 2014 01:12:03 -0800 (PST)
Received: by 10.70.35.105 with HTTP; Wed, 5 Nov 2014 01:12:03 -0800 (PST)
In-Reply-To: <1415149921.6634.1.camel@perches.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 5, 2014 at 2:12 PM, Joe Perches <joe@perches.com> wrote:
> I have a patch file created by git format-patch.
>
> Applying it via git am changes the subject prefix.
> Anyone know why?
>
> $ git --version
> git version 2.1.2
>
> $ git am -i 0002-staging-ft1000-Logging-message-neatening.patch
> Commit Body is:
> --------------------------
> staging: ft1000: Logging message neatening
>
> Use a more common logging style.
>
> o Convert DEBUG macros to pr_debug
> o Add pr_fmt
> o Remove embedded function names from pr_debug
> o Convert printks to pr_<level>
> o Coalesce formats and align arguments
> o Add missing terminating newlines
>
> Signed-off-by: Joe Perches <joe@perches.com>
> --------------------------
> Apply? [y]es/[n]o/[e]dit/[v]iew patch/[a]ccept all
>
> choosing "Y" emits:
>
> Applying: ASoC: staging: ft1000: Logging message neatening
>
> ASoC:? where does that come from?
>
>

Looks like you have an apply-patch-msg hook installed. What does the
output of 'ls -l .git/hooks' look like.
