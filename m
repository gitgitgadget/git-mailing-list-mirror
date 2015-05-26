From: Guillaume Pages <guillaume.pages@ensimag.grenoble-inp.fr>
Subject: Implementation of git rebase --status
Date: Tue, 26 May 2015 16:38:01 +0200 (CEST)
Message-ID: <2024498388.1201300.1432651081110.JavaMail.zimbra@ensimag.grenoble-inp.fr>
References: <1086316854.1201217.1432650834727.JavaMail.zimbra@ensimag.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Matthieu Moy <matthieu.moy@grenoble-inp.fr>,
	Remi LESPINET <remi.lespinet@ensimag.grenoble-inp.fr>,
	Remi GALAN ALFONSO <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	Louis-Alexandre STUBER 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	Antoine DELAITE <antoine.delaite@ensimag.grenoble-inp.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 26 16:45:07 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YxG6L-00069d-8z
	for gcvg-git-2@plane.gmane.org; Tue, 26 May 2015 16:45:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752853AbbEZOo7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 26 May 2015 10:44:59 -0400
Received: from zm-etu-ensimag-2.grenet.fr ([130.190.244.118]:37169 "EHLO
	zm-etu-ensimag-2.grenet.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752254AbbEZOo4 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 May 2015 10:44:56 -0400
X-Greylist: delayed 568 seconds by postgrey-1.27 at vger.kernel.org; Tue, 26 May 2015 10:44:56 EDT
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id 0B74E24C8;
	Tue, 26 May 2015 16:35:25 +0200 (CEST)
Received: from zm-smtpout-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id B-Y0dzPZMX0c; Tue, 26 May 2015 16:35:24 +0200 (CEST)
Received: from zm-int-mbx4.grenet.fr (zm-int-mbx4.grenet.fr [130.190.242.143])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id EE88B2497;
	Tue, 26 May 2015 16:35:24 +0200 (CEST)
In-Reply-To: <1086316854.1201217.1432650834727.JavaMail.zimbra@ensimag.grenoble-inp.fr>
X-Originating-IP: [130.190.242.137]
X-Mailer: Zimbra 8.0.9_GA_6191 (ZimbraWebClient - FF37 (Linux)/8.0.9_GA_6191)
Thread-Topic: Implementation of git rebase --status
Thread-Index: rpT7u4K4JhixNiMY/hfyx5DedmBuUg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269943>

Hi,=20

I would like to implement a new command git rebase --status to inform t=
he user=20
about the current rebase session. Here is a sample of what I think it c=
ould=20
look like in case of merge conflict:=20

git rebase --status=20
You are in the middle of a rebase session.=20
The line that paused this session is:=20
pick 848a16f commit with conflicts=20
CONFLICT (content): Merge conflict in file1=20
Consult and edit remaining actions with git rebase --edit-todo=20

In case of syntax error:=20

git rebase --status=20
You are in the middle of a rebase session.=20
The line that paused this session is:=20
tick 848a16f syntax error=20
SYNTAX ERROR=20
Consult and edit remaining actions with git rebase --edit-todo=20

In case of error during the execution of a script:=20

git rebase --status=20
You are in the middle of a rebase session.=20
The line that paused this session is:=20
exec exit 3=20
ERROR IN SCRIPT EXECUTION=20
Consult and edit remaining actions with git rebase --edit-todo=20

Do you think it could be usefull or do you have any suggestion?=20

Thanks,=20

Guillaume Pag=C3=A8s=20
