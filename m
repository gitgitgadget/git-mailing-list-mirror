From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] http-push: support full URI in handle_remote_ls_ctx()
Date: Sun, 18 Jan 2009 15:51:39 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901181546100.3586@pacific.mpi-cbg.de>
References: <1232278116-6631-1-git-send-email-catap@catap.ru>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "Kirill A. Korinskiy" <catap@catap.ru>
X-From: git-owner@vger.kernel.org Sun Jan 18 15:54:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOZ2x-0002Yu-Af
	for gcvg-git-2@gmane.org; Sun, 18 Jan 2009 15:54:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757523AbZAROvk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Jan 2009 09:51:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756540AbZAROvk
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Jan 2009 09:51:40 -0500
Received: from mail.gmx.net ([213.165.64.20]:43515 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756458AbZAROvj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Jan 2009 09:51:39 -0500
Received: (qmail invoked by alias); 18 Jan 2009 14:51:37 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp043) with SMTP; 18 Jan 2009 15:51:37 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+JjD087KiJ8POAXaXWRh68yY8f3bz+Yap1bg+zGW
	nkXu5QAAWC6YmR
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <1232278116-6631-1-git-send-email-catap@catap.ru>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.54
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106202>

Hi,

On Sun, 18 Jan 2009, Kirill A. Korinskiy wrote:

> The program calls remote_ls() to get list of files from the server
> over HTTP; handle_remote_ls_ctx() is used to parse its response to
> populate "struct remote_ls_ctx" that is returned from remote_ls().
> 
> The handle_remote_ls_ctx() function assumed that the server returns a
> local path in href field, but RFC 4918 (14.7) demand of support full
> URI (e.g. "http://localhost:8080/repo.git").
> 
> This resulted in push failure (e.g. git-http-push issues a PROPFIND
> request to "/repo.git/alhost:8080/repo.git/refs/" to the server).
> 
> Signed-off-by: Kirill A. Korinskiy <catap@catap.ru>
> ---
>  http-push.c |   24 ++++++++++++++++++------
>  1 files changed, 18 insertions(+), 6 deletions(-)
> 
> diff --git a/http-push.c b/http-push.c
> index 7c6460919bf3eba10c46cede11ffdd9c53fd2dd2..2cb925a9ad857b6d79858d5187f14072167282e7 100644

You mean this patch is not vs 
junio/next(bbe7a8ed3dac72b7a1372cd92f68f47965c10100) or junio/master or 
junio/maint(both a4b7d08663504a57008f66a39fffe293f62c1d08) but 
tags/v1.6.1-rc4~13?

Ciao,
Dscho
