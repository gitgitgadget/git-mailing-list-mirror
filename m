Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-12.3 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8B4A11F87F
	for <e@80x24.org>; Tue, 13 Nov 2018 00:58:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727357AbeKMKxx (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Nov 2018 05:53:53 -0500
Received: from mail-yb1-f202.google.com ([209.85.219.202]:44686 "EHLO
        mail-yb1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726028AbeKMKxx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Nov 2018 05:53:53 -0500
Received: by mail-yb1-f202.google.com with SMTP id w13-v6so9318458ybm.11
        for <git@vger.kernel.org>; Mon, 12 Nov 2018 16:58:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=NiEizSrYfI7k/v4f2MwNSB9ZV53dJeqcjSD2Oq5FXog=;
        b=hAmCDmrHeEBajU8qDGvX7UWfCOZznRbmQ/v0keMF6/ouzOd+4d95u17U9e/+Xf9aC9
         pCHs4JhJhGTJVYRtyXmyFRBgzS1RmgsZ71cpbCNj3uwqVFlmOC99xnA6RV3lRzx06QGz
         hs0FhlbKsCSnb/dlsErndWnS2hTAW89UOdtngK3JM9hpcBR2q5SsJVeR8a9kiLbDLo9z
         2v7xCIb1Ed7o+fjhScbTjPReCAiYLI2+wwyVO4jDZA9vBOKtE+Iz2LMN6AGPbYoNhor5
         kNzN/fPS5DT4aDj6zqAmaJmMN6lsK1sqvlz5rFNiL4adSWNI639ydKy2fJVgQ5ObaNT2
         Ec9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=NiEizSrYfI7k/v4f2MwNSB9ZV53dJeqcjSD2Oq5FXog=;
        b=kM27YkEHxS/qjBLzgA/ILmPIh7TKEHzzVW38mqr8Lk4T+UNU3JtVqAAQBKMRf+Ugpl
         4U7iQllRIF7UUU9i8hbLm4+pf/Fi+gInZyGlkpjk1CsZZjAHHmobz67FQNvw1lLyD/xB
         NcRjAb2EHMWXVlTRJB3xDfLbziNwq8ix11CUcFJKD0k6rELuNBkHNBcQqbnt3970HeUa
         +opv/28E50gyPLlyk0XPvfd7eah8gjeUzt//lWlAa1kU0kZdMC9mGRx2HFwfUJmKRVy7
         muVp6/PiiL4jDL4xj6b+81ZGD9GCevMDaK8R+O8ubK4Pg8JdIGGttbo/7a+J44Gji98Q
         ACHA==
X-Gm-Message-State: AGRZ1gLkHrCPvpPpcMqlc/5Ns+QZDRfLY+mc4vkXGcwPUOokyGZr+uUf
        rqUm6ZMa5uiaYV1kni78/l6QRxU/cx22njnnOw4N
X-Google-Smtp-Source: AJdET5eIiNeWE2Dw2NNfntKB3LtbFRn3EwNdE602G+YvWLwQ7jwvBmenT1xdDClTDjWbvxXChFgh4NOpymwTzwvhE3aE
X-Received: by 2002:a0d:d3c3:: with SMTP id v186-v6mr1577170ywd.14.1542070694092;
 Mon, 12 Nov 2018 16:58:14 -0800 (PST)
Date:   Mon, 12 Nov 2018 16:58:06 -0800
In-Reply-To: <20181113003938.GC170017@google.com>
Message-Id: <20181113005806.128469-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20181113003938.GC170017@google.com>
X-Mailer: git-send-email 2.19.0.271.gfe8321ec05.dirty
Subject: Re: [PATCH 2/3] ieot: default to not writing IEOT section
From:   Jonathan Tan <jonathantanmy@google.com>
To:     jrnieder@gmail.com
Cc:     peartben@gmail.com, git@vger.kernel.org, gitster@pobox.com,
        pclouds@gmail.com, benpeart@microsoft.com,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> +index.recordOffsetTable::
> +	Specifies whether the index file should include an "Index Entry
> +	Offset Table" section. This reduces index load time on
> +	multiprocessor machines but produces a message "ignoring IEOT
> +	extension" when reading the index using Git versions before 2.20.
> +	Defaults to 'false'.

Probably worth adding a test that exercises this new config option -
somehow create an index with index.recordOffsetTable=1, check that the
index contains the appropriate string (a few ways to do this, but I'm
not sure which are portable), and then run a Git command that reads the
index to make sure it is valid; then do the same except
index.recordOffsetTable=0.

The code itself looks good to me.

Same comment for patch 1.
