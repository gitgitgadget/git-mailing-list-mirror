From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git clone operation
Date: Sun, 17 Aug 2008 12:23:57 -0700 (PDT)
Message-ID: <m3wsifsawl.fsf@localhost.localdomain>
References: <20080817184443.GA11782@mg1.gantsfort.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Mike Gant <mwgant@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 17 21:25:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KUns9-0006WD-TE
	for gcvg-git-2@gmane.org; Sun, 17 Aug 2008 21:25:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750886AbYHQTYA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Aug 2008 15:24:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750806AbYHQTYA
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Aug 2008 15:24:00 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:13233 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750793AbYHQTYA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Aug 2008 15:24:00 -0400
Received: by nf-out-0910.google.com with SMTP id d3so1043252nfc.21
        for <git@vger.kernel.org>; Sun, 17 Aug 2008 12:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=BlL88jaME+CtI6aFBmbdCB/VKRM3KZsvMuK0PSi/FAg=;
        b=gkIHQs87+fcUcMmLBjm/QXapjLN1MVTfeqXf4mYVDY93sOku41vOwd1zwcvUsgC1XB
         lylKLjkaF3ZuGEdn4f7toz3TRe0JV/EIwSsyYwUzq5URdntH/bkRQTVJ5Kvh05E4YjKT
         XvK3fHzNpFNbB146t8t4CiMSqLZcadVsWh1FA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=RL9fD2HWRVFj8ihnHIxcEKOfLSc6H9vsPVWiBL5pF190pBjw5b0ho5SDhJudAI9lw8
         bk/iEn12lQRZ4Msw9+DE2rxwhf/Qwj/CGMzIByUroaCwxm+cte/45TUCCF7S8GLjd/D2
         BMm9n26drJelINEbE1x+YU/5ow6CR1/CsaYvQ=
Received: by 10.210.73.12 with SMTP id v12mr6837859eba.101.1219001038599;
        Sun, 17 Aug 2008 12:23:58 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.215.124])
        by mx.google.com with ESMTPS id g12sm4102496nfb.28.2008.08.17.12.23.56
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 17 Aug 2008 12:23:57 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m7HJNt5V021185;
	Sun, 17 Aug 2008 21:23:56 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m7HJNsGC021182;
	Sun, 17 Aug 2008 21:23:54 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <20080817184443.GA11782@mg1.gantsfort.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92620>

Mike Gant <mwgant@gmail.com> writes:

> I'm trying to understand git-clone and what to expect when I clone a
> repository. Disclaimer, I am a newbie :).
[...]

> According to the man page, git-clone "creates and checks out an initial
> branch equal to the cloned repository's currently active branch."
[...]

> Now, let's say that I am working in the cpu-intfc branch of the original
> repository and I clone the repository.
> 
> Running git-branch -a returns the following
> 
>   origin/HEAD
>   origin/cpu-intfc
>   origin/gige_mux
>   origin/improve-build
>   origin/main-devel
>   origin/master
> * cpu-intfc
> 
> And this,
> 
> $ cat .git/refs/remotes/origin/HEAD
> ref: refs/remotes/origin/cpu-intfc
> 
> I was expecting to have a local branch named master (that is equal to
> the remote branch origin/cpu-intfc) instead of cpu-intfc. Am I wrong to
> expect this? Also, as a newbie user, it seems odd that I cannot specify
> which branch of repo that I am cloning should be the default (master)
> branch of the cloned repo? To put it another way, when cloning a repo I
> have no way of controlling which branch I get as the default. It just
> happens to depend on which branch the developer is working in at the
> time I clone.  I've read through the man-page and there doesn't seem to
> be any way around this.

Currently the situation is a bit strange, because while git-remote
supports selecting which branch is meant to be remote-tracking master
branch via '-m <master>' option to "add" subcommand (setting
origin/HEAD symref), git-clone which is init + remote + fetch + some
bookkeeping and shortcuts doesn't.

Both commands are now built-in.

> I realize that I can create a new local branch that is based off the
> desired branch:
> 
> $ git-checkout -b master origin/master
> 
> Is this the accepted method for obtaining the desired branch?

You can use (with new anough Git)

  $ git checkout --track -b master origin/master

to setup repository in such way that "git pull" on 'master'
would know that it is meant to fetch from 'origin' and merge
'origin/master'.

In upcoming 1.6.1 it would be enough to use

  $ git checkout --track origin/master

-- 
Jakub Narebski
Poland
ShadeHawk on #git
