Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1EF8D1F42D
	for <e@80x24.org>; Sat, 24 Mar 2018 09:36:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751853AbeCXJgb (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Mar 2018 05:36:31 -0400
Received: from mail-wr0-f182.google.com ([209.85.128.182]:42850 "EHLO
        mail-wr0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751755AbeCXJg3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Mar 2018 05:36:29 -0400
Received: by mail-wr0-f182.google.com with SMTP id s18so14308000wrg.9
        for <git@vger.kernel.org>; Sat, 24 Mar 2018 02:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=QvcZilnDwim4NlKloI63a8JyDGsXD7cLGaf2nfUXlPU=;
        b=nLhVrAhZt3yz0kU0ubyj1vNXtxH82kCqgj2t6ttO/VGHPIOj/25dFDZLWF+IOqeid3
         J3IybpfC4gRF/nT+yHEKOFoTSMdkAp1pC930/MiwZF447fQL1/GqqNO59IgeQPC6byqp
         5TNKyuRlQbPKFDkDdzGpsEV/ZHUVKTa3iSjJ6aZxqD5VKbYC8gLYx9DS+XjRFYkzQxFQ
         nempOfrfJ3WFkGJswKcuRSiP/opt4MKM22Ou8QMIheaGqlvqqXIoSPVz5nUQATlhXSy4
         EANCKAA0WLUe2Nh4eTKbjZIe+QAHC5Mm32AVcjyYbZvrVB41s/zJbjY0pTAzaAjVV30r
         FQPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=QvcZilnDwim4NlKloI63a8JyDGsXD7cLGaf2nfUXlPU=;
        b=pbOFoDx097zz6mR6Y4GJgqcMbbfl9LqhdduaWyTmsvz/pxEHzRsh4chhvTN+fZ062M
         nNYrBJzkjFUHCrRq115Od+QWpVi5Uo4VT6GLbsRKKt82P1aRqXXrcC5eq/by60wLTM39
         thagwnU5jg/JOJU0qPS3RV1+YBb1E/2q1+QDcUxPwlJ93lBrw8PP5kqKao/XlKTjsZ04
         4c10F0a3+aYMdF/jev5JiksGIQFP4Bu5PFuXja79HhzwceYSydTOatR5Qs2jiIJUAq/J
         vcFZHxku/UDxyyhohHIH93QWEijyymSx5zIM2kSKox6K0Kiji0ytrxbSgGn6T6OY7ujn
         v5hw==
X-Gm-Message-State: AElRT7GEi51sl8Fxe7dEzuzQfa7EHCMonTXqTYokf+DjATRJlty1jmkF
        ks/8uGD+FUwRHbw5vmzL5EE=
X-Google-Smtp-Source: AG47ELummv1bfyp0Wml81iXz8PoQElYqSqKb4ZtWnD4x1kph2mFe4c4Fot6NK+GvyFgtqzEPaBIVBw==
X-Received: by 10.223.144.69 with SMTP id h63mr16097691wrh.218.1521884188507;
        Sat, 24 Mar 2018 02:36:28 -0700 (PDT)
Received: from evledraar (dhcp-089-098-184-206.chello.nl. [89.98.184.206])
        by smtp.gmail.com with ESMTPSA id y9sm1923309wrg.34.2018.03.24.02.36.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 24 Mar 2018 02:36:26 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 3/7] gc: add --keep-largest-pack option
References: <20180317075421.22032-1-pclouds@gmail.com> <20180324074308.18934-1-pclouds@gmail.com> <20180324074308.18934-6-pclouds@gmail.com>
User-agent: Debian GNU/Linux 9.4 (stretch); Emacs 25.1.1; mu4e 1.1.0
In-reply-to: <20180324074308.18934-6-pclouds@gmail.com>
Date:   Sat, 24 Mar 2018 10:36:24 +0100
Message-ID: <87fu4pyfvr.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Mar 24 2018, Nguyễn Thái Ngọc Duy wrote:

>  	struct option builtin_gc_options[] = {
>  		OPT__QUIET(&quiet, N_("suppress progress reporting")),
> @@ -362,6 +390,8 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
>  		OPT_BOOL(0, "aggressive", &aggressive, N_("be more thorough (increased runtime)")),
>  		OPT_BOOL(0, "auto", &auto_gc, N_("enable auto-gc mode")),
>  		OPT_BOOL(0, "force", &force, N_("force running gc even if there may be another gc running")),
> +		OPT_BOOL(0, "keep-largest-pack", &keep_base_pack,
> +			 N_("repack all other packs except the largest pack")),
>  		OPT_END()
>  	};

This conflicts with master because of your own 7e1eeaa431 ("completion:
use __gitcomp_builtin in _git_gc", 2018-02-09). I pushed out a
avar-pclouds/gc-auto-keep-base-pack branch to github.com/avar/git which
resolves it as:

    @@ -365,6 +393,8 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
                    OPT_BOOL_F(0, "force", &force,
                               N_("force running gc even if there may be another gc running"),
                               PARSE_OPT_NOCOMPLETE),
    +               OPT_BOOL(0, "keep-largest-pack", &keep_base_pack,
    +                        N_("repack all other packs except the largest pack")),
                    OPT_END()
            };

I assume that's the intention here.
