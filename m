Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B60931F453
	for <e@80x24.org>; Sat, 16 Feb 2019 19:37:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732659AbfBPTgL (ORCPT <rfc822;e@80x24.org>);
        Sat, 16 Feb 2019 14:36:11 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:33576 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728102AbfBPTgL (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Feb 2019 14:36:11 -0500
Received: by mail-ed1-f66.google.com with SMTP id a2so10608534edi.0
        for <git@vger.kernel.org>; Sat, 16 Feb 2019 11:36:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=QGP/vwT4P6KXEjh4iFR+0z8W9qT9GrNi0VJszR/zgQU=;
        b=O4scVU4p06u+p1AnrvK8UWy+ox9cCKnKFO0Ckkw0llm8niIEopk8suJN0NN+OSZMaJ
         sW/zAhoK2EX2qeDyLzl/yEDWAToFJ/Q/mHLqMNSt8/nHUt3eviSh+QWZ2qSUK4w5tgKK
         7zp8H9PP3SBlYsdr+mm2zQR7IFvG4pjcVq5aVToLb4GyuXxGeavmgvvfOstxAvyttdyW
         LEYmyiVHUVW0ghJ/PYLXrYjl7qGc8b1M87+bPnE2DXI9VCln3GKvLsgWVXsZ/Jsn84PX
         PCgC7/GJyXrWshZCVroq0BxkQvgSpeHVytrTKBk/sTa2dDWngyWlKj3XPvtK9E/nD3x/
         q00w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=QGP/vwT4P6KXEjh4iFR+0z8W9qT9GrNi0VJszR/zgQU=;
        b=hgCgJF0tWHovM8QF+9jykzrwtqzyIOcZhb+PXcvEaJRS/CQo2Ntk9ssYFi/U5k/8Kk
         A41kiVd6yiQqb6mFJvGGBiP1YAzTyL4Q3t/xzxGhCumntN4Qzf7VK9cITCov1q8QEWX/
         IYSXWVOkul/7zodDmvR9NoYpU+xPWsJWvIO9JEqLU9ZC8MKFiagBzBU2+YT//GNzQfYu
         WfkpUFj0DlhbAKhd9e+iTfaIgUkGegrRfDUK8WO5XrK61nODz1vn12HWFYuR/i+0RPQR
         7PA50Ea4Gk9C5ibyRoWsx1GI9KrAxXlTcReoMmpCNuLe6xIRn+MdECxHMHIMbbKjNmrG
         qdYQ==
X-Gm-Message-State: AHQUAuaGp1PH8BAhcOTdlrWzhrIiBJl1MhtjCyte/1MEOt+UQGsVWn6/
        2A5xp8+Y7iPuju+A/8viGvlm3J+b
X-Google-Smtp-Source: AHgI3Ia3ZggISz6Oz04BPlT8s3ejPUMg03XGvzkPd+o0h/n4atp5Y768l7zd7yHRwXOeNtK3IpYtMw==
X-Received: by 2002:aa7:d445:: with SMTP id q5mr1965948edr.294.1550345768519;
        Sat, 16 Feb 2019 11:36:08 -0800 (PST)
Received: from evledraar (dhcp-077-251-215-224.chello.nl. [77.251.215.224])
        by smtp.gmail.com with ESMTPSA id k26sm2000938ejv.63.2019.02.16.11.36.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 16 Feb 2019 11:36:07 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Per Lundberg <per.lundberg@hibox.tv>,
        Steffen Jost <jost@tcs.ifi.lmu.de>,
        Joshua Jensen <jjensen@workspacewhiz.com>,
        Junio C Hamano <gitster@pobox.com>,
        Matthieu Moy <git@matthieu-moy.fr>,
        Clemens Buchacher <drizzd@gmx.net>,
        Holger Hellmuth <hellmuth@ira.uka.de>,
        Kevin Ballard <kevin@sb.org>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH 1/1] Introduce "precious" file concept
References: <20190216114938.18843-1-pclouds@gmail.com> <20190216114938.18843-2-pclouds@gmail.com>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <20190216114938.18843-2-pclouds@gmail.com>
Date:   Sat, 16 Feb 2019 20:36:06 +0100
Message-ID: <87wolzo7a1.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Feb 16 2019, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:

[Re-CC some people involved the last time around]

> A new attribute "precious" is added to indicate that certain files
> have valuable content and should not be easily discarded even if they
> are ignored or untracked.
>
> So far there are one part of Git that are made aware of precious
> files: "git clean" will leave precious files alone.

Thanks for bringing this up again. There were also some patches recently
to save away clobbered files, do you/anyone else have any end goal in
mind here that combines this & that, or some other thing I may not have
kept up with?

My commentary on this whole thing is basically a repeat of what I said
in https://public-inbox.org/git/87wop0yvxv.fsf@evledraar.gmail.com/

I.e. we have a definite problem here somewhere, and there is some
solution, but this patch feels a bit like navigating that maze in the
dark without a map.

We had users report that the likes of "pull" were eating their data, but
now with this iteration of "precious" only impacting "clean" the only
problem anyone with the current semantics is still left unaddressed. My
memory (I may be wrong) is that "clean" was just brought up (by you?) as
a "what about this other related case?" in that whole discussion.

So as noted in the E-Mail linked above I think the first step should be
to enumerate/document/test the cases where we're now eating data
implicitly, and discuss how that relates to the semantics we desired
when the data-eating behavior was first introduced (as noted in E-Mails
linked from the above, my own preliminary digging seems to reveal there
isn't much of a relationship between the two).

Only when we have that list of XYZ cases we're supporting now, and can
see that XYZ is so important to maintain backwards compatibility for
that we can't change it should way say "we eat your data by default
because XYZ is so useful/backcompat, set 'precious' ...".

But right now we don't even have the list of XYZ or tests for them (as
my RFC "garbage" attribute patch revealed). So this whole thing still
feels like jumping three steps ahead to me in terms of addressing *that*
issue, but perhaps you have some orthogonal use-case in mind for this?
