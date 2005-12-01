From: Majkls <majkls@tiscali.cz>
Subject: Segmentation fault in git-shell & symlink instead of script post-update
 in git repository
Date: Thu, 01 Dec 2005 20:17:09 +0100
Message-ID: <438F4C35.6000605@tiscali.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu Dec 01 20:08:11 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ehthz-0001FM-0x
	for gcvg-git@gmane.org; Thu, 01 Dec 2005 20:03:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751704AbVLATDE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Dec 2005 14:03:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751699AbVLATDE
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Dec 2005 14:03:04 -0500
Received: from mail.pamico-czech.cz ([212.158.146.130]:13730 "EHLO
	mail.pamico-czech.cz") by vger.kernel.org with ESMTP
	id S1751704AbVLATDD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Dec 2005 14:03:03 -0500
Received: from [192.168.1.20] (client-1021-03103.pamico.cz [212.158.146.147])
	by mail.pamico-czech.cz (Postfix) with ESMTP id 0AA86BF406B
	for <git@vger.kernel.org>; Thu,  1 Dec 2005 20:02:57 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: cs, en-us, en
To: git@vger.kernel.org
X-Enigmail-Version: 0.92.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13067>

Hello,
when I tried to install git, I found some bug in git-shell (shell.c). If
you don't give two parameters in argv[2], program ends by segfault.
There is a problem solution.

*** shell.c     2005-11-26 01:35:20.000000000 +0100
--- shell.c.new 2005-12-01 19:42:29.000000000 +0100
*************** int main(int argc, char **argv)
*** 42,48 ****
                char *arg;
                if (strncmp(cmd->name, prog, len))
                        continue;
!               arg = NULL;
                switch (prog[len]) {
                case '\0':
                        arg = NULL;
--- 42,48 ----
                char *arg;
                if (strncmp(cmd->name, prog, len))
                        continue;
!               arg = "";
                switch (prog[len]) {
                case '\0':
                        arg = NULL;

I have /home/scm mounted as noexec. I had a problem with post-update. I
remove it and replaced with symlink to current program. So that works.

-- 
Miloslav "Majkls" Semler
