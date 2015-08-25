From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] compat/inet_ntop.c: Use INET_ADDRSTRLEN and
 INET6_ADDRSTRLEN macroses
Date: Tue, 25 Aug 2015 14:13:32 +0200
Organization: gmx
Message-ID: <9f870e741fc573934ebfe40cd73aba81@www.dscho.org>
References: <1440498879-12382-1-git-send-email-brilliantov@inbox.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: brilliantov@inbox.ru
X-From: git-owner@vger.kernel.org Tue Aug 25 14:13:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZUD6j-0000mA-67
	for gcvg-git-2@plane.gmane.org; Tue, 25 Aug 2015 14:13:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754619AbbHYMNh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Aug 2015 08:13:37 -0400
Received: from mout.gmx.net ([212.227.17.22]:50662 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751726AbbHYMNg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Aug 2015 08:13:36 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0MfzEP-1Z7Iu81b7N-00NTkQ; Tue, 25 Aug 2015 14:13:33
 +0200
In-Reply-To: <1440498879-12382-1-git-send-email-brilliantov@inbox.ru>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.2
X-Provags-ID: V03:K0:MbOFwJLW3QDv0v/+YSQmJiudHLxRbFn4mfr7hUoO9bspd9xvuQr
 qh4RMydZZGgxMQYADLKlfBZVhVvkvhy/xzXZ1ABOANFlm5XPBgWCzOh4VY2oRlX57qvd4Bq
 /7L7+l4oaXNTsilaqRoy4aSNnlgXzadSkjNlRsHGt61QHotjnMBsWO+nRojvORlCDoo/w/w
 JpoBh9v4xbOUySjnawLtA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ZMRiQpvsUZU=:/cDhhzTZO8EZB03IebA7bB
 MUvdS6ZYMDnJ2pVfRuFtyOsFzCxuAfPJ7B35+DFCVAbDSMNolGcHPFj2W2R0Qko+gk/W7haph
 5jqLdGkqoFxJv1AJiEmoCfJRV3s+6m0DC7PXgsIfENqF6AqB3EBl/2h6A4PxDpmmVCcixhxOA
 HfXdE6Uhc4NSosi54LyGQBv4pt/iLUZLDqSsFuYV6B935Aq6w/6prP6qwoB3OnLG0AXP9A9r/
 AJlETKAnitTSz1CXsO0mO3cCzdcP2X4IE7X8uYFIe4WVq/pR18vtzuS1rpB8u95nayb6VQvao
 0LYXPhmr9qBODcw8l2+WDKtziTJqnuqJMKTu8vi65sCOH19G184qGI9A8QD8NAgTIXjuAxJVw
 DsQKzZKZZ29UCCYYcOU/gMRqRay8nFClnTl+pOHYlh11oLVTST96nn9cXXW1zSn5jkXseKxfu
 kNxf8x2Nl5MRESQsTGQ9nOb2kM0U/NRULkWdh6YzQNU5paK8xVXeCAkCHMN9KniSI+3b53d8a
 MPZqErLqNvVA1dTXzpufeLaNJD2WxW6KTU9kAfrcSbcZVBxTt4OgGuUX+VY5vNtRD82xFwOHY
 23TukBmMrDHWveBROECA/iIsV9ZgY/rYFvEd1zM/3QsY5zkbt96gMNjTouHG9HtTUEmuORNRO
 +CQ21Zc1ZfT56BrYYoUv429M0g9lN4xiAkBNtkePxpCYrR4afMzLB4qXb48pGHfczBMBd2oOq
 6Um2RZYNc4LJMVu6GlRfGacjtpC8vm9MDM9K8g==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276520>

Hi Kirill,

On 2015-08-25 12:34, brilliantov@inbox.ru wrote:
> From: Brilliantov Kirill Vladimirovich <brilliantov@inbox.ru>
> 
> Signed-off-by: Brilliantov Kirill Vladimirovich <brilliantov@inbox.ru>

The commit message makes for an excellent place to fill in the reader on information that is not obvious from reading the patch. For example...

> diff --git a/compat/inet_ntop.c b/compat/inet_ntop.c
> index 90b7cc4..fcd3b15 100644
> --- a/compat/inet_ntop.c
> +++ b/compat/inet_ntop.c
> @@ -47,7 +47,7 @@ static const char *
>  inet_ntop4(const u_char *src, char *dst, size_t size)
>  {
>  	static const char fmt[] = "%u.%u.%u.%u";
> -	char tmp[sizeof "255.255.255.255"];
> +	char tmp[INET_ADDRSTRLEN];

Given that we are in compat/ space, i.e. in a space meant for platforms lacking POSIX functions and definitions, is it really safe to assume that INET_ADDRSTRLEN is available there?

> @@ -78,7 +78,7 @@ inet_ntop6(const u_char *src, char *dst, size_t size)
>  	 * Keep this in mind if you think this function should have been coded
>  	 * to use pointer overlays.  All the world's not a VAX.
>  	 */
> -	char tmp[sizeof "ffff:ffff:ffff:ffff:ffff:ffff:255.255.255.255"], *tp;
> +	char tmp[INET6_ADDRSTRLEN], *tp;

Are we really, absolutely sure that INET6_ADDRSTRLEN is defined?

Also I wonder: what problem does this patch solve? Is the current way to determine the size of the `tmp` array incorrect?

Please use the commit message space to answer at least these questions.

Ciao,
Johannes
