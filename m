From: Bill Lear <rael@zopyra.com>
Subject: Re: pull into dirty working tree
Date: Wed, 13 Jun 2007 10:56:08 -0500
Message-ID: <18032.5016.716192.939675@lisa.zopyra.com>
References: <18031.64456.948230.375333@lisa.zopyra.com>
	<Pine.LNX.4.64.0706131559210.4059@racer.site>
	<200706131640.22588.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 13 17:56:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HyVCl-0003xX-WC
	for gcvg-git@gmane.org; Wed, 13 Jun 2007 17:56:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758031AbXFMP4T (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Jun 2007 11:56:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758019AbXFMP4S
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jun 2007 11:56:18 -0400
Received: from mail.zopyra.com ([65.68.225.25]:61141 "EHLO zopyra.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757974AbXFMP4S (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jun 2007 11:56:18 -0400
Received: (from rael@localhost)
	by zopyra.com (8.11.6/8.11.6) id l5DFuEm17625;
	Wed, 13 Jun 2007 10:56:14 -0500
In-Reply-To: <200706131640.22588.andyparkins@gmail.com>
X-Mailer: VM 7.18 under Emacs 21.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50082>

On Wednesday, June 13, 2007 at 16:40:18 (+0100) Andy Parkins writes:
>On Wednesday 2007 June 13, Johannes Schindelin wrote:
>
>> The other thing, if you have to, is to put all dirty changes into the
>> index before pull. Something like "git add $(git ls-files --modified)".
>
>Or the shiny new
>
> git add -u
>
>which works a treat :-)

Better.

I wonder, also, if there could be a way to alert users that their
working tree is dirty before all the git pull blather comes out,
scaring their poor little souls?  So, instead of this:

% git pull
remote: Generating pack...
remote: Done counting 122 objects.
remote: Result has 90 objects.
remote: Deltifying 90 objects.
remote:  100% (90/90) done
Unpacking 90 objects
remote: Total 90 (delta 59), reused 41 (delta 10)
 100% (90/90) done
* refs/remotes/origin/master: fast forward to branch 'master' of
git://source/sc
  old..new: 171b65f..0be3472
* refs/remotes/origin/v1.0: fast forward to branch 'v1.0' of
git://source/sc
  old..new: a9de9dd..efa3a73
Updating 717d9f6..0be3472
src/fs/testsuite/fs.tst/gettest: needs update
src/nl/EocCompiler.cc: needs update
src/nl/EocCompiler.hh: needs update
src/nl/Nl.cc: needs update
fatal: Entry 'src/netlist/EocCompiler.cc' not uptodate. Cannot merge.

we could have:

% git pull
Sorry, I can't pull, as you have a dirty working tree.  Please commit
your changes or move your files before you pull.  These are the
files that are preventing this:

    src/fs/testsuite/fs.tst/gettest
    src/nl/EocCompiler.cc
    src/nl/EocCompiler.hh
    src/nl/Nl.cc


Bill
