Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 51B8520281
	for <e@80x24.org>; Thu,  2 Nov 2017 19:44:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934334AbdKBTos (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Nov 2017 15:44:48 -0400
Received: from mail-io0-f176.google.com ([209.85.223.176]:49646 "EHLO
        mail-io0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934300AbdKBTor (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Nov 2017 15:44:47 -0400
Received: by mail-io0-f176.google.com with SMTP id n137so1496497iod.6
        for <git@vger.kernel.org>; Thu, 02 Nov 2017 12:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ut9yHuwp7JXg2vYLy88wQF5VGAZ6TWft58z/9Z3Gt30=;
        b=QIbZ/OoqquVDkNSPfglTrE6Ifoqmc33sl5mFF87+M6UJ/JgXO7mrrk8vR3ET7zLcFG
         /gbH4vxSyNK446waDdbWp02WNz6/32Qdy5aAxXvp0CYElrLMQwUfU3G8SIiyKdo7765W
         gQhwPWVd31ENOGK/S41827p560djmT8sZJ/F6+wtwfO4FAPsPijvATx3toBVLGZ2NN6K
         j8FrS64q1lJ7rBv/esFDmN7W4ds2gVEXDFng/jT2bPFJrG0or9SSjIgFZwHlDueHShn2
         0Ets0UIX6uHHk1+pS4HhFbZXMrHawY8uHgmg5jLW82KPELWxv3BtP3ZunHVHlnnTVi/q
         0r8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ut9yHuwp7JXg2vYLy88wQF5VGAZ6TWft58z/9Z3Gt30=;
        b=B7VkaUB18E9fJavsxcct4e3pcjG9IZ8/wUwIZw5q9GJVzvFm3bHZDw6Tx7dJnQIfeU
         /dT+XnQGOz5l4EL0pSMcW6zF+R8o8/0IWh/4dFPJxqtVoqGC8nc+H7D2pSv8plBlcfSc
         HJGTz3rEZaiaAefdjRY9bfgIjBgtw4GwQ9c7koErgY/OGlsriUPkzV5EE1ikcd9+tdDF
         /ORQI9YdiW941hyEAzrTHz2xJ+2oAhXKX2CzazUbK0tWKUM1++sbcHso66bAYTP7dyiU
         yDJ0lDl+W4vnQFrY87+QZFWyeCDNPdd7FHKeD9i9BSyDkHwbp2cDzF6ZPXazT6BG/etk
         7kmQ==
X-Gm-Message-State: AMCzsaVI/6iPM+1OJ/pTpZgUDf85e/T/uDFXGedI5+Uc/RNyAdU5MvMH
        O5wotyh4pJ223En3TLqB755YHALXbXQ=
X-Google-Smtp-Source: ABhQp+QTfTj2xTxx51iEbaYbZzIAYqAiu0UFV0xpi88fZRxX+G3DCX0pyLU8Tn1qpWt6LeF3TjrI2w==
X-Received: by 10.107.17.31 with SMTP id z31mr6076918ioi.124.1509651886620;
        Thu, 02 Nov 2017 12:44:46 -0700 (PDT)
Received: from twelve3.mtv.corp.google.com ([2620:0:100e:422:2131:f64d:d486:a16f])
        by smtp.gmail.com with ESMTPSA id 80sm1868088ioz.54.2017.11.02.12.44.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Nov 2017 12:44:46 -0700 (PDT)
Date:   Thu, 2 Nov 2017 12:44:45 -0700
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v2 0/6] Partial clone part 1: object filtering
Message-Id: <20171102124445.fbffd43521cd35f6a71e1851@google.com>
In-Reply-To: <20171102175013.3371-1-git@jeffhostetler.com>
References: <20171102175013.3371-1-git@jeffhostetler.com>
X-Mailer: Sylpheed 3.4.1 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu,  2 Nov 2017 17:50:07 +0000
Jeff Hostetler <git@jeffhostetler.com> wrote:

> From: Jeff Hostetler <jeffhost@microsoft.com>
> 
> Here is V2 of the list-object filtering. It replaces [1]
> and reflect a refactoring and simplification of the original.

Thanks, overall this looks quite good. I reviewed patches 2-6 (skipping
1 since it's already in next), made my comments on 4, and don't have any
for the rest (besides what's below).

> I've added "--filter-ignore-missing" parameter to rev-list and
> pack-objects to ignore missing objects rather than error out.
> This allows this patch series to better stand on its own eliminates
> the need in part 1 for "patch 9" from V1.
> 
> This is a brute force ignore all missing objects.  Later, in part
> 2 or part 3 when --exclude-promisor-objects is introduced, we will
> be able to ignore EXPECTED missing objects.

(This is regarding patches 5 and 6.) Is the intention to support both
flags? (That is, --ignore-missing to ignore without checking whether the
object being missing is not unexpected, and --exclude-promisor-objects
to check and ignore.)
