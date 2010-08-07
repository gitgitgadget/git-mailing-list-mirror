From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] rebase -i: add exec command to launch a shell command
Date: Sat, 07 Aug 2010 10:48:36 +0200
Message-ID: <vpqeiealsez.fsf@bauges.imag.fr>
References: <vpqwrs9nxi5.fsf@bauges.imag.fr>
	<1280743433-27803-1-git-send-email-Matthieu.Moy@imag.fr>
	<201008062307.54841.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com,
	=?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
	Marc Branchaud <marcnarc@xiplink.com>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Sat Aug 07 14:12:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OhiGn-0004JG-2k
	for gcvg-git-2@lo.gmane.org; Sat, 07 Aug 2010 14:12:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753820Ab0HGItL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Aug 2010 04:49:11 -0400
Received: from mx2.imag.fr ([129.88.30.17]:49933 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753606Ab0HGItI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Aug 2010 04:49:08 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id o778kLiL016367
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sat, 7 Aug 2010 10:46:21 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1Ohf53-0005NO-1s; Sat, 07 Aug 2010 10:48:37 +0200
In-Reply-To: <201008062307.54841.j6t@kdbg.org> (Johannes Sixt's message of "Fri\, 6 Aug 2010 23\:07\:54 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Sat, 07 Aug 2010 10:46:21 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o778kLiL016367
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1281775582.86171@J3bOYYgpptVKQTBWMWWHsw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152847>

Johannes Sixt <j6t@kdbg.org> writes:

> On Montag, 2. August 2010, Matthieu Moy wrote:
>> The typical usage pattern would be to run a test (or simply a compilation
>> command) at given points in history.
>
> What happens if the command modifies the worktree and/or the index?

Something terrible :-(. The next patch application fails, and the
patch is more or less silently dropped (I thought it would fail giving
the user an opportunity to fix and re-apply, but it doesn't).

New version checks working tree cleanness right after the command
finishes, and stops cleanly, in time (restart with "git rebase
--continue"). This comes with a new test.

(But the command can possibly create a new commit or amend the
previous one without problem)

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
