From: Timo Hirvonen <tihirvon@gmail.com>
Subject: Re: 1.3.2.gde1d fails to build on OpenBSD
Date: Mon, 15 May 2006 18:58:19 +0300
Message-ID: <20060515185819.ff05f6fe.tihirvon@gmail.com>
References: <86psiftlgf.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 15 17:57:01 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FffR4-00039v-8O
	for gcvg-git@gmane.org; Mon, 15 May 2006 17:56:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751585AbWEOP4j (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 15 May 2006 11:56:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751586AbWEOP4j
	(ORCPT <rfc822;git-outgoing>); Mon, 15 May 2006 11:56:39 -0400
Received: from nf-out-0910.google.com ([64.233.182.186]:60011 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751583AbWEOP4i (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 May 2006 11:56:38 -0400
Received: by nf-out-0910.google.com with SMTP id o25so95337nfa
        for <git@vger.kernel.org>; Mon, 15 May 2006 08:56:36 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=nCNdp8jCrZdy2O40EX+7hwN3qEEs8RJJSQFZDLX9C+mWl7ld8o0X5MsLGNFN6phay2d5jzboPhQ5jEx9sR4kgYUbGp4ySOqqEDY5tEl14U+hVw99UW0m4Pcq7Tj0mCMbr3STOOfS6jYpkXrfQ9T7BmfEsmUleN1QR5HnqychDiQ=
Received: by 10.48.217.20 with SMTP id p20mr3721868nfg;
        Mon, 15 May 2006 08:56:34 -0700 (PDT)
Received: from garlic.home.net ( [82.128.200.31])
        by mx.gmail.com with ESMTP id l21sm3626745nfc.2006.05.15.08.56.32;
        Mon, 15 May 2006 08:56:33 -0700 (PDT)
To: merlyn@stonehenge.com
In-Reply-To: <86psiftlgf.fsf@blue.stonehenge.com>
X-Mailer: Sylpheed version 2.2.3 (GTK+ 2.8.17; i686-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20060>

merlyn@stonehenge.com (Randal L. Schwartz) wrote:

> 
> GIT_VERSION = 1.3.2.gde1d
> gcc -o sha1_file.o -c -g -O2 -Wall -I/usr/local/include -DSHA1_HEADER='<openssl/sha.h>' -DNO_STRCASESTR sha1_file.c
> sha1_file.c:16:20: stdint.h: No such file or directory
> gmake: *** [sha1_file.o] Error 1
> 
> I think you want
> 
>         #include <sys/types.h>
> 
> on OpenBSD.

I think it should be #include <inttypes.h>.  It works at least on BSD
and Linux.

-- 
http://onion.dynserv.net/~timo/
