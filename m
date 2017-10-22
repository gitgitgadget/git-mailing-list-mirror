Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C465D202DD
	for <e@80x24.org>; Sun, 22 Oct 2017 14:25:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751174AbdJVOZE (ORCPT <rfc822;e@80x24.org>);
        Sun, 22 Oct 2017 10:25:04 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:52066 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751003AbdJVOZD (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Oct 2017 10:25:03 -0400
Received: by mail-pg0-f67.google.com with SMTP id p9so9881927pgc.8
        for <git@vger.kernel.org>; Sun, 22 Oct 2017 07:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:in-reply-to:references:date
         :mime-version:content-transfer-encoding;
        bh=+NjLuW5TuvyHDxqOXpBPy9QgMEjKCGRIA36aVGr99qo=;
        b=ljDkCliix+B3CnDeZKFd5VH9wumyzfLZ+vxNypEznVfI1RkdVkH26cBvimipk2np4E
         aiorTr7prhxOp28RHIkAcJHYfyvGJhAy3X2XO/ShjiA2pY9kbjdF0pt1tKUDsQh6fnzP
         V8DnOlmrmKA/cj08BMsdYT0nNnFn8hLeT+oW3xgMo9DnwjpufrSb3ZNDIG0YrpbbjUNJ
         dbIB4rqCUkb5k4IEs9xVn+7GFPK5yfnoC6PDLG3ywfMWGwbPJlc3CrEkPr+MuiRcVsQ5
         S3zGcZ4o440wW/Ce64xFTKKQLThT7QR4r/5w0yRysEs6T9N5CWeH2hmcAKSrKR9c7Cv1
         +d1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:in-reply-to
         :references:date:mime-version:content-transfer-encoding;
        bh=+NjLuW5TuvyHDxqOXpBPy9QgMEjKCGRIA36aVGr99qo=;
        b=GXNMFiHzdm2qPSdtIrKoE4rpfNJJGsCIgRbcpmJ6WuXlx4xSRQk9rdAyy5ZDa8vNN9
         z6WGbmgOnT5B5xocQ8eLWcIVbE07wHvFBwEWcHYa1zETxZ7q4CDW3fl8AsdX0Vno0rZp
         EZvdJw62LdlG720bN1+DUaHnSP+ZaskVH8OdrsGu88NRXI5Opq74pUwqqo8eMq12WJ99
         EONuBU7AsULhT+iyU0MUVI8hfKGBfk1pEyudQFbYXqu5ERoLcCAdqrbDof3f6rsygB52
         0pZVUzu2ND8j1CXzKC3gNJSJyPZZ/v43ykatFEEkQ3dOb/yKWRZmVcV72dIQbBoFbbnT
         qruQ==
X-Gm-Message-State: AMCzsaXuAcBzt0f5qRBb35WG+ExWSjKto2KTbDidPLxp18f7oKRtGkkc
        9lzGCS5FqqZAe2pYzAczYIg=
X-Google-Smtp-Source: ABhQp+QN/PQDPfTQ6PG/M0PBm12shTli0HCvDBWrpZyDcoC0J1W8v26cis0LCtOLxRXclsEtm/CPWg==
X-Received: by 10.101.82.76 with SMTP id q12mr9350549pgp.140.1508682303210;
        Sun, 22 Oct 2017 07:25:03 -0700 (PDT)
Received: from unique-pc ([218.248.21.162])
        by smtp.gmail.com with ESMTPSA id l5sm9366376pfi.165.2017.10.22.07.24.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 22 Oct 2017 07:25:02 -0700 (PDT)
Message-ID: <1508682297.6715.15.camel@gmail.com>
Subject: Re: "Cannot fetch git.git" (worktrees at fault? or origin/HEAD) ?
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
To:     Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Duy Nguyen <pclouds@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>
In-Reply-To: <CAGZ79kaeJsahVuWgFsJfyGahciT4xBeM3m59F5crGy4+ZRJMCw@mail.gmail.com>
References: <CAGZ79kYP0z1G_H3nwfmSHraWHMBOcik5LepUXKj0nveeBrihiw@mail.gmail.com>
         <20171020031630.44zvzh3d2vlhglv4@sigill.intra.peff.net>
         <CAGZ79kZc+O9gM97bVZETE3sgkmc-t78Nf_Hq6=K4Gf2yaE79zA@mail.gmail.com>
         <20171020060443.l6v74ik4v4jdt4ky@sigill.intra.peff.net>
         <CAGZ79kaeJsahVuWgFsJfyGahciT4xBeM3m59F5crGy4+ZRJMCw@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-15"
Date:   Sun, 22 Oct 2017 19:54:57 +0530
Mime-Version: 1.0
X-Mailer: Evolution 3.22.6-1+deb9u1 
Content-Transfer-Encoding: 7bit
X-Cyberoam-smtpxy-version: 1.0.6.3
X-Cyberoam-AV-Policy: default
X-CTCH-Error: Unable to connect local ctasd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 2017-10-20 at 13:45 -0700, Stefan Beller wrote:
> 
> The git-test from Michael sounds intriguing. Initially I put off using
> it as I had my main working dir (or rather test dir) on a spinning
> disk, still. Now I test in memory only, which is a lot faster, so I could
> try if git-test can keep up with my local commit pace.
> 

Excuse my ignorance but I don't get your statement correctly. What do
you mean by "I test in memory only"? How do you do that?

---
Kaartic
