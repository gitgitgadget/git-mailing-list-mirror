Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D989C433F5
	for <git@archiver.kernel.org>; Fri, 12 Nov 2021 16:28:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6928A61029
	for <git@archiver.kernel.org>; Fri, 12 Nov 2021 16:28:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235406AbhKLQau (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Nov 2021 11:30:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235392AbhKLQat (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Nov 2021 11:30:49 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7907C061767
        for <git@vger.kernel.org>; Fri, 12 Nov 2021 08:27:58 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id t18so20455262edd.8
        for <git@vger.kernel.org>; Fri, 12 Nov 2021 08:27:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8M8Ql7mAfZ7bvPJa4nPzCdAS398D8VKhC37sTjy7vgY=;
        b=ReVUeIW6WXASb4g0prXRFGM0FmvqGMACa+JJzJMJhSoetjux5WX9PnlfR4uqmcLplf
         ZGDsqIuTV4XRF2Ikp84mfzOO6GYd0YR7BfVEOk8IU2+ipL+Da2ufHx+kzmqC7Px9ozN0
         HC+8/n/wpt/xDHv1H/up2TSRqtlpF3Vxhk/+jhh4MYnfingg+JjQoQbOZbAGsOYURe3O
         B1/0LnLbeRMa40un6H1+JoM9c+JSXbRIQAAFj/KXcz5DJkQxbyRCorCN8aRwMBjGejaj
         LrgPM+RsZWXXSnogsG+Vn5g42iYwc4icAjkJDtJ3sxDTnlnI42/sdZ7KDuyhn39H+3z/
         RYHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8M8Ql7mAfZ7bvPJa4nPzCdAS398D8VKhC37sTjy7vgY=;
        b=w5cjibiEEC112zW5bp5GPK8KnDCL24n1fwXNhgURbcOQ8v85AKjnInPJ0rpn1cwfep
         NbLDBxBxinR05dfgQurMYoUiW/G86Xhdqq586BKfMscuwTMLy8fPyfVEfsTosD/PQcH5
         gBh0EtuOVYlbTlFB6BNYaVN+jJsq37Pb+e1vWC0ZrlL/aVfjfN2b93IBUp+AfxgkVfq3
         9/J6nOpk+VOFa+pMILGl5AEyLp2bX5VR7SBYa9s88YLQl+eQC1MIrp25xYTd6yGsH7gE
         HQ1AgRsy8GW0eEqStTWusU/oTwdTWLFu/XfUpthzZOrqqCGIsxqTzO53p+PtpfU17ATO
         DXQw==
X-Gm-Message-State: AOAM531xFm0+OQqXavGAiGLPhrNb1LFt3634GHfueGFxSZgRLpg7qxR4
        9AtHJAhdhhHSUca4Xo363HqhJJrnl/8Cgyj5ereyBD1ymNg=
X-Google-Smtp-Source: ABdhPJwy0oUU88nEJoHZvJMoB5EoVe4I4bhamiK0fdQzYsYzMR2c+TqN8tdYhXC8nUiOYDALt8fyAAzFCTMbyD7VSeg=
X-Received: by 2002:a05:6402:207c:: with SMTP id bd28mr23133872edb.240.1636734477357;
 Fri, 12 Nov 2021 08:27:57 -0800 (PST)
MIME-Version: 1.0
References: <pull.1065.git.1635542128.gitgitgadget@gmail.com>
In-Reply-To: <pull.1065.git.1635542128.gitgitgadget@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Fri, 12 Nov 2021 17:27:45 +0100
Message-ID: <CAP8UFD3Uh7AJTFaVv25f7gGQkTxgMQTCO=NMHCWoSm9sjmw26g@mail.gmail.com>
Subject: Re: [PATCH 0/4] Flag to add a newline after decorations for --oneline
 log output
To:     John Cai via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git <git@vger.kernel.org>, John Cai <johncai86@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 29, 2021 at 11:17 PM John Cai via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> Add a flag --newlineafter to be able to pass in "decorations" to enable a
> nicer format for the --oneline output so the commit subjects are aligned
> when decorations are printed.

I wonder if --newlinebefore or --newlinefor rather than --newlineafter
would be better. It seems to me that it would be easier for users to
guess what the result will look like with --newlinefor.

Another possibly more generic solution would be something like
--format-field=<field>:<format> where, in the output, the field
<field> (which corresponds to the "%(<field>)" format) would be
replaced by <format> which should contain "%(<field>)". For example
`--format-field=decorations:'[[%(decorations)]]\n'` would enclose the
decorations using [[...]] and would add a newline after them.

Also it would be nice if this could be extended to other fields and to
formats other than "oneline". You might want to discuss a bit about
how it could be done with generic code.

> 0b96396ef5ff7a3a01e137b3735893c970759dfa (HEAD -> jc/two-line-pretty-decoration, john-cai/jc/two-line-pretty-decoration)
>                                          Improve UX for oneline with decorations
> e9e5ba39a78c8f5057262d49e261b42a8660d5b9 (origin/master, origin/HEAD, master)
>                                          The fifteenth batch
> c6fc44e9bf85dc02f6d33b11d9b5d1e10711d125 Merge branch 'ab/test-lib-diff-cleanup'
> 63ec2297d26155adb0e38745bf2284cd663add8e Merge branch 'ab/fix-make-lint-docs'

Not sure why the above lines are included in your cover letter.

> original thread in
> https://lore.kernel.org/git/CA+55aFwT2HUBzZO8Gpt9tHoJtdRxv9oe3TDoSH5jcEOixRNBXg@mail.gmail.com/T/#t

It would be nice if you could summarize the threads a bit in this
cover letter, and tell a bit about how your design evolved from what
was discussed.

> John Cai (4):
>   oneline: parse --newlineafter flag
>   oneline: print newline after decorations if flag provided
>   oneline: test for --newlineafter feature
>   doc: add docs for newlineafter flag

The 2 last patches look very small and might want to be squashed into
the patch that introduces the --newlineafter flag.

Thanks!
