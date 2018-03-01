Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B79531F576
	for <e@80x24.org>; Thu,  1 Mar 2018 07:25:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966470AbeCAHZa (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Mar 2018 02:25:30 -0500
Received: from mail-wm0-f47.google.com ([74.125.82.47]:37190 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966450AbeCAHZ3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Mar 2018 02:25:29 -0500
Received: by mail-wm0-f47.google.com with SMTP id 139so9628639wmn.2
        for <git@vger.kernel.org>; Wed, 28 Feb 2018 23:25:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=3VZzoCI2OLDxlY0Z50gLk+FXY9MpxdDuWu8SJQ7kFJA=;
        b=QJYrhKZt+O4hcdau1574WT3uT//s1C4S1PVcZFXUV2rRHPUE8dtAJ29VsdyLsrKc9q
         Tt/d485ehLtoZkAaJi99+D0S9Mn+guGcYse4wgYnHvyaCT8Eg7VcTeOf4M/9fCiP7SDf
         8iugu5N8Ha7peeIpoDHG4aMb9ZZGS+DcgDVmBdmKBsVS6KQfcndSpmuW3IV66pncX8zW
         CLfP+x7rn4s+L4enAXm9Q//ZTRqkinIQDSwwoWLERM56sWHMfH//8sp6AKyttdSNFFcb
         iTJImOkKPEP9mrkp5cJYz3sL7IOLJwO/luksDzOaHr6Joi+8vthUGYlnpc+n9uUNC89l
         Axjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=3VZzoCI2OLDxlY0Z50gLk+FXY9MpxdDuWu8SJQ7kFJA=;
        b=rqVjSgf1v4qs4C5cz//HO2pxbyAErbKaxId29FTXF+KqAzC+R8zdyyOIwi/4EgUGzR
         ue/EaGgHVf8ANT4J1pI082vdbT4GSeTDvvFIUWsshgntNoLG7O98fYCM/18TzhTQ4CMZ
         V6YJnwXH/Hj6dVvcWtG1VgwkNLuIEUjDGvMAahq5/B1HRrMJVjmHKoRomBOXNnlg4A6+
         krF8ugd9ZwVDzt/UqZxF0LkbUhqW2AJn4sqsCfAeeAT0Jni9y7ojKpd1aiVYcTEzHgSY
         rBo3n4NQ4uq1ovLzjS+adNfqUTJUtAdtX1dsTTa+lqeFwGkiOXSyZogb1s9iZbjYL0xx
         +AMA==
X-Gm-Message-State: APf1xPDgq5NBaatkt3J6DcmVfLpwadyB1qWzbT6d674dH8nCzpKZRkNt
        JtfWb2CpjBABjJarM//Xc8bi6sP8z+6MaNdGb2E=
X-Google-Smtp-Source: AG47ELvG39q6Mx5leqXH0uYWGtXgbA6488TsKRWdVc3znXeqw1Ue5a9ZFupFZeZMvl45Y+FFHM+x8nJgiQMlie/tXHI=
X-Received: by 10.80.139.5 with SMTP id l5mr1563252edl.265.1519889127652; Wed,
 28 Feb 2018 23:25:27 -0800 (PST)
MIME-Version: 1.0
Received: by 10.80.139.133 with HTTP; Wed, 28 Feb 2018 23:25:07 -0800 (PST)
In-Reply-To: <CAGZ79ka6PXgs+JDicaQYWYSKgEthj0A-2bBaRcdp_0T2H+sREA@mail.gmail.com>
References: <CAGZ79ka6PXgs+JDicaQYWYSKgEthj0A-2bBaRcdp_0T2H+sREA@mail.gmail.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Wed, 28 Feb 2018 23:25:07 -0800
Message-ID: <CA+P7+xpB36t7WHpYOa+8wc7kLY7ES_bVEnSHPYHJ50gJ03uQBw@mail.gmail.com>
Subject: Re: The case for two trees in a commit ("How to make rebase less modal")
To:     Stefan Beller <sbeller@google.com>
Cc:     git <git@vger.kernel.org>, Sergey Organov <sorganov@gmail.com>,
        Igor Djordjevic <igor.d.djordjevic@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 28, 2018 at 3:30 PM, Stefan Beller <sbeller@google.com> wrote:
> $ git hash-object --stdin -w -t commit <<EOF
> tree c70b4a33a0089f15eb3b38092832388d75293e86
> parent 105d5b91138ced892765a84e771a061ede8d63b8
> author Stefan Beller <sbeller@google.com> 1519859216 -0800
> committer Stefan Beller <sbeller@google.com> 1519859216 -0800
> tree 5495266479afc9a4bd9560e9feac465ed43fa63a
> test commit
> EOF
> 19abfc3bf1c5d782045acf23abdf7eed81e16669
> $ git fsck |grep 19abfc3bf1c5d782045acf23abdf7eed81e16669
> $
>
> So it is technically possible to create a commit with two tree entries
> and fsck is not complaining.
>
> But why would I want to do that?
>
> There are multiple abstraction levels in Git, I think of them as follows:
> * data structures / object model
> * plumbing
> * porcelain commands to manipulate the repo "at small scale", e.g.
> create a commit/tag
> * porcelain to modify the repo "at larger scale", such as rebase,
> cherrypicking, reverting
>   involving more than 1 commit.
>
> These large scale operations involving multiple commits however
> are all modal in its nature. Before doing anything else, you have to
> finish or abort the rebase or you need expert knowledge how to
> go otherwise.
>
> During the rebase there might be a hard to resolve conflict, which
> you may not want to resolve right now, but defer to later.  Deferring a
> conflict is currently impossible, because precisely one tree is recorded.
>

How does this let you defer a conflict? A future commit which modified
blobs in that tree wouldn't know what version of the trees/blobs to
actually use? Clearly future commits could record their own trees, but
how would they generate the "correct" tree?

Maybe I am missing something here?

Thanks,
Jake

> If we had multiple trees possible in a commit, then all these large scale
> operations would stop being modal and you could just record the unresolved
> merge conflict instead; to come back later and fix it up later.
>
> I'd be advocating for having multiple trees in a commit
> possible locally; it might be a bad idea to publish such trees.
>
> Opinions or other use cases?
>
> Thanks,
> Stefan
