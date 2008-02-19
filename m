From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/2] branch: optionally setup branch.*.merge from upstream
 local branches
Date: Tue, 19 Feb 2008 16:45:22 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802191643490.30505@racer.site>
References: <1203438278-73786-1-git-send-email-jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 19 17:46:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JRVbh-0000LL-JA
	for gcvg-git-2@gmane.org; Tue, 19 Feb 2008 17:46:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753495AbYBSQpi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Feb 2008 11:45:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753426AbYBSQpi
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Feb 2008 11:45:38 -0500
Received: from mail.gmx.net ([213.165.64.20]:41029 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753471AbYBSQph (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Feb 2008 11:45:37 -0500
Received: (qmail invoked by alias); 19 Feb 2008 16:45:36 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp043) with SMTP; 19 Feb 2008 17:45:36 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/VSK4RT9fVeBFurRFoxUV9STB4mKzb+/7k97da4y
	D5zXwt9u3RsbJA
X-X-Sender: gene099@racer.site
In-Reply-To: <1203438278-73786-1-git-send-email-jaysoffian@gmail.com>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74434>

Hi,

On Tue, 19 Feb 2008, Jay Soffian wrote:

> +	if (!tracking.matches)
> +		switch (track) {
> +		case BRANCH_TRACK_ALWAYS:
> +		case BRANCH_TRACK_EXPLICIT:
> +			break;
> +		default:
> +			return 1;
> +		}

I'd write that as

	if (!tracking.matches &&
	    (track == BRANCH_TRACK_ALWAYS || track == BRANCH_TRACK_EXPLICIT))
		return 1;

but that is really niggling about style...

As you can see, I have no real objections ;-)

Ciao,
Dscho
