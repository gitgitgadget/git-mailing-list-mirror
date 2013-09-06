From: Andreas Krey <a.krey@gmx.de>
Subject: [PATCH 0/3] Unconfuse git clone when two branches at are HEAD.
Date: Fri, 6 Sep 2013 17:52:04 +0200
Message-ID: <20130906155204.GE12966@inner.h.apk.li>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 06 17:52:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VHyKv-00070V-K1
	for gcvg-git-2@plane.gmane.org; Fri, 06 Sep 2013 17:52:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753943Ab3IFPwh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Sep 2013 11:52:37 -0400
Received: from continuum.iocl.org ([217.140.74.2]:51622 "EHLO
	continuum.iocl.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753557Ab3IFPwh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Sep 2013 11:52:37 -0400
Received: (from krey@localhost)
	by continuum.iocl.org (8.11.3/8.9.3) id r86Fq4h00815;
	Fri, 6 Sep 2013 17:52:04 +0200
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-message-flag: What did you expect to see here?
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234053>

Ok, here are some patches that make git actually
check out the current remote branch when cloning.

Up to now this failed when there were two branches that pointed to 
the HEAD commit of the remote repo, and git clone would sometimes
choose the wrong one as the HEAD ref isn't transmitted in all
transport.

Stuff the HEAD ref into the capability list (assuming refs are clean 
enough to do that w/o escaping), and read them out on the other
side. All other things were thankfully already in place.

Two of the patches have Junio in the From as they are essentially his.

Andreas
