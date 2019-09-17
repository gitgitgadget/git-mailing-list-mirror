Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4F8EA1F463
	for <e@80x24.org>; Tue, 17 Sep 2019 22:49:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728320AbfIQWtO (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Sep 2019 18:49:14 -0400
Received: from mail-pl1-f202.google.com ([209.85.214.202]:38523 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726500AbfIQWtO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Sep 2019 18:49:14 -0400
Received: by mail-pl1-f202.google.com with SMTP id x5so3018474pln.5
        for <git@vger.kernel.org>; Tue, 17 Sep 2019 15:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=nstejjy2vF5mrPcSfletdPJ/a7Wx72Hea0RixcOBZgM=;
        b=XNkFjdotfYSuL1awPOlj6KoI+FCpjIvWiPsJmizBdkrPJoRDcpWFLSETpFNY2mGfeT
         EGRl0jatw7+IhTgL9Zslp8OQC0gYecrczOGkd4959l8+A0e+uuCordWXd0SMw8ZqBHeE
         WYta7rtM06skfwIsfwU5lYwMDaMYgpJk7paqIZehRTTEkuAoSIFRo9FvJdipSEsdRIZw
         h0mSCgL6Uie6y8H3SECi1scneYUEw3TvYGKuzX3fJkbr9VnxgiCV4xs89Tpq4Ynebham
         5iqRbjOyXj0GPmalEAWPUEnoYURL1w9L321/TyvYnNFljZFl6i0SWfatpp/+N1hQNxlL
         ti7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=nstejjy2vF5mrPcSfletdPJ/a7Wx72Hea0RixcOBZgM=;
        b=sFjuRW1ono/+jcLqBmYfVWCLJaBJgA2TvDPiwAPSmohUfLOx3zhHCToLnfQDDjQyW9
         VGBY95l+Rbd2+L5UOFMEDBwVUr/gjUhdsCGzG3+J41QLxsv1IHIbKhQsjmPlwbhq3wlf
         +vJf8COz9zbzn4StsNH0Bum6iE43pY4Tt/MuZWK9IPIkmAN4FwdbnsPCU/2zF90CSTAh
         Qx5gfFPwx7re4hTaHtUG16wKpF7qCBH20RxVHz0jF4SAqLLFfcG40bJlL+4AlhkuRwAl
         jmnNvbys16lMl0oPB7FoDW4VZ9Vsy/mrs6tliQpq/UVfHf8dZaVZ2coDcVRjuCeIQ/n/
         dnKw==
X-Gm-Message-State: APjAAAVFZ85yiTDjHlW5/Yvbky1uJUOm1RR6mFLgUTUT7MnVqLcCfmWm
        D5lhZdQk8F3jMaQ3l6OLUGgcexuoc/Ec3wcZHlgh
X-Google-Smtp-Source: APXvYqxfesWDE8n7Ed8+d4BFlVPZu2LoWVGrWwSUuLW07d2YbSbhOVksNGceUWg+kufsHbOAznT2sSbvcT7QOs/zHHm4
X-Received: by 2002:a63:f907:: with SMTP id h7mr1162400pgi.418.1568760551923;
 Tue, 17 Sep 2019 15:49:11 -0700 (PDT)
Date:   Tue, 17 Sep 2019 15:49:08 -0700
In-Reply-To: <xmqq8sqm7dmw.fsf@gitster-ct.c.googlers.com>
Message-Id: <20190917224909.123111-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <xmqq8sqm7dmw.fsf@gitster-ct.c.googlers.com>
X-Mailer: git-send-email 2.23.0.237.gc6a4ce50a0-goog
Subject: Re: [RFC PATCH] merge-recursive: symlink's descendants not in way
From:   Jonathan Tan <jonathantanmy@google.com>
To:     gitster@pobox.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org, newren@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Yeah, I recall having to add has_symlink_leading_path() long time
> ago in different codepaths (including "apply").  It is not surprising
> to see a similar glitch remaining in merge-recursive (it's a tricky
> issue, and it's a tricky code).

Thanks for the pointer to has_symlink_leading_path() - I tried it and it
seems to work too. I'll wait for more replies and send an updated
version tomorrow.
