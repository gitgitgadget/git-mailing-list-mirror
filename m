Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6F4CC1F597
	for <e@80x24.org>; Fri, 20 Jul 2018 22:28:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730006AbeGTXSy (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Jul 2018 19:18:54 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46563 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728616AbeGTXSy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Jul 2018 19:18:54 -0400
Received: by mail-wr1-f66.google.com with SMTP id s11-v6so12507225wra.13
        for <git@vger.kernel.org>; Fri, 20 Jul 2018 15:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Usph/pXxthWsu1O3wpqeBj1rA26JoBsk2HBVVz4hXA0=;
        b=U6cp8J3zFobBm5NVbTmHVjYgSTGtDe59xvhsumFldmhh8H7ziCYNa4Ao70f1kRUFF+
         Wft2Chzl37Px+zf772ozWwYu+hgEak10jsPidu6KNpi9sM3RT2gWr8uTUYi8Vsx5RbgE
         HMf4w07T+PrPtP6yq1MHvnaeVucZPAZi24Pi99qqCQDqw2e2iFP0NUVLJ3wCJED7xOBr
         WEZN7Uim0hKtXxsYu6jfAN6/WCZ/kJ1eJnvXCgFxwFePabpljpcp9XY2qdLsJRuuFNhm
         3vmCFTtw7348s9lKwzOeV5IS9jALai5T05JTYysOCF9CKhMlWC43Af84Kb+qV30QsSVK
         JfMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=Usph/pXxthWsu1O3wpqeBj1rA26JoBsk2HBVVz4hXA0=;
        b=Pe0wKhIOchVw6hJzfZOt0k4/YrSyKWFTtlzgT/5WReKXaPaTLY2YkPMRDJh5Tu8UPt
         fhJtRNzAycksR1QHGwSxSQWAXlKy83sqgf43KqFNnS0tFaW7Fwfcn8QDtWnlJoW3EAo2
         5KDADYZ/jWhx9VncC6WiCIke6yXlDWi1vNaLTzfGu7csOhUc+cU6VcyhGfY7wnwZdrjM
         NxcJME87kP3DOP+myUZ9iR3vGil4dSCUtnjzY9FJltL8ABj+c/o6WoC8Q5yWvlpVJGnr
         QvFcQdOJol9Y30jktpURTzJbbebO1tgZSu2MqffC16xcs5n4ijvCbeoR4gs5yqQ9iJ29
         tzpw==
X-Gm-Message-State: AOUpUlEh9KegljIPpgnbdaeTbeB9LKd2WkFZ3OKNJBz+XLk/kUlc1wK8
        yLz9/YY8nJ0f6XBwzDZETwCql1y2
X-Google-Smtp-Source: AAOMgpeVD3E7OwDGvkiC0UCsfh0I8UOFNBaGHjbLpSqn9cHsRF3tILMP3Lk1rYL22F4duJlGj6UT9Q==
X-Received: by 2002:adf:bc03:: with SMTP id s3-v6mr2727814wrg.211.1532125715958;
        Fri, 20 Jul 2018 15:28:35 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id f8-v6sm5961267wrj.9.2018.07.20.15.28.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 20 Jul 2018 15:28:34 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Derrick Stolee <stolee@gmail.com>, git@vger.kernel.org,
        dstolee@microsoft.com, sbeller@google.com, pclouds@gmail.com,
        avarab@gmail.com, sunshine@sunshineco.com, szeder.dev@gmail.com
Subject: Re: [PATCH v4 03/23] multi-pack-index: add builtin
References: <20180706005321.124643-1-dstolee@microsoft.com>
        <20180712193940.21065-1-dstolee@microsoft.com>
        <20180712193940.21065-4-dstolee@microsoft.com>
        <xmqqva99bwdw.fsf@gitster-ct.c.googlers.com>
        <20180720221522.GD18502@genre.crustytoothpaste.net>
Date:   Fri, 20 Jul 2018 15:28:34 -0700
In-Reply-To: <20180720221522.GD18502@genre.crustytoothpaste.net> (brian
        m. carlson's message of "Fri, 20 Jul 2018 22:15:22 +0000")
Message-ID: <xmqqwotp8ru5.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> On Fri, Jul 20, 2018 at 11:22:03AM -0700, Junio C Hamano wrote:
>> Derrick Stolee <stolee@gmail.com> writes:
>> 
>> > diff --git a/Documentation/git-multi-pack-index.txt b/Documentation/git-multi-pack-index.txt
>> > new file mode 100644
>> > index 0000000000..ec9982cbfc
>> > --- /dev/null
>> > +++ b/Documentation/git-multi-pack-index.txt
>> > @@ -0,0 +1,36 @@
>> > +git-multi-pack-index(1)
>> > +======================
>> 
>> Isn't this underline too short by one column?  My copy of AsciiDoc
>> seems to be OK with it, but do other versions and reimplementations
>> groke this fine?
>
> I believe AsciiDoc allows a two-character grace (either longer or
> shorter) and Asciidoctor allows one.  So this should work both places
> (although I haven't tested).
>
> It might be nice to fix if a re-roll is needed, but it should be
> functional as-is.


Thanks.

I've already locally amended it and pushed the result out, as I
needed to touch-up another commit in the same series anyway.


