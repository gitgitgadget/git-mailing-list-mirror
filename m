Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3B1DF1F954
	for <e@80x24.org>; Wed, 22 Aug 2018 17:52:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727775AbeHVVRz (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Aug 2018 17:17:55 -0400
Received: from mail-yw1-f74.google.com ([209.85.161.74]:46805 "EHLO
        mail-yw1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727468AbeHVVRz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Aug 2018 17:17:55 -0400
Received: by mail-yw1-f74.google.com with SMTP id 2-v6so1393382ywn.13
        for <git@vger.kernel.org>; Wed, 22 Aug 2018 10:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=E8qsPEbZFf/qAIFCn88tTGdrC+qTxxbFvLYstjuNNOs=;
        b=iU+q69zGHWuCBB14AnnRFhwPZ81eQ3fZX+O37uOHslpQ1OD1yOGc7vulHLykLsXzmV
         8KPucg0Ih7CaMrb1ZFLTo3ucS/F9GB4WRLXqfRsuLJeY5n5LiOF7c2F6cExFaA3OrWAO
         8SjSCy0quCI3dyYi4yVmNJ4ZJmCW5uk3gvHecDZmLIgECXF+pRb/Mt7NvwWiPfqbzbFT
         Bt9O+rANZ8N7B5331MNiBIndKXQC0No0zGLRbjybjXmFx7Klm7Yvv4K5z9CwfqQPmoou
         v2O6cPeWFlKW0dvXsRxkk7id6+Kzk12gu0zhYiYQxLdTVR9GRnErIOg9yx7kYG2oogMg
         1zEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=E8qsPEbZFf/qAIFCn88tTGdrC+qTxxbFvLYstjuNNOs=;
        b=OmDB1ndnbeph+D+HU7rDdS4dn2bzgJ8+K2VU0HXCfwjSYnPSdM1ZNkEZ8AfiuCtc3T
         vCbIiKRDCSGkbC+SCKBlbmkBf/Or+BODhRjd9LrDMgoWfFTfBnerM05MX2Da9U1U9jyS
         O8gO10EmAbfWgQYdQC+KhgLl+3R+c39V/Vl164rNWJOIueHUZZ33CRh8g+R1WgBQV75f
         ylZj9ZUvbMxYBdAqDUwjfD5A0O+IshivZ913lafHFVonakjcPd68G8Qdb0veucUBilLd
         xQ12t/+qYGy8nTX8tlu/VAH+b4JN0RWSU5OTYO8LBGa0R5FGJce5NKniYkU36vHfgBic
         Mt8A==
X-Gm-Message-State: AOUpUlHGdPhWXeHqf4AIsoVduIdLaRrZnBanKNMopwlAH02hGDBpbuWy
        Ns9DkGsw+7Y85RRJq0BImzNw7qZjJG4=
X-Google-Smtp-Source: ANB0VdZeNEUmfC9AXD9puuB5+Xzqfy8yzIf6usPwr7fMJm/NU66/PMAxTMgWD7jGv6zVa6v3GfXeK530oLxo
X-Received: by 2002:a0d:d5c8:: with SMTP id x191-v6mr3680689ywd.96.1534960323951;
 Wed, 22 Aug 2018 10:52:03 -0700 (PDT)
Date:   Wed, 22 Aug 2018 10:52:01 -0700
In-Reply-To: <20180819215725.29001-1-szeder.dev@gmail.com>
Message-Id: <20180822175201.42406-1-matvore@google.com>
Mime-Version: 1.0
References: <20180819215725.29001-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.19.0.rc0.228.g281dcd1b4d0-goog
Subject: Re: [PATCH 0/4] tests: make more use of 'test_must_be_empty'
From:   Matthew DeVore <matvore@google.com>
To:     szeder.dev@gmail.com
Cc:     avarab@gmail.com, git@vger.kernel.org, gitster@pobox.com,
        rybak.a.v@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Note that you can also trivially convert a lot more instances of empty
checking to the "right" way: 'test_line_count = 0'

$ grep -Ir 'test_line_count = 0' t | wc -l
76

I think it would be nice to clean these up as well.

