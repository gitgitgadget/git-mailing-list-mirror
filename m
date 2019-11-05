Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9A44B1F454
	for <e@80x24.org>; Tue,  5 Nov 2019 15:41:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389871AbfKEPlH (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Nov 2019 10:41:07 -0500
Received: from mail-vs1-f43.google.com ([209.85.217.43]:43662 "EHLO
        mail-vs1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389507AbfKEPlH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Nov 2019 10:41:07 -0500
Received: by mail-vs1-f43.google.com with SMTP id b16so7557331vso.10
        for <git@vger.kernel.org>; Tue, 05 Nov 2019 07:41:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=XQSawSadpfiiHRH00ZgAH0dIVnjz4xYWFGifa00CE8U=;
        b=ORwkXg3ac8mUABHZyG7c1KCrJ+gnaH3ATFajuHYZtBH+E45zi/7/eNoilcwGxFRTQJ
         QXg7C50uXHSBI5SBrD1HZr/spd8Ri5hcljXJ+ZMb5Ksw9aE2jtsrTYzYVAPPSqqQYwVw
         DK4CMn/G/uj7qWvFdeaVGQKPcA0FunplcmJiFHtO6GpeO4KirO+vGhFWf3w0B/qZYelv
         ZhxQEkoTTUzoFstlFcdOLczuS3YTJeeF/q7yiuZ23ibq2ZXomhDNg+D5WBGdmq+4YSXz
         OL7dDxQToDAFEf8w1Rn9GdLj8Y6FRzW9YdtIsiBD3C7cxwnF4wQwqHdcH27WA7Id3tcj
         xnqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=XQSawSadpfiiHRH00ZgAH0dIVnjz4xYWFGifa00CE8U=;
        b=hx6kqWlR7RUfoLx5QG9GWaMvRD4cFgU5VDBLghTvvOmoPQysGt1xQsdAVTUJ/PxX6b
         wQj3c1o3RHywOtU0lDf/WvPdUhu/CGPdHG8KW01cWUj8fvHfvFOr6UmR+JNhLfmjrk+3
         MDXMI5DE8y464wlxpXLLDOXIPp8M/bgcOqQNZHmu5o52EB4nTXElyrWq1vK9ImcEAKv6
         ERV4l99VCBwF3P1r5FpQHv8AW0Hni+knPqwFmNEkc+gaOvFNGidVJ3o0eorQaC3Gi6r+
         96woHYj843U49BiAJpCFLvvd0eR1tgJz3s5SKzHSB6+68JrJMkYr/soCvMJIWqq2DgyT
         qMeA==
X-Gm-Message-State: APjAAAX+UVWHO4lqT4t445s7081ghzhdhWP0L38npQC5P+vvDtyz6HzY
        JtsqPVZ7LPMFj69bumdpMFNX2kcJInHTAbDHhJ2YB3Y7JGYR/Q==
X-Google-Smtp-Source: APXvYqxavUzAMRSKpAxn7S+UbZpFo4QmwTnOsxzXtxfeREHn0V+54Ma/FW1mA6be437GR2HA7ng0st1e2bp2JtVHPiQ=
X-Received: by 2002:a67:ef0c:: with SMTP id j12mr8153838vsr.201.1572968464800;
 Tue, 05 Nov 2019 07:41:04 -0800 (PST)
MIME-Version: 1.0
From:   ryenus <ryenus@gmail.com>
Date:   Tue, 5 Nov 2019 23:40:53 +0800
Message-ID: <CAKkAvaz=xpMpVqCxOMT+b-cUNKdcNdC_4FVkfAVTRhP1cODp0g@mail.gmail.com>
Subject: commit-graph: avoid message Computing commit graph generation numbers...
To:     Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

After setting fetch.writeCommitGraph to true, the message
> Computing commit graph generation numbers: 100% (2/2), done.
is always printed.

IMHO this is internal to Git and probably NOT necessary to print by
default, if really necessary, maybe an option can be provided
to turn it on. Thoughts?

Thanks
