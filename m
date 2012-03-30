From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Maintaining historical data in a git repo
Date: Fri, 30 Mar 2012 09:32:51 -0700 (PDT)
Message-ID: <m3boneaw27.fsf@localhost.localdomain>
References: <CA+P+rLeyEcZPudhLWavB74CiDAqpn+iNkk4F8=NK_yGaJPMmyA@mail.gmail.com>
	<201203301510.q2UFAqn6003864@no.baka.org>
	<CA+P+rLcWT0SZQjW2LtFXXCDRwjMp8daJ2hVup=7cnsRGbKw7xw@mail.gmail.com>
	<201203301618.q2UGIF3Q005388@no.baka.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Yuval Adam <yuv.adm@gmail.com>, git@vger.kernel.org
To: Seth Robertson <in-gitvger@baka.org>
X-From: git-owner@vger.kernel.org Fri Mar 30 18:32:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SDekz-0004eL-J2
	for gcvg-git-2@plane.gmane.org; Fri, 30 Mar 2012 18:32:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756637Ab2C3Qcy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Mar 2012 12:32:54 -0400
Received: from mail-wi0-f172.google.com ([209.85.212.172]:51315 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754991Ab2C3Qcw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Mar 2012 12:32:52 -0400
Received: by wibhj6 with SMTP id hj6so775216wib.1
        for <git@vger.kernel.org>; Fri, 30 Mar 2012 09:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=kzeKUi7jHoeu5yGmCjwPwXyexVAvwEOUQuVQDUn0Ss8=;
        b=mZy4o6jREBRA1wQtN/ULE1s5eViDbZXUanvGh+v1l/UXuiAHQ4DbWVpIJCdCsvdbtA
         XP5vmWnFEQAXh6TuT8dGulRdzjb4uyRKOpb7WzpkuIVRftUb+IDap4p/6kJOqGPnmywl
         NRnrYKh2EjpwXes+Y4CIQU+F7hlKpZ39xbts+WbyeaqDJPy8pdTfeflP4+Fqv1ZqfuTy
         PMmgue1a3jM+S+EWI/JutPYRpivLM+NoBLiLW79PKOK2+QzCqT6nagS1U8hd1ATRoHqt
         cxbS9Bqy6GwUCstRm4urjmAlKPbRhXLJzACnvbnNpc6u/JOICBADPqGt/iH9neWRy/CB
         11qQ==
Received: by 10.180.81.37 with SMTP id w5mr7962746wix.16.1333125171454;
        Fri, 30 Mar 2012 09:32:51 -0700 (PDT)
Received: from localhost.localdomain (addb154.neoplus.adsl.tpnet.pl. [79.184.53.154])
        by mx.google.com with ESMTPS id o2sm12047991wiv.11.2012.03.30.09.32.50
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 30 Mar 2012 09:32:51 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id q2UGWojn023129;
	Fri, 30 Mar 2012 18:32:50 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id q2UGWmId023126;
	Fri, 30 Mar 2012 18:32:48 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <201203301618.q2UGIF3Q005388@no.baka.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194378>

Seth Robertson <in-gitvger@baka.org> writes:

> In message <CA+P+rLcWT0SZQjW2LtFXXCDRwjMp8daJ2hVup=7cnsRGbKw7xw@mail.gmail.com>, Yuval Adam writes:
> 
>     On Fri, Mar 30, 2012 at 6:10 PM, Seth Robertson <in-gitvger@baka.org> wrote:
>     > Revision control shouldn't be used to change the past (even if git
>     > allows this with sufficient amounts of pain/warning to all users).
>     > What it is extremely good at is preserving the past and tracking the
>     > changes that are made.
> 
>     This is exactly what we _do_ want to do.
> 
>     Is this something that is definitively complicated with git?
> 
> Ah, I understand now.  I imagine others will chime in as well, but
> this should not be too complex with git.  You can easily go back into
> history and change it.  The problem comes in when you have shared your
> repository with other people.
> 
> In general, rewriting public history is a bad idea because git cannot
> tell the difference between someone adding to history for good reasons
> (expanding on known history) and bad reasons (retroactively rewriting
> the law to add a loophole).
> 
> You can absolutely do it, 

For example using `git filter-branch`, or grafts mechanism plus said
git-filter-branch, or interactive rebase for changes closer to current
version, or `git commit --amend` for latest version (latest commit).

>                           but then you have to "force push" your
> changes to the master server to override the history (assuming that is
> allowed, and it typically is not by default) and then everyone else
> would have to do special things (`git pull --rebase` in the simple
> case, rebuilding branches and tags in more complex cases) to get the
> new history.  Clearly for something like the law and the probable
> complex workflow it will have, this isn't a good method.

Well, if nobody is basing their work on this repository, and it is
meant as read-only source of information, that doesn't matter much.

> 
> What I would probably suggest is having either a historical branch or
> a historical repository which is allowed and expected to be rewritten.
[...]

Yet another solution would be to fix mistakes using `git replace`
mechanism.  It doesn't as much rewrite history, as paste on fixes;
this of course requires setting up sharing of those replacements
(fixes).

See git-replace(1) manpage for more information.

-- 
Jakub Narebski
