Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1DBE81FAE2
	for <e@80x24.org>; Fri, 16 Mar 2018 21:25:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750915AbeCPVZE (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Mar 2018 17:25:04 -0400
Received: from mail-wm0-f49.google.com ([74.125.82.49]:54010 "EHLO
        mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750806AbeCPVZD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Mar 2018 17:25:03 -0400
Received: by mail-wm0-f49.google.com with SMTP id e194so5510245wmd.3
        for <git@vger.kernel.org>; Fri, 16 Mar 2018 14:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=mylPEjT5I7Mb8Niw4Uwb6k2MaXMGmXy+UlqfL9Q4CCE=;
        b=a49lHDxc3uyg1wUarvNVIHf3vX4MG1KNlk7a03xewVH9da1SRswM8pqUqvokC4NiFW
         W2mLC/qxnykabUbsBqq+H/KWbcleEjgf484JpVfTFbcxul5b9YoDUYBYwsB01fiq5A3t
         KcxhCW0iw+kc+Mxusk7SEoVDRjepmKxVTDse5b4alJOkj5F5TYq+EtJrMpCwBAKG4V2J
         xYHBH0KwF4G4NG/N10KFDJerMhqH5w7M1ukgwjoiSOLeLch3D2nwG3pxkGbjZbZ4e0ow
         CwIzIaA3QEsn2omMHHZIrQzjFB7GBspkukT7upn/iNbwDQEyiWLD1/AJDe0iKaYn7HJw
         4Igw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=mylPEjT5I7Mb8Niw4Uwb6k2MaXMGmXy+UlqfL9Q4CCE=;
        b=aLbWHomKywHPZ3DrIDl95LGduq4aaDyuutMpkQIp13i/MoIjpQHv/VCj5DZ/Ui80VS
         6McQEs5823UKAN7R3ZsMZE1iXEkhB6SGBB/CMu9wiGCW5tY3D/eC6RU3+btHBO38ciOt
         A6QLNWTlSwYjKvA7U567Lwpsj29sYrANx1rmy1rQCKPHWtmgNHDWfD0P5cZKspMM7cgZ
         V0rIDKVhwRR/CRL2bTOl9qX7UARVxXkS5F8SH7RkymPdzjhmiagoRyhaI4fuP62DvmCN
         P/guZm1uGG0sZ8Hvo+nsKgc0z0YcvHVy3wF3AZHo6UEcp6Pq/oORWsgROTZxFcyKeNnX
         zbhw==
X-Gm-Message-State: AElRT7FjCWgCmYwy4/LLQtvI1I0LkU8IeeeNBDZ5ZKPp6QwzvAYfnTqG
        Ow6in2Lz1Y4lQDlOKLFDiFo=
X-Google-Smtp-Source: AG47ELuaFs25I5sHLhQOxwfcI7pA95CeGIfRUPyASH3tDbLekxYgxhP1FRrvZq79EaCIp16QcPSSMg==
X-Received: by 10.28.51.67 with SMTP id z64mr2698494wmz.59.1521235502065;
        Fri, 16 Mar 2018 14:25:02 -0700 (PDT)
Received: from evledraar (dhcp-089-098-184-206.chello.nl. [89.98.184.206])
        by smtp.gmail.com with ESMTPSA id m3sm7493393wri.25.2018.03.16.14.25.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 16 Mar 2018 14:25:00 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     e@80x24.org, git@vger.kernel.org, gitster@pobox.com, peff@peff.net
Subject: Re: [PATCH v3 2/7] gc: add --keep-base-pack
References: <20180306104158.6541-1-pclouds@gmail.com> <20180316192745.19557-1-pclouds@gmail.com> <20180316192745.19557-3-pclouds@gmail.com>
User-agent: Debian GNU/Linux 9.3 (stretch); Emacs 25.1.1; mu4e 1.1.0
In-reply-to: <20180316192745.19557-3-pclouds@gmail.com>
Date:   Fri, 16 Mar 2018 22:25:00 +0100
Message-ID: <87vadvd87n.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Mar 16 2018, Nguyễn Thái Ngọc Duy jotted:

>  	struct option builtin_gc_options[] = {
>  		OPT__QUIET(&quiet, N_("suppress progress reporting")),
> @@ -362,6 +390,8 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
>  		OPT_BOOL(0, "aggressive", &aggressive, N_("be more thorough (increased runtime)")),
>  		OPT_BOOL(0, "auto", &auto_gc, N_("enable auto-gc mode")),
>  		OPT_BOOL(0, "force", &force, N_("force running gc even if there may be another gc running")),
> +		OPT_BOOL(0, "keep-base-pack", &keep_base_pack,
> +			 N_("repack all other packs except the base pack")),
>  		OPT_END()
>  	};

There's an easy to solve merge conflict here between the current master
& this. Pushed out a solution (for my own use) at
https://github.com/avar/git/ gc-auto-keep-base-pack. Interdiff with
yours:

    @@ -112,9 +112,9 @@
        struct option builtin_gc_options[] = {
                OPT__QUIET(&quiet, N_("suppress progress reporting")),
     @@
    -           OPT_BOOL(0, "aggressive", &aggressive, N_("be more thorough (increased runtime)")),
    -           OPT_BOOL(0, "auto", &auto_gc, N_("enable auto-gc mode")),
    -           OPT_BOOL(0, "force", &force, N_("force running gc even if there may be another gc running")),
    +           OPT_BOOL_F(0, "force", &force,
    +                      N_("force running gc even if there may be another gc running"),
    +                      PARSE_OPT_NOCOMPLETE),
     +          OPT_BOOL(0, "keep-base-pack", &keep_base_pack,
     +                   N_("repack all other packs except the base pack")),
                OPT_END()
