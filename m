Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DBD22207D6
	for <e@80x24.org>; Tue,  2 May 2017 01:36:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750851AbdEBBge (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 May 2017 21:36:34 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:34261 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750831AbdEBBgd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 May 2017 21:36:33 -0400
Received: by mail-pg0-f65.google.com with SMTP id t7so18497324pgt.1
        for <git@vger.kernel.org>; Mon, 01 May 2017 18:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=y8negvn53mDDge+YF7EwMSLCKzTjIoi3gjnCBtQl+0c=;
        b=MQZtxQZ2ycTSiq0w9CYu5ZhmeqZmcwUkrWLFrAAOzDtMcD2pzUHrXz+HM3DrJdxYGj
         bTXON5R7QR1RokKtYKZz2jQ19VDDBn88HVmMJ7eEhKUCQ6nr6YuY3D1JUPi36PtaV/3Y
         1r3GhX3/PIKCpoRFMNYKS8GjV5lYXpgrQT2Ikdfdgv5Q1AKYZbW1+glvonI4NkvStqJE
         vn0kwI6b3oFh2AtEkiPNzhu6NAquouUTnOOu3AtcKVUFMSqr9CnaQPi1Z8pWMdQJj+IG
         sIPUUR4/cGrxeTKYP0CAqPFVeyhcea0yAOoTveZRxDbcfH+aAdHxMDYM4OaK85RfggRb
         DD2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=y8negvn53mDDge+YF7EwMSLCKzTjIoi3gjnCBtQl+0c=;
        b=CrAIl+w3tvdnajTJNiH9kVlHqOjzTSAyJ1LkFllNnBaILwi1aLwmZLX+MPoFCfasq+
         vLCM1ceNvwsYwGsaGqJkfkbZ4bvCWokKHcF5rYoWyVyaVTdvIEDNxGWOELoT1FxtV1rd
         CBNrFPFH12vKDfT6oCFVUBdZri0zWIxqvyB+X3k7jEkqoDzT2p8M4uHf7J2XXkNJ4dgQ
         33LMr3TJ7DZmkg6TD0HXcwpnCRK4uvFT5yWDFebrUA8w6NpJtqo8tizJnWQssGNSIRr/
         sim0ok6jXnhdTFEdIjHg+KHhFSW2MV/d3EiVEJ48oEqJBeGFiyY1SQnykjEzl/kErsNV
         wWyw==
X-Gm-Message-State: AN3rC/5KQDXtxyXEYkrPmM301W9/kIHnghBrgu3Qu96TSxwA+trgwN+a
        xSVHq3v5FXmQ5w==
X-Received: by 10.84.233.200 with SMTP id m8mr13046906pln.118.1493688992667;
        Mon, 01 May 2017 18:36:32 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:3c5e:d1c1:579c:ef99])
        by smtp.gmail.com with ESMTPSA id w85sm26606481pfk.62.2017.05.01.18.36.32
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 01 May 2017 18:36:32 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/5] Start of a journey: drop NO_THE_INDEX_COMPATIBILITY_MACROS
References: <20170501190719.10669-1-sbeller@google.com>
Date:   Mon, 01 May 2017 18:36:31 -0700
In-Reply-To: <20170501190719.10669-1-sbeller@google.com> (Stefan Beller's
        message of "Mon, 1 May 2017 12:07:14 -0700")
Message-ID: <xmqq7f20f3a8.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> This applies to origin/master.
>
> For better readability and understandability for newcomers it is a good idea
> to not offer 2 APIs doing the same thing with on being the #define of the other.
>
> In the long run we may want to drop the macros guarded by
> NO_THE_INDEX_COMPATIBILITY_MACROS. This converts a couple of them.

Why?  Why should we keep typing &the_index, when most of the time we
are given _the_ index and working on it?
