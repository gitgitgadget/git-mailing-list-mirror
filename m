Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A3F6920248
	for <e@80x24.org>; Wed,  3 Apr 2019 14:38:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726462AbfDCOiR (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Apr 2019 10:38:17 -0400
Received: from mail-lf1-f49.google.com ([209.85.167.49]:46204 "EHLO
        mail-lf1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726151AbfDCOiQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Apr 2019 10:38:16 -0400
Received: by mail-lf1-f49.google.com with SMTP id r25so11883921lfn.13
        for <git@vger.kernel.org>; Wed, 03 Apr 2019 07:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=aMgbnFKVuepeU/v22WLmYcN0wLDZaVc6wDiyTlqblY0=;
        b=tRegudten62JW6hpEkxxwsVge/hioE01rf71CON0vq2rpZUYPOvja697bjFAZ3uuY0
         DSF6VMNOrfsxwST3cPBLPVWlXvt1iat1CNSczy0A8AUugl7fdDmxz4ngkmceiT0fH48r
         NMjkyCL20bA53R3Py0kJPjzab+a1fz5ccrjZ6PM4eiLk9u44irkN3h1gjJsOF/4CllQh
         NF8m5IbUNnWPXslgQI9UkJhjJy7KalvvNobXIy3I3xrS3/w+fY8rfqj+9bY8tQlIWezn
         JoPxqxSg+ljvJ6BQMES6I+xLaNGVxxcMAzNVj+vHa2i35pfDdyDrrgH4M6JTroApqTVO
         B/mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=aMgbnFKVuepeU/v22WLmYcN0wLDZaVc6wDiyTlqblY0=;
        b=Ha/rwEFKLKwA0f/KSMMvHlPctTq0g4veFfTlrusuuDs1oGSRfqT2J702yv7o1oQYOz
         EdOGiOVBYxk/3+2pPMullZKwPI6iLmqw3a1RoRrS5n2DXxnPitjVy4JlLmRNti0gKWjI
         AhbUUyEgVqSyYsGRsDsbDPEUL5isxrQ0fmW0wqHMFndD8lIzjekd7r2qktVJgtsu8jLO
         W/VZJxPt2I+Y8g/clxEeEgJILMBwhWE6xKI3Obsoxljl3XxPPBmPpT35A+MsEAp9YRrb
         peBkOOmXoKU649c5wxt9rmWa3aqNQtlM6psP/UzF3k+UmmzzozcNLnvb5d471V5YP7yj
         8jsw==
X-Gm-Message-State: APjAAAUm3VBx+NcZL78P9qFmeCP/Crrm4GOYhmc/jYQyhmn/wlKVWtsv
        mefbyNDa0DLQ9GchmcvB0G9E2lYpzYjeUhEet61TZg==
X-Google-Smtp-Source: APXvYqyYFx5s2ZWttoMpXCCmRlEa5bF8f9+AnbAX0ZIWs9lHdQtaUDZ2MMycN752/qLUtG4LIvQ2dN09/OVW0J5x7LM=
X-Received: by 2002:a19:ec17:: with SMTP id b23mr67844lfa.76.1554302294729;
 Wed, 03 Apr 2019 07:38:14 -0700 (PDT)
MIME-Version: 1.0
X-Google-Sender-Delegation: rcdailey@gmail.com
From:   Robert Dailey <rcdailey.lists@gmail.com>
Date:   Wed, 3 Apr 2019 09:38:02 -0500
X-Google-Sender-Auth: dgsOnP9weZPpOiF-cTjlEUIt0Ec
Message-ID: <CAHd499BM6M+=zRE1WFVXr7b+VhJHFeDind5xLqXcwZLv7QeDvw@mail.gmail.com>
Subject: Feature request: Add --no-edit to git tag command
To:     Git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Similar to git commit, it would be nice to have a --no-edit option for
git tag. Use case is when I force-recreate a tag:

$ git tag -af 1.0 123abc

An editor will be prompted with the previous annotated tag message. I
would like to add --no-edit to instruct it to use any previously
provided message and without prompting the editor:

$ git tag --no-edit -af 1.0 123abc
