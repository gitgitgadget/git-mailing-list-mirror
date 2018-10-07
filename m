Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	PI_IMPORTANCE_HIGH,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1C5E51F97E
	for <e@80x24.org>; Sun,  7 Oct 2018 01:10:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726264AbeJGIN5 (ORCPT <rfc822;e@80x24.org>);
        Sun, 7 Oct 2018 04:13:57 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36541 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725873AbeJGIN4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Oct 2018 04:13:56 -0400
Received: by mail-wr1-f65.google.com with SMTP id y16so17086047wrw.3
        for <git@vger.kernel.org>; Sat, 06 Oct 2018 18:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:importance:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=F3JOSNJ5+Zpnx2maEu5sp//B9hDf9nDupD9bVCVLDCk=;
        b=H+t+CzjowfEv+c2VQGmnf95BPOpb8b8xCtynuXHFdZBQahLNaWNm2cTWMP7yCSrcvs
         mnqMRqmNNjtm4jMask+dSAsHNrwuS+c/dEuKAP6h0YjFpkAyfHrgFFxjHqBwjePmSHAY
         SZIqxQktlOtP2MgBw7/HTiL+2bf4PR98JfOUGqF7bMliT5Hn8JPUv5+cioYYKAB++JAB
         Ve6ZoSkH29lRXWOO7SbkJaa0rTIdYjcZQYUk7aygesNNE0zh0Vya7Ij4yeLgX3fOn1gJ
         pBQjFOfaRvgtLonLTav+yQ5HEVwRKQ9GL8d+HzHKWz9JY7btMgHcqCt2AojDmjEMy5Ug
         mxBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:importance
         :date:in-reply-to:message-id:user-agent:mime-version;
        bh=F3JOSNJ5+Zpnx2maEu5sp//B9hDf9nDupD9bVCVLDCk=;
        b=Jhabut8QC4kw3oYhOnMy4HGbj06GOiyt6U+b178uzoCdmM7Ay/iomRPSFgmnD+i03S
         ZORpfIq2hAMFAHd2j2h1iSzR8ntfQe8WdQMWG561v5VvotVEUIBDKro1CgBTeHYYf7EU
         kk/4epm5vvjXDvcT2GPaSVybBvTg2Rl7RjGI1jYjFiQSUk6xpxuroqJY5Wirz/FFHlF5
         3DGuuLzhopw8ndFFfZb+mZtbXGTMUNIxeESgDd4tq7uxFr+hZL9ouQZ0XlDYnTLoykhN
         DM4TOeox0ydN2UxUOP/+mKYlrUofXP49gQX6MJRQOAZFM+e5cK9sTZ0BBSH053q4UKGf
         uPtQ==
X-Gm-Message-State: ABuFfoiIl4XNFgY8B9rpnYodd+k/HWuXS1YlGtVeMlYv1Dl7PqJvMito
        wI4rvB2z8M0KhEnVrfe0nqpHOgrGrPU=
X-Google-Smtp-Source: ACcGV60CEmHBqeCmHGBVC9D3v1ziC8szocVHAQjiLHXzLixOY1+8cyLYF/7hEqw8ifd8+oGj2dqiLA==
X-Received: by 2002:adf:a3d0:: with SMTP id m16-v6mr12526355wrb.312.1538874511519;
        Sat, 06 Oct 2018 18:08:31 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id 63-v6sm6667002wmj.39.2018.10.06.18.08.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 06 Oct 2018 18:08:30 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Steve <steve@lonetwin.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] git-completion.bash: Add completion for stash list
References: <ef5e9e8da180a5ead70b53d767a8ed4a0666e598.camel@lonetwin.net>
Importance: high
Date:   Sun, 07 Oct 2018 10:08:29 +0900
In-Reply-To: <ef5e9e8da180a5ead70b53d767a8ed4a0666e598.camel@lonetwin.net>
        (Steve's message of "Thu, 27 Sep 2018 20:59:00 +0100")
Message-ID: <xmqq36tiva0i.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Steve <steve@lonetwin.net> writes:

> Since stash list accepts git-log options, add the following useful
> options that make sense in the context of the `git stash list` command:
>
>   --name-status --oneline --patch-with-stat
>
> Signed-off-by: Steven Fernandez <steve@lonetwin.net>
> ---
>
> This is my first patch to the project so please be excuse any process
> errors.
> Although, I've tried my best to follow the guidelines in
> Documentation/SubmittingPatches but I'm not sure if I missed anything.

Thanks.  Will queue with manual fix-ups, but since you asked, here
are the things I'll be fixing up manually, which you may want to
avoid next time.

 (1) We strongly prefer to see contributor's identity recorded as
     the "author" of a commit to match the sign-off from the
     contributor.  Your MSA sent your message with only the more
     casual version of your first name on the "From: " header, which
     does not match your sign-off.  It would have been more correct
     if you added two lines at the beginning of the body of the
     message, i.e. before "Since stash list accepts...".  The first
     line would be

	From: Steven Fernandez <steve@lonetwin.net>

     and then you would have a blank line immediately after that.
     Your "Since stash list accepts..." would become the third line
     of the body.  That will tell the receiving end that the author
     identity of the resulting commit should not be "Steve" but
     should be "Steven Fernandez".

 (2) "git shortlog --no-merges" would show that we tend not to
     capitalize the first word after "<area>:" on the subject line.

 (3) Your patch is line-wrapped (see below that has with-stat on its
     own line after the line you intended it to go).

 (4) You somehow generated your patch with "-p0".  It is OK to do
     whatever for your own use, but patch submission is 
     communication with others, so don't be original by doing
     unusual things.

None of the above is something I cannot fix on the receiving end
myself, but at the same time, it is not something people should be
wasting maintainer's time on, and small wastes add up.

>  contrib/completion/git-completion.bash | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git contrib/completion/git-completion.bash
> contrib/completion/git-completion.bash
> index d63d2dffd..06ec6ca11 100644
> --- contrib/completion/git-completion.bash
> +++ contrib/completion/git-completion.bash
> @@ -2567,6 +2567,9 @@ _git_stash ()
>  		drop,--*)
>  			__gitcomp "--quiet"
>  			;;
> +		list,--*)
> +			__gitcomp "--name-status --oneline --patch-
> with-stat"
> +			;;
>  		show,--*|branch,--*)
>  			;;
>  		branch,*)
