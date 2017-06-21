Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2674A20401
	for <e@80x24.org>; Wed, 21 Jun 2017 22:51:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751979AbdFUWvG (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Jun 2017 18:51:06 -0400
Received: from mail-pg0-f54.google.com ([74.125.83.54]:36143 "EHLO
        mail-pg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750981AbdFUWvF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jun 2017 18:51:05 -0400
Received: by mail-pg0-f54.google.com with SMTP id u62so63598667pgb.3
        for <git@vger.kernel.org>; Wed, 21 Jun 2017 15:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=leXsDoz1skgT+RhBoTtgc4kk5XId9PjypPbxqpZc/hE=;
        b=tPMhHj0Ih+ZfC/yYH2z7aFt2pPDmBSJja3fSpTyPqbfCM1BKON68iXEqMhwVgRueyg
         nGeYhKcK5BnCUXORDVXhi7Mk6w7fJQR26kOY6d942yVftb+3n67xB5PEJQNCS0xDFxRx
         RfXu1s/UfFFFm09MgAHxJUdFhtYwPdzlYmqiKp48wZEkN3gEf0jhvA5F1kKkEvUUFo22
         3c3F1R0N4jO5VWmpRnvyXxHhK5GMqr1GUXkHs/jyGXGUUDnClAJB5nyqCw4X/WlW640p
         Btsnle1AUPiyLUZ56NWGnpO/yv3pG8RwGHm5r2486jn3asNZxnA+7haHo51PL+5tTdUS
         W7og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=leXsDoz1skgT+RhBoTtgc4kk5XId9PjypPbxqpZc/hE=;
        b=j9Xp0SDkmRFjOHwu6FSyLZKLzP3Z3qhFZHtiy/PsF7Ndl6bdKRRDvNQbzxGaklkrLp
         jOvnte4UZLTwjYnfw704hAtIJaF0G9JZC9iU/yEyAOOuF39nuWXM1/OxMuIXCbEv8ZQO
         lXinhPaYHoFrctVjbJHPr0lk7NK3t8vGYWHYgAJPOLSsIq+kfvM7Pb5v21rXhSRMvXG4
         tjCYSw2K0jQBrcnUTL3MkATxScYbe+wo+YDtQeQNz+nmDKLy8IC/WoL5hZkxnWHpDGRM
         HQJhjbvm7jcq32Z8bWczPNIFxsDazaRNTvR4ABfSX5/f8DCPq+AdS3r957iXZGwUc60J
         UjYw==
X-Gm-Message-State: AKS2vOydKJK2Dsx09sNICjg3ICKi27WGFlOWT1UknsNJY20pXkrrYYiD
        kZUtAVU2lGG5FenT
X-Received: by 10.98.207.68 with SMTP id b65mr38574209pfg.6.1498085464387;
        Wed, 21 Jun 2017 15:51:04 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([2620:0:100e:422:a12e:c584:e29b:1036])
        by smtp.gmail.com with ESMTPSA id q6sm35802398pfi.129.2017.06.21.15.51.03
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 21 Jun 2017 15:51:03 -0700 (PDT)
Date:   Wed, 21 Jun 2017 15:50:59 -0700
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, sbeller@google.com, jrnieder@gmail.com,
        jacob.keller@gmail.com, Johannes.Schindelin@gmx.de,
        sandals@crustytoothpaste.net, peartben@gmail.com,
        pclouds@gmail.com, gitster@pobox.com, peff@peff.net,
        git@jeffhostetler.com, avarab@gmail.com
Subject: Re: [PATCH v3 15/20] repository: add index_state to struct repo
Message-ID: <20170621155059.3ae2c601@twelve2.svl.corp.google.com>
In-Reply-To: <20170620191951.84791-16-bmwill@google.com>
References: <20170608234100.188529-1-bmwill@google.com>
        <20170620191951.84791-1-bmwill@google.com>
        <20170620191951.84791-16-bmwill@google.com>
X-Mailer: Claws Mail 3.9.3 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 20 Jun 2017 12:19:46 -0700
Brandon Williams <bmwill@google.com> wrote:

> +int repo_read_index(struct repository *repo)
> +{
> +	if (!repo->index)
> +		repo->index = xcalloc(1, sizeof(struct index_state));

sizeof(*repo->index)?

[snip]

> +	/* Repository's in-memory index */
> +	struct index_state *index;
> +

Might be worth commenting that repo_read_index() can populate this.
