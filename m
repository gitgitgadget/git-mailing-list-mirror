Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F20F21F404
	for <e@80x24.org>; Wed, 21 Feb 2018 18:06:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S939000AbeBUSGO (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Feb 2018 13:06:14 -0500
Received: from mail-pl0-f45.google.com ([209.85.160.45]:38988 "EHLO
        mail-pl0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934173AbeBUSGM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Feb 2018 13:06:12 -0500
Received: by mail-pl0-f45.google.com with SMTP id s13so1343577plq.6
        for <git@vger.kernel.org>; Wed, 21 Feb 2018 10:06:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=BQK2MJBBU8g6beJethBxJN8VcKptEa1q+lTfc7Kf7HQ=;
        b=a5caMYAHdKE8AeLrqyW0tGze4QmlQ8Pmfk5ilqg8EiYQY6bOu5LpiMXILuc+s6kXAm
         /1nW3DPVJlELZEei1jcbtaQsYFEDcqTulEBI3pVqAhrlYSZVFFIcwKx+lBQ16lAXeN/p
         glp86b+PbaX3zx//aHJcb42tFL756ly5yBD06FnP9bnXid7utmSqA1ems3wBr7mZim+a
         1xqvkclRL6xdUFsBAaTB5uM1VlxeF0fDKpkfr4JVf1n0ZBsn+Ao4VlB28QXdmGKOlqzX
         RWxYClBdQbzfeRijAbx2hUzmKcUCohMTTYcde27Eo8N5T7dDdLLROefAdU+orUp0Wwnv
         zbuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=BQK2MJBBU8g6beJethBxJN8VcKptEa1q+lTfc7Kf7HQ=;
        b=GGakzJkYty5ANi4wcrjhopdVabvAmu8VmxYi0rE07MMY64x0+1Z11ueycmQjQZ5Wp3
         gaTOtZgHm1s4u5/QzOnTUAqxiMsmweaCUhg8CCiFj9zxqoeFyB99xpUPc6DKEOg7Vld1
         xUTxw+1A7xCMCpl2TGaA83TcBh17XGRIVcfjVMKUWg+BUb5MKD8UnSzrgd3NIUTLHqnF
         oTQCffzTBdVZw6SQ9Xg1Ogz5keOZ4D7wdLd7QJFGrKA5KjyTkmigxsLY4h6iiRw2FAeo
         wyHKM0SLQ0n5t5o3wlU57y6ImshOvP5YDib0j5rARNgFASPYKEwmNSPBoyETExR/jfIu
         neYQ==
X-Gm-Message-State: APf1xPBSRBZmejlo59AXOrQ2tB/BJUORi8ajFMTK+LFDWX06xT9BmrGc
        FQNAKJDerkVz8SiLIp7TK91gtazA
X-Google-Smtp-Source: AH8x224zxJ1ATqHlsiLfIfexJ7wDdzR3RTJuRo4nshviUxcLSiI1XUiL/uWOegceQxJfYbjXIX1XKQ==
X-Received: by 2002:a17:902:5269:: with SMTP id z96-v6mr3879772plh.385.1519236372222;
        Wed, 21 Feb 2018 10:06:12 -0800 (PST)
Received: from neuc02sy061h040.ads.autodesk.com (adsknateur.autodesk.com. [132.188.32.100])
        by smtp.gmail.com with ESMTPSA id z4sm11022141pgb.4.2018.02.21.10.06.09
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 21 Feb 2018 10:06:11 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v7 0/7] convert: add support for different encodings
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <xmqq606w7oht.fsf@gitster-ct.c.googlers.com>
Date:   Wed, 21 Feb 2018 19:06:24 +0100
Cc:     Jeff King <peff@peff.net>, lars.schneider@autodesk.com,
        git@vger.kernel.org, tboegi@web.de, j6t@kdbg.org,
        sunshine@sunshineco.com, ramsay@ramsayjones.plus.com,
        Johannes.Schindelin@gmx.de
Content-Transfer-Encoding: 7bit
Message-Id: <3D564480-619C-4AF2-9896-B2FC2C40028A@gmail.com>
References: <20180215152711.158-1-lars.schneider@autodesk.com> <xmqqr2pm81hh.fsf@gitster-ct.c.googlers.com> <20180215220952.GA23970@sigill.intra.peff.net> <xmqq606w7oht.fsf@gitster-ct.c.googlers.com>
To:     Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 16 Feb 2018, at 19:55, Junio C Hamano <gitster@pobox.com> wrote:
> 
> Jeff King <peff@peff.net> writes:
> 
>> So a full proposal would support both cases: "check this out in the
>> local platform's preferred encoding" and "always check this out in
>> _this_ encoding". And Lars's proposal is just the second half of that.
> 
> Actually, what you seem to take as a whole is just half of the
> story.  The other half that is an ability to say "what is in the
> repository for this path is stored in this encoding".  I agree that
> "check it out in this encoding" is a useful thing to have, and using
> the in-tree .gitattributes as a place to state the project-wide
> preference may be OK (and .git/info/attributes should be able to
> override it if needed -- this probably deserves to be added to a
> test somewhere by this series).

Good call! I'll add this test case!


> Luckily, lack of 'in-repository-encoding' attribute is not a show
> stopper for this series.  A later topic could start with "earlier,
> in order to make use of w-t-e attribute, you had to have your
> contents in UTF-8.  Teach the codepath to honor a new attribute that
> tells in what encoding the blob contents are stored." without having
> to be a part of this topic.

I have the impression that this is the purpose of the already existing 
"encoding" attribute, no? AFAIK this attribute is only respected by 
gitk, though. A future series could make Git respect this attribute too.


- Lars

