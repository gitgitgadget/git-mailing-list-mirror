From: Nicolas Pitre <nico@fluxnic.net>
Subject: [PATCH] update git-repack documentation wrt repack.UseDeltaBaseOffset
Date: Thu, 04 Feb 2010 16:19:35 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1002041611530.1681@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 04 22:19:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nd974-0002q1-3d
	for gcvg-git-2@lo.gmane.org; Thu, 04 Feb 2010 22:19:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758281Ab0BDVTi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Feb 2010 16:19:38 -0500
Received: from relais.videotron.ca ([24.201.245.36]:12447 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758086Ab0BDVTh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Feb 2010 16:19:37 -0500
Received: from xanadu.home ([66.130.28.92]) by VL-MO-MR005.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KXC00EPN5WNBMI0@VL-MO-MR005.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 04 Feb 2010 16:19:36 -0500 (EST)
X-X-Sender: nico@xanadu.home
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139007>

This default for repack.UseDeltaBaseOffset has been "true" since
Git v1.6.0.

Signed-off-by: Nicolas Pitre <nico@fluxnic.net>


diff --git a/Documentation/git-repack.txt b/Documentation/git-repack.txt
index e2f2fa2..8c67d17 100644
--- a/Documentation/git-repack.txt
+++ b/Documentation/git-repack.txt
@@ -109,15 +109,15 @@ other objects in that pack they already have locally.
 Configuration
 -------------
 
-When configuration variable `repack.UseDeltaBaseOffset` is set
-for the repository, the command passes `--delta-base-offset`
-option to 'git pack-objects'; this typically results in slightly
-smaller packs, but the generated packs are incompatible with
-versions of git older than (and including) v1.4.3; do not set
-the variable in a repository that older version of git needs to
-be able to read (this includes repositories from which packs can
-be copied out over http or rsync, and people who obtained packs
-that way can try to use older git with it).
+By default, the command passes `--delta-base-offset` option to
+'git pack-objects'; this typically results in slightly smaller packs,
+but the generated packs are incompatible with versions of Git older than
+version 1.4.4. If you need to share your repository with such ancient Git
+versions, either directly or via the dumb http or rsync protocol, then you
+need to set the configuration variable `repack.UseDeltaBaseOffset` to
+"false" and repack. Access from old Git versions over the native protocol
+is unaffected by this option as the conversion is performed on the fly
+as needed in that case.
 
 
 Author
