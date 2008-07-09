From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Merging a foreign tree into a bare repository.
Date: Wed, 09 Jul 2008 10:27:15 -0700 (PDT)
Message-ID: <m3lk0bdkyl.fsf@localhost.localdomain>
References: <1215562468.4199.26.camel@moss-terrapins.epoch.ncsc.mil>
	<alpine.DEB.1.00.0807090238561.5277@eeepc-johanness>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Dave Quigley <dpquigl@tycho.nsa.gov>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jul 09 19:28:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KGdSp-0008NY-8K
	for gcvg-git-2@gmane.org; Wed, 09 Jul 2008 19:28:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751959AbYGIR1Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jul 2008 13:27:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751953AbYGIR1Y
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Jul 2008 13:27:24 -0400
Received: from yw-out-2324.google.com ([74.125.46.31]:14483 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751889AbYGIR1Y (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jul 2008 13:27:24 -0400
Received: by yw-out-2324.google.com with SMTP id 9so1395323ywe.1
        for <git@vger.kernel.org>; Wed, 09 Jul 2008 10:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=l9Yr1Wl3KAZzap91SXys1Wqkxe4pUHAj8dVIVKv+6qM=;
        b=oB5h5KZ8P2jQsUvlT6Crl8ifrmTkI1F+fuE/8AcCP3RyaSj2gF99p8vFsmqoAbHPEX
         PXqTc7sbCoR6P5SZ/v6xLmQeyA4vhhu/ORON1WgYsvWm2XrBb0iDqv2duCm8CqQ5F3cQ
         Mf5maJ6Hh9Qzjga4+9lIdCvMwsVqyIDTz1k3Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=wHoZLQn15Numvj1KIgXpMpMGgKW/B3T8X6ZTOwNDLg5Q9JnmgXM4/SF2/bRa4j6+VK
         e+Leh/6adQ8OGuX1ClE/q+ZF26djMbd3NrLrbaB4GxLA2MRxuB21wJqxAJDU2WGfIW2H
         gIPQqiEiDQW6Qe5cncwbGK0yk0LVgf3IXkBnA=
Received: by 10.103.244.10 with SMTP id w10mr4106917mur.67.1215624436375;
        Wed, 09 Jul 2008 10:27:16 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.249.234])
        by mx.google.com with ESMTPS id g1sm29643356muf.7.2008.07.09.10.27.13
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 09 Jul 2008 10:27:15 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m69HUXVb001163;
	Wed, 9 Jul 2008 19:30:50 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m69HUAUm001156;
	Wed, 9 Jul 2008 19:30:10 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <alpine.DEB.1.00.0807090238561.5277@eeepc-johanness>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87896>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Tue, 8 Jul 2008, Dave Quigley wrote:
> 
> > I tried to then merge them but you need a working directory to merge the 
> > changes which makes sense.
> 
> Of course it does.  Merging runs the risk of conflicts, and you need a 
> working directory for that.
> 
> > How would one go about doing this with a bare repository?
> 
> Very easy: clone it ("non-barely"), merge, and push back the results.
> 
> You _need_ a working directory for the merge.

Or, alternatively, you can tell git where you want to have working
directory with '--work-tree' parameter to git wrapper, for example

  1451:jnareb@roke:/tmp/jnareb> git clone --bare test/ test-clone.git
  Initialize test-clone.git
  Initialized empty Git repository in /tmp/jnareb/test-clone.git/

(Hmmm... I hope the last message, which is unnecessary and I think
is just spillage from git-init, would vanish in builting git-clone)

  1453:jnareb@roke:/tmp/jnareb/test-clone.git> ls
  branches  config  description  HEAD  hooks  info  objects  refs
  1454:jnareb@roke:/tmp/jnareb/test-clone.git> cat config 
  [core]
        repositoryformatversion = 0
        filemode = true
        bare = true

(It is bare repository)
  
  1461:jnareb@roke:/tmp/jnareb/test-clone.git> git checkout
  fatal: This operation must be run in a work tree

(You would get the same error with merge and with rebase)

  1458:jnareb@roke:/tmp/jnareb/test-clone.git> git --work-tree=../test-workdir/ checkout
  1459:jnareb@roke:/tmp/jnareb/test-clone.git> ls ../test-workdir/
  foo

It works!

You can also set core.worktree configuration variable... although
I don't know what git would do if core.bare is true and core.worktree
is set.

HTH
-- 
Jakub Narebski
Poland
ShadeHawk on #git
