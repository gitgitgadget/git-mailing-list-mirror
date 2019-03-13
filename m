Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 801F120248
	for <e@80x24.org>; Wed, 13 Mar 2019 04:31:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725893AbfCMEb0 (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Mar 2019 00:31:26 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38253 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbfCMEbZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Mar 2019 00:31:25 -0400
Received: by mail-wr1-f65.google.com with SMTP id g12so381279wrm.5
        for <git@vger.kernel.org>; Tue, 12 Mar 2019 21:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=sZOFVtdRWcHgKhT5vIc5qkhp1uEVUcTPIOUyb0okEDc=;
        b=pH24zUoqhQKkwk3/oemwI1qR31uTHm0S+OW1Tv+JxfEcrD1dAEauIDe1fGXWNOw/GQ
         WueV6+8YwEh4MnySxYqUONq0IJydk1vVxnqaXgMIYx5wyiknP5TttZcE5lNNqydikYhZ
         egttRX0Fd1X8kO1E12sXe/JIgnEGQ7R65/k7xuqWrINw6lUMWav3+yHB/P7k1zyOy6K+
         MhU405cPW5lc6fkHzTd8rwwDWaFySzTQhsoi4Tx+OTQfyvHV+2h6gI7bqYL3juAR9z21
         7hFLxYjTlogh+XnPyW8wrI5AMzVRKdWH1UdthpWP6W5oaLPYS/syu483Er7F1xxNFnvu
         itZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=sZOFVtdRWcHgKhT5vIc5qkhp1uEVUcTPIOUyb0okEDc=;
        b=M6F0YGv+NTJsbhvpqs5GQv7ulTzV+lT+gkT9Mbhzj5tBO4LLcfeFUReQykmCe6z9ko
         OHLbKEwnEEAH7yG01/ssfXL/ipeNcQfzYfeqXc3iKrs08tW+f88mgpecMgMD6DoicD3N
         +k9qYCN9Wox6S5E4Ij7uWqcNI/zDnQSmKeoGYee+WQT9lQXBq3a+cV1b7LCRrnSCDVlu
         c8pSwmATWTI0NP14Wml0/A6Cig6ADlPtkX5JQCtaVGtW8u7+qBm1gcT9N574FpFIf3Rz
         qVwl0mzEB6Cxi+CxrMwOt+Ru3xW/T3VFGnWekEEGyOxH3itkXubjXnnIFvy+CLT0vZ3G
         K+ew==
X-Gm-Message-State: APjAAAXDyNTXHSYxbZ+QYiqRQ3Cn02BtqpeBwvLfZ3ZeOBeYHRSgS9NR
        TqNRDy/WuTgm9SlSjS7FsS4=
X-Google-Smtp-Source: APXvYqz0bKq+2GClk8PipGC0Z3sVFzq1MyOmphIwdf/7/l8u/j2r428wmmIXk4jaE++zX8kwHy1AIA==
X-Received: by 2002:a5d:4587:: with SMTP id p7mr16204975wrq.211.1552451483644;
        Tue, 12 Mar 2019 21:31:23 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id g2sm6029020wrh.7.2019.03.12.21.31.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Mar 2019 21:31:23 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Beat Bolli <dev+git@drbeat.li>
Subject: Re: [PATCH v3 05/11] promisor-remote: use repository_format_partial_clone
References: <20190312132959.11764-1-chriscool@tuxfamily.org>
        <20190312132959.11764-6-chriscool@tuxfamily.org>
Date:   Wed, 13 Mar 2019 13:31:22 +0900
In-Reply-To: <20190312132959.11764-6-chriscool@tuxfamily.org> (Christian
        Couder's message of "Tue, 12 Mar 2019 14:29:53 +0100")
Message-ID: <xmqqftrre6p1.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> A remote specified using the extensions.partialClone config
> option should be considered a promisor remote too.
>
> This remote should be at the end of the promisor remote list,
> so that it is used only if objects have not been found in other
> remotes.

That's a declaration, not a rationale, and does not answer "Why
should the origin be only used as the last resort?".

> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
>  promisor-remote.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/promisor-remote.c b/promisor-remote.c
> index ea74f6d8a8..dcf6ef6521 100644
> --- a/promisor-remote.c
> +++ b/promisor-remote.c
> @@ -83,6 +83,17 @@ static void promisor_remote_do_init(int force)
>  	initialized = 1;
>  
>  	git_config(promisor_remote_config, NULL);
> +
> +	if (repository_format_partial_clone) {
> +		struct promisor_remote *o, *previous;
> +
> +		o = promisor_remote_look_up(repository_format_partial_clone,
> +					    &previous);
> +		if (o)
> +			promisor_remote_move_to_tail(o, previous);
> +		else
> +			promisor_remote_new(repository_format_partial_clone);
> +	}
>  }
>  
>  static inline void promisor_remote_init(void)
