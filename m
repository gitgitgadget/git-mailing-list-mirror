Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AC50F1F404
	for <e@80x24.org>; Mon, 17 Sep 2018 16:32:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728542AbeIQWBB (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Sep 2018 18:01:01 -0400
Received: from mail-wm1-f41.google.com ([209.85.128.41]:33962 "EHLO
        mail-wm1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728200AbeIQWBB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Sep 2018 18:01:01 -0400
Received: by mail-wm1-f41.google.com with SMTP id j25-v6so5082736wmc.1
        for <git@vger.kernel.org>; Mon, 17 Sep 2018 09:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=z5VDVzSR+p/HbFRr4Knc2Xp0Rzl3rEBde+jexmz2oDo=;
        b=bcgQWDErStqrMsno+8mBQa3YOvQ+y0JtLkvlIcIYN8EmB+WBOZFc3lRmvbsJzugxE0
         +ubmZJ2W2riToveYTI4NyB+RVEoViSrWuAUiBlYaSm6qOAyRcaUn2CZhH6XxPIHHFh2F
         Z48k0mEsyJF8g6kJLlcE8IamBLcZjnWH3aYWxINehuay8xf4aYFoRBMVGsdaBGS9V6qb
         mmMzKb6dPG3u/Pwvf/rMaAwiJo5nt4/mUH40bkjpp5RgWkrc3hP2Yy1arpS9i6IxzKvC
         eFaXBH/WsPS1Ec3Ej3M1WFxIJ5zFQUFekXheq4onkhzpkmQ+u6FuhP9su19WreVRKo6h
         LSmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=z5VDVzSR+p/HbFRr4Knc2Xp0Rzl3rEBde+jexmz2oDo=;
        b=D/IZYWxUiyV6sW8UjsYs4sJCLr9zGOyRMD7FcxIpsopE1jA13+wsVcoL2pPbJUoo7L
         qE62KvMwjWN/GStC5EydxbXjr4FHxgG5XpVyNk6PwMyKDro9ysDMhMymlHa2GqJP84im
         t6vt45rtr400h6lnX96tiCOWpi/b0bKjbEtTIYiD5iti1rX4dKbqFrTyP8STKeXyMQva
         +O4keO9MUZLBKi1kIx0FYC/o0Nk2VEnAXCiQWuy+KZEmhDO7YJTHHo2ZGme1M00SL0Es
         Twgdp+QOw5w1X12vsxyu5SWZkuE8HQaw+umvJrmsrg1mrepPdlLLSIV4vmLNkshhpfYb
         0PIA==
X-Gm-Message-State: APzg51DVgoOxZm/D5yrRQve1x1PqxIxf005zqZy4zAosyb4uZSJ8A0va
        ewNthodcCyAV4MiOxGItZaI=
X-Google-Smtp-Source: ANB0Vdbrba7fVUgldImQV3ZuLx/r7mfol69fRTaogXOd2jkaO+tvkgws+Bytk3sL4NmzjGS934MO1g==
X-Received: by 2002:a1c:98cc:: with SMTP id a195-v6mr12767728wme.64.1537201972399;
        Mon, 17 Sep 2018 09:32:52 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id g7-v6sm13776633wrw.30.2018.09.17.09.32.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Sep 2018 09:32:51 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v4 05/23] blame.c: rename "repo" argument to "r"
References: <20180909085418.31531-1-pclouds@gmail.com>
        <20180915161759.8272-1-pclouds@gmail.com>
        <20180915161759.8272-6-pclouds@gmail.com>
Date:   Mon, 17 Sep 2018 09:32:51 -0700
In-Reply-To: <20180915161759.8272-6-pclouds@gmail.com> (=?utf-8?B?Ik5ndXk=?=
 =?utf-8?B?4buFbiBUaMOhaSBOZ+G7jWM=?=
        Duy"'s message of "Sat, 15 Sep 2018 18:17:41 +0200")
Message-ID: <xmqqk1nk84p8.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguyễn Thái Ngọc Duy  <pclouds@gmail.com> writes:

> The current naming convention for 'struct repository *' is 'r' for
> temporary variables or arguments. I did not notice this. Since we're
> updating blame.c again in the next patch, let's fix this.

It is likely that we end up having to refer to an in-core repository
object in many places, so giving a short-and-sweet 'r' to it makes
quite a lot of sense.  One thing we may want to do as preparation
related to this effort is to sweep the codebase to make sure we do
not use 'r' as a variable that refers to anything other than an
in-core repository object.

Thanks.
