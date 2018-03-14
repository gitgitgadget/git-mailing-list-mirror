Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 93BC41FAE2
	for <e@80x24.org>; Wed, 14 Mar 2018 08:17:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932721AbeCNIRu (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Mar 2018 04:17:50 -0400
Received: from mail-pf0-f180.google.com ([209.85.192.180]:41729 "EHLO
        mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932600AbeCNIOw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Mar 2018 04:14:52 -0400
Received: by mail-pf0-f180.google.com with SMTP id f80so1077354pfa.8
        for <git@vger.kernel.org>; Wed, 14 Mar 2018 01:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:content-transfer-encoding:subject:date:message-id:cc:to
         :mime-version;
        bh=obPWOejNIWc4nVcb51VsM88zAOGFnQ6POAwAN0ht5t4=;
        b=VLDVKvip0xQCuCQWMcsAFS+knuf2D5g2GZyerRat4mcBME4fdtzEctioTkq5IUEUA2
         TFGDEOg7BHKQbNd+SDFFqlk3IJK0SKP6ZPTlpBd8p3EG2lCZIyh9pNbS1M8kfRlMKsTR
         VEbuyK6XiwCvRw+9L+gbC3tLXjTnkzzwY77Xd+m2oUmA3K94Pg7Bav4a6YTSAM70QvRh
         u0d1aVvTcCjQ6XgX2reNDGwSQvNeY1wY4zZpvBWJGZN8iQSI1bI1HFaXIKy+rHR5lkj0
         FXtEg/PA10Rjn/OJtXSSmfZWpx71IWJ0EAVpTLUfzuP6cwGVtymfzFSvdVT0qJtwdAsp
         HfqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:subject:date
         :message-id:cc:to:mime-version;
        bh=obPWOejNIWc4nVcb51VsM88zAOGFnQ6POAwAN0ht5t4=;
        b=ThHiaOvySVFRZDpsRW5qD9/wcu2Qqu+K0YLg7nF9K8QZEl1+XOWuHr5+haO7db9S2l
         FGVeyUE4finkHdg2o0xrrapvV952Xh9W3kJJ8heBS3I+jtrLvHIla6kXXYsgceiP/hlM
         oVDexJ6hmLFj+WZLi/Udep0BQBOLh+pw6XoDZUb7eKyEK5kBcRxo/fMRGxBPXleUDbGj
         m5VcAXl9I1ubzOtCLzlxYShOi7NO+2lvctYWaAVwZhGXoCsjS6grI4K5CJIpwDdE3e+9
         qqM8CXuG7sHA+0gwo41j7NXYtjRUW4KXUFDMjNK48owLVevoR20O4ZvLt7XPcahDxUcW
         o4gw==
X-Gm-Message-State: AElRT7H6ZLC8uBv4k9EmOj8B+5KkznRtRWN6WLx6fy7bA8Y9Ylm11k96
        2qoAFBxNbpqCaZUDRBRrwPVz8rEl
X-Google-Smtp-Source: AG47ELuRre4JFJU+tUStWJRDESKn0KmvRW5tK9J8AMWEk/v6+KZe2p24OQY8nzqmppT6Fg1cTmzWZg==
X-Received: by 10.101.69.4 with SMTP id n4mr2967290pgq.184.1521015291136;
        Wed, 14 Mar 2018 01:14:51 -0700 (PDT)
Received: from obe4l5qp12.ads.autodesk.com (adsknateur.autodesk.com. [132.188.32.100])
        by smtp.gmail.com with ESMTPSA id j23sm3596820pfi.78.2018.03.14.01.14.48
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 14 Mar 2018 01:14:50 -0700 (PDT)
From:   Lars Schneider <larsxschneider@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: [git-sizer] Implications of a large commit object
Date:   Wed, 14 Mar 2018 09:14:46 +0100
Message-Id: <953C263C-6ECA-46AC-849C-8D1A38378654@gmail.com>
Cc:     Michael Haggerty <mhagger@alum.mit.edu>
To:     Git List <git@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I am using Michael's fantastic Git repo analyzer tool "git-sizer" [*]
and it detected a very large commit of 7.33 MiB in my repo (see chart 
below).

This large commit is expected. I've imported that repo from another
version control system but excluded all binary files (e.g. images) and
some 3rd party components as their history is not important [**]. I've 
reintroduced these files in the head commit again. This is where the 
large commit came from.

This repo is not used in production yet but I wonder if this kind of
approach can cause trouble down the line? Are there any relevant
implication of a single large commit like this in history? 

Thanks,
Lars


 [*] https://github.com/github/git-sizer
[**] I know some of this stuff shouldn't be in the repo in the first 
     place, but I am constrained in the things I can change.


#######################################################################
## git-sizer output

Processing blobs: 543782
Processing trees: 517104
Processing commits: 43365
Matching commits to trees: 43365
Processing annotated tags: 3
Processing references: 123
| Name                         | Value     | Level of concern               |
| ---------------------------- | --------- | ------------------------------ |
| Overall repository size      |           |                                |
| * Blobs                      |           |                                |
|   * Total size               |  18.8 GiB | **                             |
|                              |           |                                |
| Biggest objects              |           |                                |
| * Commits                    |           |                                |
|   * Maximum size         [1] |  7.33 MiB | !!!!!!!!!!!!!!!!!!!!!!!!!!!!!! |
| * Trees                      |           |                                |
|   * Maximum entries      [2] |  6.84 k   | **                             |
|                              |           |                                |
| History structure            |           |                                |
| * Maximum tag depth      [3] |     1     | *                              |
|                              |           |                                |
| Biggest checkouts            |           |                                |
| * Number of directories  [4] |  21.9 k   | **********                     |
| * Maximum path depth     [4] |    18     | *                              |
| * Maximum path length    [5] |   225 B   | **                             |
| * Number of files        [4] |   256 k   | *****                          |
| * Total size of files    [6] |  2.08 GiB | **                             |



