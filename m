From: Matt Kraai <kraai@ftbfs.org>
Subject: Re: [PATCH] Support FTP-over-SSL/TLS for regular FTP
Date: Sat, 12 Jan 2013 06:25:21 -0800
Message-ID: <20130112142521.GA21639@ftbfs.org>
References: <1357999192-877-1-git-send-email-modestas@vainius.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Modestas Vainius <modestas@vainius.eu>
X-From: git-owner@vger.kernel.org Sat Jan 12 15:26:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tu224-00005w-Jy
	for gcvg-git-2@plane.gmane.org; Sat, 12 Jan 2013 15:26:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753538Ab3ALOZk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Jan 2013 09:25:40 -0500
Received: from zoom.lafn.org ([108.92.93.123]:41622 "EHLO zoom.lafn.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753325Ab3ALOZk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jan 2013 09:25:40 -0500
Received: from hpe-490t.ftbfs.org (pool-108-23-63-172.lsanca.fios.verizon.net [108.23.63.172])
	(authenticated bits=0)
	by zoom.lafn.org (8.14.3/8.14.2) with ESMTP id r0CEPWFs019684;
	Sat, 12 Jan 2013 06:25:34 -0800 (PST)
	(envelope-from kraai@ftbfs.org)
Received: from kraai by hpe-490t.ftbfs.org with local (Exim 4.80)
	(envelope-from <kraai@ftbfs.org>)
	id 1Tu21R-0005kw-9H; Sat, 12 Jan 2013 06:25:21 -0800
Mail-Followup-To: Modestas Vainius <modestas@vainius.eu>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <1357999192-877-1-git-send-email-modestas@vainius.eu>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Virus-Scanned: clamav-milter 0.97 at zoom.lafn.org
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213283>

On Sat, Jan 12, 2013 at 03:59:52PM +0200, Modestas Vainius wrote:
> @@ -306,6 +311,11 @@ static CURL *get_curl_handle(void)
>  	if (curl_ftp_no_epsv)
>  		curl_easy_setopt(result, CURLOPT_FTP_USE_EPSV, 0);
>  
> +#ifdef CURLOPT_USE_SSL
> +    if (curl_ssl_try)
> +		curl_easy_setopt(result, CURLOPT_USE_SSL, CURLUSESSL_TRY);
> +#endif
> +
>  	if (curl_http_proxy) {
>  		curl_easy_setopt(result, CURLOPT_PROXY, curl_http_proxy);
>  		curl_easy_setopt(result, CURLOPT_PROXYAUTH, CURLAUTH_ANY);

It looks like the indentation of the "if" line you added is messed up.
