Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 90B8C1F403
	for <e@80x24.org>; Thu,  7 Jun 2018 05:22:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752669AbeFGFWb (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Jun 2018 01:22:31 -0400
Received: from mail-ua0-f193.google.com ([209.85.217.193]:39658 "EHLO
        mail-ua0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752562AbeFGFW3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jun 2018 01:22:29 -0400
Received: by mail-ua0-f193.google.com with SMTP id n4-v6so5647909uad.6
        for <git@vger.kernel.org>; Wed, 06 Jun 2018 22:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=7/Rk77xvmsPoKvMF/DZkgS/qiywZlX4WGo6TmWyBY0Q=;
        b=Mbu1rwph4zWOdtvccPo8n8bmArvboaKC2ZxTXUrceeN7upXldm/sqGti2QS/KMegeV
         aKSJxVF7aer2rnCG2h5SCEp77pCiBs83RzM5OP8Nr6VPwyMnX4/kbQ3OrBGceC4ZlQk2
         w97dTvA7apOPLsahybPUrehFEDn5y0KcA6VHFPfth5d4rqErvQSebqQ7SiMAsmVVKWZe
         YwYQjrFn4MGmJc9tYTXM88ixP9wgXk1FudGS4GuhemgLMSEruwBkidWRW9KosmQOWjXs
         HgQavsTe6FEOyUNcdU/OvIWQVdf2+jofqAErFA1g9JnWLFt5vwDpo6ji4dCaa/u1f+H8
         sR6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=7/Rk77xvmsPoKvMF/DZkgS/qiywZlX4WGo6TmWyBY0Q=;
        b=k8SEXP5nCFt7eMlxtb5gLSuPB/f4gvUYU97h6d8JC38FjXXUeTehO1m+PLwF1w5JUW
         uCqYlagEcgITUY2JGNCbxBrz9oxtYaPiKFfK/YDRdAnqkR72AtauoMplEzP4jGx2Jt3o
         KMdZZbitx3K1kOLZTQf9jzuruCkbwy6vvIl+3hVFbNioYAJLqQJXl9MhLnCS0d3/Yixr
         mfLWWyrayBly465dxs6QPQpBSn8kQ8GRtmfLQHUJI0yRi3G0HhE8MmiBJu2NFZKoO1Co
         R95EsPNksVvTtAFZaxE8EZojzBwzeMpTFnTj4XlddShsvzx1+4W5PBF7Il8en7KnY/QT
         F7pw==
X-Gm-Message-State: APt69E1iazfWhbK+JlKjKP7VOL2b0J6RZTZoYmNMO7sN6m6kOV69lCfG
        sISPjbDLqdwwJ15A/DMkCZVRRkjGMqBDQvkNdws=
X-Google-Smtp-Source: ADUXVKIxCceS5RYDub/4ppAMZGqf4FSM9Di0EcpoXi38gy5+MfXOekhHwNqFciKYU34Oet08NZqqACVvWc6LvAMDvzE=
X-Received: by 2002:ab0:5e83:: with SMTP id y3-v6mr252620uag.112.1528348948063;
 Wed, 06 Jun 2018 22:22:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:5f28:0:0:0:0:0 with HTTP; Wed, 6 Jun 2018 22:22:27 -0700 (PDT)
In-Reply-To: <20180604184805.36332-2-leif.middelschulte@gmail.com>
References: <xmqqk1s474vx.fsf@gitster-ct.c.googlers.com> <20180604184805.36332-1-leif.middelschulte@gmail.com>
 <20180604184805.36332-2-leif.middelschulte@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 6 Jun 2018 22:22:27 -0700
Message-ID: <CABPp-BEdaSVG9GGwxLwr=neWGq-vO39njC+Ri4tDmN5PPtAntg@mail.gmail.com>
Subject: Re: [PATCH 1/1] merge-recursive: give notice when submodule commit
 gets fast-forwarded
To:     Leif Middelschulte <leif.middelschulte@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Leif,

On Mon, Jun 4, 2018 at 11:48 AM, Leif Middelschulte
<leif.middelschulte@gmail.com> wrote:
> From: Leif Middelschulte <Leif.Middelschulte@gmail.com>
>
> Since submodules are treated similarly to ordinary files (i.e. not as 'dumb'
> pointers), an automatic merge should be mentioned if the user asks for it.
> Just as it is mentioned for oridnary files.

Thanks for following up; sorry it took me a few days to respond.
However, it looks like Junio merged the
sb/submodule-merge-in-merge-recursive topic, including your patch, to
master back on May 30.  As such, instead of re-rolling your patch,
we'd need a patch on top of the other existing change.

Also, take a look at the preliminary release announcement -- you show
up as a new contributor to git!  See it at
  https://public-inbox.org/git/xmqqwove4pzo.fsf@gitster-ct.c.googlers.com/


> +                       output(o, 2, _("Auto-merging %s"), path);
...
> +                       output(o, 2, _("Auto-merging %s"), path);

I preferred your old initial wording here, "Fast-forwarding submodule
%s" (I just wanted the "to %s" part at the end removed).  I'm afraid
that users who saw "Auto-merging $submodule" would assume that we
descended into the submodule and ran a full merge there.

Could you submit a patch that just removed that "to %s" part?
