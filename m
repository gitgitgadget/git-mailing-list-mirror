Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C9DBB215F6
	for <e@80x24.org>; Wed, 12 Oct 2016 23:37:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932961AbcJLXht (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Oct 2016 19:37:49 -0400
Received: from mail-lf0-f45.google.com ([209.85.215.45]:36598 "EHLO
        mail-lf0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932724AbcJLXhr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Oct 2016 19:37:47 -0400
Received: by mail-lf0-f45.google.com with SMTP id b75so101588750lfg.3
        for <git@vger.kernel.org>; Wed, 12 Oct 2016 16:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kaarsemaker-net.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=29vc8FGUcyRdmvU5rgKBXbo+ce2pPjW4f04bL2C85FA=;
        b=gPKoyWTzXeCt0/Cjq9Icx/S/Hs+bTlnWJt2pR1rqf/W6c9LxekciDhsSOIUNtS57tx
         7c4Qw1eJ4AnSUn++ZNPT6XgDdTSPGAl1yPDKTu/2sDUem3+Lo8eOyzYj502+EYf16jZQ
         5kEJD7rDXSpK5clC1IHSku6UDDaEQSy2l8tZzH+8KO68kvFTG+q8FsPGAvLJnSfs9UOw
         wIozMr2+JcaKdR8IYPyzfOFOL97Xr/o+xDMYgPOCryGZg9dT5SEV+gvDTi4WSb7ZNvT7
         pKp087TPPK2yQePHnHO7OgTQq/EDrJWrbAQqH3uWu+fmQPzwwAP1OM4HWpw8OfGV/6Rx
         Z+6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=29vc8FGUcyRdmvU5rgKBXbo+ce2pPjW4f04bL2C85FA=;
        b=K4EroY/xdTKzdijFZvZIHo1F3TgcKQDF33Zc6dcOvCQ5pNJmOHBmgwZNpLsVo463ao
         ymlpmPqdip52co97tsepxSjrFqndB1exsofSPLhiOx28KhxuigeCSQfzzynJ21EDrnWg
         0sqRbI4A7R0hfplOwPfUPHPo86kdejJjjtFoswzwPrlz509onFBjwWhiwDfoob1MM4xZ
         ZRyS7M+nrsddLh8CMM+K5JAoqJK3A5n92VI23G2WjxtIC3l4rAcHLmPD4huY0xU8ZoUv
         zmX9prKnbU2DQdy07I3X7r5c1GEbMkzOQCk6wfCiAjuNHVx7lztjntHQM4A7odBZt4fc
         blTA==
X-Gm-Message-State: AA6/9Rn3LWJ7o7FhnIc7oIPS+7FgWLxLiEvii4/uQs5zh8Ib3ubMSzhF9/rjiVQ+pf3+Nw==
X-Received: by 10.194.243.167 with SMTP id wz7mr3871206wjc.65.1476300191308;
        Wed, 12 Oct 2016 12:23:11 -0700 (PDT)
Received: from [10.42.1.91] ([145.132.209.114])
        by smtp.gmail.com with ESMTPSA id h10sm15253962wje.48.2016.10.12.12.23.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Oct 2016 12:23:10 -0700 (PDT)
Message-ID: <1476300189.3876.18.camel@kaarsemaker.net>
Subject: Re: [PATCH] worktree: allow the main brach of a bare repository to
 be checked out
From:   Dennis Kaarsemaker <dennis@kaarsemaker.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, pclouds@gmail.com, mtutty@gforgegroup.com,
        rappazzo@gmail.com
Date:   Wed, 12 Oct 2016 21:23:09 +0200
In-Reply-To: <xmqqfuo14dnr.fsf@gitster.mtv.corp.google.com>
References: <CACsJy8CmgmGLEi0xQUY9Eo-4FkA4eDNk9WJ2LtEDVFQBjbFdCA@mail.gmail.com>
         <20161012164104.zcxpcwqrp5h65qmc@hurricane>
         <xmqqfuo14dnr.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.0-2ubuntu1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 2016-10-12 at 11:37 -0700, Junio C Hamano wrote:
> > ++test_expect_success '"add" default branch of a bare repo' '
> 
> Huh?

Copy paste error. And I missed

ok 17 - checkout from a bare repo without "add"
./t2025-worktree-add.sh: 141: ./t2025-worktree-add.sh: +test_expect_success: not found

in the output of 'make test'. Thanks for fixing up!

D.
