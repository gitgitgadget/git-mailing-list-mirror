Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 029451F404
	for <e@80x24.org>; Tue, 11 Sep 2018 21:11:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728102AbeILCMu (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Sep 2018 22:12:50 -0400
Received: from mail-wm0-f49.google.com ([74.125.82.49]:54476 "EHLO
        mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726870AbeILCMt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Sep 2018 22:12:49 -0400
Received: by mail-wm0-f49.google.com with SMTP id c14-v6so114344wmb.4
        for <git@vger.kernel.org>; Tue, 11 Sep 2018 14:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=XcyBsnABTKUGJOYrWANdR+y6UBEis4PPvLvBCRy9kXk=;
        b=dQjGIFShFt/q86Ei6lCoRsGRe4tplB2fgFVFzRPhzHWnUjjs8ImmUzWmNHffxHjz9I
         Z5FdjornP4I68WLqj6LnBzUph1Y01ZLJtskAHwWnhUewQAFLE6xA5gkgJb1aV0p/OxeV
         P4EkocfsHTc/HI9LOzU701k6JDIlvVGBdOaQwBK7WMlevQUGc+OjVuRhuvIwqJkFQl4f
         TBMMW+oiHgTj1tnPJIAw9//XoUzw7Dnb0bntgyyb1dkkVKY83vgbA5BdNZaalR+t6Mk8
         r6/9E9Vneu5ZmGVMhnS8BI1tpC7ifed0Lts4cQ3X3qmh1sE6bEBY82tJtbYrETWSK0L1
         l7iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=XcyBsnABTKUGJOYrWANdR+y6UBEis4PPvLvBCRy9kXk=;
        b=HI6MwUm7utFbNedZpbAt2ieG5a48gubad+pgycMeaSaZsYtVM8FSnMAQEeT4RAiXx5
         QFQ4EnvrMIltMmTq6ZZtEPdIib4by6jI45gUvtbpzBBgXNCXk5jShP39GAljqbnStb6A
         6EyTlpV74ouhh2i5zT35VhfOrRF0DG/L6een5bw+OR9tEcaFbVfC9yvOzXiObH8f1+gX
         mGazApdrI0wgasDo6u8S1DsQZk3zqtwhei3vcAar9ySyCIT98PWX+kT+LfA2X4EKzHji
         MWleOWyOGhhabP19ooEbRYuLp1glYR/wgJF6qe57a/cYay1wnIvHi8LN1DobUxqGwPlh
         N3vA==
X-Gm-Message-State: APzg51Djz4813+8Bs42htsk3QOOb4wFWOoubBqv3cUmLTL+kdnfKW1Zv
        tHnus9i2irebnaqcCrXWCaw=
X-Google-Smtp-Source: ANB0VdYcET1AOOa3uE/Mp080La+mmizBRENfDKkB6sdJra28W6D7JaF8G+44w1pEBBqD547FQTtX/w==
X-Received: by 2002:a1c:1802:: with SMTP id 2-v6mr2508884wmy.81.1536700299837;
        Tue, 11 Sep 2018 14:11:39 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id k5-v6sm32902941wrm.96.2018.09.11.14.11.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Sep 2018 14:11:39 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 1/1] t3206-range-diff.sh: cover single-patch case
References: <pull.37.git.gitgitgadget@gmail.com>
        <58347a962438852be0d37c3957686ea5000b2dbd.1536697263.git.gitgitgadget@gmail.com>
        <xmqq4levoinl.fsf@gitster-ct.c.googlers.com>
Date:   Tue, 11 Sep 2018 14:11:39 -0700
In-Reply-To: <xmqq4levoinl.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Tue, 11 Sep 2018 13:58:54 -0700")
Message-ID: <xmqqzhwnn3hw.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>> +test_expect_success 'format-patch --range-diff as commentary' '
>> +	git format-patch --stdout --range-diff=HEAD~1 HEAD~1 >actual &&
>> +	grep -A 1 -e "\-\-\-" actual | grep "Range-diff:"
>
> Isn't "grep -A" GNUism?

Sorry for short-write(2) X-<.

Perhaps

	sed -ne "/^---$/,+1/s/^Range-diff:/&/p"

or something along that line.

