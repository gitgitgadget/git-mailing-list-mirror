Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B29DF1F597
	for <e@80x24.org>; Tue, 19 Jun 2018 19:23:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967196AbeFSTXe (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Jun 2018 15:23:34 -0400
Received: from mail-ot0-f201.google.com ([74.125.82.201]:36670 "EHLO
        mail-ot0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966263AbeFSTXe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jun 2018 15:23:34 -0400
Received: by mail-ot0-f201.google.com with SMTP id z25-v6so428371otk.3
        for <git@vger.kernel.org>; Tue, 19 Jun 2018 12:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=DdM98LuccinOfV/LNetqtm+JBZztfby8uObQSV7esB8=;
        b=ru336Jh0KKUvcDPcPgSoPdpHzWP2M0y8kaJ2eVdkyKjazKcN05suuy8ENh8vKMcB36
         Ge+1r4w6j40VsjCCOo4dG1gdOzyC2RytdIlrlvS9T0SC/aaAt1OSzxwep8O5pSwS47jW
         YqFh9S5LhFEGMe3nNSfej8xP/A5vjGAh8H2aXaEdpH7nGtzQMBTBVSPcb6r9je5NGNuF
         8nUdie4oTwJumOjhK7ExW9QVgxsau/hp835gXW1CvpLIXkLAyZ2C6bkxlrBKrbxX5civ
         7rV/kEzoIfsmqD8sQlpQQiRnZdUdZzQK9g4dxoaN9AkeoAX/ynVf0HXJdyNmqwGPy73k
         r47Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=DdM98LuccinOfV/LNetqtm+JBZztfby8uObQSV7esB8=;
        b=IiivcH9JWQcFZAI3Ova5ebUUZTPjeDm5hr2pXlzsh9EXpxpaqeJP5deoxvQx3DghyF
         R1Ba0Woaw2RCUL2S1QYxgcXlmmkyvzPXdGI2pqtaXlRowkGmv6ijNw9SZcXC+6ghWbJX
         9fsPstjOlo9rBzcjyMcCKUGV5T/5k5SJinIXLtMilfwr6O+/dsJFm931vbT/1ji/B4vD
         lS+8ESUbkESh3wWRRMwNqnGW0FzqXlh1d9T5I8yKhU6CX+gsVObl+cpm5lpwR4KVjtPT
         g8n3No/TatosHfcved2hSR3chfbB8a9+d9t66vlKe7bVQnk0ZTTaE4mEy+xcaYDhEvt1
         KuZA==
X-Gm-Message-State: APt69E3i0K+iuSX+FUAssweD4FZTa/N1EzKTqhgdsroyutzYnwTtp0L/
        yMvCGv2JZISmIX2ai2bNGeqQjtxsreDZTr2GJ/xh
X-Google-Smtp-Source: ADUXVKJy5ibnnC5d/gI17TowH6NLgBFADqUwfO/6UezmGfg04QOU4UY4/4T0gZY4wn9Cp3Xqqp/33h7lvRIpdLmvqF1m
MIME-Version: 1.0
X-Received: by 2002:a9d:5b36:: with SMTP id x51-v6mr9137326oth.118.1529436213437;
 Tue, 19 Jun 2018 12:23:33 -0700 (PDT)
Date:   Tue, 19 Jun 2018 12:23:30 -0700
In-Reply-To: <20180619173250.GA199585@google.com>
Message-Id: <20180619192330.83971-1-jonathantanmy@google.com>
References: <20180619173250.GA199585@google.com>
X-Mailer: git-send-email 2.18.0.rc2.347.g0da03f3a46.dirty
Subject: Re: [PATCH 0/8] ref-in-want
From:   Jonathan Tan <jonathantanmy@google.com>
To:     bmwill@google.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

[snip]

> > in which we have rarely-updated branches that we still want to fetch
> > (e.g. an annotated tag when we fetch refs/tags/* or a Gerrit
> > refs/changes/* branch), having the ref advertisement first means that we
> > can omit them from our "want" or "want-ref" list. But not having them
> > means that we send "want-ref refs/tags/*" to the server, and during
> > negotiation inform the server of our master branch (A), and since the
> > server knows of a common ancestor of all our wants (A, B, C), it will
> > terminate the negotiation and send the objects specific to branches B
> > and C even though it didn't need to.
> > 
> > So maybe we still need to keep the ls-refs step around, and thus, this
> > design of only accepting exact refs is perhaps good enough for now.
> 
> I think that taking a smaller step first it probably better.  This is
> something that we've done in the past with the shallow features and
> later capabilities were added to add different ways to request shallow
> fetches.

I think we're agreeing that the smaller step first is better.

> That being said, if we find that this feature doesn't work as-is and
> needs the extra complexity of patterns from the start then they should
> be added.

I agree (although I would be OK too if we decide to do the small
exact-name step now and then the pattern step later guarded by a
capability, as long as the project understood that multiple support
levels would then exist in the wild).

> But it doesn't seem like there's a concrete reason at the
> moment.

I agree. I thought I had a reason, but not after thinking through the
ideas I explained in [1].

[1] https://public-inbox.org/git/20180615190458.147775-1-jonathantanmy@google.com/
