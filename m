Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 568B3211B4
	for <e@80x24.org>; Fri, 11 Jan 2019 18:00:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732021AbfAKSAv (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Jan 2019 13:00:51 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44315 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729853AbfAKSAv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Jan 2019 13:00:51 -0500
Received: by mail-wr1-f67.google.com with SMTP id z5so16106699wrt.11
        for <git@vger.kernel.org>; Fri, 11 Jan 2019 10:00:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=/cI8JP+jfGOTH+hC4oBcceNgJzo2Ed4l2rDRxQyioAI=;
        b=hX+GhPSatTqR5wOTXxnprue2/6nojL+ap/vPrDFE+Vhgch2n9jEoOMhRu3NTIfxi1J
         Aq+Cq3KeqLsF8FvzbtU+I7VJm1GKY66H7hgcdirngclVCSSYF8/zI6mjvdwvkPcYwN1T
         TofZVxCJE9pEtgMlN1bs43s0rX1sGsLwITftBDATk+gWgPFfx1kcQ0DLRBzzTBqtt5rG
         RkcGLiDnCfuTq1dVqkbK83SL6Npqv6vsZFBJ3sI8q8mKDr/fYE8Vseatmxmsp6fPKhQl
         7p3QyQ8abTgOItA7+BGQXqbbYMp/4e3zCcSysaQrwUrnjGi7aCz1cJaR9jVJI66b+fS9
         Q3ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=/cI8JP+jfGOTH+hC4oBcceNgJzo2Ed4l2rDRxQyioAI=;
        b=rRU/VCRYcgJOcsvK8XfOJs2kth2w1Ia66x5iegrfiAAgDtLgfgmL6uK7os9YWTAoFD
         9NatFRu9zGwjc74KVeptuZ+lPFwByGcVy62C+NTiInsino6bbBSkb2PqU5+HJPA7rvZG
         FxD1FOdc6xtd7F+6078skWtjY/GW7g+GhrnWf9WBi49gTH1YrzPCnL1uR8Aj8SEvJGEm
         flOUrXWVBpLjPTxnqydy2E4D/ZLFm5LdXhx7nz07lveA8DBr1D3VDItT46bjHMTCq6FJ
         Uk3RO6OSlba/p3fETJ2W/PDOekHXmDaAs13NHRV0NaCI0ZgbQqmyp+tWfNQk+d8GmRJd
         fu0A==
X-Gm-Message-State: AJcUukfesWa39ghSdjAm2qJpCU/pC+g4ikkaHntxsiUWIgxqKtp8c8vc
        fbGRV2J1eTetJBQdRVGJkvQ=
X-Google-Smtp-Source: ALg8bN4V7ZHbLEdyjvFb+42eBdwRNAAjYjPAGyWUc6awhLL1oEIljwc68kqWW5ovpXf5cc5AaTujAw==
X-Received: by 2002:adf:9361:: with SMTP id 88mr14038081wro.204.1547229648904;
        Fri, 11 Jan 2019 10:00:48 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id l6sm63457809wrv.70.2019.01.11.10.00.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 11 Jan 2019 10:00:47 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jiang Xin <worldhello.net@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Sun Chao <sunchao9@huawei.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v5 1/5] t5323: test cases for git-pack-redundant
References: <20190109164731.GJ4673@szeder.dev>
        <20190110120142.22271-2-worldhello.net@gmail.com>
        <xmqqimyw1am8.fsf@gitster-ct.c.googlers.com>
        <CANYiYbFxCYSt0yQtt5xsFSshVCDuVU58hWBA6AF2e+QzmdUViQ@mail.gmail.com>
Date:   Fri, 11 Jan 2019 10:00:47 -0800
In-Reply-To: <CANYiYbFxCYSt0yQtt5xsFSshVCDuVU58hWBA6AF2e+QzmdUViQ@mail.gmail.com>
        (Jiang Xin's message of "Fri, 11 Jan 2019 09:59:22 +0800")
Message-ID: <xmqq8szrysz4.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jiang Xin <worldhello.net@gmail.com> writes:

> Junio C Hamano <gitster@pobox.com> 于2019年1月11日周五 上午5:11写道：
>>
>> Jiang Xin <worldhello.net@gmail.com> writes:
>>
>> > From: Jiang Xin <zhiyou.jx@alibaba-inc.com>
>> > +create_commits()
>> > +{
>>
>> Style (see Documentation/CodingGuidelines).
>
> OK, parenthese after function name.
>>
>> > +create_pack_1()
>> > +{
>> > +     P1=$(cd .git/objects/pack; printf "$T\n$A\n$B\n$C\n$D\n$E\n$F\n$R\n" | git pack-objects pack 2>/dev/null) &&
>>
>> Yikes.  Can't "git pack-objects" get the input directly without
>> overlong printf, something along the lines of...
>>
>>         P1=$(git -C .git/objects/pack pack-objects pack <<-EOF
>>                 $A
>>                 $B
>>                 $C
>>                 ...
>>                 $R
>>                 EOF
>>         )
>
> Find that no space before <OID>,  because git-pack-objects not allow that,
> and mached parentheses should in the same line.
> So Will write like this:
>
>     create_pack_1() {
>             P1=$(git -C .git/objects/pack pack-objects pack <<-EOF) &&
>     $T

Isn't the whole point of <<-EOF (notice the leading dash) to allow
us to indent the here-doc with horizontal tab?

