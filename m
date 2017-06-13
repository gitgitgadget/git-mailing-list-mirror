Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BFBC51FA7B
	for <e@80x24.org>; Tue, 13 Jun 2017 17:10:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752369AbdFMRKl (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Jun 2017 13:10:41 -0400
Received: from mail-pg0-f42.google.com ([74.125.83.42]:36111 "EHLO
        mail-pg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751805AbdFMRKk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jun 2017 13:10:40 -0400
Received: by mail-pg0-f42.google.com with SMTP id a70so63381993pge.3
        for <git@vger.kernel.org>; Tue, 13 Jun 2017 10:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=dO6h+DKK1/DFgPemFnnaYdlxa8AUaBkTQFs/3cCOcTs=;
        b=prw3HVo4fltjjC2f/Tc2L5cO9Nf8mUBpY4AKCeoy8AMJvQzCK5n6LtLfXCpBH3Bk/M
         WjtU1VkfyDwzZh4P5/3IZby8NNVpBo+DzTr2gKcRp8qo6V78CbUekq/4RPqC9L212aJx
         Gwd/x2OlwwHS4tNI+OMscyAmTaGAKVXQynrayfmJXBY/7IZaLh/Zsjvkb010TR7JPfzq
         pi55yhAKDY6axt6h6AZy5dVFdDwdzGMsKeqbSsQY28KOJxtJirQiMLnNWGhZwHNuHVMp
         xovUy0OgA86wTUD1XNcXhbbVBOg4lpOyXmPgFfZQYR4JKRexPcIC1qNikqxiW9Nb6sPN
         l8Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=dO6h+DKK1/DFgPemFnnaYdlxa8AUaBkTQFs/3cCOcTs=;
        b=WAZss35ME5o+eObhkiIkT4HQTs8t2CqH0aSPGLmz1Np2LqCzen7M/lfJS+MSJKW/kR
         E8ANUd77AepdhIZWg0oGMbxZeFNsFATCLwEo9PdgphnqEme3DTQ2BQK8VqTreKLbtyHa
         LtGYEW3F8b0/MwkqoDXWFGaht/3wygND5cBJKvH2pamYMSfSV2SbYcU8sJhOSm2kNnqt
         0rprIlpDQ1yHWa/Z2z4b8GkceF8+s6AyCrcEqIAvq3tTN1yaO22NAOXT+QezXRrmf3hC
         5/NiAWJ2nrwNKre/knGuonyXuPbyO0WxzIyRH+y1aHHAcnBMnW9SV31BElyN6ubFEfSx
         d4mQ==
X-Gm-Message-State: AKS2vOy1FuxKzW0k0yCfBtoDGl4iCkpaRzR5XX4VnrUjAPXK6sAWomYn
        LeiKkLtPGuPgMQ==
X-Received: by 10.98.197.130 with SMTP id j124mr413135pfg.239.1497373839964;
        Tue, 13 Jun 2017 10:10:39 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:b4c1:e9f6:bf2b:dcec])
        by smtp.gmail.com with ESMTPSA id e124sm24005191pgc.17.2017.06.13.10.10.39
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 13 Jun 2017 10:10:39 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Sahil Dua <sahildua2305@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/3] branch: add test for -m renaming multiple config sections
References: <0102015ca23f0488-7423db93-b65f-4214-8221-af6a1bb4c2e5-000000@eu-west-1.amazonses.com>
        <0102015ca23f0529-c860f75d-e3bb-48b0-b2c0-502f7ab9d667-000000@eu-west-1.amazonses.com>
Date:   Tue, 13 Jun 2017 10:10:38 -0700
In-Reply-To: <0102015ca23f0529-c860f75d-e3bb-48b0-b2c0-502f7ab9d667-000000@eu-west-1.amazonses.com>
        (Sahil Dua's message of "Tue, 13 Jun 2017 16:17:38 +0000")
Message-ID: <xmqqwp8f7r01.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sahil Dua <sahildua2305@gmail.com> writes:

> +	cat >expect <<-\EOF &&
> +	branch.dest.key1=value1
> +	some.gar.b=age
> +	branch.dest.key2=value2
> +	EOF
> +	cat >config.branch <<\EOF &&
> +;; Comment for source
> +[branch "source"]
> +	;; Comment for the source value
> +	key1 = value1
> +	;; Comment for some.gar
> +[some "gar"]
> +	;; Comment for the some.gar value
> +	b = age
> +	;; Comment for source, again
> +[branch "source"]
> +	;; Comment for the source value, again
> +	key2 = value2
> +EOF

Indenting using <<- would make it easier to read.  I.e.

	cat >config.branch <<-\EOF &&
	;; Comment for ...
	[branch "source"]
		;; Comment for ...
	...
	EOF

> +	cat config.branch >>.git/config &&
> +	git branch -m source dest &&
> +	git config -f .git/config -l | grep -F -e source -e dest -e some.gar >actual &&
> +	test_cmp expect actual &&
> +
> +	# ...and that the comments for those sections are also
> +	# preserved.
> +	cat config.branch | sed "s/\"source\"/\"dest\"/" >expect &&
> +	grep -A 9001 "Comment for source" .git/config >actual &&

Where does 9001 come from?  Is that just "an arbitrary large
number"?
	
Besides, "grep -A" is quite unportable.  Would

	sed -n -e "/Comment for source/,$p" .git/config >actual

work equally well?

> +	test_cmp expect actual
> +'
> +
>  test_expect_success 'deleting a symref' '
>  	git branch target &&
>  	git symbolic-ref refs/heads/symref refs/heads/target &&
>
> --
> https://github.com/git/git/pull/363
