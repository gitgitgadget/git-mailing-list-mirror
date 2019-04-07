Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8120E20248
	for <e@80x24.org>; Sun,  7 Apr 2019 12:17:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726329AbfDGMRr (ORCPT <rfc822;e@80x24.org>);
        Sun, 7 Apr 2019 08:17:47 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38159 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726049AbfDGMRr (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Apr 2019 08:17:47 -0400
Received: by mail-pf1-f193.google.com with SMTP id 10so5961580pfo.5
        for <git@vger.kernel.org>; Sun, 07 Apr 2019 05:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VglZV+v7KFkJFKuScGURKUdIm8BTTbfm1aEDplyVZLY=;
        b=qhLQqDaQ9AX3SzgosRmJHMhSyBAOm0Ds+fLl8qWl93mZYUZDZ7Njlb0GceUbK5t6Cg
         +L/D6DopjooE+Tvd8Vrz8eiGYkdD27ysUpzd4SOqMRrZ4EyIKzdK8hjujj7X3MDDzumb
         gthggy9m9B60oys1gnQMffu9aRiaeLMZuyhas/IXmWYUD3L40Sj8KWnr5wtZCHUNHHGH
         qNAoIvhxB9ojy/WlGhdEbRcViXkHYAVFdVdiKEfGe6u/hNWmlZj8LuXT+OWTfYy/3QAV
         9VS4ENesFnr/n4RxvFwUUMwCZUVjtI5/EUiuR4sBRQlCMcVgQaoiuUAGJM786A1IxVkY
         XDgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VglZV+v7KFkJFKuScGURKUdIm8BTTbfm1aEDplyVZLY=;
        b=oGS52o2O7HcZbfdNQAf5qprPT8vQzd+f0w5Uuk6yBHNZ+Cu+TskPgnx0NvTv1ENAvr
         wCk0FlmPeSBOEDB3c/TcTiO14RNTByA9GsmbBwqJvAoHELE645sk7ZERGnmBhCL/GKwb
         UJj+OB1ehszy39j6cla+9YrmspxsepkIsERfZ0s/BpLkE/zZgVjObsZEwTx+k3zYkTSe
         TbQqsZm9JYls1Z7PHMzmJEtdl1hiHJZ20wrHQvZzlfaed0U280b4vAL/oyroaVJyYsp5
         +MLAHGE8V4BJHhDmRBGNyq65Eb+r9bBTPsuhsJXnBm7vAxuzwS4lj2BZg1h0D3Nbh88d
         a+0g==
X-Gm-Message-State: APjAAAURVXoO9ku62Flf2TtXt51ylx/HiNVlL5Uk2xF+FJOs32hNC6mx
        s4S935IYDf/R/KCZn3ntkaA=
X-Google-Smtp-Source: APXvYqwX3xh5xzsslMTLt0UrO4nvG45fy9SZxMyeNatI5uX4mcKO6covPpko1QXO9PZ1PpZn5YCfCg==
X-Received: by 2002:a63:243:: with SMTP id 64mr22553717pgc.214.1554639466338;
        Sun, 07 Apr 2019 05:17:46 -0700 (PDT)
Received: from ar135.iitr.local ([103.37.201.45])
        by smtp.gmail.com with ESMTPSA id q74sm22450378pfc.111.2019.04.07.05.17.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 07 Apr 2019 05:17:45 -0700 (PDT)
From:   Rohit Ashiwal <rohit.ashiwal265@gmail.com>
To:     christian.couder@gmail.com
Cc:     Johannes.Schindelin@gmx.de, alban.gruin@gmail.com,
        artagnon@gmail.com, git@vger.kernel.org, newren@gmail.com,
        rafa.almas@gmail.com, rohit.ashiwal265@gmail.com, s-beyer@gmx.net,
        t.gummerer@gmail.com
Subject: Re: [GSoC][RFC v3] Proposal: Improve consistency of sequencer commands
Date:   Sun,  7 Apr 2019 17:46:40 +0530
Message-Id: <20190407121640.3737-1-rohit.ashiwal265@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <CAP8UFD12GXV80SVi5UR=mpBox9DFWw0Fp2wrf+1FEXbUdX1ReA@mail.gmail.com>
References: <CAP8UFD12GXV80SVi5UR=mpBox9DFWw0Fp2wrf+1FEXbUdX1ReA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey Chris!

On Sun, 7 Apr 2019 09:15:30 +0200 Christian Couder <christian.couder@gmail.com> wrote:

> As we are close to the deadline (April 9th) for proposal submissions,
> I think it's a good idea to already upload your draft proposal on the
> GSoC site. I think you will be able to upload newer versions until the
> deadline, but uploading soon avoid possible last minute issues and
> mistakes.

Sure, I'll upload my proposal as soon as possible.

> It looks like you copy pasted the Git Rev News article without
> updating the content. The improvement has been released a long time
> ago.

The intention was to document how the project started and *major* milestones or
turning points of the project. Here they are.

> Maybe s/rebases/rebase/

Yes, :P

> It seems to me that there has been more recent work than this and also
> perhaps interesting suggestions and discussions about possible
> sequencer related  improvements on the mailing list.

Again the idea was to document earlier stages of project, "recent" discussions
have been on the optimizations which are not exactly relevant.

Should I write more about recent developments?

Regards
Rohit

