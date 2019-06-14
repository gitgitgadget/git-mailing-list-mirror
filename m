Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 60FE51F462
	for <e@80x24.org>; Fri, 14 Jun 2019 03:50:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725793AbfFNDuT (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Jun 2019 23:50:19 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:38697 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725616AbfFNDuT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jun 2019 23:50:19 -0400
Received: by mail-pl1-f195.google.com with SMTP id f97so411431plb.5
        for <git@vger.kernel.org>; Thu, 13 Jun 2019 20:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=G73MgnFYCnFsWuDD61PTpURh4LUG6T52oXpb/X9KclQ=;
        b=t7yORGb4K+NnGyUtPwzXCczQGzOgK1fGoh8xgme11sGpsg8F91/zUDRXejgQxhvgaj
         1TnO0JAlSwl6mqClSKnPgXMPCnFkvjCqDvsJk0X3KgEfWLS9W3ynBydiWyh+HoDTfVi9
         CyP0x/mIV2EFXTg7eCl0WZPBqouOPSY8suKscA48BtF7hQfEimtr7qA/bLovi4RNgam9
         5tRkaMmF2VlWPmlhNKDQ7Lb438vORr3a5oMdfzDzaRofO7+DrBI2cVt2zW5hGHVGqrdu
         8wm1Q2r/FU2A7Klk1LWuDT1xHNaEmiD2KoXE2cqlUNKuGDDPfWO9qHV5z4D9zpZLlix/
         3CfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=G73MgnFYCnFsWuDD61PTpURh4LUG6T52oXpb/X9KclQ=;
        b=VyIky9WtduE3S14lShYNK9faoJGsPbgXCYVp+bZz7kd/SbXGHGCr6BXUxTmfVMFiWQ
         SnvISa2p4kcGS+i+Fismh7mkaLrIdfEinCPF+j8hj4NrqfKYAJDDSbHfv8d85SIK2QOn
         thbsnFZRaXeOqqyvK09tifZpB18vNlehJ6Ts6WQ6z+ehmfJtfBfTxNxAiyrlP86pvy8W
         UjS+MlQbZt1EIwJggmgTPuYMNrqlCBnwqXDG/9gSXt5fXIDUbk1cBGnoYNmwKx+mKXpY
         VWNykuvnhDHgupKQ/VZFYeTaLEWYn8ntVDjA8u6vvx4dCl/cd0URj4K0FpO63duDx1xO
         7O9w==
X-Gm-Message-State: APjAAAWmwCA85KtQmpadf+T1wEM2UkGWDDSrSAIl3fvASeGUBuJlzZO4
        Cr9i85qEIGks+1EsCDkNk/I=
X-Google-Smtp-Source: APXvYqynNeYwaJsMDxy4D+bTdeXs/S0z1WGgLP/W1ErEiNXhU3ME4GUK6//Es+02UdMC4YMvAFLeng==
X-Received: by 2002:a17:902:9689:: with SMTP id n9mr91318959plp.133.1560484218409;
        Thu, 13 Jun 2019 20:50:18 -0700 (PDT)
Received: from ar135.iitr.local ([117.234.2.144])
        by smtp.gmail.com with ESMTPSA id c133sm1127031pfb.111.2019.06.13.20.50.14
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 13 Jun 2019 20:50:17 -0700 (PDT)
From:   Rohit Ashiwal <rohit.ashiwal265@gmail.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, newren@gmail.com, phillip.wood123@gmail.com,
        rohit.ashiwal265@gmail.com, t.gummerer@gmail.com
Subject: Re: [GSoC][PATCH v3 2/3] cherry-pick/revert: add --skip option
Date:   Fri, 14 Jun 2019 09:18:08 +0530
Message-Id: <20190614034808.19667-1-rohit.ashiwal265@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <xmqqtvctuul6.fsf@gitster-ct.c.googlers.com>
References: <xmqqtvctuul6.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio

On 2019-06-13 19:57 UTC Junio C Hamano <gitster@pobox.com> wrote:
> 
> I think my earlier comments would lead to a wrong direction, i.e. to
> justify the change made to rollback_single_pick(), so let's step
> back a bit.  Perhaps the change is unjustifiable and that is why I
> had trouble reading it and trying to make sense out of it.
> 
> Is it possible that the new callsite that passes is_skip==1 should
> not be calling it (while castrating many parts of the callee) in the
> first place?  Perhaps it is doing something _different_ from being
> called "rollback single pick" (or perhaps the name of the function
> is not specific enough to describe what its existing caller, i.e. the
> one that passes is_skip==0 after your patch, calls it for)?  IOW,
> would it lead to a better code structure if you left the original
> rollback_single_pick() helper and its caller alone (perhaps rename
> it to make it clearer what it does), and *add* a new helper around
> the underlying reset_for_rollback() function and call it from here?

That is why I added a new function, but I was not super sure if it
was a good idea to begin with, since it only introduced small changes
to `reset_for_rollback` (also Phillip[1] discouraged it so, I stopped
thinking in that direction).

> Perhaps it is not rolling back but is skipping, so the new function
> needs to be called skip_single_pick() or something, and the existing
> one is named correctly and there is no need for even renaming?

We could have a wrapper function to `reset_for_rollback` and better
rename it to `reset_merge` since we *are* resetting a merge which
translates to rolling-back in reality?

Thanks
Rohit

[1]: https://public-inbox.org/git/6d3c1c1e-6140-dd8c-c37f-8c625b04ddc9@gmail.com/

