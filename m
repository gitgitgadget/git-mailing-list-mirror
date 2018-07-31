Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3B45F1F597
	for <e@80x24.org>; Tue, 31 Jul 2018 17:40:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729830AbeGaTWJ (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Jul 2018 15:22:09 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38966 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728327AbeGaTWJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Jul 2018 15:22:09 -0400
Received: by mail-wr1-f67.google.com with SMTP id h10-v6so17515864wre.6
        for <git@vger.kernel.org>; Tue, 31 Jul 2018 10:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=aJmJXZ/cmNT21HMiHWX95EO61m4TJyODLeyZm0TElZE=;
        b=DLd6h/YkiiPvWLBrN9AgzepgNyywokGTdP6yCGhPrzrQLkh3R9e21GVBiQMbS0jDWe
         LvXwkhUjrmywUZheZelUhE+1K0P9ggY5xNIR/XQsvSHUwVUhmb0C+qiljFOeialLAWLG
         04ZswSKSua2XEAh6IyNp5opcLybqsDu3ud3pVYDC77aBV/FuaE9ywE9j8KxCIiMGewJe
         NDz1it++0nqjbEVaLt5+6kWhP2aGXWGUFeEjBTczpEFOur2LNn2EwEDboCSvnqvVWGBR
         g7kk7cfj9jIKE3WCWCP+FWnPvSPxq+oEPyBH0dtZcWWcvmViSwNFgqrtd9O8gwUeSGbo
         VlVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=aJmJXZ/cmNT21HMiHWX95EO61m4TJyODLeyZm0TElZE=;
        b=NyTBzkUft0iVAzVATnZ24hi0fc6Bt3MC4luWT2W+nyHcoTplZcq+l7za+dZxhwpJdW
         4emt1a3TjMA7/gvrEQyCEnICm4grNm5jL36joP8v5P/diM6/g3pC8mpAojLGmTFRqueQ
         J4ToJNNpmA9E6ktDT4/uhai6GA78g4C7m172zaqN8i1MG/ULYAtRUrv8DkLzP51R6aUo
         DdGDw24ZrSP06FhJFfJ4DaFFWSy0Mm+aBIQ7RZxrwtvf6/TMACO8iMh5OZnE27mwJEm0
         or0ZIFfb2FNb7nFzSvOc24NLVkb9kbFT2IHfxnAPUEP7VaBxSuy6Ct77Mul1prS1lbd1
         G/8w==
X-Gm-Message-State: AOUpUlHV+0Ts17C6OZvFrrhDpsBz3p/J6Yh5/pJlg3UXL1j/96KR9lwG
        YlvdlKlPEXE6Rv1k/OoKe4A=
X-Google-Smtp-Source: AAOMgpcSH2b0FpNO11BoIOOzY7cVCLcJbJYq7KWbDe0XkuarZeO3baHPIVohUjDWsj9fWYeH+ZMHjg==
X-Received: by 2002:adf:b519:: with SMTP id a25-v6mr22674747wrd.273.1533058844940;
        Tue, 31 Jul 2018 10:40:44 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id g125-v6sm2888392wmf.16.2018.07.31.10.40.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 31 Jul 2018 10:40:43 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Wink Saville <wink@saville.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Bryan Turner <bturner@atlassian.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Jeff King <peff@peff.net>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Subject: Re: [PATCH v2 06/10] push doc: correct lies about how push refspecs work
References: <20180429202100.32353-1-avarab@gmail.com>
        <20180731130718.25222-7-avarab@gmail.com>
Date:   Tue, 31 Jul 2018 10:40:43 -0700
In-Reply-To: <20180731130718.25222-7-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Tue, 31 Jul 2018 13:07:14 +0000")
Message-ID: <xmqq8t5rcnhg.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:

>  The <src> is often the name of the branch you would want to push, but
> -it can be any arbitrary "SHA-1 expression", such as `master~4` or
> -`HEAD` (see linkgit:gitrevisions[7]).
> +it can be any arbitrary expression to a commit, such as `master~4` or
> +`HEAD` (see linkgit:gitrevisions[7]). It can also refer to tag
> +objects, trees or blobs if the <dst> is outside of `refs/heads/*`.

"It can also refer to..." is a good addition, but do you really want
to make it part of this series to change/deprecate "SHA-1 expression"
(which would certainly involve discussion on "then what to call them
instead, now we are trying to refrain from saying SHA-1?")?

> +on the remote side. Whether this is allowed depends on where in
> +`refs/*` the <dst> reference lives. The `refs/heads/*` namespace will
> +only accept commit objects, and then only they can be
> +fast-forwarded. The `refs/tags/*` namespace will accept any kind of
> +object, and any changes to them and others types of objects will be
> +rejected. Finally, it's possible to push any type of object to any
> +namespace outside of `refs/{tags,heads}/*`,

All sound correct.

> but these will be treated
> +as branches for the purposes of whether `--force` is required, even in
> +the case where a tag object is pushed.

I am not sure what "will be treated as branches" exactly means.
Does it mean "as if they were in refs/heads/* hierarchy?"  Or
something else?

> That tag object will be
> +overwritten by another tag object (or commit!) without `--force` if
> +the new tag happens to point to a commit that's a fast-forward of the
> +commit it replaces.

Yup, and that is something we want to fix with a later part of this
series.

> +By having the optional leading `+` to a refspec (or using `--force`
> +command line option) you can tell Git to update the <dst> ref even if
> +it is not allowed by its respective namespace clobbering rules (e.g.,
> +it is not a fast-forward. in the case of `refs/heads/*` updates).

This gives an impression that with "--force" you can put non-commit
inside refs/heads/* hierarchy.  Is that correct (if so we probably
would want to fix that behaviour)?

> +This
> +does *not* attempt to merge <src> into <dst>.  See EXAMPLES below for
> +details.

That is not wrong per-se, but would normal people expect a merge to
happen upon pushing on the other side, I wonder?

Thanks for cleaning up our longstanding mess.

