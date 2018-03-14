Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 89BAD1F404
	for <e@80x24.org>; Wed, 14 Mar 2018 16:56:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751976AbeCNQ4J (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Mar 2018 12:56:09 -0400
Received: from mail-pg0-f47.google.com ([74.125.83.47]:45427 "EHLO
        mail-pg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751588AbeCNQ4I (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Mar 2018 12:56:08 -0400
Received: by mail-pg0-f47.google.com with SMTP id s13so1603201pgn.12
        for <git@vger.kernel.org>; Wed, 14 Mar 2018 09:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:content-transfer-encoding:subject:message-id:date:to
         :mime-version;
        bh=V5R8mAwicn+jwUsl3aPqrCt+B9i39tequyAudxU9YlQ=;
        b=h4AUbniodAnn3KqgkYjWc1LYuZCpmkJ3W/OxqpXjWX/vLURPkIQM3BbQdLh+KAUd60
         ypyoR6jMdD7VcYQTdU4xdLolfD3e8FcvuPlmEVd6KyVR4VR9JaamzRt2V1QmhIzQoDQg
         szWnM5+AG99U7RTIuoZe6MLL+EWh/xb0xCvtJFb7o87UuqPe8BHfZpxVtSQnNrg7kA8N
         xscXQEjAp3+VShOBnlRZbQ9PSfAlIChDQitjTjHY1BOBze6iMOXVrxy/nbPEW0/sIulU
         pIKmeR1L69H4GmDprfc6mA51g9U8jFh5IU9lCa4UrUv6p6mMgI1693JphUGZutXwDaQ8
         CpRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:subject
         :message-id:date:to:mime-version;
        bh=V5R8mAwicn+jwUsl3aPqrCt+B9i39tequyAudxU9YlQ=;
        b=hM8l9V+ZtDHlaZCio9ph5ZHDJesIegyS/gm0CJrka18Ford/esELJFN4IH1EgIRgnC
         Uy5X4rjjqc58vZ+tP4NPfRSis4OMB/aS7mILGn/pneHLg38zE4zuIRUPnHpOulP1Vilt
         /+yZcUiD9afog+HDyBHE5YDeZ88uGG/0OiDsxNXWUoAUuRw6e6HF9+m5IQwEVYjy5XcY
         JOGHD/4A5kxm3y9aJf95zHXT/ew+5Pua5pvC/PyOnFnmSg2s+rL0Ii16ao63+6CjB+3t
         w2ick8NnZrpSHN42YSdBBxivS9tslBus8Nt7CtqAj2xzKU6iL1uIWg1pVriUNRKfXFkg
         ZDdA==
X-Gm-Message-State: AElRT7F8RwU6V/OZpBbBNrz4lcRrK92LIR6P9GeLSfabkJuJ2+/OPt1J
        8XTqSO74Kh//Zn2p9yh6p7QuStcd
X-Google-Smtp-Source: AG47ELuq1EgxJu9ldime6icPbUgY8Yr60x59pv0Fsl67KD9x0uXgWusvCRY45dnmNNNb18LOOyKy8A==
X-Received: by 10.98.242.6 with SMTP id m6mr4923727pfh.230.1521046567789;
        Wed, 14 Mar 2018 09:56:07 -0700 (PDT)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id y3sm5464915pgc.81.2018.03.14.09.56.06
        for <git@vger.kernel.org>
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 14 Mar 2018 09:56:07 -0700 (PDT)
From:   Lars Schneider <larsxschneider@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: How to debug a "git merge"?
Message-Id: <7895279B-9FB6-471B-A8BA-53315B265A51@gmail.com>
Date:   Wed, 14 Mar 2018 17:56:04 +0100
To:     Git List <git@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I am investigating a Git merge (a86dd40fe) in which an older version of 
a file won over the newer version. I try to understand why this is the 
case. I can reproduce the merge with the following commands:
$ git checkout -b test a02fa3303
$ GIT_MERGE_VERBOSITY=5 git merge --verbose c1b82995c

The merge actually generates a merge conflict but not for my
problematic file. The common ancestor of the two parents (merge base) 
is b91161554.

The merge graph is not pretty (the committers don't have a clean 
branching scheme) but I cannot spot a problem between the merge commit
and the common ancestor:
$ git log --graph --oneline a86dd40fe

Can you give me a hint how to debug this merge further? How can I 
understand why Git picked a certain version of a file in a merge?

I am using Git 2.16.2 on Linux.

Thanks,
Lars
