Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 29F621F404
	for <e@80x24.org>; Fri, 30 Mar 2018 19:50:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752626AbeC3Tuy (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Mar 2018 15:50:54 -0400
Received: from mail-wr0-f180.google.com ([209.85.128.180]:37790 "EHLO
        mail-wr0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752314AbeC3Tux (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Mar 2018 15:50:53 -0400
Received: by mail-wr0-f180.google.com with SMTP id l49so8792741wrl.4
        for <git@vger.kernel.org>; Fri, 30 Mar 2018 12:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=486v+jFWKbYJ8yrCH2EdMb96Fg4qepHmDJxA6C1zw9c=;
        b=PZ3CqRQVBOeD2KXKIej0IZArel8uPQRtlXGTL8GpHV9+DvmwGUVwAYavh8CkJQYQ3a
         mtXANbmU/etoF6AlJCOXfpDVMZ7oQHOjCd7QX/DZQbfNXo2SDD9rdbfjSWVII3mulwl+
         7n8nKkzK7lNR09N/TVD1i95J5DAqLTE/1lQobzDloFx1Piio1klE3gESL1Camz4+QaGP
         pr+VWelwJHYLznugj5LfpcghLcvaRfZfa2tgBzy1VlYv7FqAHmji3C9RucgUuwzQUM+k
         Uor86sY+hXF6ZBUeQydq6glugx5DPE9hj8cSL0Hnbk7MvPcJ3B5AcBieuzb0fFr/4+/q
         lM5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=486v+jFWKbYJ8yrCH2EdMb96Fg4qepHmDJxA6C1zw9c=;
        b=BfOvZbPhL2LytWJ6/CwrdOcYgKNYefLYhgjTuk8g0gU7eFMDqlTvu5kSuSNMdy0Hm1
         hjp22myaqk3VNAXP27ea+CZL/ZiVDn+8NaB0TwNCcKTRQKj8BeMFwBko04Af/nUX0w8s
         pa3nIbElsPiAFsgzamKrpd8yPCIc3OdfMjTkqqNTmp9C1NV8rr6V/oZMkI8b8BxLj3ph
         44DDoEiWQR3zMAs/KfjUxVjD2GjhBQF5n0Gej7D/6nkJ4IVinkYWgnnVrMj87sMzjErL
         wij+giikWu5pEUBKDXewfUwux7Msm1N51z4q0CV0QgJhT1MjOS1wvV8cCmr7SmGN9qjc
         j3eg==
X-Gm-Message-State: AElRT7HXmYQHtIjC8WcPESTct1wiw6XciqOjULABYI4L4SOgifeYPAhd
        6LllIKs+7zQbMhEZp8Wqr3E=
X-Google-Smtp-Source: AIpwx49c2cm1anqzjqVwpMgu/TOANzqCzh03qAZQLYM6/adG2e39C/kRx9VHxexEnOsnIxcTVMGQcg==
X-Received: by 10.223.176.7 with SMTP id f7mr171519wra.257.1522439451888;
        Fri, 30 Mar 2018 12:50:51 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id 93sm11047913wrh.46.2018.03.30.12.50.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 30 Mar 2018 12:50:51 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v2 2/5] trace.c: export trace_setup_key
References: <20180330183425.GA30575@sigill.intra.peff.net>
        <20180330183459.GB31135@sigill.intra.peff.net>
        <xmqq8ta92vot.fsf@gitster-ct.c.googlers.com>
        <20180330194749.GA13537@sigill.intra.peff.net>
Date:   Fri, 30 Mar 2018 12:50:50 -0700
In-Reply-To: <20180330194749.GA13537@sigill.intra.peff.net> (Jeff King's
        message of "Fri, 30 Mar 2018 15:47:49 -0400")
Message-ID: <xmqq4lkx2vhh.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Fri, Mar 30, 2018 at 12:46:26PM -0700, Junio C Hamano wrote:
>
>> Jeff King <peff@peff.net> writes:
>> 
>> > From: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
>> >
>> > This is so that we can print traces based on this key outside trace.c.
>> 
>> "this key" meaning...?  GIT_TRACE_SETUP?
>
> I think "based on trace_setup_key".
>
> -Peff

Yeah, I read, but did not pay enough attention to, the subject X-<.
