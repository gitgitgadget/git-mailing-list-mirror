From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git-mv: fix directory separator treatment on Windows
Date: Tue, 30 Jun 2009 16:20:51 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0906301620370.4773@pacific.mpi-cbg.de>
References: <4A4A1445.6090704@viscovery.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Jun 30 16:21:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MLeB9-0002IM-Pz
	for gcvg-git-2@gmane.org; Tue, 30 Jun 2009 16:19:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752847AbZF3OTO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Jun 2009 10:19:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752569AbZF3OTN
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Jun 2009 10:19:13 -0400
Received: from mail.gmx.net ([213.165.64.20]:36279 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752500AbZF3OTN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jun 2009 10:19:13 -0400
Received: (qmail invoked by alias); 30 Jun 2009 14:19:15 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp063) with SMTP; 30 Jun 2009 16:19:15 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/x9KFYXrLxMKSTMGvfv9l0j7zT8U8c6ofl63xl4D
	oepuf38/XvoBim
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <4A4A1445.6090704@viscovery.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.65
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122515>

Hi,

On Tue, 30 Jun 2009, Johannes Sixt wrote:

> From: Johannes Sixt <j6t@kdbg.org>
> 
> The following invocations did not work as expected on Windows:
> 
>     git mv foo\bar dest
>     git mv foo\ dest
> 
> The first command was interpreted as
> 
>     git mv foo/bar dest/foo/bar
> 
> because the Windows style directory separator was not obeyed when the
> basename of 'foo\bar' was computed.
> 
> The second command failed because the Windows style directory separator was
> not removed from the source directory, whereupon the lookup of the
> directory in the index failed.
> 
> This fixes both issues by using is_dir_sep() and basename().
> 
> Signed-off-by: Johannes Sixt <j6t@kdbg.org>

ACK

Dscho
