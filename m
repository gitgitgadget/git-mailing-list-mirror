From: Joel Becker <Joel.Becker@oracle.com>
Subject: wherefore art thou, git-applymbox? - Adding non-self signoffs
Date: Thu, 3 Jan 2008 17:50:28 -0800
Message-ID: <20080104015028.GC3989@mail.oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 04 02:52:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JAbjS-00012D-Ga
	for gcvg-git-2@gmane.org; Fri, 04 Jan 2008 02:52:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752911AbYADBvt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jan 2008 20:51:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752862AbYADBvt
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Jan 2008 20:51:49 -0500
Received: from rgminet01.oracle.com ([148.87.113.118]:11347 "EHLO
	rgminet01.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752444AbYADBvs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jan 2008 20:51:48 -0500
Received: from rgmgw2.us.oracle.com (rgmgw2.us.oracle.com [138.1.186.111])
	by rgminet01.oracle.com (Switch-3.2.4/Switch-3.1.6) with ESMTP id m041pkQv009445
	for <git@vger.kernel.org>; Thu, 3 Jan 2008 18:51:46 -0700
Received: from acsmt358.oracle.com (acsmt358.oracle.com [141.146.40.158])
	by rgmgw2.us.oracle.com (Switch-3.2.4/Switch-3.2.4) with ESMTP id m03LnDG0004878
	for <git@vger.kernel.org>; Thu, 3 Jan 2008 18:51:46 -0700
Received: from ca-server1.us.oracle.com by acsmt356.oracle.com
	with ESMTP id 6633766231199411429; Thu, 03 Jan 2008 17:50:29 -0800
Received: from jlbec by ca-server1.us.oracle.com with local (Exim 4.67)
	(envelope-from <joel.becker@oracle.com>)
	id 1JAbhd-0006fT-6R; Thu, 03 Jan 2008 17:50:29 -0800
Content-Disposition: inline
X-Burt-Line: Trees are cool.
X-Red-Smith: Ninety feet between bases is perhaps as close as man has ever
	come to perfection.
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69545>

Junio, et al,
	When git-applymbox disappeared, I didn't pay much attention.  I
just learned git-am and went along.  Little did I know, there was a
trap laid.
	The ocfs2-tools.git repository is maintained by the entire ocfs2
team.  It's a "shared" style repo.  A proposed change is posted to
ocfs2-tools-devel, and when a teammate approves, they respond with a
signoff.  The author then adds the signoff to the patch and pushes to
the shared repo.
	We used to do this very easily with git-applymbox:
(from http://oss.oracle.com/osswiki/GitRepositories/ForMaintainers)

$ echo "Julie Hacker <julieh@my.site.com>" > /tmp/signoff
$ git branch to-push master
$ git checkout to-push
$ git format-patch -C -k --stdout master..workingbranch > /tmp/changes-to-push
$ git applymbox -k /tmp/changes-to-push /tmp/signoff
$ git push ssh://my.server.com/path/project.git to-push:master

	The <signoff> file argument to applymbox allowed us to add the
approvers signoff to an entire series in one go.  git-am does not have
this feature.  As far as I can tell, I have to edit each patch by hand
to add the new signoff.  Is there a better way?

Joel

-- 

Life's Little Instruction Book #356

	"Be there when people need you."

Joel Becker
Principal Software Developer
Oracle
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127
