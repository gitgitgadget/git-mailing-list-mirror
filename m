Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 208FA1F404
	for <e@80x24.org>; Tue,  6 Mar 2018 22:42:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754151AbeCFWmp (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Mar 2018 17:42:45 -0500
Received: from mail-wr0-f193.google.com ([209.85.128.193]:34012 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753868AbeCFWmo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Mar 2018 17:42:44 -0500
Received: by mail-wr0-f193.google.com with SMTP id o8so261680wra.1
        for <git@vger.kernel.org>; Tue, 06 Mar 2018 14:42:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=AIMHNcvqQiD2whg+T0+tovgPj3MSrVntKnQDriZl6wk=;
        b=sEEnNWSItuwL4+TWsmkPUCN+KVxSw6gYl0vq2rMhs9HZ4iVN562KCNTGWYCuenu6Ou
         caUO6ntZUHzoFk2VK9RZ8wpi/a3yFhsBpngIatSSoAdUjmROPuhJAnxl/+15/FO2KPBy
         2mEZvukCgc3d/itI3L3P5DiGvqrfJwaiDpRsuDsEb4Qu+AzT7ZNpj7X1yt/aWRj76Rjn
         A6VmfdPrvN7U1kbjQKeY3WWnYAte9ngvEvNgRYskD/G3Ckd1yYXGWXahCkt5yza2VoEz
         SGtN3tROec8mF68GdOEOWkgkuVtyZLJnWDrdIx9d/QzPkPeA4qe+m93XHy/jUkWjvf+x
         tRTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=AIMHNcvqQiD2whg+T0+tovgPj3MSrVntKnQDriZl6wk=;
        b=jr0NTWguBgl1i/ulPd1EPvtdOfLsQKXtiDnPRBAh4m7b+TXPyDTq7kJGopybxJQYPN
         J3Spn9qbY99l7dion5W+Bi1FeAblRKDxmW0UEsEotb4kcPcpwH0ZAv6DLmZCAsYFRjon
         Iay2XeIH40pCd5L/KbzYUjXfQ4RjJF0dWP7AC2KOl6cR7wht5vW3BVgT+aw3bFAch/wc
         kYjn1aw9jhfaMfCzsp2tgVCrM07Nn4l1BYEtkvsh7UzBTkbF0Tu2jsA9akLmCSBoqc/a
         yCI/rj+doTCZtQnhlor8XUCVYjX6sLwM4oNCouFCmGZoLAU62eveKUgHSBpWFAnwwJdt
         GhIw==
X-Gm-Message-State: APf1xPBR2rJYP/NScvBV7uL1r1pUjIHUYCzDKAoDde0WjOd0oLJfRrXu
        5CVKEgFI94+YDmZEF7yiQVQ=
X-Google-Smtp-Source: AG47ELv5l8Gz4cAzdlR2if+fiaB3wb3unVMLfTw00NBFCW3yRX321tgl5L9AQaG0kUd0pNPzbXaWWg==
X-Received: by 10.223.160.147 with SMTP id m19mr18520063wrm.32.1520376162294;
        Tue, 06 Mar 2018 14:42:42 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id f142sm11073137wme.15.2018.03.06.14.42.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 06 Mar 2018 14:42:41 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Git mailing list <git@vger.kernel.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 2/2] completion: simplify _git_notes
References: <20180303092307.3796-1-pclouds@gmail.com>
        <20180303092307.3796-3-pclouds@gmail.com>
        <CAM0VKjmmF2t=B2s3rJoKmO3j6Bk5d6PEfCV==ONRGMcdUMLFpQ@mail.gmail.com>
Date:   Tue, 06 Mar 2018 14:42:40 -0800
In-Reply-To: <CAM0VKjmmF2t=B2s3rJoKmO3j6Bk5d6PEfCV==ONRGMcdUMLFpQ@mail.gmail.com>
        ("SZEDER =?utf-8?Q?G=C3=A1bor=22's?= message of "Sat, 3 Mar 2018 14:09:17
 +0100")
Message-ID: <xmqqd10g3jxb.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER Gábor <szeder.dev@gmail.com> writes:

> There is a minor behaviour change here, though.  This
>
>   prune,*)
>     ;;
>
> case arm ensured that we don't list refs for 'git notes prune <TAB>',
> because it doesn't accept them (and then we take our usual fallback and
> let Bash complete filenames;  yeah, 'git notes prune' doesn't accept
> filenames either, but, as I said, that's our usual fallback when we
> can't offer anything for completion).
>
> This patch removes that case arm, and refs will be offered for 'git
> notes prune <TAB>'.
>
>> +       *,--*)
>> +               __gitcomp_builtin notes_$subcommand
>>                 ;;
>>         *)
>>                 case "$prev" in

I have this tentatively queued on the topic.  Can we wrap the topic
up and move it forward, instead of leaving it (and other topics)
hanging around and causing conflicts with other topics in flight,
please?

Thanks.


Subject: [PATCH] SQUASH???

By Szeder <CAM0VKjmmF2t=B2s3rJoKmO3j6Bk5d6PEfCV==ONRGMcdUMLFpQ@mail.gmail.com>
---
 contrib/completion/git-completion.bash | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index ab80f4e6e8..5f7495cda3 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1836,6 +1836,11 @@ _git_notes ()
 	add,--reedit-message=*|append,--reedit-message=*)
 		__git_complete_refs --cur="${cur#*=}"
 		;;
+	prune,--*)
+		__gitcomp_builtin notes_prune
+		;;
+	prune,*)
+		;;
 	*,--*)
 		__gitcomp_builtin notes_$subcommand
 		;;
-- 
2.16.2-345-g7e31236f65

