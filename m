Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D69581F42D
	for <e@80x24.org>; Fri,  1 Jun 2018 19:38:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753047AbeFATiH (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Jun 2018 15:38:07 -0400
Received: from mail-yb0-f194.google.com ([209.85.213.194]:47026 "EHLO
        mail-yb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752704AbeFATiG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Jun 2018 15:38:06 -0400
Received: by mail-yb0-f194.google.com with SMTP id p22-v6so9107081yba.13
        for <git@vger.kernel.org>; Fri, 01 Jun 2018 12:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=EKdTUFSBJWuL+vbiEhRAViteFnIkXHkopP6Nt+ovCpE=;
        b=BqeQatQUQ5CUF4ldh2pO8exyBw7LO2r73P4iVyMdz27cKExFiUJ3EvhU3WlMcN/eOp
         yC6wZ67bY8mREMQMA32pirw9T4TNsdisxhYnBBBaB8ptA12wkEx/1LToYsN6o+nftOt2
         a05QVOU+dVgbvWcXnF3jOvz4u+VedJtu/xvdI5+eXyDozfeiu/8aTJd2s9v3dmorH5KQ
         pkAjZRkwRRqfOLuBTJsS0lEKTkpDR2r9TGYYaKUof9xMKjQzrWm98tx6xOaPFxcPYDEN
         6Y2040avrhtwYTvIuIdVf4MfzKbndkqUEzISp2Kt89A8tic+mH6Wf8FeTOK9W4zqG4hx
         YLIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=EKdTUFSBJWuL+vbiEhRAViteFnIkXHkopP6Nt+ovCpE=;
        b=X/WiRIU9s7Hi64vsGr3Qal2U+Rke/W2zYdHpNdLjG9LPY8ZTOf33M265i7GqU1eI5/
         pUBlLd619WvfvMho6JEmG7vlNAXhegwECnK5ZIdT/l+JcrsdMa8WxHfX/MbdGJ5JihVr
         LLhl8zYYvEPpaNXOSjbJyKTdywcWXUQqph+XNXXMfJxbKlWW0g9+A39tFPICyjCKx4IA
         BZp3jYmkV3IjKQe9RPhwmE7budI8vLBf/9oETc4d+J5pjo6ls1q6Na4ERsBXBvEN6aDX
         uP8aYPAa8OnoC8R3ZMzY6zsh3Qnp17KPlo4npD2IGW3Oyh91gZwzjaG9WITBGW9rqVp2
         3YzA==
X-Gm-Message-State: ALKqPwePwycg4vfifvqS1RztTw/r/wRT5DarVL9OCd/CVFTU9Vtx6hT+
        KenoM8R9ql5mQKmtxznsA/f130ks7ZaqMR1LqZ9uWg==
X-Google-Smtp-Source: ADUXVKIAcr+ZpjbA3YC0D6TU711B4GdLYiN9HJa8Ix1Q44EBxaUTQseb4XB9cD6iUsDtkhAkTKdQ+0NFJVJc42BMfoA=
X-Received: by 2002:a25:dfca:: with SMTP id w193-v6mr6723748ybg.334.1527881885211;
 Fri, 01 Jun 2018 12:38:05 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:e87:0:0:0:0:0 with HTTP; Fri, 1 Jun 2018 12:38:04 -0700 (PDT)
In-Reply-To: <xmqq8t7z9qc6.fsf@gitster-ct.c.googlers.com>
References: <20180530170433.191495-1-sbeller@google.com> <xmqqzi0f9see.fsf@gitster-ct.c.googlers.com>
 <xmqq8t7z9qc6.fsf@gitster-ct.c.googlers.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 1 Jun 2018 12:38:04 -0700
Message-ID: <CAGZ79kaJ-k3rTiksJqkiJSvDv_bA-CKHskGXcTuA86Yyigf0oQ@mail.gmail.com>
Subject: Re: [PATCH 5/5] refspec.c: use rhs in parse_refspec instead of
 potentially uninitialized item->dst
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>, Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 31, 2018 at 7:46 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> Perhaps a better fisx is to explicitly assign NULL to item->dst when
>> we see there is no right-hand-side.
>
> -- >8 --
> Subject: [PATCH] refspec-api: avoid uninitialized field in refspec item
>
> When parse_refspec() function was created at 3eec3700 ("refspec:
> factor out parsing a single refspec", 2018-05-16) to take a caller
> supplied piece of memory to fill parsed refspec_item, it forgot that
> a refspec without colon must set item->dst to NULL to let the users
> of refspec know that the result of the fetch does not get stored in
> an ref on our side.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>

This looks correct. Thanks for writing the patch.

> Did I miss the other 4 patches that this might depend on it?

No. I was sloppy and developed a couple of patches on top
of pu and then tried to put them onto their respective branches.
and then I forgot to correct the patch counts after figuring out the right
branch to apply this to.

Thanks,
Stefan
