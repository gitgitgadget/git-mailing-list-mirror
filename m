Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 86EDA1F404
	for <e@80x24.org>; Wed, 28 Mar 2018 05:22:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750881AbeC1FWi (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Mar 2018 01:22:38 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:37895 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750703AbeC1FWh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Mar 2018 01:22:37 -0400
Received: by mail-wm0-f65.google.com with SMTP id l16so2678639wmh.3
        for <git@vger.kernel.org>; Tue, 27 Mar 2018 22:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=txSlDEQQv8G5okZT2Qm8veugcHlrfjU+L1KlvdPgGJs=;
        b=IXuNBbMiUjD95LTr9N6jM+TIr8PcMlE7F8CCMwUWS42W8AA3P8a+OI4T+AULlJ9yG5
         9/EQXmfuaF5AnsXnp4bUIa44Z4dQXpI+IUDf6dJG8GtQjLdYSn4u3Bxip+Rvxu3TxfCV
         Oc+wZSpKdMjZl9nbH7a1fbDhFwqfpG6VbX/w1+gqebapkbOQbuywc5Z8/lXzeC6e0IQd
         +IfHulK2j/lzru2XPpRjOFX2gHqQCkcURi+YlSE+uuNzAZxBrJvynagxBPuTKq6luQA5
         h0GtV2XI5b5dRBnZvpa2vaMxCdgbXBboFZSDWcM6hTmdDUofn3B7I2dgEVrwRD+4o3rX
         JmkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=txSlDEQQv8G5okZT2Qm8veugcHlrfjU+L1KlvdPgGJs=;
        b=oYS0VtTDJDx/t7XswcrsvXwZBeRAIa8Wg3qga3OgDkXfCNKue2ih8MMieTK+E8wEcV
         Xgnx6ydCwupq4pleHSk47xEEVbAP4UppjL/LPL0+n5POWiLfedSB4fOoa3xWdjsYgV9c
         tFX5MOUT9bElKBhOTYtzEWSTq+xpkfdP38EjkVAXJbePYERvPRuvNXMgy+eMePizWaCk
         g6WGmOW5EOCFCGT7a+LwrlRZ9WlC4e9Qg7j7gk04nGTHoyHld3wQFumEndglbwHKdetW
         elEJgldDsaPtdC9creSsrKM3Ly+9MwA6xulTXGBFtikX2dgstOzP7JW+xQLH/vKTCnPs
         ZcVQ==
X-Gm-Message-State: AElRT7H+jqIGmbIbWVZSSf2lbUAv/J8ZYsBSP+vwPutqqc5xr/vgMuHZ
        kFfm56QP/9MTS9ZiWZHpx9dcoLD4
X-Google-Smtp-Source: AIpwx4+oYijkOlFLuZnHIH3hF6qrJBTZSywsrqC+Ao0UxOWZxIOMQW1WrK4WkhqyL3dO8J+d5N9eoQ==
X-Received: by 10.28.174.67 with SMTP id x64mr1420945wme.104.1522214556230;
        Tue, 27 Mar 2018 22:22:36 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id m184sm3276055wme.40.2018.03.27.22.22.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 27 Mar 2018 22:22:35 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
Cc:     "'Wink Saville'" <wink@saville.com>,
        "'Jeff Hostetler'" <git@jeffhostetler.com>,
        "'Ramsay Jones'" <ramsay@ramsayjones.plus.com>,
        "'Git List'" <git@vger.kernel.org>, <peff@peff.net>,
        <l.s.r@web.de>, "'Jeff Hostetler'" <jeffhost@microsoft.com>
Subject: Re: [PATCH v4] json_writer: new routines to create data in JSON format
References: <20180326143136.47116-1-git@jeffhostetler.com>
        <20180326143136.47116-2-git@jeffhostetler.com>
        <ce076d5e-f30f-006e-a25e-ff1a900562bf@ramsayjones.plus.com>
        <ad15ccab-088d-b827-a9fa-c83d397c3479@ramsayjones.plus.com>
        <2bc6f6a6-bf53-b87c-af02-156ad006a878@jeffhostetler.com>
        <CAKk8isp5NncyDuGNhWctQfmjToWa8nAzHODi7SjbUW2i2R4kiw@mail.gmail.com>
        <007a01d3c5f5$7fcd3290$7f6797b0$@nexbridge.com>
Date:   Tue, 27 Mar 2018 22:22:35 -0700
In-Reply-To: <007a01d3c5f5$7fcd3290$7f6797b0$@nexbridge.com> (Randall
        S. Becker's message of "Tue, 27 Mar 2018 14:00:27 -0400")
Message-ID: <xmqqvadg93l0.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Randall S. Becker" <rsbecker@nexbridge.com> writes:

> cat <<-EOF | sed "1,\$s/_/ /g" >expect
> { level1 ...
> ________{ level2
> Etc.
> EOF
>
> Providing you don't use _ elsewhere in the output. It's a bit hacky but works.

The trick is especially useful if your golden master has mixture of
SP and HT, as you can write the source in a way that helps readers
understand what is going on, and turn that with sed into what the
machines would want to see.  When used that way, I'd say it is not
"bit hacky but works", but actually is a beautiful solution ;-).
