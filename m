Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 240C01F770
	for <e@80x24.org>; Sun, 30 Dec 2018 22:45:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726857AbeL3Wo7 (ORCPT <rfc822;e@80x24.org>);
        Sun, 30 Dec 2018 17:44:59 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50699 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726803AbeL3Wo7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 Dec 2018 17:44:59 -0500
Received: by mail-wm1-f68.google.com with SMTP id n190so22569208wmd.0
        for <git@vger.kernel.org>; Sun, 30 Dec 2018 14:44:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=i5oEo6/jLZ4TzWMx6xwO7VTgJlOPQN8r0F64vDFLAOo=;
        b=sdvaaaFYFeHuKvLBCuhHW8ol4o58LJ9Fn3y4mLYgeh69Tlpk60F7Oq+qMBatVJQI74
         hg5iBGUhHmlnqixM9FQjz/AxyCUFJ7rj2FAwAknI6KRdJlU9SXOwkIZPZckvHX+L7cK2
         Vz7w4y2Hf2QYAv2Fa/8Zo0gDEqY91ATSqetVBNaoOiP0LSBHNbB4tbp9fwF8HOMHWi4s
         iXHjspbRRsesmLanRzN5Q39FosShCbbjxtnNfNH+B6z7gwjhekj/odYTdn7MBualKHGn
         KxJNUvrUzYyMCojgqbLupDAOntZggjgijOjNq8afhFF3q/Pv1E/oDbH2lqgXBnb2g6zS
         WlcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=i5oEo6/jLZ4TzWMx6xwO7VTgJlOPQN8r0F64vDFLAOo=;
        b=OVwMk4x4nKXhuvIoc6W2QBOMvN7parR6jOfTN7Ce1iGsJaoO6QGukQhL8z6vw3KGv9
         4tn0I1ZX6kWIa5XNN6XeVWHT+n4rpbYxjEXQmqkw9cWlT+pl7cqf3ePBv0pRWqZszACj
         OiHEmGDTdfSs2G6zsQ9BtpM7kzqPNurky6vBa1u9UHvlH13ze9svukbBSjBGgH4VZkVO
         TwYNPkhek+ykKtMKvsodRFi/XEMWIZSWT9jzs2VqpQlzP6K539xpOzJEdZGGXmQkrQNG
         OS1ELm51Nbaog/5qJC2oC+QhJu9gfgTWtLvfexhcRxTg4oZjmy2gLfV7iCqF8HMgcXGJ
         +KCA==
X-Gm-Message-State: AA+aEWaQcCpRhtuqKiu+llgkV77KbPO2L37bVVG7g9OYMKpf1r7MM2cp
        l/KsRFrogq0nlbv2+vt8gms=
X-Google-Smtp-Source: AFSGD/XX1pnMaBgcb+t9WyiVLV0JKBuhjzZqNQoUs55nOjF5r33gkiAu36jmy0lSoUEnILX1Z6CT2g==
X-Received: by 2002:a1c:c90b:: with SMTP id f11mr29451025wmb.33.1546209896772;
        Sun, 30 Dec 2018 14:44:56 -0800 (PST)
Received: from szeder.dev (84-236-109-65.pool.digikabel.hu. [84.236.109.65])
        by smtp.gmail.com with ESMTPSA id v5sm38342615wrn.71.2018.12.30.14.44.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Dec 2018 14:44:55 -0800 (PST)
Date:   Sun, 30 Dec 2018 23:44:53 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: [PATCH v3 5/8] test-lib: set $TRASH_DIRECTORY earlier
Message-ID: <20181230224453.GC6120@szeder.dev>
References: <20181209225628.22216-1-szeder.dev@gmail.com>
 <20181230191629.3232-1-szeder.dev@gmail.com>
 <20181230191629.3232-6-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181230191629.3232-6-szeder.dev@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Dec 30, 2018 at 08:16:26PM +0100, SZEDER Gábor wrote:
> A later patch in this series will need to know the path to the trash
> directory early in 'test-lib.sh', but $TRASH_DIRECTORY is set much
> later.  Furthermore, the path to the trash directory depends on the
> '--root=<path>' option, which, too, is parsed too late.
> 
> Move parsing '--root=...' to the early option parsing loop, and set
> $TRASH_DIRECTORY where the other test-specific path variables are set.

Sigh.
After moving the whole option parsing loop, I should have updated this
commit message as well.

Hang on for a sec...


> Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
> ---
>  t/test-lib.sh | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index 41457d1dcf..2b88ba2de1 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -186,6 +186,12 @@ fi
>  TEST_NAME="$(basename "$0" .sh)"
>  TEST_RESULTS_DIR="$TEST_OUTPUT_DIRECTORY/test-results"
>  TEST_RESULTS_BASE="$TEST_RESULTS_DIR/$TEST_NAME"
> +TRASH_DIRECTORY="trash directory.$TEST_NAME"
> +test -n "$root" && TRASH_DIRECTORY="$root/$TRASH_DIRECTORY"
> +case "$TRASH_DIRECTORY" in
> +/*) ;; # absolute path is good
> + *) TRASH_DIRECTORY="$TEST_OUTPUT_DIRECTORY/$TRASH_DIRECTORY" ;;
> +esac
>  
>  # if --tee was passed, write the output not only to the terminal, but
>  # additionally to the file test-results/$BASENAME.out, too.
> @@ -1046,12 +1052,6 @@ then
>  fi
>  
>  # Test repository
> -TRASH_DIRECTORY="trash directory.$TEST_NAME"
> -test -n "$root" && TRASH_DIRECTORY="$root/$TRASH_DIRECTORY"
> -case "$TRASH_DIRECTORY" in
> -/*) ;; # absolute path is good
> - *) TRASH_DIRECTORY="$TEST_OUTPUT_DIRECTORY/$TRASH_DIRECTORY" ;;
> -esac
>  rm -fr "$TRASH_DIRECTORY" || {
>  	GIT_EXIT_OK=t
>  	echo >&5 "FATAL: Cannot prepare test area"
> -- 
> 2.20.1.151.gec613c4b75
> 
