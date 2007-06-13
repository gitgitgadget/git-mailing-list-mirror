From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: That improved git-gui blame viewer..
Date: Wed, 13 Jun 2007 18:05:55 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0706131804080.4059@racer.site>
References: <alpine.LFD.0.98.0706091117510.20321@woody.linux-foundation.org>
 <Pine.LNX.4.64.0706131553390.4059@racer.site> <200706131827.08163.Josef.Weidendorfer@gmx.de>
 <200706131854.59605.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Marco Costalba <mcostalba@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>
To: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jun 13 19:09:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HyWLP-0005gc-KV
	for gcvg-git@gmane.org; Wed, 13 Jun 2007 19:09:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757941AbXFMRJS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Jun 2007 13:09:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757806AbXFMRJS
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jun 2007 13:09:18 -0400
Received: from mail.gmx.net ([213.165.64.20]:47120 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757450AbXFMRJR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jun 2007 13:09:17 -0400
Received: (qmail invoked by alias); 13 Jun 2007 17:09:15 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp057) with SMTP; 13 Jun 2007 19:09:15 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+WJilJFnSWPqXyBNsjlKNqqTYWVaZIRtxmFq0OHh
	9+Y9NtNB7oURQX
X-X-Sender: gene099@racer.site
In-Reply-To: <200706131854.59605.Josef.Weidendorfer@gmx.de>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50099>

Hi,

On Wed, 13 Jun 2007, Josef Weidendorfer wrote:

> opt->diff is set to 1 in setup_revisions() whenever
> diff_opt_parse() parses an option. And "-z" is
> parsed in diff_opt_parse().
> 
> In cd2bdc, Linus write in the commit log
> 
>  - make setup_revision set a flag (revs->diff) if the diff-related
>    arguments were used. This allows "git log" to decide whether it wants
>    to show diffs or not.
> 
> So why is "-z" regarded as tree-diff related, leading to calculating diffs?

Because it changes the behaviour of a diff. As far as I can tell, the line 
termination does not have any effect on any output _except_ the diff 
output.

So, I should have realized earlier that "git-log -z" _without_ anything in 
the way of "-p", "--stat" or friends does not make sense at all.

Ciao,
Dscho
