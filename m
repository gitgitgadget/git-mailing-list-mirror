Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C166520248
	for <e@80x24.org>; Fri, 12 Apr 2019 01:51:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbfDLBvv (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Apr 2019 21:51:51 -0400
Received: from mail-wm1-f49.google.com ([209.85.128.49]:33797 "EHLO
        mail-wm1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726661AbfDLBvv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Apr 2019 21:51:51 -0400
Received: by mail-wm1-f49.google.com with SMTP id r186so3177434wmf.1
        for <git@vger.kernel.org>; Thu, 11 Apr 2019 18:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=KhwiUb4hrIhuHCVecSeMl+nkjMntuu1oYjafnFRb9ZM=;
        b=UK/dMWP9/70RsZ6ELaoh4gjHmxnREDYbAEdJeva/A3/+Fs6Fg4iLr1RE5fnxNB7jFC
         z48R47Jc9krZGDuajchv3mDGuhank8V1hbBcGSxjELUSOeApY2IErJOMbs0kEoqYKQV+
         lQIbep+Z1RDcacsgJLZF0vtyUE5kykjSvif2VPzO74pVOuSdSDEYQJi3vr4HtnY5f3qE
         MyYQ7GLrfGugwZcAnLfmBOM5BZ89CtwF/ZvMb9L53YtxAfSKeNx+u8u48+Ma171WhN4X
         HJumhOYl/cd2ovQm59T0HDHWvh49nM8Yj405K1IUcNBVrYR/W9KCQZDv5UKVtHAUi842
         8KKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=KhwiUb4hrIhuHCVecSeMl+nkjMntuu1oYjafnFRb9ZM=;
        b=rhQPXCeslmuW01krHis/0zzo4q9LWl60AmouDyiDaZrRrcbcbmINpWVqR4crgHu1+x
         5bBNmxZFrsQcHLrdjv68zRWd7g6m8xBzh6zUF6uYt2jP9KffE77Jzf0duKMdgl2KG9Iz
         EdyKLhiI6g9AySEK1N6SZA9eKshGOOgMF5zmsMxBzMD9KkcltpuIquAIUCircdhxn9a4
         i/zTs363mK4m30AR6AYJ/tuvqgCq/+y9srL3vC7lnWmWHrE8VWvEsfV78fG2PnssPwHX
         BrOGf61pe/sbbbKu6stt6ayIAiNQxVwrlupQiURZ4FCdU8ShwaXAhtNCHcLKwDbQqSgm
         tHtQ==
X-Gm-Message-State: APjAAAUBYYslyjKK59NimkvVbeJvrJI1caop0RBBDqWYO6XXtoRa8W6u
        UVw2IfpYkUvwMVA+kIiaOJU=
X-Google-Smtp-Source: APXvYqzfL2dH+UgC0B8za3O3HtvnyG1zHwMLCV25MJadr1au4vVt/Te3lawyC0+g5mPNjhzrB14lyQ==
X-Received: by 2002:a1c:6c17:: with SMTP id h23mr9452091wmc.122.1555033909465;
        Thu, 11 Apr 2019 18:51:49 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id r30sm128087037wrr.46.2019.04.11.18.51.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 11 Apr 2019 18:51:48 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: dl/warn-tagging-a-tag, was Re: What's cooking in git.git (Apr 2019, #02; Wed, 10)
References: <xmqqr2ab2gs6.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1904102354510.41@tvgsbejvaqbjf.bet>
Date:   Fri, 12 Apr 2019 10:51:48 +0900
In-Reply-To: <nycvar.QRO.7.76.6.1904102354510.41@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Wed, 10 Apr 2019 23:56:47 +0200 (DST)")
Message-ID: <xmqq36mo0z4b.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> For me, this does not work without this squashed in:
>
> -- snipsnap --
> diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
> index 33a1d70b434d..7767cb1fab64 100755
> --- a/t/t7004-tag.sh
> +++ b/t/t7004-tag.sh
> @@ -1688,7 +1688,7 @@ test_expect_success '--points-at finds annotated tags of tags' '
>  '
>
>  test_expect_success 'recursive tagging should give advice' '
> -	sed -e 's/|$//' <<-EOF >expect &&
> +	sed -e "s/|$//" <<-EOF >expect &&

Ah, that's quite an obvious fix.  We should look out for sq inside
the body of the test.

Will squash in.

Thanks.
