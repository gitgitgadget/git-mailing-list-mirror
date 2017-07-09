Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 91FDB202AE
	for <e@80x24.org>; Sun,  9 Jul 2017 18:52:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752568AbdGISwQ (ORCPT <rfc822;e@80x24.org>);
        Sun, 9 Jul 2017 14:52:16 -0400
Received: from mail-pf0-f178.google.com ([209.85.192.178]:34860 "EHLO
        mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752430AbdGISwP (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Jul 2017 14:52:15 -0400
Received: by mail-pf0-f178.google.com with SMTP id c73so39161375pfk.2
        for <git@vger.kernel.org>; Sun, 09 Jul 2017 11:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=GX52Mz95lPjUzPENOxflEQG8W6mWWCtdh8Gx4TmoDEs=;
        b=MgagZMsUpB7xPNRQbTy6YpFQpczlJbPjKOBPTRbC4X6xRnuXvPmpR33qU986oaR6VF
         SzynITUUVKJkH69x58WhJyUC5BD2AN2KDon8I0XF4R4vAAVob7uo/b7BYeUsyil1Fp0M
         dzR6BkAy5Xtw0nXL8HKt0ZyNkWQ5joY2L0WdvoxJgAj/emCBR4QFTGEq+3ie+ctzNg7m
         AgGL3TdvK2qxMkT6xP7U1Gn7RcUItOEhLRkZMQea78oAGe5/Gq0jGkHtlS+85ifQlE4z
         0QfW+O6/u4i0HpYQyV9x6TRlzoaWtD3iJdvAGMwEOzSShu8nzrfOTNesFGvTjB6JSdfc
         Is6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=GX52Mz95lPjUzPENOxflEQG8W6mWWCtdh8Gx4TmoDEs=;
        b=loj97JKk9d4IivvByvihymYWm86K5xyi8zGEI8en9uOlpMEcoqV7Y/1OuJtKLP1QAP
         iolI1hUhPan1GhvIcg9DN38Lz+8sZLxPvg3eo+5hBGQHy257LdrSSRs2uqWSL6TwB1EW
         IgYNS2ZAN2ugL1XnuP98w92O6czF7vG1ecn67v2rf6TINmas26dS6KTNGUsZgdNgDvfO
         w+MeqXjOhWlLDYZpx3BHx89Vbs6xnrNdy7eTdiDJM42Z0qqKbJxzATtSVCZeXS8qAJgg
         Yi9lO+APIHt/LE4RWIOB9nGZftKcAoMP2TbR1baIheSZGXnG87pG9W/HCEEmTzVTgO0Y
         FVAw==
X-Gm-Message-State: AIVw113ZtunrIwxQMMjx8wkgAJAx95dDsLmmi3SOc6c21hRRkanv/Vu8
        Mz7pbQ90W69Vh/hJk/g=
X-Received: by 10.84.241.4 with SMTP id a4mr14368208pll.160.1499626334538;
        Sun, 09 Jul 2017 11:52:14 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:dc1e:60e1:7751:9c92])
        by smtp.gmail.com with ESMTPSA id n71sm20757906pfi.95.2017.07.09.11.52.12
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sun, 09 Jul 2017 11:52:12 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Toralf =?utf-8?Q?F=C3=B6rster?= <toralf.foerster@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: enhancement request : If 2 commits to be squashed together do have the same title and comment ...
References: <66e0ec72-699c-f71b-55c7-e1f780111853@gmx.de>
Date:   Sun, 09 Jul 2017 11:52:11 -0700
In-Reply-To: <66e0ec72-699c-f71b-55c7-e1f780111853@gmx.de> ("Toralf
 =?utf-8?Q?F=C3=B6rster=22's?=
        message of "Sun, 9 Jul 2017 18:48:02 +0200")
Message-ID: <xmqqlgnx8muc.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Toralf Förster <toralf.foerster@gmx.de> writes:

> ... then jast squsash them w/o questioning.
>
> Is this a valid RFE ?

In the form, it is valid---sending a message to git@vger.kernel.org
is the right way to describe a problem and ask for a help (or better
yet, propose a solution ;-).

I am guessing that you are talking about "squash" in "rebase -i"
command?  If so, instead of saying "squash", you can say "fixup",
which will squish the change into the commit to be corrected while
retaining the log message of it, which makes the new feature you
are looking for unnecessary, I think.

Unless I misunderstood what you want, that is.
