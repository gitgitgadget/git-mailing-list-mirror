From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH v2 2/3] send-email: handle multiple Cc addresses when
	reading mbox message
Date: Sat, 14 Feb 2009 21:07:31 -0800
Message-ID: <20090215050731.GA32067@kroah.com>
References: <1234672335-54321-1-git-send-email-jaysoffian@gmail.com> <1234672335-54321-2-git-send-email-jaysoffian@gmail.com> <1234672335-54321-3-git-send-email-jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Thomas Rast <trast@student.ethz.ch>,
	Junio C Hamano <gitster@pobox.com>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 15 06:25:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYZVu-00072P-GR
	for gcvg-git-2@gmane.org; Sun, 15 Feb 2009 06:25:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750753AbZBOFJP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Feb 2009 00:09:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750732AbZBOFJP
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Feb 2009 00:09:15 -0500
Received: from kroah.org ([198.145.64.141]:36150 "EHLO coco.kroah.org"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750718AbZBOFJO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Feb 2009 00:09:14 -0500
Received: from localhost (c-76-105-230-205.hsd1.or.comcast.net [76.105.230.205])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by coco.kroah.org (Postfix) with ESMTPSA id 9AE6E4903F;
	Sat, 14 Feb 2009 21:09:13 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1234672335-54321-3-git-send-email-jaysoffian@gmail.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109960>

On Sat, Feb 14, 2009 at 11:32:14PM -0500, Jay Soffian wrote:
> When git format-patch is given multiple --cc arguments, it generates a
> Cc header that looks like:
> 
>  Cc: first@example.com,
>      second@example.com,
>      third@example.com
> 
> Before this commit, send-email was unable to handle such a message as it
> did not handle folded header lines, nor multiple recipients in a Cc
> line.
> 
> This patch:
> 
> - Unfolds header lines by pre-processing the header before extracting
>   any of its fields.
> 
> - Handles Cc lines with multiple recipients.
> 
> - Adds use of Mail::Address if available for splitting Cc line and
>   the "Who should the emails be sent to?" prompt", with fall back to
>   existing split_addrs() function.

YES!!!

I was just trying to fix this in the latest version, as it couldn't
handle mbox files well at all (vger.kernel.org spit the output back at
me quite nastily when I tried it.)

Thanks for these fixes, I personally really appreciate it, and need
them.

greg k-h
