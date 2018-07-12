Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 966211F85E
	for <e@80x24.org>; Thu, 12 Jul 2018 18:35:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726506AbeGLSqe (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Jul 2018 14:46:34 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:53925 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726351AbeGLSqe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jul 2018 14:46:34 -0400
Received: by mail-wm0-f67.google.com with SMTP id b188-v6so6566549wme.3
        for <git@vger.kernel.org>; Thu, 12 Jul 2018 11:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=XNsulFwBMNx6wf/xsE/MESQf38ZkAxszR5Pw51NrhVc=;
        b=gM93vR3aH+DYovNjfKwGtCVwrvKbAF7q4JKb9nh3JWkdz/NI+oCmun//xtQEu0rycF
         YhunTJKi2CW4qafEiYVpLhr1ozXX1FLZPCKlWF1vz2acEIzpomskb9tIVLDzXbK/hBu/
         7bndiTVEY1jfg9ZVKKqJDhxbzFboxtjT63efOQk5/VYHd4S9Wdl0K3NJjw7eIHO4i6tT
         +hv4rqy7NWZHPUnWFOdPM7+XNSpXnecI6x4XAyxfD0aKSr7RCFnHu3m0KTmprOLFHEDY
         fmuIUbODoAiMVlCh+y2/z6CNWZd7wRu+MwaOg3EEN9DmTVFiXZtv7xBNwqsdvBBu3N9C
         DNQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=XNsulFwBMNx6wf/xsE/MESQf38ZkAxszR5Pw51NrhVc=;
        b=OSF5fluap37GZ7rMWjh2ZApXUnY5G9/rX8FsFVK2noPCn0I7apJozf1LylLRtXMeCy
         EP5/dRNq/UyDoTvgbewqXvqUMdYy+e+OaxbERoWhDFb09rh+9IDrUX7DcXSXs0OopXvw
         VyW8f5cBYwNtcvbkfWl483IRw+74HtPVHgIp+rdOCz+7yiHMfs30u+b7gG/GJGvrC4tq
         RUcYVjBDD+iehXEmxJR4TzJ7FqlAGblvN5l6ZJn2EaUt+e2qCqbqyEQbJN87do+OD5V1
         SsKaLwNRCwgSYEgBQKmzCzy2b3hOIY2JyMvA3rMv28za5o/DRCWJvdLxFENCXFQ1OEix
         U1WQ==
X-Gm-Message-State: AOUpUlEDzs4LpGsg1Jq8xUZ7iVifQ/x3FTROjLr2SECOH7V3j8siSaRw
        sD0jyBBR8BZRUidSBkvf1jE=
X-Google-Smtp-Source: AAOMgpfQBXjKFgGbF+xMz2s3FcQ03+WROb884QmTYNA1YCFgtf+zKo2EA0O+hWCDbkG90mhuZ2o2xg==
X-Received: by 2002:a1c:8a0f:: with SMTP id m15-v6mr2091693wmd.33.1531420545937;
        Thu, 12 Jul 2018 11:35:45 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id t140-v6sm8415334wmd.14.2018.07.12.11.35.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 12 Jul 2018 11:35:45 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Git List <git@vger.kernel.org>,
        Elijah Newren <newren@gmail.com>, Johannes Sixt <j6t@kdbg.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Stefan Beller <sbeller@google.com>,
        Luke Diamand <luke@diamand.org>, Jeff King <peff@peff.net>
Subject: Re: [PATCH 21/25] t5000-t5999: fix broken &&-chains
References: <20180702002405.3042-1-sunshine@sunshineco.com>
        <20180702002405.3042-22-sunshine@sunshineco.com>
        <20180712123729.17861-1-szeder.dev@gmail.com>
        <CAPig+cRYNo_KL02LN1LOa79Zm2oYZqbnBHJ=KDA3oaF4pVfjcA@mail.gmail.com>
        <xmqqd0vsxq47.fsf@gitster-ct.c.googlers.com>
Date:   Thu, 12 Jul 2018 11:35:44 -0700
In-Reply-To: <xmqqd0vsxq47.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Thu, 12 Jul 2018 11:31:36 -0700")
Message-ID: <xmqq8t6gxpxb.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Eric Sunshine <sunshine@sunshineco.com> writes:
>
>> On Thu, Jul 12, 2018 at 8:37 AM SZEDER Gábor <szeder.dev@gmail.com> wrote:
>>> The change below should be squashed into this patch to fix a
>>> previously unnoticed broken &&-chain.  I think you missed it, because
>>> this test script is rather expensive and you didn't run it with
>>> GIT_TEST_CLONE_2GB=YesPlease.
>>>
>>> diff --git a/t/t5608-clone-2gb.sh b/t/t5608-clone-2gb.sh
>>> @@ -23,7 +23,7 @@ test_expect_success CLONE_2GB 'setup' '
>>> -               echo "M 100644 :$i $i" >> commit
>>> +               echo "M 100644 :$i $i" >> commit &&
>>
>> Thanks for finding this. I tried to get as much coverage as possible
>> by installing packages I don't normally have installed (Apache, cvs,
>> cvsps, Subversion, Perforce, etc.) and even temporarily modified a
>> script or two to force it run ...
>
> Thanks, both.  I think the &&-chain fix series is already large and
> also otherwise seem to be pretty solid, so let's not reroll but
> queue this addition on top.

Oops, sent before completing the message.

	For that to happen, we need a sign-off ;-)

I guess this one would have been caught with the "sed script on
subshell" linter that does not execute?

-- >8 --
Subject: t5608: fix broken &&-chain

This is inside a loop that is run inside a subshell, in a test that
is protected with CLONE_2GB prerequisite, one or more which is quite
likely reason why it wasn't caught durin the previous clean-up.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t5608-clone-2gb.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t5608-clone-2gb.sh b/t/t5608-clone-2gb.sh
index df822d9a3e..2c6bc07344 100755
--- a/t/t5608-clone-2gb.sh
+++ b/t/t5608-clone-2gb.sh
@@ -23,7 +23,7 @@ test_expect_success CLONE_2GB 'setup' '
 		printf "blob\nmark :$i\ndata $blobsize\n" &&
 		#test-tool genrandom $i $blobsize &&
 		printf "%-${blobsize}s" $i &&
-		echo "M 100644 :$i $i" >> commit
+		echo "M 100644 :$i $i" >> commit &&
 		i=$(($i+1)) ||
 		echo $? > exit-status
 	 done &&
