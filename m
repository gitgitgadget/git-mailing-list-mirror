From: Brian Gernhardt <brian@gernhardtsoftware.com>
Subject: Re: [PATCH] Makefile: Add NEEDS_CRYPTO_WITH_SSL
Date: Mon, 24 Aug 2009 10:22:26 -0400
Message-ID: <4E04F1F2-132A-4695-BCFF-C1F3159671AF@gernhardtsoftware.com>
References: <1250354813-81349-1-git-send-email-brian@gernhardtsoftware.com> <81b0412b0908240245l33b04322l923084362197406a@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 24 16:22:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MfaRS-0006Zm-HI
	for gcvg-git-2@lo.gmane.org; Mon, 24 Aug 2009 16:22:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752604AbZHXOW2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Aug 2009 10:22:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752600AbZHXOW2
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Aug 2009 10:22:28 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:38475 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752598AbZHXOW1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Aug 2009 10:22:27 -0400
Received: by silverinsanity.com (Postfix, from userid 5001)
	id 67F181FFC08B; Mon, 24 Aug 2009 14:22:26 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on silverinsanity.com
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=4.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.5
Received: from [192.168.1.3] (cpe-67-240-168-84.rochester.res.rr.com [67.240.168.84])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTPSA id 6A9061FFC080;
	Mon, 24 Aug 2009 14:22:24 +0000 (UTC)
In-Reply-To: <81b0412b0908240245l33b04322l923084362197406a@mail.gmail.com>
X-Mailer: Apple Mail (2.936)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126930>


On Aug 24, 2009, at 5:45 AM, Alex Riesen wrote:

> As imap-send is the only one which uses the symbols, why not just add
> LIB_4_CRYPTO
> to its linking command? Like in the broken GMail-patch below:

I didn't do this because I didn't know if all platforms needed  
libcrypto to compile imap-send.  If it is, then this is obviously the  
simpler solution.

> diff --git a/Makefile b/Makefile
> index 02ff867..33971f3 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1503,7 +1503,7 @@ git-%$X: %.o $(GITLIBS)
>
> git-imap-send$X: imap-send.o $(GITLIBS)
> 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o, 
> $^) \
> -		$(LIBS) $(OPENSSL_LINK) $(OPENSSL_LIBSSL)
> +		$(LIBS) $(OPENSSL_LINK) $(OPENSSL_LIBSSL) $(LIB_4_CRYPTO)
>
> http.o http-walker.o http-push.o: http.h
