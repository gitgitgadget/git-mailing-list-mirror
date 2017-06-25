Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ED04F2082F
	for <e@80x24.org>; Sun, 25 Jun 2017 22:15:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751424AbdFYWPg (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Jun 2017 18:15:36 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:33418 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751363AbdFYWPf (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Jun 2017 18:15:35 -0400
Received: by mail-pg0-f67.google.com with SMTP id u62so13119902pgb.0
        for <git@vger.kernel.org>; Sun, 25 Jun 2017 15:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=3SOqxiZvlIcjTwJKtnUSk7JsKj8X5UEPeSdYwRt5z18=;
        b=j8WxV1fRsM78YXysI47jv6ryBO/Fnle5YszdrrLnZD3eYbINOBjo0ntZgX/px53Z80
         WQ2uY4ctrnmSR7AGFI5/N/WgKtsDc6377JBtBIN1C1SDpVBMNopmlypsXiY0rVHOxsdU
         YriQ0J0n/Cu71n1FkF0Rip+TZTrckQE7YaWHrbGNSOJFJrdA3A5Jg29c/xuBrm2psPjK
         wwbv3/QA+c81htNyFUuXEqzAvXxhJX4dA8AGzdqMKQZ+byUYtwTT10/Gsw6wBYGgscOp
         lXMiREqm3BY1OopEs78sEQa9A64R9TCxFjk1EreXC9Rl3RNoUG/209r/YfXUw4ZR0hip
         QZXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=3SOqxiZvlIcjTwJKtnUSk7JsKj8X5UEPeSdYwRt5z18=;
        b=RzsbhaCj3+DSADlDY4rJ5wRMsY2TYHKKKyB0jyEMTfvSv9q7H74lLcs7UDKGD/TcoO
         SCHgbEXOzfmA/X6zjBn1121PKliciUyltVUeyse3qNlhlLwjz4O+yVJI3MCWFxMXFGmY
         06y/7grql3Yt0ibuTPYqCiqG0uQNPRUQwTI3pqhVnOyolWreLCOO/vNeqSooMJ0rGsJU
         lwQH6AaXmKZ69LVNtrgaAaIXaM5mEbKDqN6I+wsQmCfsDvSIyINFcOJfkpqELcjqS2qx
         x8/EqesWg1YBB88kazPhZDYVoOUY4wItSNp0BSodAhz25LxXPeAnWe/nH0Cal++GDAIP
         /8hQ==
X-Gm-Message-State: AKS2vOz1ZAO8clTT3yJEdLgKyKitxMy7H3/zlySTm8vR++9190iabEwL
        PqoQHV+Vd0GsQQ==
X-Received: by 10.84.129.67 with SMTP id 61mr20598474plb.229.1498428934388;
        Sun, 25 Jun 2017 15:15:34 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:644d:1257:a024:dc49])
        by smtp.gmail.com with ESMTPSA id 66sm22526012pfm.82.2017.06.25.15.15.33
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sun, 25 Jun 2017 15:15:33 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net, tboegi@web.de, e@80x24.org,
        ttaylorr@github.com, peartben@gmail.com
Subject: Re: [PATCH v6 2/6] t0021: make debug log file name configurable
References: <20170625182125.6741-1-larsxschneider@gmail.com>
        <20170625182125.6741-3-larsxschneider@gmail.com>
