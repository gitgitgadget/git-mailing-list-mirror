From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/2] builtin-prune.c: fix object parsing and use
 parse_options()
Date: Mon, 24 Mar 2008 14:13:19 +0100 (CET)
Message-ID: <alpine.LSU.1.00.0803241409400.4353@racer.site>
References: <200803232150.29971.barra_cuda@katamail.com> <alpine.LSU.1.00.0803232319130.4353@racer.site> <200803241331.17986.barra_cuda@katamail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Michele Ballabio <barra_cuda@katamail.com>
X-From: git-owner@vger.kernel.org Mon Mar 24 14:14:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JdmV5-0006MY-KR
	for gcvg-git-2@gmane.org; Mon, 24 Mar 2008 14:14:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759844AbYCXNNR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Mar 2008 09:13:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759833AbYCXNNR
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Mar 2008 09:13:17 -0400
Received: from mail.gmx.net ([213.165.64.20]:32802 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1759828AbYCXNNQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Mar 2008 09:13:16 -0400
Received: (qmail invoked by alias); 24 Mar 2008 13:13:15 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp040) with SMTP; 24 Mar 2008 14:13:15 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+azMA9BiqamFuYGdd/QEYbRkSiLu1D7jih9uXEHZ
	el5YEpj1mMaHsE
X-X-Sender: gene099@racer.site
In-Reply-To: <200803241331.17986.barra_cuda@katamail.com>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78030>

Hi,

On Mon, 24 Mar 2008, Michele Ballabio wrote:

> diff --git a/parse-options.h b/parse-options.h
> index 1af62b0..e6976ed 100644
> --- a/parse-options.h
> +++ b/parse-options.h
> @@ -110,6 +110,8 @@ extern NORETURN void usage_with_options(const char * const *usagestr,
>  
>  /*----- some often used options -----*/
>  extern int parse_opt_abbrev_cb(const struct option *, const char *, int);
> +extern int parse_opt_approxidate_cb(const struct option *, const char *,
> +		int);
>  
>  #define OPT__VERBOSE(var)  OPT_BOOLEAN('v', "verbose", (var), "be verbose")
>  #define OPT__QUIET(var)    OPT_BOOLEAN('q', "quiet",   (var), "be quiet")

And maybe a

#define OPT_DATE(s, l, v, h)	{ OPTION_CALLBACK, (s), (l), (v), "time", 
(h), 0, parse_opt_approxidate_cb }

Hmm?

Ciao,
Dscho
