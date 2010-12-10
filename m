From: "J.H." <warthog9@eaglescrag.net>
Subject: Re: [PATCH 00/18] Gitweb caching v8
Date: Thu, 09 Dec 2010 16:45:30 -0800
Message-ID: <4D01782A.5060702@eaglescrag.net>
References: <1291931844-28454-1-git-send-email-warthog9@eaglescrag.net> <7vsjy6ea0k.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 10 01:43:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQr5U-0007rt-G6
	for gcvg-git-2@lo.gmane.org; Fri, 10 Dec 2010 01:43:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756765Ab0LJAnr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Dec 2010 19:43:47 -0500
Received: from shards.monkeyblade.net ([198.137.202.13]:42320 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757540Ab0LJAnr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Dec 2010 19:43:47 -0500
Received: from voot-cruiser.eaglescrag.net (c-71-202-185-40.hsd1.ca.comcast.net [71.202.185.40])
	(authenticated bits=0)
	by shards.monkeyblade.net (8.14.4/8.14.3) with ESMTP id oBA0hhUK010286
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256 verify=NO);
	Thu, 9 Dec 2010 16:43:44 -0800
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.95.3 at shards.monkeyblade.net
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.15) Gecko/20101027 Fedora/3.0.10-1.fc12 Lightning/1.0b2pre Thunderbird/3.0.10
In-Reply-To: <7vsjy6ea0k.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.0.1
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.2.3 (shards.monkeyblade.net [198.137.202.13]); Thu, 09 Dec 2010 16:43:44 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163371>

On 12/09/2010 04:39 PM, Junio C Hamano wrote:
> It seems that t950X tests do not like me.  I am getting these in gitweb.body:
> 
>     <!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www/w3.porg/TR/html4/strict.dtd">
>     <!-- git web w/caching interface version current, (C) 2006-2010, John 'Warthog9' Hawley <warthog9@kernel.org> -->
>     <!-- git core binaries version 1.7.3.3.494.gcf92e -->
>     <head>
>     <meta http-equiv="content-type" content="; charset=utf-8"/>
>     <meta name="generator" content="gitweb/current git/1.7.3.3.494.gcf92e"/>
>     <meta name="robots" content="index, nofollow"/>
>     <meta http-equiv="refresh" content="10"/>
>     <title></title>
>     </head>
>     <body>
>     &lt;p&gt;&lt;strong&gt;*** Warning ***:&lt;/strong&gt; Caching enabled but cache directory did not exsist.  (cache)&lt;br/&gt;/<span class="cntrl">\n</span>Cache directory created successfully<span class="cntrl">\n</span>&lt;p&gt;
>     </body>
>     </html>

caching directory didn't exist prior to running the test, and so it
throws the warning that it needed to create it.  The cache directory
should likely be created before caching tests.

(Sorry, didn't catch that one as I've already got my caching directory
created, and it doesn't really get deleted)

- John 'Warthog9' Hawley
