Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3D17120401
	for <e@80x24.org>; Wed, 21 Jun 2017 17:25:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752042AbdFURZJ (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Jun 2017 13:25:09 -0400
Received: from mail-pf0-f169.google.com ([209.85.192.169]:35026 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751106AbdFURZI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jun 2017 13:25:08 -0400
Received: by mail-pf0-f169.google.com with SMTP id c73so27742030pfk.2
        for <git@vger.kernel.org>; Wed, 21 Jun 2017 10:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=YVkwpZjDCoOCX8ElLQVGug9bYhD/yu2BS64FUb+dSNI=;
        b=bvB2gGxnXMOpIx5tMocXJQRRXFNwor87E9ymHUQ9q1Dz6P/RYxN+4h3EGYaAyQJq7W
         G+yuTJ7XRnv5HLP6WSauLKvunnRTczVpHyY4VK9tjISPYFF9QC2jt++vUwH8doNoTPVV
         LTB6XAZas5L5i2TsQaaZmmG0Wx1iwzPJ57KbkHwYSdVXHIcGFQITpMEfGerdib+o5e1f
         QCLOmvix0CXAPvAZNkuwSNrPrpJQyMl47GFxAkHvuD6c1WXhAViadQySe85j/aZPCw8Q
         GSQ9M1bo1A4ecY0tjFY2iyNuY6Efy/sxSKm6HGiipcDgW2RJsUa3E2GDSGYm8WBtCkeT
         Eo5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=YVkwpZjDCoOCX8ElLQVGug9bYhD/yu2BS64FUb+dSNI=;
        b=R/Ove0nIZd3bH2th839TYha0FIHeXdJDXQHFVk+2JN0jtrXdrts9HMahoJoqjc6bIg
         p5ov5Mu2z6EadyHlW6YicqjAhRYt4Fd4l6krpodFtOiPbnVDpJUDi9HcgzJfS0RSR7Bn
         K642kMCA6UcIv83WR7VJqmZmHA+nPUQMXe/y2+nCZPn70LVOe1Jwj6IRyqqWocMJSynI
         WeY/GyqqMNCaIB1Q4+7g09+oED1iv4ham1DUdttxw2RfwnUm4Q33ZIHSlkNYABxH08Tb
         gb7RXvnzslX0rRa/ZwI/oqK28ieDMU7TuSoQekGyPFQ8XxyZzsI3/hRxz4xq4U+DhA39
         mo5A==
X-Gm-Message-State: AKS2vOx9O5ZbsPj3wVSPD4n7sSa05Ks25EJs/44TUNN8AzBXtLAykJFy
        cb13sr4K0lnEdhRrm+bikUpQbWwN8oTk
X-Received: by 10.99.186.81 with SMTP id l17mr19101484pgu.87.1498065907472;
 Wed, 21 Jun 2017 10:25:07 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.161.227 with HTTP; Wed, 21 Jun 2017 10:25:06 -0700 (PDT)
In-Reply-To: <CAGf8dg+f-RzcT15zofB9xbgEE6nTK+T7awjOHY+KEx7KZ-cPXg@mail.gmail.com>
References: <20170607185354.10050-1-sbeller@google.com> <20170620225650.7573-1-sbeller@google.com>
 <CAGf8dg+f-RzcT15zofB9xbgEE6nTK+T7awjOHY+KEx7KZ-cPXg@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 21 Jun 2017 10:25:06 -0700
Message-ID: <CAGZ79kYbjYyFk5-z+68iUqM=U8dgnDEzReS9aTshXb97Co+RqQ@mail.gmail.com>
Subject: Re: [PATCHv2] submodules: overhaul documentation
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        Brandon Williams <bmwill@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 20, 2017 at 8:45 PM, Jonathan Tan <jonathantanmy@google.com> wrote:
> Thanks, this looks like a good explanation. Some more nits, but
> overall I feel like I understand this and have learned something from
> it.
>
> On Tue, Jun 20, 2017 at 3:56 PM, Stefan Beller <sbeller@google.com> wrote:
>> +A submodule is another Git repository tracked inside a repository.
>> +The tracked repository has its own history, which does not
>> +interfere with the history of the current repository.
>> +
>> +It consists of a tracking subdirectory in the working directory,
>> +a 'gitlink' in the working tree and an entry in the `.gitmodules`
>
> Probably should be `gitlink` (the special quotes), and (optional)
> s/`gitlink`/`gitlink` object/ because it might not be apparent that
> gitlink is a type of object.
>
>> +file (see linkgit:gitmodules[5]) at the root of the source tree.
>
> After reading below, maybe we should mention the Git directory in
> $GIT_DIR/modules/<submodule name> as part of what a submodule consists
> of too.

I implemented the rest of the suggestions, but this one leaves my head
scratching.
It's not as if we don't know what a submodule is already. Our glossary says:

    submodule
           A repository that holds the history of a separate project inside
           another repository (the latter of which is called superproject).

So by that definition the gitlink and the entry in .gitmodules are just
metadata by the superproject and the actual submodule is the
repository consisting of its working tree (inside the superprojects
working tree)
as well as its git directory preferably inside the superprojects git dir.

This definition however is broken IMHO, as when there is proper meta data
(gitlink + .gitmodules entry), you can have an "uninitialized" submodule,
which has neither a working tree nor a git dir at the time.

The wording above holds true for un-{initialized,populated} submodules
as well, as the tracking directory is empty and the git dir doesn't exist.

So I think I'll resend without that change.

Thanks,
Stefan
