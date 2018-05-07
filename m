Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CBA0F200B9
	for <e@80x24.org>; Mon,  7 May 2018 15:13:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752598AbeEGPMv (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 May 2018 11:12:51 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:54810 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752449AbeEGPMl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 May 2018 11:12:41 -0400
Received: by mail-wm0-f66.google.com with SMTP id f6so13986672wmc.4
        for <git@vger.kernel.org>; Mon, 07 May 2018 08:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=+QwPiT+Vj7N7tdHz2dyAe4qRKay8cjoFnulB//Dhjgc=;
        b=daHbEg7c+b6nMGHqfqDJWk98G0GLvimQq/QJID7faMaauVd3XuRvluj8LvFNgcF0IX
         mmDxLm7wO30mrYwGdoR1nImpuGFf5ToIargK4rgsVo6UcA/QPy+UMfe6mZfCxRaz6mDE
         fr3UE887IHKxaE8lka/NajIBnyzz/gcGsxqxgqlarweWdH1TIudomjrucnccoc9+V7mR
         pq26WQnIcwECBayZnHKckBL1evoEzq2/h/nJ0ETf6+NHPHTfWDb9dOxz28lZqPf7ApHb
         GKBuY06CbGEv9NnVU1mjR9SR/MGGoJFYU6/OwfeXt90L8PYbeFNpe/F85SkqrfNna+qV
         LEfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=+QwPiT+Vj7N7tdHz2dyAe4qRKay8cjoFnulB//Dhjgc=;
        b=qc1pdH+n+0N76RbO3BMeLbms9kEmjdkGcBbDjG/+qBB+mM2308kIqxhIlcpNJLqmhE
         cDAuyY81ozosLpWohmy0v9P/TWGrpxxryVrPsGX8GliPUvwplGeKY8KerAKA3rOLQYm4
         8yuYzJDOKNpkopKNLumiw3KFDk6iKhRduicg4ptfzThFbjkJk7zJYZvU0EGWrhE/dxsX
         NbLE4+B5dWqOd2Ej/2aAP95wSU3wipV/y2GrsGgwObKCA5rEYHFAC0n1jASGA2qeiPLw
         cBoJSxZH8ArjyCftE6prrKFTgSO4nUGyBUAGV2gxtmf7LHBtdGbtHrCqOJOnT/GJv6vG
         ilTQ==
X-Gm-Message-State: ALKqPwdNOGdqOBERgc9zBTNfUPcoZ1x+mSur3Z64gzF9DiE+TGAIoK9a
        toQamMf4fYN6l9YdusS9pcI=
X-Google-Smtp-Source: AB8JxZqiqF+G6LfrAjnB73L3AmQXWOmW9+g9d2Fe+3eWj/NPYpuG4udBf5lOWI5uevsN+ree67z/ew==
X-Received: by 10.28.71.146 with SMTP id m18mr998687wmi.144.1525705960198;
        Mon, 07 May 2018 08:12:40 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id x70-v6sm9897693wma.9.2018.05.07.08.12.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 07 May 2018 08:12:39 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Thomas Rast <tr@thomasrast.ch>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Stefan Beller <sbeller@google.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 02/18] Add a new builtin: branch-diff
References: <cover.1525361419.git.johannes.schindelin@gmx.de>
        <cover.1525448066.git.johannes.schindelin@gmx.de>
        <a1ea0320b64527ee6ce9856dcf359513d13052b7.1525448066.git.johannes.schindelin@gmx.de>
        <20180505182631.GC17700@sigill.intra.peff.net>
        <nycvar.QRO.7.76.6.1805052355190.77@tvgsbejvaqbjf.bet>
        <xmqqk1shsecd.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1805061419530.77@tvgsbejvaqbjf.bet>
        <xmqqr2moqlw8.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1805062355190.77@tvgsbejvaqbjf.bet>
Date:   Tue, 08 May 2018 00:12:38 +0900
In-Reply-To: <nycvar.QRO.7.76.6.1805062355190.77@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Mon, 7 May 2018 01:39:46 -0400 (DST)")
Message-ID: <xmqq603zpkih.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> It would be easy to introduce, but I am wary about its usefulness.
> Unless you re-generate the branch from patches (which I guess you do a
> lot, but I don't), you are likely to compare incomplete patch series: say,
> when you call `git rebase -i` to reword 05/18's commit message, your
> command will only compare 05--18 of the patch series.

Well that is exactly the point of that "..@{1} @{1}..", which turned
out to be very useful in practice at least for me when I am updating
a topic with "rebase -i", and then reviewing what I did with tbdiff.

I do not want 01-04 in the above case as I already know I did not
touch them.
