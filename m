Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ADEB11F667
	for <e@80x24.org>; Tue, 22 Aug 2017 20:01:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752623AbdHVUBG (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Aug 2017 16:01:06 -0400
Received: from mail-qt0-f169.google.com ([209.85.216.169]:36309 "EHLO
        mail-qt0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752614AbdHVUBF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Aug 2017 16:01:05 -0400
Received: by mail-qt0-f169.google.com with SMTP id v29so102001494qtv.3
        for <git@vger.kernel.org>; Tue, 22 Aug 2017 13:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=O9PvIeeA3iwm8MMp2c8KSB72kl99imtE7EQzo6KBWVI=;
        b=sbLMMUBqG1Ss1CUHqkGe8b/Nc877pH/CWKI3aKk8lD26vz+Ay7oXlqzL+Sc5nvaJy/
         mOCSSN5pmtx0uaCH45RbsELqMg9NEP/tWWrmPtwsJz/1lTG3LqaSWKapGU0Es/mpK8Yl
         kRSXYhbLbhGQ4VDMexVzl3qum9tdAQUxMhy5P5k14KiftnogCMI7PnCQUNiGl2MyIzsP
         ljhObhY4Ox8QHuzhibDM3+tm+zM0EeQy3SvLXw35iTwui3pJqCVVKsPDTWptJYUWPLfn
         xg8YekH2Yz/jOMbOXY43WDaxdQCqUnDoR+rWx7XFHF+DHLsjXcH9tQhx9qb+TKvVPFIq
         fM2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=O9PvIeeA3iwm8MMp2c8KSB72kl99imtE7EQzo6KBWVI=;
        b=aNL183svSv2Uz7uczJ2Snz4JjkHFUdouIRreKkiIqc6yz9nkZq27KUpm+h6EWcV8x7
         0/pZndFiDNVmct1j38iHyqjLS0ZsyaDv4IGHz429w7Ic3veICd3nef7WqdqtgzxDiwkf
         rXKPEJHywAMax1GxFFMUkTirDLNd7AsLYNPhUQ1zEyfuqXa+XkhjPdebxRDg4av0kOlm
         99U1zIDaPYsb7cLVQaRsZ8ch8jJIa5+tKm/wtkxxDPYRjd8C5EHsyXfzF1VfyfDHNd5s
         h8nviZ7gJgidgDaa1wsu4rEUknaDhTASijqqbnfJ+0OD0iyl6oGm3wxsXEkAI7LJss8V
         Am3A==
X-Gm-Message-State: AHYfb5iZ9FqDJhZkWgJDdef9KIlltewKbv5uS/o1mzF3XisaqpQgq1Cm
        3HgwStHmA0sU3E+TpPqqeesUdHQDSQ==
X-Received: by 10.237.58.131 with SMTP id o3mr427713qte.229.1503432064841;
 Tue, 22 Aug 2017 13:01:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.16.242 with HTTP; Tue, 22 Aug 2017 13:00:44 -0700 (PDT)
In-Reply-To: <20170822193520.GJ39363@Vurt.local>
References: <20170802185901.GA27243@Vurt.local> <20170820180332.GC39363@Vurt.local>
 <CAOxFTcxOt878uDYj1Y0QMDNe8mNkfX3ZaZayOH3Njp9RWCJo0Q@mail.gmail.com>
 <20170821104425.geetdgi7q2uqycyt@hanna.meerval.net> <CAOxFTcxaxRjdsd0OSQX9E9ncEnO4XFLoa-0puXm2AByv6dZUow@mail.gmail.com>
 <20170821141306.wnlfn5a4hmgnj3yn@hanna.meerval.net> <xmqqo9r72yrg.fsf@gitster.mtv.corp.google.com>
 <20170822193520.GJ39363@Vurt.local>
From:   Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Date:   Tue, 22 Aug 2017 22:00:44 +0200
Message-ID: <CAOxFTczs6Z8qKw_X2USpG0bSKq-XXhfLyg21Nsm196QaxfN7EQ@mail.gmail.com>
Subject: Re: [PATCH] Add 'raw' blob_plain link in history overview
To:     Job Snijders <job@instituut.net>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        yashi@atmark-techno.com, Jakub Narebski <jnareb@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 22, 2017 at 9:35 PM, Job Snijders <job@instituut.net> wrote:

> We often work with very large plain text files in our repositories and
> found it friendlier to the users if we can click directly to the raw
> version of such files.

It might be worth it to add this information to the commit message.

-- 
Giuseppe "Oblomov" Bilotta
