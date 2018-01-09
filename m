Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 67E171F406
	for <e@80x24.org>; Tue,  9 Jan 2018 18:27:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754081AbeAIS1T (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Jan 2018 13:27:19 -0500
Received: from mail-qt0-f195.google.com ([209.85.216.195]:33980 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753210AbeAIS1S (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Jan 2018 13:27:18 -0500
Received: by mail-qt0-f195.google.com with SMTP id 33so18970803qtv.1
        for <git@vger.kernel.org>; Tue, 09 Jan 2018 10:27:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=RqnJWsLEeAknwot74DuETFwGwX15oPO1Ini/UveAwwQ=;
        b=eBFW/RC49ehrSn2tOCDsexbidMNH5Gv1NWMNl0RGctDGVL+tVm8LdedhA1oJhXrtWv
         zYr+rIrM1e/MrK5TUlWe5ZjtQ+3rPKfayj9LZEDWntOCeWF0+rrqzWsbDvgh/hNbQIXB
         SNn+WFwP6Ofaxb0fnqgTR8RjCIkJPN1gg40roULPMQViiM0jmBV9GR+jkBfieaWVUDok
         zbLZyoPf0Ge6mOh6zcs7y7Z4sGrIgDOwIbGQwM+Lxmi9HT8L/5zwwDa9OBe5VlrZZcTx
         AJaAZIAnVGAV6Y/6+GZ8JZylYxUc75UyXCihZuWln7nasD10U5VOboAsUAk55M4m7UaU
         2RTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=RqnJWsLEeAknwot74DuETFwGwX15oPO1Ini/UveAwwQ=;
        b=Y96BEy36TjzxLGlUlnR0NDkFZgiKt3R8tmR8TA+gz7trtEpmcjylfGhLlsaRtX7/w1
         ySFCnpEsT/zHrzmIyPfGbd+nEP5J1yDZhRFPrG6yYYp/cVlsYDyGb/D6x3pvvdJmnXPx
         M3a2wxoTzmwWmTkhUV7ibHOl2+LDWAXPuIPCpTXCcH0evBinXMPcyUx0PfYxSNPhz+/s
         5ww8mrzPQvgQ1Ax7Xz6Rcx3TQ2/TEY4plvL5KITE5NqYRuMemRE6k9BxWDQrbsIpfwqY
         0PjqQoS0pwXYAFqa0e4Do4pONJP5ZA4QiwvG+lfxSA4pwM/L1NWQLtBAf5sU67+FeLhN
         ARzA==
X-Gm-Message-State: AKwxytfEZP5q6ouvklr+rHsk0DHvbX1fS0XhV4Y+vbTouiOcr1vDKrzz
        BqDKAI+dcvZh1scWWyNL2aiHwD7t69mn/IkLaEU=
X-Google-Smtp-Source: ACJfBoudmg51Z8fhPbUouohh2m99ylnMF/W7AXXNNLpbjuBwvjuz3lxEoEytdmQW205KRar2EKAp6jSlUCJi50cws4w=
X-Received: by 10.200.1.10 with SMTP id e10mr20244632qtg.51.1515522437783;
 Tue, 09 Jan 2018 10:27:17 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.143.2 with HTTP; Tue, 9 Jan 2018 10:27:17 -0800 (PST)
In-Reply-To: <xmqq7esq7v4j.fsf_-_@gitster.mtv.corp.google.com>
References: <CABPp-BGy3_RyVQfCm+9O_AAfKA0_CZ5ajJE7NuLbToERWyWmqQ@mail.gmail.com>
 <20171221191907.4251-1-newren@gmail.com> <20171221191907.4251-3-newren@gmail.com>
 <xmqqbmi484tw.fsf@gitster.mtv.corp.google.com> <xmqq7esq7v4j.fsf_-_@gitster.mtv.corp.google.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 9 Jan 2018 13:27:17 -0500
X-Google-Sender-Auth: fUxpCe-M5S1-Fnhp4VpUaMiXz3s
Message-ID: <CAPig+cQ7Xn_DXG1NSyaktzybNPxiNBgRe=qeuqxrm9Z+GxCROQ@mail.gmail.com>
Subject: Re: [PATCH] merge-recursive: do not look at the index during
 recursive merge
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>, Elijah Newren <newren@gmail.com>,
        Andreas Krey <a.krey@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 9, 2018 at 1:19 PM, Junio C Hamano <gitster@pobox.com> wrote:
> When merging another branch into ours, if their tree is the same as
> the common ancestor's, we can declare that our tree represents the
> result of three-way merge.  In such a case, the recursive merge
> backend incorrectly used to create a commit out of our index, even
> when the index has changes.
>
> A recent fix attempted to prevent this by adding a comparison
> between "our" tree and the index, but forgot that this check must be
> restricted only to the outermost merge.  Inner merges performed by
> the recursive backend across merge bases are by definition made from
> scratch without having any local changes added to the index.  The
> call to index_has_changes() during an inner merge is working on the
> index that has no relation to the merge being performed, preventing
> legitimate merges from getting carried out.
>
> Fix it by limiting the check to the outermost merge.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
> diff --git a/t/t3030-merge-recursive.sh b/t/t3030-merge-recursive.sh
> @@ -678,4 +678,54 @@ test_expect_success 'merge-recursive remembers the names of all base trees' '
> +test_expect_success 'merge-recursive internal merge resolves to the sameness' '
> +       git reset --hard HEAD &&
> +
> +       # We are going to create a history leading to two criss-cross
> +       # branches A and B.  The common ancestor at the bottom, O0,
> +       # has two childs O1 and O2, both of which will be merge base

s/childs/children,/

> +       # between A and B, like so:
> +       #
> +       #       O1---A
> +       #      /  \ /
> +       #    O0    .
> +       #      \  / \
> +       #       O2---B
> +       #
> +       # The recently added "check to see if the index is different from
> +       # the tree into which something else is getting merged into and

Too many "into"s: s/merged into/merged/

> +       # reject" check must NOT kick in when an inner merge between O1
> +       # and O2 is made.  Both O1 and O2 happen to have the same tree
> +       # as O0 in this test to trigger the bug---whether the inner merge
> +       # is made by merging O2 into O1 or O1 into O2, their common ancestor
> +       # O0 and the branch being merged have the same tree, and the code
> +       # before fix will incorrectly try to look at the index.

Nit: Does "code before fix" belong in this comment? It sounds more
like something you'd say in the commit message.

> +
> +       echo "zero" >file &&
> +       git add file &&
> +       test_tick &&
> +       git commit -m "O0" &&
> +       O0=$(git rev-parse HEAD) &&
> +
> +       test_tick &&
> +       git commit --allow-empty -m "O2" &&

s/O2/O1/

> +       O1=$(git rev-parse HEAD) &&
> +
> +       git reset --hard $O0 &&
> +       test_tick &&
> +       git commit --allow-empty -m "O2" &&
> +       O2=$(git rev-parse HEAD) &&
> +
> +       test_tick &&
> +       git merge -s ours $O1 &&
> +       B=$(git rev-parse HEAD) &&
> +
> +       git reset --hard $O1 &&
> +       test_tick &&
> +       git merge -s ours $O2 &&
> +       A=$(git rev-parse HEAD) &&
> +
> +       git merge $B
> +'
