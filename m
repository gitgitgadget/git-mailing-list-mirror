Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C5F431F42D
	for <e@80x24.org>; Fri, 11 May 2018 06:39:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752126AbeEKGjl (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 May 2018 02:39:41 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:53265 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752043AbeEKGjk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 May 2018 02:39:40 -0400
Received: by mail-wm0-f66.google.com with SMTP id a67-v6so987589wmf.3
        for <git@vger.kernel.org>; Thu, 10 May 2018 23:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=P021OFgHU+G+3+HY0zAhuxRQ6B7uZDYWeOspcQN/IVU=;
        b=VDOT73WVZiYV6Ip67HrgIY7QkCW9Avb4n4V9oIaWCRZJj4I2Jp+VgqogOTUHUG3rCS
         Qc6cde+FvA7gcjvlUkUA6iLep4K0JsP6xNgbbkXEjtZvI9xgwXW9ZrnkTUUQEbH9nyvW
         kunqdXstvAlsk2YNf2dWTCi3fgaAKq8/tUkyLYr1FmfqWs9ZFaQwzKmp1kJDqBO7vQCu
         DrtIqD/KD/0i90+wIxjW/LRlDipU3XM068wMslbyMlJuOtYEXpSYDtHJWElTJP0UvXJq
         urwaQhUAwVxxOyKVCZDIO+nNppC3NGJLurBStC3FpDje3nhcDij0rERyTZTTkYUo54nD
         r4LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=P021OFgHU+G+3+HY0zAhuxRQ6B7uZDYWeOspcQN/IVU=;
        b=GaCpJdW0lsBo1/2vkMT9v92O23Z1OMZcTnA1g31dDL1+tMNwcrBa5losRh9tTmX9Kz
         jL+Xx1jQthiAMRuB6yGqTY+swxIlcTEm3qHvFovKNvJysHe4ju1ttIMM5Uhn/UAnBlbD
         8/lTLkw/C4OA3SKFVc/xIo1AlBPFKHBJZyVd9kvtFRci7ij/5VFGtksmeFPNEz9Oo9n8
         03cX1Z+BN5EBMogo2fy1VNzkt5jKtBnDV/0u1wVDdIUZ2Wru8y4+OtoCRcmJbXYXJkjA
         EnYOjFyqna4qv7EgaZJCZtutlfInyuQf7OrYaQnzv/abug9pBqVADWuEYU9QqT80y/mn
         0qLQ==
X-Gm-Message-State: ALKqPwf+KxYUlsV2n4NP6PldxVuAyTlkuyYUpMe4cbzH+mJoNvf9qoWG
        YJSgEG9j3wE4mRtVmWV2eDQ=
X-Google-Smtp-Source: AB8JxZpmvBWvS5GJLt9/kJx31kCopAxIdf7HPfbKOnGfnOH+yGQD/zvaS8GUV/diXXLT64qQh1tI3g==
X-Received: by 2002:a1c:96c1:: with SMTP id y184-v6mr1005831wmd.156.1526020778748;
        Thu, 10 May 2018 23:39:38 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id s14-v6sm423620wmb.5.2018.05.10.23.39.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 10 May 2018 23:39:37 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ben Peart <Ben.Peart@microsoft.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>,
        "newren\@gmail.com" <newren@gmail.com>,
        "pclouds\@gmail.com" <pclouds@gmail.com>,
        "vmiklos\@frugalware.org" <vmiklos@frugalware.org>,
        Alejandro Pauly <alpauly@microsoft.com>,
        "Johannes.Schindelin\@gmx.de" <Johannes.Schindelin@gmx.de>,
        "eckhard.s.maass\@googlemail.com" <eckhard.s.maass@googlemail.com>
Subject: Re: [PATCH v2] add status config and command line options for rename detection
References: <20180509144213.18032-1-benpeart@microsoft.com>
        <20180510141621.9668-1-benpeart@microsoft.com>
Date:   Fri, 11 May 2018 15:39:37 +0900
In-Reply-To: <20180510141621.9668-1-benpeart@microsoft.com> (Ben Peart's
        message of "Thu, 10 May 2018 14:16:37 +0000")
Message-ID: <xmqqr2mig0gm.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ben Peart <Ben.Peart@microsoft.com> writes:

>  Documentation/config.txt     | 10 ++++
>  Documentation/git-status.txt | 10 ++++
>  builtin/commit.c             | 41 ++++++++++++++++
>  diff.c                       |  2 +-
>  diff.h                       |  1 +
>  t/t7525-status-rename.sh     | 90 ++++++++++++++++++++++++++++++++++++
>  wt-status.c                  | 12 +++++
>  wt-status.h                  |  4 +-
>  8 files changed, 168 insertions(+), 2 deletions(-)
>  create mode 100644 t/t7525-status-rename.sh

I'll mark the new script as executable (otherwise the test will not
even start).

