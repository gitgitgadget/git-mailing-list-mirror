Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E4511F516
	for <e@80x24.org>; Mon, 25 Jun 2018 16:34:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932758AbeFYQe5 (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Jun 2018 12:34:57 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:45808 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752582AbeFYQe4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jun 2018 12:34:56 -0400
Received: by mail-wr0-f194.google.com with SMTP id o9-v6so105992wrs.12
        for <git@vger.kernel.org>; Mon, 25 Jun 2018 09:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=ztleENeEHblhlyURblysPomkoi3U3/rg/B9I2LzokKk=;
        b=SrbDiO4v8pfG0fEFzJPDTB9T9j6zbUvUTe/XZNCVkt3u0Tpgegmv5wGwhQxjFqegzu
         Cj/mjZH6xjknBefJxxQUTD4iuo7bIrxY+lV2S5s8XTOqThkPuen/P9MbwraGqrmy8h5H
         arxVdMoFTVccDPhzJSJaEyPnbND0JURPs/IdIVdyky2WpDDJanMx7tA459KefwcRMCfb
         fzYicsYcCelamYbujPTgNgzWiouPY6ZOVa97L9ezrEsuxkJXpMKT5tVBEvzdXq0nUgHe
         Nwelz0xvJPjDQe8TB61a/dqtMngDvKUH3tR1ka1sTIaFjtcLEL8WMH1nA9+xXUUsPY8u
         pz7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=ztleENeEHblhlyURblysPomkoi3U3/rg/B9I2LzokKk=;
        b=bmeTo7Mdg+qViiUW4fVMSC8JoIEdt2Z/6n0t0uctsbimINSA5mt1NMElPc4Paj00Q5
         6mfUrCo47qHGetkUAD4ulECNeEgVAgGOic291IMEwluaJkngDqqtmc7rJHCwAsc1AnAf
         sKThE42WuGenMJzt7kF4l0uifbbh3eeeK7EcMLtiM9cVPC30E27ROc4qxEjFYTR+nawZ
         vpqjMMZkzGcEOLe4qfA27PzC++h/EsJLiUJdqkZKP/5KClgdjuDukCgrHTxei6dEprix
         b/rM9xbliWq1twZ9e9MV9dKs751gG9cT2ents+NkykHqhpLw1TO/TljYv3NzHnaff1ip
         iXUQ==
X-Gm-Message-State: APt69E3IgYo2R0ipzV9Hb1tfUjFjZPwk2efg0C1AGM0rRcikxcX3yi/L
        zqUHiZhRa4s+uIlycvk07lHk9QgS
X-Google-Smtp-Source: AAOMgpcqOeOv+1kQZJ8lJ2TgcA4MpfrJUfG6J65iL8chGHUnA2OiB/R3DHD3j4p30D5HAYkTQ3gQag==
X-Received: by 2002:adf:8dad:: with SMTP id o42-v6mr4934054wrb.274.1529944494710;
        Mon, 25 Jun 2018 09:34:54 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id w126-v6sm9428638wmw.29.2018.06.25.09.34.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Jun 2018 09:34:53 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Bryan Turner <bturner@atlassian.com>
Cc:     marc.strapetz@syntevo.com, j6t@kdbg.org,
        Git Users <git@vger.kernel.org>
Subject: Re: Unexpected ignorecase=false behavior on Windows
References: <c5abdd45-a919-96f6-8560-5fd943069f5e@syntevo.com>
        <1c7e338e-157b-fd2f-5eb1-01373f627acd@kdbg.org>
        <2cf2d884-de1a-7b9b-5aca-1f396ad205a2@syntevo.com>
        <CAGyf7-GvcN8EhMgtaZcDJNYNdfLwVH8HVBDmZqJU40nze0NSEA@mail.gmail.com>
Date:   Mon, 25 Jun 2018 09:34:53 -0700
In-Reply-To: <CAGyf7-GvcN8EhMgtaZcDJNYNdfLwVH8HVBDmZqJU40nze0NSEA@mail.gmail.com>
        (Bryan Turner's message of "Fri, 22 Jun 2018 13:58:57 -0700")
Message-ID: <xmqqfu1aq0ya.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Bryan Turner <bturner@atlassian.com> writes:

> Git on Windows is not designed to run with anything other than
> core.ignoreCase=true, and attempting to do so will cause unexpected
> behavior.

Even though I fully agree with your conclusion that the document
must make it crystal clear that core.ignoreCase must be set to
reflect the reality, I found the above statement misleading and do
not want it to be used as the basis of a documentation update.  But
it is possible that I am misunderstanding the current state of
affairs.

Is the case insensitivity that deeply ingrained in the Git for
Windows code?

IOW, even if the code used to build Git for Windows were executed on
a case sensitive filesystem, is there a case-smashing code on _our_
side that kicks in to cause unexpected behaviour, _even_ when
core.ignorecase is set to false to match (hypothetical) reality?

To put it yet another way, if a case sensitive filesystem were
available, wouldn't running "git init" from Git for Windows in a
directory on such a filesytem set core.ignoreCase to false in the
resulting repository and from then on wouldn't everything work fine?

If my suspicion (i.e. the code for Git for Windows is perfectly
fine---it is just the users are not running with case sensitive
filesystems and flipping core.ignoreCase to true does not make case
incapable filesystems suddenly capable) is correct, then it is not
"Git on Windows is not designed to run" from two angles.  (1) it is
not just Git for Windows---Git running on UNIX that mounts VFAT, or
Git running on macOS with default HFS+, would exhibit the same
symptom, and (2) it is not "Git is not designed to run"---it is
core.ignoreCase that is not designed to be a way to make case
incapable filesystems suddenly capable of distinguishing cases in
filesystems.

Thanks.
