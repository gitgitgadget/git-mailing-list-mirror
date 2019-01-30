Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A00071F453
	for <e@80x24.org>; Wed, 30 Jan 2019 00:07:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727396AbfA3AHt (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Jan 2019 19:07:49 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:37748 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726951AbfA3AHt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Jan 2019 19:07:49 -0500
Received: by mail-io1-f67.google.com with SMTP id g8so17904056iok.4
        for <git@vger.kernel.org>; Tue, 29 Jan 2019 16:07:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kjTPufN6FM7WbDto639GJTzelozDEedP0bR65roOd6c=;
        b=IHI+hVgqNSJbzEGmeTUVhoOP4l4fX6BxDnikzXSNrsQYB3se0hqcNeNCD5+EOcauFw
         fTZ9K9JmpcOKH+jfDG2oZ+7ZbTLboP99eguJ9AmKZCk3twTl8PEW2mMwzUQ+vT+4rq5b
         uqHNjH6javjoMdPwyopmabhTjDIALbLAQmgHuH7G7Twr9v3k+cfN8sudk7v1MQP4d40d
         4JBb1+4byAnxzcXKqumoqfKE8cMXHz7++2i+bEjEddOIOkUk/g0vrhdSQB6jynlwosG+
         t9j+FsXVgqHuDgPh+ICij4FNijXoiQldBfGxX7jWsG0uVQX1Uh9kt7fAGwb5OsmDDPKg
         3BkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kjTPufN6FM7WbDto639GJTzelozDEedP0bR65roOd6c=;
        b=KnmZk2onGF2NTXfT7NpvtkIfQTSP1G2MhCcvwbE1/PMju9JE5Rb5Nek9UOuDiCwZxO
         M8m/OQHA1pYUagcpk40IgAXapwBhNTvS+sJuu7e6YpUgE+i8PUaw3d+NujMOBsIaI6Ed
         jE4cjuKasohBnNnZeIM7GoUB1YLzEEHgnUJ3GzOM4Yc3pdg22YsTdQTZ0ag8mNXZTnmF
         YYK33hShUqOkTlX3Wgp9ePPJlclxSNjbmSH+xOZmjXDoyDc7gljOwhFMqr1ltWe+zTrU
         AlcO42rky5cvrxVqUvsBRQu6iy2zK7ofMpaZJ8JElTJScI5AJicytTd/wWZS+1pD/pus
         UHqw==
X-Gm-Message-State: AHQUAuZC50NtDa4+65xp2VKSHl8CwpPztowz3/6apvj1Vea5aZEyGske
        1u3QCE6AbQrYLbTm0Ix2WGGTzTcvjCEOMrEZ4qA=
X-Google-Smtp-Source: AHgI3IYHGsU3Pw1StL87BMRx3lmAwb7qOUrBRizMYUDBC88b3mEAsKQI1OvtHQTPUTTJKCJT1YgefLA81ZSQXCAULn4=
X-Received: by 2002:a6b:2b07:: with SMTP id r7mr1675543ior.169.1548806868373;
 Tue, 29 Jan 2019 16:07:48 -0800 (PST)
MIME-Version: 1.0
References: <20190129193818.8645-1-jeremyhu@apple.com> <20190129193818.8645-3-jeremyhu@apple.com>
 <xmqq1s4v6pzm.fsf@gitster-ct.c.googlers.com> <09281A61-1EDA-4226-AD59-6A97EDF1B1DB@apple.com>
 <20190129235947.GG13764@szeder.dev>
In-Reply-To: <20190129235947.GG13764@szeder.dev>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Tue, 29 Jan 2019 16:07:36 -0800
Message-ID: <CAPUEsphfxcqjkqRSV8soCBEtC20Q8+wjYz6_zbKM0=SpsSxTSg@mail.gmail.com>
Subject: Re: [PATCH (Apple Git) 02/13] test-lib: Export PERL5LIB for testing git-svn
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Jeremy Huddleston Sequoia <jeremyhu@apple.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        peff@peff.net
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

/usr/local/versioner/perl/versions is also not provided with macOS or
Xcode AFAIK

Carlo
