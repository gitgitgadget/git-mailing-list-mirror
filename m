Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BD20720248
	for <e@80x24.org>; Mon, 18 Mar 2019 01:28:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726932AbfCRBZh (ORCPT <rfc822;e@80x24.org>);
        Sun, 17 Mar 2019 21:25:37 -0400
Received: from mail-wr1-f54.google.com ([209.85.221.54]:34778 "EHLO
        mail-wr1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726735AbfCRBZh (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Mar 2019 21:25:37 -0400
Received: by mail-wr1-f54.google.com with SMTP id k1so14710472wre.1
        for <git@vger.kernel.org>; Sun, 17 Mar 2019 18:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=R3576xFp8slsVPP/yMaVxMbYWanqO/ZstneAflzpP5I=;
        b=s9PRImyh72bAwenEpXHvY/7S8vI0zO/T29yuQsBTDLKYN4JyvHIsnixktxGwyfwIj0
         OIIDzS+2P/AfN2GxR3U5q3rE5LQd2mBRQcpvUfuwyX92AtRLVL5kHJGzrL+RENRdSllJ
         ArvRRBNkcwKLobhEhY+pAIzZ6cAz6YLsg00kO/8xL0zLwR3xSvCf5tEytrYAOsOpNP6o
         QJ7xmUVJBZ/rpjU7+TvUpiwYr35Lnq1siHncIJUhgEEUwkxZxxldc24Q9YGGfrYidI2E
         17bm/cdTd+K4pbBal+kFZcEbwMZwZ+KPpLqpFHxH79vo5dkTYelOFCavQeKVqNJWNxDv
         m6ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=R3576xFp8slsVPP/yMaVxMbYWanqO/ZstneAflzpP5I=;
        b=SuL51omX+h+SPqgKPYRrczUxvXojjuQOl8RqdmlUu9FfnsLdzWNC4r2zf9blOgeLJF
         uD8x0zY9eUuwz29mAOYpEc/CAfS7Wsbatulxh3CAWjlQLgU3iLB5GpMZMWoVsnAYzRlB
         6VYR/EtUBgQQLfYw4Iu3X+wpbXrsPRpTVzHwWL+aAOi3eDlczKrftRY59ujAGM0QEPAt
         u5acTjeRlVjsoXk5EsKYwZ0L+cs5jTUT1fy2x+hOhgC4VbEkl61nC11C7OT1qxy8i5k7
         lNlF1QOu+ZFigDjBSkf6ws5AsbHOocFdbE2BYAH158pzLUjDIuF/Ajqki/oEFWdLQOPg
         p5WQ==
X-Gm-Message-State: APjAAAW9HP4GDsGrghZKNdlPYqmgjMMTMeR06LkOyVQbMoZrH60ZtQvR
        oCTaDw3N5OiOSNcYrUetfCY=
X-Google-Smtp-Source: APXvYqyLycoNv16ph9/ierzzBvCHrXyqFw2vXnklmo0KyOI/89wdD3elIabeoiDI/DL0D6SQqtHFsw==
X-Received: by 2002:a5d:4606:: with SMTP id t6mr1658365wrq.43.1552872335354;
        Sun, 17 Mar 2019 18:25:35 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id q24sm6375192wmq.5.2019.03.17.18.25.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 17 Mar 2019 18:25:33 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: am/cherry-pick/rebase/revert: document --rerere-autoupdate
References: <xmqqef7a9hbx.fsf@gitster-ct.c.googlers.com>
        <20190314191234.25553-1-phillip.wood123@gmail.com>
Date:   Mon, 18 Mar 2019 10:25:32 +0900
In-Reply-To: <20190314191234.25553-1-phillip.wood123@gmail.com> (Phillip
        Wood's message of "Thu, 14 Mar 2019 19:12:31 +0000")
Message-ID: <xmqq7ecx7z3n.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

> I've squashed the first tree patches together

Thanks.  The result of the series has no changes and that is good.
