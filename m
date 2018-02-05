Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3EB101F404
	for <e@80x24.org>; Mon,  5 Feb 2018 19:41:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750862AbeBETly (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 14:41:54 -0500
Received: from mail-wm0-f47.google.com ([74.125.82.47]:52772 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750807AbeBETlx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 14:41:53 -0500
Received: by mail-wm0-f47.google.com with SMTP id g1so28334703wmg.2
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 11:41:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=POL5Ixd25httseW/E8ormWLUoS4KToRlc9PBPnqI1f8=;
        b=Firj+Nuvb5fYaUuqgNj+ocKaNYbbWm6A60eJSTFAb9h6NDnG2spvTJaPMrvRwEFO02
         Y53YV1FeDCnrgWxbtMO9V/hj9uuYy5W98Ey/yczGXdU4zHI9pfwv9LIJpyBx8Sz89mn6
         pYL1SxwFLzxcyVvk8ck7hxV72qKuvAKPe87ey1Ga3TEoDpFVzcdCxaT4xJWWysPuUCcX
         NPDn0jui4vG2uC4K3pD+1DgmJ2yfe7zFw46ygkkYdI0UOwwr8rTLZburZrbgoF5pvXdo
         Riv6D1tIzmZ1Qh5YM+2kaYh+z4btuTRQRVeDhQzhyugUTbJJdrOA6sENZjhm3h50ExTb
         1GSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=POL5Ixd25httseW/E8ormWLUoS4KToRlc9PBPnqI1f8=;
        b=lgE4BKTnbFI3/cFdLyeSyxhgyF2SALHJ4cK0IrPJ8og21KmRhkWlwUC7zaTjNjssMp
         R9wLjX8LKzoILhniB4HJsqiOYBJrMnoYDF4hJb3LFf94/2ct/tM7nxb8qZxfCpoHXvL5
         o8k8t/EUE3YXxFiuO9HwPsGye6ItlQ8EIvcFOUY7pTCzg3+oal4XebviEz3cxF/NLfCN
         vVXKR8j1bTIxKvIHcSXLp1QcSFIHRyzL8xLHD2GmTDHB5mFmjjAFk4kzMQkZEKL63mVI
         ofHPyxf31MAn1+FDm+pqv/clmN7brEcrnH5/mu/yDV0wUBgh1h5R1Kc51scvZLc/jz/h
         YHSA==
X-Gm-Message-State: APf1xPCJsalNvgWmNPE3VLJGP2/zen6ShqM64yFpWgx0egpwp74rUlYH
        FDomCqfelEr6ipK2u/6mdts=
X-Google-Smtp-Source: AH8x226UOY+by6mZziw6J/YR1gI6tq84eoxUi0+CH+DrVeUPbz9fUf0Z7oFjntTWUQzlKhXCrB7qnA==
X-Received: by 10.28.165.4 with SMTP id o4mr344637wme.66.1517859711796;
        Mon, 05 Feb 2018 11:41:51 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id q15sm11425936wra.54.2018.02.05.11.41.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Feb 2018 11:41:51 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Martin =?utf-8?Q?H=C3=A4cker?= <mhaecker@schwarz-online.org>,
        git <git@vger.kernel.org>
Subject: Re: Missing git options
References: <AD196D8E-04DB-4274-ADEB-D914A79628B3@schwarz-online.org>
        <CAGZ79kaSY=j23Nn+UH5DGJCptTow7ZpEko2DFzuuAgN2e1BxSQ@mail.gmail.com>
Date:   Mon, 05 Feb 2018 11:41:50 -0800
In-Reply-To: <CAGZ79kaSY=j23Nn+UH5DGJCptTow7ZpEko2DFzuuAgN2e1BxSQ@mail.gmail.com>
        (Stefan Beller's message of "Mon, 5 Feb 2018 10:56:17 -0800")
Message-ID: <xmqqzi4n9qbl.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> I had the impression that git-log was a pseudo-plumbing,
> despite it being explicitly marked porcelain
> as there is no good plumbing alternative.

I do not think that is a fair assessment of the situation.  The more
troublesome is that depending on what exactly you want to do, you
need to use a different plumbing command and/or combinations of
them, which means people need to _learn_ Git scripting.  

We recently saw that somebody used "log -1 --pretty=format:%T
$commit" when the code only needed to say "rev-parse --verify
$commit^{tree}" and got broken due to end-user configuration ;-)

