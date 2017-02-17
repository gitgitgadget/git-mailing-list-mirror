Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID,URIBL_DBL_ABUSE_BOTCC shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DD21C201A9
	for <e@80x24.org>; Fri, 17 Feb 2017 22:12:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935007AbdBQWM0 (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Feb 2017 17:12:26 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:34459 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934956AbdBQWMZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Feb 2017 17:12:25 -0500
Received: by mail-pg0-f65.google.com with SMTP id v184so5885090pgv.1
        for <git@vger.kernel.org>; Fri, 17 Feb 2017 14:12:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=jf/i+lpB4kAsvxi4NqDep2hGS4eJsmTs6LHOwMt2QOo=;
        b=f+H/8L9KwDAAiGv0dXzqKPyGm0R6zJCebbZ5l92BgajfS1nbie0E7VBhyAhKNLewzV
         jCkIeM3gvcd9S8qXePon5AJ9gM7cv/Hqvk9XW/IK87ScM+Zcsq9Nj4exeVLZM0pmoYjL
         9QGov6bzPC6qZE2yyQDzVPVuLsl/JbfO3KWmqomcZIRHtm2bbK7zWurI933X8eeVd/2E
         DrjhmtcQpsMYx2jz0Dm9cIxUGdSTXIrfHh/tZezdN0Qprhkk7OjAigfbrLNqnRnbPDrr
         0ptfpQqEfjywDwsZWYV7N8BiAFK0YGgXuab1tCMKsF8CfblZEWPtn7Ru6ojb0Geqhdcj
         +6pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=jf/i+lpB4kAsvxi4NqDep2hGS4eJsmTs6LHOwMt2QOo=;
        b=CjQxO2T6Xf6Ys9kkua5dd1yX9bzD0vQxcMzE2dA5zyWDLqa/uraOxRzUJZscvs+IMf
         asy50m0nvjQk0KiKZaYL3EcZ3/KpLxKoMxn/QkMfhoEZMvEu69jEmHqts55rVG0n3F8p
         dDojjyWCz3d3tX0Pt8KcskV5dNrKYq3xrF1+1oITN1/emqcn8IKzXo6oe5MDOIeNuAHh
         lVhcJiHQdXjaFmW1dFSPmQopd+VMvIHZbwishLmtuITOVRVp7o+duxod/JaRK1k7IY4C
         yeGrRt7gpg/tfCZwQGel3sp0lYNIaC7XeqMF7XGwBhZkaoaiBi/dCumN6khVV+h/CMuf
         3npA==
X-Gm-Message-State: AMke39nqtiaNocjHQSn0L26VCXYvy9tdM3KF0XTAUpfKPyPwLhaclp2bCH4d8ZpR6Tjz2g==
X-Received: by 10.98.51.70 with SMTP id z67mr11823827pfz.68.1487369544717;
        Fri, 17 Feb 2017 14:12:24 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:3130:38b1:b121:8f0d])
        by smtp.gmail.com with ESMTPSA id g2sm2198706pfg.105.2017.02.17.14.12.23
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 17 Feb 2017 14:12:23 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Gr=C3=A9goire?= PARIS <postmaster@greg0ire.fr>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: dotfiles in git template dir are not copied
References: <ebd661c3-7d99-54d2-dda9-09c4a76cfe93@greg0ire.fr>
        <20170217204411.2yixhuazgczxmmxa@sigill.intra.peff.net>
        <2bae8d8a-f0bf-fa8b-8ce4-6880d3490b43@greg0ire.fr>
Date:   Fri, 17 Feb 2017 14:12:22 -0800
In-Reply-To: <2bae8d8a-f0bf-fa8b-8ce4-6880d3490b43@greg0ire.fr>
 (=?utf-8?Q?=22Gr=C3=A9goire?=
        PARIS"'s message of "Fri, 17 Feb 2017 22:42:43 +0100")
Message-ID: <xmqqmvdkqxfd.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Grégoire PARIS <postmaster@greg0ire.fr> writes:

>> You could, for example, have your template directory itself be a git 
> repository.
>
> I can and I do and indeed, that might be the reason behind this.

An embedded .git was _not_ the reason behind the current behaviour
when we wrote it.  The primary reason is because we did not ship and
did not plan to ship anything .dot in our standard template set and
there wasn't any reason to copy what we were not going to ever ship
;-).

As a justification after the fact, "you wouldn't want to copy .git
do you?" is a good one, though, and I do not think we should change
the behaviour to copy files whose names begin with a dot.


