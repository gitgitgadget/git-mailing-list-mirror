From: Francois Pepin <fpepin@cs.mcgill.ca>
Subject: corrupted repository?
Date: Wed, 01 Oct 2008 17:29:38 -0400
Message-ID: <48E3EBC2.7090107@cs.mcgill.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 01 23:38:20 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kl9Ns-0000is-1S
	for gcvg-git-2@gmane.org; Wed, 01 Oct 2008 23:37:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753608AbYJAVgJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Oct 2008 17:36:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753604AbYJAVgI
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Oct 2008 17:36:08 -0400
Received: from trickle.CC.McGill.CA ([132.206.27.51]:63632 "EHLO
	trickle.cc.mcgill.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753413AbYJAVgH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Oct 2008 17:36:07 -0400
X-Greylist: delayed 379 seconds by postgrey-1.27 at vger.kernel.org; Wed, 01 Oct 2008 17:36:07 EDT
Received: from torrent.cc.mcgill.ca (torrent.CC.McGill.CA [132.206.27.49])
	by trickle.cc.mcgill.ca (8.13.6/8.12.3) with ESMTP id m91La4nk003048
	for <git@vger.kernel.org>; Wed, 1 Oct 2008 17:36:04 -0400 (EDT)
Received: from mailscan1.ncs.mcgill.ca (mailscan1.NCS.McGill.CA [132.216.77.248])
	by torrent.cc.mcgill.ca (8.12.11.20060308/8.12.3) with ESMTP id m91LTix7031727;
	Wed, 1 Oct 2008 17:29:44 -0400
Received: from mailscan1.ncs.mcgill.ca (localhost [127.0.0.1])
	by localhost (Postfix) with SMTP id 1D709400F;
	Wed,  1 Oct 2008 17:29:39 -0400 (EDT)
Received: from monch.mcb.mcgill.ca (monch.MCB.McGill.CA [132.206.211.134])
	by mailscan1.ncs.mcgill.ca (Postfix) with ESMTP id EFB493A17;
	Wed,  1 Oct 2008 17:29:38 -0400 (EDT)
User-Agent: Thunderbird 2.0.0.12 (X11/20080213)
X-PMX-Version: 5.4.2.338381, Antispam-Engine: 2.6.0.325393, Antispam-Data: 2008.9.28.155531
X-McGill-WhereFrom: Internal
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97272>

Hi,

The repository on my OS X machine (10.5.5) seems to have been suddenly 
become corrupted in a strange way.

Everything seems to be working properly there (git fsck --full returns 
normally with no output), but I cannot clone or pull from my other machines:

(iduna is the name of the OS X machine)
[francois@monch ~]$ git clone iduna:git iduna2
Initialized empty Git repository in /bioinfo/home/francois/iduna2/.git/
Password:
error: git upload-pack: git-pack-objects died with error.
fatal: git upload-pack: aborting due to possible repository corruption 
on the remote side.
remote: fatal: exec pack-objects failed.
remote: aborting due to possible repository corruption on the remote side.
fatal: early EOF
fatal: index-pack failed

I have the same issue from the same machine:
[francois@Iduna ~]$ git clone localhost:git git2
Initialized empty Git repository in /Users/francois/git2/.git/
remote: fatal: exec pack-objects failed.
error: git upload-pack: git-pack-objects died with error.
fatal: git upload-pack: aborting due to possible repository corruption 
on the remote side.
remote: aborting due to possible repository corruption on the remote side.
fatal: early EOF
fatal: index-pack failed

But not if I just do it locally:
[francois@Iduna ~]$ git clone git git2
Initialized empty Git repository in /Users/francois/git2/.git/
Checking out files:   2% (140/5273)
[I cancelled it at this point]

I am running git 1.6.0.2 on the mac, and have only recently updated it 
so that might have a role to play.

Any suggestion would be welcome to fix this issue, and I'll be more than 
happy to provide whatever more information could useful.

Francois
