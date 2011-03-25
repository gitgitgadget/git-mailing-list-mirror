From: Markus Heller <hellerm2@gmail.com>
Subject: Re: shell script calling git fails when called from scheduler
Date: Fri, 25 Mar 2011 16:03:33 -0700
Message-ID: <0v1v1upzui.fsf@gmail.com>
References: <0v62r6q2lm.fsf@gmail.com> <20110325221914.GA11156@genestate.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 26 00:03:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q3G2s-0000G0-9C
	for gcvg-git-2@lo.gmane.org; Sat, 26 Mar 2011 00:03:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755410Ab1CYXDt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Mar 2011 19:03:49 -0400
Received: from lo.gmane.org ([80.91.229.12]:56200 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753327Ab1CYXDs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Mar 2011 19:03:48 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Q3G2k-00009T-5o
	for git@vger.kernel.org; Sat, 26 Mar 2011 00:03:46 +0100
Received: from mail.cdrd.ca ([142.103.191.98])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 26 Mar 2011 00:03:46 +0100
Received: from hellerm2 by mail.cdrd.ca with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 26 Mar 2011 00:03:46 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: mail.cdrd.ca
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (windows-nt)
Cancel-Lock: sha1:ZQhEHt0m6Pa7mfWBrtxY4xhROdM=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170030>

Matt Harrison <iwasinnamuknow@genestate.com> writes:

> On Fri, Mar 25, 2011 at 03:04:05PM -0700, Markus Heller wrote:
>> Hi all,
>> 
>> I have the following batch shell script (org-git-synch.bat):
>> 
>> @ECHO OFF
>> 
>> REM get date and time
>> for /f "delims=" %%a in ('date/t') do @set mydate=%%a
>> for /f "delims=" %%a in ('time/t') do @set mytime=%%a
>> set fvar=%mydate%%mytime%
>> 
>> REM add all new files
>> call git add .
>> call git commit -a -m "Automated commit by org-git-sync.bat on %fvar%"
>> 
>> The script resides in h:/org/; and I have a working git repository in
>> this directory (in h:/org/.git).
>> 
>> I can run the script from the command line no problem, but when I try to
>> run it from the Windoze scheduler, all I get is a cmd window saying:
>> 
>> fatal: not a git repository (or any of the parent directories): .git
>> fatal: not a git repository (or any of the parent directories): .git
>> 
>> I did re-initialize the repository, but that didn't matter, since git
>> status and everything else works fine from the command line.  I'm on Win
>> 7 Pro 64 bit SP 1.
>> 
>> Any ideas?
>> 
>> Thanks and Cheers
>> Markus
>
> At a guess (I dont use the windows scheduler), the working directory of the batch file
> is not being set to h:/org
>
> I dont know if there is a way to tell the windows scheduler what the working directory
> should be, so maybe try cd'ing to h:/org at the start of your script?

Thanks Matt,

this was the problem.  U can specify the directory where the script
should be run in the scheduler.

Cheers
Markus
