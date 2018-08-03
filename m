Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B72EB1F597
	for <e@80x24.org>; Fri,  3 Aug 2018 17:13:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729842AbeHCTLH (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Aug 2018 15:11:07 -0400
Received: from mail-wr1-f53.google.com ([209.85.221.53]:43125 "EHLO
        mail-wr1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727792AbeHCTLH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Aug 2018 15:11:07 -0400
Received: by mail-wr1-f53.google.com with SMTP id b15-v6so6039666wrv.10
        for <git@vger.kernel.org>; Fri, 03 Aug 2018 10:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=nTwOiw/rXaqo7vIdV1qa23pXg2IgMIZF50AChJml9F4=;
        b=tculIcqMKmYpoSnDgbUG3XH6c4Ua4dGt7y0AI4luqfh1Zi8PdZhy9YGalegfnoNSux
         AXsXAsChxk9OU+c6Ehh0E1U2xddFpBT3IjLU0lBYR7oNJPYUqxDZHJZyBtOC4MNVBUsk
         wqGY7iMOnZXf+Ijmk2r5imlYx0MU/hf9Ed/5x94+5sFR7oaMzGvVYpPQVb4V6fKeY75k
         enHziikhRJySvBxdsTHB5DK6IcAoKaOqA1PqOAIfkrcYY1kwW8BS/y0kvCjpow1jluQj
         bGztLXfLQUaFf3aR5/TQy5Uf4oQH9A2J1jKujz0UkYbbckIY/ffBz9Tc/Bnt1gSrueCX
         qZPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=nTwOiw/rXaqo7vIdV1qa23pXg2IgMIZF50AChJml9F4=;
        b=jflo1tgap2at2jI+rEC3tAoBFN3Hih+zDrqCNS9KKKiou9F8VA21cH1pnh1dneFiPI
         Dwb0CxKiWEXHPXkXidZZNdS+aJ65rqIjdoC4qHdL4RSkWybtbPPHEOigVSArHCwNNuoi
         oZUYuVSHPt7QPwKpwoJ9oS1N0bbg6e4rZ/x8g4DGFzuabMFR9C/Yg2+xCDtYzRIT/xJ1
         /YCeERE5Ar2rm8Zkn9SXL9V+bNcVLxZNjCWzi0WVLF/9LebLRZnY/y67oG2Q0pFPGSyk
         0WNJGdpRS0q9IvxscWEPru0RnptxwWp3MA87+UfKIKn6wrIsgig1k31bN4jg+tQYWQod
         lU1A==
X-Gm-Message-State: AOUpUlHlONEMpYGD52XsA2uw6lL1sFuWlr8bG5rgWuN1R/In67ZAMwkE
        O94KM+toFK8IGgpxf/dZQok=
X-Google-Smtp-Source: AAOMgpf1nF3wsM1Sn7RBh4nL8c1BVacNVWCr1Agus6CncieEuJXVQV+nBjwXn3xBO8T6pNtoQQ2BDw==
X-Received: by 2002:adf:f342:: with SMTP id e2-v6mr3138484wrp.161.1533316434223;
        Fri, 03 Aug 2018 10:13:54 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id x23-v6sm3348482wmh.26.2018.08.03.10.13.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 03 Aug 2018 10:13:53 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 00/12] Kill the_index part2, header file cleanup
References: <20180630092031.29910-1-pclouds@gmail.com>
        <CACsJy8Am4bWKziBV6-J+c+Kz4u-rkotgZiorhvHOfy2K5cMBvg@mail.gmail.com>
        <CACsJy8DnsTw6_Ohu+rZyqiBGV127dJ1Y4xGRbkRTaBchHtaQxQ@mail.gmail.com>
Date:   Fri, 03 Aug 2018 10:13:53 -0700
In-Reply-To: <CACsJy8DnsTw6_Ohu+rZyqiBGV127dJ1Y4xGRbkRTaBchHtaQxQ@mail.gmail.com>
        (Duy Nguyen's message of "Fri, 3 Aug 2018 18:16:36 +0200")
Message-ID: <xmqqtvobxtim.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

> Another friendly ping. I really need to know if I need to update (or
> drop) this part before moving on to part 3.

Easier is to resend and see if it sticks this time (that is how I
landed format-patch back when I was just an individual contributor
;-)

I will see if I can locate them in the archive (I actually do not
have strong preference either way myself, so the inaction was not a
form of objection but was merely showing a "Meh").

Thanks for prodding.
