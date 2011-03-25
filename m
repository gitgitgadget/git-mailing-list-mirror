From: Markus Heller <hellerm2@gmail.com>
Subject: shell script calling git fails when called from scheduler
Date: Fri, 25 Mar 2011 15:04:05 -0700
Message-ID: <0v62r6q2lm.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 25 23:04:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q3F7D-0004Dp-JF
	for gcvg-git-2@lo.gmane.org; Fri, 25 Mar 2011 23:04:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755305Ab1CYWEP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Mar 2011 18:04:15 -0400
Received: from lo.gmane.org ([80.91.229.12]:51001 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755148Ab1CYWEO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Mar 2011 18:04:14 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Q3F77-0004B0-Kg
	for git@vger.kernel.org; Fri, 25 Mar 2011 23:04:13 +0100
Received: from mail.cdrd.ca ([142.103.191.98])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 25 Mar 2011 23:04:13 +0100
Received: from hellerm2 by mail.cdrd.ca with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 25 Mar 2011 23:04:13 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: mail.cdrd.ca
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (windows-nt)
Cancel-Lock: sha1:APx12aaPLOx6b2FpMu4eZgpG1O8=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170027>

Hi all,

I have the following batch shell script (org-git-synch.bat):

@ECHO OFF

REM get date and time
for /f "delims=" %%a in ('date/t') do @set mydate=%%a
for /f "delims=" %%a in ('time/t') do @set mytime=%%a
set fvar=%mydate%%mytime%

REM add all new files
call git add .
call git commit -a -m "Automated commit by org-git-sync.bat on %fvar%"

The script resides in h:/org/; and I have a working git repository in
this directory (in h:/org/.git).

I can run the script from the command line no problem, but when I try to
run it from the Windoze scheduler, all I get is a cmd window saying:

fatal: not a git repository (or any of the parent directories): .git
fatal: not a git repository (or any of the parent directories): .git

I did re-initialize the repository, but that didn't matter, since git
status and everything else works fine from the command line.  I'm on Win
7 Pro 64 bit SP 1.

Any ideas?

Thanks and Cheers
Markus
