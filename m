Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 03F89202AA
	for <e@80x24.org>; Sun,  3 Mar 2019 14:07:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726285AbfCCOHn (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Mar 2019 09:07:43 -0500
Received: from mail-pg1-f173.google.com ([209.85.215.173]:41835 "EHLO
        mail-pg1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726186AbfCCOHn (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Mar 2019 09:07:43 -0500
Received: by mail-pg1-f173.google.com with SMTP id k11so259408pgb.8
        for <git@vger.kernel.org>; Sun, 03 Mar 2019 06:07:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NtURRQ6YsxgJR+VcC7zsKqoO5/eug9Bt2pNF6S7si28=;
        b=c9MUdyhTyaMx9CylzNkWapuMjhQLlucjInglCk3ZG+MEK/TMAzowUMPOj9wX+ME9wo
         Xn7cnePxh+TjGcJvMo15L6IEooytzeFgJus6YjLFIAlhAdnIjiz6LNbl3YGgpIu3Nvpu
         QRGxGBrQBlFcNh2GZCEGmanzHkbP9RhrCcMIUJce//eqnplonZZuMiT27Mh+iynmLkLk
         bhho8bcGFeiYq5ltZQWOrty2l6txH9ZRplYYQXrqB51PrhKguvd00f+f47cR13+lK9T2
         Y6vtLia3uwygTH2oxkE/DQjoOO2cPdxF+MLyryJjOxKnbnQIVgU7g1aIePNwKVIBRDLO
         RgXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NtURRQ6YsxgJR+VcC7zsKqoO5/eug9Bt2pNF6S7si28=;
        b=ZiLMvHR+B44ponOwp92mGjgTpTEIxwp3jp+TtIdPv9gjfbMObqNU2can3yaT/x2o00
         tf1gWyFYadFnvVO+nsYlg/ZyR9eKho3g4H3+FsZZa42l3013p9tiWtKe54Oh78pjFbbW
         /r0ccWCbJ/z/9WJEBxk/799rutR4bGkXsuLEcs1NE01f+SXVjEryFQnlhnN5pi8/pdbN
         9Hgqkl3Tn7qHEDc6kVmFxSqqvb9IjPdfXrDRpP2zCm3NLfqi4MeDDwDtVS5jdQFFYLO8
         UuEoJbQKrvUWzeeDL/ANm+9X0Jk6Mlbw2RbujT4v9yzmd5PUSafXAogpYZ/5AflCgn0R
         kc8Q==
X-Gm-Message-State: APjAAAVuRUfrVx0cda6RszUgC/gms+z3xPz8bci3xG427r3zVqQMlF5x
        gJhAv2fGDuyaRRu1hwyvUdo=
X-Google-Smtp-Source: APXvYqyav7twsX85q4p8o0KEzaYsYir9dc4bbvOGO2fuJ57Q+0DWuBEIDNARm82pN8vbQK+COvSFww==
X-Received: by 2002:a63:e447:: with SMTP id i7mr13924847pgk.70.1551622062563;
        Sun, 03 Mar 2019 06:07:42 -0800 (PST)
Received: from ar135.iitr.ernet.in ([103.37.201.80])
        by smtp.gmail.com with ESMTPSA id f65sm5241145pff.21.2019.03.03.06.07.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 03 Mar 2019 06:07:41 -0800 (PST)
From:   Rohit Ashiwal <rohit.ashiwal265@gmail.com>
To:     gitster@pobox.com
Cc:     Johannes.Schindelin@gmx.de, christian.couder@gmail.com,
        git@vger.kernel.org, rohit.ashiwal265@gmail.com,
        t.gummerer@gmail.com
Subject: Clearing logic
Date:   Sun,  3 Mar 2019 19:37:09 +0530
Message-Id: <20190303140709.5561-1-rohit.ashiwal265@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <xmqqo96syte0.fsf@gitster-ct.c.googlers.com>
References: <xmqqo96syte0.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2019-03-03 13:33 UTC Junio C Hamano <gitster@pobox.com> wrote:

> test -s <path> makes sure <path> is file; if it is not a file, then
> it won't yield true.

> On 2019-03-03 13:20 UTC Rohit Ashiwal <rohit.ashiwal265@gmail.com> wrote:
> > test_path_is_file "$1" &&
> > 	if ! test -s "$1"

According to the conditional if the path is not a file then we will get
the error "file does not exist" and then we will shortcircuit without checking
the second conditional, on the other hand, if path is a file then we will
again check if it has a size greater than zero, then error will be different
(if any).

Regards
Rohit

