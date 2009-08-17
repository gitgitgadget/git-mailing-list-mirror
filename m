From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 03/11] Define SNPRINTF_SIZE_CORR 1 when use MSVC build
 git
Date: Mon, 17 Aug 2009 18:32:43 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0908171829510.4991@intel-tinevez-2-302>
References: <1250524872-5148-1-git-send-email-lznuaa@gmail.com> <1250524872-5148-2-git-send-email-lznuaa@gmail.com> <1250524872-5148-3-git-send-email-lznuaa@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, msysgit@googlegroups.com
To: Frank Li <lznuaa@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 17 18:33:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Md58z-00040t-Fz
	for gcvg-git-2@lo.gmane.org; Mon, 17 Aug 2009 18:33:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757026AbZHQQcp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Aug 2009 12:32:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756905AbZHQQco
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Aug 2009 12:32:44 -0400
Received: from mail.gmx.net ([213.165.64.20]:34211 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756654AbZHQQco (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Aug 2009 12:32:44 -0400
Received: (qmail invoked by alias); 17 Aug 2009 16:32:44 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp012) with SMTP; 17 Aug 2009 18:32:44 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19ESHNX+1RE3FReIx4qKwQSvJ6ngCjZfN/FI97E4r
	9cbdK4DhKlmBMz
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <1250524872-5148-3-git-send-email-lznuaa@gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.63
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126221>

Hi,

On Tue, 18 Aug 2009, Frank Li wrote:

> There are not NUL at vsnprintf verstion of MSVC when rearch max len.
> Define vsnprintf to _vsnprintf. vsnprintf have deprecated.

How about this instead?

	Define SNPRINTF_SIZE_CORR=1 for Microsoft Visual C++

	The Microsoft C runtime's vsnprintf function does not add NUL at 
	the end of the buffer.

	Further, Microsoft deprecated vsnprintf in favor of _vsnprintf, so 
	add a #define to that end.

The patch is good, although I suspect that the definition of vsnprintf is 
better handled in the precompiler options in .vcproj.

Ciao,
Dscho
