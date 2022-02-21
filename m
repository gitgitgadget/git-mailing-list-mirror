Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C375C433F5
	for <git@archiver.kernel.org>; Mon, 21 Feb 2022 18:54:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232547AbiBUSy6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Feb 2022 13:54:58 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232535AbiBUSyw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Feb 2022 13:54:52 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5D8A111
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 10:54:27 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id h15so14307065edv.7
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 10:54:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=tE3bHo//Uvm3Po2Kz3fr2Jv947IvdGYuf93lQdeTL3A=;
        b=d72slJk3wHyDd5Uz1PIAS2gf/h7XOSjkVi6Dh3Dai08O4Le0O53OEf36vJsbYhfP6b
         UdxY32V941yomsOMFWvb2JdkngsBzKeLQc2EOFPjD+2CoH3b65kIPmnPbtw4kS7bkn+k
         k6cjDz7tBSYXnG5ZHWx3letZlyfxnpwHuht7sL0T0FrXmhla27Kj7oY6noFZBfLVV/Yh
         qdWNwNMpQIXx8FfqlcB+aJ5lQmhhW7ZYPCWX0TLyl41n6VD/50HIqWKNmxWfDnYlCoN2
         Q17mwgbEOO6Xqr6ywGLa7q1O+NrTD7+5rGxUpEUjZtjj81hEMrAqIPgd2YUBjGM0DQsh
         n70g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=tE3bHo//Uvm3Po2Kz3fr2Jv947IvdGYuf93lQdeTL3A=;
        b=JU5TqXvO86Jn6i4yOoe9M9jp1GSfmsGcjHy6WuD15+zwn//SUZvcQFq6Eff1fJbbZ3
         wrRl3J3CzJHhDHwBfyMawLO5LBAfG+S6lM46pI9GIYLrnYGH3ACmKUuBt7mJmfKhX6Mx
         ohkB/CPwjqXxADS4nQ6Vk/65t9wpEDYusLMHL3C7H8FoeqGKzpQjrFRT8umz5Me3e7A7
         fQIeZVObApvPZ5RFHiBg9vZ1OSICPN7KzVbf2pdbDwiok8ctCmyzZD7GT33ljeF1RaAP
         NxD1W2RuXSJAqwntpHa1lQ8En9N4K0F1o8a7DRAwOLSg55Ub8lurFv0xx8CaMf4I7sLe
         vCPw==
X-Gm-Message-State: AOAM532PpjnStJNHoky3pgVzzfDMOHunvCj1HB3BSg2z+M8WrOSD0TOS
        vRbkV7kraoCioAeZhNz0nf/oxDamsuITXg==
X-Google-Smtp-Source: ABdhPJyIcU/OTn9D8GVCe7wTBw2fWtyqyl8z4WFG8OLrVoqadc7B93frFynd3vLZjaqwwMPm1va8Cw==
X-Received: by 2002:a50:ba8e:0:b0:410:a99c:4c3b with SMTP id x14-20020a50ba8e000000b00410a99c4c3bmr23427825ede.427.1645469666123;
        Mon, 21 Feb 2022 10:54:26 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id 5sm5437056eji.192.2022.02.21.10.54.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Feb 2022 10:54:25 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nMDpI-005koZ-E4;
        Mon, 21 Feb 2022 19:54:24 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Cc:     git <git@vger.kernel.org>
Subject: Re: [PATCH] add usage-strings ci check and amend remaining usage
 strings
Date:   Mon, 21 Feb 2022 19:52:26 +0100
References: <220221.86tucsb4oy.gmgdl@evledraar.gmail.com>
 <20220221173357.8622-1-chakrabortyabhradeep79@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <20220221173357.8622-1-chakrabortyabhradeep79@gmail.com>
Message-ID: <220221.86h78saw4f.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Feb 21 2022, Abhradeep Chakraborty wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> wrote:
>
>> Sorry about leaving this patch submission hanging. I read this at the
>> time, but forgot to find time to loop back to it.
>
> No worries. Thanks for reviewing :)
>
>> But in this case there's really a much easier way to do this, to just
>> extend something like this:
>> ...
>> See b6c2a0d45d4 (parse-options: make sure argh string does not have SP
>> or _, 2014-03-23) for the existing code shown in the context where we
>> already check "argh" like that, i.e. we're just missing a test for
>> "help".
>>
>> Obviously such a function would need to hardcode some of the logic you
>> added in your shellscript. E.g. this fires on a string ending in "...",
>> but yours doesn't.
>
> Thank you so much for the suggestion. Didn't aware of it before. I will
> try to implement the logic in parse-options.c` (as you suggested).
>
>> That should be fairly easy to do though, and if not we could always just
>> dump these to stderr or something if a
>> git_env_bool("GIT_TEST_PARSE_OPTIONS_DUMP_FIELD_HELP", 0) was true, and
>> do the testing itself in t0012-help.sh.
>
> Okay but if the logic can't be implented in the `parse-options.c` file
> (most probably I will be able to implement the logic), would you allow me
> to try the `coccinelle script` method you mentioned?

In this case I think there's definitely no reason for why it can't/won't
work in parse-options.c.

If you're doing something like that with coccicheck I'm afraid I can't
help much, I've only seen that the kernel is doing it (it's referenced
in some of the coccinelle docs), but I haven't personally used it for
anything close to that.

