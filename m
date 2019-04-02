Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2017120248
	for <e@80x24.org>; Tue,  2 Apr 2019 02:39:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726841AbfDBCjR (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Apr 2019 22:39:17 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36484 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726411AbfDBCjQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Apr 2019 22:39:16 -0400
Received: by mail-wm1-f65.google.com with SMTP id h18so1664980wml.1
        for <git@vger.kernel.org>; Mon, 01 Apr 2019 19:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=at1zPa0x/7jkaf1Tco9XBxxcBSP4wv9ZUdVHdv3Df4E=;
        b=fOrg4Wai8dxHx/GQtzbtPea6fZETt2hC3Y7zUuoDIJB76mtH0ZZgGeI86PtBnkZuGq
         l0996JKONXcAo1ZlS58Z3XbGxv/7tXN+ygnlme59L/qA2u1n0UuFAXIlAqoL8A2QiRZL
         qHxn/80w4bCdDD3VLDf/p4TG0Gznxk9SJLesV14q7Co/2+iyQhDgroFd1ayc0oFq7TFx
         CF7lyN1/mBBqwSjqAjREAOSffBuUJwmyExRiZVoNCCvo1PRkEsS6r0V16XQs/3N2BImo
         Yo/UHABzoYBDocZ45VhJHoIpopW7MEt2ExPNp/73QThTwoLuUOXZy4ldTW98ADSzJx1d
         bY7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=at1zPa0x/7jkaf1Tco9XBxxcBSP4wv9ZUdVHdv3Df4E=;
        b=XBKYaozvRCyMmHgkU8eAiHKVwdeY4bWUyuygJgGG03eNBMMPsGyn+OEebfMxExDke+
         psN4/SKBgvOB6ZB76UvObonhA7InAhXLVRhPQ2W48GZVEWM8xSchMPRiIyQHHE+dEx6G
         3foaNCkYfz9sGb6Vd/bRnNKNx7dW1fs3zU1zWnS1CsVF+0ymj4l9yyOVmGLBycFu2K87
         QK+OCoZeOcZBH8TtL5cLt7qyJ9lhkiTZAUW8OoChkLjzclxLQ3VY5EyDcN4u4QFZwT1o
         78aoVqKRyn183Er0YEuYPtJqta6FD/extTNnNorr9/uMpMs7TBNRipPiBsJOUfjxxtbV
         i+rA==
X-Gm-Message-State: APjAAAVJluXYIxAp1Wa7bnYnYkVROtnB9oCawNCt1INR0qJGOcSRk6bh
        fF5MJfWmdr4RAea+7TZuDgs=
X-Google-Smtp-Source: APXvYqzczbkAgz1NMUVy9K/dwmU+cp6eqleBUki9KRyiQ60Yoj2+Ffhr9HnR8xxp2/XChEe5BCuO5Q==
X-Received: by 2002:a1c:804c:: with SMTP id b73mr1630093wmd.116.1554172754841;
        Mon, 01 Apr 2019 19:39:14 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id j22sm35181775wrd.91.2019.04.01.19.39.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 01 Apr 2019 19:39:13 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Khalid Ali <khalludi123@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [GSoC][PATCH v1] t9811: avoid pipe in git commands in test script
References: <20190402014115.22478-1-khalludi123@gmail.com>
Date:   Tue, 02 Apr 2019 11:39:13 +0900
In-Reply-To: <20190402014115.22478-1-khalludi123@gmail.com> (Khalid Ali's
        message of "Mon, 1 Apr 2019 21:41:15 -0400")
Message-ID: <xmqqk1gdt9ke.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Khalid Ali <khalludi123@gmail.com> writes:

> The exit code of the upstream in a pipe is ignored thus we
> should avoid using it. By writing out the output of the git command to a
> file, we can test the exit codes of both the commands.

End the log message here by moving the next two paragraphs below the
three-dash line.

>
> Aside from the commit message, I plan to apply for GSoC. Planning to
> solve the rebase/cherry-pick issue or adding functionality for the
> rebase interactive command. 
>
> Any review on this commit would be appreciated!
>
> Signed-off-by: Khalid Ali <khalludi123@gmail.com>
> ---
>  t/t9811-git-p4-label-import.sh | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/t/t9811-git-p4-label-import.sh b/t/t9811-git-p4-label-import.sh
> index 602b0a5d5c..2f4e80ed55 100755
> --- a/t/t9811-git-p4-label-import.sh
> +++ b/t/t9811-git-p4-label-import.sh
> @@ -63,7 +63,8 @@ test_expect_success 'basic p4 labels' '
>  		git checkout TAG_WITH\$_SHELL_CHAR &&
>  		test -f f1 && test -f f2 && test -f file_with_\$metachar &&
>  
> -		git show TAG_LONG_LABEL | grep -q "A Label second line"
> +		git show TAG_LONG_LABEL >actual &&
> +		grep -q "A Label second line" actual

There is no mention of file 'actual' before this patch, so we can
reasonably be sure that we are not breaking expectations of existing
test that a file with that name has contents different from what the
above command produces.  On the other hand, if later tests have
things like "git add ." or "git status -s" and expects that there is
no such file called 'actual', this change may have broken the
expectation.

I *think* the above is done after going inside $git directory, which
will be removed with "test_when_finished cleanup_git", so it is
fairly clear that leaving an extra file 'actual' behind at this
point is safe.

This is not a problem with this conversion, but we tend to avoid
squelching standard output to help debugging tests.  An independent
clean-up patch may want to replace "grep -q" with just "grep".

> @@ -92,9 +93,9 @@ test_expect_success 'two labels on the same changelist' '
>  		cd "$git" &&
>  		git p4 sync --import-labels &&
>  
> -		git tag | grep TAG_F1 &&
> -		git tag | grep -q TAG_F1_1 &&
> -		git tag | grep -q TAG_F1_2 &&
> +		git tag >actual && grep TAG_F1 actual &&
> +		git tag >actual && grep -q TAG_F1_1 actual &&
> +		git tag >actual && grep -q TAG_F1_2 actual &&

Ditto.

>  
>  		cd main &&
>  
> @@ -205,7 +206,7 @@ test_expect_success 'use git config to enable import/export of tags' '
>  		git p4 rebase --verbose &&
>  		git p4 submit --verbose &&
>  		git tag &&
> -		git tag | grep TAG_F1_1
> +		git tag >actual && grep TAG_F1_1 actual
>  	) &&

I notice that this test piece does not call cleanup_git when it is
done.  I think that is a mistake (not introduced by this patch) that
ma want to get fixed independently.

>  	(
>  		cd "$cli" &&
