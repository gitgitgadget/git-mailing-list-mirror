From: Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH 1/5] t5550: fix typo in $HTTPD_URL
Date: Thu, 28 Apr 2016 08:24:05 -0700
Message-ID: <CA+P7+xqSYA5++pq0_0FYFg8TXhc7f0=X_4uNWtFRpebEDzqtHQ@mail.gmail.com>
References: <20160428133534.GA19056@sigill.intra.peff.net> <20160428133636.GA25319@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Lars Schneider <larsxschneider@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Git Users <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Apr 28 17:24:37 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avnnu-00037W-Oe
	for gcvg-git-2@plane.gmane.org; Thu, 28 Apr 2016 17:24:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753160AbcD1PY2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Apr 2016 11:24:28 -0400
Received: from mail-oi0-f50.google.com ([209.85.218.50]:33675 "EHLO
	mail-oi0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753037AbcD1PY1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2016 11:24:27 -0400
Received: by mail-oi0-f50.google.com with SMTP id v145so54035831oie.0
        for <git@vger.kernel.org>; Thu, 28 Apr 2016 08:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=yRjZZObGuDgLj0BRfNSF5Acq8PwNjE263IM+S1/tUcA=;
        b=MJqtF0DvoEqmTF/biwhwFVqHzX2CSZUrhYJI/aHfkNh4zP0ErxfHCPnnqi9Nmr/ZGX
         32ZYESX+3EtXOTTwpJZHE73Xs9X+5CyYz1+xIY1rl2unZ9dZviNymq48/hwh70sNnI6u
         Q648V9nVLbsG25mj1zUf38H945OyO0FbyN6pACUFeVE453vzprN08XvDiN7FXT5PJ7kz
         jjmm//5X/uRBWVfOlg/AlQvs27k0yiVA6zJGu95n3KHYM6lbiZ2+r4F//ilfMtPOtoZm
         Z4GdYqER0md7gzt7iTIGcaJZOO/ONO8TM4/KXgFXq+NA4g2dchUSJsSxUpn1wDgOkKN7
         u4oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=yRjZZObGuDgLj0BRfNSF5Acq8PwNjE263IM+S1/tUcA=;
        b=LJpheIJncxMpI5YvRjWG5+aHzRC15hSwJsJ14pyM8iC2UlQK7QYWyIiNnv0loYZmWU
         ed16UJ6+N7wANy8PRde8jrXaTx+/WPE6U/q7nye1oSxHN/Dz5xdqMRA5/4VV3RaCkYKm
         5MdMaqRZ0mkZXkLVlo4mj4M/OOk+bGGkfnVFVAXhv5vIQ0LTYTfYCXI1Mx86rTUvAJy3
         RkUIKJ20WBbrda2kPwlBwBhvk85uwH7r1SDCUoAibIGMeB+YKDFfEKEOg6AESQY2ZpfS
         7FGYHLLxoGX9NdV6ig4YJMIuhZ++1LBzBfdN/v832Xa4uEu3yD2lQdeysh5VWMVvNqqG
         fibg==
X-Gm-Message-State: AOPr4FWs8W/1CTjqeG7g97FWDNehrsgRZI4oQ13IaheXLG2ESkVSnvUxRsNqyfAbMJsbeRK3hc+94XXo+IwmGg==
X-Received: by 10.157.52.162 with SMTP id g31mr7455874otc.165.1461857065408;
 Thu, 28 Apr 2016 08:24:25 -0700 (PDT)
Received: by 10.182.117.132 with HTTP; Thu, 28 Apr 2016 08:24:05 -0700 (PDT)
In-Reply-To: <20160428133636.GA25319@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292894>

On Thu, Apr 28, 2016 at 6:36 AM, Jeff King <peff@peff.net> wrote:
> Commit 14111fc (git: submodule honor -c credential.* from
> command line, 2016-02-29) accidentally wrote $HTTP_URL. It
> happened to work because we ended up with "credential..helper",
> which we treat the same as "credential.helper", applying it
> to all URLs.

You say "credential.helper" twice here? I think that's confusing. The
patch looks perfectly fine but I am having trouble parsing this
description. 'We end up with X which we treat the same as X"?

>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  t/t5550-http-fetch-dumb.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/t/t5550-http-fetch-dumb.sh b/t/t5550-http-fetch-dumb.sh
> index 48e2ab6..81cc57f 100755
> --- a/t/t5550-http-fetch-dumb.sh
> +++ b/t/t5550-http-fetch-dumb.sh
> @@ -103,7 +103,7 @@ test_expect_success 'cmdline credential config passes into submodules' '
>         test_must_fail git clone --recursive super super-clone &&
>         rm -rf super-clone &&
>         set_askpass wrong pass@host &&
> -       git -c "credential.$HTTP_URL.username=user@host" \
> +       git -c "credential.$HTTPD_URL.username=user@host" \
>                 clone --recursive super super-clone &&
>         expect_askpass pass user@host
>  '
> --
> 2.8.1.617.gbdccc2d
>
