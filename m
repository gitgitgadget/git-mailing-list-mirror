Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6584E201A4
	for <e@80x24.org>; Mon, 15 May 2017 01:29:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751637AbdEOB3E (ORCPT <rfc822;e@80x24.org>);
        Sun, 14 May 2017 21:29:04 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:36334 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751005AbdEOB3C (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 May 2017 21:29:02 -0400
Received: by mail-pf0-f193.google.com with SMTP id n23so12709186pfb.3
        for <git@vger.kernel.org>; Sun, 14 May 2017 18:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=nY4PuDzpEac6QltGYMV4XpEu3/J7RAiqW+qdYX1LBSc=;
        b=vI41cPALVDz3E6AX+BNqun92I2kONzZHX2pYZj/mjJARqE2vNcxMgZUkM+xj4b2j9A
         gjvV8eclpgQAQcsEAwQgN1OKobPgXAY1HDnj0UmqEZYY8bz0Qlpc0XPWRZw0rrrCv4tF
         0ZKqkC+36YJZmfeT+2Fu1/RNP0cJUN/8nPWch8DPFhbl6ZEnr5f4HDHZHcTUOlK2gHeh
         N3G6IqzO63Qpbcqe3xlDNFobcGtHju73i+0rG+jOPdR7f4aCR//oWZjCPBRdUV6RHGJw
         dn3/rosbI5ZawVxrNHsugCPPFwBegmxyHxWGDQywOO+ZK3iWpJ5mIEu3GlzaUMwt2pUW
         e4fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=nY4PuDzpEac6QltGYMV4XpEu3/J7RAiqW+qdYX1LBSc=;
        b=IoVAk5fKPThS0mH5AhurB3V9sP+GUN3jDskKV+s1ejjBaOWwAcxyZ0H1kC3ChaO5uJ
         HwFThQNR8CiBzlINtDcSQTl56R9seegwB4IHTGGsM0vXYTi3IAoQvO38MzZFhC7lFiSu
         ODIgxdGSVJfP/8kRogxVEdmFXFBPVwk1wcuWyRCVx6SJHpALt+KByAgZWV+u9WTbrvQ2
         wOkjrwRBBTcjkC/H3oRCCQvkkA12CYnbi7lBRKdGhqGvM3DIYLC+r/Pm59wVXLNq5fYi
         Es1ux36OVALORnf0r/+qAYlZj4Gc/j8x1WuXL9AewTX9LklblpuqXnBcwb5Z0PblzCuS
         YkQQ==
X-Gm-Message-State: AODbwcBkpo/xHTFl7uBCoQ67PrL0jpyRMMf+yEHbRgnTRr043xl+xvHa
        o/7dlgXZAv23G71ECt8=
X-Received: by 10.99.109.141 with SMTP id i135mr3608187pgc.33.1494811742266;
        Sun, 14 May 2017 18:29:02 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:b170:f9ed:5f25:7ab5])
        by smtp.gmail.com with ESMTPSA id e16sm16738719pfk.100.2017.05.14.18.29.01
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sun, 14 May 2017 18:29:01 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Jeffrey Walton <noloader@gmail.com>,
        =?utf-8?Q?Micha=C5=82?= Kiedrowicz <michal.kiedrowicz@gmail.com>,
        J Smith <dark.panda@gmail.com>,
        Victor Leschuk <vleschuk@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Fredrik Kuivinen <frekui@gmail.com>,
        Brandon Williams <bmwill@google.com>
Subject: Re: [PATCH 11/29] grep: add a test helper function for less verbose -f \0 tests
References: <20170511091829.5634-1-avarab@gmail.com>
        <20170511091829.5634-12-avarab@gmail.com>
        <xmqqlgq27jgl.fsf@gitster.mtv.corp.google.com>
        <CACBZZX4MK8=YixozpbPjJh1JxHcFr9x6GoXJeA34E-qLn6ZSDw@mail.gmail.com>
Date:   Mon, 15 May 2017 10:29:00 +0900
In-Reply-To: <CACBZZX4MK8=YixozpbPjJh1JxHcFr9x6GoXJeA34E-qLn6ZSDw@mail.gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Sat, 13 May
 2017 13:33:49
        +0200")
Message-ID: <xmqqshk6ykkj.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

>> It somehow was unintuitive that 0 expected failure and 1 expected
>> success, but it probably was just me.
>
> Except this. The wildmatch uses the same idiom, and I think it makes
> sense. 1 = true, 0 = false, ... when all we wanted was
> "does this match".

OK.  Makes perfect sense (it would have been even easier to
understand if the variable was not $status but $matches or
something).


