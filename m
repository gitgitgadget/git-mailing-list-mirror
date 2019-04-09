Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C92FB20248
	for <e@80x24.org>; Tue,  9 Apr 2019 11:33:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726921AbfDILdN (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Apr 2019 07:33:13 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53043 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726463AbfDILdN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Apr 2019 07:33:13 -0400
Received: by mail-wm1-f66.google.com with SMTP id a184so3081758wma.2
        for <git@vger.kernel.org>; Tue, 09 Apr 2019 04:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:message-id:user-agent
         :mime-version;
        bh=d97qaxIXqPNBLnx6TYELoeTq9ZGmsgQ9yQVMjj/fwJc=;
        b=uTRFWvFMG8B9iZijarH7LSpYKnMld7vYe3TCr1a87yR62nMTDVCrap1INwRkbFWZ9n
         Ol1Qainix4SbOQSjw9BoivYF6sJJw1xLS7QplzD/+g10vXoJXR9Pl2eFMs1zD10tUJV8
         p4EckzPE8iNN1N7ImxpiJYLm3C77vaa7WUu4jomqslszvqRCEJEJrjBUcDZj6tSnQT9d
         MsmDH9YAxgHQ0FhKzi/k6dK099upMf75bgXWeG7w4CbRj8bxlMjNhc54PWhyozSPozHP
         VozJJlnTicExh5xyUFvVKzj3j5fua/1iNIanaMM/nBFchtGyUm/ViIrFnoAG1gW/U/cx
         uc7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :message-id:user-agent:mime-version;
        bh=d97qaxIXqPNBLnx6TYELoeTq9ZGmsgQ9yQVMjj/fwJc=;
        b=tBZ3sdmigp9UmDj7qrM7U6bYW5YdRT72QwkqhTU8R4t7K6c5s5V3ossmaC2RNvCK80
         vshTCa8kTPvvhNx57ZQKvmB09UHP0uqPrszhkvvhOKG6wX+5GMr7zwuOq/phuMP7Fr3H
         e424Qm9kODdEJvdNndOQ/p/7J3Uxa2F+RXz+L22F/uTCNc20dJluBNqCgXSG/W9clvqM
         7jtFW/053TXTqddFDcyEXq8wF8FXi7ywTuJHcdSNA8KO1cHvbbaeltzeQ0XQHMMJE+X5
         3/Zga4/gsMAAVDPn1AO9zGPmAk5SJrAHNSXwxJKENq4vKNTic+/RccLJOm1YpDaDqtJt
         8jXQ==
X-Gm-Message-State: APjAAAUN522XM70e9gCc9z16di7z0tVbU21tD6v+68JhcwdNYEYKKbuL
        GmEJHVxBiIWQP2VSqObrUpM=
X-Google-Smtp-Source: APXvYqzxxDmDHmlGOrQIURgA6tvL+2gBtkkMUG2u76jYxcaocVvoSWq0BG1H4iykRPWJgdvd8nHsDA==
X-Received: by 2002:a1c:2394:: with SMTP id j142mr22135496wmj.111.1554809591498;
        Tue, 09 Apr 2019 04:33:11 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id g132sm12231039wme.3.2019.04.09.04.33.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 09 Apr 2019 04:33:10 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 1/1] t3301: fix false negative
References: <pull.176.git.gitgitgadget@gmail.com>
        <a01a8c704ba03213aa59c59384dba46502089522.1554806481.git.gitgitgadget@gmail.com>
Date:   Tue, 09 Apr 2019 20:33:10 +0900
Message-ID: <xmqq4l775s7d.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> In 6956f858f6 (notes: implement helpers needed for note copying during
> rewrite, 2010-03-12), we introduced a test case that verifies that the
> config setting `notes.rewriteRef` can be overridden via the environment
> variable `GIT_NOTES_REWRITE_REF`.
>
> Back when it was introduced, it relied on a side effect of an earlier
> test case that configured `core.noteRef` to point to `refs/notes/other`.
>
> In 908a320363 (t3301: modernize style, 2014-11-12), this side effect was
> removed.
>
> The test case *still* passed, but for the wrong reason: we no longer
> overrode the rewrite ref, but there simply was nothing to rewrite
> anymore, as the overridden notes ref was "modernized" away.

Wow.  Thanks for digging thru this

> Let's let that test case pass for the correct reason again.
>
> To make sure of that, let's change the idea of the original test case:
> it configured `notes.rewriteRef` to point to the actual notes ref,
> forced that to be ignored and then verified that the notes were *not*
> rewritten.
>
> By turning that idea upside down (configure the `notes.rewriteRef` to
> another notes ref, override it via the environment variable to force the
> notes to be copied, and then verify that the notes *were* rewritten), we
> make it much harder for that test case to pass for the wrong reason.

Yup.  I agree that testing positive side, expressing what we want to
happen in a more explicit manner, is always a better alternative.

Will queue.  Thanks.

> index 84bbf88cf9..704bbc6541 100755
> --- a/t/t3301-notes.sh
> +++ b/t/t3301-notes.sh
> @@ -1120,9 +1120,10 @@ test_expect_success 'GIT_NOTES_REWRITE_REF overrides config' '
>  	test_config notes.rewriteMode overwrite &&
>  	test_config notes.rewriteRef refs/notes/other &&
>  	echo $(git rev-parse HEAD^) $(git rev-parse HEAD) |
> -	GIT_NOTES_REWRITE_REF= git notes copy --for-rewrite=foo &&
> +	GIT_NOTES_REWRITE_REF=refs/notes/commits \
> +		git notes copy --for-rewrite=foo &&
>  	git log -1 >actual &&
> -	test_cmp expect actual
> +	grep "replacement note 3" actual
>  '
>  
>  test_expect_success 'git notes copy diagnoses too many or too few parameters' '
