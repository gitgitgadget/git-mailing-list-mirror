Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8CB1D1FD09
	for <e@80x24.org>; Mon, 29 May 2017 04:27:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750880AbdE2E1s (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 May 2017 00:27:48 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:36642 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750844AbdE2E1r (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 May 2017 00:27:47 -0400
Received: by mail-pg0-f68.google.com with SMTP id h64so5169041pge.3
        for <git@vger.kernel.org>; Sun, 28 May 2017 21:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=NqYcpY5RzUws7N60L0y4EtEZQcVIiblRe9uCtrb0Pt0=;
        b=UmtdBgUDNv1dpGE5geNimL6e9EgxNo1rmJvAhZq9AY7Ut7joesW47YCLw2nf8faedO
         xrT66fjJiZy2j7COr41gnfa5vR00YySgUw/DVBdhICI9zcepLFNoywHbxHBLe8GIBrl2
         mly+2BjAhsLyeRRofYGyYvygpgWuHKArBlAm937vvG02uZXCOfQPXZeHenwh7pl04r+A
         SPwP+G1mCb+8M7WlQERvihI9JMlaNC9lVpI46pI4i5t2ijbykOKTmnh92J8nVfRVdz1o
         LeFVm3enT2tKLzb6sQ9xzeQnyZti9cNB93fYqqdRyAzbeVcInxhCR88ffQu/lym0/y+n
         QrNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=NqYcpY5RzUws7N60L0y4EtEZQcVIiblRe9uCtrb0Pt0=;
        b=o5w8nKIZPD9Jxil7fWeKDqFhVmjxqTU6Vq6Rrf8r5VVBAmqe8vZVS7LOsUhqABKAnb
         lAi6MaFUjInlk2SYOGUliclX4krVfiJJlBh79loy9WR00sEcJ4LUIkrc0ENczkaztlxE
         v77C8wdLTWbH5e1ZY+pzpVIxAza5G3XYTgtB/CWbtJc1m7nZyFkXtIfU6nXtk4FFmfRN
         TgwxYRmdh89HibZ5j/i6avWVRAsaevs9o6GGvmxXoDQ98r8ZYP+7U++NSs9EYeA+EsCP
         ZIcSVD5lr1Mb1sV8RwnV0gO24CoLhOjbmUIxRCpWuO1karFJKed8mFVJWocokEHBPqK5
         s8/g==
X-Gm-Message-State: AODbwcAAnNahpVxkl7JK+PmuJ3DGszdouTpZdRx2vXRpaFY0VrGei/93
        iI12jDdr82Y7Gg==
X-Received: by 10.98.40.198 with SMTP id o189mr15926955pfo.238.1496032066860;
        Sun, 28 May 2017 21:27:46 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:393e:d787:9be9:17cc])
        by smtp.gmail.com with ESMTPSA id e124sm13421347pfc.64.2017.05.28.21.27.46
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sun, 28 May 2017 21:27:46 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Samuel Lijin <sxlijin@gmail.com>
Cc:     Jeff King <peff@peff.net>, Andreas Heiduk <asheiduk@gmail.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH] doc: filter-branch does not require re-export of vars
References: <20170526173654.4238-1-asheiduk@gmail.com>
        <20170526183702.jrjkykhldz74pquq@sigill.intra.peff.net>
        <CAJZjrdVjeeHUN_biza-MA9iqP5Y5CO3DkLaGG-Bq1w5oo5tW_g@mail.gmail.com>
Date:   Mon, 29 May 2017 13:27:45 +0900
In-Reply-To: <CAJZjrdVjeeHUN_biza-MA9iqP5Y5CO3DkLaGG-Bq1w5oo5tW_g@mail.gmail.com>
        (Samuel Lijin's message of "Sun, 28 May 2017 21:35:30 -0400")
Message-ID: <xmqqa85w8eym.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Samuel Lijin <sxlijin@gmail.com> writes:

>> However, I think POSIX mandates the behavior you'd expect. And the only
>> shell I know that misbehaves in this way is Solaris /bin/sh, which we
>> have already declared too broken to support.
>
> Off-topic, but where is this explicitly documented?

One link I had readily available was

  https://public-inbox.org/git/7vei5qtnc5.fsf@alter.siamese.dyndns.org/

but there may be older discussions that were the actual process of
our officially having "written its /bin/sh off as broken and
unusable" if you dig further in the list archive.
