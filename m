Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 80D811F85A
	for <e@80x24.org>; Tue, 10 Jul 2018 12:21:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753168AbeGJMVg (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Jul 2018 08:21:36 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46485 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752001AbeGJMVf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jul 2018 08:21:35 -0400
Received: by mail-wr1-f67.google.com with SMTP id s11-v6so14382638wra.13
        for <git@vger.kernel.org>; Tue, 10 Jul 2018 05:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=tpHly7neObmfHUDx4adpj1Fk6ysZ4BvE5L7s1U8S7uk=;
        b=YNFzKxKFawTPvv4pU3dIvg5ZVOV8fyrxwhUo+dqF0KIXrgnQmfj2/pYmvdZqvZttyy
         n4wjmyGV23NBV0IFcin/0lz0wt8X3sOObUVgW3XSbVwuxOw+3ISuSvSxFTkC86oYY/eq
         El64rTSmJHOPcHf8q1Ajc1jzEUnL7MXg2ZbJ+NwY47fBG8yVwYp2r2aIB7s6eU3g+ezP
         Z+igvVjGy8TN9lsLXSqtJCXxHnEbiwQkjbuyCDLPPf0W+LFfbhdDj5j0Mwkj32fz2YuI
         HvYT4yYTqzzN1W++Kr5JbOv1qar94JaLwfqvPEarVuPgvUf8E4GjcBiCs0mPXPdWu5ry
         QKbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tpHly7neObmfHUDx4adpj1Fk6ysZ4BvE5L7s1U8S7uk=;
        b=mGyg654A0oJ+ydNpd6Ehsfb8QT1skzkhSIWqPcWga5Mz9JxiX481tR+In4PEuDEGvk
         6WtLSQeEER+ggV5snozhjrs8UvuJ8odc6qSpswJjqc2PJjAP2bIuWM6sAYpCDTqjozJZ
         6d5nfVOggaDYjwdi3dLasndf6TtLkYuBCDwfZTQrLY5cWFnuPno1bD7msyo7X2XYAq7f
         nrUFMmtoQDgNJmVK3WlcNjc9p+Tht+lx+t1CC5rFkPkfGm8e8BD7CsWrP8TZtDEpgtBt
         cc1DmnqyPj4GpIzLDwaf4sSmDUaOaq8auGxmAfaV+AMr1qizH5SI03vxqsKQNurl/itc
         PAdA==
X-Gm-Message-State: APt69E0v6tpCfzJv1kSzUTtJ28f+UUU5SL1ezzB13gsILIhJK4iGurVL
        /0+EdvVbKss0sWkB1/fkD0g=
X-Google-Smtp-Source: AAOMgpeMYOCrj83+UMb8u4Pw5iZNPzNmUQp3N6EZw3FVY2f9eQj648u+tKTIpTCoaflN4OIWG6t51w==
X-Received: by 2002:adf:c74e:: with SMTP id b14-v6mr16446450wrh.16.1531225294710;
        Tue, 10 Jul 2018 05:21:34 -0700 (PDT)
Received: from [192.168.0.104] (AToulouse-658-1-239-37.w90-38.abo.wanadoo.fr. [90.38.238.37])
        by smtp.gmail.com with ESMTPSA id x6-v6sm20682385wrd.57.2018.07.10.05.21.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Jul 2018 05:21:33 -0700 (PDT)
Subject: Re: [GSoC][PATCH v3 02/13] rebase--interactive: rewrite
 append_todo_help() in C
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        phillip.wood@dunelm.org.uk, gitster@pobox.com
References: <20180702105717.26386-1-alban.gruin@gmail.com>
 <20180710121557.6698-1-alban.gruin@gmail.com>
 <20180710121557.6698-3-alban.gruin@gmail.com>
From:   Alban Gruin <alban.gruin@gmail.com>
Openpgp: preference=signencrypt
Message-ID: <2d451b5c-a819-7e44-bdc7-9340b5b55992@gmail.com>
Date:   Tue, 10 Jul 2018 14:21:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180710121557.6698-3-alban.gruin@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr-FR
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Le 10/07/2018 à 14:15, Alban Gruin a écrit :
> This rewrites append_todo_help() from shell to C. It also incorporates
> some parts of initiate_action() and complete_action() that also write
> help texts to the todo file.
> 
> This also introduces the source file rebase-interactive.c. This file
> will contain functions necessary for interactive rebase that are too
> specific for the sequencer, and is part of libgit.a.
> 
> Two flags are added to rebase--helper.c: one to call
> append_todo_help() (`--append-todo-help`), and another one to tell
> append_todo_help() to write the help text suited for the edit-todo
> mode (`--write-edit-todo`).
> 
> Finally, append_todo_help() is removed from git-rebase--interactive.sh
> to use `rebase--helper --append-todo-help` instead.
> 
> Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
> ---
> Unchanged from what have been queued on `pu` (ag/rebase-i-in-c), and
> from v2.

Sorry, this has actually changed since v2.

