Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3FBD61F85E
	for <e@80x24.org>; Thu, 12 Jul 2018 17:22:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732195AbeGLRdZ (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Jul 2018 13:33:25 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42842 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726528AbeGLRdZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jul 2018 13:33:25 -0400
Received: by mail-wr1-f68.google.com with SMTP id e7-v6so2927509wrs.9
        for <git@vger.kernel.org>; Thu, 12 Jul 2018 10:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=2GJbPf301Tq90njmx73Ya1C8jEnOH+hhsJnCWjadBYQ=;
        b=SUxsxzccVPJXOZqDc45B8NLu0WICLXFyRh3jAAbth6DuGHSmurjt0EIt/O9ekGPKmu
         lG3RegtMNztssH1GOFLPiiuMjc54Z6akuD1pvzZ6HgS6E7bhRGQ1YzDEWi3lgf5hlNfy
         V/IDe2IgRrwy3gWa8sU4YyNrnSDktjmrceRebmTYJOjO2QtgSswQRh8sG4K17Pk7AOPw
         sTHmlzxaGRgDK3ZmHFFUsyg3qOol7q7ubucbIl1E7k5X18JpqxaO3qoaMQSvCDFWk9rV
         hQpN3+5c6/26sxPRo/lhUWuTweSx+4iCnvCPb0thkGdrDjut6Fbvj2DxaeI5OY4/LyiS
         LWlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=2GJbPf301Tq90njmx73Ya1C8jEnOH+hhsJnCWjadBYQ=;
        b=BJT2b9l2QVnuVS6Y1J8rnQz8jH44ZET758dI3mTsdazufDd5ijGNUtLTalT4FcqP7B
         WMj0KgliWe5ndj2JLW0/Zqe4GO8hYjl11f4QqkfpLMSnsfhsLWSM6NhHD533YzCV7rRR
         jg4T4EYtTtfoBUwOdXvTYi7w3F4QOqOsh8PRFCsghuiav+OMZvVr0QzGAHlPYE2oNY5P
         YxdzzKEpgemrGy0/lZ77EvEAYtr4yDo9vbPUX56g/u7CgJGu2OYcOgKnhDzkKivQZCue
         OHu3GTTixLJRoX+M+r641MFKy6IVPsfnyJLhvB2RJt140MwxXZNqN87K1rROBaxFkzEr
         ff2w==
X-Gm-Message-State: AOUpUlFswCCXWbOm77eYqutJ26NzpFJ2TxY1SSGVEtp4SCxB29wtdK4+
        /mqkU3Cvl7slu7RE0S+mdrAnpVIy
X-Google-Smtp-Source: AAOMgpe7cCaQD/7U5gYp8P6WGAYHm1slEBhpRjvfs9f2xoloqsDx/2Heo47IUq7ONmsdcKJlwhLzSw==
X-Received: by 2002:adf:9954:: with SMTP id x78-v6mr2599064wrb.178.1531416173745;
        Thu, 12 Jul 2018 10:22:53 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id z5-v6sm24897505wrv.2.2018.07.12.10.22.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 12 Jul 2018 10:22:52 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Akinori MUSHA" <knu@iDaemons.org>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] sequencer.c: terminate the last line of author-script properly
References: <86a7qwpt9g.knu@iDaemons.org>
Date:   Thu, 12 Jul 2018 10:22:52 -0700
In-Reply-To: <86a7qwpt9g.knu@iDaemons.org> (Akinori MUSHA's message of "Thu,
        12 Jul 2018 20:18:52 +0900")
Message-ID: <xmqqwou0xtar.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Akinori MUSHA" <knu@iDaemons.org> writes:

> It looks like write_author_script() intends to write out a file in
> Bourne shell syntax, but it doesn't put a closing single quote on the
> last line.

s/closing single quote/& and the terminating newline/?

>
> This patch makes .git/rebase-merge/author-script actually parsable by
> sh(1) by adding a single quote and a linefeed to terminate the line
> properly.

Sounds good.

I wonder why this breakage was left unnoticed for a long time,
though.  It's not like writing and reading the author-script from C
code was done first in the "rebase -i" and friends that are users of
the sequencer machinery (I think we had code to do so in "git am"
that was rewritten in C first).  Do we have a similar issue over
there as well?  If not, perhaps if we reused the existing code that
was not broken, we wouldn't have seen this breakage on the sequencer
side?

Thanks.

>
> Signed-off-by: Akinori MUSHA <knu@idaemons.org>
> ---
>  sequencer.c                   |  1 +
>  t/t3404-rebase-interactive.sh | 13 +++++++++++++
>  2 files changed, 14 insertions(+)
>
> diff --git a/sequencer.c b/sequencer.c
> index 4034c0461..5f32b6df1 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -651,6 +651,7 @@ static int write_author_script(const char *message)
>  			strbuf_addch(&buf, *(message++));
>  		else
>  			strbuf_addf(&buf, "'\\\\%c'", *(message++));
> +	strbuf_addstr(&buf, "'\n");
>  	res = write_message(buf.buf, buf.len, rebase_path_author_script(), 1);
>  	strbuf_release(&buf);
>  	return res;
> diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
> index 352a52e59..345b103eb 100755
> --- a/t/t3404-rebase-interactive.sh
> +++ b/t/t3404-rebase-interactive.sh
> @@ -75,6 +75,19 @@ test_expect_success 'rebase --keep-empty' '
>  	test_line_count = 6 actual
>  '
>  
> +test_expect_success 'rebase -i writes out .git/rebase-merge/author-script in "edit" that sh(1) can parse' '
> +	test_when_finished "git rebase --abort ||:" &&
> +	git checkout master &&
> +	set_fake_editor &&
> +	FAKE_LINES="edit 1" git rebase -i HEAD^ &&
> +	test -f .git/rebase-merge/author-script &&
> +	unset GIT_AUTHOR_NAME GIT_AUTHOR_EMAIL GIT_AUTHOR_DATE &&
> +	eval "$(cat .git/rebase-merge/author-script)" &&
> +	test "$(git show --quiet --pretty=format:%an)" = "$GIT_AUTHOR_NAME" &&
> +	test "$(git show --quiet --pretty=format:%ae)" = "$GIT_AUTHOR_EMAIL" &&
> +	test "$(git show --quiet --date=raw --pretty=format:@%ad)" = "$GIT_AUTHOR_DATE"
> +'
> +
>  test_expect_success 'rebase -i with the exec command' '
>  	git checkout master &&
>  	(
> -- 
> 2.18.0
