Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9A8AB208EB
	for <e@80x24.org>; Mon,  6 Aug 2018 18:25:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732230AbeHFUf3 (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Aug 2018 16:35:29 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:54720 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728936AbeHFUf2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Aug 2018 16:35:28 -0400
Received: by mail-wm0-f67.google.com with SMTP id c14-v6so14761644wmb.4
        for <git@vger.kernel.org>; Mon, 06 Aug 2018 11:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=FoBOkhphq4vxj7/If/TjEAyE/JLUmNXdBgop+bUhLB8=;
        b=JM3nB2UviYp6ttkM4AZz2lQuzRgAdYV21sifjl9wJU5bb1pGtIv3TNVRUNwXcfP2R6
         HDyqgkqpq0i98BIiAqIXRjToVTAfv2tI78LKuxmNl1T9ylY28UUVTo33fBNKaZBc3Dl8
         Y7MYK1l9cK4QV9RaJiugdJdGPSasB76oeDCyvIOjqIBALNKSkv+xu1dGsQp3Fppozn8o
         iz85/fyJPdCltNEy0XWlzKJpxqwlbhIy9aYbrYuGkHVYpRbcyg6WFJE4CPqBn7bKp/pj
         4Wgfkien8KW6I/JDFUCvqE5X5lgEBWQ/NGPM96B7AEJ5T1PC1zNLIbaH6TFfe4c394VD
         k4Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=FoBOkhphq4vxj7/If/TjEAyE/JLUmNXdBgop+bUhLB8=;
        b=uEygfcfnfk5MYpuv2I75eMNZtUp25s1kc90EsPi7SmuG90ZZc1xDjmRcg54NNSRdcc
         zeK8Dl/ONQhrLeQ+koSHHQrvRS/taYANhjqV8VfAhugRLWcw90twAVZOxeLEC510VaFL
         eRBHgFV/g0Q7C627cgNlOoIrX/T2qQ8staWGy5AJ5LQZ72KX2TiP/YOlPwUEtnKyDmPE
         EQ5V9SiNez5cSAIY4+E/t5fHFYtaGpjvy4ZhevjR2AaxR4wKBAbXVwVThZLUI3IJqKQi
         OonxlQscZQqxekoQco4fbcbldW3YLYPir+589MNs0LQvKWXbZaCZKesAXTyZ58/uuem3
         lyHw==
X-Gm-Message-State: AOUpUlHyftwSfBfxsPNhRwIA4rg1/shd/yTUrheihzoeDwewiphBj7l5
        dQZqC8RfOHYKz7YbNXYTW4g=
X-Google-Smtp-Source: AAOMgpc6VsCmCVXfmd7TXJExb6XhMsWXHGUq/PzIzib/kr+favBaDzvD3EMEzBU3RLcP8yJbe85AHA==
X-Received: by 2002:a1c:4885:: with SMTP id v127-v6mr12168690wma.161.1533579909006;
        Mon, 06 Aug 2018 11:25:09 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id t6-v6sm9077662wmf.8.2018.08.06.11.25.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 06 Aug 2018 11:25:08 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH] add a script to diff rendered documentation
References: <20180803205204.GA3790@sigill.intra.peff.net>
        <20180806173720.GA5508@sigill.intra.peff.net>
Date:   Mon, 06 Aug 2018 11:25:07 -0700
In-Reply-To: <20180806173720.GA5508@sigill.intra.peff.net> (Jeff King's
        message of "Mon, 6 Aug 2018 13:37:20 -0400")
Message-ID: <xmqqy3djnyik.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> +while test $# -gt 0
> +do
> +	case "$1" in
> +	-j)
> +		parallel=${1#-j} ;;

This is curious.  Did you mean "-j*)" on the line above this one?

> +	-f)
> +		force=t ;;
> +	--)
> +		shift; break ;;
> +	*)
> +		usage ;;
> +	esac
> +	shift
> +done
> +
> +if test -z "$parallel"
> +then

Then "script -j" (no explicit number) would get here and autodetect.
Running the script without any "-j" would also get an empty parallel
and come here.

So "script -j1" would be how a user would say "I want to use exactly
one process, not any parallelism", which makes sense.

> +	parallel=$(getconf _NPROCESSORS_ONLN 2>/dev/null)
> +	if test $? != 0 || test -z "$parallel"
> +	then
> +		parallel=1
> +	fi
> +fi
