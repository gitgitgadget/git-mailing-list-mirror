Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9D6EF1F461
	for <e@80x24.org>; Fri, 21 Jun 2019 19:33:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726010AbfFUTdF (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Jun 2019 15:33:05 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:46450 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbfFUTdF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Jun 2019 15:33:05 -0400
Received: by mail-ed1-f66.google.com with SMTP id d4so11523967edr.13
        for <git@vger.kernel.org>; Fri, 21 Jun 2019 12:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=CdjRtaeHIcS2ZRykLN/iSsufZ8ZULoXD/jIWN9yf5ao=;
        b=LzMuZ0eV9sEAL8/os0JZgTf26uIwXewWbhqTKuyYwXCaVDzcAWVKMzM2VVFnQVmsxb
         cpcDOqXfCGn25zAVb7aw6XD48yiPEYeNGoj5RoAcK1QPF1pRqD617G75vKkSFhU96Lqh
         VPggdgFSd0Ktw/Z4VYH3he19Mp5QOnSJfKTzebmeMnnW4+TIqaILJK6vyE31z0fd+PFP
         NSvQ42H8+AhZCBDgUedUy9TdY2kxqJLw3//0bAM3U4fkYUSz6XvOBQ7kUDv1jfIw7iIk
         PBrRdP0w6Hd9JvWYsgCwv/tSHv7eh0GLmYCB9T+HW4tgtQofMGYETgFr30O8nLd6ViVY
         +PAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=CdjRtaeHIcS2ZRykLN/iSsufZ8ZULoXD/jIWN9yf5ao=;
        b=swpVHopTViwk1Tq+CFDpdQ4sgf3C3QpFY+z3UblbUPVdPCPrClK+i3UsGKHx/hsNNi
         OqXWOWxd6W6+n8lTx5En6h4PJyfg7M40oQocxp8RELIYM6fGC2q/UDXjHIicf0S51QwN
         U9aHqxvql2SW2beLcVnvnfE6JNb/mwtfKp19b6vJQHf9xanzRFLmZXYks1kLLA6xgD81
         1ddOWZEBoRT5oaWqM9gYRbLZVeSk+59wvkrRHhr/fCjq9VnRT65DV/scNazO2BIJ3Vfu
         NfvPdm7rXR6iG8ymwS9eY15hloAtTAnHKI9hXEiwg1sG6TTrWRZTkR5N0VBuhCE3mZbN
         TitQ==
X-Gm-Message-State: APjAAAWBGhE4V/R5J6x1bu+ufsQNKSSstQ/2lNtn6pxyuzUUtAGsQIxs
        CjFpLkhbR+hJNS7eVc9vWiw=
X-Google-Smtp-Source: APXvYqyP+592ARdUPt6M10pL8A2LP8E1MdbZXZynO7hLZczyxcrRRQC5bkRBSTr+eFR6ZTOdg2u1Mg==
X-Received: by 2002:a17:906:a39a:: with SMTP id k26mr93184861ejz.82.1561145583814;
        Fri, 21 Jun 2019 12:33:03 -0700 (PDT)
Received: from evledraar (i237193.upc-i.chello.nl. [62.195.237.193])
        by smtp.gmail.com with ESMTPSA id v32sm1104874edm.92.2019.06.21.12.33.02
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 21 Jun 2019 12:33:03 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 1/1] t0001: fix on case-insensitive filesystems
References: <pull.151.git.gitgitgadget@gmail.com> <1dd56d034efb6ff251bdac8d099052175f4777a0.1560005022.git.gitgitgadget@gmail.com> <20190609201302.GX8616@genre.crustytoothpaste.net>
User-agent: Debian GNU/Linux 10 (buster); Emacs 26.1; mu4e 1.1.0
In-reply-to: <20190609201302.GX8616@genre.crustytoothpaste.net>
Date:   Fri, 21 Jun 2019 21:33:02 +0200
Message-ID: <878stu91jl.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Jun 09 2019, brian m. carlson wrote:

> On 2019-06-08 at 14:43:43, Johannes Schindelin via GitGitGadget wrote:
>> diff --git a/t/t0001-init.sh b/t/t0001-init.sh
>> index 42a263cada..f54a69e2d9 100755
>> --- a/t/t0001-init.sh
>> +++ b/t/t0001-init.sh
>> @@ -307,10 +307,20 @@ test_expect_success 'init prefers command line to =
GIT_DIR' '
>>  	test_path_is_missing otherdir/refs
>>  '
>>
>> +downcase_on_case_insensitive_fs () {
>> +	test false =3D "$(git config --get core.filemode)" || return 0
>> +	for f
>
> TIL that =E2=80=9Cfor f=E2=80=9D is equivalent to =E2=80=9Cfor f in "$@"=
=E2=80=9D. Thanks for teaching
> me something new.

See also test_have_prereq in test-lib-functions.sh where this trick is
combined with IFS to loop over a "param,like,this" split by ",".
