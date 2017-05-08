Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E45231FDEA
	for <e@80x24.org>; Mon,  8 May 2017 06:35:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752145AbdEHGfa (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 May 2017 02:35:30 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:35223 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751528AbdEHGf3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 May 2017 02:35:29 -0400
Received: by mail-pg0-f67.google.com with SMTP id i63so9238975pgd.2
        for <git@vger.kernel.org>; Sun, 07 May 2017 23:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=49DNrLG8dxkSHbO9qbakNcRCkGydrxfvgA84kvETDg8=;
        b=PmlBVknyp7t/VAapW/zgbiqM8KGzXx4kOZiV0m6Ct2BLb0duReXnWPf7b7+lOh+jtt
         L4ju4ZKAIaPAhoEaR7t/uQqFiFPLsx5sOlHUThM/9hFMYuCJS4Yc84fQO82ybY9gQTwZ
         lCno8TK2OTpvVd5DNaOTThh/l9EX2D36Tn95t4n9O1RskzKnNEmIvh473vTdjS2PdnD8
         5P9krbb4/QdqSTGTfzwOWDxdYRUhD/y4c3hzVRlqYlCs91wF4tOnLNkNMmd+oa+wP7gU
         avPYGN7QCrcyMSBHu8bQltxfKxLUCmw/+4/qTDYyMQU5n1Qn7dGyU7gNp+3wYMx6AbIM
         iUnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=49DNrLG8dxkSHbO9qbakNcRCkGydrxfvgA84kvETDg8=;
        b=HKk45K/LWXHKwGNYaGoGkcxyv4tX+HI7d1eROXssR6NRWGf84Ak5+TZDgTSQogZm8q
         OrU5JWP0XARpPtCLRQxKQTb7Nxsi8nD4brE4YgnsyIkZt+MIuzbYUE/gwHk5tE0WeOXz
         7slna17XxWBq0qzOGXyIam75cGPwr24pcVd/+KYfGG6ZU0DhUxOWb9ccQ8LtWbOdFJpL
         FFtheyxjNUUCGM2povhZiEa8gpjWZqcTwgQqYqDDAoVXexGsftsRZYmn3P7OqSqo5cWG
         Z7nIl7n2qpuC7rYu+1rEKPQru5Y777L7ghrhCLHfHmex/OTn0zjDBnWlHT7bjWnb+qJU
         oALQ==
X-Gm-Message-State: AN3rC/5SudyZAQJivN09WlVGKWBvlBgvWhBsuQ2kmV9reR17rRPrJIeH
        U5vXh+qdzWIwig==
X-Received: by 10.84.228.201 with SMTP id y9mr52590781pli.13.1494225329127;
        Sun, 07 May 2017 23:35:29 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:2823:d4da:fd9a:464a])
        by smtp.gmail.com with ESMTPSA id b90sm4655953pfj.19.2017.05.07.23.35.28
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sun, 07 May 2017 23:35:28 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Samuel Lijin <sxlijin@gmail.com>
Cc:     git@vger.kernel.org, Antoine Pelisse <apelisse@gmail.com>
Subject: Re: [PATCH v2 9/9] t7061: expect ignored files in untracked dirs
References: <20170505104611.17845-1-sxlijin@gmail.com>
        <20170503032932.16043-1-sxlijin@gmail.com>
        <20170505104611.17845-10-sxlijin@gmail.com>
Date:   Mon, 08 May 2017 15:35:27 +0900
In-Reply-To: <20170505104611.17845-10-sxlijin@gmail.com> (Samuel Lijin's
        message of "Fri, 5 May 2017 05:46:11 -0500")
Message-ID: <xmqqy3u77t5c.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Samuel Lijin <sxlijin@gmail.com> writes:

> We now expect `status --ignored` to list ignored files even if they are
> in an untracked directory.
>
> Signed-off-by: Samuel Lijin <sxlijin@gmail.com>
> ---
>  t/t7061-wtstatus-ignore.sh | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/t/t7061-wtstatus-ignore.sh b/t/t7061-wtstatus-ignore.sh
> index dc3be92a2..fc6013ba3 100755
> --- a/t/t7061-wtstatus-ignore.sh
> +++ b/t/t7061-wtstatus-ignore.sh
> @@ -9,9 +9,10 @@ cat >expected <<\EOF
>  ?? actual
>  ?? expected
>  ?? untracked/
> +!! untracked/ignored
>  EOF

In my comment on an earlier step (2/9, I think), I said it is
unclear if the change in behaviour to "status --ignored" is a new
bug you are introducing, or is a fix that happens as a side-effect.

I may be misunderstanding what the test that uses this expected
output is trying to see, but to me, it seems that:

        --ignored::
                Show ignored files as well.

is clear enough that "status --ignored", regardless of the
"--unracked" settings, should show the ignored file even when the
directory it happens to be in does not have any file that is
registerd in the index, and the expected output updated by this
patch looks to me the one that we _should_ be expecting.  IOW, the
change in behaviour looks like a bugfix to me.  And if that is
indeed the case, the above change should be in the earlier patch
that flips "expect_success" to "expect_failure".  The "expected"
file is prepared to expect the "correct" output before the code is
updated to produce one (i.e. the test update declares that the
current behaviour is broken), and then with changes in a later step
(i.e. somewhere before 7/9) the code starts to produce the "correct"
output at which point in that same patch you flip expect_failure into
expect_success.

The log message of eb8c5b87 ("git-status: Test --ignored behavior",
2012-12-30) says otherwise, though.  I am undecided, if I agree with
the design decision described by the first two bullet points:

    commit eb8c5b872ef144add4ac89f85bcddc974ac7114d
    Author: Antoine Pelisse <apelisse@gmail.com>
    Date:   Sun Dec 30 15:39:01 2012 +0100

        git-status: Test --ignored behavior

        Test all possible use-cases of git-status "--ignored" with the
        "--untracked-files" option with values "normal" and "all":

         - An untracked directory is listed as untracked if it has a mix of
           untracked and ignored files in it.  With -uall, ignored/untracked
           files are listed as ignored/untracked.

         - An untracked directory with only ignored files is listed as
           ignored.  With -uall, all files in the directory are listed.

         - An ignored directory is listed as ignored. With -uall, all files
           in the directory are listed as ignored.

         - An ignored and committed directory is listed as ignored if it has
           untracked files.  With -uall, all untracked files in the
           directory are listed as ignored.

        Signed-off-by: Antoine Pelisse <apelisse@gmail.com>
        Signed-off-by: Junio C Hamano <gitster@pobox.com>

     t/t7061-wtstatus-ignore.sh | 146 +++++++++++++++++++++++++++++++++++++++++++++
     1 file changed, 146 insertions(+)

What do others think?

By the way, I wonder what the performance impact of this change
would be.  Do we end up needing to scan more parts of the
filesystem, when we already know that a directory does not have any
tracked paths?

> -test_expect_failure 'status untracked directory with --ignored' '
> +test_expect_success 'status untracked directory with --ignored' '
>  	echo "ignored" >.gitignore &&
>  	mkdir untracked &&
>  	: >untracked/ignored &&
> @@ -20,7 +21,7 @@ test_expect_failure 'status untracked directory with --ignored' '
>  	test_cmp expected actual
>  '
>  
> -test_expect_failure 'same with gitignore starting with BOM' '
> +test_expect_success 'same with gitignore starting with BOM' '
>  	printf "\357\273\277ignored\n" >.gitignore &&
>  	mkdir -p untracked &&
>  	: >untracked/ignored &&
