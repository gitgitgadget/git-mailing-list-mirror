Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6DB1B20D0A
	for <e@80x24.org>; Tue, 30 May 2017 06:03:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750897AbdE3GDV (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 May 2017 02:03:21 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:36304 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750885AbdE3GDU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 May 2017 02:03:20 -0400
Received: by mail-pf0-f195.google.com with SMTP id n23so15570183pfb.3
        for <git@vger.kernel.org>; Mon, 29 May 2017 23:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=xuORvcl3vS+rXMpT8XqfweBOoRi9h+eDfSU5xJovHTQ=;
        b=TywFRa3Iv5SA6Pau1h8M1SnH1SoCGd/ow3gYA0za4M7d1mieo8kAmvIklGjdqBJezq
         UxF8HV69FuCDlWK3zfwDjudT7UoeJyG5fd/DHsk283a3SVjDw5grpwueIiHh3qMrFY6J
         YshUR/n/tmFK45/7bcMSf+75+ZMVHvduKaSDEaq0P9hLgzFTUtResj8fxJYz94ZWTz8T
         +sfmv64B6wbi+/CSrBaGgs8ZmFAtJf93wJLdmL9D7SgiBhuedvppfGm5qpqbAAkLRM1q
         80s10R8aLanZF54mNvZT3CHh4MSVAEVJy8yWpu1Sc/4WXcsDFSpX8XDvVssovyLU6otZ
         WWIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=xuORvcl3vS+rXMpT8XqfweBOoRi9h+eDfSU5xJovHTQ=;
        b=EN8I+isMwlnvePBXpgHEd2KbOPLA7yC+09DOT1FnBq6w3X/EG3oK4vd6yl562ydBFH
         cmA+16QaR5CFdneBMW9Xc1l9a5upVNHspL5UuTIQBiD5lpeohcpcC1Bmj5e7TLf59LaV
         PilpV3asE7GLmM60QerZCFvCupGVJyl3YMbLHsE2VaUFoeQvHeW8Pr7vm5oS5kaj7s5J
         RMgRIPUbFbF8jZivNOkVrMXxQ04dRLz1CtMB3tvPf2rJsi1mShb9RxTT3Iqamzr2c902
         AVRc7oiyYz0Zd7dzlwaC71wpeKJCIpFBWFgKkpO2MCt/40FWAigFwsCdQ12Ntsk6Mrqf
         nIEA==
X-Gm-Message-State: AODbwcAoBLmcsudtSz1xlUu/GCFIQprEpKI92BmeKpEgDRhS5BpPz1jJ
        ofaJ1HM0acmSZw==
X-Received: by 10.84.233.132 with SMTP id l4mr80761620plk.148.1496124199945;
        Mon, 29 May 2017 23:03:19 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:f830:fc5f:a16b:f475])
        by smtp.gmail.com with ESMTPSA id h7sm18086131pfc.97.2017.05.29.23.03.19
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 29 May 2017 23:03:19 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Zero King <l2dy@macports.org>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 8/8] t0012: test "-h" with builtins
References: <20170530050949.dkgu3u26qj6ycusy@sigill.intra.peff.net>
        <20170530051930.pqywvihwl5klg7hz@sigill.intra.peff.net>
Date:   Tue, 30 May 2017 15:03:18 +0900
In-Reply-To: <20170530051930.pqywvihwl5klg7hz@sigill.intra.peff.net> (Jeff
        King's message of "Tue, 30 May 2017 01:19:30 -0400")
Message-ID: <xmqqwp8yc255.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> This patch just tests that "git foo -h" works for every
> builtin, where we see a 129 exit code (the normal code for
> our usage() helper), and that the word "usage" appears in
> the output.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  t/t0012-help.sh | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/t/t0012-help.sh b/t/t0012-help.sh
> index 8faba2e8b..487b92a5d 100755
> --- a/t/t0012-help.sh
> +++ b/t/t0012-help.sh
> @@ -49,4 +49,16 @@ test_expect_success "--help does not work for guides" "
>  	test_i18ncmp expect actual
>  "
>  
> +test_expect_success 'generate builtin list' '
> +	git --list-builtins >builtins
> +'
> +
> +while read builtin
> +do
> +	test_expect_success "$builtin can handle -h" '
> +		test_expect_code 129 git $builtin -h >output 2>&1 &&
> +		test_i18ngrep usage output
> +	'
> +done <builtins
> +

These still seem to need further tweaks?

    diff-files
    diff-index
    diff-tree
    rev-list

