Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 899681F404
	for <e@80x24.org>; Tue, 30 Jan 2018 20:41:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752036AbeA3Ulc (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Jan 2018 15:41:32 -0500
Received: from mail-wr0-f195.google.com ([209.85.128.195]:45880 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753592AbeA3Ulb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Jan 2018 15:41:31 -0500
Received: by mail-wr0-f195.google.com with SMTP id 16so12619911wry.12
        for <git@vger.kernel.org>; Tue, 30 Jan 2018 12:41:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=jAHugJY/HZPKDD1BjFMZNFIJf8RFo7Zh6d+xNfbZJs0=;
        b=VpK39vl0Jx8oCalb0HwZua8EyQsmQ/gr1moCyvPuk8stV1b7P/zr8QI7VYcLvpw8sT
         m8H6ngx6JQVnftHyK8SHRfnG+XHoOcS9N2wx/waY3d5JKlCai7u8/xiXiP7ojYKStRX5
         a3CEJuE83KhrgFFzEebdklM3VO0neS310qYECf5X6h/+xtIowI3YQuhriPWs6n3vHx8z
         Vxl7+q/7wBX4AmvDLoVt5SIAuVotco+kcsKVT45tr5DQl+zWY6bB97uAAnIou8kiU2hO
         4YVC/MuPq+kgZJ3LpRzleW1iHNbbOtlx7/PX/Zw34bverc2xKlr0DH7oPExAiZ9TDyH2
         sMZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=jAHugJY/HZPKDD1BjFMZNFIJf8RFo7Zh6d+xNfbZJs0=;
        b=QN2OyiNUHsh4Q7sEQ2eZcVW1t08ncu5qG5i7Kt04EpsttqcHA0m1cR9pChkuJN/P8Z
         Y8Vr3VNoyfMDCDBxdIvSWfnQtosnkkZh1rNHiMkx37UVK2yN0cHGS6VqcyGM30xQCMyQ
         6qbGlpd+8Ynj6E+AreNcHKOMWaIJB8SXC+2DyrTMWHelTyAK9WQfAK1DneMcgyQsHQ8u
         zN6P9gx7Cor3qBpn+Mc1fDaPvPrT0Ox/18eFxS5m/URG3iPnNAHbQLKcl4p3v50k1KwT
         D39W2SRD2/cd69AcOqmT5kXveoIe0FowP3hTfeRriMOZR+Myx5PY4rI5hxK7bJcGgRWF
         OdlA==
X-Gm-Message-State: AKwxytfh9euDc/Woa5WJ93vFHWZwapzRsILc/SvQGEaU0Zsjg31meqFA
        uDLuBNsL2Lj/l+rU4jk9ZrE=
X-Google-Smtp-Source: AH8x227g1119coy5POoO9DCJ5Yf7IFJcod9lr8u8E4hNuezhSZHVyPxO6VdaJTV91g1rFi6VMrPCBw==
X-Received: by 10.223.148.165 with SMTP id 34mr10802277wrr.52.1517344889860;
        Tue, 30 Jan 2018 12:41:29 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id s13sm10547498wrf.11.2018.01.30.12.41.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 30 Jan 2018 12:41:29 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Philip Oakley <philipoakley@iee.org>,
        'Michal =?utf-8?Q?Such=C3=A1nek?= =?utf-8?Q?'?= 
        <msuchanek@suse.de>, git@vger.kernel.org,
        "'brian m. carlson'" <sandals@crustytoothpaste.net>
Subject: Re: git send-email sets date
References: <20180126183230.0ae0c76b@kitsune.suse.cz>
        <20180128151536.GE431130@genre.crustytoothpaste.net>
        <001601d39850$a0a48ae0$e1eda0a0$@iee.org>
        <20180128221231.GB13621@thunk.org>
Date:   Tue, 30 Jan 2018 12:41:28 -0800
In-Reply-To: <20180128221231.GB13621@thunk.org> (Theodore Ts'o's message of
        "Sun, 28 Jan 2018 17:12:31 -0500")
Message-ID: <xmqqk1vzt6yv.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Theodore Ts'o <tytso@mit.edu> writes:

> If there is a From: header in the beginning of the mail body, it is
> used as the Author instead of the From: header in the mail header.  It
> would make sense if there is a Date: header in the beginning of the
> mail body, it should be used instead of Date: field in the mail header.

Just like From:, Date: and Subject: are in-body headers that are
accepted by deployed versions of "git am" (actually, "mailinfo").

