Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E22661F404
	for <e@80x24.org>; Mon, 12 Feb 2018 21:48:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932321AbeBLVsd (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Feb 2018 16:48:33 -0500
Received: from mail-wr0-f175.google.com ([209.85.128.175]:34161 "EHLO
        mail-wr0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932109AbeBLVsc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Feb 2018 16:48:32 -0500
Received: by mail-wr0-f175.google.com with SMTP id m5so4637121wrg.1
        for <git@vger.kernel.org>; Mon, 12 Feb 2018 13:48:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=UGMpsVE8Xg2DMp81nNo4Dv18q1p5dUDSDYtwftxy/D4=;
        b=oEdAZywkusveCkFZEDP70ZFH01qL7wUQx5uL42S1Agh5L1zEVOR1YPQGG8SeE+BDkd
         eOllg8HCGaTElpuPZ2tOdgEynvInEss8/fINPpn3TNsZBxpYm47PRBZklmHvFChE9MFq
         4V9KoGL59HLookh8oNGFQoxAR6Lj0fBLbaaXhOKujbbCCuvSzQ4UZNOyzh4wFwjRzLf0
         7l7qWYOYkt30Q2tYkbwt0nGseV2QPl2hUEztchJIeurxYR6Am00Bxx2Z+/Ijq2Phks8g
         o4M0HvPatUYQIHXgEypl8ST+vsAi826XbJxG1EXcnAW5J4ubPK/vpmqO5SKl/hc8U8/X
         Obzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=UGMpsVE8Xg2DMp81nNo4Dv18q1p5dUDSDYtwftxy/D4=;
        b=S06TTSaitFnvZx8XTH41/mh0fVqEqjt/YHb3b0wRCt6pgzOQ8Ci4B2JcjAS+PaEd45
         WRSyWeGiBcUCKJg08CzfAZvoKONhuYjBp0MtRvWiQHa/AUJT5B0B0MGugHD8oW18D+qN
         Kz9Mwr00pqBMl+JxFlRk28pv3k6rbbIpOKIwM9+p+qs3DMmgo7nnekLT8E7qMsPOYA2b
         QQh/PgUj96yEdl4S7eHB9dCwmIOK4eM9WrC7Web0tT9U5cLFHU7rCKN1N0CNeVRpwHQI
         sz6y7B3YKsZT6s1MqRT43ozQGIL677wV2SjMRpSG+MAb8Zl4jSShgGhxMZVQvohLIgVN
         Qmew==
X-Gm-Message-State: APf1xPBO0BN61/Ija21G8Ylqeo11w0IfaLKGoJN0zQbfT66XBJHMAizI
        Mh1Wex7oKG3L1kOBLvNwpoM=
X-Google-Smtp-Source: AH8x2255HvECiRBFCsjoGt3i/RBu0e/Isz8aEOJQhi7RKHr2rL+Ukfs9/QUqsuQIq7IC5foJy4/8Ow==
X-Received: by 10.223.197.13 with SMTP id q13mr10305462wrf.235.1518472111203;
        Mon, 12 Feb 2018 13:48:31 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id d5sm10319354wra.72.2018.02.12.13.48.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 12 Feb 2018 13:48:30 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Stefan Beller <sbeller@google.com>, git <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 003/194] object-store: move packed_git and packed_git_mru to object store
References: <20180205235508.216277-1-sbeller@google.com>
        <20180205235508.216277-4-sbeller@google.com>
        <xmqqsha9vmqt.fsf@gitster-ct.c.googlers.com>
        <CAGZ79kacD5Bevw==v3fbyWmz0FiDDM5ypkYuxHxbXJM62FX40w@mail.gmail.com>
        <xmqqsha5sywh.fsf@gitster-ct.c.googlers.com>
        <212094a6-f1bd-c4cd-01f9-e819a701cfac@web.de>
Date:   Mon, 12 Feb 2018 13:48:29 -0800
In-Reply-To: <212094a6-f1bd-c4cd-01f9-e819a701cfac@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Mon, 12 Feb 2018 22:40:20 +0100")
Message-ID: <xmqqbmgtswuq.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

René Scharfe <l.s.r@web.de> writes:

> Am 12.02.2018 um 22:04 schrieb Junio C Hamano:
>> Stefan Beller <sbeller@google.com> writes:
>> 
>>> I thought it may be a helpful
>>> for merging this series with the rest of the evolved code base which
>>> may make use of one of the converted functions. So instead of fixing
>>> that new instance manually, cocinelle could do that instead.
>> 
>> Having the .cocci used for the conversion *somewhere* would indeed
>> be helpful, as it allows me to (1) try reproducing this patch by
>> somebody else using the file and following the steps in order to
>> audit this patch and (2) catch new places that need to be migrated
>> in in-flight topics.
>> 
>> But placing it in contrib/coccinelle/ has other side effects.
>
> Running "make coccicheck" takes longer.  What other downsides are
> there?

Once the global variable packed_git has been migrated out of
existence, no new code that relies on it would be referring to that
global variable.  If coccicheck finds something, the suggested rewrite 
would be turning an unrelated packed_git (which may not even be the
right type) to a reference to a field in a global variable, that
would certainly be wrong.
