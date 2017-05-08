Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 091A520188
	for <e@80x24.org>; Mon,  8 May 2017 00:28:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750968AbdEHA2C (ORCPT <rfc822;e@80x24.org>);
        Sun, 7 May 2017 20:28:02 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:35694 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750782AbdEHA2B (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 May 2017 20:28:01 -0400
Received: by mail-pg0-f68.google.com with SMTP id i63so8176677pgd.2
        for <git@vger.kernel.org>; Sun, 07 May 2017 17:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=tlZt5IwWaF3IJv15nX/dizdbQFA8J8YqmAO/fyRjPyo=;
        b=kH01RQ+8kqFWzOuLZkCfQMk266Q1qr0mlp9kS6bmLRE3F87Z0V59sk0jEesJnfbWvo
         pa7epGMmwQbVpwCsx3BtXNkPrhSSqubi2JsY2GrkbwHS6xHvtZIOlvA109H4y91mlrXn
         lOm92/TIbcvm2zmDNn+ZkuPoMYGMExZClD0X8tNtA9WzDbJwT3Wt128t+Z7Kru7lBd2C
         unVW+pvijJEYb7UtDyXUbI5XOwcfF+L8Ioz7jCVJyRtEfHYXqZrzgGC5GInoJEHEg/y8
         DtFkJKnIP+3MeDKa0WhKTSD51v8bxctJPDWuSxZfn6p7jwrQljhjoB9T0xKcKeh/43ny
         53FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=tlZt5IwWaF3IJv15nX/dizdbQFA8J8YqmAO/fyRjPyo=;
        b=Y5q75q/l6RQairL/IR4jb+U38EaFxwU7g0UHnEMsfo38ClYQUEvFaFoQDPah5r2vWj
         NoqN7PBnzWeYSmMuUN/nAJt6tPmoktRRBVRyzBJzV0zm0L50sCj5DbQk/j0QuRS4aQTv
         p1msQrUbS6NfpnoQOByb3A1Gt2aMDP4L9jOB9in7r3V4LOg2ynt+iysvTyOCQw5BhlzT
         ri23JE2iTOpQD393b7PkROcfptmS7ObIsgnm98FZRParAupnffMb9lPD6BXKdVCzzySA
         dtKfYwpl0J0oHQzPuwjEGmmLyHeUySVXMMWBlJmv7PySxYL45MarO/bs10BStuYc57qK
         fCFA==
X-Gm-Message-State: AN3rC/5cXIVn3sV4OMRWUJBj0TWlC/FMMU1MQBsgzqbWd271pX9cKxBN
        0CesTZcrxxTcCw==
X-Received: by 10.84.241.206 with SMTP id t14mr23950940plm.48.1494203281111;
        Sun, 07 May 2017 17:28:01 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:3011:642f:81a0:efbd])
        by smtp.gmail.com with ESMTPSA id 20sm27593746pfq.42.2017.05.07.17.27.59
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sun, 07 May 2017 17:27:59 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Liam Beguin <liambeguin@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH v3 0/6] rebase -i: add config to abbreviate command-names
References: <20170502040048.9065-1-liambeguin@gmail.com>
        <alpine.DEB.2.20.1705021741580.3480@virtualbox>
        <1493769381.29673.39.camel@gmail.com>
        <alpine.DEB.2.20.1705031315460.3480@virtualbox>
        <xmqqwp9x9prp.fsf@gitster.mtv.corp.google.com>
        <1494177195.32697.2.camel@gmail.com>
Date:   Mon, 08 May 2017 09:27:59 +0900
In-Reply-To: <1494177195.32697.2.camel@gmail.com> (Liam Beguin's message of
        "Sun, 07 May 2017 13:13:15 -0400")
Message-ID: <xmqqo9v4chv4.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Liam Beguin <liambeguin@gmail.com> writes:

> Sorry for the delay, I don't mind switching to C but it would probably
> be easier to see if the scripted version gets approved first.
> If it does, I could then get started on the C implementation.
> If you prefer I could also forget about the scripted version, make a C
> implementation work and see if that gets approved.

I am not sure what "approved" would mean in the context of this
project, though ;-) Your patch to the scripted version would
certainly not be in the upcoming release.  If you define the
"approval" as "it is queued to my tree somewhere", the patch would
start its life like everybody else by getting merged to the 'pu'
branch, where there already is a topic that removes the code you
patch your enhancement into.

The list _can_ agree that it is a good idea to have an option to
populate the todo list with shortened insn words from the beginning
(instead of merely accepting a short-hand while executing), which is
what your patch wants to do, without actually having the updated
scripted "rebase -i" merged in any of the integration branches in my
tree.  If you meant by "approval" to have such a list concensus, I
think you may already have one.  I personally do not think it is a
great idea but I do not think it is a horrible one, either.  As long
as it is an opt-in feature that many people find useful (which may
be the case already, judging from the list traffic), I do not mind
;-)



