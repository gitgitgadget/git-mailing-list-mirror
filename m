From: "Kyle J. McKay" <mackyle@gmail.com>
Subject: Re: Git on Mac OS X 10.4.10
Date: Fri, 15 Aug 2014 10:56:41 -0700
Message-ID: <FF233C51-7AEA-4A10-8446-D8233F55E89B@gmail.com>
References: <53ECA7DB.7060407@jump-ing.de> <53ECCA14.40900@web.de> <53ED0257.3070505@jump-ing.de> <xmqqppg21wyk.fsf@gitster.dls.corp.google.com> <273241271546c07e692ae93774993f5@74d39fa044aa309eaea14b9f57fe79c> <xmqqbnrl1ya1.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Markus Hitter <mah@jump-ing.de>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 15 19:56:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XILkH-0007Sm-89
	for gcvg-git-2@plane.gmane.org; Fri, 15 Aug 2014 19:56:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751239AbaHOR4x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Aug 2014 13:56:53 -0400
Received: from mail-pd0-f172.google.com ([209.85.192.172]:61689 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751027AbaHOR4w (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Aug 2014 13:56:52 -0400
Received: by mail-pd0-f172.google.com with SMTP id y13so3705032pdi.31
        for <git@vger.kernel.org>; Fri, 15 Aug 2014 10:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:in-reply-to:subject:references:message-id:content-type
         :content-transfer-encoding:mime-version:date:cc;
        bh=JkEacSu4sIlkMXGm54grXgMT1TV9Jie0ATdFS2ZUXfI=;
        b=fyuBZZOk1RxvOVFvMtvQKoFbuwZ473qAcyPxCo1Lqcj9ev4kqgV97X7XV7ezftqthW
         XkIsMj3u18KnPKxFRyZsLQXsqF71RYADI4tWNj+x4JrGsoEkIyBqxqum6qlBclQk3w6t
         04RRDx8AluHS20PuhLFK7qOFQx2FoSiPIj3ne/nstW8rJHWahUakvvmF4uGOHUPfaFWi
         Q0vnHEGyycQZ8fuu2KpGF8NpmfyQUi7Qh00dLtKqFXx4+61JijAUosFsfZYp3bcSLaNa
         lcUHMTisfY4FB6wTIGop5Ia3FNa1zXbBMqNGvzQcpL9/iBLr+/Q0KAXUQS4YnzXZ62Ep
         hlXw==
X-Received: by 10.70.45.74 with SMTP id k10mr20055589pdm.78.1408125407890;
        Fri, 15 Aug 2014 10:56:47 -0700 (PDT)
Received: from [172.16.16.105] (ip72-192-173-141.sd.sd.cox.net. [72.192.173.141])
        by mx.google.com with ESMTPSA id b13sm8549690pbu.63.2014.08.15.10.56.46
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 15 Aug 2014 10:56:47 -0700 (PDT)
In-Reply-To: <xmqqbnrl1ya1.fsf@gitster.dls.corp.google.com>
X-Mauler: Craptastic (2.936)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255298>

On Aug 15, 2014, at 10:02, Junio C Hamano wrote:

> By the way, can we document this "uname_R on MacOS X" business
> nearby, perhaps like this?
>
> -- >8 --
> Subject: config.mak.uname: add hint on uname_R for MacOS X
>
> I always have to scratch my head every time I see this cryptic
> pattern "[15678]\."; leave a short note to remind the maintainer
> and the reviewers.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
> config.mak.uname | 4 ++++
> 1 file changed, 4 insertions(+)
>
> diff --git a/config.mak.uname b/config.mak.uname
> index f8e12c9..7e49aca 100644
> --- a/config.mak.uname
> +++ b/config.mak.uname
> @@ -86,6 +86,10 @@ ifeq ($(uname_S),Darwin)
> 	NEEDS_CRYPTO_WITH_SSL = YesPlease
> 	NEEDS_SSL_WITH_CRYPTO = YesPlease
> 	NEEDS_LIBICONV = YesPlease
> +	# Note: $(uname_R) gives us the underlying Darwin version.
> +	# - MacOS 10.0 = Darwin 1.*
> +	# - MacOS 10.x.? = Darwin (x+4).* for (1 <= x)
> +	# i.e. "begins with [15678] and the a dot" means "10.4.* or older".

s/the a dot/a dot/

> 	ifeq ($(shell expr "$(uname_R)" : '[15678]\.'),2)
> 		OLD_ICONV = UnfortunatelyYes
> 		NO_APPLE_COMMON_CRYPTO = YesPlease

Otherwise looks good.  Mac OS X 10.1.0 doesn't actually fit the  
pattern (it's still Darwin 1.*), but it's so old and it doesn't affect  
the 10.4.* or older test (or the later 10.1.* or older test), so let's  
just ignore that anomaly.  :)
