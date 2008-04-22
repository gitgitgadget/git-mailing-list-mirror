From: "Ping Yin" <pkufranky@gmail.com>
Subject: Re: [regression?] "git status -a" reports modified for empty submodule directory
Date: Tue, 22 Apr 2008 20:39:56 +0800
Message-ID: <46dff0320804220539y51c02dedoe181a0eed8599902@mail.gmail.com>
References: <46dff0320804220401h26d2f2ebg1748a4a310acc0f5@mail.gmail.com>
	 <480DD6D8.9040900@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Johannes Sixt" <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Apr 22 14:41:19 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JoHno-0005mN-FM
	for gcvg-git-2@gmane.org; Tue, 22 Apr 2008 14:40:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752998AbYDVMkC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Apr 2008 08:40:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753030AbYDVMkC
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Apr 2008 08:40:02 -0400
Received: from wx-out-0506.google.com ([66.249.82.230]:22462 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752989AbYDVMkA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Apr 2008 08:40:00 -0400
Received: by wx-out-0506.google.com with SMTP id h31so1773446wxd.4
        for <git@vger.kernel.org>; Tue, 22 Apr 2008 05:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=5vn/3bdMG2olA69pk1oIwBadQipHiBFJZ6IPmOGjpbU=;
        b=GYjGLZmTzcIjxb39KTB7S3LyPz4A1e+MbzlPWAFLJSyl5HjMPIuLPSJgDxIQPf6vDXBVF2PvF6GuPbruO2ppPRYLlYoCzd9xLszRM0QFQb1NPeT+v4kjZeSyX8mJkA5XoPt+iVUQeR/VmpLNd4RIJuyYzfQW+a2N+PXTfaoPBDA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=XBJE2oy+HmBhRk8lm7e5/jzSsT2K6mZeoR6wlUucrdiFZbCrtjYRB5SyU0eLPu5XVxR/G+d4k89gEpXVCSxP1Au+hpj9UL+Od0tCtsjdEPARJMPfPeoFvrsLrE80+pfbaEJztlEqeGfWA5gkA6xUatUTye7SpX7qSrYREJ4a6Nk=
Received: by 10.100.41.16 with SMTP id o16mr234272ano.132.1208867996346;
        Tue, 22 Apr 2008 05:39:56 -0700 (PDT)
Received: by 10.100.32.10 with HTTP; Tue, 22 Apr 2008 05:39:56 -0700 (PDT)
In-Reply-To: <480DD6D8.9040900@viscovery.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80107>

On Tue, Apr 22, 2008 at 8:15 PM, Johannes Sixt <j.sixt@viscovery.net> wrote:
> Ping Yin schrieb:
>
> > # create a super project super
>  > $ mkdir super && cd super && git init
>  > $ touch foo && git add foo && git commit -m "add foo"
>  >
>  > # create a sub project sub
>  > $ mkdir sub && cd sub && git init
>  > $ touch bar && git add bar && git commit -m "add bar"
>  >
>  > # add sub project to super project
>  > $ cd ..
>  > $ git add sub && git commit -m 'add sub'
>  >
>  > # remote contents of subproject
>  > $ rm -rf sub/* sub/.git
>  >
>  > # git status -a regression
>  > $ git status
>  > # On branch master
>  > nothing to commit (working directory clean)
>
>  This should have reported:
>
>  # On branch master
>  # Changed but not updated:
>  #   (use "git add/rm <file>..." to update what will be committed)
>  #
>  #       deleted:    sub
>  no changes added to commit (use "git add" and/or "git commit -a")
>
>  Right?
>
>
>  > $ git status -a
>  > # On branch master
>  > # Changes to be committed:
>  > #   (use "git reset HEAD <file>..." to unstage)
>  > #
>  > #       deleted:    sub
>  > #
>
>  There's nothing wrong with this.
>
>  -- Hannes

It seems that in 1.5.4, both 'git status' and 'git status -a' report
"no changes added to commit". And i think this is the right behaviour.
Because when a super project is cloned, all submodule directories are
empty in the beginning. In this case 'git status' and 'git status -a'
should report " no changes added to commit".



-- 
Ping Yin
