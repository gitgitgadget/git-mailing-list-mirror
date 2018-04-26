Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 376B11F424
	for <e@80x24.org>; Thu, 26 Apr 2018 23:23:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932181AbeDZXXn (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Apr 2018 19:23:43 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:44035 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752991AbeDZXXm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Apr 2018 19:23:42 -0400
Received: by mail-pg0-f68.google.com with SMTP id 82-v6so33642pge.11
        for <git@vger.kernel.org>; Thu, 26 Apr 2018 16:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2wigw694Hz5oPuuNIhNW8g+zN0jF3kAHpYwL4wtS8Y0=;
        b=qiZYysNh/QOQLXdb70RraJlCFm5fHB+NO94AafkrQ2dox2GvPaJPL3hcbIVaIvu92Q
         KAa4fugUyaCSYA2NZxs19q5nl9qALgHTjOkN3ceRLne8ADDNfnH8EyxRczycy7oXhB7K
         zet6p6WziFVxb7Zku1k6iEhkmYouuHBWAtQxj2+esFmpl+3SR2AzZ4rJ3u8kMxioGFZd
         ReWUbL72UHlHteHAfV1WXxrByvU1KMyWYudrpTx4pROy3XP9V5Pv8BhI73fHfGtTItBt
         NANeOBxLI/uvgV+VkQvWbLUnDrRUN9mXfBc3zawpapS/hfpiAQkKPtMZp35lW9u0ZsZM
         wFoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2wigw694Hz5oPuuNIhNW8g+zN0jF3kAHpYwL4wtS8Y0=;
        b=i1eiDGWI/ENKE3zLJQ6cizy9hjPbKsW2Cw7ArAhczrOocrnCcHWIbQxSGAooiM8HdU
         S5UjxlGV9kW+6bhzm/91CPNQxCM/ZJV1dTUPRRD7j7glfxK+o7WbsqKUoZnSCdHdy1V9
         fyCxHFj2mNSfKSxUJjiS01eMD5PBPRsHSrZ+pyh4bqEcVNQF25TA1kLriyVkFnmScz6u
         4qQ4cp9WUNQf66jW/0RaKL2QwqQylEJSQmBnnZQeZxtY+0eZd0anFhxYJ93BMq4/i/x3
         YrmT4YC7u3+aiJTiz2jigiAcFSrD8qvZE7WiszGEN5ijzejxoOBeHFV3AMRFDUP41UOP
         FuZQ==
X-Gm-Message-State: ALQs6tA+lMnSEY1Q90hdvWD19ysbT0D+msPegtihn5UH87RFg94I1Cu0
        26AtaQwHalTGVSwl0LEAA75dzg==
X-Google-Smtp-Source: AB8JxZpI8/hnghHc/6rPsttx+43uq71BPmKupmqOfPB6+nWflxCvgW0VxlnSLETApgmG/9hH3+CbXg==
X-Received: by 2002:a17:902:aa94:: with SMTP id d20-v6mr8322plr.323.1524785021862;
        Thu, 26 Apr 2018 16:23:41 -0700 (PDT)
Received: from twelve3.svl.corp.google.com ([2620:0:100e:422:ffac:c1d4:4bf7:bb93])
        by smtp.gmail.com with ESMTPSA id 27sm41583160pfo.137.2018.04.26.16.23.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 26 Apr 2018 16:23:40 -0700 (PDT)
Date:   Thu, 26 Apr 2018 16:23:39 -0700
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Ben Peart <Ben.Peart@microsoft.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "peff@peff.net" <peff@peff.net>,
        "gitster@pobox.com" <gitster@pobox.com>,
        "pclouds@gmail.com" <pclouds@gmail.com>,
        "vmiklos@frugalware.org" <vmiklos@frugalware.org>,
        Kevin Willford <kewillf@microsoft.com>,
        "Johannes.Schindelin@gmx.de" <Johannes.Schindelin@gmx.de>,
        "eckhard.s.maass@googlemail.com" <eckhard.s.maass@googlemail.com>
Subject: Re: [PATCH v3 1/3] merge: update documentation for
 {merge,diff}.renameLimit
Message-Id: <20180426162339.db6b4855fedb5e5244ba7dd1@google.com>
In-Reply-To: <CABPp-BEa2EDdeDfcXxRERKAuOPUYTsBGZB8XyTXDYN1JpHsbXA@mail.gmail.com>
References: <20180420133632.17580-1-benpeart@microsoft.com>
        <20180426205202.23056-1-benpeart@microsoft.com>
        <20180426205202.23056-2-benpeart@microsoft.com>
        <CABPp-BEa2EDdeDfcXxRERKAuOPUYTsBGZB8XyTXDYN1JpHsbXA@mail.gmail.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 26 Apr 2018 16:11:50 -0700
Elijah Newren <newren@gmail.com> wrote:

> Patch looks fine, but it's hard for me not to notice a separate issue
> in this area independent of your series: I'm curious if we should
> document that the value of 0 is special here (as per Jonathan Tan's
> commit 89973554b52c ("diffcore-rename: make diff-tree -l0 mean
> -l<large>", 2017-11-29)), and doesn't actually drop the limit to 0.
> cc'ing Jonathan Tan for his thoughts.

Documenting that the value of 0 is special does make sense to me. I
think this patch can go in as-is, though - it is already an improvement.
