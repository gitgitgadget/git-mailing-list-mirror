From: Daniel Stenberg <daniel@haxx.se>
Subject: Re: https_proxy and libcurl
Date: Fri, 22 Feb 2013 23:09:39 +0100 (CET)
Message-ID: <alpine.DEB.2.00.1302222306130.27393@tvnag.unkk.fr>
References: <CABURp0qQ6tO0B4Ya6OStX59SJqG-Jx1F4g6MUL7tVwR_6VgDhw@mail.gmail.com> <7v7gm0c8ub.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Phil Hord <phil.hord@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 22 23:24:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U912x-0005I3-8Y
	for gcvg-git-2@plane.gmane.org; Fri, 22 Feb 2013 23:24:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757208Ab3BVWY1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Feb 2013 17:24:27 -0500
Received: from giant.haxx.se ([80.67.6.50]:48057 "EHLO giant.haxx.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756912Ab3BVWY0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Feb 2013 17:24:26 -0500
X-Greylist: delayed 874 seconds by postgrey-1.27 at vger.kernel.org; Fri, 22 Feb 2013 17:24:25 EST
Received: from giant.haxx.se (localhost.localdomain [127.0.0.1])
	by giant.haxx.se (8.14.4/8.14.4/Debian-2) with ESMTP id r1MM9da0012542
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 22 Feb 2013 23:09:39 +0100
Received: from localhost (dast@localhost)
	by giant.haxx.se (8.14.4/8.14.4/Submit) with ESMTP id r1MM9du8012537;
	Fri, 22 Feb 2013 23:09:39 +0100
X-Authentication-Warning: giant.haxx.se: dast owned process doing -bs
X-X-Sender: dast@giant.haxx.se
In-Reply-To: <7v7gm0c8ub.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
X-fromdanielhimself: yes
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216869>

On Fri, 22 Feb 2013, Junio C Hamano wrote:

>>     http_proxy=http://proxy.myco.com
>>     https_proxy=https://proxy.myco.com
>>
>> The problem is that libcurl ignores the protocol part of the proxy
>> url, and it defaults to port 1080. wget honors the protocol specifier,
>> but it defaults to port 80 if none is given.
>
> IIRC, the historical norm is to set these to <host>:<port>.
>
> So many people mistakenly write them with <method>:// that some tools over 
> time learned to strip and ignore that prefix, though.

You're right, but also what exactly is the https:// _to_ the proxy supposed to 
mean? The standard procedure to connect to a proxy when communicating with 
either HTTP or HTTPS is using plain HTTP.

If you would want port 443 for a HTTPS connection to a proxy, you'd use:

   https_proxy=http://proxy.myco.com:443

Or without the ignore protocol prefix:

   https_proxy=proxy.myco.com:443

-- 

  / daniel.haxx.se
