From: magnuspalmer <magnus.palmer@jayway.com>
Subject: Re: Migrating from subversion via git svn contains log entry, but
 not the file change in the branch.
Date: Mon, 3 May 2010 05:53:00 -0700 (PDT)
Message-ID: <1272891180297-4997630.post@n2.nabble.com>
References: <1272889536578-4997493.post@n2.nabble.com> <4BDEC3AE.90409@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 03 14:53:09 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O8v93-00005P-Is
	for gcvg-git-2@lo.gmane.org; Mon, 03 May 2010 14:53:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758766Ab0ECMxE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 May 2010 08:53:04 -0400
Received: from kuber.nabble.com ([216.139.236.158]:44109 "EHLO
	kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758565Ab0ECMxA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 May 2010 08:53:00 -0400
Received: from jim.nabble.com ([192.168.236.80])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <magnus.palmer@jayway.com>)
	id 1O8v8u-000708-9p
	for git@vger.kernel.org; Mon, 03 May 2010 05:53:00 -0700
In-Reply-To: <4BDEC3AE.90409@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146232>


Answer to list failed, so typing it in forum instead.


Michael J Gruber-2 wrote:
> 
> magnuspalmer venit, vidit, dixit 03.05.2010 14:25:
>> 
>> I've been working almost fulltime for two weeks migrating a subversion
>> repository to git.
>> Most repos go fine, but some doesn't and I'm running out of options.
>> 
>> Been trying to find posts regarding this and tried what I've found.
>> 
>> The subversion repo contains subrepos.
>> Layout is this:
>> tags
>> branches
>> <trunk is in root dir, contains only a maven pom.xml>
>> subrepo-a(with standard layout: trunk, tags, branches)
>> subrepo-n
>> 
>> Team is doing ongoing development in currently four branches (develop,
>> release-product-a-1.1, release-product-b-1.0, trunk). I'll deal with that
>> later.
>> 
>> What happends is that I get the svn log message, but the file is not the
>> correct one, or the file is completely missing suddenly.
>> git checkout develop
>> HEAD is now at 5269d17... increased version to 1.2.0-SNAPSHOT.
>> 
>> The change in the file is not there, the old version number in the
>> pom.xml.
>> I compare this with the one checkout out via svn.
>> 
>> git svn init --trunk='' --tags=tags/*/* --branches=branches --prefix=svn/
> 
> What is the reason for the tags/*/*? I would expect a simple --tags=tags
> here.
> 
>>> they have for some reason tags/internal-delivery and tags/delivery
> 
>> --ignore-paths="branches|tags|subrepo-a|subrepo-b|"
>> https://example.com/svn/theproject/client
>> 
>> Then I've tried:
>> git fetch
>> git fetch --no-follow-parent
> 
> git svn that, I assume.
> 
>>> Yes, it is git svn of course. 
> 
>> turn on/off brokensymlink workaround
>> git config svn.brokenSymlinkWorkaround false
>> git config svn.brokenSymlinkWorkaround true
> 
> Do you use symlinks?
> 
>>> Don't know, I am off site the current team that will move to this
>>> location.
>>> Since they use windows workstations I doubt it.
> 
>> Also started at different revisions
>> -r XYZ:HEAD
>> 
>> For one of the cases (with svn.brokenSymlinkWorkaround=false) I get:
>> Found possible branch point:
>> https://example.com/svn/theproject/client/branches/develop/pom.xml =>
>> https://example.com/svn/theproject/client/branches/release-1.1.0, 10623
>> Initializing parent: release-1.1.0@10623
>> W: Ignoring error from SVN, path probably does not exist: (160013):
>> Filesystem has no item: File not found: revision 6973, path
>> '/theproject/client/branches/develop/pom.xml'
>> 
>> And I end up with a:
>> remotes/release-1.1.0
>> remotes/release-1.1.0@10623
>> 
>> Any ideas of how to proceed?
>> I am getting short out of ideas.
> 
> I assume you can't make that repo accessible, can you?
> 
>>> No, unfortunately :(
>>> It was hard getting access myself.
>>> It is a team of consultants moving from offsite contracting to inhouse
>>> development. Same team though.
> 
> Michael
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 

-- 
View this message in context: http://git.661346.n2.nabble.com/Migrating-from-subversion-via-git-svn-contains-log-entry-but-not-the-file-change-in-the-branch-tp4997493p4997630.html
Sent from the git mailing list archive at Nabble.com.
