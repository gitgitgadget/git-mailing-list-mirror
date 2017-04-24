Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DBFC3207D6
	for <e@80x24.org>; Mon, 24 Apr 2017 21:11:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S973322AbdDXVLg (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Apr 2017 17:11:36 -0400
Received: from mail-it0-f49.google.com ([209.85.214.49]:35480 "EHLO
        mail-it0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966844AbdDXVLe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Apr 2017 17:11:34 -0400
Received: by mail-it0-f49.google.com with SMTP id 70so6885197ita.0
        for <git@vger.kernel.org>; Mon, 24 Apr 2017 14:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackthorn-media.com; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=yL0pkQh7INvmYJJbB27wh910gQ4upNNljpCQe9e28Uw=;
        b=Vd4SnVrxhJLWyEi3UOPyQF2ApCs/E2WkmzxpgloZKEMjYKnzlGY01W0Vn8LiBGhe3q
         CDIK7HQS7r4uhTWwnQ6HLbFwNuDIRbdCXRjbnCkruMODJoBzVyMyN3vuDavWIHnamtqe
         /fIUcqeUPOT6OA5E0Uf7N40KQYIiurhi6WA7w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=yL0pkQh7INvmYJJbB27wh910gQ4upNNljpCQe9e28Uw=;
        b=CGKMVUapfUl6ceoSMA/kEQ8rL14yANyv3oNArblece/OGd7zLKTsiBS9ShBpnyZ7GE
         6HhnzPvqgGQ0ieee6anCgaBLgPPzOY28mbZ3vTu/zsXsN1Pbq+mrxDeoGRd83ozGZRZT
         HWKHWNGVhbjIKHpn4BPal4ZvsNGJDT6gPFUe7s41q2AmHM6WF+Wnl23Q4I8zp4WgkQjc
         KLFT9ETGEoftoJ8qP9pZeuYVsbBHQNA7bZvW6Kex9u2+8IErW9PXTvD89YHgIK9BA+PH
         puVN8CJJYd1c3x1EsjpyvoFIFgnBVYEyXzs6fzM1eRCE3k6Wv2cjUJrHkUbq9ADi7Evt
         /pNQ==
X-Gm-Message-State: AN3rC/62wtOlHlaiNUwwcDkiV+AbFp82IRb/Hs+xVG5NQUUxukizU6eP
        GQDJQ70s49Ru0VFtSwp8vA==
X-Received: by 10.36.230.5 with SMTP id e5mr17248945ith.0.1493068293447;
        Mon, 24 Apr 2017 14:11:33 -0700 (PDT)
Received: from [10.10.2.117] ([38.88.196.250])
        by smtp.gmail.com with ESMTPSA id e73sm8427021ioi.22.2017.04.24.14.11.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Apr 2017 14:11:33 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH v3 5/5] archive-zip: support files bigger than 4GB
From:   Keith Goldfarb <keith@blackthorn-media.com>
In-Reply-To: <e53f1d3f-be3a-ac28-89eb-63011da64586@web.de>
Date:   Mon, 24 Apr 2017 14:11:31 -0700
Cc:     Peter Krefting <peter@softwolves.pp.se>,
        Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <0E87DF4B-1924-41DE-97E0-8294146E7D4E@blackthorn-media.com>
References: <37eb7c14-eb61-7a63-bdf0-ee1ccf40723f@kdbg.org>
 <alpine.DEB.2.11.1704222341300.22361@perkele.intern.softwolves.pp.se>
 <a1504d15-36d6-51f8-f2c9-a6563789bb6f@kdbg.org>
 <alpine.DEB.2.11.1704231526450.3944@perkele.intern.softwolves.pp.se>
 <e0d1c923-a9f5-9ffc-a7e7-67f558e50796@kdbg.org>
 <alpine.DEB.2.00.1704240901520.31537@ds9.cixit.se>
 <b3f2f12c-2736-46ed-62c9-16334c5e3483@web.de>
 <85f2b6d1-107b-0624-af82-92446f28269e@web.de>
 <e53f1d3f-be3a-ac28-89eb-63011da64586@web.de>
To:     =?utf-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
X-Mailer: Apple Mail (2.3273)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This set of patches works for my test case.

Thanks,

K.

