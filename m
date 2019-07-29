Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6D7931F462
	for <e@80x24.org>; Mon, 29 Jul 2019 03:07:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726461AbfG2DHB (ORCPT <rfc822;e@80x24.org>);
        Sun, 28 Jul 2019 23:07:01 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:36846 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725681AbfG2DHB (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Jul 2019 23:07:01 -0400
Received: by mail-io1-f66.google.com with SMTP id o9so13260545iom.3
        for <git@vger.kernel.org>; Sun, 28 Jul 2019 20:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1CY4qC+r8M3Tfqsau78lxussa8tNrS/rZ/gQWRYgJyY=;
        b=mA/bBo8vcSEYAWX9O2Z4ocEGv/lrRBFO6C1p1QoYRe3tZlUhOmnbt6e8H0OuS7RVqQ
         K5i+gpRBxf0wWbSgVng9pziZ3vcyElcgvrGabnBwGxvcrYjrLyHyxFAppbkh7q55G+eG
         0i0UFINm4DTLT5N01+0fwKLPqpDPOTOTGJZPzGPpUsxS2I83FT1+eT29SHF0tOrErNUG
         016j1wnGWimyyBOq97BeZLkHdn5KjN3Y3DlPQZcpNB7ZycJKCMBPWnZEiv3lQCBI6mSH
         UKlhp5kS7mvNHluVXblnQxJvF7SvEbI5WyuqM9zsehT1IWSZRZHXm3xNYKBv1mfyhTF7
         erbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1CY4qC+r8M3Tfqsau78lxussa8tNrS/rZ/gQWRYgJyY=;
        b=GRbWo/LgyBqiutJdLBHVvDQBRKCGbZRWRTrPZqeflzOg+tOkmqrGQkILduU5osZ90N
         CZtTmK2f9K/rEfuJrJWvwvmrQ6C97ynyspBhfp9pbCySgeJ/q2YQgM3AlJCEInDD00jG
         TPxp6ckmGiwAX08WaW4WSIzUpeG/umMJq6z5aqPmxD6DdzQFb/nPVH4acj+PAJKFLEiZ
         vGlLPqxxDvsG1WnwgLHKkWpu3EORxKrApciSfer8UuC4q3b6oFMiZlWl/8x/cfEWXcrz
         xnn/2Q6mJtXCVzj7QwHNn77iAJbsS6lIJF8z4xxf+eVdFUti4ypSmnKDBuqIIiwIA5yZ
         7YCQ==
X-Gm-Message-State: APjAAAWFbi/Y/iTRp/7/IsM5R9gl6xN83N7tpZFrO6GYDzz65xdrv2Cg
        OzX28+YMbMoKdcAIRtV+NF3Rd4zZS9tjPOfqZCE=
X-Google-Smtp-Source: APXvYqyDgo5mMAlKbEtzF+bz2f9rDOkxlJT85c3sM9tBxBwDImkhOhwCtytnvT19GCBYGziWkg2Y/bFaRagrH2XmOWo=
X-Received: by 2002:a6b:c38b:: with SMTP id t133mr34938873iof.162.1564369620181;
 Sun, 28 Jul 2019 20:07:00 -0700 (PDT)
MIME-Version: 1.0
References: <20190724151415.3698-1-avarab@gmail.com> <20190726150818.6373-7-avarab@gmail.com>
In-Reply-To: <20190726150818.6373-7-avarab@gmail.com>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Sun, 28 Jul 2019 20:06:49 -0700
Message-ID: <CAPUEspiCL+ZbcOwna7XLvW3HfDg+i3bg2GcS_1Sv=VHU3aNRoA@mail.gmail.com>
Subject: Re: [PATCH v2 6/8] grep: stess test PCRE v2 on invalid UTF-8 data
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Beat Bolli <dev+git@drbeat.li>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 26, 2019 at 8:09 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> This patch does nothing to fix that, instead we sneak in support for
> fixed patterns starting with "(*NO_JIT)", this disables the PCRE v2
> jit with implicit fixed-string matching for testing, see
> pcre2syntax(3) the syntax.

Alternativelly; using `git -c pcre.jit=3Dfalse grep ...` on top of [1],
might be cleaner

Carlo

[1] https://public-inbox.org/git/20190728235427.41425-1-carenas@gmail.com/
