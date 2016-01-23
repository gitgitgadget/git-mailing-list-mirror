From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v1] t0027: Add tests for get_stream_filter()
Date: Sat, 23 Jan 2016 18:29:41 -0500
Message-ID: <CAPig+cTjLFFa+1mz222pKhoCjMbPwJwPSy1nWCfOd2SdKX1x-A@mail.gmail.com>
References: <1453558101-6858-1-git-send-email-tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: "tboegi@web.de" <tboegi@web.de>
X-From: git-owner@vger.kernel.org Sun Jan 24 00:29:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aN7cq-0001rk-0P
	for gcvg-git-2@plane.gmane.org; Sun, 24 Jan 2016 00:29:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751592AbcAWX3o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Jan 2016 18:29:44 -0500
Received: from mail-vk0-f66.google.com ([209.85.213.66]:33232 "EHLO
	mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751104AbcAWX3m (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Jan 2016 18:29:42 -0500
Received: by mail-vk0-f66.google.com with SMTP id n1so4392990vkb.0
        for <git@vger.kernel.org>; Sat, 23 Jan 2016 15:29:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=dkIbWsqTezorJp/Gg8sk7IxpgtXZXwiuI9gb1S00nC0=;
        b=wDCS2WDAPUR2zVPRVwnfxjdgMHfmHKxsrGA/tSJJ/QZ+ixcLuFkGkBc+lFtkKILqLa
         oWkBs66qTdDff9mq2RxsCoyFQx0Bdf/lcoryYBGUIZjhVKoUVHjErUlTd5mYkWGUTh28
         4aFHqD0oAzDUvioLlCcwswGCthOk6+QITT0sBdd5b+ox8O/BjJfyZ2zI2ZbStrb5AaeW
         SW/C/W4z12rFfkPC/LWlP4euuO9IrXJWVuFa3GdcA8cRQ2sKBsIE9FX5xRFoAdzJWSGd
         odfqcoPVWPFXi9lWpBISFvep8o2LT69qDEBfJEzlZQThyD3wZAzW1Rf0pfZZmaOlpoUd
         0k1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=dkIbWsqTezorJp/Gg8sk7IxpgtXZXwiuI9gb1S00nC0=;
        b=mkf/nVZaCvLD7tmzfeG5sVrENGdOR2po51F7ylqafwSacXLQyfNrzyN4heH3pt1ZTy
         1kifVbhGmdytQGCirdQ3ASmduvJ+P08BJyFoHS9sP6ga7bCPrbKpDGh1zZHKD66pflSS
         Au0GtJxYB4PQDApWjLqxXDEog+0P69Td0a2mq5TqAPqRMXPdi4tGp7c5NjYSZxMkWv9J
         jV7ktygsYWVAcbjmf14cQ4z2NKZ/uz4UXO9XxoFQenldmfRmmWVtEjZNKypFqgsOLoja
         42ZqXqmo4jlS0dYE8EkX8oi806odmJyfne6qFMpeFOVOiyNsUS0b6AKEkz32RVYU0+WB
         1d7A==
X-Gm-Message-State: AG10YOSK71Ihn0nKWffTIrayVXgVvq2m6nvH4Fy4LqM5gwzl7nxGPRjeoSrpe0fSPXC1izwA4jqdMLrbuid0yQ==
X-Received: by 10.31.141.2 with SMTP id p2mr6827227vkd.37.1453591781891; Sat,
 23 Jan 2016 15:29:41 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Sat, 23 Jan 2016 15:29:41 -0800 (PST)
In-Reply-To: <1453558101-6858-1-git-send-email-tboegi@web.de>
X-Google-Sender-Auth: ons0HFCqHBBuiRZ33xI3-fQI6s8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284632>

On Saturday, January 23, 2016, <tboegi@web.de> wrote:
> When a filter is configured, a different code-path is used in
> convert.c and entry.c via get_stream_filter(), but there are no test cases yet.
>
> Add tests for the filter API by configuring the ident filter.
> The result of the SHA1 conversion is not checked, this is already
> done in other TC.
>
> Add a paramter to checkout_files() in t0027.

s/paramter/parameter/

> While changing the signature, add another parameter for the eol= attribute.
> This is currently unused,
> tests for e.g. "* text=auto eol=lf" will be added in a separate commit.
> ---

Missing sign-off.

>  t/t0027-auto-crlf.sh | 261 ++++++++++++++++++++++++++++-----------------------
>  1 file changed, 146 insertions(+), 115 deletions(-)
