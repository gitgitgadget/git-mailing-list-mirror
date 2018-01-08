Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8B28F1FADF
	for <e@80x24.org>; Mon,  8 Jan 2018 22:18:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757415AbeAHWSV (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 Jan 2018 17:18:21 -0500
Received: from mail-qk0-f181.google.com ([209.85.220.181]:45758 "EHLO
        mail-qk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757164AbeAHWSU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Jan 2018 17:18:20 -0500
Received: by mail-qk0-f181.google.com with SMTP id o126so16173119qke.12
        for <git@vger.kernel.org>; Mon, 08 Jan 2018 14:18:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dwnjTB6pLDITXc4eU2U7DgKvnzinxXTEjXVQNluLdxM=;
        b=lJHd3Xn8IAsbUi1kzHiFO8xoqbjIEhVEFnHVHX9HKjsrKHaYABy37hFZ3DFKIR/ZMz
         W7FAz8SazQZjIUQZfsVsdVWfNvk3eOzawNQBP+hJAXcNHbVzmciPshhrJpj1ZfWt/83A
         a1ROVuCbWYgebXk523KVDe39OnxveSY7pr93p1qn4RR4qe5jFM6tm9fYfocqgyjZ0XJH
         3zki6cgLDoOq78nuA/tAoj7OTdsf5/EZQW75H0fA8oCjI7cu1BLAXA1TeZ7sJ0eHTOlw
         lRItb0XfvhaZFMqWd+a6r0i4GS1x/0Rd2AJDmG3QIpWCLvKwBNh0Slam69kapS0dmD7X
         DnhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dwnjTB6pLDITXc4eU2U7DgKvnzinxXTEjXVQNluLdxM=;
        b=YHhooNN4RmFuAsk81y/Cfq96NUPw/eBC6/GNRp7284ERWAhf+l5egmXpfxoE3zdZSc
         YHOs+llPmen4wjsz2VJAcMEOADYyczyZN29r0LPULhlJtcOnWH0GGyG7XgoBOozmmrWL
         VKPedWUEdMCsHL1n4UgzeneZpY+YWh0PZPU3R/gPG+W+jVJ+QUZoTEH7+g1mbxZpf/bL
         saGCEQHCPqa+mjwLgC63fX919Z9tXyOnQmZv6em2Ipyr3VUIa6dCdcQRHx2Ab5aiSDbG
         tEp4eFuffRkXDQhJP+uXhOFreqHf++UaKmrROJMKBNwqEUHRjecqIlWR90gV6Zx/RDiS
         8o1g==
X-Gm-Message-State: AKwxytebPmOXamxmF3PJnGZquJp+D41pLwxFwK8WLkRvDFqUtTM4hXXC
        WX4vTYeiqlL1JCp1R/fXEXGcpw==
X-Google-Smtp-Source: ACJfBouZtcuq0TiHVGMTkhTIZo2G+8ZZxllUGAAJHvbDYSl811etlc6GiHN2rkEdT4MMVLGJlqNVxw==
X-Received: by 10.55.183.3 with SMTP id h3mr19047085qkf.34.1515449898994;
        Mon, 08 Jan 2018 14:18:18 -0800 (PST)
Received: from dnj-macbookpro.roam.corp.google.com.com ([172.23.222.209])
        by smtp.gmail.com with ESMTPSA id r2sm8443654qkb.54.2018.01.08.14.18.18
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Mon, 08 Jan 2018 14:18:18 -0800 (PST)
From:   Dan Jacques <dnj@google.com>
To:     avarab@gmail.com
Cc:     dnj@google.com, git@vger.kernel.org, gitster@pobox.com,
        johannes.schindelin@gmx.de
Subject: Re: [PATCH v5 2/3] Makefile: add Perl runtime prefix support
Date:   Mon,  8 Jan 2018 17:18:13 -0500
Message-Id: <20180108221813.66805-1-dnj@google.com>
X-Mailer: git-send-email 2.15.0.chromium12
In-Reply-To: <877essatef.fsf@evledraar.gmail.com>
References: <877essatef.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, 08 Jan 2018, Ævar Arnfjörð Bjarmason wrote:

> > I'll add a "NO_RUNTIME_PREFIX_PERL" flag as per avarab@'s suggestion as a
> > potential mitigation if a problem does end up arising in Windows builds,
> > with a note that NO_RUNTIME_PREFIX_PERL can be deleted if everything seems
> > to be working. What do you think?
>
> To be clear, I meant that if it's determined by you/others that an
> opt-out on Windows is needed I think it makes sense to make it a NO_*
> flag, but if there's a solution where we can just turn it on for
> everything then ideally we'd just have RUNTIME_PREFIX=YesPlease.

Oh that's fair. Okay, we'll go all in and just have RUNTIME_PREFIX.
