From: Yann Dirson <ydirson@altern.org>
Subject: stgit restrictions on patch names
Date: Thu, 25 Oct 2007 21:48:08 +0200
Message-ID: <20071025194808.GV26436@nan92-1-81-57-214-146.fbx.proxad.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT list <git@vger.kernel.org>
To: Catalin Marinas <catalin.marinas@gmail.com>,
	Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Thu Oct 25 21:53:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Il8lp-0002ZF-On
	for gcvg-git-2@gmane.org; Thu, 25 Oct 2007 21:53:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754411AbXJYTxV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Oct 2007 15:53:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754453AbXJYTxV
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Oct 2007 15:53:21 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:54961 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754411AbXJYTxU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Oct 2007 15:53:20 -0400
Received: from smtp3-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp3-g19.free.fr (Postfix) with ESMTP id A617C17B5AA;
	Thu, 25 Oct 2007 21:53:18 +0200 (CEST)
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id 7439E17B557;
	Thu, 25 Oct 2007 21:53:18 +0200 (CEST)
Received: by gandelf.nowhere.earth (Postfix, from userid 1000)
	id A6C741F0D5; Thu, 25 Oct 2007 21:48:08 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62363>

Looks like stgit is now more picky on patch names than in used to be:

$ stg branch --clone v2.0.6-debian
Checking for changes in the working directory ... done
Cloning current branch to "v2.0.6-debian" ...
  No log for 01_springelectrical
stg branch: Invalid patch name: "10_g++4.0_build_failures"
$


=> the result of the cloning operation is a partial clone.  Do we want to:

- implement a mechanism for checking beforehand that the operation
will not fail ?  Seems awkward to duplicate checks already found
elsewhere.

- wait for proper transactions so we can rollback on error ?

- on clone error, delete the newly-created stack ?  I'd vote for this
one, until the previous one gets done.


=> is there any particular reason why we would refuse "+" ?
