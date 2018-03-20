Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A7F6E1F404
	for <e@80x24.org>; Tue, 20 Mar 2018 03:33:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751317AbeCTDdT (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Mar 2018 23:33:19 -0400
Received: from mail-wm0-f41.google.com ([74.125.82.41]:40842 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751022AbeCTDdS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Mar 2018 23:33:18 -0400
Received: by mail-wm0-f41.google.com with SMTP id t6so689350wmt.5
        for <git@vger.kernel.org>; Mon, 19 Mar 2018 20:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=uqASMf21M166EIOx0OPayptdTCUyvaEIQUMF7GMInH4=;
        b=MeGbwukGX2zRNgnzq0Y1cpPNmO1fgjWYwkvqfunqH/dP992MkvDTvDrw07B/IqKLEA
         /l0N7lRke1gVrSaEzfXV2oibjOpBy47A2ItvAWM2GT92FFqK3/hwZ3mpUG+boZELGkxF
         YIY+nrzoAFHxxRDPuWiVaBZJtZaTjI93lQODa4dHcqL3TbkwJT1Ze1252dg6xVxu6r/u
         Xx+zjncx+mjKIcElp2qbBzO5E6DPj/jstikpSXt+xcRVZLDiBDQb9A7iqHIZjGPVpUKl
         Po6xe8JdgqL/S5oABU3KQ2z32YwyDhL+jWR6BgPKbKbHWrBMJJdWBbzjOMYArwm6B+e4
         3Nzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=uqASMf21M166EIOx0OPayptdTCUyvaEIQUMF7GMInH4=;
        b=J0FMtbSOUzLfC9Asik/f87hhz5lKO7YUl0y4QhA47a20Un2kVsjzOysTJ6BEX5XBtV
         Dbiv0hpZJhc7ppKNF9yteJ2LZuvCUDHEU2AUofoiZpOwIuJPhC/2Wl/5MQvP+5twyP8h
         jKioJ9bX36FD4/89Y1tNGnrTnXDHZJ/N4cmbQ7lylyR5w6iMUNVaeu9k1D4r9UeEfrjx
         smKk/PiJZJtjgEQpg9v8gApK4RYEzREEpZBgzhamwCF7JheJUmP/WzdjN4ZdvhpMwYGk
         sYVoOhWwviXbrwfPqBSw1TWJ7omDiqcDlADhcndrznoy5C4whluR5o/V54q/r0QCg2SX
         er/w==
X-Gm-Message-State: AElRT7HrMxQZDjDK8xSw+ANUKNOvBMv39RIIoWwEnpOz7BU4NfQRb43P
        k1WJDuSE8KubxrlH4l26gPM=
X-Google-Smtp-Source: AG47ELvcib6o4z/+xlKyTdHmSYvFL/HpXLFU6RxX5Uc+FEuIZ3De0H7K331VAT0oivilUQ9ZNCSg/A==
X-Received: by 10.28.133.78 with SMTP id h75mr802756wmd.8.1521516796885;
        Mon, 19 Mar 2018 20:33:16 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id 43sm603295wru.40.2018.03.19.20.33.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 19 Mar 2018 20:33:16 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Dakota Hawkins <dakota@dakotahawkins.com>,
        Git <git@vger.kernel.org>
Subject: Re: .gitattributes override behavior (possible bug, or documentation bug)
References: <CAHnyXxRX4+sMJCNG6f9xtsDO6bdqRS-U6TAYO47OKQjH8bGzbg@mail.gmail.com>
        <20180320023423.GA10143@sigill.intra.peff.net>
Date:   Mon, 19 Mar 2018 20:33:15 -0700
In-Reply-To: <20180320023423.GA10143@sigill.intra.peff.net> (Jeff King's
        message of "Mon, 19 Mar 2018 22:34:24 -0400")
Message-ID: <xmqq8tanto90.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> The best you can probably do is:
>
>   /.readme-docs/* diff=foo
>
> Since you have no diff.foo.* config, that will behave in the default way
> (including respecting the usual "is it binary" checks). So a bit hacky,
> but I think it would work as "ignore prior diff".

You can say

	/.readme-docs/* !diff

I think.  Thre is a difference between setting it to "false"
(i.e. Unset) and reverting it to unspecified state.

Isn't that what you want here?
