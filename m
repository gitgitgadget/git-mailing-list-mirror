Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 421D320248
	for <e@80x24.org>; Fri, 22 Mar 2019 04:26:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726041AbfCVE0K (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Mar 2019 00:26:10 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45372 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbfCVE0K (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Mar 2019 00:26:10 -0400
Received: by mail-wr1-f65.google.com with SMTP id s15so793526wra.12
        for <git@vger.kernel.org>; Thu, 21 Mar 2019 21:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=U+F1IhdIekOtwkg1Kmc8fvdyH8f4/NEHv5NSL5PvPd8=;
        b=Q0jLyrBidpfCzTwILQWhR/VtmvM6cBdfgUtwC2pFfw36mUUPudhVAvCQmw9zOMrnNK
         MKtLbQsrAYfuxxKt64ab0yWIc+z4SIUQLsW6JTe+ulljWIK5q5HvgqFp9hwSbw5TdTsq
         tC+feUOErn2ZuEhPZgDTuF/HZiegLHNMKpgfR39vfLe9Z1v5XEgDvFLeyNnzaXGw2qSV
         RRUtYcmTtPW/h/rgwJmYgXVMAsMzu84MX+5YVvzgAh47vLSzi6/P8GgcUIj7TV3jJhd7
         Rpct/jUS954Hsto2f1pBnd31wRuYOu4jvtMpYA/zBxbYjaKd6h034hx7wQugDupMVJNs
         fNHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=U+F1IhdIekOtwkg1Kmc8fvdyH8f4/NEHv5NSL5PvPd8=;
        b=RZLegdIG6ADMvR+QG8RtxMnGUTJfJnkDOM6X3nx3EiHHMLT0AQXy7tXfFosTkrXEoV
         8kDIJ7T0VRcDKOMqGSvZ5Z7QPk5g/SiBBSoP4F4f2vvWvbKq8uH9XrreSjbDTHgFAEYJ
         I0HQXGl+PUgreW0BxbIvpUHsPJixntq3OWLl2U+JkwYF2T1oLBHuOMsvEzKZ9EnGts0X
         qmtGElY+0G5W8zL0ipE4bgt4OYtUUNBHZBBMqSP4tgIs4P+Bh1wqAUk6lP+fUw9rEZF0
         1m/va41OomD+4J1N13pEDy+TeC2o/9LLEBt1ljJ2EvRnPgWKfJvWJXHQjPFBSnptxBQ6
         BdVA==
X-Gm-Message-State: APjAAAXStSDrAFMjzwPViyXmTNgZQDdEQFGkfP3+eCsqVvNWPmDo/rUI
        JwSKZQSvKamxEkCjfhNIHiY=
X-Google-Smtp-Source: APXvYqzmld5kX1MZvNLr29MVb/jfcnh5xk9ERr3wNdbrG1T52XKv7torel0foddO+i8woIxyqr7D8w==
X-Received: by 2002:adf:f70e:: with SMTP id r14mr4599839wrp.37.1553228767910;
        Thu, 21 Mar 2019 21:26:07 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id l12sm9975130wrt.31.2019.03.21.21.26.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Mar 2019 21:26:06 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     eckhard.s.maass@googlemail.com, git@vger.kernel.org,
        jacob.keller@gmail.com, martin.agren@gmail.com, newren@gmail.com,
        phillip.wood123@gmail.com, rybak.a.v@gmail.com,
        sunshine@sunshineco.com, szeder.dev@gmail.com
Subject: Re: [PATCH v5 00/26] Add new command 'switch'
References: <20190317124926.17137-1-pclouds@gmail.com>
        <20190321131655.15249-1-pclouds@gmail.com>
Date:   Fri, 22 Mar 2019 13:26:05 +0900
In-Reply-To: <20190321131655.15249-1-pclouds@gmail.com> (=?utf-8?B?Ik5n?=
 =?utf-8?B?dXnhu4VuIFRow6FpIE5n4buNYw==?=
        Duy"'s message of "Thu, 21 Mar 2019 20:16:29 +0700")
Message-ID: <xmqqh8bvr0v6.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguyễn Thái Ngọc Duy  <pclouds@gmail.com> writes:

> This adds a new command 'git-switch' as the half-replacement for
> 'git-checkout'. Jump to 12/26 as the starting point. The other half is
> git-restore, which is dealt with separately.
>
> The diff delta is shrinking nicely. The two main changes are
>
> - '--orphan <new-branch> <initial-tree>' is no longer accepted
> - --force implies --ignore-in-progress
>
> The rest is the usual typo and bug fixes.

And droppage of sign-off?

Other than that, the changes relative to the previous round looked
all reasonable.
