From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: How to run http server tests?
Date: Wed, 14 Dec 2011 23:02:38 +0100
Message-ID: <4EE91CFE.4070807@kdbg.org>
References: <4EE91307.6080504@kdbg.org> <20111214213952.GA11519@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Dec 14 23:02:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RawuV-0007Ox-Hj
	for gcvg-git-2@lo.gmane.org; Wed, 14 Dec 2011 23:02:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758228Ab1LNWCm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Dec 2011 17:02:42 -0500
Received: from bsmtp4.bon.at ([195.3.86.186]:42824 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1758213Ab1LNWCm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Dec 2011 17:02:42 -0500
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id EF589130049;
	Wed, 14 Dec 2011 23:02:40 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id AD4B419F3B8;
	Wed, 14 Dec 2011 23:02:38 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; de; rv:1.9.2.24) Gecko/20111101 SUSE/3.1.16 Thunderbird/3.1.16
In-Reply-To: <20111214213952.GA11519@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187171>

Am 14.12.2011 22:39, schrieb Jeff King:
> On Wed, Dec 14, 2011 at 10:20:07PM +0100, Johannes Sixt wrote:
>> diff --git a/t/lib-httpd/apache.conf b/t/lib-httpd/apache.conf
>> index 0a4cdfa..e5cb3f9 100644
>> --- a/t/lib-httpd/apache.conf
>> +++ b/t/lib-httpd/apache.conf
>> @@ -13,4 +13,4 @@ ErrorLog error.log
>>  </IfModule>
>> -<IfModule !mod_cgi.c>
>> -       LoadModule cgi_module modules/mod_cgi.so
>> +<IfModule !mod_scgi.c>
>> +       LoadModule scgi_module modules/mod_scgi.so
>>  </IfModule>
> 
> Hmm. I know nothing about scgi, but a quick google indicates that it is
> a separate protocol from CGI and is more like FastCGI (i.e., it wants to
> spawn a long-running CGI server and contact it over a separate
> protocol).
> 
> So I suspect you are not able to run http-backend, and thus you have no
> smart-http support in your setup.

Thanks, that put me on the right track. I have to use

  LIB_HTTPD_MODULE_PATH=/usr/lib64/apache2-prefork

-- Hannes
