From: "Kyle J. McKay" <mackyle@gmail.com>
Subject: Re: [PATCH 2/2] Makefile: Also add a symlink fallback to installing ALL_PROGRAMS
Date: Thu, 5 Feb 2015 09:49:26 -0800
Message-ID: <6D3D9F6F-E610-4C41-847C-5ECDD427BB18@gmail.com>
References: <CAHGBnuPtzQeqNoHiwNoaH3j9OWXq-jopjwwdStS-0mnX_9mzww@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 05 18:49:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YJQYW-0002rd-RH
	for gcvg-git-2@plane.gmane.org; Thu, 05 Feb 2015 18:49:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754611AbbBERt3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Feb 2015 12:49:29 -0500
Received: from mail-pd0-f172.google.com ([209.85.192.172]:37304 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754416AbbBERt2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Feb 2015 12:49:28 -0500
Received: by pdbfp1 with SMTP id fp1so9077922pdb.4
        for <git@vger.kernel.org>; Thu, 05 Feb 2015 09:49:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:in-reply-to:subject:references:message-id:content-type
         :content-transfer-encoding:mime-version:date:cc;
        bh=TwHL+tFT++ikP/185RwHJfBKQle9F3iG9JaFcxT8jJ0=;
        b=sZkZF2dgxBRDZXQXu0UEw8q+jaSGX4yB4RoU9WzDL0d+cWazUF+Gjh4DeqTcV+Jg8G
         vK8ybPnD34/CIwZBFwy8TYm4Ae1fjlaE/WnqkfN07nX4OrQmG9MJwyLGHMb9G5c1R166
         ab34j1y3o4P1fAa9u/SL76YlvMkP2MBy8HHyyzKysVisx+yz8cu/sTWKk8oMvSvdTxTj
         P0wcYxx0HEpAI3L7fpQBcGBypK9UBzjPpxrdN0rzjYJwvEc80AhKaV9mPpaDHieDrujI
         9ZXS+/4tCSKmq7MadvhZxFunT/0S+Mgf1Crbl5nCWi7bVSVmRWgZpdUaSV9uQRIwdW4m
         cyQA==
X-Received: by 10.66.55.4 with SMTP id n4mr7323216pap.79.1423158567839;
        Thu, 05 Feb 2015 09:49:27 -0800 (PST)
Received: from [172.16.16.105] (ip72-192-173-141.sd.sd.cox.net. [72.192.173.141])
        by mx.google.com with ESMTPSA id dh1sm5682312pbc.24.2015.02.05.09.49.26
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 05 Feb 2015 09:49:27 -0800 (PST)
In-Reply-To: <CAHGBnuPtzQeqNoHiwNoaH3j9OWXq-jopjwwdStS-0mnX_9mzww@mail.gmail.com>
X-Mauler: Craptastic (2.936)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263381>

On Feb 5, 2015, at 07:52, Sebastian Schuberth wrote:
> We do this for BUILT_INS and REMOTE_CURL_ALIASES, so we should do so  
> here,
> too.
>
> Signed-off-by: Sebastian Schuberth <sschuberth@gmail.com>
> ---
> Makefile | 1 +
> 1 file changed, 1 insertion(+)
>
> diff --git a/Makefile b/Makefile
> index 21f23cb..d2849c3 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -2258,6 +2258,7 @@ endif
>         $(RM) "$$execdir/$$p" && \
>         test -z "$(NO_INSTALL_HARDLINKS)$ 
> (NO_CROSS_DIRECTORY_HARDLINKS)" && \
>         ln "$$bindir/$$p" "$$execdir/$$p" 2>/dev/null || \
> +        ln -s "$$bindir/$$p" "$$execdir/$$p" 2>/dev/null || \

Can we not start installing absolute path symlinks please.

-Kyle
