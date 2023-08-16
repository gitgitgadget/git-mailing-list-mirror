Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC39BC001DE
	for <git@archiver.kernel.org>; Wed, 16 Aug 2023 01:08:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240928AbjHPBH5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Aug 2023 21:07:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240933AbjHPBHg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Aug 2023 21:07:36 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 810972128
        for <git@vger.kernel.org>; Tue, 15 Aug 2023 18:07:34 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-584034c706dso65815057b3.1
        for <git@vger.kernel.org>; Tue, 15 Aug 2023 18:07:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1692148053; x=1692752853;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6/V8mmOHABYkJJFSp7mNOTRNXohQaDruW16VARxFxf8=;
        b=LP7/z9JMu2zzBNoND9Zf9sdniaytKes51oGquDoHRZjoxVeoGubM+/OjPVdFqpML6A
         sIX0uYe/LL8l0qvemLwZoKxk0b3MdXitxaSE3XQ7rjS7j6fmkKmFj+17XGQGZ3HyqV36
         TqxcPeBhBFQsPRcfroGBvYiREVjaWqspi9zmkQkBP9NCXTuRezautwKQVWsyZf7Dv5wj
         c1+n9VeK8ta06VI0i/ze/Mitz2mnV+r3chW5m+xEvkyaJ9E7le7m84qFqiNTbFkDfiNy
         fHb/tbWlRF46yUjsCf+4+aSgSBsoKd/Nctd943ndmel2sfdvx8qxfHHJOlrr9xWTmUHe
         g3BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692148053; x=1692752853;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6/V8mmOHABYkJJFSp7mNOTRNXohQaDruW16VARxFxf8=;
        b=Y7Tu7s8TGePaam2tjNtuli0oxx+k20N7PCwndcdLa4HEICIIhdkbajpgg2grwAsOrN
         YL9XgWiKVJF7Aboa9amVhS/kvAAEJ7fX5dmX+KQ4w+OkgaUCFE2frUNIalXZGQYeopxq
         3++Lg2AaIMon2DAbR5G6WcmhUcdS7tvpztWD+z0dul1nnMtpprgeMQzDe+zqKnrNkEcb
         zvHLDR0eXaX7dDy4mdVEzlArZopxBCtwF+svMj7p8PaXo7hneNPzjk2bllpl5w4qg/W/
         85VeNBqG5CJdPoYFoEB5jmAebZFmsb887O0BopXUTfG3qBaupUWc62gRzIikliQSLcHb
         eHFQ==
X-Gm-Message-State: AOJu0Yyqzr7JMfPW719MZZto4YOyyAfh7Iiqs6puYxOGZiRDPhshzHjy
        hkko+B3UeGsmwqGzOiMr/d5RfzesHeXP4QE1emwbqw==
X-Google-Smtp-Source: AGHT+IFgkrreQXuPZjcacUgqLKdmvip8x7WYrIGtYZBBWq3K3NCTEi5WAm25x/cvKpelWBYoMzcK6g==
X-Received: by 2002:a0d:d9c3:0:b0:586:ddc:eabf with SMTP id b186-20020a0dd9c3000000b005860ddceabfmr298283ywe.37.1692148053495;
        Tue, 15 Aug 2023 18:07:33 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id ey15-20020a05690c300f00b005837b48d16csm3698884ywb.84.2023.08.15.18.07.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Aug 2023 18:07:33 -0700 (PDT)
Date:   Tue, 15 Aug 2023 21:07:32 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Christian Couder <christian.couder@gmail.com>
Subject: Git in Outreachy? (December, 2023)
Message-ID: <ZNwhVOggObU7aVTr@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian and I got an email from the Outreachy organizers asking if
the Git project is interested in participating this year. Last year we
submitted projects, but ultimately did not select anybody from the
program.

I think it would be good to participate in this year's December cohort.
September 1, 2023 at 4pm UTC is the initial community application
deadline.

If we're interested, the project submission deadline is September 29th.
By then, we'd need:

  - Volunteers to act as mentors
  - Updates to our applicant materials on git.github.io (project ideas,
    as well as potential microprojects).

If folks are interested, I'd be more than happy to answer any questions
about participating, and overall logistics of the program.

Thanks,
Taylor
