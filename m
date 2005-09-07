From: Mark Allen <mrallen1@yahoo.com>
Subject: Re: [PATCH] Add $(LIBS) and set libiconv in tools/Makefile for Darwin
Date: Wed, 7 Sep 2005 08:01:02 -0700 (PDT)
Message-ID: <20050907150103.11609.qmail@web34311.mail.mud.yahoo.com>
References: <7v8xy9bfaj.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Wed Sep 07 17:01:50 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ED1QO-00064w-QL
	for gcvg-git@gmane.org; Wed, 07 Sep 2005 17:01:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932155AbVIGPBP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Sep 2005 11:01:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932157AbVIGPBP
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Sep 2005 11:01:15 -0400
Received: from web34311.mail.mud.yahoo.com ([66.163.178.143]:36247 "HELO
	web34311.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932155AbVIGPBN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Sep 2005 11:01:13 -0400
Received: (qmail 11611 invoked by uid 60001); 7 Sep 2005 15:01:03 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=4Tg+nDVI2bT5fQnLLI9gdrYeuNSMQKZvvwvhhGs3pktj7J1T9fnihMT+4mKGtyy/y2qBmHPhDaswJtoMewzzTtM/zg4a6mcN/n4SZKO22PzNhYaRYRSNpPFyJzTvLCmkMkLp1nS3W3gMDZlJpr7JQNUcs0g4xk6vB7tUHOQ5bjM=  ;
Received: from [65.173.207.2] by web34311.mail.mud.yahoo.com via HTTP; Wed, 07 Sep 2005 08:01:02 PDT
To: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
In-Reply-To: <7v8xy9bfaj.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8168>

--- Junio C Hamano <junkio@cox.net> wrote:
> I'd do this slightly differently.  Could you take a look at what
> I have in the "proposed updates" branch, especially "Flatten
> tools/ directory" commit?  What I am aiming for is to have
> platform specific ifeq() thing in only one place.

Looks good to me, Junio.  There's a very small typo in your commit though. :-)

Cheers,

--Mark

---

diff --git a/Makefile b/Makefile
--- a/Makefile
+++ b/Makefile
@@ -149,7 +149,7 @@ else
        MOZILLA_SHA1=1
        OPENSSL_LIBSSL=
 endif
-ifdef NEEDS_SSL_WITH_CRIPTO
+ifdef NEEDS_SSL_WITH_CRYPTO
        LIB_4_CRYPTO = -lcrypto -lssl
 else
        LIB_4_CRYPTO = -lcrypto
