Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DD62D1F453
	for <e@80x24.org>; Thu, 21 Feb 2019 20:43:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726183AbfBUUnP (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Feb 2019 15:43:15 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45603 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725866AbfBUUnP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Feb 2019 15:43:15 -0500
Received: by mail-wr1-f65.google.com with SMTP id w17so32057405wrn.12
        for <git@vger.kernel.org>; Thu, 21 Feb 2019 12:43:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=T65zdVe763MnTRmZ2kb7iwh+1eoD6L2ZK3llDoDLQgo=;
        b=lC13vIFj1NsP2FlnNypqmWP64vWqQg9N1ow6A19lmucX1QYUOQB1T9Q1oCh1z9jclL
         DibdVhqMrot3mCEN42SLlZSPkp3g+rpxkM7vKa+X1ZO/2kcJ/rb8L5qMQ9W0ZLOh6Klf
         kXBM+zXQJdDHGTi+VOurWM98ngJ0sNefOTS6uyTOg7ptxh+fBlLnS1z5jUQ7KyMDUoPj
         1l+25DwgBnLI/NzyynrPbwg7tHrEgyXg09YLNWeIhnfe3SB/8VQOM/jPZeRhHIEKiFmu
         YFOVtkRaVYeYGvP51Bu0j2wp75vVyVHJDVPWV7D4EfrovBXc3a1Rh4eDhFrLQCvjV7+9
         wGww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=T65zdVe763MnTRmZ2kb7iwh+1eoD6L2ZK3llDoDLQgo=;
        b=t81grTn6+aa9hkzbffeYoeIitkIN7dUU6a+huy9iLSghbL3D1u1xbB1Ret5pxkcAQR
         wcceP7QoPvlMUBMjFCa48wcgo8z7juR6z7efSYJYYpzHsau8MRJ7L9FdX1Z3xkIo/ILL
         dmuMcAXvRpejfG/myh8epm2gpah3yNgKC5d1mr3YtO0K1jf9Hrqx1z66hvZYC4uJZ34G
         9+l58wEUoDaRdsZQU3eekL7zDgz+BojCOZ+mKFWYwLNj1u3xbNfnGCuUbIVepmw4dCpX
         iRyBj2PEAw1UjY5lrcpYEqEpy9FP52D86h4ciR57bSvI8UCAANgRLIZpoEcn3yslT8WH
         DvjA==
X-Gm-Message-State: AHQUAuZl5HknOaVfQG4Z7JaKHPC7BVZZgwKjZmEoVYoaWCJOzdiJOnih
        RO+LOkjQO4iOf/+PP4IlFBE=
X-Google-Smtp-Source: AHgI3IY/VQ9wLbfalZWO0vgzyhHzxK4VMJW956LpcVuD6mphgI64ncW8Ddg3N3CwGctkNZjNTwMg5A==
X-Received: by 2002:a5d:6107:: with SMTP id v7mr311857wrt.78.1550781793832;
        Thu, 21 Feb 2019 12:43:13 -0800 (PST)
Received: from szeder.dev (x4db54a94.dyn.telefonica.de. [77.181.74.148])
        by smtp.gmail.com with ESMTPSA id o8sm10488752wma.1.2019.02.21.12.43.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Feb 2019 12:43:12 -0800 (PST)
Date:   Thu, 21 Feb 2019 21:43:10 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Sebastian Staudt <koraktor@gmail.com>,
        Josh Steadmon <steadmon@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/2] commit-graph tests: fix cryptic unportable "dd"
 invocation
Message-ID: <20190221204310.GS1622@szeder.dev>
References: <xmqq8sybz7b2.fsf@gitster-ct.c.googlers.com>
 <20190221192849.6581-3-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190221192849.6581-3-avarab@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 21, 2019 at 08:28:49PM +0100, Ævar Arnfjörð Bjarmason wrote:
> Change an unportable invocation of "dd" that truncated the
> commit-graph to call Perl's truncate() function instead.
> 
> In POSIX it is unspecified what happens when count=0 is
> provided[1]. The NetBSD "dd" behavior differs from GNU (and seemingly
> other BSDs), which as left this test broken since
> d2b86fbaa1 ("commit-graph: fix buffer read-overflow", 2019-01-15).
> 
> In POSIX the truncate(2) and ftruncate(2) functions are
> portable. We've used the latter since 271421cd34 ("Update partial HTTP
> transfers.", 2005-09-30), but the truncate(1) command-line tool is
> GNU-specific. Thus let's use Perl's version of it. We could also just
> introduce a "test-tool truncate" in the future if we wanted to avoid
> shelling out to perl.
> 
> On Linux and NetBSD we don't need the "if -s $ARGV[0] > $ARGV[1]"
> condition I'm adding. We never have a $zero_pos longer than the file
> being truncated. But let's have that condition to future-proof the
> code, and because "the behavior is undefined if LENGTH is greater than
> the length of the file" (perldoc -f truncate).
> 
> 1. http://pubs.opengroup.org/onlinepubs/9699919799/utilities/dd.html
> 
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>  t/t5318-commit-graph.sh | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
> index d4bd1522fe..d99bea6cce 100755
> --- a/t/t5318-commit-graph.sh
> +++ b/t/t5318-commit-graph.sh
> @@ -382,7 +382,8 @@ corrupt_graph_and_verify() {
>  	test_when_finished mv commit-graph-backup $objdir/info/commit-graph &&
>  	cp $objdir/info/commit-graph commit-graph-backup &&
>  	printf "$data" | dd of="$objdir/info/commit-graph" bs=1 seek="$pos" conv=notrunc &&
> -	dd of="$objdir/info/commit-graph" bs=1 seek="$zero_pos" count=0 &&
> +	perl -we 'truncate $ARGV[0], $ARGV[1] if -s $ARGV[0] > $ARGV[1]' \
> +		$objdir/info/commit-graph $zero_pos &&

This will make Dscho unhappy :)

Is there a problem with:

  dd if=/dev/null of="$objdir/info/commit-graph" bs=1 seek="$zero_pos"

?

To my understanding of the specs it's well-defined what it should do,
even when $zero_pos is larget than the file size,  it's shorter,
simpler, and doesn't introduce yet another Perl dependency.


>  	generate_zero_bytes $(($orig_size - $zero_pos)) >>"$objdir/info/commit-graph" &&
>  	test_must_fail git commit-graph verify 2>test_err &&
>  	grep -v "^+" test_err >err &&
> -- 
> 2.21.0.rc0.258.g878e2cd30e
> 
