From: Finn Arne Gangstad <finnag@pvv.org>
Subject: git gui blame utf-8 bugs
Date: Wed, 12 Dec 2007 10:17:44 +0100
Message-ID: <20071212091744.GA5377@pvv.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org, spearce@spearce.org
X-From: git-owner@vger.kernel.org Wed Dec 12 10:18:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2Njm-0005YA-EY
	for gcvg-git-2@gmane.org; Wed, 12 Dec 2007 10:18:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758868AbXLLJRt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Dec 2007 04:17:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758064AbXLLJRs
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Dec 2007 04:17:48 -0500
Received: from decibel.pvv.ntnu.no ([129.241.210.179]:59789 "EHLO
	decibel.pvv.ntnu.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758846AbXLLJRq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Dec 2007 04:17:46 -0500
Received: from finnag by decibel.pvv.ntnu.no with local (Exim 4.60)
	(envelope-from <finnag@pvv.ntnu.no>)
	id 1J2Niq-0002Az-Qc; Wed, 12 Dec 2007 10:17:44 +0100
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68019>

git gui has some utf-8 bugs:

If you do git gui blame <file>, and the file contains utf-8 text,
the lines are not parsed as utf-8, but seemingly as iso-8859-1 instead.

Also, the hovering comment is INITIALLY shown garbled (both Author and
commit message), but if you click on a line, so that the commit
message is shown in the bottom window, the hovering message is
magically corrected to utf-8.

The text in the lower window (showing specific commits) seems to
always be handled correctly.

To reproduce: Set your author name to include some utf-8 tokens, add a
line with some utf-8 tokens to a file, commit it with a commit message
including some utf-8 tokens, and do git gui blame on the file. The
line will be garbled in the top window, and the hovering message will
be garbled until you click on the line.

Verified with git-gui.git master

- Finn Arne
