Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2DE601F461
	for <e@80x24.org>; Thu, 16 May 2019 22:41:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727245AbfEPWlz (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 May 2019 18:41:55 -0400
Received: from mail-vk1-f202.google.com ([209.85.221.202]:49692 "EHLO
        mail-vk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726943AbfEPWly (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 May 2019 18:41:54 -0400
Received: by mail-vk1-f202.google.com with SMTP id t204so1856053vkd.16
        for <git@vger.kernel.org>; Thu, 16 May 2019 15:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=mk2T3v08UGG/VrLic8t3Yz3WI/Iqg/bpKfJ/xfqi0Mg=;
        b=qm4l5sHOY+Cw8QHxIZmTRcHke+uyRgljbx9oSpt6TLCoZbpf1utwTxyTrwDjOkSK92
         QplcfWOxYXl7w7muesfLpBqf5N+oWywUf8UV2RjQUbg0AP/8DPR+xE89WfKmhJZEtPc+
         1C9HSb0PCnb5m/W9ABZFZWL2JtvQZNvZJ1JcVI4FXvuJT5oiit7OR4N9xvVzntMG4/wr
         BSOzqZ8KXXq5jRVCMaHKlEu6QNwTj/zywCR+lqbLV09cpcd+XA/6zQb2QKVD3x/hcv8M
         A+3NmYkd3YohhFavVcu/bThuyOlsA1XbEyeprib/h9DP8iA2fFrPx3Y/dP67UsrmopsB
         PvpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=mk2T3v08UGG/VrLic8t3Yz3WI/Iqg/bpKfJ/xfqi0Mg=;
        b=GGJRs7PSZc0gLacKeb3TY7PNBh07p2DE8ba9vFTyf3w4cegyxHO/OhTBlYXyI2G0OG
         Nj6e6EYBFd9N8f0e72hCmvmVxBuk+wB5P61PWF4BlI+BB6OchxaDp21efUhcmRTrxrK2
         7YWBY/YBcyJ5yWsD360iOWDB6ax3En903/JMUwE9PeHYY2hsc9poIAJrlDOOJmnzp82Z
         90im2plLtftlbVCO/iQd3nFOKiISV/iecbr0gKFctgSizHm0bhJ6s5zRi0qZQ0aSGPIi
         ZR6ctuj6u1rw1l3DMCexNoNINgyTZctiLnk0MJZhxkC9fulUxlBtLmKSv+RDeBhbGpX/
         MvEA==
X-Gm-Message-State: APjAAAX7r5If0ivPjwc3RzYh4H2Slez2CZItfldNzF4z+CoJoa0DFp8Z
        aTo8uoYgMJYUdISabt6yqQKbPl1PpS4AbSvkIRG+
X-Google-Smtp-Source: APXvYqzG4Q/TWnBi63J5QNHyAlVkd8LlnAlY5AA0Q1P9ITiaCGgG4BdisxWSF4wEUVzG76A4JbvDfQBeR20Kxzg561Ah
X-Received: by 2002:a67:f24d:: with SMTP id y13mr6417482vsm.82.1558046513672;
 Thu, 16 May 2019 15:41:53 -0700 (PDT)
Date:   Thu, 16 May 2019 15:41:50 -0700
In-Reply-To: <cover.1558030802.git.matvore@google.com>
Message-Id: <20190516224150.243395-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1558030802.git.matvore@google.com>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
Subject: Re: [RFC PATCH 0/3] implement composite filters
From:   Jonathan Tan <jonathantanmy@google.com>
To:     matvore@google.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Here is a first stab at composite filters. It does not actually support omits,
> but the biggest difficulties of the implementation are already addressed. So I
> decided to send out an early version to give interested people an idea of just
> what is needed to implement it, and then give them a chance to change my mind
> (Jonathan T. especially was concerned about code complexity).

Thanks - seeing these patches reduces my concerns significantly. A
composite filter has LHS and RHS filters, either of which can be
composite themselves, so we support compositing arbitrary numbers of
filters. I see that the approach is to run LHS and RHS in lockstep, with
our own handling of the result flags:

- LOFR_MARK_SEEN is tracked for LHS and RHS separately. To support an
  arbitrary number of filters, we don't use object flags to track this,
  so we use oidsets instead. I don't think that the extra memory usage
  will be a problem (we already allocate more for all the struct
  object). If this is an issue in the future, we can switch to using
  object flags for the first N filters, and oidsets thereafter.

- LOFR_SKIP_TREE is simulated if only one filter wants to skip the tree.

- I haven't fully figured out LOFR_DO_SHOW yet. It seems to me that if
  an object appears twice in the walk, and the LHS says LOFR_DO_SHOW on
  the first occurrence, if the RHS says LOFR_DO_SHOW on the second
  occurrence, the object will be shown twice. But perhaps this isn't a
  problem - as it is, I think that a filter can call LOFR_DO_SHOW
  multiple times on the same object anyway. In any case, if this turns
  out to be a problem, it seems surmountable to me.
