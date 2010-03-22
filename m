From: Thomas Koch <thomas@koch.ro>
Subject: Re: rethinking patch management with GIT / topgit
Date: Mon, 22 Mar 2010 08:59:40 +0100
Message-ID: <201003220859.41820.thomas@koch.ro>
References: <201003201802.51129.thomas@koch.ro> <201003201953.34666.thomas@koch.ro> <20100321203626.GE3533@machine.or.cz>
Reply-To: thomas@koch.ro
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, vcs-pkg-discuss@lists.alioth.debian.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Mon Mar 22 08:59:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NtcYE-0007ci-KP
	for gcvg-git-2@lo.gmane.org; Mon, 22 Mar 2010 08:59:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753536Ab0CVH7t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Mar 2010 03:59:49 -0400
Received: from koch.ro ([88.198.2.104]:60840 "EHLO koch.ro"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753359Ab0CVH7s (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Mar 2010 03:59:48 -0400
Received: from 84-72-85-88.dclient.hispeed.ch ([84.72.85.88] helo=jona.localnet)
	by koch.ro with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <thomas@koch.ro>)
	id 1NtcUv-0001Gv-6Z; Mon, 22 Mar 2010 08:56:29 +0100
User-Agent: KMail/1.12.4 (Linux/2.6.32-2-amd64; KDE/4.3.4; x86_64; ; )
In-Reply-To: <20100321203626.GE3533@machine.or.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142908>

Hi Petr,

Petr Baudis:
> On Sat, Mar 20, 2010 at 07:53:34PM +0100, Thomas Koch wrote:
> > Petr Baudis:
> >   - tg recreate <patchset> <newbase> <new patchset name>
> >     Creates a new patchset with root <newbase> by creating new patch
> > branches for each patch branch in <patchset>
> >     This command is useful if you need to keep the old patchset to
> > maintain an older version of your Debian package.
> 
> This means wiping out history again; in TopGit, you would ideally
> checkpoint all the branches within the patchset, then just tg update
> your branches. It's another matter that the former is now difficult to
> do easily.
It's not necessary to lose history. Creating a new patchset from a given 
patchset could be done in at least three different ways. Given that you've a 
patchset named patches-x.y.z/* and you'd like to create patches-x.y.z+1/* from 
this, you could

- checkout new patch branches from the top of the old patch branches and merge 
upstream into each of them

- recreate (like rebase) the full history of the patch branches on top of the 
new upstream

- collapse the branch history and create one commit per patch branch on top of 
the new upstream

In all three cases you're free to either keep or throw away the old patchset.

Best regards,

Thomas Koch, http://www.koch.ro
