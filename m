Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AA8121FA21
	for <e@80x24.org>; Thu,  5 Oct 2017 21:59:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751421AbdJEV7Z (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Oct 2017 17:59:25 -0400
Received: from mail-qt0-f176.google.com ([209.85.216.176]:53264 "EHLO
        mail-qt0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751402AbdJEV7Y (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Oct 2017 17:59:24 -0400
Received: by mail-qt0-f176.google.com with SMTP id n61so216953qte.10
        for <git@vger.kernel.org>; Thu, 05 Oct 2017 14:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=A5JY9gsyvdow0iToNZ60KOfEQamy62pbWL1WzmertI0=;
        b=kUKScMqeamYvd65NvL5q9cucAw/I5kUlEjABLK/CnjEt9YIxMSt2AdP6GdNSaprMw8
         Xb9qEf34mvaprO2vx7akfUX+yW2woXiMxQJmgPV2XBSpjYaVsgYRz+xix5dtaORWDp4y
         UIa7U5w3eE6junlTAVY0x0G4gmj2Et00RTLBlUCMU9iDj6eRfSwsez6I4ouQoNxyUZao
         2poTXpb9mbajVu7JatgiAQgWJSV6mLRyN6ZoYLsgIbCqCtDPx/j4aGhvcotze541W6O+
         5t2VApEZx5MNcPIUZv/R9me9wukD59Ak8z1LLFzXq6k3g83stpQftkSVQ6wLfG/IlCFB
         T/Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=A5JY9gsyvdow0iToNZ60KOfEQamy62pbWL1WzmertI0=;
        b=P2T4PLwlSoUnZDyKsL02MLSG8khrpGGhh0lZqe9zycsJRDvXqDPN0GFzNAl3sLdxaR
         VfiTpufesBzOIlWHX1PCEZen3cT1r6xV0BlEbu55mPz1meR8pdHjuX8+K1hX2l4zBuZ4
         ClVNcZv/9PoY0IBW8kuljg+G+J1U6U6BTY1cfXJ/O11dcFkYcoIBnVrEscCELwBq8e70
         42/O+d+/vY80AL/jzSwhSo9Zw9Echhaijm9gRifLfjbtI6HGOeIlYvn4D19PFVO337M3
         Jdl3afW4gZFozCxXwLdaSDKro2hOlHeOMAuyz5vvgRtHnRfXhe0xzhXPGmU1Nf8bBFfa
         Z6DQ==
X-Gm-Message-State: AMCzsaWXQGUL6jVm4VP7f9A1XJaIC6f/qhkvG40UCvYOofX7TcOpv5zo
        dth9LrtSTnKk5TRjjrGiHbjqmzxg99i3FwLrN7jxrA==
X-Google-Smtp-Source: AOwi7QBk4jNMeHPjUABtUliN6KLE4+laQQeueBO0kHwRrhWpqUB2Eb456xjbJiZVrbZeoeczleb5NESHN0Ql03yMeeI=
X-Received: by 10.200.8.53 with SMTP id u50mr165138qth.260.1507240764133; Thu,
 05 Oct 2017 14:59:24 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.102.46 with HTTP; Thu, 5 Oct 2017 14:59:23 -0700 (PDT)
In-Reply-To: <20171005205443.206900-4-jameson.miller81@gmail.com>
References: <20171005205443.206900-1-jameson.miller81@gmail.com> <20171005205443.206900-4-jameson.miller81@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 5 Oct 2017 14:59:23 -0700
Message-ID: <CAGZ79kaP7EthkcbAtuCSiFTU=nG8g-smxk5ZP=K=G5Ez2ZcsSQ@mail.gmail.com>
Subject: Re: [PATCH 3/6] Add tests for git status `--ignored=matching`
To:     Jameson Miller <jameson.miller81@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Brandon Williams <bmwill@google.com>,
        Jameson Miller <jamill@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 5, 2017 at 1:54 PM,  <jameson.miller81@gmail.com> wrote:
> From: Jameson Miller <jamill@microsoft.com>
>
> Add tests for new ignored mode (matching) when showing all untracked
> files.
>
> Signed-off-by: Jameson Miller <jamill@microsoft.com>
> ---
>  t/t7519-ignored-mode.sh | 132 ++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 132 insertions(+)
>  create mode 100755 t/t7519-ignored-mode.sh
>
> diff --git a/t/t7519-ignored-mode.sh b/t/t7519-ignored-mode.sh
> new file mode 100755
> index 0000000000..a8c35d1cbc
> --- /dev/null
> +++ b/t/t7519-ignored-mode.sh
> @@ -0,0 +1,132 @@
> +#!/bin/sh
> +
> +test_description='git status collapse ignored'
> +
> +. ./test-lib.sh
> +
> +# commit initial ignore file
> +test_expect_success 'setup initial commit and ignore file' '

Here and in the following tests, I have the impression that the
leading comment says the same as the test title, so you could
omit the comments, putting all effort into a well word smithed
test title.


> +       cat >.gitignore <<-\EOF &&
> +       *.ign
> +       ignored_dir/
> +       !*.unignore
> +       EOF
> +       git add . &&
> +       test_tick &&

How is timing relevant to these test?

Thanks,
Stefan
