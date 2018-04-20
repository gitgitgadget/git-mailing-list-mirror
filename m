Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 812AA1F404
	for <e@80x24.org>; Fri, 20 Apr 2018 01:21:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753790AbeDTBVK (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Apr 2018 21:21:10 -0400
Received: from mail-wr0-f176.google.com ([209.85.128.176]:45888 "EHLO
        mail-wr0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753761AbeDTBVJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Apr 2018 21:21:09 -0400
Received: by mail-wr0-f176.google.com with SMTP id u11-v6so18590939wri.12
        for <git@vger.kernel.org>; Thu, 19 Apr 2018 18:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=OxsxZrTYT6t7ANQkXNKpnjGn1eVkGN7r4q0iZjVdkMg=;
        b=ThCcZp6JvL6jSjTBcCcGyqVhr3ZaWEqd741MFDIEhgxKuycUzwahQlTduBChqWe+jU
         a+a7j05VKYLv2VDp5ajBkBfymbepJAmjMhGjKUBMvQewX3PEqN6xnJZg0CTt2qMHzYTx
         7KOjO6MoQi2B4NCGTK0KrvfjB8pDkuX/JFMyqrTSjJWVE/Mf/it2AA3DZDwqu+FqKFho
         802M0U5WxrVs5E6ARb4XAQKvlbkw1xv/eDE0DULWVFCJJsv6xsoqr7bgw33Elu3IY4hH
         MPdeAz5RLQICJ8/ll/nU/KK3vCFDlxOIQrAU+jVRrBOHJ4/YY14Z6Z6ratI4r0FW5h0f
         Z3sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=OxsxZrTYT6t7ANQkXNKpnjGn1eVkGN7r4q0iZjVdkMg=;
        b=LAaJoHaQT1VM99qBFaYVcYyu4Tsglgrtux89AW4GVjlG/9xzMp4zgTNDHb9Te2chzT
         lkf2CA7gQpebQznh66vE5QwjkGVZoK3nC7WtsO5b9/Ll5ahK6iR8wDEpjnlB9R8X7D3z
         2QJ0w1R2NqGJkErJFT7txQ2hH9i1d1LDC/kCiFpe+ILOURlqzyF34ka2H0Q0/af1jDjx
         VRzFA+5SqrGJrMJz8rJEkoOn3yOegIiees0G4p3ACLJT7Sqtv/H0VcN09U/eXV7CA0JG
         2iwQBcpXiovjrGakukFTj3lcusRSLFGMuBx4zn4q1lYQadoJ5OkkYEeIXPNlA3TLMR1Y
         8t0g==
X-Gm-Message-State: ALQs6tAgNSQCd/Fy6dZAFbbCDQxt6HV2SYzGItk2nlXR6gQ4oGgphY9+
        CBP9vvQLyGJ+EYcBe52MBFA=
X-Google-Smtp-Source: AB8JxZq6OKDOqFVdJGoXLtCX6KD0pnPi3NXgofJBDLaqxa9LxiFey/yvMtd6Q+hiq6DcEtZ5F/Bo5g==
X-Received: by 10.28.141.138 with SMTP id p132mr533901wmd.51.1524187267609;
        Thu, 19 Apr 2018 18:21:07 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id 64sm560040wmb.2.2018.04.19.18.21.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 19 Apr 2018 18:21:06 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 3/7] Add a test for `git replace --convert-graft-file`
References: <0f0942043678fe76f8d654306482ee26fac643f0.1523617836.git.johannes.schindelin@gmx.de>
        <cover.1524125760.git.johannes.schindelin@gmx.de>
        <cf8169c80f08612185f81927ee6ff22e087b2835.1524125760.git.johannes.schindelin@gmx.de>
Date:   Fri, 20 Apr 2018 10:21:06 +0900
In-Reply-To: <cf8169c80f08612185f81927ee6ff22e087b2835.1524125760.git.johannes.schindelin@gmx.de>
        (Johannes Schindelin's message of "Thu, 19 Apr 2018 10:18:10 +0200
        (DST)")
Message-ID: <xmqq7ep2d665.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> The proof, as the saying goes, lies in the pudding. So here is a
> regression test that not only demonstrates what the option is supposed to
> accomplish, but also demonstrates that it does accomplish it.

The above spreads the misconception that the value of the test is
"what I wrote works, look here".  It is not.  "Here is how this
thing is supposed to work.  You are free to improve it, but do not
break the basic promises these tests outline" to protect the
resulting system is.

> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  t/t6050-replace.sh | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>
> diff --git a/t/t6050-replace.sh b/t/t6050-replace.sh
> index c630aba657e..77ded6df653 100755
> --- a/t/t6050-replace.sh
> +++ b/t/t6050-replace.sh
> @@ -444,4 +444,24 @@ test_expect_success GPG '--graft on a commit with a mergetag' '
>  	git replace -d $HASH10
>  '
>  
> +test_expect_success '--convert-graft-file' '
> +	: add and convert graft file &&
> +	printf "%s\n%s %s\n%s\n" \
> +		$(git rev-parse HEAD^^ HEAD^ HEAD^^ HEAD^2) \
> +		>.git/info/grafts &&

I find the above much less readbale than something like

	{
		git rev-parse HEAD^^
		git rev-parse HEAD^ HEAD^^
		git rev-parse HEAD^2
	} >.git/info/grafts

because printf formatting string must be deciphered and then matched
against the order and number of rev-parse arguments (and printf's
ability to happily accept more args than the placeholders does not
help in readablity---the reader needs to verify that the code is not
doing anything overly clever exploiting that ability) before I can
figure out who's parent of whom.

Of course, it saves a few spawning of subprocesses; I am not sure if
that is worth the loss of readability in this case, though.

> +	git replace --convert-graft-file &&
> +	test_path_is_missing .git/info/grafts &&

Successful conversion exits with success, and removes the grafts
file.  Good.

> +	: verify that the history is now "grafted" &&
> +	git rev-list HEAD >out &&
> +	test_line_count = 4 out &&

We are pretending that HEAD^ has only one parent HEAD^^ and that
HEAD^^ and HEAD^2 are roots with the above graft.  We want the
resulting "apparent" history to also show that fact, and the
traversal should stop after counting HEAD, HEAD^, HEAD^2 (which is
root), and HEAD^^ (which is also root).  Good.

> +	: create invalid graft file and verify that it is not deleted &&
> +	test_when_finished "rm -f .git/info/grafts" &&
> +	echo $EMPTY_BLOB $EMPTY_TREE >.git/info/grafts &&
> +	test_must_fail git replace --convert-graft-file 2>err &&
> +	grep "$EMPTY_BLOB $EMPTY_TREE" err &&
> +	grep "$EMPTY_BLOB $EMPTY_TREE" .git/info/grafts
> +'
> +
>  test_done
