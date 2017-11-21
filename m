Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2F2B32036D
	for <e@80x24.org>; Tue, 21 Nov 2017 18:17:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751263AbdKUSRF (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Nov 2017 13:17:05 -0500
Received: from mail-pf0-f175.google.com ([209.85.192.175]:44885 "EHLO
        mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750794AbdKUSRE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Nov 2017 13:17:04 -0500
Received: by mail-pf0-f175.google.com with SMTP id r14so3885169pfl.11
        for <git@vger.kernel.org>; Tue, 21 Nov 2017 10:17:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7RuPi8SKB2EuJxu9zdJqmv3wwPbUp3d700p9a28bRCI=;
        b=bSn60p8KgHJp0gFLWLvwyM9v4FuZRPnfFnkD93uoEksY/FMsyZPr6elsb9G8g8Ypy7
         0Ed6Z+ZzEysgT1kzVOnHHj1T+okIIR2whBCdlwFo0mgt5tiEyPTVphXZKJip/uoxcIda
         CYeOJ+KqIw+uN2+F4GXlgVMJ3cPNqmZscEqvzDQuQ3Vsp92ljj+X9QlBWTZPszGL0mdk
         c3NTWNOKQTz77ellni3synDJHQwpS6ekBCcXU9tH10aMntpIfyZINASfqxZ5wLiaIC76
         jKRQ9544mWbblDRatOqrxz1KdpWh/s2UkbVA+qFTMSnkavTXrcDhraZmiY4VtZd4jkkH
         YAvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7RuPi8SKB2EuJxu9zdJqmv3wwPbUp3d700p9a28bRCI=;
        b=qQa8vRveQuH3iLYjYqTa68+sVuJiCbBa2GGf7F6DDO57r/Hvn3M4M0SOvjOwEgU4yN
         4Q4TKLcg4SeRg4JxYC1p5GcY7Qd6CuC2WY7cIUhYPfoolRxzVlwrPps8D3CHyY1UoWQm
         MoTxsRvqUbXic64Q3scYsFGL3073BVTqxmAheztRnQ8hkg+NUyVpufcRFrHDuqehzk64
         r6DEQ/rINla1zjSKyloLALePZ8DYIoT2MlBCC6Sz6k87RQHrkFqjgNaMhZ5IzdkcHElo
         tUYoUJahvaBbZNiPwZ++A3mTT4ZvaZj+IH2/csPms9DabAuP5Ot95RH5wrD6HeDwpFB8
         BEkw==
X-Gm-Message-State: AJaThX5SoiQKi5ZcstmnQcxT7PzMkQ4bHrvEAV9SKkTDG3+c/lHRixca
        4atr/aIZc0eo3RwwwL8f4ikr9A==
X-Google-Smtp-Source: AGs4zMZFtbdw+LvCzkSZH/+B6lTRpLTAHUyHFFQj0T7cR5KuE3r+L1iH2LlQB0AWNr4l/phZQscFIQ==
X-Received: by 10.98.208.67 with SMTP id p64mr16198257pfg.111.1511288224146;
        Tue, 21 Nov 2017 10:17:04 -0800 (PST)
Received: from twelve3.mtv.corp.google.com ([2620:0:100e:422:1cbc:1098:b843:9bbe])
        by smtp.gmail.com with ESMTPSA id n22sm15368790pgd.47.2017.11.21.10.17.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Nov 2017 10:17:03 -0800 (PST)
Date:   Tue, 21 Nov 2017 10:17:02 -0800
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v4 00/15] Parial clone part 3: clone, fetch, fetch-pack,
 upload-pack, and tests
Message-Id: <20171121101702.663a52515070faf73a97f2b8@google.com>
In-Reply-To: <20171116181723.62033-1-git@jeffhostetler.com>
References: <20171116181723.62033-1-git@jeffhostetler.com>
X-Mailer: Sylpheed 3.4.1 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 16 Nov 2017 18:17:08 +0000
Jeff Hostetler <git@jeffhostetler.com> wrote:

> From: Jeff Hostetler <jeffhost@microsoft.com>
> 
> This part 3 of a 3 part sequence partial clone.  It assumes
> that part 1 and part 2 are in place.
> 
> This patch series is labeled as V4 to keep it in sync with
> the corresponding V4 versions of parts 1 and 2.  There was
> not a V3 version of this patch series.
> 
> Jonathan and I independently started on this task.  This is another
> pass at merging those efforts.  So there are several places that may
> need refactoring and cleanup, but fewer than in the previous submission.
> In particular, the test cases should be squashed and new tests added.
> 
> And I think we need more end-to-end tests.  I'll work on those next.

I think that it would be easier to review if the test for each command
was contained in the same patch as (or the patch immediately following)
the implementation of the command - for example, as in my modifications
[1].

(If you're about to send out v5, that's fine - maybe take this in
consideration for v6, if there is one.)

[1] https://github.com/jonathantanmy/git/commits/pc20171103
