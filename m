From: "Ferry Huberts (Pelagic)" <ferry.huberts@pelagic.nl>
Subject: Re: [PATCH] git-svn: always initialize with core.autocrlf=false
Date: Thu, 09 Apr 2009 19:21:29 +0200
Message-ID: <49DE2E99.9060804@pelagic.nl>
References: <cover.1239276588u.git.johannes.schindelin@gmx.de> <560e98ae1d5350c6ff8db56d41089900dbaab08a.1239276588u.git.johannes.schindelin@gmx.de> <20090409165920.GA6311@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	git@vger.kernel.org, gitster@pobox.com
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Thu Apr 09 19:23:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LrxyW-00089J-KM
	for gcvg-git-2@gmane.org; Thu, 09 Apr 2009 19:23:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764292AbZDIRVd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Apr 2009 13:21:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764101AbZDIRVc
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Apr 2009 13:21:32 -0400
Received: from hupie.xs4all.nl ([82.95.241.251]:52167 "EHLO
	Lighthouse.internal.Hupie.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1760690AbZDIRVb (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Apr 2009 13:21:31 -0400
Received: from [192.168.0.101] (unknown [192.168.0.101])
	by Lighthouse.internal.Hupie.com (Postfix) with ESMTP id BE2FA58BD88;
	Thu,  9 Apr 2009 19:21:29 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
In-Reply-To: <20090409165920.GA6311@dcvr.yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116183>

Eric Wong wrote:
> Johannes Schindelin <johannes.schindelin@gmx.de> wrote:
>> It has been reported time and time again in relation to msysGit that
>> git-svn does not work well when core.autocrlf has any value other than
>> 'false'.  So let's make it so by default.
>>
>> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> Acked-by: Eric Wong <normalperson@yhbt.net>
> 
>> ---
>>  git-svn.perl |    1 +
>>  1 files changed, 1 insertions(+), 0 deletions(-)
>>
>> diff --git a/git-svn.perl b/git-svn.perl
>> index 8be6be0..d4e8fc8 100755
>> --- a/git-svn.perl
>> +++ b/git-svn.perl
>> @@ -325,6 +325,7 @@ sub do_git_init_db {
>>  		command_noisy(@init_db);
>>  		$_repository = Git->repository(Repository => ".git");
>>  	}
>> +	command_noisy('config', 'core.autocrlf', 'false');
>>  	my $set;
>>  	my $pfx = "svn-remote.$Git::SVN::default_repo_id";
>>  	foreach my $i (keys %icv) {
>> -- 
>> 1.6.2.1.613.g25746
> 
funny that this kind of seems to get through while my suggestion (and
proff by tests) to do the same for the cvs-import stuff resulted in
hefty discussions and no consensus on what to do, the result of which is
to do nothing. i guess i couldn't make myself clear enough?
