From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Make repack less likely to corrupt repository
Date: Sun, 15 Feb 2009 17:46:59 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902151745270.10279@pacific.mpi-cbg.de>
References: <1234140299-29785-1-git-send-email-robin.rosenberg@dewire.com> <200902110127.18149.robin.rosenberg.lists@dewire.com> <7vwsbxizlg.fsf@gitster.siamese.dyndns.org> <200902151715.19351.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	spearce@spearce.org
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Sun Feb 15 17:47:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYk9X-0004YO-Rm
	for gcvg-git-2@gmane.org; Sun, 15 Feb 2009 17:47:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753209AbZBOQqK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Feb 2009 11:46:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753195AbZBOQqI
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Feb 2009 11:46:08 -0500
Received: from mail.gmx.net ([213.165.64.20]:60199 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753185AbZBOQqH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Feb 2009 11:46:07 -0500
Received: (qmail invoked by alias); 15 Feb 2009 16:46:04 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp061) with SMTP; 15 Feb 2009 17:46:04 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19I/QsTGwZIFbH3N/GPFrfBMd7niW22+ZnuEaD+pb
	jRQ+mybyXciKiH
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <200902151715.19351.robin.rosenberg.lists@dewire.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110021>

Hi,

On Sun, 15 Feb 2009, Robin Rosenberg wrote:
> -	exit 1
> +	echo >&2 "INFO: We recovered from the repack error, but your repo"
> +	echo >&2 "INFO: is probably suboptimally packed. You may try to repack"
> +	echo >&2 "INFO: later. A common reason for repacking failure is that"
> +	echo >&2 "INFO: a Windows program was locking one of the old pack files."
> +	echo >&2 "INFO: To repack successfully you may have to close that program"
> +	echo >&2 "INFO: before repacking."

cat >&2 << EOF?

> +	exit

You lose the error condition here, but I cannot find a convincing argument 
about that in the commit message.

Ciao,
Dscho
