From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: PATCH] http-push: refactor request url creation
Date: Sat, 24 Jan 2009 18:03:34 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901241758200.13232@racer>
References: <be6fef0d0901240816r25e6a9c9q2d437d413a524362@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 24 18:04:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQlvs-00067y-HK
	for gcvg-git-2@gmane.org; Sat, 24 Jan 2009 18:04:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755559AbZAXRDK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Jan 2009 12:03:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755457AbZAXRDI
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Jan 2009 12:03:08 -0500
Received: from mail.gmx.net ([213.165.64.20]:50506 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754977AbZAXRDH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Jan 2009 12:03:07 -0500
Received: (qmail invoked by alias); 24 Jan 2009 17:03:04 -0000
Received: from pD9EB3F9A.dip0.t-ipconnect.de (EHLO noname) [217.235.63.154]
  by mail.gmx.net (mp063) with SMTP; 24 Jan 2009 18:03:04 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18GfJkqRzIGLMnrZRqMK+fICzcju4Mtz3SZB0ZH9G
	AZ0LAy5jWlyJZo
X-X-Sender: gene099@racer
In-Reply-To: <be6fef0d0901240816r25e6a9c9q2d437d413a524362@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.5600000000000001
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106977>

Hi,

On Sun, 25 Jan 2009, Ray Chuan wrote:

> Currently, functions that deal with objects on the remote repository
> have to allocate and do strcpys to generate the URL.
> 
> This patch saves them this trouble, by providing a function that
> returns a URL: either the object's 2-digit hex directory (eg.
> /objects/a1/) or the complete object location (eg. /objects/a1/b2).
> 
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>

Make that an Acked-by: okay?

> diff --git a/http-push.c b/http-push.c
> index cb5bf95..715954e 100644
> --- a/http-push.c
> +++ b/http-push.c
> @@ -177,6 +177,16 @@ struct remote_ls_ctx
>  	struct remote_ls_ctx *parent;
>  };
> 
> +static char *get_remote_object_url(const char *url, const char *hex,
> int only_two_digit_postfix) {

It is actually a prefix.

Ciao,
Dscho
