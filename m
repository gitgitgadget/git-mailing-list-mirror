Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 341DB1F404
	for <e@80x24.org>; Mon,  5 Mar 2018 19:14:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932538AbeCETOA (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Mar 2018 14:14:00 -0500
Received: from mail-wr0-f169.google.com ([209.85.128.169]:37875 "EHLO
        mail-wr0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932182AbeCETN5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Mar 2018 14:13:57 -0500
Received: by mail-wr0-f169.google.com with SMTP id z12so18463891wrg.4
        for <git@vger.kernel.org>; Mon, 05 Mar 2018 11:13:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=ROMFnTpoaPoJY0eH9Vd4KGHoAr7HBwcFUvIG1wRALeI=;
        b=CTNETmGN9YjsivwItFgnwQjIRa84KvT3L39QkccGwPL33OmJiJ9ywQut8DUFNISdfw
         f/tcsR1d38okOE6BkiKy6hAq8PA68/PhA9sd8JwKDNg3LnmUbW3HBFJ6MCkv3V+dEzvy
         cj3vDc19yQngiMUuEkNahRhiajmryyzp8qxOPxa6YdfQhUAGz+XNSAq5lDqH6y5h8cyI
         76FmtY+KJfrfWSPnKtFb9HfLfl7DmapdR/TEv6fN+iu5uSMAP3n/d3MgImlTtmVb/z6z
         bNiNw/k3GKg7XM3t6hOsnKUPF4dQULkUOXEU6EvJ4r6reoacY77JS/C3opf2JKPMbj8+
         ht7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=ROMFnTpoaPoJY0eH9Vd4KGHoAr7HBwcFUvIG1wRALeI=;
        b=DqHFp2B0aZKoAxb9lLU+GtS/su9J699ITJMJ9gPmxbsRgs7308ryE8/N9UAbdHwrSS
         D2c1JzNuyFW164To6f2XO5fBOUX4qm5I9o8XVQ4Eonqm5fTC/X2V/4pxBlXZnuCaGXrb
         ackd8Y4KPqjfmHlgP+bR4k6V+2yW2SSrLx4atVitkCi18dDZtHp5fcYHl69XMnq3MOn3
         qnCwohjpP4G7A80CTcXaiUsfW5a/7DcSVkKUacRqn5tXe+n0+MLdEaDmTadONFlZGf97
         elhLfmIXqhb7GuYajuH4vD9bmVicMqZ8SrAWvibYBAt8fMiJYElbmzwqacuExnSZc+X0
         f7Bw==
X-Gm-Message-State: APf1xPDUqFNQHVvUPJcm8f/x8b3UtEyQQgdKUMSmSECnhA9WSHwSTqf4
        FPs2soWn+jRRoZNClKLzz9M=
X-Google-Smtp-Source: AG47ELvqFEfLkhfjyzOmw+bU+9bTQl035/Wn6aO6no9PHegupw4WiNgaWjfw0XMLRPHlzdH32DmsBA==
X-Received: by 10.223.133.214 with SMTP id 22mr14260074wru.130.1520277236120;
        Mon, 05 Mar 2018 11:13:56 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id w74sm13589785wmd.1.2018.03.05.11.13.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Mar 2018 11:13:55 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 00/44] reroll nd/remove-ignore-env.. sb/object-store and sb/packfiles..
References: <CACsJy8DWrNzZM1K2vkx2XiETdAR5WhwXEdPijsxd0ZD4Lj=tZw@mail.gmail.com>
        <20180303113637.26518-1-pclouds@gmail.com>
Date:   Mon, 05 Mar 2018 11:13:55 -0800
In-Reply-To: <20180303113637.26518-1-pclouds@gmail.com> (=?utf-8?B?Ik5n?=
 =?utf-8?B?dXnhu4VuIFRow6FpIE5n4buNYw==?=
        Duy"'s message of "Sat, 3 Mar 2018 18:35:53 +0700")
Message-ID: <xmqq371e9vyk.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguyễn Thái Ngọc Duy  <pclouds@gmail.com> writes:

> 01/44 - 05/44: nd/remove-ignore-env-field
>
>   This series is moved up top. After this the patch that touch
>   alternate-db in sha1_file.c looks natural because no env is involved
>   anymore

Yes, I do like having this upfront and being able to merge it before
having to wait for the rest of the huge pile.

>   I also take this opportunity to introduce a new patch 01/44 to avoid
>   struct initialization that makes it hard to read and update. Later
>   patches are also simplified thanks to this.
>
> 06/44 - 32/44: sb/object-store
>
>   06/44 is updated to introduce raw_object_store_init() instead of
>   RAW_OBJECT_STORE_INIT macro. This function is now used to initialize
>   both main repo and submodule ones.
>
>   10/44 (moving "packed_git") also introduces two new access wrapper
>   get_packed_git() and get_packed_git_mru()

I haven't studied individual patches in this round for these, but
the interdiff you show below looks quite sensible.

Thanks, will take a bit deeper look at the rest.
