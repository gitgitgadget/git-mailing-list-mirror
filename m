From: Yann Dirson <ydirson@free.fr>
Subject: [BUG] blame -M not finding that some lines were moved
Date: Sun, 16 Jan 2011 21:56:19 +0100
Message-ID: <20110116205619.GR3296@home.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: GIT list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jan 16 21:56:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PeZeL-0001JY-Dz
	for gcvg-git-2@lo.gmane.org; Sun, 16 Jan 2011 21:56:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753908Ab1APU41 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Jan 2011 15:56:27 -0500
Received: from smtp5-g21.free.fr ([212.27.42.5]:33486 "EHLO smtp5-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753666Ab1APU41 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Jan 2011 15:56:27 -0500
Received: from home.lan (unknown [81.57.214.146])
	by smtp5-g21.free.fr (Postfix) with ESMTP id 0A840D48052
	for <git@vger.kernel.org>; Sun, 16 Jan 2011 21:56:20 +0100 (CET)
Received: from yann by home.lan with local (Exim 4.72)
	(envelope-from <ydirson@free.fr>)
	id 1PeZe7-0003Zk-HO
	for git@vger.kernel.org; Sun, 16 Jan 2011 21:56:19 +0100
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165167>

I just noticed a case where "git blame -M" ran on a file containing
only line reorderings in the last commit would still report some files
as being introduced in the reordering commit.  Reproduced with Debian
squeeze's 1.7.2.3, as well as with 1.7.4.rc2.

Sample case is available from https://alioth.debian.org/anonscm/git/omaha/omaha.git,
commit 369b92da.

"git blame -L325,354 -M 369b92da README" shows the reordered lines,
where lies 332, 333, 338 are reported new in this commit.

It does not seem to be related to the -M threshold.
