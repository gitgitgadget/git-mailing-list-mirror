From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] Support various HTTP authentication methods
Date: Thu, 29 Jan 2009 15:08:50 +0100
Message-ID: <4981B872.4040701@viscovery.net>
References: <1233221532.21518.1.camel@lena.gsc.riken.jp> <4981826D.507@viscovery.net> <4981B6E6.6020502@mozo.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Moriyoshi Koizumi <mozo@mozo.jp>
X-From: git-owner@vger.kernel.org Thu Jan 29 15:10:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSXb3-0006dv-JR
	for gcvg-git-2@gmane.org; Thu, 29 Jan 2009 15:10:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752663AbZA2OIz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Jan 2009 09:08:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752651AbZA2OIz
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Jan 2009 09:08:55 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:65013 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751601AbZA2OIy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jan 2009 09:08:54 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1LSXZa-0002FN-KO; Thu, 29 Jan 2009 15:08:50 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 5996B6EF; Thu, 29 Jan 2009 15:08:50 +0100 (CET)
User-Agent: Thunderbird 2.0.0.18 (Windows/20081105)
In-Reply-To: <4981B6E6.6020502@mozo.jp>
X-Enigmail-Version: 0.95.5
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107680>

Moriyoshi Koizumi schrieb:
> Johannes Sixt wrote:
>> Moriyoshi Koizumi schrieb:
>>> @@ -210,6 +272,20 @@ static CURL* get_curl_handle(void)
>>>  	if (curl_http_proxy)
>>>  		curl_easy_setopt(result, CURLOPT_PROXY, curl_http_proxy);
>> CURLOPT_PROXY is set here...
> 
> As I wrote in the previous post, this part was from the original.
> 
>>>  
>>> +	if (curl_http_auth) {
>>> +		long n = get_curl_auth_bitmask(curl_http_auth);
>>> +		curl_easy_setopt(result, CURLOPT_HTTPAUTH, n);
>>> +	}
> 
>> ... and here again. Is that necessary?
> 
> What part do you mean by that?

Oops, sorry, I cut too much from your patch:

> +	if (curl_http_auth) {
> +		long n = get_curl_auth_bitmask(curl_http_auth);
> +		curl_easy_setopt(result, CURLOPT_HTTPAUTH, n);
> +	}
> +
> +	if (curl_http_proxy) {
> +		curl_easy_setopt(result, CURLOPT_PROXY, curl_http_proxy);

Here you set CURLOPT_PROXY again.

-- Hannes
