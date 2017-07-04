Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 65057201A0
	for <e@80x24.org>; Tue,  4 Jul 2017 06:02:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750893AbdGDGCK (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Jul 2017 02:02:10 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:34538 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750798AbdGDGCJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Jul 2017 02:02:09 -0400
Received: by mail-pg0-f68.google.com with SMTP id j186so25263362pge.1
        for <git@vger.kernel.org>; Mon, 03 Jul 2017 23:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=blvVBnpRAZw66WaVQpnRnMQqhtev4m0A0z0LJXX9lIY=;
        b=O1bdoWcnCussg46UVQU8QEmjNCo6MV5yURtZDDgcR27rfJz3fsW80AQA3o8Vu7Az8B
         1B+gdEsOB9H6ChDXYjnWvxGl23k6YNE/1dcAQBJnQDUi++kfTvUuXcXShucqTwrZceYb
         GwnGoo3b/pwNKm05RHh9tZKiuUn1smBTgH7LK2vuA+C3jyaRkmHLaSIAYhk6YqWBVLa8
         PpYmZQL9YwmKJV01HnOW1zdxiAkiPtjEKkmyI6jYt2knonjpAkvNgpv4p4cBTNL5669p
         rdSdKjkUKXSoaViXJySBZ/N9Q/WXf+wr76WIt3SW9aLa49HmxU8DDiB2RwzulTRM9rA4
         NoYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=blvVBnpRAZw66WaVQpnRnMQqhtev4m0A0z0LJXX9lIY=;
        b=V6CCrTOoxu8AIYW3bJNNsSW6ykeP1avhWG8p1GiETguRi8hvHdhrHpxa+TWPswu+qn
         WtB7aBzyujcEsJiEQhSkUvkB80o9zhRBnNJg4Zk2YoVZWnY3M7+qClMFltpjfTcNxgzS
         HALEmhjMCslTfrOpnBDGyxGP83omtGmwVP4GitDT1vhwXmgJdbsiFUAbnQ2OoD4eeSI4
         kHc0S5G7XQ6Nj4Ut+Y2Thx/W0DwOQEGtM46Mf1pxclpYajYyVa+OjYeNwPEhotu9Ksgy
         2QwAkCL8odehK6Z4QrZVrNCzR+kJ7kZP2PaLl+cueNR/N3l8KxTC8FKF5tKf03qBY4Ur
         ueZQ==
X-Gm-Message-State: AIVw1136PQYyj/2VMsV1SKOISAn906FWtzV3uUFYkdT2/LVb+Bp2HsTV
        Nql7iaVqgV0O0Q==
X-Received: by 10.84.224.11 with SMTP id r11mr14815926plj.267.1499148128552;
        Mon, 03 Jul 2017 23:02:08 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:30:4739:ca21:b5b4])
        by smtp.gmail.com with ESMTPSA id o13sm41904111pfa.120.2017.07.03.23.02.05
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 03 Jul 2017 23:02:06 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Philip Oakley" <philipoakley@iee.org>
Cc:     <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (Jun 2017, #09; Fri, 30)
References: <xmqqk23tp2jk.fsf@gitster.mtv.corp.google.com>
        <4374FA169AD7465AA39BDB477A348B02@PhilipOakley>
        <xmqqo9t1l6vi.fsf@gitster.mtv.corp.google.com>
        <C31723137B784D54A3CDB1B7D9432D7E@PhilipOakley>
Date:   Mon, 03 Jul 2017 23:02:04 -0700
In-Reply-To: <C31723137B784D54A3CDB1B7D9432D7E@PhilipOakley> (Philip Oakley's
        message of "Mon, 3 Jul 2017 20:13:02 +0100")
Message-ID: <xmqq8tk4loyr.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Philip Oakley" <philipoakley@iee.org> writes:

> From: "Junio C Hamano" <gitster@pobox.com>
>
>> I am not sure what you are asking.  Is this the command you are
>> looking for?
>>
>> $ grep -e "^[[*]" whats-cooking.txt
>>
> Ah, thanks.
>
> It does presume that one has extracted the email to the text file,
> which is easier on some systems and mail clients than others ;-)

Perhaps you would want to find an e-mail client that can handle text
files better, then? ;-)

If you are cloning and following along my tree from one of these
places:

    git://repo.or.cz/alt-git.git/
    git://git.kernel.org/pub/scm/git/git.git/
    git://github.com/git/git.git/

the 'todo' branch in these repositories keeps track of the
whats-cooking.txt report (among other things), so you can also:

    $ git cat-file -p origin/todo:whats-cooking.txt |
      grep -e "^[[*]"

to get the same effect.




