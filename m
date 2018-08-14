Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 420701F404
	for <e@80x24.org>; Tue, 14 Aug 2018 19:10:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728034AbeHNV73 (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Aug 2018 17:59:29 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:38100 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbeHNV73 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Aug 2018 17:59:29 -0400
Received: by mail-yw1-f67.google.com with SMTP id r3-v6so17041995ywc.5
        for <git@vger.kernel.org>; Tue, 14 Aug 2018 12:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=H6gyQSMOM/y8rutsoaaf6uYjafuOCjP6yzCusVvRDSo=;
        b=I3Q7ltxNEkTo55FvdNn4bJ1N7ay0hDjkI4P5rGslzSAk5qnvNiBVF6VtfcbW3BgWS+
         hr7Kwh2TkHIPy0QJLEOXC3UIJmohdkU/zj8GkKx9s8T7PH1lCW9ocB9PbxcYSqxnmMEL
         y8mpTg8tTC8lj/WKzZCXTWGbJrmgXoU6bimXZPldm2bxJusNK77nXt+kA9MZuVL/B+OX
         zJV0VFyn0AFUX7BMa+k0GURj6hhTevIHrZcVslBRsUObzv+2XsayZGytEfjwcg0T7AW6
         2wJgF9oi14JrfbnuvVztw2PzGOsNfIRmbZguJmzOIHYX1JEYy2z7Wt1GJw0ZyfvGKVyB
         H39g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=H6gyQSMOM/y8rutsoaaf6uYjafuOCjP6yzCusVvRDSo=;
        b=ImM+TMWEjqAcK5TDGP7AGrlPGLTdL1h8HEyL3OTBLUke45nYRwBYqIpI4zQ1BBavQC
         mdDtMTk+13q4rwJIxggOny5C2T+qqBeEn1liSD5HJUfqnxtUndFPdyN/RDl1GVdTsDmO
         DrwytuF636K+/iKBVbAcKtCRckWsvWbb42SWkN4+LTtHsYqmSr5P7VBxAIZl2SHgVrFD
         gIVWPygdehDjkw/9POJEN3vSkvBm2VuvTpV0fE+G+o8CfhuDpn0Iq0/a7NiwmAAxzBcS
         3pI7U52ewZK3tYIM2RwKh5bPdw35FN/1IDG3i2pR1pdH8IBhvSGBsiX0lJkq8QEDFyha
         vCwQ==
X-Gm-Message-State: AOUpUlEj24DOd9OEjv9xYct1SCK+NXYLBmChxNkd7oAiJ26XdCXKqfhy
        jeGtb31kKtatNlLZpbdSvugIq8X2Yi+nMeW9OE920A==
X-Google-Smtp-Source: AA+uWPw5GjgvXUy+zB7kdPKXtZTQe9EW/gTJCC0jYE5dACwU4HzpnCWHEZjqUm2cnNGKFv4nGFl4fdoM3cdbTHAslx4=
X-Received: by 2002:a25:7142:: with SMTP id m63-v6mr7178543ybc.352.1534273852497;
 Tue, 14 Aug 2018 12:10:52 -0700 (PDT)
MIME-Version: 1.0
References: <20180814185906.2680-1-avarab@gmail.com>
In-Reply-To: <20180814185906.2680-1-avarab@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 14 Aug 2018 12:10:41 -0700
Message-ID: <CAGZ79kaK8Wt0TGvo-PyDZRLWr9PU0BRo4=DiYUXvv8c8nZ+M8A@mail.gmail.com>
Subject: Re: [PATCH] submodule: add more exhaustive up-path testing
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 14, 2018 at 11:59 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> The tests added in 63e95beb08 ("submodule: port resolve_relative_url
> from shell to C", 2016-04-15) didn't do a good job of testing various
> up-path invocations where the up-path would bring us beyond even the
> URL in question without emitting an error.
>
> These results look nonsensical, but it's worth exhaustively testing
> them before fixing any of this code, so we can see which of these
> cases were changed.

Yeah. Please look at the comment in builtin/submodule--helper.c
in that commit, where I described my expectations.

I should have put them into tests instead with the expectations
spelled out there.

Thanks for this patch!
Stefan

>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---


> So I think these tests are worthwihle in themselves,

The reason I put it in the comment instead of tests was the
ease of spelling out both the status quo and expectations.

> but would like
> some advice on how to proceed with that from someone more familiar
> with submodules.

So ideally we'd also error out as soon as the host name is touched?
