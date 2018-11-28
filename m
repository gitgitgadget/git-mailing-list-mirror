Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3809D1F609
	for <e@80x24.org>; Wed, 28 Nov 2018 16:12:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728833AbeK2DOn (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Nov 2018 22:14:43 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:39527 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728251AbeK2DOn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Nov 2018 22:14:43 -0500
Received: by mail-io1-f65.google.com with SMTP id k7so10528882iob.6
        for <git@vger.kernel.org>; Wed, 28 Nov 2018 08:12:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3i81h6UnvngswbKP40E6Xux67RtodyTNt42Bn7EsKcY=;
        b=CpqW+5toBB2uYW3Kj5B1j3fNTYmjxXgrydi0LBT0dKcJNAHMR6GEfhgcfgk0fHUCwD
         sgE32s8JPQ1y6CEj7jxXpSVhd9FaSSsamxKOCeWhJ9qVLDW7BokYWJP3+mTnhOEWtJLj
         FD0vMomC71/hqosBmP8IKf0hGN9MmxfSkdCwihJP+n/765Mg4RoMu8BTOrXXSO4W3dP1
         fNEW+AxylRBcRM0w4K83qYK2O4Kzboln+/vm7il017bphn/+/mz85XbsSsH4RkLFNNfC
         oCRw3oE7H1bTqYbcekUGQPCleBc9DhOy7LSKVklz4/v7X++KR7NnKwcMRjI2e1iM36AH
         pfRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3i81h6UnvngswbKP40E6Xux67RtodyTNt42Bn7EsKcY=;
        b=bNjFUVyo4OSNaJRALouwiwj8DJODOmTG3PfR/p3LqVkNHaOt/aAfGyjUTGM9AtuUZv
         Rx7CMHyUUR1gNAwCIOxpiuZnw9L0Gx169RXfTW7vaXjnMe5UzrQ792CAafsFlS23K+n+
         GyRJOPPHd3kOLGu3jo+fZpPJc/TTrs79e+FRuThAOqw5lgN8fG0LTsQTjiQNTU1zhPig
         YlvVYsrMieKhRN28xaFHZhH4UuM9FXIlUMsmPTmb30c7ks0TODPPgsD5XY3MGI1pG1Kq
         zEn5TIPfn3vKb8n+7vkADAfmRT1R9bOBZuJo42CpdYxmb3khoUVnjy10wxMfPpaa+V00
         SZOg==
X-Gm-Message-State: AA+aEWZ1TLJ4hx5Yu8gyBBmrW02YeebTrbEFDxI0o8wIT+sNeauFCon/
        +OwkeVIGS9CavvG5Fu8QcwDKMVB+zAM9itGCTCE=
X-Google-Smtp-Source: AFSGD/WNhziph1uqe3Awc+uTbzQHRSC7WPGWbwjSyCKhwxOYEUOmmMuSpdz5LQm452UcPwZgMUHDefc0u9LPwinC/UQ=
X-Received: by 2002:a5d:9455:: with SMTP id x21mr10390154ior.282.1543421552833;
 Wed, 28 Nov 2018 08:12:32 -0800 (PST)
MIME-Version: 1.0
References: <20181108060158.27145-1-newren@gmail.com> <20181122044841.20993-1-newren@gmail.com>
 <20181122044841.20993-2-newren@gmail.com>
In-Reply-To: <20181122044841.20993-2-newren@gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 28 Nov 2018 17:12:06 +0100
Message-ID: <CACsJy8BpVgTaE0EM9qkj5dK68x85ZbMmDZ-S7Jvf_KDqYrAW=A@mail.gmail.com>
Subject: Re: [PATCH v3 1/7] rebase: fix incompatible options error message
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Pratik Karki <predatoramigo@gmail.com>,
        phillip.wood@talktalk.net
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 22, 2018 at 7:32 PM Elijah Newren <newren@gmail.com> wrote:
>
> In commit f57696802c30 ("rebase: really just passthru the `git am`
> options", 2018-11-14), the handling of `git am` options was simplified
> dramatically (and an option parsing bug was fixed), but it introduced
> a small regression in the error message shown when options only
> understood by separate backends were used:
>
> $ git rebase --keep --ignore-whitespace
> fatal: error: cannot combine interactive options (--interactive, --exec,
> --rebase-merges, --preserve-merges, --keep-empty, --root + --onto) with
> am options (.git/rebase-apply/applying)
>
> $ git rebase --merge --ignore-whitespace
> fatal: error: cannot combine merge options (--merge, --strategy,
> --strategy-option) with am options (.git/rebase-apply/applying)
>
> Note that in both cases, the list of "am options" is
> ".git/rebase-apply/applying", which makes no sense.  Since the lists of
> backend-specific options is documented pretty thoroughly in the rebase
> man page (in the "Incompatible Options" section, with multiple links
> throughout the document), and since I expect this list to change over
> time, just simplify the error message.

Can we simplify it further and remove the "error: " prefix? "fatal:
error: " looks redundant.
-- 
Duy
