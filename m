From: =?windows-1252?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: git push hung?
Date: Sun, 07 Dec 2014 18:57:33 +0100
Message-ID: <5484950D.7080107@web.de>
References: <F818AFA80A5F46BBA007F6EB102A75C5@black>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: Jason Pyeron <jpyeron@pdinc.us>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 07 18:57:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xxg5e-00052H-P1
	for gcvg-git-2@plane.gmane.org; Sun, 07 Dec 2014 18:57:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752227AbaLGR5r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Dec 2014 12:57:47 -0500
Received: from mout.web.de ([212.227.17.12]:59634 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752051AbaLGR5q (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Dec 2014 12:57:46 -0500
Received: from macce.local ([78.72.72.190]) by smtp.web.de (mrweb101) with
 ESMTPSA (Nemesis) id 0MJTdf-1Y0iDl1IiZ-0038nU; Sun, 07 Dec 2014 18:57:35
 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
In-Reply-To: <F818AFA80A5F46BBA007F6EB102A75C5@black>
X-Provags-ID: V03:K0:Mu6YOWIoUEAp+3RlH+EzI5xK1ILPKui7e90Qqor3aZe2FWfkjeQ
 Ia2aDqZYKIe4ZRoJl1M5WXLCg933rgJnWbUCurJuwdBIg7uAIisqLs2NejBduEFjGMA/L/E
 f4ADFqqfwbfloZf5a/wvQlVf+Yggy6GuE4aitTefm5VgrML3SU7E+xVWwVkP7a4CdZK67qZ
 lU9kBzmY7eU6QO7qswYyA==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260994>

On 2014-12-07 15.24, Jason Pyeron wrote:
> I am trying to push to our local intranet git (smart https behind apache), and it has been at this point for 10+ hours.
> 
> jpyeron@black /projects/git/git
> $ GIT_TRACE=1 git push
> 09:08:45.662902 git.c:349               trace: built-in: git 'push'
> 09:08:45.662902 run-command.c:341       trace: run_command: 'git-remote-https' 'origin' 'https://intranet.pdinc.us/git/git/'
> 09:08:46.225700 run-command.c:341       trace: run_command: 'git credential-cache --timeout=99999999999 get'
> 09:08:46.256967 run-command.c:192       trace: exec: '/bin/sh' '-c' 'git credential-cache --timeout=99999999999 get' 'git credential-cache --timeout=99999999999 get'
> 09:08:46.366400 git.c:554               trace: exec: 'git-credential-cache' '--timeout=99999999999' 'get'
> 09:08:46.366400 run-command.c:341       trace: run_command: 'git-credential-cache' '--timeout=99999999999' 'get'
> 09:08:47.022999 run-command.c:341       trace: run_command: 'git credential-cache --timeout=99999999999 store'
> 09:08:47.038632 run-command.c:192       trace: exec: '/bin/sh' '-c' 'git credential-cache --timeout=99999999999 store' 'git credential-cache --timeout=99999999999 store'
> 09:08:47.116799 git.c:554               trace: exec: 'git-credential-cache' '--timeout=99999999999' 'store'
> 09:08:47.116799 run-command.c:341       trace: run_command: 'git-credential-cache' '--timeout=99999999999' 'store'
> 09:08:47.366931 run-command.c:341       trace: run_command: 'send-pack' '--stateless-rpc' '--helper-status' '--thin' '--progress' 'https://intranet.pdinc.us/git/git/' 'refs/heads/master:refs/heads/master'
> 09:08:47.382565 exec_cmd.c:134          trace: exec: 'git' 'send-pack' '--stateless-rpc' '--helper-status' '--thin' '--progress' 'https://intranet.pdinc.us/git/git/' 'refs/heads/master:refs/heads/master'
> 09:08:47.429465 git.c:349               trace: built-in: git 'send-pack' '--stateless-rpc' '--helper-status' '--thin' '--progress' 'https://intranet.pdinc.us/git/git/' 'refs/heads/master:refs/heads/master'
> 09:08:47.538898 run-command.c:341       trace: run_command: 'pack-objects' '--all-progress-implied' '--revs' '--stdout' '--thin' '--delta-base-offset' '--progress'
> 09:08:47.695231 exec_cmd.c:134          trace: exec: 'git' 'pack-objects' '--all-progress-implied' '--revs' '--stdout' '--thin' '--delta-base-offset' '--progress'
> 09:08:47.742131 git.c:349               trace: built-in: git 'pack-objects' '--all-progress-implied' '--revs' '--stdout' '--thin' '--delta-base-offset' '--progress'
> Counting objects: 18734, done.
> Delta compression using up to 2 threads.
> Compressing objects: 100% (5707/5707), done.
> Writing objects: 100% (18734/18734), 9.37 MiB | 0 bytes/s, done.
> Total 18734 (delta 14519), reused 17108 (delta 12968)
> 
> Servier died, this is in the log:
> 
> fatal: protocol error: expected old/new/ref, got 'shallow 3339e9f686bd4c17e3575c71327c4ccf1e8e077b'
> 
> What steps can I take to debug this hang in the client?
> 
> Git fetch hangs the same way with a server exit of fatal: did not find object for shallow 3339e9f686bd4c17e3575c71327c4ccf1e8e077b
> 
> Note: I fixed the underlying problem with a git fetch --unshallow upstream
>
Was the log above after the git fetch --unshallow upstream ?
What is the output if you run the following commands on the server:
git show 3339e9f686bd4c17e
git fsck
git --version
which git

(And what on the client)
