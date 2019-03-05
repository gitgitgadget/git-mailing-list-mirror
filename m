Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	GAPPY_SUBJECT,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E73A20248
	for <e@80x24.org>; Tue,  5 Mar 2019 14:22:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728351AbfCEOWY (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Mar 2019 09:22:24 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:38286 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728347AbfCEOWY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Mar 2019 09:22:24 -0500
Received: by mail-pg1-f195.google.com with SMTP id m2so5738023pgl.5
        for <git@vger.kernel.org>; Tue, 05 Mar 2019 06:22:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HFqtM8POoGJSgumLIYRLnVaiMH2Km46lwRaFyTIFYqs=;
        b=e/6Lf2IXYbkwHosq4w5KOo3mTOqRn1spJoQ67n65R9cI5RTinuGDXd19DS9nZQ96y8
         GmV7OH6NcMW332E9XH0PrMQjRbxyVL1j/lJedAaq31kvOjNrPJvgVN8oCTqelXyBoybC
         u4KJLYTR2nFazoFTGxUS3c24X2CNNTbyponqmroWiu2yTqi9BCKxnA+kS5UnsJGse4y+
         bt2a4Ksu/zTmfnD1Tse3v25ZCZpupi1v1xLM02ZGzZUwDfPhucs/rtd0AonVkgSqj6Mx
         1FWomocGfqB1/oZVb96MI9nhSXY8b9Y4re7oYXi068U9KQAFje9mPcMgmE85SDYgLp5/
         RBRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HFqtM8POoGJSgumLIYRLnVaiMH2Km46lwRaFyTIFYqs=;
        b=uTksGz80ikT+FOaUebjPfp3Dyt8IChd4WyFtOUCLakEFZzYzj0BmH0/sR9utDenvXM
         xMik8TF+oBtogJYxn+qxAGRai03OOPAwtZorUBNw/JgAWCSKX0Lg/eq5Wb2nzFg4SVgl
         uH4WMTigzNKmjxLLvHr68rfNVrA/0Bc5/1ozt4jmcryo7zIDPNg73pFNcxWMOfVJvVVQ
         23TzMHw0N9rhoxn3z9qKsphPTmcdpRA363kPcL24P8nTb7lPfQ6g3pBhL6/Sqr10A8Oz
         Xqs39vzyyEMB/kRgxiOfhLp7QyG0bBNdywJ+cCns678saSRQ2diRUiu7tlLbJnwjaNxp
         MneQ==
X-Gm-Message-State: APjAAAVzoZVAuS9fsRh2rvRrhTcpRn9r93b6RimaWmrTEUVAa0vzWi+X
        6gmg5HWRXJnest36t5xno4k=
X-Google-Smtp-Source: APXvYqwG6Bj3fqiEL1FkuVroDPcThiA6BQfaBX0DmWWtCCl3y+bEmfpexg1NkyU5YRPzHLxyfruOhQ==
X-Received: by 2002:aa7:8497:: with SMTP id u23mr2088457pfn.253.1551795743232;
        Tue, 05 Mar 2019 06:22:23 -0800 (PST)
Received: from ar135.iitr.ernet.in ([103.37.201.80])
        by smtp.gmail.com with ESMTPSA id k10sm16499599pgp.91.2019.03.05.06.22.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Mar 2019 06:22:22 -0800 (PST)
From:   Rohit Ashiwal <rohit.ashiwal265@gmail.com>
To:     sunshine@sunshineco.com
Cc:     Johannes.Schindelin@gmx.de, christian.couder@gmail.com,
        git@vger.kernel.org, gitster@pobox.com, rohit.ashiwal265@gmail.com,
        t.gummerer@gmail.com
Subject: Re: [GSoC][PATCH v2 3/3] t3600: use helpers to replace test -d/f/e/s <path>
Date:   Tue,  5 Mar 2019 19:51:49 +0530
Message-Id: <20190305142149.13671-1-rohit.ashiwal265@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <CAPig+cR3b=jk4W=9SF4XJQyqAfFHiG8MduypD75RL1=T_qY0Hg@mail.gmail.com>
References: <CAPig+cR3b=jk4W=9SF4XJQyqAfFHiG8MduypD75RL1=T_qY0Hg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric

I was asking if this patch is good enough to be added to the existing code? Does this patch look good?


Regards
Rohit

