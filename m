Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 781A71F424
	for <e@80x24.org>; Thu, 12 Apr 2018 09:12:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752806AbeDLJMm (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Apr 2018 05:12:42 -0400
Received: from mail-wr0-f171.google.com ([209.85.128.171]:40895 "EHLO
        mail-wr0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751611AbeDLJMl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Apr 2018 05:12:41 -0400
Received: by mail-wr0-f171.google.com with SMTP id v60so448424wrc.7
        for <git@vger.kernel.org>; Thu, 12 Apr 2018 02:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=OzO8IfqpULLNvgSdgduGXecm0rqA3U6Y64m4g+qKIxI=;
        b=n4J2te6j+JC7LhQjbYeJ03pHHgkwnOwAshQwNPATEbYGPa+/+EhWfoCUbGyeKO08ku
         uttDFG18fx3QU0Klsc+4C0YqgFIDRgXcsySURAWgLtNhYsdZgHK8+D4XXxXBSx+vQvoR
         cQ4/NIGQK8NNdlXYGPd/0L7DqXCIISS9Y0mRKg72ZP5s6jYhveHhN5V3TMy+nGCrE7JB
         tEOtGktfrhm+i3hObRCPIpvY0TcCCYWjgJ+q6MTXidgkgUWA+GV+FrOn0XA6yBOLtWNA
         Q22qUfLaTd4V0oENIUtK4FVx76NdRApTDmWPXaCtoSoybTwZmoRYXVAsRLeBBdJNRBEL
         IejQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=OzO8IfqpULLNvgSdgduGXecm0rqA3U6Y64m4g+qKIxI=;
        b=fiPCvxYy5CkUqYCaJOXSHlpcxi2OgDmbzxrvDgAvsFT9nBp0W3fobSCHbFF4bUzKrd
         1O5S943YpQcMUmafCrtcJK+SnQQtS94whEDn4vuSFSgSS3pQ4QS/WxO1ZLaf4eNYiK5u
         WMSpdFy1s3rqRFX6AGcFl18TZOzQBTGB96NRGYdlc3W4KJfs7ALB5MQrEYGu0hPnSvCb
         01n4FkWfjRxoFFcofc50QwwnSn4ijMjIL2JhAx96ASUwY0Zfbh/htVhr9Qz1lSnm68Q6
         7xdbmfMqgY/yIc0sPGxJerQymhPRy0zy0R02dX+vsOJd9LmlWKcxyiiWkxX82WU1CkFU
         vZwQ==
X-Gm-Message-State: ALQs6tAMLG0UG8XcKPMyY1y+YXtbEZzN/JlgMMHMgDVYSVgEq+0X3vFB
        jXn/t0s5GwAf1xb4RI21fBY=
X-Google-Smtp-Source: AIpwx4+h9x3ZLvlhOYIBjUyFmsSBddSCE0WOxb1wut1qmQD7IXh1g4spQ+YuMwW13rzunGe07mrlGg==
X-Received: by 10.223.195.9 with SMTP id n9mr112814wrf.252.1523524359614;
        Thu, 12 Apr 2018 02:12:39 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id a13sm4071132wrc.19.2018.04.12.02.12.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 12 Apr 2018 02:12:38 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <dstolee@microsoft.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>,
        "peff\@peff.net" <peff@peff.net>,
        "avarab\@gmail.com" <avarab@gmail.com>,
        "sbeller\@google.com" <sbeller@google.com>,
        "larsxschneider\@gmail.com" <larsxschneider@gmail.com>,
        "bmwill\@google.com" <bmwill@google.com>
Subject: Re: [PATCH v2 07/10] commit-graph.txt: update future work
References: <20180403165143.80661-1-dstolee@microsoft.com>
        <20180409164131.37312-1-dstolee@microsoft.com>
        <20180409164131.37312-8-dstolee@microsoft.com>
Date:   Thu, 12 Apr 2018 18:12:38 +0900
In-Reply-To: <20180409164131.37312-8-dstolee@microsoft.com> (Derrick Stolee's
        message of "Mon, 9 Apr 2018 16:42:07 +0000")
Message-ID: <xmqqfu403i0p.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <dstolee@microsoft.com> writes:

> +Here is a diagram to visualize the shape of the full commit graph, and
> +how different generation numbers relate:
> +
> +    +-----------------------------------------+
> +    | GENERATION_NUMBER_INFINITY = 0xFFFFFFFF |
> +    +-----------------------------------------+
> +	    |            |      ^
> +	    |            |      |
> +	    |            +------+
> +	    |         [gen(A) = gen(B)]
> +	    V
> +    +-------------------------------------+
> +    | 0 < commit->generation < 0x40000000 |
> +    +-------------------------------------+
> +	    |            |      ^
> +	    |            |      |
> +	    |            +------+
> +	    |        [gen(A) > gen(B)]
> +	    V
> +    +-------------------------------------+
> +    | GENERATION_NUMBER_ZERO = 0          |
> +    +-------------------------------------+
> +			 |      ^
> +			 |      |
> +			 +------+
> +		     [gen(A) = gen(B)]

It may be just me but all I can read out of the above is that
commit->generation may store 0xFFFFFFFF, a value between 0 and
0x40000000, or 0.  I cannot quite tell what the notation [gen(A)
<cmp> gen(B)] is trying to say.  I am guessing "Two generation
numbers within the 'valid' range can be compared" is what the second
one is trying to say, but it is much less interesting to know that
two infinities compare equal than how generation numbers from
different classes compare, which cannot be depicted in the above
notation, I am afraid.  For example, don't we want to say that a
commit with INF can never be reached by a commit with a valid
generation number, or something like that?

>  Design Details
>  --------------
>  
> @@ -98,17 +141,12 @@ Future Work
>  - The 'commit-graph' subcommand does not have a "verify" mode that is
>    necessary for integration with fsck.
>  
> -- The file format includes room for precomputed generation numbers. These
> -  are not currently computed, so all generation numbers will be marked as
> -  0 (or "uncomputed"). A later patch will include this calculation.
> -
>  - After computing and storing generation numbers, we must make graph
>    walks aware of generation numbers to gain the performance benefits they
>    enable. This will mostly be accomplished by swapping a commit-date-ordered
>    priority queue with one ordered by generation number. The following
> -  operations are important candidates:
> +  operation is an important candidate:

Good.
