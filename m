Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 356111F71B
	for <e@80x24.org>; Sat, 30 Jul 2016 17:47:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753876AbcG3RrB (ORCPT <rfc822;e@80x24.org>);
	Sat, 30 Jul 2016 13:47:01 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33930 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753275AbcG3Rq7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jul 2016 13:46:59 -0400
Received: by mail-wm0-f66.google.com with SMTP id q128so20105271wma.1
        for <git@vger.kernel.org>; Sat, 30 Jul 2016 10:46:59 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:newsgroups:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=NtxxnUtvsVmKjOyTLm9eOzzhhlMvhbbvtEHH1kWDBkg=;
        b=xEDirxTbyMoDfEU2n2HDvk756+Siujdno1gsa3wXi43VGbrD3WSqXcnTVVqF5fOZM+
         YEnr2xG3y/KBAyKtlczOI9XRMWUtjvLgQJ4TMv6catLT9vstY9oZY/ZWY/P+Xm2hsrLu
         pSAZN/hdKv154Zbgq08J+hjjQCGzyjj4gcY0QMZ7IZMhxlAgLR8AFdMNEO4bX6h69Oci
         2smOWybrBELnNGXsL0bqwQZ7TLPkEVfuM1mf3lVq9ds8gRoGktfhaJ16Wk4nx6WcNJ0V
         BXsYxexBjtEEFEwTDPXMLP+nRdUG9mnNMshbKyPTJ9JdejOYxQGss/i7y72rKohn7hu+
         tglg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:newsgroups:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=NtxxnUtvsVmKjOyTLm9eOzzhhlMvhbbvtEHH1kWDBkg=;
        b=RklJcl1qp1rtPLHPhXqKypeaElMtxlnR37UMz0kQK1tyR/5AtzsUAJGufvChzQc1D1
         NR8+omzbS2zxxsL/dvw116c2uQUEH3PGI4Ee/ptBIdklKM0B6T0/7Uu6CmuIYyjH0izx
         HzQs7JGXy1H23E0Uc83eC8GxGLLjsJFfHRJ9LxGtb/HH574Em5imZ0rkgCXSgdtiojeJ
         NunkML/6FFMLJl7xjKb218HLgzRxkj024RAdzrI5LDV9g4Kvqgq7id31dhr/vJ+O8p+F
         BzNF1VgU/Yy8sgZk36ugo2H77wGOsZtRs2Kygl5l8IOpCkDpsDGZoE/6WIBTqKyYdXdw
         NVAA==
X-Gm-Message-State: AEkooutbfSMszFX/Xkqm64+CB/0pwmBme/XWMOn5ZjT4a1Yuof0XNGbOmmzkJcl5LON5gw==
X-Received: by 10.194.97.17 with SMTP id dw17mr42775006wjb.8.1469900818108;
        Sat, 30 Jul 2016 10:46:58 -0700 (PDT)
Received: from [192.168.1.26] (dax57.neoplus.adsl.tpnet.pl. [83.23.23.57])
        by smtp.googlemail.com with ESMTPSA id e65sm8728709wmg.3.2016.07.30.10.46.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Jul 2016 10:46:56 -0700 (PDT)
Subject: Re: [PATCH] gitweb: escape link body in format_ref_marker
To:	Andreas Brauchli <a.brauchli@elementarea.net>, git@vger.kernel.org
References: <CABnoAVcUbmvZbu7ZiEUWtq_2P6RQLVnJx1a-PiLW-r8uWQ+5vw@mail.gmail.com>
Newsgroups: gmane.comp.version-control.git
From:	=?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <51785fbd-6858-c9b2-7f59-eaf7bd3ea394@gmail.com>
Date:	Sat, 30 Jul 2016 19:46:39 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <CABnoAVcUbmvZbu7ZiEUWtq_2P6RQLVnJx1a-PiLW-r8uWQ+5vw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

W dniu 29.07.2016 o 16:49, Andreas Brauchli pisze:
> Fix a case where an html link can be generated from unescaped input
> resulting in invalid strict xhtml or potentially injected code.
> 
> An overview of a repo with a tag "1.0.0&0.0.1" would previously result
> in an unescaped amperstand in the link body.

s/amperstand/ampersand/
        ^---------------- [ spurious 't' ]

Unescaped ampersand would cause trouble if gitweb output is in XHTML
mode, as some web browsers are strict about validating XML, and do not
display anything (note: this detail is unnecessary in the commit
message).

I guess that "1.0.0&0.0.1" tags are something encountered in real
repositories, while "1<b>2" would be just something evil...

> 
> Signed-off-by: Andreas Brauchli <a.brauchli@elementarea.net>

Good catch!

Acked-by: Jakub Narębski <jnareb@gmail.com>

> ---
>  gitweb/gitweb.perl | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 2fddf75..33d701d 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -2090,7 +2090,7 @@ sub format_ref_marker {
>                                 -href => href(
>                                         action=>$dest_action,
>                                         hash=>$dest
> -                               )}, $name);
> +                               )}, esc_html($name));
> 
>                         $markers .= " <span
> class=\"".esc_attr($class)."\" title=\"".esc_attr($ref)."\">" .
>                                 $link . "</span>";
> 

