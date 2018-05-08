Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 31BE71F424
	for <e@80x24.org>; Tue,  8 May 2018 20:04:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755566AbeEHUEg (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 May 2018 16:04:36 -0400
Received: from mail-pf0-f175.google.com ([209.85.192.175]:36681 "EHLO
        mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754370AbeEHUEf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 May 2018 16:04:35 -0400
Received: by mail-pf0-f175.google.com with SMTP id w129so19043020pfd.3
        for <git@vger.kernel.org>; Tue, 08 May 2018 13:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HhxyIzKLnuR4K6WyPxZOrzWaQzRNcWrCNEjpQ60jt7E=;
        b=ZUfsUmcOHbRFkB2m46LMVvhEj0aUEx1QxfuEI4zWbkaIkvxHEFltsE7tiO95K/873y
         cDLrRsgCsAkiH2DR9bjhoCn2IooNZPlCbAtb2vMIRVsq7tH9ZudB19ynu3TlbPl1RE7Z
         OcslJUq3ZSYoxptZiEeM1R8ddyrOIIfa0GKwj25FsPplaiXRZZUaj7/5BcJE4eJrpRZX
         3WXqyf5mVDpRT/4FBTFHdpi8URHVgEb0edua36OE3OmD69ODGEWRnbdM82iXLYzufEWs
         a7dt7tF9iAJfkEAVMVykeC2qkg7PFf0+nstQ3UcIYWMvRZFGmJNgQYAkdSL8aMqFhVyU
         /Qtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HhxyIzKLnuR4K6WyPxZOrzWaQzRNcWrCNEjpQ60jt7E=;
        b=CZG4MBm0QkxF/Uj/kYN9Tz9mPhdZSrwB0p/hflS9j9V6DS4VqZWyU2T+kcfzD8FV4E
         qAcp46X6TNx0UszAs1nb3ky1NiCjTMZ4t2P5Zi/o7IwibsYRsEMu54mVHJFo2oF9lpqm
         HMJImWC5x2PZvV0tWlfNMay520VZ3r2gaE76827L3s2k8ik+R2Jt+3ONSBxt4W3z74mN
         wK3TccgqDD/TmGS/q/za6PkzGYDBBn7X0fIhZ4zbBM1FqShhbi0/zK0ZBDqZsh0onPKY
         wowa5hnClhCSKeHUQaaftt5oMBxo3rqHlT/5AfyvNZX3xetSt7FGBZJVcwYQxEjrwxsr
         dfpw==
X-Gm-Message-State: ALQs6tCu3yF+4tNWqWlF+obaAVs6Pz64AD8P+PmL2vLtE0LPWwPxLljD
        khekR3hmqiFa8t4uZ69OYUx0fg==
X-Google-Smtp-Source: AB8JxZp1K4w5lDbwtaK4taNtCS3MCUoLkrhiYNSJEQEeW6EvxR0tEQnKj67GuXj4uFXnNU43njTGZw==
X-Received: by 2002:a65:4601:: with SMTP id v1-v6mr22026797pgq.237.1525809874681;
        Tue, 08 May 2018 13:04:34 -0700 (PDT)
Received: from twelve3.svl.corp.google.com ([2620:0:100e:422:ffac:c1d4:4bf7:bb93])
        by smtp.gmail.com with ESMTPSA id i186-v6sm40345303pge.40.2018.05.08.13.04.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 08 May 2018 13:04:32 -0700 (PDT)
Date:   Tue, 8 May 2018 13:04:31 -0700
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, jamill@microsoft.com,
        pclouds@gmail.com
Subject: Re: [PATCH v3 13/13] alloc: allow arbitrary repositories for alloc
 functions
Message-Id: <20180508130431.287a9f273a847c375b3b1e2b@google.com>
In-Reply-To: <20180508193736.14883-14-sbeller@google.com>
References: <20180507225916.155236-1-sbeller@google.com>
        <20180508193736.14883-1-sbeller@google.com>
        <20180508193736.14883-14-sbeller@google.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue,  8 May 2018 12:37:36 -0700
Stefan Beller <sbeller@google.com> wrote:

> +void clear_alloc_state(struct alloc_state *s)
> +{
> +	while (s->slab_nr > 0) {
> +		s->slab_nr--;
> +		free(s->slabs[s->slab_nr]);
> +	}

I should have caught this earlier, but you need to free s->slabs itself
too.

> +void release_tree_node(struct tree *t);
> +void release_commit_node(struct commit *c);
> +void release_tag_node(struct tag *t);

Do these really need to be defined in alloc.c? I would think that it
would be sufficient to define them as static in object.c.

Having said that, opinions differ (e.g. Duy said he thinks that release_
goes with alloc_ [1]) so I'm OK either way.

[1] https://public-inbox.org/git/CACsJy8D-e-bff3S+LQAMfwB-w8OpkjrfFrV9O5S3ku+M5aAjQA@mail.gmail.com/
