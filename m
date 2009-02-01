From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] http-push: refactor request url creation
Date: Sun, 1 Feb 2009 23:45:59 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902012341310.3586@pacific.mpi-cbg.de>
References: <4983929B.2010901@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 01 23:47:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LTl5e-0000wD-63
	for gcvg-git-2@gmane.org; Sun, 01 Feb 2009 23:46:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752969AbZBAWpc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Feb 2009 17:45:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752064AbZBAWpc
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Feb 2009 17:45:32 -0500
Received: from mail.gmx.net ([213.165.64.20]:48451 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751300AbZBAWpb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Feb 2009 17:45:31 -0500
Received: (qmail invoked by alias); 01 Feb 2009 22:45:29 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp055) with SMTP; 01 Feb 2009 23:45:29 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18w1bkaPKgwOa0to9pbejqpuccawDHYtzGK/rbN/f
	2NETS3e5dOrTcx
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <4983929B.2010901@gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.54
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108018>

Hi,

On Sat, 31 Jan 2009, Tay Ray Chuan wrote:

> * split "append_remote_object_url" signature across 3 lines at Dscho's suggestion

This line is longer than 80 characters (and I seem to remember that the 
recommended maximum for emails is even less than that).

> 
>  http-push.c |   62 +++++++++++++++++++++++-----------------------------------
>  1 files changed, 25 insertions(+), 37 deletions(-)
> 
> diff --git a/http-push.c b/http-push.c
> index 59037df..ba217fc 100644
> --- a/http-push.c
> +++ b/http-push.c
> @@ -209,6 +209,22 @@ static struct curl_slist *get_dav_token_headers(struct remote_lock *lock, enum d
>  	return dav_headers;
>  }
> 
> +static void append_remote_object_url(struct strbuf *buf, const char *url,
> +				     const char *hex,
> +				     int only_two_digit_prefix)
> +{

Fine.  You changed that, although I find the indentation rather funny, 
too.  I would have expected one tab and then the rest of the signature.

> +	strbuf_addf(buf, "%sobjects/%.*s/", url, 2, hex);
> +	if (!only_two_digit_prefix)
> +		strbuf_addf(buf, "%s", hex+2);
> +}
> +
> +static char *get_remote_object_url(const char *url, const char *hex, int only_two_digit_prefix)

But this is still too long.  And no, I will not go through your patch and 
point out every too-long line; I'll expect you to do that yourself...

Ciao,
Dscho
