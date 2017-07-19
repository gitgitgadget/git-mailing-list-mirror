Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2D0F820288
	for <e@80x24.org>; Wed, 19 Jul 2017 17:16:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755640AbdGSRQu (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Jul 2017 13:16:50 -0400
Received: from mail-pg0-f41.google.com ([74.125.83.41]:34448 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755635AbdGSRQt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Jul 2017 13:16:49 -0400
Received: by mail-pg0-f41.google.com with SMTP id 123so2960793pgj.1
        for <git@vger.kernel.org>; Wed, 19 Jul 2017 10:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=RIFoweMedwG0X5OWgzY0xg3f7jwVqeW7KSoiiFJQIAs=;
        b=hG2s0UmIKF57vSag3WqHPZStvWHyGqJfH/uLaTYCGWdx4yAq+4KqcMYEPkpnRuY1z+
         5b2FaVlsEZf8KfnsU/dIPqRPyeVokRucJd47DISq6stFk4ToxiuUQL8Oelqdfv+iTQs/
         I3oPNwXZxmqz9e/WDzt74vMeIcnAniCtF7CM2ZJpslqGNyqsl4sU7FsP0pJNS1qSJJ5D
         c42rOKl92jmpiuZtUFbfd4VVQaNT7Sjhs9rb+DU/ECQdmYWIJdoIgy5ByfUJUw4d3NAr
         FpXgCzZTPM4QEhojSntsZXmhPgMhxvFw8LxihTdj4VuHf7MYoYJAbTRRmoiPL9rKEJrQ
         2Ijw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=RIFoweMedwG0X5OWgzY0xg3f7jwVqeW7KSoiiFJQIAs=;
        b=XL9V1sK5WONus+Qmzt6wTe2XoCWyveDaxAKCx5dnxkLEly/Avzg39ptUEaR32q+bWj
         bFTYg5cowUwE/A7wN/ssl25iojxQQ4861nCSLRympdcoqaVEeX6RL5MOfQMmkP8XRD9f
         1MRCpeCwcpQGtn/BkfVGaLk+os8l6aVuu0tsgwCbmM8EAxE/R5Fp7PHWSEVGCQtFDJFB
         0Jf2xdi8PuX4o5Tq3LXwU5s9wi9uuZ2VWcCyTL88d6kMbO7sy4ulAlTcQrHpkr+iI+tr
         DwqfujoIPGUbHIFueXGOyQOqGNwG2PsBFoHdy6MZCr9X5z+a5djLut92IfQcFyPq5CxN
         l13A==
X-Gm-Message-State: AIVw111c/CDSj1a1BeZewhbhlGHFF+rwkNAXih77GnH2/i3N4JcOFbQf
        1Oo8+wWZbWXCWYGjuNhcapvinG1FyFr+
X-Received: by 10.84.149.197 with SMTP id a5mr876835plh.3.1500484608410; Wed,
 19 Jul 2017 10:16:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.167.81 with HTTP; Wed, 19 Jul 2017 10:16:47 -0700 (PDT)
In-Reply-To: <7151686aba3c5254bfff35bfd7cdd1d48992e99a.1500476164.git.johannes.schindelin@gmx.de>
References: <7151686aba3c5254bfff35bfd7cdd1d48992e99a.1500476164.git.johannes.schindelin@gmx.de>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 19 Jul 2017 10:16:47 -0700
Message-ID: <CAGZ79kb9au53Rp5COvbbvoFToD_g4OAHQAqCFFUYyHi-EA+iAQ@mail.gmail.com>
Subject: Re: [PATCH] run_processes_parallel: change confusing task_cb convention
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 19, 2017 at 7:56 AM, Johannes Schindelin
<johannes.schindelin@gmx.de> wrote:
> By declaring the task_cb parameter of type `void **`, the signature of
> the get_next_task method suggests that the "task-specific cookie" can be
> defined in that method, and the signatures of the start_failure and of
> the task_finished methods declare that parameter of type `void *`,
> suggesting that those methods are mere users of said cookie.
>
> That convention makes a total lot of sense, because the tasks are pretty
> much dead when one of the latter two methods is called: there would be
> little use to reset that cookie at that point because nobody would be
> able to see the change afterwards.
>
> However, this is not what the code actually does. For all three methods,
> it passes the *address* of pp->children[i].data.
>
> As reasoned above, this behavior makes no sense. So let's change the
> implementation to adhere to the convention suggested by the signatures.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>

My bad. Thanks for spotting and fixing!
Reviewed-by: Stefan Beller <sbeller@google.com>
