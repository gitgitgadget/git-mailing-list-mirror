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
	by dcvr.yhbt.net (Postfix) with ESMTP id 258F720248
	for <e@80x24.org>; Sun, 24 Mar 2019 20:56:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727137AbfCXU4b (ORCPT <rfc822;e@80x24.org>);
        Sun, 24 Mar 2019 16:56:31 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34922 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726743AbfCXU4b (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Mar 2019 16:56:31 -0400
Received: by mail-wr1-f65.google.com with SMTP id w1so7881276wrp.2
        for <git@vger.kernel.org>; Sun, 24 Mar 2019 13:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=8FenH2p1v/vfLZh4KVZteIDk4nqkeHkwZCTkNsYFjqk=;
        b=eBrYZbmBvy1srfEeGazXa7nr6xSLI8+AtQVzsqNx7uvULj0mus5h66fVSv5/BjFfNG
         bXWkQy3MjX9kciZs3r/1SUEqHlWJlxyWG78eXWyIlWffUqN5Wy+lKtNQ0Z6hNy+XzwaI
         YOhKw1pQYk8Z/NrNWuY4z2IxOYOmrnp03OagZTV+gAl1ROiGJvRNH1JNWARlsiyCbqS2
         DFBQLr/jx3uTt+/W6Mfv0gBOQ3pnDsI9YwokATs/mqaYRpH9lF+3pN0B2gNDULLzhKnY
         LxlMMFnSJjEnRuktoD4aT8e3u3i2GawYgAruCplaVSD/Fx1Py7yRqqwwB1emLLo2wUmb
         uykQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=8FenH2p1v/vfLZh4KVZteIDk4nqkeHkwZCTkNsYFjqk=;
        b=sVokw4+Px8nmAws84BS5vC5keA9zDrjIxksx7964b+HtEQMKEvjfJouSBZwtGB9Int
         eGPZUTw/5rPJpVjZvxCDHfXeWlmJDNbjDcRvd7Uku4aIRlui2YzeM0TezWuS3S8jMLVQ
         m4yxeEdRU/QKZKuEeOuQIBnr6EaELeFn0oc/vyixm889yJzVOtQsyACTaRYrT1ZVzMmI
         OIr4XWxMlouwkIKi6QxC9M+qI44DyVBAhGbHGjjFRUBrAVC69qj93uV9e/x0FPHekEHK
         5Q20VaqCDAlyUSZzTHkvDvXNWj8LvJWck3+IV6YTiEeNgeWe5+kRDaqsOLga7jUpIY5b
         fNJA==
X-Gm-Message-State: APjAAAX2xT+YheqlerpuHqo5HEXBRHS22ISZNV3h5gan43zypfHNxpSt
        l/W5TO8jAq3HpSbhISNhYd4=
X-Google-Smtp-Source: APXvYqxo5U66tWTSUM+zGavIlQEFhOvHyfz1emwU5iuUj10VRQvNQlKjFIt+N2qPtiivTcnfqdAOIA==
X-Received: by 2002:adf:e547:: with SMTP id z7mr12806287wrm.295.1553460988875;
        Sun, 24 Mar 2019 13:56:28 -0700 (PDT)
Received: from szeder.dev (x4d0c479e.dyn.telefonica.de. [77.12.71.158])
        by smtp.gmail.com with ESMTPSA id b9sm20364644wmc.9.2019.03.24.13.56.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Mar 2019 13:56:28 -0700 (PDT)
Date:   Sun, 24 Mar 2019 21:56:24 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Matheus Tavares <matheus.bernardino@usp.br>
Cc:     git@vger.kernel.org, Thomas Gummerer <t.gummerer@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        kernel-usp@googlegroups.com, Alex Riesen <raa.lkml@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [GSoC][PATCH v4 1/7] clone: test for our behavior on odd
 objects/* content
Message-ID: <20190324205624.GJ22459@szeder.dev>
References: <20190226122829.19178-1-avarab@gmail.com>
 <20190322232237.13293-1-matheus.bernardino@usp.br>
 <20190322232237.13293-2-matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190322232237.13293-2-matheus.bernardino@usp.br>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 22, 2019 at 08:22:31PM -0300, Matheus Tavares wrote:
> From: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> 
> Add tests for what happens when we perform a local clone on a repo
> containing odd files at .git/object directory, such as symlinks to other
> dirs, or unknown files.
> 
> I'm bending over backwards here to avoid a SHA1 dependency. See [1]

s/SHA1/SHA-1/

> for an earlier and simpler version that hardcoded a SHA-1s.

s/SHA-1s/SHA-1/ or s/a SHA-1s/SHA-1s/, depending on what you consider
multiple occurrances of the same SHA-1.

> This behavior has been the same for a *long* time, but hasn't been
> tested for.
> 
> There's a good post-hoc argument to be made for copying over unknown
> things, e.g. I'd like a git version that doesn't know about the
> commit-graph to copy it under "clone --local" so a newer git version
> can make use of it.
> 
> In follow-up commits we'll look at changing some of this behavior, but
> for now let's just assert it as-is so we'll notice what we'll change
> later.
> 
> 1. https://public-inbox.org/git/20190226002625.13022-5-avarab@gmail.com/
> 
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
> Helped-by: Matheus Tavares <matheus.bernardino@usp.br>


> +test_expect_success SYMLINKS 'setup repo with manually symlinked dirs and unknown files at objects/' '
> +	git init T &&
> +	(
> +		cd T &&
> +		test_commit A &&
> +		git gc &&
> +		(
> +			cd .git/objects &&
> +			mv pack packs &&
> +			ln -s packs pack
> +		) &&
> +		test_commit B &&
> +		(
> +			cd .git/objects &&
> +			find ?? -type d >loose-dirs &&
> +			last_loose=$(tail -n 1 loose-dirs) &&
> +			rm -f loose-dirs &&
> +			mv $last_loose a-loose-dir &&
> +			ln -s a-loose-dir $last_loose &&
> +			find . -type f | sort >../../../T.objects-files.raw &&
> +			echo unknown_content> unknown_file
> +		)

Please drop these inner subshells.  They are unnecessary, because the
outer subshell alone is sufficient to ensure that the test script
returns to the original directory if one of the commands were to fail.

> +	) &&
> +	git -C T fsck &&
> +	git -C T rev-list --all --objects >T.objects
> +'
> +
> +
> +test_expect_success SYMLINKS 'clone repo with symlinked dirs and unknown files at objects/' '
> +	for option in --local --no-hardlinks --shared --dissociate
> +	do
> +		git clone $option T T$option || return 1 &&
> +		git -C T$option fsck || return 1 &&
> +		git -C T$option rev-list --all --objects >T$option.objects &&
> +		test_cmp T.objects T$option.objects &&
> +		(
> +			cd T$option/.git/objects &&
> +			find . -type f | sort >../../../T$option.objects-files.raw
> +		)

Nit: this might be a bit easier on the eyes when written as

  ( 
        cd T$option/.git/objects &&
        find . -type f
  ) | sort >T$option.objects-files.raw

because it would avoid that '../../../'.

> +	done &&
> +
> +	for raw in $(ls T*.raw)
> +	do
> +		sed -e "s!/..\$!/X!; s!/../!/Y/!; s![0-9a-f]\{38,\}!Z!" \
> +		    -e "/multi-pack-index/d" -e "/commit-graph/d" <$raw >$raw.de-sha || return 1
> +	done &&
> +
> +	cat >expected-files <<-EOF &&
> +	./Y/Z
> +	./Y/Z
> +	./a-loose-dir/Z
> +	./Y/Z
> +	./info/packs
> +	./pack/pack-Z.idx
> +	./pack/pack-Z.pack
> +	./packs/pack-Z.idx
> +	./packs/pack-Z.pack
> +	./unknown_file
> +	EOF
> +
> +	for option in --local --dissociate --no-hardlinks
> +	do
> +		test_cmp expected-files T$option.objects-files.raw.de-sha || return 1
> +	done &&
> +
> +	cat >expected-files <<-EOF &&
> +	./info/alternates
> +	EOF

Perhaps

  echo ./info/alternates >expected-files

> +	test_cmp expected-files T--shared.objects-files.raw
> +'
> +
>  test_done
> -- 
> 2.20.1
> 
