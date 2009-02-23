From: "Ferry Huberts (Pelagic)" <ferry.huberts@pelagic.nl>
Subject: Re: [EGIT] [PATCH 2/2] Make sure to set up the default (pull)	remote
 branch for master
Date: Mon, 23 Feb 2009 17:13:59 +0100
Message-ID: <49A2CB47.6050303@pelagic.nl>
References: <cover.1235228532.git.ferry.huberts@pelagic.nl> <e26eb3c2a7a0ce2b96252f00c17a62913d741579.1235228532.git.ferry.huberts@pelagic.nl> <20090223160957.GK22848@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Feb 23 17:47:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lbdxg-0001FS-On
	for gcvg-git-2@gmane.org; Mon, 23 Feb 2009 17:47:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755270AbZBWQpw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Feb 2009 11:45:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755085AbZBWQpw
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Feb 2009 11:45:52 -0500
Received: from hupie.xs4all.nl ([82.95.241.251]:52324 "EHLO
	Lighthouse.internal.Hupie.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754975AbZBWQpv (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Feb 2009 11:45:51 -0500
Received: from [192.168.0.101] (unknown [192.168.0.101])
	by Lighthouse.internal.Hupie.com (Postfix) with ESMTP id 72EB358BDC7;
	Mon, 23 Feb 2009 17:14:07 +0100 (CET)
User-Agent: Thunderbird 2.0.0.19 (X11/20090105)
In-Reply-To: <20090223160957.GK22848@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111155>

Shawn O. Pearce wrote:
> ferry.huberts@pelagic.nl wrote:
>> This is to make sure that the git plugin sets up a clone
>> in the same fashion as the CLI git clone command.
> ...
>> @@ -158,6 +159,11 @@ private void doInit(final IProgressMonitor monitor)
>>  		local.getConfig().setBoolean("core", null, "bare", false);
>>  		
>>  		remoteConfig.update(local.getConfig());
>> +
>> +		/* setup the default (pull) remote branch for master */
>> +		local.getConfig().setString(RepositoryConfig.BRANCH_SECTION, Constants.MASTER, "remote", remoteName);
>> +		local.getConfig().setString(RepositoryConfig.BRANCH_SECTION, Constants.MASTER, "merge", Constants.R_HEADS + Constants.MASTER);
> 
> Shouldn't this be "branch" and not "Constants.MASTER" ?
> 
> IIRC the dialog lets you start off a branch that isn't "master",
> especially if the remote repository has no branch named "master"
> but has something else that HEAD points at.  "git clone" would
> setup this branch.${branch}.merge to point at what the upstream
> branch calls itself.
> 
yep. missed that. want a new patch? afaic you can patch that up yourself :-)

Ferry
