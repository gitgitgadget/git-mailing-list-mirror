From: "Ludvig Strigeus" <strigeus@gmail.com>
Subject: Re: Git rebase -i failing on cygwin -- git checkout-index says File Exists
Date: Tue, 20 Jan 2009 23:20:15 +0100
Message-ID: <4285cd450901201420l8929dci25688dc9723c917a@mail.gmail.com>
References: <4285cd450901201209i792195dfmdec1fb14d627b25e@mail.gmail.com>
	 <alpine.DEB.1.00.0901202212470.3586@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jan 20 23:21:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPOyb-0006TE-Ic
	for gcvg-git-2@gmane.org; Tue, 20 Jan 2009 23:21:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756072AbZATWUU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Jan 2009 17:20:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755516AbZATWUS
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Jan 2009 17:20:18 -0500
Received: from yw-out-2324.google.com ([74.125.46.30]:33982 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754480AbZATWUR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Jan 2009 17:20:17 -0500
Received: by yw-out-2324.google.com with SMTP id 9so1604239ywe.1
        for <git@vger.kernel.org>; Tue, 20 Jan 2009 14:20:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=+e/YFXyJc6FPeYCZfdcW+aAcTgw8bxaUwNT5VGK12yc=;
        b=RteNazz8mtAZjIEzRSF4BDxtevI0yipZPEtk/brvVFUT/VjytWSOLaRoM0sID69reF
         Ryq1Hu8RMuiyKw9VaJLwjuF18lPrBYq3PJvgV9WGpZaiqLrnOQC8/SZOFVMX/fGC9m5X
         uCIhiLI7v7GSmAgdLkdMW0R0oMCq8YnYMWr28=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=DTuN/1uBqPIm31TrLhnN7m7VSgWjUfVC13u/N8V1YLscr4opTP+9l8NYER6WUEdV8d
         qC7HylkYiATmaV+9z5I/yJITuYwqeh6Ao2uFBClEVAqqbYKMuwwjBYEEW0921YPe0oHu
         DzP7VnBxsvPFPMg193mO/2pqmymGALWupxdMM=
Received: by 10.143.39.16 with SMTP id r16mr45319wfj.172.1232490015339;
        Tue, 20 Jan 2009 14:20:15 -0800 (PST)
Received: by 10.143.109.1 with HTTP; Tue, 20 Jan 2009 14:20:15 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.0901202212470.3586@pacific.mpi-cbg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106532>

Hi!

On Tue, Jan 20, 2009 at 10:16 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> Having said that, I often had that case with interactive rebase, because
> I had an untracked file lying around (in your case util/stringfuncs.cpp)
> that was tracked in the version I was trying to rebase onto, but it
> stopped right there, even on msysGit.

util/stringfuncs.cpp is not an untracked file, though. It's a part of
my repo. Also 'git status' shows that no files are modified. If it was
an untracked file, 'git status' would have said so.

>
> Hopefully you can investigate the scenario more, by "git rebase --abort",
> and then running the rebase -i again, but with GIT_TRACE=1.
>

Here is the trace output. Notice how it prints errors about two files this time.

$ GIT_TRACE=1 git rebase -i 4a1552c81b622f85b0e9170c6fd7a22b4a3e633c
trace: exec: 'git-rebase' '-i' '4a1552c81b622f85b0e9170c6fd7a22b4a3e633c'
trace: built-in: git 'rev-parse' '--git-dir'
trace: built-in: git 'rev-parse' '--is-inside-work-tree'
trace: built-in: git 'rev-parse' '--show-cdup'
trace: built-in: git 'rev-parse' '--parseopt' '--' '-i'
'4a1552c81b622f85b0e9170c6fd7a22b4a3e633c'
trace: built-in: git 'rev-parse' '--git-dir'
trace: built-in: git 'rev-parse' '--show-cdup'
trace: built-in: git 'rev-parse' '--is-inside-work-tree'
trace: exec: 'git-var' 'GIT_COMMITTER_IDENT'
trace: built-in: git 'rev-parse' '--verify' 'HEAD'
trace: built-in: git 'update-index' '--ignore-submodules' '--refresh'
trace: built-in: git 'diff-files' '--quiet' '--ignore-submodules'
trace: built-in: git 'diff-index' '--cached' '--quiet' 'HEAD'
'--ignore-submodules' '--'
trace: built-in: git 'rev-parse' '--verify'
'4a1552c81b622f85b0e9170c6fd7a22b4a3e633c'
trace: built-in: git 'rev-parse' '--verify' 'HEAD'
trace: built-in: git 'rev-parse' '--short'
'4a1552c81b622f85b0e9170c6fd7a22b4a3e633c'
trace: built-in: git 'rev-parse' '--short'
'7a70781d089d98f0de606515d1041230cef9b184'
trace: built-in: git 'rev-parse' '--short'
'4a1552c81b622f85b0e9170c6fd7a22b4a3e633c'
trace: built-in: git 'rev-list' '--no-merges' '--cherry-pick'
'--pretty=oneline' '--abbrev-commit' '--abbrev=7' '--rever
se' '--left-right' '--topo-order'
'4a1552c81b622f85b0e9170c6fd7a22b4a3e633c...7a70781d089d98f0de606515d1041230cef9b184'
trace: built-in: git 'update-ref' 'ORIG_HEAD'
'7a70781d089d98f0de606515d1041230cef9b184'
trace: built-in: git 'rev-parse' '--verify' '4965936^'
trace: built-in: git 'rev-parse' '--verify' 'HEAD'
trace: built-in: git 'reset' '--hard' '4965936'
trace: run_command: 'read-tree' '-v' '-u' '--reset'
'49659367ed932a691749fb4c6b93e38b2a85e9e1'
trace: exec: 'git' 'read-tree' '-v' '-u' '--reset'
'49659367ed932a691749fb4c6b93e38b2a85e9e1'
trace: built-in: git 'read-tree' '-v' '-u' '--reset'
'49659367ed932a691749fb4c6b93e38b2a85e9e1'
error: git checkout-index: unable to create file
util/boink_unittest.cpp (File exists)
error: git checkout-index: unable to create file util/stringfuncs.cpp
(File exists)
fatal: Could not reset index file to revision '4965936'.
trace: built-in: git 'rev-parse' '--short' '4965936'
trace: built-in: git 'rev-parse' '--verify' 'd9c7ac9^'
trace: built-in: git 'rev-parse' '--verify' 'HEAD'
trace: built-in: git 'cherry-pick' 'd9c7ac9'
error: Entry 'util/boink-py.cc' not uptodate. Cannot merge.
fatal: merging of trees 0c27b10e163f00655486976896d096302b0f5c21 and
7c7dfd93d678cfc564649738d45260e0b5d9f5a7 failed
trace: built-in: git 'rev-list' '--parents' '-1' 'd9c7ac9'
trace: built-in: git 'diff-tree' '-p' 'd9c7ac9^'\!''
trace: built-in: git 'cat-file' 'commit' 'd9c7ac9'
trace: built-in: git 'config' 'i18n.commitencoding'
trace: built-in: git 'show' '-s' '--pretty=raw' '--encoding=UTF-8'
'd9c7ac9' '--'
trace: built-in: git 'rerere'
Could not apply d9c7ac9... Various reorganizations.

It doesn't really tell me much.

Maybe this command log is useful. I got this while aborting the
rebase. Looks like some file creation race condition? Windows doesn't
allow files to be deleted while they're open.

$ git rebase --abort
error: git checkout-index: unable to create file
util/boink_unittest.cpp (File exists)
fatal: Could not reset index file to revision
'7a70781d089d98f0de606515d1041230cef9b184'.

$ git rebase --abort
error: git checkout-index: unable to create file util/stringfuncs.h
(File exists)
fatal: Could not reset index file to revision
'7a70781d089d98f0de606515d1041230cef9b184'.

$ git rebase --abort
error: git checkout-index: unable to create file
util/boink_unittest.cpp (File exists)
error: git checkout-index: unable to create file util/common.h
(Permission denied)
fatal: Could not reset index file to revision
'7a70781d089d98f0de606515d1041230cef9b184'.

$ git rebase --abort

(this time it worked)

Thanks,
Ludde
