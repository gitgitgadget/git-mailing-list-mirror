From: Pavel Roskin <proski@gnu.org>
Subject: Caching directories
Date: Mon, 23 Jan 2006 23:20:23 -0500
Message-ID: <1138076423.15105.36.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Tue Jan 24 05:20:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F1FfX-00014M-5p
	for gcvg-git@gmane.org; Tue, 24 Jan 2006 05:20:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932104AbWAXEU1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Jan 2006 23:20:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932318AbWAXEU1
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jan 2006 23:20:27 -0500
Received: from fencepost.gnu.org ([199.232.76.164]:38604 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S932104AbWAXEU0
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jan 2006 23:20:26 -0500
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1F1FfL-0003xs-0d
	for git@vger.kernel.org; Mon, 23 Jan 2006 23:20:23 -0500
Received: from proski by dv.roinet.com with local (Exim 4.60)
	(envelope-from <proski@dv.roinet.com>)
	id 1F1FfM-00043Y-5P
	for git@vger.kernel.org; Mon, 23 Jan 2006 23:20:24 -0500
To: git <git@vger.kernel.org>
X-Mailer: Evolution 2.5.4 (2.5.4-10) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15092>

Hello!

I'm thinking of moving cg-clean functionality to git.  After having
switched to StGIT, it's the last cogito command I'm still using.  I
think git can go it much better, since it's a recursive command
traversing the whole repository.

To be safe and useful, the new command should distinguish between
tracked and untracked directories.  Untracked files in tracked
directories are usually the first target for cleaning, as they are
mostly automatic backups and temporary files.  Untracked directories are
more likely candidates to be preserved, as they can hold external
sources, build output, extensive test data etc.

cg-clean considers a directory untracked if it has no cached files in
it.  This carries a significant speed penalty, even if not coded in
bash.

Maybe it's time to start caching directories in git?  I mean,
directories corresponding to tree objects could have their stats
recorded in the cache.  This would allow to distinguish between tracked
and untracked directories without scanning them recursively.

-- 
Regards,
Pavel Roskin
