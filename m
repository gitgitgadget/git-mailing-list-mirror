Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9126F1F453
	for <e@80x24.org>; Mon, 28 Jan 2019 19:00:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727257AbfA1TAu (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Jan 2019 14:00:50 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38039 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726678AbfA1TAt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Jan 2019 14:00:49 -0500
Received: by mail-wr1-f66.google.com with SMTP id v13so19288466wrw.5
        for <git@vger.kernel.org>; Mon, 28 Jan 2019 11:00:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=aL1QPIp+B/yTuxie+fMY9NhAItFdBkBQf4jp0mwiwZA=;
        b=ZE0/AkobL2Zktz/XM0qZ/BQk4rcrrIx9YXU6GTFzHIBSWUo9RYDqIdQ+ukRNzAOXS8
         Fpus3xN1Ot2+cByY2Il/p2tLSoyQjwmMWyOxQ+xA7Gz/c32yTQrEis6xZU/+NWfJs+1v
         vVIu2OdSr8qCoXEwpkhpqnuqzPKY1UcIyq+vDlBn6FajbxAU6/IfpDpcb6e1dm/epKi7
         +xIrvaqe3pcrmRzNU1CDyNWlGRr1MLycKfTGqHPcH6whehEIv77MFXTRmftBZkjelWSa
         tJpPt5fP4H9trr8JmHKcz0Xly8fL6W/Q+tY4UHPxSGwrDLD4g9iFKo5LVOVmX8DTCdI2
         TjcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=aL1QPIp+B/yTuxie+fMY9NhAItFdBkBQf4jp0mwiwZA=;
        b=XsXR0eeF5yM3jtdVfKJI5e/c1vwV291rbxO/qxLzO5VXOAo8t15NQfosWsOk4p2rna
         om/rg1iN+yrWg/PzN6pc+dhrDKPOF35qb9Kwz8U4VLMFUZYCZA1/ERXvP3dIgN2FNzgE
         9lmOMsAxmWqntD1Npz8RnaRjNuypW1E6BW/SA+VQFnkLFztYj/Gh/KG+ke6je7aRf1aD
         PbIWayv2syoFy3n27Bub+LAAL7TXI3iuiHeTu2eoZkLwZ0tFgVwdOjo8AsBj/8D2/lga
         Cja4Jht7IlgvwLX0opHtUwho3eAbD8nfL7e2jIAGwqrVTOmoaCDSnhJu+jNv/abtcw69
         8aAg==
X-Gm-Message-State: AJcUukd0kmvbP8xN9Sh3zDocaIptYxJ+BKk+y0HriFRE32lTxQqx2U8S
        odXeID58aBiDgcf3nqKVjhM=
X-Google-Smtp-Source: ALg8bN6Wg1CDPWvhb5yi/TP2ntV6GlnXmMBPsUYO77lLy29aG4ZBMT7ab4aS/rMCnvW/54/2u7pvwg==
X-Received: by 2002:adf:f390:: with SMTP id m16mr22123596wro.71.1548702047842;
        Mon, 28 Jan 2019 11:00:47 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id c14sm300677wme.13.2019.01.28.11.00.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 28 Jan 2019 11:00:47 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     William Hubbs <williamh@gentoo.org>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, chutzpah@gentoo.org
Subject: Re: [PATCH v2 1/2] config: allow giving separate author and committer idents
References: <20190125215955.30032-1-williamh@gentoo.org>
        <20190125215955.30032-2-williamh@gentoo.org>
        <877ees4a65.fsf@evledraar.gmail.com>
        <20190128185817.GA28155@whubbs1.gaikai.biz>
Date:   Mon, 28 Jan 2019 11:00:46 -0800
In-Reply-To: <20190128185817.GA28155@whubbs1.gaikai.biz> (William Hubbs's
        message of "Mon, 28 Jan 2019 12:58:17 -0600")
Message-ID: <xmqqr2cwa9pd.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

William Hubbs <williamh@gentoo.org> writes:

> This doesn't look like it is beyond 79 characters to me, but that may be
> because I use a tab stop width of 4.

In this project, a tab skips to multiple of 8.
