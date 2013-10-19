From: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: separate-git-dir doesn't work with mapped drive
Date: Sat, 19 Oct 2013 17:47:30 +0200
Message-ID: <5262A992.8000905@web.de>
References: <CADgy815BJAJrbW0JJ2a9vZ4NwzGersceg6b96TPAey_pR+mOiw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Ain Valtin <ain.valtin@gmail.com>, git@vger.kernel.org,
	msysGit <msysgit@googlegroups.com>
X-From: git-owner@vger.kernel.org Sat Oct 19 17:47:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VXYkp-0000yj-1f
	for gcvg-git-2@plane.gmane.org; Sat, 19 Oct 2013 17:47:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752009Ab3JSPrd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Oct 2013 11:47:33 -0400
Received: from mout.web.de ([212.227.17.12]:57948 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751258Ab3JSPrd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Oct 2013 11:47:33 -0400
Received: from [192.168.209.26] ([78.72.74.102]) by smtp.web.de (mrweb101)
 with ESMTPA (Nemesis) id 0MMn1H-1Vezvw1bIt-008aYE for <git@vger.kernel.org>;
 Sat, 19 Oct 2013 17:47:31 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:24.0) Gecko/20100101 Thunderbird/24.0.1
In-Reply-To: <CADgy815BJAJrbW0JJ2a9vZ4NwzGersceg6b96TPAey_pR+mOiw@mail.gmail.com>
X-Provags-ID: V03:K0:tVW/0G7idM+goUdAqmrgM2YFcvKFHazhhcvTITA3ub7pKHxcucz
 CgL55Y0o78Gy8JldqMmIYYbB5W3kR67DjucpZHNXAAbTVpc0/rmSgRpv+qBzaTZStTELeeC
 6MzqOuxOfm4JBX19wXVgD/Uo9oJ+NXmt0ZjWF2P9wAiAZXHKGlKdWyCEvfiMaz3ZwJjfe63
 1vvvT16sK/C4Ej4ZH8Zjw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236403>

On 2013-10-19 10.49, Ain Valtin wrote:
> Hi
> 
> I want to use git in a VirtualBox guest so that the repository is on
> the host drive. So in the VB settings for the guest I set up a shared
> folder "gitRepos" to /home/ain with full access rights. Then in the
> guest OS (Windows XP) I map this shared folder as G drive. Now in the
> project dir I execute
> 
> C:\...\TPP>git init --separate-git-dir g:/TPP
> Initialized empty Git repository in g:/TPP/
> 
> Checked, the repo structure is in the "g:/TPP/" (thus the guest OS can
> write to the mapped dir) and in the .git file created to the project
> dir there is line
> 
> gitdir: g:/TPP
> 
> However when tring to use the repo it fails to recognise the g:/TPP path, ie
> 
> C:\...\TPP>git add .
> fatal: unable to access '../../../../../../g:/TPP/config': Invalid argument
> 
> Also tryed "gitdir: //VBOXSVR/gitRepos/TPP" but this fails too:
> 
> C:\...\TPP>git add .
> fatal: Unable to create 'C:/Documents and
> Settings/Ain/prog/AVT/TPP/../../../../../..///VBOXSVR/gitRepos/TPP/index.lock':
> No such file or directory
> 
> Am I doing something wrong or is it a bug? Any idea how to get it to work?
> 
> BTW the VB is 3.0.14 ie rather old version but it seems that this
> isn't the problem as the git init recognises the mapped drive but
> other commands fail.
> git version is 1.8.4.msysgit.0
> 
> 
> TIA
> ain

(This could go to msysgit mailing list, so I add a CC)
(and I think, it is a known issue)

As a work around, could you try this:
> Downgrading to msysgit 1.8.3 fixes my problem.
and tell us if this helps you?

/Torsten
