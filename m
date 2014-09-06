From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <l.s.r@web.de>
Subject: Re: [RFC PATCH 2/2] headers: include dependent headers
Date: Sat, 06 Sep 2014 23:20:35 +0200
Message-ID: <540B7AA3.1090201@web.de>
References: <1410031211-14599-1-git-send-email-davvid@gmail.com> <1410031211-14599-2-git-send-email-davvid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
To: David Aguilar <davvid@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 06 23:21:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XQNPk-0002fk-Af
	for gcvg-git-2@plane.gmane.org; Sat, 06 Sep 2014 23:20:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751930AbaIFVUw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Sep 2014 17:20:52 -0400
Received: from mout.web.de ([212.227.15.3]:61239 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751532AbaIFVUv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Sep 2014 17:20:51 -0400
Received: from [192.168.178.27] ([79.253.165.27]) by smtp.web.de (mrweb004)
 with ESMTPSA (Nemesis) id 0MTuQz-1XqOju359t-00Qm5T; Sat, 06 Sep 2014 23:20:47
 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.1.0
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <1410031211-14599-2-git-send-email-davvid@gmail.com>
X-Provags-ID: V03:K0:gnxLHi94ND9bmR5hOE+UOaHfll1pmim7Bb4H2qzhFMDNBcoY3Jc
 mQTIJxs7zQXSANtqSj/Em8lhx3lUxkIo4T0DPX2/EcwsKqaj2JBQBQHWhWIuFVYQYds6T4Q
 CO7xRpBUlHnL829Z868Bzs40TvAGUPboly9M44sITXbfmlRnMurlssTeHmYFLXkwa7rOP4j
 0we/qfPo0HaBPuc1pzSKw==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256604>

Am 06.09.2014 um 21:20 schrieb David Aguilar:
> Add dependent headers so that including a header does not
> require including additional headers.
>
> This makes it so that "gcc -c $header" succeeds for each header.
>
> Signed-off-by: David Aguilar <davvid@gmail.com>
> ---

> diff --git a/branch.h b/branch.h
> index 64173ab..a61fd1a 100644
> --- a/branch.h
> +++ b/branch.h
> @@ -3,6 +3,9 @@
>
>   /* Functions for acting on the information about branches. */
>
> +#include "cache.h"
> +#include "strbuf.h"

cache.h includes strbuf.h, so the line above isn't necessary.
