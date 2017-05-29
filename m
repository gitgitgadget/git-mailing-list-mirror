Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 656111FD09
	for <e@80x24.org>; Mon, 29 May 2017 01:09:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750872AbdE2BJh (ORCPT <rfc822;e@80x24.org>);
        Sun, 28 May 2017 21:09:37 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:34917 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750861AbdE2BJh (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 May 2017 21:09:37 -0400
Received: by mail-pg0-f66.google.com with SMTP id i63so4751109pgd.2
        for <git@vger.kernel.org>; Sun, 28 May 2017 18:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=PRHp2s46Ep1v9s9lUw0waJEQdscZVoQnjrL6hreAb2o=;
        b=Ga2a/Q47GvMhsWNvxJxArSNzjATtHKypwbKGVWg3vlMb+kTfhhYLzmMGFfAHAo2Gx7
         bvEX1vTYkpuNf7fljYgdQhzhvIKi1LAUzG5e5LbzciKk+uQIzxJxDjHAzlvv9kaJldXi
         30FTPEcDU9EPnbZ89xd2zCQ9xeNIm7wpUug3Z3RZju4kLykbQYW1ExIo6OQqgVr3PSEZ
         PgXqdHLd5EN5iTEa7O8KWYuP7oTLRdTGcsb9b0AXFfKLJPotg/NZEPUeXucJ3bAFytOk
         zyLXurD7292dvrf34xHuoawOAnQeftXmeFX9atGRD4u4vDfhzLfwKiWUIdb6wmwJe0n8
         M9RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=PRHp2s46Ep1v9s9lUw0waJEQdscZVoQnjrL6hreAb2o=;
        b=KYeImo1eIktrvyDYxRQm01bbXoJGwXO0M18w8DqfNtwr/lbgmjssl4Sk5yFCvqgmxi
         wodtt8LuhrARGSLjvuJOV0on3XN0iSw1ssC7VTGXLw7Uujaws+NprP9A2lFvUSk5BuaS
         sUYaIQby7ySX3dHu61CWFGlhfV2pBaUSnAGQEb7Nzs3kaYMGve/POWOLT+2U8rLQaFay
         l5NKVdqpYJZuKOz1/JA5mYRaF3AFztKo1MIA0dzK3Os0ihhpkiLma42vYDTtMyeuaMfz
         F/q6ewztgpvJVV3xvGMHBAqCNJmk7wEDRp2kzDUbayxx1rITxoXdBfGUbx7BNJa8VWgr
         HUFA==
X-Gm-Message-State: AODbwcBgu0BVLrbTxlm/nZoX6FQJ8Kb0zBMTfZP24vpSaIvefo09ULNo
        TyHMYwH48ANo0p5+4rY=
X-Received: by 10.99.117.65 with SMTP id f1mr16067897pgn.58.1496020176332;
        Sun, 28 May 2017 18:09:36 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:393e:d787:9be9:17cc])
        by smtp.gmail.com with ESMTPSA id u26sm14346670pfg.24.2017.05.28.18.09.35
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sun, 28 May 2017 18:09:35 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH] WIP: add deprecation & experimental process/interface
References: <20170527111032.30897-1-avarab@gmail.com>
Date:   Mon, 29 May 2017 10:09:34 +0900
In-Reply-To: <20170527111032.30897-1-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Sat, 27 May 2017 11:10:32 +0000")
Message-ID: <xmqq4lw4a2pd.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:

> diff --git a/GIT-VERSION-GEN b/GIT-VERSION-GEN
> index 4f94fc7574..c76bbedf86 100755
> --- a/GIT-VERSION-GEN
> +++ b/GIT-VERSION-GEN
> @@ -37,4 +37,5 @@ fi
>  test "$VN" = "$VC" || {
>  	echo >&2 "GIT_VERSION = $VN"
>  	echo "GIT_VERSION = $VN" >$GVF
> +	echo "GIT_VERSION_INT = $(echo $VN | sed -e 's/^\([0-9]*\)\.\([0-9]*\)\..*/\1\2/')" >>$GVF
>  }

Unlike Perl's v1.2.3.4 notation, this forces us worry when we go
from v2.99.0 to v2.100.0 and eventually to v3.0, no?

> +	} else if (1) {
> +		/*
> +		 * TODO: Instead of `if 1` we should check a
> +		 * core.version variable here.
> +		 *
> +		 * I.e. if set to core.version=2.13 the user is opting
> +		 * in to get deprecations set at dep_at right away,
> +		 * and also perhaps experimental features from a
> +		 * sister experimental() interface.
> +		 */

This essentially forces us to always read _some_ configuration.
Some commands are meant to work outside repositories, so those who
want to affect them needs to write core.version in their global
configuration.  Some low-level plumbing commands may want to do
absolute minimum without configurablity.

I am not saying that it is absolutely a bad design decision to force
us to read some configuration (yet); it's just that it is something
that we have to keep in mind and always think about the
ramifications of.

> +		die(_("Early bird deprecation error: %s"), message);
> +	}
> +}
