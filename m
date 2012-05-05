From: Neal Kreitzinger <nkreitzinger@gmail.com>
Subject: Re: recipe to use git for deployment
Date: Fri, 04 May 2012 23:43:16 -0500
Message-ID: <4FA4AFE4.6040701@gmail.com>
References: <jo283q$kna$1@dough.gmane.org> <1336190286-sup-3813@nixos>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
To: Marc Weber <marco-oweber@gmx.de>
X-From: git-owner@vger.kernel.org Sat May 05 06:43:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SQWq4-00078a-G9
	for gcvg-git-2@plane.gmane.org; Sat, 05 May 2012 06:43:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751178Ab2EEEnU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 May 2012 00:43:20 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:43674 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751171Ab2EEEnT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 May 2012 00:43:19 -0400
Received: by obbtb18 with SMTP id tb18so4932404obb.19
        for <git@vger.kernel.org>; Fri, 04 May 2012 21:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=SDClqJ417sMKWrfV4a6U2CJXe0b2EjcK+xwE2B5wBUA=;
        b=hu0u5gh/QO79RfVgySqpzUpYKQMH0olwfXV0TPEHXnQEzIvlFyfhwf2vIDTC0Sp5P8
         z1B3h0whue4u2DzrkNMnFM0OX88AtyQRyig4HSYBXFgiH9KzfOAFO+HKb8hkgJVG6VCR
         /M/NY2BGKUyY0dsS6oorif168aUTPaVMl3wO6oLT+hJ+kRZYFZKgnWUPeSs/DhzCvFYy
         WAjqLlAhfq3vSU9MlJhGgr4WJ5yiN95pMIlKRtoJnA9dosj/EdHhpWVfCYlREPGso9VJ
         2CenTTZurhCplcE+6BEal2hZ5ybxm8ZZ0lFXs/P4MdOWxZEj2hm1Sj+Ju8irmkK8W4Jm
         ptqQ==
Received: by 10.182.38.1 with SMTP id c1mr4144306obk.18.1336192999128;
        Fri, 04 May 2012 21:43:19 -0700 (PDT)
Received: from [172.25.2.210] ([67.63.162.200])
        by mx.google.com with ESMTPS id d9sm11264041obz.6.2012.05.04.21.43.17
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 04 May 2012 21:43:18 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
In-Reply-To: <1336190286-sup-3813@nixos>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197093>

On 5/4/2012 11:10 PM, Marc Weber wrote:
> I always did "git pull" on the servers - but the history of my projects
> is not that huge.. Thus I never cared.
> Great: You can keep some server specific config settings and rebase
> them -
So I could rebase apache virtual host conf files with generic template 
changes like symlink support, but keep the networking ip's.  Merge 
conflicts would be bad.  I guess that would be cause to reset --hard to 
a previous commit.

and you can do a fast git status to check whether file contents
> have been modified (eg determine whether you've been hacked ..)
>
With 'source is run' like html, css, etc. that would be a good way to 
enforce no-hacking-allowed support agreements.

> If you really care that much about history why not push a zip file using
> git archive --format=zip and unpack that on the deployment server
> instead?
>
That is what I'm currently doing.  By paying attention to tracked 
executable bits I don't even have to fix permissions on deployment.

The scriptable patching of a git repo (scripted checkout of remote 
tracking branch commits to worktree with inserted conversions and 
validations -- an interactive cherry-pick so to speak) allows for 
flexible conversions of varying patch levels.  Maybe git-sequencer will 
do this when it comes out.

Also, I could have a deployment tracking repo on one of my servers that 
remotes to all deployed servers and pulls to refresh my monitor view of 
all deployed revisions in gitk.

> For FTP access only this did a great job for small projects:
> https://github.com/MarcWeber/git-ftp (->  git-ftp-minimal.sh)
> It only copies changed files *and* checks whether they have been
> modified on the server first (detecting work of others).
> But that's probably not a good thing for automatic deployment.
>
I'll take a look to see what I can steal, uh I mean reuse.  Thanks!

v/r,
neal
