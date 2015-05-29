From: Guillaume Pages <guillaume.pages@ensimag.grenoble-inp.fr>
Subject: Re: [RFC/PATCH v2] create a skeleton for the command git rebase
 --status
Date: Fri, 29 May 2015 12:40:23 +0200 (CEST)
Message-ID: <12496325.145058.1432896023146.JavaMail.zimbra@ensimag.grenoble-inp.fr>
References: <1432822837-10320-1-git-send-email-guillaume.pages@ensimag.grenoble-inp.fr> <CACRoPnRa1wrOJr=wGnR4NayZfe2yJ4F7Abv_sjqRpgQnicxm1g@mail.gmail.com> <1141577560.115469.1432827789020.JavaMail.zimbra@ensimag.grenoble-inp.fr> <vpqiobcy9yt.fsf@anie.imag.fr> <xmqqtwuwh8fv.fsf@gitster.dls.corp.google.com> <vpqlhg8pk1o.fsf@anie.imag.fr> <xmqq382gh465.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Paul Tan <pyokagan@gmail.com>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>,
	Remi Galan <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
	Louis-Alexandre Stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 29 12:40:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YyHiA-0004Lt-J7
	for gcvg-git-2@plane.gmane.org; Fri, 29 May 2015 12:40:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755932AbbE2KkQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 May 2015 06:40:16 -0400
Received: from zm-etu-ensimag-2.grenet.fr ([130.190.244.118]:53982 "EHLO
	zm-etu-ensimag-2.grenet.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755680AbbE2KkM (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 May 2015 06:40:12 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id CADD42788;
	Fri, 29 May 2015 12:40:09 +0200 (CEST)
Received: from zm-smtpout-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id My2k8vOB08c2; Fri, 29 May 2015 12:40:09 +0200 (CEST)
Received: from zm-int-mbx4.grenet.fr (zm-int-mbx4.grenet.fr [130.190.242.143])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id B7BFA261E;
	Fri, 29 May 2015 12:40:09 +0200 (CEST)
In-Reply-To: <xmqq382gh465.fsf@gitster.dls.corp.google.com>
X-Originating-IP: [130.190.242.137]
X-Mailer: Zimbra 8.0.9_GA_6191 (ZimbraWebClient - FF37 (Linux)/8.0.9_GA_6191)
Thread-Topic: create a skeleton for the command git rebase --status
Thread-Index: gKx86CBR2h4FrmytZRZNlU3a+M7MJA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270222>

After this discussion I eventually agree that it would be better
upgrading git status than creating a new command.When people use git
status, it means that they need information to continue their work, so
if you don't even know that you are in a rebase, you will very likely
need information about the current rebase.

During a classic rebase we could have output like:

rebase in progress; onto d9d448a You are currently rebasing branch
'branche1' on 'd9d448a'.  (fix conflicts and then run "git rebase
--continue") (use "git rebase --skip" to skip this patch) (use "git
rebase --abort" to check out the original branch) (5 commits applied,
3 remainings) Failed to apply:

252c273 commit message

Unmerged paths: (use "git reset HEAD <file>..." to unstage) (use "git
add <file>..." to mark resolution)

both modified: file1


And during an interactive rebase:

rebase in progress; onto 247c883 You are currently editing a commit
while rebasing branch 'b1.1' on '247c883'.  (use "git commit --amend"
to amend the current commit) (use "git rebase --continue" once you are
satisfied with your changes)

Last commands done (5 commands done) :

pick 62609785 commit message1 reword 85ae9001 new commit message2

(See more at .git/rebase-merge/done)

Next commands to do (3 remainings commands) :

squash 62609785 commit message3 pick 85ae9001 commit message4

(See more at .git/rebase-merge/git-rebase-todo)

Changes not staged for commit: (use "git add <file>..." to update what
will be committed) (use "git checkout -- <file>..." to discard changes
in working directory)

modified: file1 ...

Is it a good practice to send the user find information in the .git
directory?

Thanks

Guillaume
