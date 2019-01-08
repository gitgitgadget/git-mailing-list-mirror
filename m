Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7A58B1F803
	for <e@80x24.org>; Tue,  8 Jan 2019 17:39:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728945AbfAHRjx (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Jan 2019 12:39:53 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53457 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727484AbfAHRjx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Jan 2019 12:39:53 -0500
Received: by mail-wm1-f67.google.com with SMTP id d15so4960715wmb.3
        for <git@vger.kernel.org>; Tue, 08 Jan 2019 09:39:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=qYhFhkXwu0lJb7K87ZaP0Z34bQdGypD4YQUJBKl8Kjk=;
        b=YJDUJaMEMulHp00mWgY4XMaaAGHP2NIqTut8iEJRQ5qTXE/m8dcXgJLwMwDCFUa7TB
         izmtN0VOK9A5fTJSikkyuoS/mZbj/MHVwdT2aP/2lSy3CMsFDaQh+FWMbpM588BmAXwO
         i4uk0H4bjdGPp+lXB8TjCA2+van2lynXIMy1WsDYvtcn5ftZMgL2YwCzFY+uXq3S1Khn
         AiZ9rItexXtk/EbFtFAbjdfxgBG6IBcABEeEsuH1TSn+j6cIW1iavgRhuHrikwgRR3W0
         /5w0Mkhjj27gXRC30CyxmAUAkloc1owQcajLa5D9WSP4IpqpYvuOIJnMAEJ/VVotKcTZ
         tSZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=qYhFhkXwu0lJb7K87ZaP0Z34bQdGypD4YQUJBKl8Kjk=;
        b=C8JSmH50oAMIQtYtTeat9TV73vlA2exDDUXaLyhwnDZAAkwh2u2a9vi4dLcAl2iJgB
         oMS9ef1Dg8nCDdh8VZWjQat2VKhRgQ56sqJqETuBA8I5oX6RsbEXO/d7ZZ1olSpuJCiz
         hVfpZXnG2rRaX4u8XYVmWKMY1O9+FY90SuPaGsuGebJo0wrYELqca3UZE8B2U+F/EGsf
         dLEqcESuhh8KjfMMKOMcekJldTI/PL1wkRB60lYkrCkz0fllC7X2REJ+rty8BOb9gk1v
         oupRCF4WHWaAlVKtUOJ0b9G9RM0crHfnF3hk+BKE2wGAzPc3eEvH8FR3ucB8CDhorkXM
         NmaA==
X-Gm-Message-State: AJcUukcMaThX17Ppj2vf5vGWcE4Jiz0WXFfa62/uBNwp2Wbv+BRYncSU
        yThY7ZO1ODoMPPUcofkW8Jg=
X-Google-Smtp-Source: ALg8bN54/ZBq9zK5jVECM4tY+grxQuLJle/EbMiJqa2EEAEndErc8pU5uNOJpQPaBvmPP9zApS2nOA==
X-Received: by 2002:a1c:e913:: with SMTP id q19mr2562861wmc.55.1546969189941;
        Tue, 08 Jan 2019 09:39:49 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id f66sm10998786wmd.28.2019.01.08.09.39.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 08 Jan 2019 09:39:49 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIg?= =?utf-8?B?QXJuZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>
Subject: Re: [PATCH 0/11] jk/loose-object-cache sha1/object_id fixups
References: <xmqqh8explya.fsf@gitster-ct.c.googlers.com>
        <3512c798-aa42-6fba-ee82-d33a8985be91@web.de>
        <20190107083150.GC21362@sigill.intra.peff.net>
        <b0049722-d019-fd5d-d93d-7b7363b4f244@web.de>
Date:   Tue, 08 Jan 2019 09:39:48 -0800
In-Reply-To: <b0049722-d019-fd5d-d93d-7b7363b4f244@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Tue, 8 Jan 2019 17:40:06 +0100")
Message-ID: <xmqqy37v59qz.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

René Scharfe <l.s.r@web.de> writes:

> Am 07.01.2019 um 09:31 schrieb Jeff King:
>> I also cleaned up my sha1/object_id patch and rebased it on top of what
>> you have here. Though as I worked on it, it expanded in scope a bit.
>> Possibly it should be a separate series entirely, but that would create
>> some annoying textual conflicts on merge.
>> 
>>   [01/11]: sha1-file: fix outdated sha1 comment references
>>   [02/11]: update comment references to sha1_object_info()
>>   [03/11]: http: use struct object_id instead of bare sha1
>>   [04/11]: sha1-file: modernize loose object file functions
>>   [05/11]: sha1-file: modernize loose header/stream functions
>>   [06/11]: sha1-file: convert pass-through functions to object_id
>>   [07/11]: convert has_sha1_file() callers to has_object_file()
>>   [08/11]: sha1-file: drop has_sha1_file()
>>   [09/11]: sha1-file: prefer "loose object file" to "sha1 file" in messages
>>   [10/11]: sha1-file: avoid "sha1 file" for generic use in messages
>>   [11/11]: prefer "hash mismatch" to "sha1 mismatch"
>
> I skimmed them; they look good to me.  6 and 8 are particularly
> satisfying; getting rid of hash copy operations just feels nice. :)
>
> Junio only took 1 to 5 into pu; 6, 7 and its sidekick 8, 10 and 11
> conflict with sb/more-repo-in-api; 9 could go in unmodified.

I think these later steps are based on something a lot newer than
the result of applying your updates to the jk/loose-object-cache
series they fix.  I think I untangled and backported one of the
earlier commits but then I stopped after 05/11.

I do not think it is important to keep jk/loose-object-cache and
these two follow-up topics mergeable to the maintenance track, so
I'll see if the patches behave better if queued directly on top of
3b2f8a02 ("Merge branch 'jk/loose-object-cache'", 2019-01-04), or
even a yet newer random point on 'master'.

Thanks.