Date:   Sun, 25 Jun 2017 15:15:32 -0700
In-Reply-To: <20170625182125.6741-3-larsxschneider@gmail.com> (Lars
        Schneider's message of "Sun, 25 Jun 2017 20:21:21 +0200")
Message-ID: <xmqqpodr7lyz.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Lars Schneider <larsxschneider@gmail.com> writes:

> The "rot13-filter.pl" helper wrote its debug logs always to "rot13-filter.log".
> Make this configurable by defining the log file as first parameter of
> "rot13-filter.pl".
>
> This is useful if "rot13-filter.pl" is configured multiple times similar to the
> subsequent patch 'convert: add "status=delayed" to filter process protocol'.

Makes sense.  If you didn't rename the output file to "debug.log"
the patch may have been less noisy (because you do not have to touch
the test_cmp_count calls), but I am guessing that it helped you to
make sure that you covered all the existing users of rot13 filter,
so I am OK with that part of the change as well.

Looks good.  Thanks.

>
> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
> ---
>  t/t0021-conversion.sh   | 44 ++++++++++++++++++++++----------------------
>  t/t0021/rot13-filter.pl |  8 +++++---
>  2 files changed, 27 insertions(+), 25 deletions(-)
>
> diff --git a/t/t0021-conversion.sh b/t/t0021-conversion.sh
> index ff2424225b..0139b460e7 100755
> --- a/t/t0021-conversion.sh
> +++ b/t/t0021-conversion.sh
> @@ -28,7 +28,7 @@ file_size () {
>  }
>  
>  filter_git () {
> -	rm -f rot13-filter.log &&
> +	rm -f *.log &&
>  	git "$@"
>  }
>  
> @@ -342,7 +342,7 @@ test_expect_success 'diff does not reuse worktree files that need cleaning' '
>  '
>  
>  test_expect_success PERL 'required process filter should filter data' '
> -	test_config_global filter.protocol.process "rot13-filter.pl clean smudge" &&
> +	test_config_global filter.protocol.process "rot13-filter.pl debug.log clean smudge" &&
>  	test_config_global filter.protocol.required true &&
>  	rm -rf repo &&
>  	mkdir repo &&
> @@ -375,7 +375,7 @@ test_expect_success PERL 'required process filter should filter data' '
>  			IN: clean testsubdir/test3 '\''sq'\'',\$x=.r $S3 [OK] -- OUT: $S3 . [OK]
>  			STOP
>  		EOF
> -		test_cmp_count expected.log rot13-filter.log &&
> +		test_cmp_count expected.log debug.log &&
>  
>  		git commit -m "test commit 2" &&
>  		rm -f test2.r "testsubdir/test3 '\''sq'\'',\$x=.r" &&
> @@ -388,7 +388,7 @@ test_expect_success PERL 'required process filter should filter data' '
>  			IN: smudge testsubdir/test3 '\''sq'\'',\$x=.r $S3 [OK] -- OUT: $S3 . [OK]
>  			STOP
>  		EOF
> -		test_cmp_exclude_clean expected.log rot13-filter.log &&
> +		test_cmp_exclude_clean expected.log debug.log &&
>  
>  		filter_git checkout --quiet --no-progress empty-branch &&
>  		cat >expected.log <<-EOF &&
> @@ -397,7 +397,7 @@ test_expect_success PERL 'required process filter should filter data' '
>  			IN: clean test.r $S [OK] -- OUT: $S . [OK]
>  			STOP
>  		EOF
> -		test_cmp_exclude_clean expected.log rot13-filter.log &&
> +		test_cmp_exclude_clean expected.log debug.log &&
>  
>  		filter_git checkout --quiet --no-progress master &&
>  		cat >expected.log <<-EOF &&
> @@ -409,7 +409,7 @@ test_expect_success PERL 'required process filter should filter data' '
>  			IN: smudge testsubdir/test3 '\''sq'\'',\$x=.r $S3 [OK] -- OUT: $S3 . [OK]
>  			STOP
>  		EOF
> -		test_cmp_exclude_clean expected.log rot13-filter.log &&
> +		test_cmp_exclude_clean expected.log debug.log &&
>  
>  		test_cmp_committed_rot13 "$TEST_ROOT/test.o" test.r &&
>  		test_cmp_committed_rot13 "$TEST_ROOT/test2.o" test2.r &&
> @@ -419,7 +419,7 @@ test_expect_success PERL 'required process filter should filter data' '
>  
>  test_expect_success PERL 'required process filter takes precedence' '
>  	test_config_global filter.protocol.clean false &&
> -	test_config_global filter.protocol.process "rot13-filter.pl clean" &&
> +	test_config_global filter.protocol.process "rot13-filter.pl debug.log clean" &&
>  	test_config_global filter.protocol.required true &&
>  	rm -rf repo &&
>  	mkdir repo &&
> @@ -439,12 +439,12 @@ test_expect_success PERL 'required process filter takes precedence' '
>  			IN: clean test.r $S [OK] -- OUT: $S . [OK]
>  			STOP
>  		EOF
> -		test_cmp_count expected.log rot13-filter.log
> +		test_cmp_count expected.log debug.log
>  	)
>  '
>  
>  test_expect_success PERL 'required process filter should be used only for "clean" operation only' '
> -	test_config_global filter.protocol.process "rot13-filter.pl clean" &&
> +	test_config_global filter.protocol.process "rot13-filter.pl debug.log clean" &&
>  	rm -rf repo &&
>  	mkdir repo &&
>  	(
> @@ -462,7 +462,7 @@ test_expect_success PERL 'required process filter should be used only for "clean
>  			IN: clean test.r $S [OK] -- OUT: $S . [OK]
>  			STOP
>  		EOF
> -		test_cmp_count expected.log rot13-filter.log &&
> +		test_cmp_count expected.log debug.log &&
>  
>  		rm test.r &&
>  
> @@ -474,12 +474,12 @@ test_expect_success PERL 'required process filter should be used only for "clean
>  			init handshake complete
>  			STOP
>  		EOF
> -		test_cmp_exclude_clean expected.log rot13-filter.log
> +		test_cmp_exclude_clean expected.log debug.log
>  	)
>  '
>  
>  test_expect_success PERL 'required process filter should process multiple packets' '
> -	test_config_global filter.protocol.process "rot13-filter.pl clean smudge" &&
> +	test_config_global filter.protocol.process "rot13-filter.pl debug.log clean smudge" &&
>  	test_config_global filter.protocol.required true &&
>  
>  	rm -rf repo &&
> @@ -514,7 +514,7 @@ test_expect_success PERL 'required process filter should process multiple packet
>  			IN: clean 3pkt_2+1.file $(($S*2+1)) [OK] -- OUT: $(($S*2+1)) ... [OK]
>  			STOP
>  		EOF
> -		test_cmp_count expected.log rot13-filter.log &&
> +		test_cmp_count expected.log debug.log &&
>  
>  		rm -f *.file &&
>  
> @@ -529,7 +529,7 @@ test_expect_success PERL 'required process filter should process multiple packet
>  			IN: smudge 3pkt_2+1.file $(($S*2+1)) [OK] -- OUT: $(($S*2+1)) ... [OK]
>  			STOP
>  		EOF
> -		test_cmp_exclude_clean expected.log rot13-filter.log &&
> +		test_cmp_exclude_clean expected.log debug.log &&
>  
>  		for FILE in *.file
>  		do
> @@ -539,7 +539,7 @@ test_expect_success PERL 'required process filter should process multiple packet
>  '
>  
>  test_expect_success PERL 'required process filter with clean error should fail' '
> -	test_config_global filter.protocol.process "rot13-filter.pl clean smudge" &&
> +	test_config_global filter.protocol.process "rot13-filter.pl debug.log clean smudge" &&
>  	test_config_global filter.protocol.required true &&
>  	rm -rf repo &&
>  	mkdir repo &&
> @@ -558,7 +558,7 @@ test_expect_success PERL 'required process filter with clean error should fail'
>  '
>  
>  test_expect_success PERL 'process filter should restart after unexpected write failure' '
> -	test_config_global filter.protocol.process "rot13-filter.pl clean smudge" &&
> +	test_config_global filter.protocol.process "rot13-filter.pl debug.log clean smudge" &&
>  	rm -rf repo &&
>  	mkdir repo &&
>  	(
> @@ -579,7 +579,7 @@ test_expect_success PERL 'process filter should restart after unexpected write f
>  		git add . &&
>  		rm -f *.r &&
>  
> -		rm -f rot13-filter.log &&
> +		rm -f debug.log &&
>  		git checkout --quiet --no-progress . 2>git-stderr.log &&
>  
>  		grep "smudge write error at" git-stderr.log &&
> @@ -595,7 +595,7 @@ test_expect_success PERL 'process filter should restart after unexpected write f
>  			IN: smudge test2.r $S2 [OK] -- OUT: $S2 . [OK]
>  			STOP
>  		EOF
> -		test_cmp_exclude_clean expected.log rot13-filter.log &&
> +		test_cmp_exclude_clean expected.log debug.log &&
>  
>  		test_cmp_committed_rot13 "$TEST_ROOT/test.o" test.r &&
>  		test_cmp_committed_rot13 "$TEST_ROOT/test2.o" test2.r &&
> @@ -609,7 +609,7 @@ test_expect_success PERL 'process filter should restart after unexpected write f
>  '
>  
>  test_expect_success PERL 'process filter should not be restarted if it signals an error' '
> -	test_config_global filter.protocol.process "rot13-filter.pl clean smudge" &&
> +	test_config_global filter.protocol.process "rot13-filter.pl debug.log clean smudge" &&
>  	rm -rf repo &&
>  	mkdir repo &&
>  	(
> @@ -639,7 +639,7 @@ test_expect_success PERL 'process filter should not be restarted if it signals a
>  			IN: smudge test2.r $S2 [OK] -- OUT: $S2 . [OK]
>  			STOP
>  		EOF
> -		test_cmp_exclude_clean expected.log rot13-filter.log &&
> +		test_cmp_exclude_clean expected.log debug.log &&
>  
>  		test_cmp_committed_rot13 "$TEST_ROOT/test.o" test.r &&
>  		test_cmp_committed_rot13 "$TEST_ROOT/test2.o" test2.r &&
> @@ -648,7 +648,7 @@ test_expect_success PERL 'process filter should not be restarted if it signals a
>  '
>  
>  test_expect_success PERL 'process filter abort stops processing of all further files' '
> -	test_config_global filter.protocol.process "rot13-filter.pl clean smudge" &&
> +	test_config_global filter.protocol.process "rot13-filter.pl debug.log clean smudge" &&
>  	rm -rf repo &&
>  	mkdir repo &&
>  	(
> @@ -676,7 +676,7 @@ test_expect_success PERL 'process filter abort stops processing of all further f
>  			IN: smudge abort.r $SA [OK] -- OUT: 0 [ABORT]
>  			STOP
>  		EOF
> -		test_cmp_exclude_clean expected.log rot13-filter.log &&
> +		test_cmp_exclude_clean expected.log debug.log &&
>  
>  		test_cmp "$TEST_ROOT/test.o" test.r &&
>  		test_cmp "$TEST_ROOT/test2.o" test2.r &&
> diff --git a/t/t0021/rot13-filter.pl b/t/t0021/rot13-filter.pl
> index 617f581e56..0b943bb377 100644
> --- a/t/t0021/rot13-filter.pl
> +++ b/t/t0021/rot13-filter.pl
> @@ -2,8 +2,9 @@
>  # Example implementation for the Git filter protocol version 2
>  # See Documentation/gitattributes.txt, section "Filter Protocol"
>  #
> -# The script takes the list of supported protocol capabilities as
> -# arguments ("clean", "smudge", etc).
> +# The first argument defines a debug log file that the script write to.
> +# All remaining arguments define a list of supported protocol
> +# capabilities ("clean", "smudge", etc).
>  #
>  # This implementation supports special test cases:
>  # (1) If data with the pathname "clean-write-fail.r" is processed with
> @@ -24,9 +25,10 @@ use warnings;
>  use IO::File;
>  
>  my $MAX_PACKET_CONTENT_SIZE = 65516;
> +my $log_file                = shift @ARGV;
>  my @capabilities            = @ARGV;
>  
> -open my $debug, ">>", "rot13-filter.log" or die "cannot open log file: $!";
> +open my $debug, ">>", $log_file or die "cannot open log file: $!";
>  
>  sub rot13 {
>  	my $str = shift;
