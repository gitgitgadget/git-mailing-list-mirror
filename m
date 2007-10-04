From: Jan Wielemaker <wielemak@science.uva.nl>
Subject: Re: [PATCH/RFT] cvsserver: only allow checkout of branches
Date: Thu, 4 Oct 2007 19:06:20 +0200
Message-ID: <200710041906.21004.wielemak@science.uva.nl>
References: <200710031348.50800.wielemak@science.uva.nl> <200710041506.13154.wielemak@science.uva.nl> <Pine.LNX.4.64.0710041622070.4174@racer.site>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Frank Lichtenheld <frank@lichtenheld.de>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Oct 04 19:07:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IdU9o-0007De-AT
	for gcvg-git-2@gmane.org; Thu, 04 Oct 2007 19:06:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757089AbXJDRGa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Oct 2007 13:06:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756516AbXJDRGa
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Oct 2007 13:06:30 -0400
Received: from smtp-vbr3.xs4all.nl ([194.109.24.23]:2758 "EHLO
	smtp-vbr3.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756161AbXJDRG3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Oct 2007 13:06:29 -0400
Received: from ct.xs4all.nl (ct.xs4all.nl [82.92.39.12])
	by smtp-vbr3.xs4all.nl (8.13.8/8.13.8) with ESMTP id l94H6LBC008103;
	Thu, 4 Oct 2007 19:06:21 +0200 (CEST)
	(envelope-from wielemak@science.uva.nl)
User-Agent: KMail/1.9.5
In-Reply-To: <Pine.LNX.4.64.0710041622070.4174@racer.site>
Content-Disposition: inline
X-Virus-Scanned: by XS4ALL Virus Scanner
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59986>

On Thursday 04 October 2007 17:29, Johannes Schindelin wrote:
> It does not make sense to check out tags or "HEAD".
>
> Noticed by Jan Wielemaker.

Thanks (though it won't bite me a second time :-)

> ) +    {
> +	$log->warn("Checkout failed: $module is not a branch");
> +	print "error 1 Checkout failed: $module is not a branch\n";

There are various places where it says print "...", one that even
started some suggestion on what might be wrong, but these things don't
end up at a visible place when using ssh as transport. Its a good idea
this one is at least in the logfile as well. Not sure, but might
printing to stderr work better?

	Cheers --- Jan
