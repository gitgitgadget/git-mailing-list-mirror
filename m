From: "Kyle J. McKay" <mackyle@gmail.com>
Subject: Re: [PATCH] test-url-normalize.c: Fix gcc errors and sparse warnings
Date: Wed, 24 Jul 2013 12:35:50 -0700
Message-ID: <FDCB9C95-34A7-45D8-AC23-9739C24043B5@gmail.com>
References: <51F0260B.5000905@ramsay1.demon.co.uk>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 24 21:35:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V24qs-0001qR-29
	for gcvg-git-2@plane.gmane.org; Wed, 24 Jul 2013 21:35:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752737Ab3GXTfy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Jul 2013 15:35:54 -0400
Received: from mail-pd0-f181.google.com ([209.85.192.181]:64969 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751800Ab3GXTfx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Jul 2013 15:35:53 -0400
Received: by mail-pd0-f181.google.com with SMTP id g12so257777pdj.26
        for <git@vger.kernel.org>; Wed, 24 Jul 2013 12:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:in-reply-to:subject:references:message-id:content-type
         :content-transfer-encoding:mime-version:date:cc:x-mauler;
        bh=Lh2lhNx/hTAKx9m5YkiOxtIVXs9OYrqgNdZoE7dND8o=;
        b=uxNYUcI3e47KaGrstUPWhTA1BsSHZ9Jr6TKuAVc1bzMMC8RO2Pts3LC1ZFGgOsjzeU
         GzUOsEx2cqlfroRW6G0xlRix01uJ9goHFe6moV7vBDWgW1wB1fxircCMbc/HZISltYJA
         JVLCuRQwQfyNortfe7tWqRxHaAvnfuK1wQcUX9NEcQhI2IUQxahtbXp/BT2XLr9Uobml
         FbCAcXC2lUEVp/wBKZL3Pe1f7cvP8qxpwK/+FqvaTk+8uHp7x69ZEEpb0wr3SojC1k8c
         dyZ7EYLwBmMyIUdJ12swIF2FNIYVDTatQ7HjEkV5S1eL3idUH3all6Ne//liySpTbt9t
         9P9g==
X-Received: by 10.68.203.105 with SMTP id kp9mr44481274pbc.78.1374694552881;
        Wed, 24 Jul 2013 12:35:52 -0700 (PDT)
Received: from [172.16.16.105] (ip72-192-173-141.sd.sd.cox.net. [72.192.173.141])
        by mx.google.com with ESMTPSA id jf4sm49514314pbb.19.2013.07.24.12.35.51
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 24 Jul 2013 12:35:51 -0700 (PDT)
In-Reply-To: <51F0260B.5000905@ramsay1.demon.co.uk>
X-Mauler: Craptastic (2.936)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231115>

On Jul 24, 2013, at 12:07, Ramsay Jones wrote:

>
> Sparse issues an "non-ANSI function declaration of function 'main'"
> warning when NO_CURL is set. In order to suppress the warning, we
> simply add the function prototype.
>
> When NO_CURL and USE_CURL_MULTI are not defined, then gcc issues the
> following error:
>
>      CC test-url-normalize.o
>  test-url-normalize.c: In function `run_http_options':
>  test-url-normalize.c:49: error: `max_requests' undeclared (first  
> use in this function)
>  test-url-normalize.c:49: error: (Each undeclared identifier is  
> reported only once
>  test-url-normalize.c:49: error: for each function it appears in.)
>  make: *** [test-url-normalize.o] Error 1
>
> In order to fix the error, we simply protect the use of the  
> 'max_requests'
> variable with an preprocessor conditional.
>
> Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
> ---
>
> Hi Kyle,
>
> When you next update the patches in your 'km/http-curl-config-per-url'
> branch, could you please squash this (or something like it) into the
> relevant patches.
>
> Thanks!
>
> ATB,
> Ramsay Jones

Thanks.

And hopefully Junio can add this as an incremental patch against next  
as it looks good to me.
