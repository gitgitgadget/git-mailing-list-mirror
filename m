Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 26BD21F453
	for <e@80x24.org>; Fri,  5 Oct 2018 08:16:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728498AbeJEPNp (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Oct 2018 11:13:45 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44311 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727748AbeJEPNp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Oct 2018 11:13:45 -0400
Received: by mail-wr1-f66.google.com with SMTP id 63-v6so12560307wra.11
        for <git@vger.kernel.org>; Fri, 05 Oct 2018 01:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:message-id:user-agent
         :mime-version;
        bh=9kPytFK04/NbG7ohZLNPZBnHnHxJ+i+J+PjBbcY5c0Y=;
        b=qZE2bp6qIy6legomQyELhHbEGEcD6w+CRlhQmVgFXlp38vm6BxHguzAxIXtxzkNiLJ
         26ie3o0yFY6j1hDVgdvDQDSwjdQXGj6jVrFBXzRFrzvOFMqtbD9sx5QjVff2GBQZVPK7
         Ieu2f/R0lnY0YYYV6lLEXq4ZiKH6bKLdMpgZi0rSoRPAw23O8ur4UhEtOCuMEWFim6a+
         9hjKPFTOaLN7ys9sHImI5xfWko9E93Rts4xy/P/oRhmAJ49IMV+XkuUH+IvmEWJtEZ1C
         TOh+Kb3KCZv2Q2sFOiNjdzTorSFU9JqWRWOMLbMr1G1aDHNdR8MC1pcQPIlDvXa/AIGb
         xAJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :message-id:user-agent:mime-version;
        bh=9kPytFK04/NbG7ohZLNPZBnHnHxJ+i+J+PjBbcY5c0Y=;
        b=Kr+VnOQ5Hsg0wuymYsVo+oORGlkchJrMtyssxUyJmIOZx9maTGYUFRaTk6YD/QnfiH
         oyyhCXnT2UCPBzb+QT6o1ZLOGsbRYm1tftBCLtNyc16u5zEw723fuIwiGOpNHUMIJv9O
         hdPoRno9uQpOdNUqG9xlFQmaXsHPpDFW9QMB6yZEqUwB3Jvj3RQB0Yx0n9i2kMFMk6nW
         8v7DDBwZeY/SY/TQ9Xhr9z+M3jeWurYZaBXU5H3a5EMIwG0tiUREyGk33MSycE2EFeS0
         97vrVn7oPuxYl5ST8TqfUdBijQk7oa1ChjnC+XHBdsAN8aYWvY1BGtZ22xl5/Shq3Diu
         uKVA==
X-Gm-Message-State: ABuFfoj9urtgaryoty4fpNSZPBjrUPeqmCzaIbf2jqJ+Q9GzTVMzsc64
        FVdbEc7nPxXUZIXt4ZMrq6maJRupV5c=
X-Google-Smtp-Source: ACcGV61merWA5k8Kg8xT3EtPzmkOTuQ4TggH0pU11hPMXU0fqK1/lFwMYN2c8chv+JM8BhXk7VGHbQ==
X-Received: by 2002:adf:b211:: with SMTP id u17-v6mr7052745wra.180.1538727367569;
        Fri, 05 Oct 2018 01:16:07 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id v1-v6sm6301070wrd.24.2018.10.05.01.16.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 05 Oct 2018 01:16:06 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Matthew DeVore <matvore@google.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrn@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>, szeder.dev@gmail.com
Subject: Re: [PATCH v4 7/7] tests: order arguments to git-rev-list properly
References: <cover.1536969438.git.matvore@google.com>
        <cover.1538581868.git.matvore@google.com>
        <bc2b3ec030650c107bd07c63f48bd874bf5f1085.1538581868.git.matvore@google.com>
        <CAMfpvhKyFrYVk53Z5-qkicj5eZWT6B_JBXijPDOazKqaCia9_Q@mail.gmail.com>
Date:   Fri, 05 Oct 2018 01:16:05 -0700
Message-ID: <xmqqtvm0zu4a.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matthew DeVore <matvore@google.com> writes:

> I screwed up by putting the positional argument *after* the
> redirection. Sorry for the mix-up. This is interestingly syntactically
> valid, though bad stylistically. Here is an inter-diff:

Thanks for being careful.  Except for a rather idiomatic 

	echo >&2 message ...

which has redirection at the beginning to emphasize that the output
goes to the standard error stream, I do agree with your "stylistic"
choice of keeping the redirection at the end.

> diff --git a/t/t5616-partial-clone.sh b/t/t5616-partial-clone.sh
> index eeedd1623..6ff614692 100755
> --- a/t/t5616-partial-clone.sh
> +++ b/t/t5616-partial-clone.sh
> @@ -35,7 +35,7 @@ test_expect_success 'setup bare clone for server' '
>  test_expect_success 'do partial clone 1' '
>          git clone --no-checkout --filter=blob:none
> "file://$(pwd)/srv.bare" pc1 &&
>
> -        git -C pc1 rev-list --quiet --objects --missing=print >revs HEAD &&
> +        git -C pc1 rev-list --quiet --objects --missing=print HEAD >revs &&
>          awk -f print_1.awk revs |
>          sed "s/?//" |
>          sort >observed.oids &&
> @@ -93,8 +93,8 @@ test_expect_success 'verify diff causes dynamic
> object fetch' '
>  test_expect_success 'verify blame causes dynamic object fetch' '
>          git -C pc1 blame origin/master -- file.1.txt >observed.blame &&
>          test_cmp expect.blame observed.blame &&
> -        git -C pc1 rev-list --quiet --objects --missing=print >observed \
> -                master..origin/master &&
> +        git -C pc1 rev-list --quiet --objects --missing=print \
> +                master..origin/master >observed &&
>          test_line_count = 0 observed
>  '
