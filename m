Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6AB3E1FF1E
	for <e@80x24.org>; Mon, 30 Jan 2017 22:00:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752618AbdA3WAh (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Jan 2017 17:00:37 -0500
Received: from mail-pf0-f193.google.com ([209.85.192.193]:35791 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752115AbdA3WAg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Jan 2017 17:00:36 -0500
Received: by mail-pf0-f193.google.com with SMTP id f144so24343189pfa.2
        for <git@vger.kernel.org>; Mon, 30 Jan 2017 14:00:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=H3RE20IsyNz21Sbi0kOHNOLGe4Wv2mfwy6zw6AKZ7hU=;
        b=XwumCJS3XI9hFzEzSOIoZRl8AW0oowPCiLQ8yWJDBD4zAgi/CT+v5C1Wz502g2bTpY
         5PGkko17/68Hyc6LEH6ZaJaHA9P0hBjzWdT3fLPDwYU5AoWNjSrBaSCkOAkqQ5h7cwPu
         zvXsgqqRBMaI9M7L1owFqb8cSihyOh7tg+KupT4k174/PbN3FMccFrF17U6l0s2gmapy
         /Dc9Zo3agIcsIL0vpmta1gUymfxZfIXB7+8aoEZMwUrBlTKN+LVPuSYAnfdLh/8z0Yw9
         QgH22x3as7xA6Jra3v2UgmF9Nox5T4+qLRW3SSFrc+uWY3tg+hEuXs3PyryBYl0YbFc9
         v8cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=H3RE20IsyNz21Sbi0kOHNOLGe4Wv2mfwy6zw6AKZ7hU=;
        b=Ic/h/jyFHpTUruhWPcrxBHMuGBnzYamSAFMHaNOPgde2EK3NY6F1ePG7UxoIyzqBIA
         KnopTRhS6V/V839AfHJe7hYAaFiMilGPSmlqK6rOQrWUnYSTAtuCssNpWZMQuZ4Q0+p4
         qlfaLmXSUHBVP9qZrEfDv8G/+b/aAXu3dPWFgEY+1UDOb5RWKs4mhKKExAeccs/8C4Cg
         j3IRQbVk1zZygUaQyuKFpHPaDHn5FY4zaMb8XwjLbNEKUWIPeE3UDKeHN11LX/3DiD47
         UpkpnrcVBCWOHTmUxca8ggxdPMUnhuqtSTLBXnCABoF7zen+oWg93964QF8+5ZUGSOm0
         T6Kw==
X-Gm-Message-State: AIkVDXJCc6yF+ausPjdDjfIUQFsLf7K1fctHUuhKebqsA84TvXGkc3+lX+szrp7mIlH57A==
X-Received: by 10.84.233.133 with SMTP id l5mr34589156plk.129.1485813635533;
        Mon, 30 Jan 2017 14:00:35 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:a9ce:56f8:45fd:fc63])
        by smtp.gmail.com with ESMTPSA id b75sm34995885pfb.90.2017.01.30.14.00.34
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 30 Jan 2017 14:00:34 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Patrick Steinhardt <patrick.steinhardt@elego.de>
Cc:     git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>,
        Philip Oakley <philipoakley@iee.org>
Subject: Re: [PATCH v4 0/5] urlmatch: allow wildcard-based matches
References: <20170123130635.29577-1-patrick.steinhardt@elego.de>
        <cover.1485512626.git.patrick.steinhardt@elego.de>
Date:   Mon, 30 Jan 2017 14:00:34 -0800
In-Reply-To: <cover.1485512626.git.patrick.steinhardt@elego.de> (Patrick
        Steinhardt's message of "Fri, 27 Jan 2017 11:32:13 +0100")
Message-ID: <xmqqy3xstdh9.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patrick Steinhardt <patrick.steinhardt@elego.de> writes:

>  - I realized that with my patches, "ranking" of URLs was broken.
>    Previously, we've always taken the longest matching URL. As
>    previously, only the user and path could actually differ, only
>    these two components were used for the comparison. I've
>    changed this now to also include the host part so that URLs
>    with a longer host will take precedence. This resulted in a
>    the patch 4.

Good thinking.  I was wondering about this, too.

Thanks.  Will read it through and replace.
