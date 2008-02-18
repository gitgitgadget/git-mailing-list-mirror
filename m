From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/4] Export some email and pretty-printing functions
Date: Mon, 18 Feb 2008 12:44:48 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802181241440.30505@racer.site>
References: <alpine.LNX.1.00.0802171335460.5816@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Mon Feb 18 13:45:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JR5NI-0007kj-H8
	for gcvg-git-2@gmane.org; Mon, 18 Feb 2008 13:45:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758786AbYBRMpB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Feb 2008 07:45:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758641AbYBRMpA
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Feb 2008 07:45:00 -0500
Received: from mail.gmx.net ([213.165.64.20]:50943 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758606AbYBRMpA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Feb 2008 07:45:00 -0500
Received: (qmail invoked by alias); 18 Feb 2008 12:44:58 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp050) with SMTP; 18 Feb 2008 13:44:58 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18swakosW8sAbnwNY6BZ97nrQ3RNqwR+5PO6TUspA
	Mv/nwvcJu9yrrC
X-X-Sender: gene099@racer.site
In-Reply-To: <alpine.LNX.1.00.0802171335460.5816@iabervon.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74277>

Hi,

On Sun, 17 Feb 2008, Daniel Barkalow wrote:

> diff --git a/commit.h b/commit.h
> index 10e2b5d..42b4825 100644
> --- a/commit.h
> +++ b/commit.h
> @@ -71,6 +71,21 @@ extern void pretty_print_commit(enum cmit_fmt fmt, const struct commit*,
>                                  int abbrev, const char *subject,
>                                  const char *after_subject, enum date_mode,
>  				int non_ascii_present);
> +void add_user_info(const char *what, enum cmit_fmt fmt, struct strbuf *sb,
> +		   const char *line, enum date_mode dmode,
> +		   const char *encoding);
> +void pp_title_line(enum cmit_fmt fmt,
> +		   const char **msg_p,
> +		   struct strbuf *sb,
> +		   const char *subject,
> +		   const char *after_subject,
> +		   const char *encoding,
> +		   int plain_non_ascii);
> +void pp_remainder(enum cmit_fmt fmt,
> +		  const char **msg_p,
> +		  struct strbuf *sb,
> +		  int indent);
> +

In addition to Junio's concern that add_user_info() really wants to be 
called pp_add_user_info(), I cannot help myself but suspect that 
pp_write_email_headers() -- which called for a new name, too -- also wants 
to live in pretty.c.

Ciao,
Dscho
