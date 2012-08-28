From: Mike Hommey <mh@glandium.org>
Subject: git-rerere vs rebase --skip
Date: Tue, 28 Aug 2012 23:52:02 +0200
Message-ID: <20120828215202.GB7702@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 29 00:27:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T6UFc-0002lk-M1
	for gcvg-git-2@plane.gmane.org; Wed, 29 Aug 2012 00:27:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753435Ab2H1W1F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Aug 2012 18:27:05 -0400
Received: from cha92-13-88-165-248-19.fbx.proxad.net ([88.165.248.19]:60624
	"EHLO jigen.glandium.org" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753194Ab2H1W1E (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 28 Aug 2012 18:27:04 -0400
X-Greylist: delayed 2097 seconds by postgrey-1.27 at vger.kernel.org; Tue, 28 Aug 2012 18:27:03 EDT
Received: from mh by jigen.glandium.org with local (Exim 4.80)
	(envelope-from <mh@glandium.org>)
	id 1T6Tha-00029q-Ir
	for git@vger.kernel.org; Tue, 28 Aug 2012 23:52:02 +0200
Content-Disposition: inline
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204455>

Hi,

In one of my workflows, I constantly rebase topic branches on top of new
upstream imports. As there are several upstream import branches, I have
similar topic branches on top of different imports.
When rebasing the topic branches, I can hit conflict resolution that I
already had to do for other topic branches on another upstream import
branch. Here, git rerere is very helpful. But sometimes, the conflict
resolution is just to skip the patch, because it was incorporated
upstream in a way that git doesn't detect, or it was obsoleted, or
whatever. In such cases, git rerere is not being helpful because it
doesn't store any information about that, and I have to check again if
that's an actual conflict to solve or a patch to skip again.

It would be helpful if there was a rebase --skip mode that would tell
rerere to record that the resolution *is* --skip.

Mike
