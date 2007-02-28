From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Show binary file size change in diff --stat
Date: Wed, 28 Feb 2007 16:37:01 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702281630430.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0702281535070.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <200702281515.10016.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 28 16:37:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMQrb-0002iy-J4
	for gcvg-git@gmane.org; Wed, 28 Feb 2007 16:37:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751910AbXB1PhE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Feb 2007 10:37:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751922AbXB1PhE
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Feb 2007 10:37:04 -0500
Received: from mail.gmx.net ([213.165.64.20]:57693 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751910AbXB1PhD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Feb 2007 10:37:03 -0500
Received: (qmail invoked by alias); 28 Feb 2007 15:37:02 -0000
X-Provags-ID: V01U2FsdGVkX181A4EDlXQ1n3TJovF16fsHUmRGnKdJy8ch89Kg8U
	KAaw==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <200702281515.10016.andyparkins@gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40942>

Hi,

On Wed, 28 Feb 2007, Andy Parkins wrote:

> +				printf("%s%i%s", add_c, added, reset);

Please use "%d" instead of "%i" (I forgot why, but I remember Junio saying 
that we should do it...).

> +			if (added != 0 && deleted != 0 )
> +				printf(" -> ");

Either you want to have

	Bin +123456 bytes

or

	Bin 0 -> 123456 bytes

for added files (and the obvious thing for deleted ones), but with your 
patch, both added and deleted get

	Bin 123456 bytes

which is not so optimal.

Ciao,
Dscho
