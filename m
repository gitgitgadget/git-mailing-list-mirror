From: Nelson Benitez Leon <nelsonjesus.benitez@seap.minhap.es>
Subject: Re: [PATCH v3 2/4] http: try http_proxy env var when http.proxy config
 option is not set
Date: Tue, 06 Mar 2012 15:08:47 +0100
Message-ID: <4F561A6F.2040206@seap.minhap.es>
References: <4F54D91C.6080905@seap.minhap.es><7v4nu32bwp.fsf@alter.siamese.dyndns.org><4F560196.8070500@seap.minhap.es> <20120306112745.GA6733@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	sam@vilain.net
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Mar 06 14:11:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S4uAh-0003EW-K7
	for gcvg-git-2@plane.gmane.org; Tue, 06 Mar 2012 14:11:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758217Ab2CFNLM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Mar 2012 08:11:12 -0500
Received: from luthien2.mpt.es ([82.150.0.102]:9009 "EHLO luthien2.map.es"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752264Ab2CFNLL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Mar 2012 08:11:11 -0500
Received: from correo.map.es (unknown [10.1.31.23])
	by luthien2.map.es (Postfix) with ESMTP id 7333824E98;
	Tue,  6 Mar 2012 14:10:12 +0100 (CET)
Received: from [10.47.128.147] (unknown [10.1.29.79])
	by correo.map.es (Postfix) with ESMTP id 846E520386F;
	Tue,  6 Mar 2012 14:10:08 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:10.0.1) Gecko/20120216 Thunderbird/10.0.1
In-Reply-To: <20120306112745.GA6733@sigill.intra.peff.net>
X-map-MapScanner: Libre de virus, Libre de virus
X-Spam-Status: No, No
X-map-MapScanner-Information: 
X-map-MapScanner-ID: 7333824E98.17D17
X-map-MapScanner-From: nelsonjesus.benitez@seap.minhap.es
X-map-MailScanner-Watermark: 1331644214.18025@0lP4JLoBCxbCC0JmLcvcsQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192342>

On 03/06/2012 12:27 PM, Jeff King wrote:
> On Tue, Mar 06, 2012 at 01:22:46PM +0100, Nelson Benitez Leon wrote:
> 
>>> Also I thought the conclusion from the other thread was that even if
>>> we were to do this, we should apply the http_proxy environment only
>>> when we are talking to http:// and for https:// we would instead
>>> read HTTPS_PROXY or something?
>>
>> Ok I completely miss this, can this be added in a later patch?
> 
> Hmm. Your current series munges the curl_http_proxy variable in order to
> put the username and password in, and therefore needs to know what is in
> the proxy variable.
> 
> But if you switch patch 4/4 to set CURLOPT_PROXYUSERPWD, then we won't
> need to care what's in curl_http_proxy, no? We will get a 407 from curl
> because curl detected the proxy (either from the environment, or because
> we actually told it via curl_http_proxy), and then we will fill in the
> username and password without touching the actual proxy URL.
> 
> So this patch can just be dropped at that point, right?

I think so, I will try 4/4 using proxyuserpwd.
