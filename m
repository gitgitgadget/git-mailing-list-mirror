Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5274A2023D
	for <e@80x24.org>; Sat, 20 May 2017 05:19:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751910AbdETFTN (ORCPT <rfc822;e@80x24.org>);
        Sat, 20 May 2017 01:19:13 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:36392 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750735AbdETFTM (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 May 2017 01:19:12 -0400
Received: by mail-pg0-f66.google.com with SMTP id h64so11704504pge.3
        for <git@vger.kernel.org>; Fri, 19 May 2017 22:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=rOylOwx72+CF1/jfl3MMTjkDJ0SPpqyA2193zBSIIoA=;
        b=GMSOO5SB5e7Gu0fDuc83Fi0Gm5XQP9JkSSl9rLhN51TEr5ra+xhQBybw8BSno32UEg
         bNvJBN+mCyFzhmKotNSXpTdE6vxtjUGOiSvZJv7i+kR2c9SI9VBCf0Kqio68RkkvbFSJ
         Hnib+os45iczixjGaraprtEMfbWtXsvMK+KfzF80DeeMoQTb2NsgGVHZiC9XqPAcSkW0
         2oe9I4ZUKM6gr+eNg7kOsRpdT+IelFbPtrBNmJkwkj7YeG3prjcucb4nKZDDST6w9wR6
         FdzEQ2AbZ4tGQ3YQotwWvVRdaZbm7D5ssDDWnPLxQJZN/ZAY4VtxRoeL+b+ok8BDVM8+
         X9BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=rOylOwx72+CF1/jfl3MMTjkDJ0SPpqyA2193zBSIIoA=;
        b=ULZwBzP7P0eRfysweIIaBmZROvRNI6RZ3h5XPJIvWYs5gcLH5MDlO9l1CuA0S5CF1x
         Gqx0APQnoSqUuU582gjAjb+0ZO/VQHIXdaSXZmtBB7KGjxeusi7iVhOzuEn6IRRHzdCt
         XrbarCOsLhj5p2U2Z6SaBfFHTF2BXzJ00qwbmx6tBzS/A7tFaUwJPqJGx+F60iCGJ2qG
         SOT6GeTQLXyidmI0Iu8eE5rIDd9jEfeVdE3G1aSgQjgdSHHZU5vmjPAK/dOyQGLOgvYa
         pl41l4B0menIrbduBjKHylmhpJYgEVGzYqpMyuw1gsrMsbV/NlY0ChpCj/6FV/tgwDeg
         gv6A==
X-Gm-Message-State: AODbwcBfzwFyvjY/UapITaW4P8BChLN6Qpprbmop6tSAzlln3mHSrUwp
        WWDeGDkP3RDFkg==
X-Received: by 10.84.137.1 with SMTP id 1mr16003816plm.128.1495257551623;
        Fri, 19 May 2017 22:19:11 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:4027:806a:d2b9:807c])
        by smtp.gmail.com with ESMTPSA id v63sm15849739pfi.133.2017.05.19.22.19.10
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 19 May 2017 22:19:10 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Michael J Gruber <git@grubix.eu>
Cc:     git@vger.kernel.org, Lars Schneider <larsxschneider@gmail.com>,
        Luke Diamand <luke@diamand.org>
Subject: Re: [PATCH v3 3/4] name-rev: provide debug output
References: <xmqqinmq65at.fsf@gitster.mtv.corp.google.com>
        <cover.1490967948.git.git@grubix.eu>
        <21cf9d6f55d17463ab6eccdd78d57cf4a1b8e9e1.1490967948.git.git@grubix.eu>
        <xmqqtw69z8vz.fsf@gitster.mtv.corp.google.com>
        <14D0E7F4-0DC7-42ED-8DEE-B0338ECBA80D@grubix.eu>
        <xmqqd1cxz5gb.fsf@gitster.mtv.corp.google.com>
        <xmqqzig1xpm6.fsf@gitster.mtv.corp.google.com>
        <c85bc2a1-56d8-8a02-6089-2b8cb3d39e99@grubix.eu>
Date:   Sat, 20 May 2017 14:19:09 +0900
In-Reply-To: <c85bc2a1-56d8-8a02-6089-2b8cb3d39e99@grubix.eu> (Michael
        J. Gruber's message of "Mon, 3 Apr 2017 16:46:01 +0200")
Message-ID: <xmqqfug0t8aa.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michael J Gruber <git@grubix.eu> writes:

> I think I should change 3/4 to display exactly those bits that name-rev
> actually uses for weighing different possible descriptions; they are
> differents from the "describe-bits". So please withhold 3/4 and 4/4.

OK, I think 1&2/4 from this series can progress before that as it is
an end-user visible improvement.  While looking at it, I also found
a variable that recent "timestamp_t" series didn't notice and
update, so perhaps 1&2/4 needs to be rebased on a fix for that
anyway ;-)

Thanks.  Will hold 3&4/4 for now.
