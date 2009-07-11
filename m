From: "Stephen R. van den Berg" <srb@cuci.nl>
Subject: Re: [PATCH] Fix export_marks() error handling.
Date: Sat, 11 Jul 2009 11:45:46 +0200
Message-ID: <20090711094546.GA12399@cuci.nl>
References: <alpine.DEB.1.00.0907091500420.4339@intel-tinevez-2-302> <1247146081-4692-1-git-send-email-matthias.andree@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matthias Andree <matthias.andree@gmx.de>
X-From: git-owner@vger.kernel.org Sat Jul 11 11:55:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MPZIi-0002SR-L6
	for gcvg-git-2@gmane.org; Sat, 11 Jul 2009 11:55:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753562AbZGKJzW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Jul 2009 05:55:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752531AbZGKJzU
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Jul 2009 05:55:20 -0400
Received: from aristoteles.cuci.nl ([212.125.128.18]:42776 "EHLO
	aristoteles.cuci.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756199AbZGKJzL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Jul 2009 05:55:11 -0400
X-Greylist: delayed 560 seconds by postgrey-1.27 at vger.kernel.org; Sat, 11 Jul 2009 05:55:11 EDT
Received: by aristoteles.cuci.nl (Postfix, from userid 500)
	id 8CDFC541F; Sat, 11 Jul 2009 11:45:46 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1247146081-4692-1-git-send-email-matthias.andree@gmx.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123106>

Matthias Andree wrote:
>+	/* do not optimize the next two lines - they must both be executed in
>+	 * this order. || might short-circuit the fclose(), and combining them
>+	 * into one statement might reverse the order of execution.
>+	 * Also, fflush() may not be sufficient - on some file systems, the
>+	 * error is still delayed until the final [f]close().  */
>+	e  = ferror(f);
>+	e |= fclose(f);
>+	if (e)

The commentary above should be common knowledge for anyone familiar with
ANSI C.  So I'd suggest moving the comments into the description section of
the commit and removing them from the actual code.
-- 
Sincerely,
           Stephen R. van den Berg.

"And now for something *completely* different!"
