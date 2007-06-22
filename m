From: Johannes Sixt <J.Sixt@eudaptics.com>
Subject: Re: [PATCH] diffcore-rename: favour identical basenames
Date: Fri, 22 Jun 2007 09:17:17 +0200
Organization: eudaptics software gmbh
Message-ID: <467B777D.C47BFE0E@eudaptics.com>
References: <20070621030622.GD8477@spearce.org>
	 <alpine.LFD.0.98.0706202031200.3593@woody.linux-foundation.org>
	 <Pine.LNX.4.64.0706211248420.4059@racer.site> <20070621131915.GD4487@coredump.intra.peff.net> <Pine.LNX.4.64.0706220214250.4059@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 22 09:18:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I1dPT-0000Ql-3d
	for gcvg-git@gmane.org; Fri, 22 Jun 2007 09:18:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751810AbXFVHSW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Jun 2007 03:18:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751803AbXFVHSV
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Jun 2007 03:18:21 -0400
Received: from main.gmane.org ([80.91.229.2]:50598 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751219AbXFVHSV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jun 2007 03:18:21 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1I1dP5-0002lw-5S
	for git@vger.kernel.org; Fri, 22 Jun 2007 09:18:00 +0200
Received: from cm56-163-160.liwest.at ([86.56.163.160])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 22 Jun 2007 09:17:59 +0200
Received: from J.Sixt by cm56-163-160.liwest.at with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 22 Jun 2007 09:17:59 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: cm56-163-160.liwest.at
X-Mailer: Mozilla 4.73 [en] (Windows NT 5.0; U)
X-Accept-Language: en
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50680>

Johannes Schindelin wrote:
>         The dangerous thing is that the score can get negative now.
>  ...
> +               score = (int)(src_copied * MAX_SCORE / max_size)
> +                       - levenshtein(src->path, dst->path);

Does that also mean that you can't ever have a rename with a score of
100%?

(I haven't studied the algorithms and assume that levenshtein(a,b) == 0
only if a==b, and that without the -levenshtein(...) the score can grow
to 100%.)

-- Hannes
