Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DCF8820248
	for <e@80x24.org>; Mon, 18 Mar 2019 06:06:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbfCRGGQ (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Mar 2019 02:06:16 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:50483 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725967AbfCRGGQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Mar 2019 02:06:16 -0400
Received: by mail-wm1-f65.google.com with SMTP id z11so3156340wmi.0
        for <git@vger.kernel.org>; Sun, 17 Mar 2019 23:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=SqWHpRSDfItiE5pPrbJesr2nsEiXs2UI/gdErxBBuSo=;
        b=Cit0ReLtjDEHL4HZ/mLRQLTu3z6MGUehzBF3V8f3+u0JV2/At+xY0rLd+Gth8V99Sr
         W9kKcHTDebu331/aH+/aE6ZRmJGhuBhVu2ztyyym9Rc1KL6qT7iZMbrXzAloFfzBbR7u
         0+9xmrrix3WU4J1Q4PZ1YIdJ3MKvQo/3ekq+o+wD4nGvcBO6S2ffTwNR+me9Ry0tJokd
         PeCQVBRLOzKWilwABSFnB19ykMAZLrwDUQWgMG1RYXNHCAyZdZwTBSF0tASMnwJYnsVI
         gKgX5Wofl+nv3/4X2/VcL9RyXhss6gyhaHxKeONnqJadq2HJ8xKxOgDo0XydNwOdCJlS
         EMeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=SqWHpRSDfItiE5pPrbJesr2nsEiXs2UI/gdErxBBuSo=;
        b=d9vSE7KgMw4i1unZdjj5xuzh4V2rr84ubbIa5SIFBEFYS7/zNiqkMDagvjafKzyXzP
         +0BB5Wx0pfeTeWZEyy/aHgOFPNM+03xOvmfBK2ggZKO2B9SC2aWIcrS4XwenTT8AOHQ3
         EPQ5C8ByaB1JWsLFV/+J+QiLakESnzGYXjw3aAKWAaXeUaOisdObXndfcVMmvxbFrlMS
         xezWs+Zn99otq+smHERo65xjaaIthjrEgWdgZQO4owNQb9P7FlVCDwY1VogGst+lZEzX
         uT33UsWhp+x5ERHubT8wPvz++0LagXsMDVc5VcVnIKrQvqeuEE3lkqxyQkGU4QfKDk7k
         dPBA==
X-Gm-Message-State: APjAAAVfngb0FInVC4nHGWTWdgbG7r43WW/Jjw7m2F+7UHnslYtfZDUj
        EKEF+wdUwDAs+aWddnp9nxk=
X-Google-Smtp-Source: APXvYqx3O3SP7bNk1IRKtSCtHj/O8BMZbCd4GkULDOnOzGf+9dnBIA4XYq+zdQE9I9RfmvSAPtGW9w==
X-Received: by 2002:a1c:7906:: with SMTP id l6mr9545999wme.83.1552889174519;
        Sun, 17 Mar 2019 23:06:14 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id 16sm34328807wrb.19.2019.03.17.23.06.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 17 Mar 2019 23:06:13 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org, Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v3] rebase: remove the rebase.useBuiltin setting
References: <87ef79bho5.fsf@evledraar.gmail.com>
        <20190315134548.24479-1-avarab@gmail.com>
        <nycvar.QRO.7.76.6.1903151643300.41@tvgsbejvaqbjf.bet>
        <87wol09kxv.fsf@evledraar.gmail.com>
Date:   Mon, 18 Mar 2019 15:06:13 +0900
In-Reply-To: <87wol09kxv.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Fri, 15 Mar 2019 17:11:40 +0100")
Message-ID: <xmqqwokw3eei.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> Urgh, Junio: If there's no other comments/concerns on v3 requiring a v4
> this has my:
>
>     Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>

Alright.  Let's queue, wait for a while to see if there is anything
else and continue.

Thanks.
