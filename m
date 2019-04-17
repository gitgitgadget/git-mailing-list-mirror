Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8AC6F20248
	for <e@80x24.org>; Wed, 17 Apr 2019 05:40:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730203AbfDQFkw (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Apr 2019 01:40:52 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43298 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbfDQFkw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Apr 2019 01:40:52 -0400
Received: by mail-wr1-f67.google.com with SMTP id k17so25463393wrx.10
        for <git@vger.kernel.org>; Tue, 16 Apr 2019 22:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=zLWj56Avjdajbfamv9nEgn4TWiOfgGyXcFPZMjUn+zY=;
        b=asx4iH8+9o3+IQ5UT2v6QLkEa5LoOPdzbhq2UZtZQW7Yoc06Md88VxrMuIOt9Olxxd
         +sjA5aTisDWxvY4Fv09ow4tF0Q/E1ZI5LNpV2Ql8Mo2lsWUK0yOhegGE824ytMuRffVD
         6oWYBCSok1gBc+WsSPmWAklqqYvu2Tva1Pj/F6j2dEDsmzeXwPzBYbC3Gxs/jeRv3UMh
         hs9zmwzGXg69MpoeomlFF5j5N2vcmvLYrGu91LUYQpqV3tFkDAtzZ9prDDjnfzMJrBPI
         AqwiflOsdAaoxrtiKk9yTF4Z40Dj9Vnfipr9fEFz1TaVfpFcVCaoKq2ShKbdJcPWcuCz
         2+UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=zLWj56Avjdajbfamv9nEgn4TWiOfgGyXcFPZMjUn+zY=;
        b=DwouO+MX4ycpw6NJ/HVDnO3FiiGkJ4zttLW7wLtuFnRO+GtIYh7slRtzNLgGMLu2UB
         YkrFhxcH8s3+mSNLQFe/0trM0Fyy6TWRHQ5/3MXpUvbFn4UmNqA2Osn18LsZB/lhviQt
         iSEYAl5616iG6YV3wn2gwdAjuDdFLuiPTRc1XViTZ6UV4NjnTbM6uT/VRNC9P0cYhvp1
         XngrrZeuwN2g1xtCmNFmcxqL1TrHpfbW2bnkuVyDwBstkEOwQtcLe4yIHfqRR2gl776x
         xii/EjoFoFPXa0YQXySIjakZT4vYV31OgQC54myOCvtaiQbwm4v19Ca76+Df7U8klVs2
         oD3g==
X-Gm-Message-State: APjAAAWSh1/tzeBWcesqawhRbb3URPrOu7GZFP5EE2NqL8WCjEip8ICl
        jzklwaAn//Qyssib7f/P8Dg=
X-Google-Smtp-Source: APXvYqyj8wS/N0HiFPVOk01imt160Ss/k0VuK2bMQNOs1x5g+c4joYYH+9pNEXbiryMr3g2DUSYnlQ==
X-Received: by 2002:a5d:428c:: with SMTP id k12mr40896536wrq.279.1555479650050;
        Tue, 16 Apr 2019 22:40:50 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id z11sm1383767wmf.12.2019.04.16.22.40.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 16 Apr 2019 22:40:49 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH 7/7] Turn `git serve` into a test helper
References: <pull.168.git.gitgitgadget@gmail.com>
        <411587e4b80bd4e5a1cb9b1ec438cda7a0681465.1555070430.git.gitgitgadget@gmail.com>
        <xmqqa7grqsbt.fsf@gitster-ct.c.googlers.com>
        <20190417034621.GA19448@sigill.intra.peff.net>
Date:   Wed, 17 Apr 2019 14:40:48 +0900
In-Reply-To: <20190417034621.GA19448@sigill.intra.peff.net> (Jeff King's
        message of "Tue, 16 Apr 2019 23:46:21 -0400")
Message-ID: <xmqq36mhkx3z.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> I do not personally think, as the design of v2 stands, a standalone
>> "serve" server that "can serve anything as long as it goes over
>> protocol v2" makes much sense, but perhaps those who have been doing
>> the v2 work may have different ideas, in which case let's hear what
>> their plans are.
>
> I too would like to hear more definite comments from people who think
> git-serve is worth keeping. In the meantime, there's some discussion
> from this thread in December:
> ...
>   https://public-inbox.org/git/20181213195305.249059-1-jonathantanmy@google.com/
>
> (In case you do not feel like reading the whole thing, my opinion there
> is that git-serve is probably not the right direction, and we would do
> well to demote it as Dscho's patch does).

I guess we are more or less on the same page, then.  I'll let others
chime in by waiting for a bit more but I won't wait forever ;-).

Thanks.
