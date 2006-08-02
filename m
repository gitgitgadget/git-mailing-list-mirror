From: Rocco Rutte <pdmef@gmx.net>
Subject: Re: [PATCH 8/10] Fix some minor warnings to allow -Werror.
Date: Wed, 2 Aug 2006 08:53:30 +0000
Organization: Berlin University of Technology
Message-ID: <20060802085330.GA6595@peter.daprodeges.fqdn.th-h.de>
References: <00be01c6b5cf$7f7e9e20$c47eedc1@ramsay1.demon.co.uk> <7vvepbvauo.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
X-From: git-owner@vger.kernel.org Wed Aug 02 10:53:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G8CU3-00023L-J6
	for gcvg-git@gmane.org; Wed, 02 Aug 2006 10:53:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932076AbWHBIxf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 2 Aug 2006 04:53:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932077AbWHBIxf
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Aug 2006 04:53:35 -0400
Received: from mail.gmx.de ([213.165.64.21]:54657 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932076AbWHBIxe (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 2 Aug 2006 04:53:34 -0400
Received: (qmail invoked by alias); 02 Aug 2006 08:53:33 -0000
Received: from cable-62-117-23-3.cust.blue-cable.de (EHLO peter.daprodeges.fqdn.th-h.de) [62.117.23.3]
  by mail.gmx.net (mp029) with SMTP; 02 Aug 2006 10:53:33 +0200
X-Authenticated: #1642131
Received: from peter.daprodeges.fqdn.th-h.de (peter [192.168.0.5])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by peter.daprodeges.fqdn.th-h.de (Postfix) with ESMTP id 1051D20F01
	for <git@vger.kernel.org>; Wed,  2 Aug 2006 08:53:32 +0000 (UTC)
To: git@vger.kernel.org
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7vvepbvauo.fsf@assigned-by-dhcp.cox.net>
X-GnuPG-Key: http://user.cs.tu-berlin.de/~pdmef/rrutte.gpg
X-Blog: http://user.cs.tu-berlin.de/~pdmef/horst.cgi?o
X-System: peter.daprodeges.fqdn.th-h.de (FreeBSD 6.1-STABLE i386)
User-Agent: Mutt/1.5.12-pdmef (2006-07-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24640>

Hi,

* Junio C Hamano [06-08-02 00:46:23 -0700] wrote:

[...]

>This kills the compilation with:
>
>gcc -o builtin-mailinfo.o -c -O2 -Werror -ansi -pedantic -std=c99 -D_XOPEN_SOURCE=500 -D_BSD_SOURCE -Wall -Wdeclaration-after-statement -g -DSHA1_HEADER='<openssl/sha.h>' -DNO_STRLCPY builtin-mailinfo.c
>cc1: warnings being treated as errors
>builtin-mailinfo.c: In function 'convert_to_utf8':
>builtin-mailinfo.c:561: warning: passing argument 2 of 'iconv' from incompatible pointer type
>
>where the line 561 reads:
>
>	nrc = iconv(conv, &in, &insize, &out, &outsize);

It depends on the iconv() implementation as what the input pointer is 
defined: some use just 'char*' while others use 'const char*' (GNU 
libiconv IIRC).

   bye, Rocco
-- 
:wq!
