From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
Subject: Re: cvsimport weird
Date: Thu, 18 May 2006 14:56:59 +0900 (JST)
Organization: USAGI/WIDE Project
Message-ID: <20060518.145659.76628953.yoshfuji@linux-ipv6.org>
References: <46a038f90605171954n7e75ee64t412b22e8d405d909@mail.gmail.com>
	<1147924771.32050.40.camel@dv>
	<1147931094.32050.51.camel@dv>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: martin.langhoff@gmail.com, beber.mailing@gmail.com,
	git@vger.kernel.org, yoshfuji@linux-ipv6.org
X-From: git-owner@vger.kernel.org Thu May 18 07:56:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FgbV3-0004aR-Hr
	for gcvg-git@gmane.org; Thu, 18 May 2006 07:56:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750752AbWERF4i (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 18 May 2006 01:56:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751237AbWERF4i
	(ORCPT <rfc822;git-outgoing>); Thu, 18 May 2006 01:56:38 -0400
Received: from yue.linux-ipv6.org ([203.178.140.15]:18700 "EHLO
	yue.st-paulia.net") by vger.kernel.org with ESMTP id S1750752AbWERF4i
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 May 2006 01:56:38 -0400
Received: from localhost (localhost [127.0.0.1])
	by yue.st-paulia.net (Postfix) with ESMTP
	id 3361D33CC2; Thu, 18 May 2006 14:57:00 +0900 (JST)
To: proski@gnu.org
In-Reply-To: <1147931094.32050.51.camel@dv>
X-URL: http://www.yoshifuji.org/%7Ehideaki/
X-Fingerprint: 9022 65EB 1ECF 3AD1 0BDF  80D8 4807 F894 E062 0EEA
X-PGP-Key-URL: http://www.yoshifuji.org/%7Ehideaki/hideaki@yoshifuji.org.asc
X-Face: "5$Al-.M>NJ%a'@hhZdQm:."qn~PA^gq4o*>iCFToq*bAi#4FRtx}enhuQKz7fNqQz\BYU]
 $~O_5m-9'}MIs`XGwIEscw;e5b>n"B_?j/AkL~i/MEa<!5P`&C$@oP>ZBLP
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.1 (AOI)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20262>

In article <1147931094.32050.51.camel@dv> (at Thu, 18 May 2006 01:44:54 -0400), Pavel Roskin <proski@gnu.org> says:

> Address resolution is broken in cvsps on 64-bit machines.  This patch to
> cvsps is needed:
> 
> --- cbtcommon/tcpsocket.c
> +++ cbtcommon/tcpsocket.c
> @@ -198,7 +198,7 @@ convert_address(long *dest, const char *
>      memcpy(dest, &ip.s_addr, sizeof(ip.s_addr));
>    }
>  #else
> -  if ( (*dest = inet_addr(addr_str)) != -1)
> +  if ( (*dest = inet_addr(addr_str)) != INADDR_NONE)
>    {
>      /* nothing */
>    }

You need to define INADDR_NONE on some platforms; e.g. Solaris.

--yoshfuji
