Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7AD1E1FF72
	for <e@80x24.org>; Fri, 20 Oct 2017 07:09:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751879AbdJTHJn (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Oct 2017 03:09:43 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:51431 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751583AbdJTHJk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Oct 2017 03:09:40 -0400
Received: by mail-pf0-f196.google.com with SMTP id n14so9761897pfh.8
        for <git@vger.kernel.org>; Fri, 20 Oct 2017 00:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:in-reply-to:references:date
         :mime-version:content-transfer-encoding;
        bh=4bh8CN1NaEzwnQIGF2I5+vkgMvrQ8hqHapDPCNwyFqU=;
        b=slhgpHXkS2aYB41/LkjgVCgRywUrEutjp/zHOObR0M/SvQmqxgVQnXisDMmRJJF3Uh
         K9f6xfAqbayJ2oWjfgBPVyZp+Yx4/RagZD6VTiWQA8fSGBbGhAlE2JJVtRzmysk2z4sv
         hh84yFDWCPyeNakAEhYZ1RfzvCz9h9Qt2ico31kMRYeg0AMobpylqwIOjpYmSE3bCIYI
         1nxc5onhfeWSxaB6kFyMDHGNghK9VPTwqg/sU6jGwD8xvjx61jnbGuzmX86o0UU5Du+o
         BPA+C8qd3bstcJ70t1QvblUYCr9mrioN0dv/OFHAogQd5/RSGeLQaSAQY3oXmjHgxMvO
         N1xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:in-reply-to
         :references:date:mime-version:content-transfer-encoding;
        bh=4bh8CN1NaEzwnQIGF2I5+vkgMvrQ8hqHapDPCNwyFqU=;
        b=M10bG0KkwUWm1kVOTFwvRIdSuIYU1Mvcz5wk5eO1Xx0EYWe1YMh1sATL3egAYvW+sD
         YmdCluUu0u2a4g/3eQ3xpjxZLU/GARQnXOwfRrXZB80wg4qbRX2844wYGhYSfsN4BXIQ
         lqGbEBAleD2YN/ImBxefza2/LeKkAc0O1S2n8qd0YhIHrpTD1Slx+FHTzQdCicB8EeJM
         c2Amf8Zd312ZmrP2s/RiPmDOKlzG4RcentabySC4PCaOOsKL7qiVI8J/qVmYCGNDlIFk
         sKo5RrjaeKOn0noDl8maI2J4YywhObpTDa9Yp5E7xXVFyKEenwUM5IbQJ1dxFGC/pxKf
         oa/Q==
X-Gm-Message-State: AMCzsaWJN4E/9wnaLhnf04xlJEsAEghXdVbG2v5GvjYwdupPun+h75qm
        dERW5YIaofEdO+BTDtMdiFLyIJ/n
X-Google-Smtp-Source: ABhQp+TCcM1BffCrbkMs1RUBFUze6/3nLHV1it0EsGMkq5xwW3OchLiXfL//qC0J5SmEWTtVeDnCrw==
X-Received: by 10.101.86.196 with SMTP id w4mr3665501pgs.335.1508483379954;
        Fri, 20 Oct 2017 00:09:39 -0700 (PDT)
Received: from unique-pc ([14.102.72.147])
        by smtp.gmail.com with ESMTPSA id k7sm678208pgc.4.2017.10.20.00.09.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 20 Oct 2017 00:09:38 -0700 (PDT)
Message-ID: <1508483371.2601.8.camel@gmail.com>
Subject: Re: [RFC PATCH v2 0/5] Give more useful error messages when
 renaming a branch
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, sbeller@google.com
In-Reply-To: <20170925082024.2691-1-kaarticsivaraam91196@gmail.com>
References: <20170919071525.9404-1-kaarticsivaraam91196@gmail.com>
         <20170925082024.2691-1-kaarticsivaraam91196@gmail.com>
Content-Type: text/plain; charset="ISO-8859-15"
Date:   Fri, 20 Oct 2017 12:39:31 +0530
Mime-Version: 1.0
X-Mailer: Evolution 3.22.6-1 
Content-Transfer-Encoding: 7bit
X-Cyberoam-smtpxy-version: 1.0.6.3
X-Cyberoam-AV-Policy: default
X-CTCH-Error: Unable to connect local ctasd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

What happened to the v2 of the patch? Has this not received attention
or is there anything that's not done correctly?

-- 
Kaartic
