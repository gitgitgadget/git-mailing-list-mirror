From: Nick Hengeveld <nickh@reactrix.com>
Subject: HTTP pushes
Date: Mon, 31 Oct 2005 18:02:48 -0800
Message-ID: <20051101020248.GA3928@reactrix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Tue Nov 01 03:04:08 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EWlUV-0003jV-GL
	for gcvg-git@gmane.org; Tue, 01 Nov 2005 03:03:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964908AbVKACC7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 31 Oct 2005 21:02:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964913AbVKACC7
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Oct 2005 21:02:59 -0500
Received: from 195.37.26.69.virtela.com ([69.26.37.195]:255 "EHLO
	teapot.corp.reactrix.com") by vger.kernel.org with ESMTP
	id S964908AbVKACC6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Oct 2005 21:02:58 -0500
Received: from teapot.corp.reactrix.com (localhost.localdomain [127.0.0.1])
	by teapot.corp.reactrix.com (8.12.11/8.12.11) with ESMTP id jA122nP6000408
	for <git@vger.kernel.org>; Mon, 31 Oct 2005 18:02:49 -0800
Received: (from nickh@localhost)
	by teapot.corp.reactrix.com (8.12.11/8.12.11/Submit) id jA122mp3000406
	for git@vger.kernel.org; Mon, 31 Oct 2005 18:02:48 -0800
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10917>

HTTP is currently listed as a read-only/unsupported method for doing
pushes, is that due to inherent problems with HTTP or just because
it hasn't been written yet?

I've built a working prototype of an HTTP push implementation using DAV.
It locks the remote branch file during the push and PUTs to temp files to
insure nobody else reads objects while they're being pushed.  It does
not validate remote objects - if they exist on the remote end as loose
objects or in a pack, local copies won't be pushed.  It supports sparse
object directories, and verifies that the remote branch is an ancestor
of the local branch before doing anything.

I'm curious to know whether it would be useful to proceed further, and
to know what I haven't thought about yet...

-- 
For a successful technology, reality must take precedence over public
relations, for nature cannot be fooled.
