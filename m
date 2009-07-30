From: Brian Ristuccia <brian@ristuccia.com>
Subject: git clone ignores GIT_ALTERNATE_OBJECT_DIRECTORIES
Date: Thu, 30 Jul 2009 13:58:33 -0400
Message-ID: <20090730175833.GV12813@osiris.978.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 30 20:05:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MWa0V-0004lg-9q
	for gcvg-git-2@gmane.org; Thu, 30 Jul 2009 20:05:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752110AbZG3SFQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Jul 2009 14:05:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751946AbZG3SFP
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Jul 2009 14:05:15 -0400
Received: from osiris.978.org ([72.70.36.11]:34111 "HELO osiris.978.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751903AbZG3SFO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jul 2009 14:05:14 -0400
X-Greylist: delayed 398 seconds by postgrey-1.27 at vger.kernel.org; Thu, 30 Jul 2009 14:05:14 EDT
Received: (qmail 26467 invoked by uid 1000); 30 Jul 2009 13:58:34 -0400
Received: by osiris.978.org (hashcash-sendmail, from uid 1000);
	Thu, 30 Jul 2009 13:58:33 -0400
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Hashcash: 1:21:090730:git@vger.kernel.org::g1TFN0BslVVh1AID:000000000000000000
	0000000000000000000000004j47
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124476>

When running git clone, it seems that GIT_ALTERNATE_OBJECT_DIRECTORIES is
not considered. Even though most of the needed objects are in
GIT_ALTERNATE_OBJECT_DIRECTORIES, I still wind up with a ton of traffic over
the network and a huge .git/objects hierarchy.

Running "git gc" later pares down the .git/objects to a more reasonable
size, so it seems the problem is limited to git clone. Using "git clone
--reference" also seems to do the right thing.

Is this behavior intentional for some good reason I've overlooked, or have I
stumbled on a bug?

-- 
Brian Ristuccia
brian@ristuccia.com
