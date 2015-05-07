From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: [PATCH] add support for specifying an SSL cipher list
Date: Fri, 8 May 2015 00:42:02 +0800
Message-ID: <CALUzUxoC66QZ5gJdV_nE=zFOLUNfpz64Ena2rDmesaEqkEGDAQ@mail.gmail.com>
References: <1431008210-673-1-git-send-email-lars@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Lars Kellogg-Stedman <lars@redhat.com>
X-From: git-owner@vger.kernel.org Thu May 07 18:42:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YqOsW-0007Z8-7I
	for gcvg-git-2@plane.gmane.org; Thu, 07 May 2015 18:42:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751846AbbEGQmY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 May 2015 12:42:24 -0400
Received: from mail-ig0-f174.google.com ([209.85.213.174]:35219 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750959AbbEGQmX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 May 2015 12:42:23 -0400
Received: by igbyr2 with SMTP id yr2so164705755igb.0
        for <git@vger.kernel.org>; Thu, 07 May 2015 09:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=RqCFI0hAq3QiqHpQAno3aYV8zu8dm4HM6zetNE9C3NQ=;
        b=mABP6nk943O2z9ZayDEi1R0Kz9Jp5qn2xLenVW7z4Xl6B+r/gxMTy0+CSZwlX2OBdw
         OPzKRj78amd15xGGukaF8+xRqGis7Eu0H3TwsWjBWp70ftkoxUkxt4vWJFsY5Y7Pl4mD
         v6ohbKjolWw7PPIjDrUSXWNZ3dxcuynOy9ZRkC6KsxPi59HnDY9IIwQ1GfzdkxPieVwO
         sWO+DcppaLLInQSlBXhWTZrENTC0agsNm5HbWs/E70V92e+FDScjClvs4pIKIjhj2aqb
         y9kfcegt81KGdchzeDz5ZjKA5aoz1mlaBMLijNPkQGunMyF0Mp92TYEt1qOsPMRe2GXb
         9IoA==
X-Received: by 10.50.117.35 with SMTP id kb3mr1355375igb.13.1431016942764;
 Thu, 07 May 2015 09:42:22 -0700 (PDT)
Received: by 10.64.58.43 with HTTP; Thu, 7 May 2015 09:42:02 -0700 (PDT)
In-Reply-To: <1431008210-673-1-git-send-email-lars@redhat.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268548>

On Thu, May 7, 2015 at 10:16 PM, Lars Kellogg-Stedman <lars@redhat.com> wrote:
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 2e5ceaf..b17985c 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -1560,6 +1560,13 @@ http.saveCookies::
>         If set, store cookies received during requests to the file specified by
>         http.cookieFile. Has no effect if http.cookieFile is unset.
>
> +http.sslCipherList::
> +  A list of SSL ciphers to use when negotiating an SSL connection.
> +  The available ciphers depend on whether libcurl was built against
> +  NSS or OpenSSL and the particular configuration of the crypto
> +  library in use.  Can be overwridden by the 'GIT_SSL_CIPHER_LIST'
> +  environment variable.
> +
>  http.sslVerify::
>         Whether to verify the SSL certificate when fetching or pushing
>         over HTTPS. Can be overridden by the 'GIT_SSL_NO_VERIFY' environment

You might want to mention the libcurl option that this conf
corresponds to, so that a reader could go look it up in the libcurl
documentation to get an idea of the ciphers available, and list syntax
to be used that would be accepted by us (but really by libcurl). But
we also don't have to go as far as reproducing it here (eg. ciphers
separated by colons) since this it tied to the libcurl version the
user is linking against.

-- 
Cheers,
Ray Chuan
