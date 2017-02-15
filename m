Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 821182013A
	for <e@80x24.org>; Wed, 15 Feb 2017 18:39:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751583AbdBOSjv (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Feb 2017 13:39:51 -0500
Received: from mail-pf0-f195.google.com ([209.85.192.195]:34201 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751067AbdBOSju (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Feb 2017 13:39:50 -0500
Received: by mail-pf0-f195.google.com with SMTP id o64so8324270pfb.1
        for <git@vger.kernel.org>; Wed, 15 Feb 2017 10:39:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=fqgdvJLyzORGV5j42GxSoRQqTNt7jBAElHyA/6x6+UI=;
        b=lLx2pE9dZGZGUMi9V+9tOpWv+rVelQXfmHy0Vp9dzSN4kbFxgs2zRtofN/4gSxJxjA
         nQueOk5G6d4S039VR7cyO7O6fgoLxPi+XCGFyAqOJjRshQI4UH8VVU7ekbl9SO70qQCD
         DmjyxjC9EbgfESDsTniwp01KOW+K5BvJ16kAdPozmyz7AMvIxyZKcmFX8x+8+9y2Frf0
         s3sAAz+8RjlZO802zarBtXavqb37gdYgmruReMN/82dwyZXAPkXKkOZ0tzg3YR8pyPfH
         iirdvBvURpUROZuYMe+I1tOdpom45TnDpomfNqcmztIgkn4+QhRvLHO2xZo1GVcxrRdU
         chUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=fqgdvJLyzORGV5j42GxSoRQqTNt7jBAElHyA/6x6+UI=;
        b=RxwsRUTacXdlSbP7s60r5EEEa4BAZkNoxpzLEhJOOgc1viTiqyRsjnYLEhvpj5U9g0
         DlVcqUwflywJPZei/FqR1Ol36Ot+jtPiUFgtNQkivrkWqyKAotri7nGpJkDyAWB5B4ee
         4wnNS6JsBqBZRUKlOuZFSSjO6f93BqZpdeZpyrh9xk41JK0n1TljG4iI/KF+foRXt+T3
         XboRY9fqNEzzV1an6JVRzIsku6/UdPXCx5KTL14ocIvIo12AEBjLh4twCvW/oJyvATpw
         47UZm6m54wdl5Lon47qOXKQb4bcVkfVAr40P2N0w5+so6wY5mjgTSCEAp0HiTUvK7ey+
         S4gw==
X-Gm-Message-State: AMke39k5GLWQpbpRZXaWaJ/lLhnynAGXCvaKZfodZtddd8pgL7OrMjRffr877hzbwP4KcQ==
X-Received: by 10.98.86.68 with SMTP id k65mr39103683pfb.13.1487183990108;
        Wed, 15 Feb 2017 10:39:50 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:3551:31c7:1fe1:8b9b])
        by smtp.gmail.com with ESMTPSA id o18sm8926608pgn.36.2017.02.15.10.39.49
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 15 Feb 2017 10:39:49 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     git@vger.kernel.org, sbeller@google.com
Subject: Re: [PATCH v1] t7400: cleanup "submodule add clone shallow submodule" test
References: <20170215111704.78320-1-larsxschneider@gmail.com>
        <20170215113325.14393-1-larsxschneider@gmail.com>
Date:   Wed, 15 Feb 2017 10:39:48 -0800
In-Reply-To: <20170215113325.14393-1-larsxschneider@gmail.com> (Lars
        Schneider's message of "Wed, 15 Feb 2017 12:33:25 +0100")
Message-ID: <xmqq4lzv47t7.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Lars Schneider <larsxschneider@gmail.com> writes:

> The test creates a "super" directory that is not removed after the
> test finished. This directory is not used in any subsequent tests and
> should therefore be removed.
>
> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
> ---
>
> I just noticed that my bug report test does not run properly without this
> patch: http://public-inbox.org/git/20170215111704.78320-1-larsxschneider@gmail.com/
>
> @Junio: I think this patch should be applied regardless of the bug.

Without the other one, this is not strictly needed, but I agree that
it is a good code hygiene to make sure each test cleans up after
itself.

Is this the only one that needs change in the script from that
"hygiene" point of view, or are there others?  An alternative that
is also acceptable is to squash this one into the other patch.

>  t/t7400-submodule-basic.sh | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
> index b77cce8e40..08df483280 100755
> --- a/t/t7400-submodule-basic.sh
> +++ b/t/t7400-submodule-basic.sh
> @@ -1078,6 +1078,7 @@ test_expect_success 'submodule with UTF-8 name' '
>  '
>
>  test_expect_success 'submodule add clone shallow submodule' '
> +	test_when_finished "rm -rf super" &&
>  	mkdir super &&
>  	pwd=$(pwd) &&
>  	(
>
> base-commit: 3b9e3c2cede15057af3ff8076c45ad5f33829436
> --
> 2.11.0
