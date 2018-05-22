Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 97B441F51C
	for <e@80x24.org>; Tue, 22 May 2018 02:14:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751505AbeEVCOe (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 May 2018 22:14:34 -0400
Received: from mail-wm0-f51.google.com ([74.125.82.51]:33410 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751177AbeEVCOd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 May 2018 22:14:33 -0400
Received: by mail-wm0-f51.google.com with SMTP id x12-v6so14149041wmc.0
        for <git@vger.kernel.org>; Mon, 21 May 2018 19:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=ohJr9UkepxGzPrXVE3+T0QJyz1ckVo2UXino1rTfEQ8=;
        b=RucW4bXu31kvXvb1jyFzEGzjrT6PiELnBwjhlL4e+H6XwTAHPqYEedRnVrJWOyIQ5N
         Ccz89NKhD7cF6H0XhJAOUvE4pCrjcOz1v/GG7RwNbSzmruwzzY4uwCT581cQKg0casm+
         ZsEwhg7RlMOFZwLORVhF9C8I2vriwYMtjcFouxQCfacy232KvlUZO1E+mvm+GOyrfcf7
         SB0WUwEfEYJITUOCs6cCr3fMA6TTDlNfgDpNBoX0Yxn6H4hwNu67Eb+9A4LVXTMsaZaU
         nU2lzV9m1w5kUArp5eYQd7FGCwSQj/rw0Sfq4Qeejfybq2u5vH4/DxEtR5Y2ULFtXACO
         qvBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=ohJr9UkepxGzPrXVE3+T0QJyz1ckVo2UXino1rTfEQ8=;
        b=r5d1GtQIPD01pwFP+8I0gWfUC+7E+zMWajApa9zvg632Es4DuE36KkpOkjMZ/v77Cm
         oLL17xfcnd122oVRh6ODxFjzzPl8PTxbx1XuiU59P/g/gpDZFt8jCjqrKUFIOkbgmhA5
         tuF0NV1jPFec9gbFZ3kWEhrNCt9SOLa69w7FLh6khXB8EEwIb5vVeQQgtSkNCJ/yajzr
         Yi8zPOtYIC1f26dKKFqHOgt7eh/h2+onqgjszKV2LLCtu09FeLYAxs1Fbv/ybdZZf70/
         sbJ1wjW6Ogbj6FBf1P/O77KexloX9q2XBuGfef6UiJV2i9SAFNMVCuB9T1Mzg5pkYhjI
         2crw==
X-Gm-Message-State: ALKqPwcAH5Vz8lbi6y19jSUJQ+zem92c0uAMW3saRe47SFBtob6rHbmx
        fksFkEeyjSPi5mJyLCXo+rQ=
X-Google-Smtp-Source: AB8JxZq5TH4rgZEsFzgMOLUVdymWAjb7KRUW9CeRMLZfWLqhuf3wjEY8hhz0q48ZTYoMuQA2lj30bA==
X-Received: by 2002:a1c:b646:: with SMTP id g67-v6mr706586wmf.88.1526955272360;
        Mon, 21 May 2018 19:14:32 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id 60-v6sm560438wrc.42.2018.05.21.19.14.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 21 May 2018 19:14:31 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     "Robert P. J. Day" <rpjday@crashcourse.ca>,
        Elijah Newren <newren@gmail.com>,
        Git Mailing list <git@vger.kernel.org>
Subject: Re: which files are "known to git"?
References: <alpine.LFD.2.21.1805210717040.9926@localhost.localdomain>
        <CABPp-BH0bw3m5Ubz2+-XyFGwoHD96sAaSen9-SHQSBqMS-9u5w@mail.gmail.com>
        <alpine.LFD.2.21.1805211335250.21160@localhost.localdomain>
        <20180521175335.GC10623@aiede.svl.corp.google.com>
Date:   Tue, 22 May 2018 11:14:31 +0900
In-Reply-To: <20180521175335.GC10623@aiede.svl.corp.google.com> (Jonathan
        Nieder's message of "Mon, 21 May 2018 10:53:35 -0700")
Message-ID: <xmqqefi4zbaw.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> My understanding was the same as Elijah's.
>
> I would be in favor of a patch that replaces the phrase "known to Git"
> in Git's documentation with something less confusing.

One possible twist I recall was that normally we only pay attention
to the index (i.e. the term "tracked files" means "paths shown in
ls-files (no args) output"), but there was a desire to take a union
of paths in the index and paths in the HEAD (the obvious difference
is those that are removed from the index), and we may have called
these "known to Git" in the discussion to distinguish them from
"paths in the index".

Clearly the phrase we are discussing (e.g. the ones used in "git
clean" documentation) has been used _without_ such a desire but
merely is used carelessly and confusingly.  So I am all for finding
"known to Git" and replace them with "tracked" and/or "added to the
index" when the phrase is not used to mean "union of paths in the
index and in the HEAD".

Thanks.

