From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Re: That improved git-gui blame viewer..
Date: Wed, 13 Jun 2007 18:54:58 +0200
Message-ID: <200706131854.59605.Josef.Weidendorfer@gmx.de>
References: <alpine.LFD.0.98.0706091117510.20321@woody.linux-foundation.org> <Pine.LNX.4.64.0706131553390.4059@racer.site> <200706131827.08163.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Marco Costalba <mcostalba@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jun 13 18:55:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HyW7j-0001wU-Lg
	for gcvg-git@gmane.org; Wed, 13 Jun 2007 18:55:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757692AbXFMQzJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Jun 2007 12:55:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758040AbXFMQzJ
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jun 2007 12:55:09 -0400
Received: from mailout1.informatik.tu-muenchen.de ([131.159.0.18]:43921 "EHLO
	mailout1.informatik.tu-muenchen.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757692AbXFMQzI (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 Jun 2007 12:55:08 -0400
Received: from dhcp-3s-48.lrr.in.tum.de (dhcp-3s-48.lrr.in.tum.de [131.159.35.48])
	by mail.in.tum.de (Postfix) with ESMTP id AA9E12233;
	Wed, 13 Jun 2007 18:55:06 +0200 (MEST)
User-Agent: KMail/1.9.7
In-Reply-To: <200706131827.08163.Josef.Weidendorfer@gmx.de>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new/sophie/sophos at mailrelay2.informatik.tu-muenchen.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50097>

On Wednesday 13 June 2007, Josef Weidendorfer wrote:
> While without "-z", log_tree_diff immediatly returns
> because "opt->diff" is 0, in the case of "-z",
> the tree differences are fully done even not used at all ?!

I wished git-gui and gitk would be better integrated for
history/blame browsing; I also missed a text search functionality
in the blame view of git-gui.

Neverless...

opt->diff is set to 1 in setup_revisions() whenever
diff_opt_parse() parses an option. And "-z" is
parsed in diff_opt_parse().

In cd2bdc, Linus write in the commit log

 - make setup_revision set a flag (revs->diff) if the diff-related
   arguments were used. This allows "git log" to decide whether it wants
   to show diffs or not.

So why is "-z" regarded as tree-diff related, leading to calculating diffs?

Josef
