Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C899820248
	for <e@80x24.org>; Tue,  5 Mar 2019 12:43:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728274AbfCEMnZ (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Mar 2019 07:43:25 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52366 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728164AbfCEMnZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Mar 2019 07:43:25 -0500
Received: by mail-wm1-f67.google.com with SMTP id f65so2418808wma.2
        for <git@vger.kernel.org>; Tue, 05 Mar 2019 04:43:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=vo/SVncKyVTA92JecBXeTeXCh9TDlLBagJzAaIiDhS4=;
        b=hE6cjZviwmNXBQoQJKwkgtvgrgYo33czHZbKwF1MrAF8eqRXnmOx6TLNGXDxEBKagl
         t2BHktgDYH31g6jgRy1jJg1KJX4Fhqv3EIn5QjwSXGjv4q9R31m0OUVdPWdutq1lkqZU
         /zTf77+GJXgzzG4epp/SUOoX57lJ8atD9ruAgc9skQRDWrQIG8RVyGzrJCYJ1CnzIu6M
         Zj+IPhPMqp57rYcosJHvwC93WP5VUCHH3E6I2rKpfkwl6iDUc52EfgEdBRXj9B+nQCdN
         FTrwK4oY5k7vTYA7Di9tPV1HwuvhtIycK6gWaQPtIylWZdXpdQgBwrdgYP2pI6U/7RX5
         rS5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=vo/SVncKyVTA92JecBXeTeXCh9TDlLBagJzAaIiDhS4=;
        b=Mc/ASazTpG7rEAbMXRDBeifM/RH3lS4ZPOeiMM6cZfTTpJwOtZWrFjSEeIcbfX/08L
         XGh6JYIXuDK/gIUXbi5YVKC35w6sR5OYL3DFPgQrYEPiaAQygQg11+css500+V4XBFeu
         rhmi2bhtd/TzNqQ+KbiY0/ntNEnknzgGxBl5SK0MInrzmVuhPNWIxR8beLwHYIIdSMK5
         +dooSlGcyxPzsJjAy7VpdT1k/KVI+3SnSEYiRRPCs5ebOw+ZEAFQpM3cSfr4+dDd0Gsi
         LDI80yiGtaPxMj4CRMQz/PniXkgtcGSNZrxSW/ruqQ2iv3cObOIJH8dJSrN4n1K//fvN
         KA9g==
X-Gm-Message-State: APjAAAXSc5pWioZ2ugQHirJrxdMvNju6xz71HrYL7flGnLdbErkjYqXi
        5WSonEvcw5wQjQADGVIG0TYe5G2XaTQ=
X-Google-Smtp-Source: APXvYqycczdkVxy6Uau4GmS/NF023TgSedezdq/aN695OIm6jTzNugBmMhm9yH2sZB94EJ//gH4VAQ==
X-Received: by 2002:a1c:6788:: with SMTP id b130mr2822575wmc.102.1551789803489;
        Tue, 05 Mar 2019 04:43:23 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id m26sm6976238wmg.13.2019.03.05.04.43.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 05 Mar 2019 04:43:22 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Rohit Ashiwal <rohit.ashiwal265@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Christian Couder <christian.couder@gmail.com>,
        Git List <git@vger.kernel.org>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [GSoC][PATCH v3 1/3] test functions: add function `test_file_not_empty`
References: <20190303122842.30380-1-rohit.ashiwal265@gmail.com>
        <20190304120801.28763-1-rohit.ashiwal265@gmail.com>
        <20190304120801.28763-2-rohit.ashiwal265@gmail.com>
        <CAPig+cTTJgXERud0=svc5b+ctwQxoQ6cmpiA7WHMa7TUZ37BgQ@mail.gmail.com>
Date:   Tue, 05 Mar 2019 21:43:22 +0900
In-Reply-To: <CAPig+cTTJgXERud0=svc5b+ctwQxoQ6cmpiA7WHMa7TUZ37BgQ@mail.gmail.com>
        (Eric Sunshine's message of "Mon, 4 Mar 2019 19:17:50 -0500")
Message-ID: <xmqqmum9v6dx.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

>> +test_file_not_empty () {
>> +       if ! test -s "$1"
>> +       then
>> +               echo "'$1' is not a non-empty file."
>
> Although not incorrect, the double-negative is hard to digest. I had
> to read it a few times to convince myself that it matched the intent
> of the new function. I wonder if a message such as
>
>     echo "'$1' is unexpectedly empty"
>
> would be better. (Subjective, and not at all worth a re-roll.)

Yeah, that is subjective.  The expectation of the test is "not-empty",
so I do not see this double-negation as being too bad, though.

> Much later in this same file, a function named test_must_be_empty() is
> defined, which is the complement of your new test_file_not_empty()
> function. The dissimilar names may cause confusion, so choosing a name
> more like the existing function might be warranted.
>
> Also, it might be a good idea to add this new function as a neighbor
> of test_must_be_empty() rather than defining it a couple hundred lines
> earlier in the file. Alternately, perhaps a preparatory patch could
> move test_must_be_empty() closer to the other similar functions
> (test_path_is_missing() and cousins).

Very good suggestions.  Looking at neighbouring helpers around
must-be-empty, it seems to me that the latter, i.e. moving it to sit
next to other "path" helpers, would make the most sense.

Thanks.
