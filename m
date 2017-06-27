Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9A55A20401
	for <e@80x24.org>; Tue, 27 Jun 2017 21:38:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753736AbdF0ViU (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Jun 2017 17:38:20 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:34382 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753653AbdF0ViT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jun 2017 17:38:19 -0400
Received: by mail-pf0-f193.google.com with SMTP id d5so6279658pfe.1
        for <git@vger.kernel.org>; Tue, 27 Jun 2017 14:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:in-reply-to:references:user-agent:date
         :message-id:mime-version:content-transfer-encoding;
        bh=ZtbW0xJH70v17VQaGoA3pORsZQkNO6FV5xRhDLqGUaM=;
        b=DNErIFflDsYf0P+7s72mxUYPu77/JUfe1eiJyzeWsuOuus1q5V9aXtpN5q1VgdHhqn
         5VyZrdk4IESshJmru/m7IAbYpdQhCzKK5B4h6OZYCwEvcTTQRK/YMQhlt5DYt6yar1K4
         fveN0FR3FYYcYImZN0gx9tXRRrrMBCwLZwmFWfAdJaIjz32wUDRoG4i4D/Vsdy5dGn6F
         xlX8J24QeOAuuMe8o75WXjc2lFgDOnGK3xSVmnR5CPCbTRN6iuthOZZdx5l7oCkBamzt
         jxrvWHTmnXCL2g1lk+Eh4i87TlTqKSRdtcshGf7T7hRlt7C5lWX+P+btx3knkKwFz8dq
         +PgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :user-agent:date:message-id:mime-version:content-transfer-encoding;
        bh=ZtbW0xJH70v17VQaGoA3pORsZQkNO6FV5xRhDLqGUaM=;
        b=A62eswMkhgnzp3Ez8KfbdTnJWobJZ1Sfzc1hTYVixAyZ4T/+6Mr7R/+Qqat3nXQFRJ
         PUMB8USCa62oWTM68uA4TynA2aMgiccPDi7Gb8tKNjatX1jCNzyNRGqdoEmLV559kaY4
         +YYWXVr23DH2ZOlVQ0wz0eq+Get7VUwksMrvIlDaP3c8mF3u51r4VHAsOTtf79rpX0hs
         HgcMRVSq2OOKX7pHI+/NS7GtZ3ydaGWW1CR2JtXS3eXN4ZM9PPp7BYJM5S5dr7vwviV4
         1j4eWfqYXht2Us7l/qnWB6WgyY0nwGbIseZV8OGVCe7NsfclpXcohNWukyfMMXWYstx/
         Hjgg==
X-Gm-Message-State: AKS2vOyhmA6dl586OiuSN/mbfCbGBGmlQFUuiWRQkZlOTVo33juVhmJ1
        9fhmn5H7PYnKrg==
X-Received: by 10.98.28.71 with SMTP id c68mr7335568pfc.116.1498599498480;
        Tue, 27 Jun 2017 14:38:18 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:3095:bb54:d256:9ca9])
        by smtp.gmail.com with ESMTPSA id 63sm325513pgd.57.2017.06.27.14.38.17
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 27 Jun 2017 14:38:17 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Michael Kebe <michael.kebe@gmail.com>,
        "Liam R . Howlett" <Liam.Howlett@Oracle.com>,
        Adam Dinwoodie <adam@dinwoodie.org>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v2 0/3] update sha1dc from PR #36
In-Reply-To: <20170627203348.19827-1-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Tue, 27 Jun 2017 20:33:45 +0000")
References: <20170627121718.12078-1-avarab@gmail.com>
        <20170627203348.19827-1-avarab@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
Date:   Tue, 27 Jun 2017 14:38:17 -0700
Message-ID: <xmqqfuelyuuu.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:

> A v2 addressing comments to the v1, tbdiff below. Just fixes the
> subject line on 1/3 & gets rid of the redundant _BIG_ENDIAN detection
> for Solaris, we can just use __sparc (and indeed we did before this).

Thanks.  Let's have this tested by minority platform folks to help
the upstream digest your pull request.  The change since the last
round makes perfect sense to me.

Thanks.

