From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] Support various HTTP authentication methods
Date: Thu, 29 Jan 2009 11:18:21 +0100
Message-ID: <4981826D.507@viscovery.net>
References: <1233221532.21518.1.camel@lena.gsc.riken.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Moriyoshi Koizumi <mozo@mozo.jp>
X-From: git-owner@vger.kernel.org Thu Jan 29 11:19:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSU05-0005PK-41
	for gcvg-git-2@gmane.org; Thu, 29 Jan 2009 11:19:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751552AbZA2KS0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Jan 2009 05:18:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751022AbZA2KSZ
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Jan 2009 05:18:25 -0500
Received: from lilzmailso02.liwest.at ([212.33.55.13]:57716 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750701AbZA2KSZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jan 2009 05:18:25 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1LSTyX-0000WL-JS; Thu, 29 Jan 2009 11:18:21 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 519DD6EF; Thu, 29 Jan 2009 11:18:21 +0100 (CET)
User-Agent: Thunderbird 2.0.0.18 (Windows/20081105)
In-Reply-To: <1233221532.21518.1.camel@lena.gsc.riken.jp>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107653>

Moriyoshi Koizumi schrieb:
> @@ -210,6 +272,20 @@ static CURL* get_curl_handle(void)
>  	if (curl_http_proxy)
>  		curl_easy_setopt(result, CURLOPT_PROXY, curl_http_proxy);

CURLOPT_PROXY is set here...

>  
> +	if (curl_http_auth) {
> +		long n = get_curl_auth_bitmask(curl_http_auth);
> +		curl_easy_setopt(result, CURLOPT_HTTPAUTH, n);
> +	}
> +
> +	if (curl_http_proxy) {
> +		curl_easy_setopt(result, CURLOPT_PROXY, curl_http_proxy);

... and here again. Is that necessary?

-- Hannes
