From: Markus Hitter <mah@jump-ing.de>
Subject: Re: Git on Mac OS X 10.4.10
Date: Fri, 15 Aug 2014 14:34:12 +0200
Message-ID: <53EDFE44.6000800@jump-ing.de>
References: <53ECA7DB.7060407@jump-ing.de> <53ECCA14.40900@web.de> <53ED0257.3070505@jump-ing.de> <xmqqppg21wyk.fsf@gitster.dls.corp.google.com> <273241271546c07e692ae93774993f5@74d39fa044aa309eaea14b9f57fe79c>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Kyle J. McKay" <mackyle@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 15 14:34:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XIGi6-0005qu-3d
	for gcvg-git-2@plane.gmane.org; Fri, 15 Aug 2014 14:34:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750970AbaHOMeP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Aug 2014 08:34:15 -0400
Received: from ud03.udmedia.de ([194.117.254.43]:52864 "EHLO
	mail.ud03.udmedia.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750824AbaHOMeP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Aug 2014 08:34:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=mail.ud03.udmedia.de; h=
	message-id:date:from:mime-version:to:cc:subject:references
	:in-reply-to:content-type:content-transfer-encoding; s=beta; bh=
	119Yyj9u6oXeVskJTNODVoJnZcHjW+Ckx+B6JeScuAM=; b=DJHMB3Qy6v1x/RO1
	bXE+sgwViHsBlmpa1asgx+aIhQXBuwsM4DQZzj0lKi5LEmLSzLF7U6pz4ritcUlY
	aDQqcrPIzLKGAEZ6GQ6ZXNu0riV5O7G3EUl7q39etk7XynZBSbvZ7wBKBhSTg5Xm
	+uhL36UdnWowXVdRb6fvFBx5avk=
Received: (qmail 3497 invoked from network); 15 Aug 2014 14:34:13 +0200
Received: from unknown (HELO ?10.0.0.102?) (ud03?291p1@134.3.201.241)
  by mail.ud03.udmedia.de with ESMTPSA (DHE-RSA-AES128-SHA encrypted, authenticated); 15 Aug 2014 14:34:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.0
In-Reply-To: <273241271546c07e692ae93774993f5@74d39fa044aa309eaea14b9f57fe79c>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255287>

Am 15.08.2014 um 09:46 schrieb Kyle J. McKay:
> The below patch does the right thing.  Conveniently there's already
> a test for 10.4 and earlier so only a single line need be added.

I can confirm this patch works. Thank you very much.


> ---- 8< ----
> Subject: [PATCH] config.mak.uname: set NO_APPLE_COMMON_CRYPTO on older systems
> 
> Older MacOS systems prior to 10.5 do not have the CommonCrypto
> support Git uses so set NO_APPLE_COMMON_CRYPTO on those systems.
> 
> Signed-off-by: Kyle J. McKay <mackyle@gmail.com>
> ---
>  config.mak.uname | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/config.mak.uname b/config.mak.uname
> index 7846bd76..f8e12c96 100644
> --- a/config.mak.uname
> +++ b/config.mak.uname
> @@ -88,6 +88,7 @@ ifeq ($(uname_S),Darwin)
>  	NEEDS_LIBICONV = YesPlease
>  	ifeq ($(shell expr "$(uname_R)" : '[15678]\.'),2)
>  		OLD_ICONV = UnfortunatelyYes
> +		NO_APPLE_COMMON_CRYPTO = YesPlease
>  	endif
>  	ifeq ($(shell expr "$(uname_R)" : '[15]\.'),2)
>  		NO_STRLCPY = YesPlease
> 


-- 
- - - - - - - - - - - - - - - - - - -
Dipl. Ing. (FH) Markus Hitter
http://www.jump-ing.de/
