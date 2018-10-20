Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2AFA31F453
	for <e@80x24.org>; Sat, 20 Oct 2018 14:32:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727423AbeJTWmz (ORCPT <rfc822;e@80x24.org>);
        Sat, 20 Oct 2018 18:42:55 -0400
Received: from mail-wm1-f53.google.com ([209.85.128.53]:52904 "EHLO
        mail-wm1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727404AbeJTWmy (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Oct 2018 18:42:54 -0400
Received: by mail-wm1-f53.google.com with SMTP id 189-v6so6160769wmw.2
        for <git@vger.kernel.org>; Sat, 20 Oct 2018 07:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ahYRhr3pOrAT8QWYRGuWI2NFGCobfc0+1PeLenvH+4I=;
        b=JcfGDKM7Yo7qnW0tphXbCdPohDPbkp93Fy+e+S9h/GyTrTXdgMALUnBrTzTBfIpJva
         M9qJvTR4oK4DlMeqcDarcqf6BrC4k4nQyQBPlOX+MZHhNKdGT4QHaaKvjgYTQbWtQHLD
         +uNHdzV2SCDBFCYuJAk2nbhjsCTfjx957bs0mUjmJ/FzmF8ZdH0+1HVLVC6oXA5Gyljz
         zvmj/HTjA3OzHHKws02I8pvVmJgCtiMPw9BSqP55y4sTHlSZ7u9uyPBZKRZyP0pCgx61
         U+odpd+G+5TVs7grCVdeL2XnTa0srQ5Q5yVu8tsljYqEWRQ0UcRyk1GiUB1YAb3ZnzP0
         0WTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=ahYRhr3pOrAT8QWYRGuWI2NFGCobfc0+1PeLenvH+4I=;
        b=hX3W25mFUWEyMRieEscsKBeZYA7q0LTpljNtRsiGJzz/jct07DGXciJk3Ha9m1QOKN
         Kz8ysA6bnniRFRmNuccZPLoyfdPS7+OX71GbCclkx3sKQGqE3/ZWSuWoYn46w20z1Fly
         eOU7xaN6tWyNe0RRdaFrl5niQ+7aPcO4h54IKgTwNGTIS8MvJgEP/AD0/ilip0ALABS9
         MLN3D2ebi4u0DwlAOW/reUMyXhrTIHI8sjHF8xlEovM8HWtI7guA3mt3VbpJusB3ySFI
         SRu29ku33k4ytS8SGkmThuq9zYEhyxIvgVHbrQI8VH5UBkBkg3V5kjGlsl4R2/ZV7Yh4
         l6wQ==
X-Gm-Message-State: ABuFfojwZQZmks+FpeL4VKb/qJ/VbxOBSfOeva8VQNgXR1FWgAqYEdVQ
        AzBX6mru0Hbc0Rczw1/3iLXeBKt4
X-Google-Smtp-Source: ACcGV63lUG5KDp6eZXhRMEoMdPsDl9qryz9W3NPNrmR8qMa0wtacguW1NdiYAvlEI/lQ+mK4b7ECpA==
X-Received: by 2002:a1c:7c07:: with SMTP id x7-v6mr8942622wmc.32.1540045931102;
        Sat, 20 Oct 2018 07:32:11 -0700 (PDT)
Received: from [192.168.0.104] (atoulouse-658-1-59-23.w92-136.abo.wanadoo.fr. [92.136.154.23])
        by smtp.gmail.com with ESMTPSA id 134-v6sm4519819wmb.13.2018.10.20.07.32.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 20 Oct 2018 07:32:10 -0700 (PDT)
Subject: Re: What's cooking in git.git (Oct 2018, #04; Fri, 19)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Pratik Karki <predatoramigo@gmail.com>, git@vger.kernel.org
References: <xmqq8t2u1nkh.fsf@gitster-ct.c.googlers.com>
 <20181019124625.GB30222@szeder.dev>
 <6e4fdcdd-6c50-a07e-74b7-1fcd15c33444@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=alban.gruin@gmail.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <5f0fb76f-0774-3545-38fc-b86137f747fa@gmail.com>
Date:   Sat, 20 Oct 2018 16:31:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <6e4fdcdd-6c50-a07e-74b7-1fcd15c33444@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr-FR
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Le 19/10/2018 à 20:05, Alban Gruin a écrit :
> Le 19/10/2018 à 14:46, SZEDER Gábor a écrit :
>> On Fri, Oct 19, 2018 at 03:02:22PM +0900, Junio C Hamano wrote:
>>> Two large set of topics on "rebase in C" and "rebase -i in C" are
>>> now in 'next'.
>>
>> I see occasional failures in 't5520-pull.sh':
>>
>> […]
>>
>> When running t5520 in a loop, it tends to fail between 10-40
>> iterations, even when the machine is not under heavy load.
>>
>> It appears that these failures started with commit 5541bd5b8f (rebase:
>> default to using the builtin rebase, 2018-08-08), i.e. tip of
>> 'pk/rebase-in-c-6-final', but it's a "flip the big switch" commit, so
>> not very useful...
>>

The bug can be bisected by prepending the command chain of 5520.25 with
`git config --bool rebase.usebuiltin true &&`.  Commit 7debdaa4ad
(“builtin rebase: support `--autostash` option”) is the culprit, but
some commits that cause this test to fail with a different error (ie.
“TODO”…) must be marked as good.

The error comes from the call to `git stash apply $stash_id' in
builtin/rebase.c:261.  When $stash_id only contains decimals and no
letters, git-stash tries to apply stash@{$stash_id}[0][1].  Thas was not
a real problem with the shell script, because it did not abbreviate the
object id of the stashed commit, so it was very unlikely that the oid
would contain only digits.  builtin/rebase.c shortens the oid[2], making
this problem more likely to occur.

We could add a switch to git-stash to tell it that the parameter is an
oid, not anything else.

[0] https://github.com/git/git/blob/master/git-stash.sh#L514-L520
[1] https://github.com/git/git/blob/pu/builtin/stash.c#L167-L168
[2] https://github.com/git/git/blob/next/builtin/rebase.c#L1373

Cheers,
Alban

