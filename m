Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AFDBA1F403
	for <e@80x24.org>; Tue, 19 Jun 2018 16:00:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966907AbeFSQAH (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Jun 2018 12:00:07 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35644 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966895AbeFSQAE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jun 2018 12:00:04 -0400
Received: by mail-wm0-f66.google.com with SMTP id j15-v6so1462475wme.0
        for <git@vger.kernel.org>; Tue, 19 Jun 2018 09:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=nLZlpwKs5zf/LRQ7yd3cpotxZeLbz+o0EFW9shzMAIQ=;
        b=c5xpl/tWB1xbXYlhB6ZU46sE6/OFSfUQ8c3RG8STreit7NIjL3W3l08xSLGCzLUIeC
         Yj823Da0M9+WcBmuUSYyYX6ZfkrBxPJlJq1vzTNio7mbiS0rWU4JJo+20MArUCz0iD9r
         D2iawweDiU3+I/21OGT98KQ7lbSF4SrNAtjnzN0DJlmoD2xzcNegWnBFYqNCYyv0UFWz
         A/pgGCZ4+casNFUA/QuzU6fapqNQ1OPeFZm5ocTJ3zGRykeQkkDFo2YEROpIFqrRrXje
         8z/2+BBA2NU1Gnxp4BUAwpOGb6V5elY46Yt5e7+ATwnS66ekKywAMCZMXoO7WzGVqUff
         cNOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=nLZlpwKs5zf/LRQ7yd3cpotxZeLbz+o0EFW9shzMAIQ=;
        b=sFJCTeeROWA93MY1oOU/W6l4FBzP/pX1mAuG+yru73gWc/aF5XW94rkOkKCP9Z+GKf
         63uKn123qGCXbEt+HfCJPI1x4Wq9zcCfTDCaVGVOfmbsBLiAmS78oMxX7Vf0CamnRj8M
         G3mr+RtsNS2OyjkylnVST6ACgQeKaZ26RelP0lUIzZ4XO9hB666Q1DvIUbEGSocEdv4e
         cmu4YbYIOhVpJXF5KxVjMlfw6cBjeXOr1iFMzne4fg2hkAMckmW73fS0k7lUSF6xXxn3
         /L1tnXSuuZ4anjciSF8R++sWCMBxvi8R4zdkuII5arxF4KCEreBUluiMtY+qsT9d0taz
         n8xg==
X-Gm-Message-State: APt69E0YbKgeXvFJ7ZR37Ne41yEIyklRD/DSokQF4Waaz4lKwmCAAJs/
        AdyXivOrDsykYMnxGaTzvXk2Q87z
X-Google-Smtp-Source: ADUXVKJWtE52/l2I/MwuuPoCj/l0Izn7fyaeEblxexpFsWGEBSgT+TImbATfWszjHqo4kulDbbSaGg==
X-Received: by 2002:a1c:8fd5:: with SMTP id r204-v6mr13254260wmd.77.1529424002601;
        Tue, 19 Jun 2018 09:00:02 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id n11-v6sm58349wro.13.2018.06.19.09.00.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Jun 2018 09:00:01 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Todd Zullinger <tmz@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@talktalk.net>, git@vger.kernel.org
Subject: Re: [PATCH] t3404: check root commit in 'rebase -i --root reword root commit'
References: <pull.3.git.gitgitgadget@gmail.com>
        <d59805a43ddaf4bbd4528a2b7afa9809eca9b86b.1529177176.git.gitgitgadget@gmail.com>
        <484fe825-0726-a027-1187-de00df6406d5@talktalk.net>
        <20180618164958.GO11827@zaya.teonanacatl.net>
        <nycvar.QRO.7.76.6.1806182343421.77@tvgsbejvaqbjf.bet>
        <20180618221942.GQ11827@zaya.teonanacatl.net>
Date:   Tue, 19 Jun 2018 09:00:01 -0700
In-Reply-To: <20180618221942.GQ11827@zaya.teonanacatl.net> (Todd Zullinger's
        message of "Mon, 18 Jun 2018 18:19:42 -0400")
Message-ID: <xmqqin6ewyv2.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Todd Zullinger <tmz@pobox.com> writes:

> With luck, this will save you a few minutes, assuming the
> commit message is reasonable (or can be improved with help
> from Phillip and others). :)

OK.

> Or Junio may just squash this onto js/rebase-i-root-fix.

Nah, not for a hotfix on the last couple of days before the final.
We'd need to build on top, not "squash".

>
> Thanks.
>
>  t/t3404-rebase-interactive.sh | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
> index e500d7c320..352a52e59d 100755
> --- a/t/t3404-rebase-interactive.sh
> +++ b/t/t3404-rebase-interactive.sh
> @@ -977,7 +977,8 @@ test_expect_success 'rebase -i --root reword root commit' '
>  	set_fake_editor &&
>  	FAKE_LINES="reword 1 2" FAKE_COMMIT_MESSAGE="A changed" \
>  	git rebase -i --root &&
> -	git show HEAD^ | grep "A changed"
> +	git show HEAD^ | grep "A changed" &&
> +	test -z "$(git show -s --format=%p HEAD^)"
>  '
>  
>  test_expect_success C_LOCALE_OUTPUT 'rebase --edit-todo does not work on non-interactive rebase' '
