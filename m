From: Peter Hagervall <hager@cs.umu.se>
Subject: Re: PATCH Documentation/git-rev-list.txt typo fix
Date: Fri, 16 Sep 2005 16:24:12 +0200
Message-ID: <20050916142412.GA973@brainysmurf.cs.umu.se>
References: <E1EG2Or-0005E2-Pw@jdl.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, junkio@cox.net
X-From: git-owner@vger.kernel.org Fri Sep 16 16:26:32 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EGH8l-0004bQ-2g
	for gcvg-git@gmane.org; Fri, 16 Sep 2005 16:24:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161102AbVIPOYc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Sep 2005 10:24:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161106AbVIPOYc
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Sep 2005 10:24:32 -0400
Received: from mail.cs.umu.se ([130.239.40.25]:64458 "EHLO mail.cs.umu.se")
	by vger.kernel.org with ESMTP id S1161102AbVIPOYb (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 16 Sep 2005 10:24:31 -0400
Received: from localhost (localhost [127.0.0.1])
	by amavisd-new (Postfix) with ESMTP id C5B122E28;
	Fri, 16 Sep 2005 16:24:30 +0200 (MEST)
Received: from mail.cs.umu.se ([127.0.0.1])
 by localhost (mimmi.cs.umu.se [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id 29328-01; Fri, 16 Sep 2005 16:24:13 +0200 (MEST)
Received: from brainysmurf.cs.umu.se (brainysmurf.cs.umu.se [130.239.89.21])
	by mail.cs.umu.se (Postfix) with ESMTP id E80AD2E1D;
	Fri, 16 Sep 2005 16:24:12 +0200 (MEST)
Received: by brainysmurf.cs.umu.se (Postfix, from userid 12006)
	id A979E31; Fri, 16 Sep 2005 16:24:12 +0200 (CEST)
To: jdl@freescale.com
Content-Disposition: inline
In-Reply-To: <E1EG2Or-0005E2-Pw@jdl.com>
User-Agent: Mutt/1.5.9i
X-Virus-Scanned: amavisd-new at cs.umu.se
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8684>

On Thu, Sep 15, 2005 at 05:40:13PM -0500, jdl@freescale.com wrote:
> I'm not positive what the doc conventions are, but I think
> something like this patch fixes the "superscript" problem
> on the git-rev-list doc page.
> 
> Signed-off-by: Jon Loeliger <jdl@freescale.com>
<snip>
> -if "git-rev-list --bisect foo ^bar ^baz" outputs 'midpoint', the output
> -of "git-rev-list foo ^midpoint" and "git-rev-list midpoint ^bar ^baz"
> +if 'git-rev-list --bisect foo ^bar ^baz' outputs 'midpoint', the output
> +of 'git-rev-list foo ^midpoint' and 'git-rev-list midpoint ^bar ^baz'
<snip>

This causes a mismatch in <emphasis> and <superscript> tags, one way of
fixing it is having no more than one caret symbol per line, which is the
only solution I found in the asciidoc documentation. Ugly, but it works.

Signed-off-by: Peter Hagervall <hager@cs.umu.se>
---


diff --git a/Documentation/git-rev-list.txt b/Documentation/git-rev-list.txt
--- a/Documentation/git-rev-list.txt
+++ b/Documentation/git-rev-list.txt
@@ -32,8 +32,11 @@ I have the commit object 'bar', but not 
 
 The *--bisect* flag limits output to the one commit object which is
 roughly halfway between the included and excluded commits. Thus,
-if 'git-rev-list --bisect foo ^bar ^baz' outputs 'midpoint', the output
-of 'git-rev-list foo ^midpoint' and 'git-rev-list midpoint ^bar ^baz'
+if 'git-rev-list --bisect foo ^bar
+^baz' outputs 'midpoint', the output
+of 'git-rev-list foo ^midpoint' and 'git-rev-list midpoint
+^bar
+^baz'
 would be of roughly the same length. Finding the change which introduces
 a regression is thus reduced to a binary search: repeatedly generate and
 test new 'midpoint's until the commit chain is of length one.
