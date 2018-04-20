Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2C25A1F404
	for <e@80x24.org>; Fri, 20 Apr 2018 19:29:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752634AbeDTT3h (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Apr 2018 15:29:37 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:43898 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751136AbeDTT3f (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Apr 2018 15:29:35 -0400
Received: by mail-qt0-f193.google.com with SMTP id l11-v6so11033098qtj.10
        for <git@vger.kernel.org>; Fri, 20 Apr 2018 12:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=8byqD8xJmY7X1FF2DYFsnYMLadS82vnCXjEKDR901S0=;
        b=r3AbFA6J1fTLca0AOQVtsgGJVhsWBBTxRSPQXHA9cBvP19P05InRxuMtM+FY1oGUms
         dMS993dIApPuhA3opxwPmaihV5wkHqNgRtHjLKVTcN9Z10bD5jMwg+2I9qXTvHP+vWac
         HUvGRsNzqd8baQLC1X1qcR6dzCbz2sTxmXgP7JPvt9rbJvh0pKGlHXvhvDF/hx3Hbim+
         IXcZvvnfbK5pu0/KMyRkOVTWBu5N8RZkyPpoZfnHlAKuRDnqdkdOPm5+2dAYWKk7N98k
         yRzXJdB90gURjlLvxAByRhb5IQRGuU/wXliuf+Ywfwxx9ZAqMHgAL3T6n02KUDTLt7gm
         ZJ7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=8byqD8xJmY7X1FF2DYFsnYMLadS82vnCXjEKDR901S0=;
        b=TRiTFEn2aImAsnzpOMXS4WvvTGFU2H4mxmpNcgkAll1jdTH76yNW3GmX2uPSZcT0hM
         a3Dd4BIIwL6ZIlL7IZHG2NMe7pF/+WLbcEVrRKj3lZqGvBz2+koXyokZ2LgXdJpwFQQL
         fqffIIJNkEQT+0thEX1DtcI6Q/MkWkMuYJ0sJ89MZYmC2Hamg54XNzOc0j/lzBLQIES/
         0qkS6cLwX1Qsm72SM7Ug77gMv7BfZe04YNofjqYOGjO8CWO0iCLyaMmxWSFbV0Za3t1C
         Te6uOaJcba7YWRhTYDIQCTzL+YB+5zOvGlC3DsFBjy2vV3VXj5Cs33E4Dgd/Jb71dlaS
         ZMXw==
X-Gm-Message-State: ALQs6tCJxh3mLTOKDRKzNVXisY+sdRIDIoFRjC3AN/hDBTmu3kYBuX0h
        yAGKH1hZst+Cu0rgB++5GhyiUCLDqRYhzqTnCoc=
X-Google-Smtp-Source: AB8JxZroi3i0vV/vfJH+PCumCvoX1m7AP8MoApuXXhS0mc8gF64iE0A4JDApE9HhJPk5nDUl3lkoz0DDhuRamxOWMQ8=
X-Received: by 2002:ac8:17d1:: with SMTP id r17-v6mr11979329qtk.314.1524252574925;
 Fri, 20 Apr 2018 12:29:34 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.174.202 with HTTP; Fri, 20 Apr 2018 12:29:34 -0700 (PDT)
In-Reply-To: <ad2a1b2c60341d692e94b1cb997df05dd7cded88.1524226637.git.johannes.schindelin@gmx.de>
References: <cover.1524226637.git.johannes.schindelin@gmx.de> <ad2a1b2c60341d692e94b1cb997df05dd7cded88.1524226637.git.johannes.schindelin@gmx.de>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 20 Apr 2018 15:29:34 -0400
X-Google-Sender-Auth: ZL-9MtTb1hY1OSKo438JlM1FF8Y
Message-ID: <CAPig+cSb33EG2nATjCem4-2dp87SKOXm_SCWU=fCXJCBRZzgeg@mail.gmail.com>
Subject: Re: [PATCH 1/3] rebase -i: demonstrate bug with fixup!/squash! commit messages
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 20, 2018 at 8:17 AM, Johannes Schindelin
<johannes.schindelin@gmx.de> wrote:
> When multiple fixup/squash commands are processed and the last one
> causes merge conflicts and is skipped, we leave the "This is a
> combination of ..." comments in the commit message.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
> diff --git a/t/t3418-rebase-continue.sh b/t/t3418-rebase-continue.sh
> @@ -88,6 +88,27 @@ test_expect_success 'rebase passes merge strategy options correctly' '
> +test_expect_failure '--continue after failed fixup cleans commit message' '
> +       git checkout -b with-conflicting-fixup &&
> +       test_commit wants-fixup &&
> +       test_commit "fixup! wants-fixup" wants-fixup.t 1 wants-fixup-1 &&
> +       test_commit "fixup! wants-fixup" wants-fixup.t 2 wants-fixup-2 &&
> +       test_commit "fixup! wants-fixup" wants-fixup.t 3 wants-fixup-3 &&
> +       test_must_fail env FAKE_LINES="1 fixup 2 fixup 4" \
> +               git rebase -i HEAD~4 &&
> +
> +       : now there is a conflict, and comments in the commit message &&
> +       git show HEAD >out &&
> +       grep "This is a combination of" out &&
> +
> +       : skip and continue &&
> +       git rebase --skip &&

I see that this test script doesn't utilize it, but do you want a

    test_when_finished "reset_rebase" &&

before starting the rebase to clean up in case something before "git
rebase --skip" fails?

> +       : now the comments in the commit message should have been cleaned up &&
> +       git show HEAD >out &&
> +       ! grep "This is a combination of" out
> +'
