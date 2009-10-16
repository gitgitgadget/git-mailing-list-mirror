From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/3] strbuf_nested_expand(): allow expansion to interrupt
 in the middle
Date: Fri, 16 Oct 2009 13:30:18 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0910161329270.4985@pacific.mpi-cbg.de>
References: <1255681702-5215-1-git-send-email-gitster@pobox.com> <1255681702-5215-3-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 16 13:35:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Myl6C-0004zE-3Z
	for gcvg-git-2@lo.gmane.org; Fri, 16 Oct 2009 13:35:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758292AbZJPL2W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Oct 2009 07:28:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758006AbZJPL2W
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Oct 2009 07:28:22 -0400
Received: from mail.gmx.net ([213.165.64.20]:42525 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751429AbZJPL2V (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Oct 2009 07:28:21 -0400
Received: (qmail invoked by alias); 16 Oct 2009 11:27:33 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp066) with SMTP; 16 Oct 2009 13:27:33 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+lV+lbiAClOyozbawPOWLxK6XKUzm0OT/BEEOef2
	w4W2gacu/1iNAl
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <1255681702-5215-3-git-send-email-gitster@pobox.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130477>

Hi,

On Fri, 16 Oct 2009, Junio C Hamano wrote:

>  		consumed = fn(sb, format, context);
> -		if (consumed)
> +		if ((ssize_t) consumed < 0)
> +			break;

Would it not be much better to fix the signature of fn in a separate 
commit before this one?

Ciao,
Dscho
