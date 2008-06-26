From: "David Jeske" <jeske@willowmail.com>
Subject: is rebase the same as merging every commit?
Date: Thu, 26 Jun 2008 23:04:58 -0000
Message-ID: <1006.35704952783$1214525911@news.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 27 02:18:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KC1fU-0004bj-K1
	for gcvg-git-2@gmane.org; Fri, 27 Jun 2008 02:18:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755147AbYF0AR2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jun 2008 20:17:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755041AbYF0AR2
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jun 2008 20:17:28 -0400
Received: from w2.willowmail.com ([64.243.175.54]:32802 "HELO
	w2.willowmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754747AbYF0AR1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jun 2008 20:17:27 -0400
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Thu, 26 Jun 2008 20:17:27 EDT
Received: (qmail 19347 invoked by uid 90); 27 Jun 2008 00:10:39 -0000
X-Mailer: Willow v0.02
Received: from 72.14.229.81 at Thu, 26 Jun 2008 23:04:58 -0000
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86506>

Rebasing is described in the docs I've read as turning this: (sorry for the
dots)

..........A---B---C topic
........./
....D---E---F---G master

Into this:

...................A'--B'--C' topic
................../
.....D---E---F---G master

If I understand it right (and that's a BIG if), it's the same as doing a merge
of C into G where every individual commit in the C-line is individually
committed into the new C' line.

...........-------------A---B---C
........../            /   /   /
........./        /---A'--B'--C'  topic
......../        /
....D---E---F---G - master


(1) Is the above model a valid explanation?

(2) From the documentation diagrams, it looks like the rebased A' has only (G)
as a parent, not (A,G). If this is the case, why?  (i.e. not connecting those
nodes throws away useful information)

(3) If it only has (G) as a parent, does the rebase explicitly remove the
source A,B,C nodes from the repository? (the diagrams make it look like it
does) ..or do they just get cleaned up during GC?
