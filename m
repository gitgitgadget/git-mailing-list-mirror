From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/3] fast-import: improve efficiency of tree_content_set
Date: Sat, 10 Mar 2007 14:23:04 -0500
Message-ID: <20070310192304.GB3416@coredump.intra.peff.net>
References: <<20070310191515.GA3416@coredump.intra.peff.net>> <20070310192131.GB3875@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, spearce@spearce.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 10 20:23:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HQ79w-0006kg-0V
	for gcvg-git@gmane.org; Sat, 10 Mar 2007 20:23:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751755AbXCJTXJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 10 Mar 2007 14:23:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751785AbXCJTXJ
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Mar 2007 14:23:09 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3025 "HELO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751755AbXCJTXI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Mar 2007 14:23:08 -0500
Received: (qmail 19288 invoked from network); 10 Mar 2007 14:23:26 -0500
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 66-23-211-5.clients.speedfactory.net with SMTP; 10 Mar 2007 14:23:26 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 10 Mar 2007 14:23:04 -0500
Content-Disposition: inline
In-Reply-To: <20070310192131.GB3875@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41881>

On Sat, Mar 10, 2007 at 02:21:31PM -0500, Jeff King wrote:

> This patch keeps the tree entries of a tree_content in
> order, sorted by entry name. The lookup in find_tree_entry
> now performs a binary search instead of a linear search.

I should note that this patch doesn't handle removing entries from
tree_content structs; I will work up a patch for that momentarily.

-Peff
