Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DEC7D1F461
	for <e@80x24.org>; Mon, 13 May 2019 21:12:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726454AbfEMVMV (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 May 2019 17:12:21 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:46921 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726190AbfEMVMV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 May 2019 17:12:21 -0400
Received: by mail-ed1-f66.google.com with SMTP id f37so19511265edb.13
        for <git@vger.kernel.org>; Mon, 13 May 2019 14:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=DCXyYkgo+3FL3fySpC+pdZ0wcYDMXnjKpWouOF8/83U=;
        b=X+H9OcD3HIER2d9j5khWHxtwraV+XBTyL8BFShO7g94c2p38FVJWm/WMtADfK5MNAS
         gc9hJHbsCdFegT6Z0sRuWRZhDi1h9WbLpn616So12n6HfFVuebUxq/2cTKlooCX1yzLF
         gDVwqaQv+FbU20laEgxGf2oLEZiCwUsVUs8YOps7swqYtnVMSr1ybwd/1gL2fdKFo28n
         H2RjDf+j+uywRzfALtezULwiDlhenUlxUv9H5ZhRr7/T9sP7MpDxW0lvYPQqY4j+LwZ+
         MzNqFF9sDfg4t/7TFzwxE9CShXP6m0+OziMFiN38yzIqdI4HKG1VcZQKdFGX24Q69KZw
         kOig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=DCXyYkgo+3FL3fySpC+pdZ0wcYDMXnjKpWouOF8/83U=;
        b=cxJ/e2H+K8VQ06yJuaEuyeU7E75KdNV08dFI8UGDg3bZXUuy0s/6wfa7kXglHJpcna
         IYQJ0YDXVd+XftUeW/ttIqtsYmJ5RS6VLVutdzSOkhiEkElh7eAAWrH0S0UH1kV2YenT
         kat75KmqbfUsJ+N2UWUQmzzA7LxU+S1MtKy2Q84hnZaprJHw2Gfp6C2BxXx4sG/6CwNZ
         GgyYqEAaI16QBL893CerYGJsFXLKyNRJoR6rHw12MHumG9NrSX0iBc/gIgNWPwE+Mb5+
         bBigrL02tEMctyu555SdI39uucHYBIMp4/ke1y4vaT/29KBXYHsVe3xagzb6vmdqoCYM
         ZqeQ==
X-Gm-Message-State: APjAAAXH5Kp4pRbIaBdYD3yzZPYpeW4XphvOaO1ZIzlbIDo82fjg4TNm
        yqax4D+pRXC7SwH1bGvXCD6lmUpxPfI=
X-Google-Smtp-Source: APXvYqw12LD1S7dWyNt8K4veHZTetzZHDJySogKSrwomURbIqoBKCF62TKMwIcEPsFnWsw8Gl3Dm9A==
X-Received: by 2002:a50:cdd4:: with SMTP id h20mr32429048edj.114.1557781939311;
        Mon, 13 May 2019 14:12:19 -0700 (PDT)
Received: from evledraar (dhcp-077-251-215-224.chello.nl. [77.251.215.224])
        by smtp.gmail.com with ESMTPSA id cg25sm1338252ejb.15.2019.05.13.14.12.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 13 May 2019 14:12:18 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Ben Avison <bavison@riscosopen.org>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] clone: add `--remote-submodules` flag
References: <20190513175903.126079-1-bavison@riscosopen.org>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <20190513175903.126079-1-bavison@riscosopen.org>
Date:   Mon, 13 May 2019 23:12:17 +0200
Message-ID: <87sgtivz2m.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, May 13 2019, Ben Avison wrote:

> @@ -792,6 +795,11 @@ static int checkout(int submodule_progress)
>  		if (option_verbosity < 0)
>  			argv_array_push(&args, "--quiet");
>
> +		if (option_remote_submodules == 1) {

I see you copied this from code above the context, but to check a bool
variable just use "if (var)" not "if (var == 1)".

> +test_expect_success 'check the default is --no-remote-submodules' '
> +	test_when_finished "rm -rf super_clone" &&
> +	git clone --recurse-submodules --no-remote-submodules "file://$pwd/." super_clone &&
> +	(
> +		cd super_clone/sub &&
> +		git diff --exit-code sub_when_added_to_super
> +	)
> +'

This isn't testing the default, it just tests --no-remote-submodules,
i.e. if you change the "static int" assignment to "1" (to make this new
option the default) all these tests will still pass.

Just fixing that means we finally test for this (the entire test suite
would pass before with this on, showing a concerning lack of test
coverage in the submodule tests...), but with just
s/--no-remote-submodules // here we'll test for it.

You might want to have another test to explicitly check what happens
with --no-remote-submodules, but I don't think it's worth the effort, at
that point you're just testing the getopt machinery.
