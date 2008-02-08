From: Michele Ballabio <barra_cuda@katamail.com>
Subject: Re: [PATCH] remote.c: guard config parser from value=NULL
Date: Fri, 8 Feb 2008 17:34:37 +0100
Message-ID: <200802081734.37715.barra_cuda@katamail.com>
References: <20080208142640.GX25954@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Miklos Vajna <vmiklos@frugalware.org>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 08 17:27:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNW45-0005XG-En
	for gcvg-git-2@gmane.org; Fri, 08 Feb 2008 17:27:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757329AbYBHQ0I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Feb 2008 11:26:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756820AbYBHQ0H
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Feb 2008 11:26:07 -0500
Received: from smtp.katamail.com ([62.149.157.154]:57230 "HELO
	smtp1.pc.aruba.it" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with SMTP id S1757311AbYBHQ0F (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Feb 2008 11:26:05 -0500
Received: (qmail 30211 invoked by uid 89); 8 Feb 2008 16:25:41 -0000
X-Spam-Checker-Version: SpamAssassin 3.2.3 (2007-08-08) on smtp1-pc
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=5.0 tests=RDNS_NONE autolearn=disabled
	version=3.2.3
Received: from unknown (HELO host116-57-static.104-80-b.business.telecomitalia.it) (barra?cuda@katamail.com@80.104.57.116)
  by smtp1-pc with SMTP; 8 Feb 2008 16:25:41 -0000
User-Agent: KMail/1.9.7
In-Reply-To: <20080208142640.GX25954@genesis.frugalware.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73106>

On Friday 08 February 2008, Miklos Vajna wrote:
> Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
> ---
>  remote.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/remote.c b/remote.c
> index 0e00680..4765815 100644
> --- a/remote.c
> +++ b/remote.c
> @@ -276,7 +276,7 @@ static int handle_config(const char *key, const char *value)
>  		else
>  			error("more than one uploadpack given, using the first");
>  	} else if (!strcmp(subkey, ".tagopt")) {
> -		if (!strcmp(value, "--no-tags"))
> +		if (value && !strcmp(value, "--no-tags"))
>  			remote->fetch_tags = -1;
>  	} else if (!strcmp(subkey, ".proxy")) {
>  		remote->http_proxy = xstrdup(value);

Function handle_config() has already returned 0 at this point.
