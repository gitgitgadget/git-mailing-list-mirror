From: Thomas Rast <tr@thomasrast.ch>
Subject: t7610 is no longer valgrind-clean in pu
Date: Fri, 11 Feb 2011 11:46:07 +0100
Message-ID: <201102111146.07303.tr@thomasrast.ch>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 11 11:54:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pnqdh-0001n1-94
	for gcvg-git-2@lo.gmane.org; Fri, 11 Feb 2011 11:54:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755211Ab1BKKyH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Feb 2011 05:54:07 -0500
Received: from psi.thgersdorf.net ([188.40.92.130]:52038 "EHLO mail.psioc.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750848Ab1BKKyG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Feb 2011 05:54:06 -0500
X-Greylist: delayed 474 seconds by postgrey-1.27 at vger.kernel.org; Fri, 11 Feb 2011 05:54:05 EST
Received: from localhost (localhost [127.0.0.1])
	by localhost.psioc.net (Postfix) with ESMTP id DF2E453608;
	Fri, 11 Feb 2011 12:39:02 +0100 (CET)
X-Virus-Scanned: amavisd-new at psioc.net
Received: from mail.psioc.net ([127.0.0.1])
	by localhost (mail.psioc.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 4ylFmb25LAAg; Fri, 11 Feb 2011 12:38:59 +0100 (CET)
Received: from pctrast.inf.ethz.ch (pctrast.inf.ethz.ch [129.132.153.233])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by mail.psioc.net (Postfix) with ESMTPSA id 0A8CC53600;
	Fri, 11 Feb 2011 12:38:59 +0100 (CET)
User-Agent: KMail/1.13.5 (Linux/2.6.37-9-desktop; KDE/4.5.4; x86_64; ; )
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166551>

Hello Martin

My valgrind tester cronjob tells me the output below (some cruft
trimmed).  If you need any more data just ask :-)

- Thomas

> expecting success: 
>     git config rerere.enabled true &&
>     rm -rf .git/rr-cache &&
>     git checkout -b test5 branch1
>     test_must_fail git merge master >/dev/null 2>&1 &&
>     ( yes "d" "d" | git mergetool --no-prompt >/dev/null 2>&1 ) &&
>     output="$(yes "n" | git mergetool --no-prompt)" &&
>     test "$output" = "No files need merging" &&
>     git reset --hard
> 
> Switched to a new branch 'test5'
> ==25695== Invalid free() / delete / delete[]
> ==25695==    at 0x4C20A31: free (vg_replace_malloc.c:325)
> ==25695==    by 0x4F2538: string_list_clear (string-list.c:115)
> ==25695==    by 0x466CE8: cmd_rerere (rerere.c:182)
> ==25695==    by 0x404771: run_builtin (git.c:290)
> ==25695==    by 0x4048FC: handle_internal_command (git.c:448)
> ==25695==    by 0x4049E7: run_argv (git.c:492)
> ==25695==    by 0x404B43: main (git.c:565)
> ==25695==  Address 0x772388 is 0 bytes inside data symbol "RERERE_UTIL_STAGED"
> ==25695== 
> ==25702== Invalid free() / delete / delete[]
> ==25702==    at 0x4C20A31: free (vg_replace_malloc.c:325)
> ==25702==    by 0x4F2538: string_list_clear (string-list.c:115)
> ==25702==    by 0x466CE8: cmd_rerere (rerere.c:182)
> ==25702==    by 0x404771: run_builtin (git.c:290)
> ==25702==    by 0x4048FC: handle_internal_command (git.c:448)
> ==25702==    by 0x4049E7: run_argv (git.c:492)
> ==25702==    by 0x404B43: main (git.c:565)
> ==25702==  Address 0x772388 is 0 bytes inside data symbol "RERERE_UTIL_STAGED"
> ==25702== 
> ==26111== Invalid free() / delete / delete[]
> ==26111==    at 0x4C20A31: free (vg_replace_malloc.c:325)
> ==26111==    by 0x4F2538: string_list_clear (string-list.c:115)
> ==26111==    by 0x466CE8: cmd_rerere (rerere.c:182)
> ==26111==    by 0x404771: run_builtin (git.c:290)
> ==26111==    by 0x4048FC: handle_internal_command (git.c:448)
> ==26111==    by 0x4049E7: run_argv (git.c:492)
> ==26111==    by 0x404B43: main (git.c:565)
> ==26111==  Address 0x772388 is 0 bytes inside data symbol "RERERE_UTIL_STAGED"
> ==26111== 
> ==26118== Invalid free() / delete / delete[]
> ==26118==    at 0x4C20A31: free (vg_replace_malloc.c:325)
> ==26118==    by 0x4F2538: string_list_clear (string-list.c:115)
> ==26118==    by 0x466CE8: cmd_rerere (rerere.c:182)
> ==26118==    by 0x404771: run_builtin (git.c:290)
> ==26118==    by 0x4048FC: handle_internal_command (git.c:448)
> ==26118==    by 0x4049E7: run_argv (git.c:492)
> ==26118==    by 0x404B43: main (git.c:565)
> ==26118==  Address 0x772388 is 0 bytes inside data symbol "RERERE_UTIL_STAGED"
> ==26118== 
> ./test-lib.sh: line 1033: echo: write error: Broken pipe
> not ok - 8 mergetool skips resolved paths when rerere is active
> #	
> #	    git config rerere.enabled true &&
> #	    rm -rf .git/rr-cache &&
> #	    git checkout -b test5 branch1
> #	    test_must_fail git merge master >/dev/null 2>&1 &&
> #	    ( yes "d" "d" | git mergetool --no-prompt >/dev/null 2>&1 ) &&
> #	    output="$(yes "n" | git mergetool --no-prompt)" &&
> #	    test "$output" = "No files need merging" &&
> #	    git reset --hard
> #	
> 6a53d958f3fa0ee2671517dca10837f42e1c57c1 is first bad commit
> commit 6a53d958f3fa0ee2671517dca10837f42e1c57c1
> Author: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
> Date:   Mon Feb 7 22:08:38 2011 -0500
> 
>     mergetool: don't skip modify/remove conflicts

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
