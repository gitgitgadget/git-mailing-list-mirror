Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B18E21F453
	for <e@80x24.org>; Fri,  8 Feb 2019 20:11:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727739AbfBHULL (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Feb 2019 15:11:11 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37781 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727505AbfBHULK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Feb 2019 15:11:10 -0500
Received: by mail-wm1-f66.google.com with SMTP id g67so5169811wmd.2
        for <git@vger.kernel.org>; Fri, 08 Feb 2019 12:11:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qanc6Uo6bjvTP3aVi73ixK6Hlnu5ahMqiwbpa2DGGzA=;
        b=Raymjy5EzLQ74AJmxHs8MyJPQmUsf8lL6FD/zfgXwksLEggmaQKY9MRCVDZkgzHZKM
         b5yspFteK2NOjnePyKL/XjpBkEAbgXC95GLb4WxftW7yOUVM+GhXT86rxcLN/Su50YDl
         qAyQUPo3i/oSLtDllNkgDFCgGfX0vTLMGJ9DuN9AjFlMsepKPr1eeB2I7jTvU3kOk8UZ
         C08wzwv+k8kBRPxsBadZuptEqhffNtGkGXdSNR0eQRLLIuUNVTS6pAMsBMC+uhv6M4WF
         sspo038p5iM7LK5Cir58jyPIAAjJpr5/lY2EL6f6jxdIIEJNBDA2j3gwsDt2qkm/AlMD
         kkvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qanc6Uo6bjvTP3aVi73ixK6Hlnu5ahMqiwbpa2DGGzA=;
        b=b3LLxMJ10mlb+nbAh4GVKa/CgB2jPT+3dGhzslNloSzsK8+qwetq4SRRRDjOGUmqgQ
         FlnjTcbNu6bkqIbFnaxoThDJ/HZHDxO5ElqwYeZEKFZ2nCbsuOXt8OPaYOqOJaAF8p6W
         D7TeKWBBbMrqFEpPym/iUyIsecPzyOA9AWo+u9lnaC18ph4Nx9NvhEQFbmF1FDZu6yaS
         u3flhBU0wASjfSvJn598RVNt3/V2HaYktJdahNqSpTK7ya6o1TH4A/UzDn7zsQkjAp4H
         62v4OSYDc6397N9LFACbkXne/1lLJRWxtwY2eFhio7JETQY99xR54k8ZOAHnawmJrCRy
         A0HA==
X-Gm-Message-State: AHQUAuZg1DYEr9g+MV618JWEC73zhEdFP/OPIBeKZ3N6sFDG7TiOu4T0
        jjiYsOZhUotrKGshOlR6Z/L45sGl
X-Google-Smtp-Source: AHgI3IYuZhjCfvcMCtVYLJ7c20mddoMm1lE211lMdztNvP7liO+M1wXBlw1nxauQq5iYpIEQKo0y1w==
X-Received: by 2002:adf:9ec8:: with SMTP id b8mr18900247wrf.164.1549656668768;
        Fri, 08 Feb 2019 12:11:08 -0800 (PST)
Received: from szeder.dev (x4db62aaa.dyn.telefonica.de. [77.182.42.170])
        by smtp.gmail.com with ESMTPSA id r12sm2749655wrq.3.2019.02.08.12.11.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Feb 2019 12:11:07 -0800 (PST)
Date:   Fri, 8 Feb 2019 21:11:05 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Todd Zullinger <tmz@pobox.com>
Cc:     git@vger.kernel.org, Henning Schild <henning.schild@siemens.com>
Subject: Re: [PATCH 1/2] t/lib-gpg: quote path to ${GNUPGHOME}/trustlist.txt
Message-ID: <20190208201105.GA10587@szeder.dev>
References: <20190208031746.22683-1-tmz@pobox.com>
 <20190208031746.22683-2-tmz@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190208031746.22683-2-tmz@pobox.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 07, 2019 at 10:17:45PM -0500, Todd Zullinger wrote:
> When gpgsm is installed, lib-gpg.sh attempts to update trustlist.txt to
> relax the checking of some root certificate requirements.  The path to
> "${GNUPGHOME}" contains spaces which cause an "ambiguous redirect"
> warning when bash is used to run the tests:

s/error/warning/

>   $ bash t7030-verify-tag.sh
>   /git/t/lib-gpg.sh: line 66: ${GNUPGHOME}/trustlist.txt: ambiguous redirect
>   ok 1 - create signed tags
>   ok 2 # skip create signed tags x509  (missing GPGSM)
>   ...
> 
> No warning is issued when using bash called as /bin/sh, dash, or mksh.

Likewise.

POSIX says that no field splitting should be performed on the result
of a parameter expansion that is used as the target of a redirection,
but Bash doesn't conform in this respect (unless in POSIX mode).

> Quote the path to ensure the redirect works as intended and sets the
> GPGSM prereq.  While we're here, drop the space after ">>".
> 
> Signed-off-by: Todd Zullinger <tmz@pobox.com>
> ---
>  t/lib-gpg.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/t/lib-gpg.sh b/t/lib-gpg.sh
> index f1277bef4f..207009793b 100755
> --- a/t/lib-gpg.sh
> +++ b/t/lib-gpg.sh
> @@ -63,7 +63,7 @@ then
>  		cut -d" " -f4 |
>  		tr -d '\n' >"${GNUPGHOME}/trustlist.txt" &&
>  
> -		echo " S relax" >> ${GNUPGHOME}/trustlist.txt &&
> +		echo " S relax" >>"${GNUPGHOME}/trustlist.txt" &&
>  		(gpgconf --kill gpg-agent >/dev/null 2>&1 || : ) &&
>  		echo hello | gpgsm --homedir "${GNUPGHOME}" >/dev/null \
>  			-u committer@example.com -o /dev/null --sign - 2>&1 &&
> -- 
> Todd
