Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 22C7E1F597
	for <e@80x24.org>; Tue, 31 Jul 2018 16:54:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731785AbeGaSfS (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Jul 2018 14:35:18 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33832 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728321AbeGaSfS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Jul 2018 14:35:18 -0400
Received: by mail-wm0-f67.google.com with SMTP id l2-v6so11572268wme.1
        for <git@vger.kernel.org>; Tue, 31 Jul 2018 09:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=xirF9SYcE5C8Ve7xMk5HynqmPx8v56XEi4NUDP4VwBk=;
        b=Z4DLG+eJnEvfCtuqHmhIIszMiviOBt1muqDeQQbkiLX7Ft+RBPviMV7/o9YTJmDLhJ
         OgYOUF9yp/aMovS5ERSWF+Emf+njdsERdFyhTxWOjf08BPBHX5oxR0B/qOuFI1Zrp2me
         rPWbr0Mx/SFsBoWWgJ15uMtPCfAKLfe52V1llbhxvFucpmwoZN+SSvWPKUTLp1hlAKy3
         OlTBXYCgZR5428Brj0JKG7jV/Bt5BAa+WVpGRmCtIlg9pgiAH2hlsypsKhvaEBliWz7i
         wbY8DZnyhSrZp3bja0sZAMbyHXcqlKQRWJcUVLf4QFVOh1sK1D8bGM8B8z5B6Bud/pif
         QYWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=xirF9SYcE5C8Ve7xMk5HynqmPx8v56XEi4NUDP4VwBk=;
        b=aUk6mrX73ku5qOE5QQG2AuIp+KU133Vm/Fsg35U+4kFSuG3uxZ53A3wq3rTqxBQzSn
         Uy0nazeK4IPGNnCnFBr5My3pl7yDB/Y6gfRjyhI9mqE6tbDp7wLGzsP9bk4NK0+z3pSe
         y2PoYoCavTb1G01M1v9A/pulnJBpXau556VnSPUu3z8ANb/M6ObDnJNaizwJUMDa86t4
         8n7JgZZMAloCxIqj1ISeYi2p6kZOHAg7ujwySJ2GVLet9lYxbuwQS+aNUaUQTyrs3wgJ
         ZtEP/oNwyweWJ42hJd21UZUUK97Oam9dqOWF4rXqVWoRBHJPuJBwjfB7fVaTISN6EL6l
         He3w==
X-Gm-Message-State: AOUpUlFI0djBZocu0nNM2G1LMHG3XkF3RhqoFQ40cWeiUHBj0neYvtp0
        vcchuItk9AF2VBqm5xfAulq9f7D5
X-Google-Smtp-Source: AAOMgpdI4PO0EiBgTTOsuClov1oHHAQ1hJaDFvasX0gC6gwmGVK8BPWFnTPEDLIePg0y70PFQ8L2sA==
X-Received: by 2002:a1c:9e4d:: with SMTP id h74-v6mr355180wme.70.1533056045998;
        Tue, 31 Jul 2018 09:54:05 -0700 (PDT)
Received: from Laptop-Acer-Aspire-F15 (egs127.neoplus.adsl.tpnet.pl. [83.21.82.127])
        by smtp.gmail.com with ESMTPSA id y128-v6sm3892931wmy.26.2018.07.31.09.54.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 31 Jul 2018 09:54:04 -0700 (PDT)
From:   Jakub Narebski <jnareb@gmail.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Derrick Stolee <dstolee@microsoft.com>, git <git@vger.kernel.org>
Subject: Re: [PATCH] DO-NOT-MERGE: write and read commit-graph always
References: <pull.11.git.gitgitgadget@gmail.com>
        <20180718152244.45513-1-dstolee@microsoft.com>
        <86y3ds6b40.fsf@gmail.com>
        <CAGZ79kbAocJU2oqVCr9Dzhy2Qi-iESYGU6z2LbtFF89obaBgqw@mail.gmail.com>
Date:   Tue, 31 Jul 2018 18:54:02 +0200
In-Reply-To: <CAGZ79kbAocJU2oqVCr9Dzhy2Qi-iESYGU6z2LbtFF89obaBgqw@mail.gmail.com>
        (Stefan Beller's message of "Mon, 30 Jul 2018 10:06:25 -0700")
Message-ID: <86muu7pcr9.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

>> I wonder though if all those changes to the testsuite shouldn't be
>> merged.
>
> I think Stolee doesn't want this to be merged after rereading
> subject and the commit message.

Yes, I understand that, and for the most part I agree with it.  This
commit main purpose is to thoroughly exercise the new feature.

But I think that changes to the testsuite could have been extracted into
separate commit, and merged (and only those changes).  It could serve as
note about the intent of the test.  Well, perhaps after encapsulating it
in some function with a good name... ;-)

Anyway, this is a minor insignificant thing.
--=20
Jakub Nar=C4=99bski
