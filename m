From: Jeff King <peff@peff.net>
Subject: Re: [Bug] Segfault in git status
Date: Thu, 21 Feb 2008 11:20:30 -0500
Message-ID: <20080221162029.GA25778@coredump.intra.peff.net>
References: <F8D3F7F0-3A98-4576-BD89-6E5C682B351C@fastmail.fm> <D3C27E63-329D-4509-830A-099A7BCB72B7@ai.rug.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Dane Jensen <careo@fastmail.fm>,
	Junio C Hamano <gitster@pobox.com>,
	Jay Soffian <jaysoffian@gmail.com>, git@vger.kernel.org
To: Pieter de Bie <pdebie@ai.rug.nl>
X-From: git-owner@vger.kernel.org Thu Feb 21 17:21:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JSEAW-0000AC-BE
	for gcvg-git-2@gmane.org; Thu, 21 Feb 2008 17:21:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757073AbYBUQUd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Feb 2008 11:20:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757140AbYBUQUd
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Feb 2008 11:20:33 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2976 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757032AbYBUQUc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Feb 2008 11:20:32 -0500
Received: (qmail 14313 invoked by uid 111); 21 Feb 2008 16:20:31 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Thu, 21 Feb 2008 11:20:31 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 21 Feb 2008 11:20:30 -0500
Content-Disposition: inline
In-Reply-To: <D3C27E63-329D-4509-830A-099A7BCB72B7@ai.rug.nl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74626>

On Thu, Feb 21, 2008 at 05:01:10PM +0100, Pieter de Bie wrote:

> Program received signal EXC_BAD_ACCESS, Could not access memory.
> Reason: KERN_INVALID_ADDRESS at address: 0x004a2010
> index_name_exists (istate=0xeba80, name=0xbfffdc27 "Data/Cache/ 
> Template/Peter_II_of_Yugoslavia.html", namelen=47) at read-cache.c:101
> 101			if (!(ce->ce_flags & CE_UNHASHED)) {
> (gdb) print *ce
> Cannot access memory at address 0x4a1fec

This shows up using valgrind under Linux, too. I haven't had time to
track it down yet, though.

-Peff
