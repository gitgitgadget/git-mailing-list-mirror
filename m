From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Basic Git usage
Date: Sat, 14 Aug 2010 05:39:16 -0700 (PDT)
Message-ID: <m3hbix2wss.fsf@localhost.localdomain>
References: <1281760358285-5422412.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: hogsolo <greg@localdirt.com>
X-From: git-owner@vger.kernel.org Sat Aug 14 14:39:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OkG1F-00042Z-3t
	for gcvg-git-2@lo.gmane.org; Sat, 14 Aug 2010 14:39:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756172Ab0HNMjT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Aug 2010 08:39:19 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:40437 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756105Ab0HNMjS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Aug 2010 08:39:18 -0400
Received: by fxm13 with SMTP id 13so2254894fxm.19
        for <git@vger.kernel.org>; Sat, 14 Aug 2010 05:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=UNLBvjE9VTh2k00d/cH7A7YuujmS5rsVgCxc0TmsbGw=;
        b=hKO7FLMEsIZm4YXF4Hq/0NQLh2J6uhMr20yshvNqwSAHr4Uy9dOClKQaHKTmSsZABk
         IotqUeOm10IKpEa3514B7Es6MZFPo5CNUMd4scmsRdET/nFdNLnAyby/ZHJRHEQm/ogx
         oZ4+MmVD1WqIMoOI1RvKZqOrkTI+vfb/S0Two=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=TKeE9CfPhVV0LLVfgPZR3fZyu5zlnvWGBlAm6Np7m9XPhq4BXmiBY0NihySZzR0eNJ
         3rM6J15y3+U1peyQzhJaxKZNJoHhTOHmqZjJGl92yGp78hhCpOribfANy/BjeQKsNDEi
         vGi2SbPG0ohzmNYn03mn5CFbkNwNT7W0fp6uI=
Received: by 10.223.113.13 with SMTP id y13mr3190567fap.37.1281789556775;
        Sat, 14 Aug 2010 05:39:16 -0700 (PDT)
Received: from localhost.localdomain (abvh53.neoplus.adsl.tpnet.pl [83.8.205.53])
        by mx.google.com with ESMTPS id b36sm1556852faq.11.2010.08.14.05.39.15
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 14 Aug 2010 05:39:16 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o7ECdV4W001709;
	Sat, 14 Aug 2010 14:39:42 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o7ECdGpD001699;
	Sat, 14 Aug 2010 14:39:16 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1281760358285-5422412.post@n2.nabble.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153557>

hogsolo <greg@localdirt.com> writes:

> Hi, Im new to Git, formerly an SVN user.
>
> I have a master repo and have created a branch. I want to work in both at
> the same time. I want to change some files in the master, then switch to the
> branch ( git checkout branchname) , work on some files, then switch back to
> the master. 
>
> However git wont let me switch back to the master until I have added,
> committed and pushed my files in the branch. 
>
> Is this correct behavior for git? It would seem that I not be REQUIRED to
> check in anything I was working on before switching between branch and
> master, but that's the behavior I'm seeing via error messages.

Git wouldn't allow you to switch a branch ('git checkout <branch>') if
you have uncomitted changes that would conflict with the branch you
switch to.  For example if you have uncomitted changes to file 'foo',
and this file is different on the branch you switch to, then git rightly
refuses to switch branches.

You can tell git to try to merge changes with

  git checkout -m <branch>

or you can force git to discard your local changes with

  git checkout -f <branch>

or you can stash away your changes before switching branch.


In no case _pushing_ changes is a requirement.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
