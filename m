Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EC8F61F404
	for <e@80x24.org>; Thu, 15 Mar 2018 16:54:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750731AbeCOQyo (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Mar 2018 12:54:44 -0400
Received: from mail-wm0-f41.google.com ([74.125.82.41]:37536 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751755AbeCOQym (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Mar 2018 12:54:42 -0400
Received: by mail-wm0-f41.google.com with SMTP id 139so11869390wmn.2
        for <git@vger.kernel.org>; Thu, 15 Mar 2018 09:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=1YfJ0j2LUeRuVJyxh5ydF/Bg3o+bXnKf6RF+cJWf/fY=;
        b=QdsK9PZG91Ve/ZEvuowzWxseh54DiNaE6imnxGhz+Wh2iapd9s9KDnwApkiKFTVwYt
         lE4uKGCPihjRkvTTUCdMUgcBmgyLwsnLjKlhu09HOahO/3ErkFlj16rg8FDZrcACJ1le
         Csx/7UstcNNVCoZxytCwnzlgeChq7uXdB4inzrdtOBPMLoFHs0lH9mtzGvJCjC/yeg6I
         AXNZcrg4IL+ve0iGIAfmqovJGkjDfWNBrp7mXwwRIkifoNuLO6VyvbjNqXi3gagmDJht
         PsPDBX4/JMfQKRjalEoyHeRN1TMcSJGrysDKYhgupZcIRezn1R/7/EfkXITA0+JNvE9Q
         4vNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=1YfJ0j2LUeRuVJyxh5ydF/Bg3o+bXnKf6RF+cJWf/fY=;
        b=Y7Eiue2xqZUoHquWNtr8TQXoUjptByqSHhnzMNfQmecZ6/3vUdQs9E3DR7GVot2NVm
         L893C+TKM7+fMdCzYPdVy+yqGzzcqEAVyWn5WeHGJuAbujxkll5FGERfYNVVFp21vNUl
         U0+oxyxSZcyzx1tRqGvB5LhRhdrmHKeBlzLMfzgz8e+dPb4etdoKMj4CzeEkTbdglaH8
         NoUlDqc6eO2sDDadzvhZgphzGnS/5oS7+/4BEtsgQEwzGshUSN8hhKuBDOWCLPo41O1x
         0OhooZZQ4YxHjvLh2NX27I7cPgmSWXpFRmhwjI8Tk7BlmoX75E1rR97BFFDDX8kETSEj
         GAgA==
X-Gm-Message-State: AElRT7FATcXqVdAoywRGmoLBK05N9W7P8HNJvk80pl8Y4XPY6Y7oDToy
        9KVXNGvfMHqng/12lZiSURC+fj0r
X-Google-Smtp-Source: AG47ELtwnrwbqmnr7DuA6aVJkfjU798jbGqMNOam/aYbm3jZrwKL/vBGGSj3lxRYcdzlyuCbI3UxtA==
X-Received: by 10.28.13.136 with SMTP id 130mr5767604wmn.123.1521132881247;
        Thu, 15 Mar 2018 09:54:41 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id h20sm6337513wrf.65.2018.03.15.09.54.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 15 Mar 2018 09:54:40 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (Mar 2018, #03; Wed, 14)
References: <xmqqefkm6s06.fsf@gitster-ct.c.googlers.com>
        <CACsJy8D9-OaU5F+bugpgaPBPV_cdtqeYJ_5iYYMcrDj5d-9z5Q@mail.gmail.com>
Date:   Thu, 15 Mar 2018 09:54:40 -0700
In-Reply-To: <CACsJy8D9-OaU5F+bugpgaPBPV_cdtqeYJ_5iYYMcrDj5d-9z5Q@mail.gmail.com>
        (Duy Nguyen's message of "Thu, 15 Mar 2018 07:30:53 +0100")
Message-ID: <xmqqwoyd5lf3.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

> On Thu, Mar 15, 2018 at 2:34 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> * nd/pack-objects-pack-struct (2018-03-05) 9 commits
>> ...
>>  Will merge to 'next'.
>
> Hold it. A reroll is coming. I'm a bit busy this week and can't really do much.
>
>> * nd/worktree-prune (2018-03-06) 3 commits
>> ...
> Same.

Thanks, quick responses like this message really helps.
