Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A9C081F404
	for <e@80x24.org>; Tue, 13 Mar 2018 21:42:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752173AbeCMVmj (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Mar 2018 17:42:39 -0400
Received: from mail-lf0-f52.google.com ([209.85.215.52]:39776 "EHLO
        mail-lf0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752054AbeCMVmi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Mar 2018 17:42:38 -0400
Received: by mail-lf0-f52.google.com with SMTP id f75-v6so1679077lfg.6
        for <git@vger.kernel.org>; Tue, 13 Mar 2018 14:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=6j3I8QYvmFTYVW4lUxTIIwxYSBOILXFTYH1snM6ARao=;
        b=YklDZr0ucBqtrdy9I7xlB7u61weh90/1i2rnc+MENP24MKUBtOYMXY1K8PT/yHz052
         RL3F3LRrgci1s4yyHaB6XYcPe/EhNZ+Nz9Z8T4R2wvCO+WH+KQGWoy3vZCYgBa6yZ508
         yQe157Xa+9UDt84JrQOlFJFGmYaMeePEmRNwUXlVRFcyezfdQZrUawze2HCfzPLKmahp
         Oz7lbURMoa1FM5yXZu+Kih9N7zUtTrMGaeVZTBkKjlUIHKbrxjJqGLvfBZtFmnD7gPY1
         csuT5kiMJHRKuW+2sOYEEcWN6o1gy4Uc4wvUpVNzc2pYIElLDStdaIBV7zs1WK8MGqkc
         4ZYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=6j3I8QYvmFTYVW4lUxTIIwxYSBOILXFTYH1snM6ARao=;
        b=iw3CnyrDeuNhjFKJQ93Ni4pvCk+lOa7YuIn0bqXF8YFOp9ca9aHpqy8YDpGi5PeA/w
         eOBoiM+d5jUGbrHTTIZLDmsJ1OXFwYKdlwZC6ZrEyI7NXid/SBagZA/VRBGFiZBtELmw
         6uvxbit8/6bx5rKEY7VVB7j4lpOVaXuXMxbUEFxDz8Y3DBU9NyGVuTS3GPGDiMp8fsID
         eny4OZRgLrA08FMhfPVVc/SgIvKW3FJlc+CbE8XCxveW2+Bx6ccn16/x4y78sXDi2gY5
         fq1xlprWG0FFtBmvnYctHVGK1ur6joXmp9m0PEVhRClOOqk4giFv9/tzbKFngAjd3JG4
         4vbA==
X-Gm-Message-State: AElRT7GLO7gPSNYn/A/WAOORSvKF0luuE2eobCoRKZtz/mR/2SVDCgWg
        WSmzArJSI1AzRfWREIQwni656joRSKZ9LoDu6E0REQ==
X-Google-Smtp-Source: AG47ELsNWz4Q0RkPEK8StPBnakEfoJPFbpHTODOL8qxIpus/gkwYJFjbfN1sR24SN8FIpteP0hdliHD/QDzbcSHLvV8=
X-Received: by 10.46.128.214 with SMTP id r22mr359433ljg.51.1520977356889;
 Tue, 13 Mar 2018 14:42:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.46.88.26 with HTTP; Tue, 13 Mar 2018 14:42:36 -0700 (PDT)
From:   Alexander Mills <alexander.d.mills@gmail.com>
Date:   Tue, 13 Mar 2018 14:42:36 -0700
Message-ID: <CA+KyZp6QZ4BmOtLFiByjmZ4NsZyDBFsqme64aT5ER-QpgD49pg@mail.gmail.com>
Subject: git-log bug: --grep and -number args are at odds
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

$ git log -50   ###  I get 50 results

$ git log -50 --grep="*"   ### I get a lot more than 50...

shouldn't `-50` minimize the results length to 50 or fewer?

-alex

-- 
Alexander D. Mills
! New cell phone number: (415)766-8243
alexander.d.mills@gmail.com

www.linkedin.com/pub/alexander-mills/b/7a5/418/
