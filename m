From: Erez Zadok <ezk@cs.sunysb.edu>
Subject: splitting large patch files into smaller ones
Date: Wed, 22 Aug 2007 15:29:42 -0400
Message-ID: <200708221929.l7MJTgiL012452@agora.fsl.cs.sunysb.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 22 21:29:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1INvtk-0000kN-R1
	for gcvg-git@gmane.org; Wed, 22 Aug 2007 21:29:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756771AbXHVT3p (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 22 Aug 2007 15:29:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753623AbXHVT3p
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Aug 2007 15:29:45 -0400
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:47771 "EHLO
	filer.fsl.cs.sunysb.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753366AbXHVT3o (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Aug 2007 15:29:44 -0400
Received: from agora.fsl.cs.sunysb.edu (agora.fsl.cs.sunysb.edu [130.245.126.12])
	by filer.fsl.cs.sunysb.edu (8.12.11.20060308/8.13.1) with ESMTP id l7MJTgo4000738
	for <git@vger.kernel.org>; Wed, 22 Aug 2007 15:29:42 -0400
Received: from agora.fsl.cs.sunysb.edu (localhost.localdomain [127.0.0.1])
	by agora.fsl.cs.sunysb.edu (8.13.1/8.13.1) with ESMTP id l7MJTgC9012455
	for <git@vger.kernel.org>; Wed, 22 Aug 2007 15:29:42 -0400
Received: (from ezk@localhost)
	by agora.fsl.cs.sunysb.edu (8.13.1/8.12.8/Submit) id l7MJTgiL012452;
	Wed, 22 Aug 2007 15:29:42 -0400
X-MailKey: Erez_Zadok
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56411>

I recently had an occasion to take a rather large git-diff patch, and split
it into smaller chunks.  This was so I can more easily import the patches
into guilt, then reorder, rename, shuffle, and join individual patch
snippets into logical patches (i.e., one patch per topic).

I was looking around for a tool that would allow me to split a large patch
file into individual snippets and couldn't find one.  So I wrote one in
perl.  It takes a patch file and creates individual small files, one for
each combination of a filename listed in the patch, and a patch snippet
(starting with an '@@' line).  Each '@@' snippet gets an index number and a
new filename, prefixed with the appropriate header ("diff ...", ---, and +++
lines) so it's a valid patch file on its own.

Questions:

1. Does anyone know of such a tool, perhaps written in C for better speed?

2. If not, is there any interest in such a tool?  If there's interest, I'd
   be happy to cleanup my perl script and contribute it to
   git/guilt/whatever.

Cheers,
Erez.
