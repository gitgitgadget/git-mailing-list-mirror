Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2FED81F597
	for <e@80x24.org>; Tue, 31 Jul 2018 20:51:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732180AbeGaWdo (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Jul 2018 18:33:44 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35249 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732147AbeGaWdo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Jul 2018 18:33:44 -0400
Received: by mail-wm0-f68.google.com with SMTP id o18-v6so4618404wmc.0
        for <git@vger.kernel.org>; Tue, 31 Jul 2018 13:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=FrbpjhnvK/E33qMuzxxBxdQyxYgB5pL0cHKJF7eRrtg=;
        b=X1p1ToMA9TGxuJC4z0tP6eJoEauu4VTHBcx0cmaqvdpNwLL/66AKOTdwVL6lM+e+oS
         E/yP08e7gRVy5HTAj8yqpq1vuJMjLYfdDZJ+ugC3CBIeRaeHZLqbuSncPZJ/eY2mhJl/
         xd62eN1ILsOpl3yy+yhDUKk3h7JwHq1fAyfk83z/JSv0B2dU1rBWm9uGwLwbQFKzbEMr
         3mcKD3XDuOH2XxXHT6nTgGB3O5z6vojvqpgFtzafw37m6SQ5DOxFqshEFhBmIvXFv1ex
         qba4wT/mBX07kt681rgb9Sbzq3t/kWIuBu7tAULDn8SAj4+tDTF3UnMI/wTkYPkoPiJb
         mBHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=FrbpjhnvK/E33qMuzxxBxdQyxYgB5pL0cHKJF7eRrtg=;
        b=mFYZy4G1o+OqWE2yWjX13kMEfF9CC3KvZTOIrS7ps22KX6NhXezO9AzTfQ8AvkfOgW
         QDSCoW0jkrJcxIWgAmblDyZesYaXlsSpDBojD5Swv3sHIMzpqGebdzkrzsYrZDj2n/x+
         cGztPxIVlMGhTML5iaV5JV6YFroZAMt5Oj44wkFAA0U/JTrWKmj/P8uLtLGzwpA2hsXM
         lPPy1k0nBx1Qt/S9U8IxPqjyyXzj9aeTH/k1QLQxKc+QQ4kGpGQ7XP5cobCpaqkbygXL
         IclafasSJaTElq+B38igvYExwQzOCHHDXgpo1lYmTWFFQRjhxRbsYU/3/B7pVznXwZJt
         8/Zg==
X-Gm-Message-State: AOUpUlGuSMAn5jJRUWNCncKkkNZCLxVJZxW1r//1qz9Xc8jG+vDKbk9d
        B69bY1T4qfyNMGBA9GPnIj8=
X-Google-Smtp-Source: AAOMgpexFxErO2nh3bLuQ5mB0bsIspciQN+LZitVd1d52VoOnLYuYYyIsHz6IqmRQ3qNMpWj94FAkA==
X-Received: by 2002:a1c:6a0b:: with SMTP id f11-v6mr762819wmc.107.1533070294148;
        Tue, 31 Jul 2018 13:51:34 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id w3-v6sm9306602wrn.16.2018.07.31.13.51.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 31 Jul 2018 13:51:33 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Johannes.Schindelin@gmx.de, git@vger.kernel.org,
        sunshine@sunshineco.com
Subject: Re: [PATCH 2/8] t3206: add color test for range-diff --dual-color
References: <20180728030448.192177-1-sbeller@google.com>
        <20180731003141.105192-1-sbeller@google.com>
        <20180731003141.105192-3-sbeller@google.com>
Date:   Tue, 31 Jul 2018 13:51:33 -0700
In-Reply-To: <20180731003141.105192-3-sbeller@google.com> (Stefan Beller's
        message of "Mon, 30 Jul 2018 17:31:35 -0700")
Message-ID: <xmqqmuu79lii.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> The 'expect'ed outcome has been taken by running the 'range-diff | decode'.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  t/t3206-range-diff.sh | 39 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 39 insertions(+)
>
> diff --git a/t/t3206-range-diff.sh b/t/t3206-range-diff.sh
> index 2237c7f4af9..019724e61a0 100755
> --- a/t/t3206-range-diff.sh
> +++ b/t/t3206-range-diff.sh
> @@ -142,4 +142,43 @@ test_expect_success 'changed message' '
>  	test_cmp expected actual
>  '
>  
> +test_expect_success 'dual-coloring' '
> +	cat >expect <<-\EOF &&

It is a good idea to use something like "sed -e 's/^|//'" instead of
"cat" here; that way allows you to mark the left-edge of the data
with "|", for a test vector like this one that has a line that would
otherwise violate the whitespace style rules.  

An inferiour alternative would be to add .gitaddtibute entry to make
this file exempt from indent-with-tab rule, but even in this 40-line
block there only is one line that requires such a workaround, and it
won't help the initial application of this patch to get modified
when applied with "am --whitespace=fix".

> +	<YELLOW>1:  a4b3333 = 1:  f686024 s/5/A/<RESET>
> +	<RED>2:  f51d370 <RESET><YELLOW>!<RESET><GREEN> 2:  4ab067d<RESET><YELLOW> s/4/A/<RESET>
> +	    <REVERSE><CYAN>@@ -2,6 +2,8 @@<RESET>
> +	     <RESET>
> +	         s/4/A/<RESET>
> +	     <RESET>
> +	    <REVERSE><GREEN>+<RESET> <BOLD>   Also a silly comment here!<RESET>
> +	    <REVERSE><GREEN>+<RESET>
> +	     diff --git a/file b/file<RESET>
> +	    <RED> --- a/file<RESET>
> +	    <GREEN> +++ b/file<RESET>
> +	<RED>3:  0559556 <RESET><YELLOW>!<RESET><GREEN> 3:  b9cb956<RESET><YELLOW> s/11/B/<RESET>
> +	    <REVERSE><CYAN>@@ -10,7 +10,7 @@<RESET>
> +	      9<RESET>
> +	      10<RESET>
> +	    <RED> -11<RESET>
> +	    <REVERSE><RED>-<RESET><FAINT;GREEN>+BB<RESET>
> +	    <REVERSE><GREEN>+<RESET><BOLD;GREEN>+B<RESET>
> +	      12<RESET>
> +	      13<RESET>
> +	      14<RESET>
> +	<RED>4:  d966c5c <RESET><YELLOW>!<RESET><GREEN> 4:  8add5f1<RESET><YELLOW> s/12/B/<RESET>
> +	    <REVERSE><CYAN>@@ -8,7 +8,7 @@<RESET>
> +	    <CYAN> @@<RESET>
> +	      9<RESET>
> +	      10<RESET>
> +	    <REVERSE><RED>-<RESET><FAINT> BB<RESET>
> +	    <REVERSE><GREEN>+<RESET> <BOLD>B<RESET>
> +	    <RED> -12<RESET>
> +	    <GREEN> +B<RESET>
> +	      13<RESET>
> +	EOF
> +	git range-diff changed...changed-message --color --dual-color >actual.raw &&
> +	test_decode_color >actual <actual.raw &&
> +	test_cmp expect actual
> +'
> +
>  test_done
