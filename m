Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 531BC1F404
	for <e@80x24.org>; Fri, 31 Aug 2018 18:14:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727366AbeHaWXT (ORCPT <rfc822;e@80x24.org>);
        Fri, 31 Aug 2018 18:23:19 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:38530 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727201AbeHaWXT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Aug 2018 18:23:19 -0400
Received: by mail-wm0-f68.google.com with SMTP id t25-v6so6145709wmi.3
        for <git@vger.kernel.org>; Fri, 31 Aug 2018 11:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=H0ZtuuDVU0gA5FbRtHmjed8LWpGW2wHz3sdiZgsp254=;
        b=Qs/IZidkXjYXr/BTvIMbE02fhFoilXmR+ze+htso27yPDFC1hZu/3e+0uExu2lQ8HF
         YQm1Zhew+eTAcMX/J4xUcBTRPusPMB4I/HnOLDyY+1fhpNbl+HpAv8X2ZcPy/nYgPKNp
         hB0JwaoPFhVvT4Gk6bvaqNUvUaD99WhYioc2oFCqXaUxvu+bmbaQFltcTKjVxp0RWG9l
         Oxbe5JrOhG6OoJCzZ89chqdk8waT9+VXEjMC9nuzMH175TbjCuZ1HQsd321IiKCb9AFT
         AGTPOnC8IbI4zIbiyHX/oPWsYSNaNf6x+PYEGYhvDaLLhpCbCZzbqREAV6sWEUOIq7BW
         X0xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=H0ZtuuDVU0gA5FbRtHmjed8LWpGW2wHz3sdiZgsp254=;
        b=egwe57PCWj4scdjijlbEKPnkj0zDR59ZGUvNB3+BpxBL/PqOPnikbyB9FgAlZfHHu5
         dMWB4vHS2QVDT0egK/p6S3LUi9HmmmBcavuT6BpLMeVhE6tZKfTHEkxA0kBVEUM93JOo
         //ykeg1ce4okFFDDy5mSeimuik+KHjKVVFKGlKk2PpkfX+LcefyifXUszq+mriG4rzWp
         9JYimE9cxpmfmI+nNsPjnVoN59VY4+EVCRcPBprnUiCGaKbYKqrceFfEdwhb1WX3W4yL
         qR4Yo5anBcDW5GNdKtFFHIcVvG322nmd0AMNPZrcfSLBHdSUsqs7bZGX7umuOTdi8iio
         Kbkg==
X-Gm-Message-State: APzg51BD4cAKsfs8DRF0B7qdUeLdUNnGmT/I/AkKCNDy1CAnF1g3tDW3
        +Jg2GaBfML94eOu/kapZiEk=
X-Google-Smtp-Source: ANB0VdbOtIH4PktBnQ1urVIt7J/AGWj9s0MnaOW3JxZrLTcvnO4VIB85Ah338H2irUbjQc3LCq4SIw==
X-Received: by 2002:a1c:c3:: with SMTP id 186-v6mr5457302wma.126.1535739277894;
        Fri, 31 Aug 2018 11:14:37 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id o14-v6sm6518886wrp.57.2018.08.31.11.14.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 31 Aug 2018 11:14:37 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [GSoC][PATCH v8 00/20] Convert "git stash" to C builtin
References: <cover.1529943789.git.ungureanupaulsebastian@gmail.com>
        <cover.1535665109.git.ungureanupaulsebastian@gmail.com>
Date:   Fri, 31 Aug 2018 11:14:36 -0700
In-Reply-To: <cover.1535665109.git.ungureanupaulsebastian@gmail.com>
        (Paul-Sebastian Ungureanu's message of "Fri, 31 Aug 2018 00:40:30
        +0300")
Message-ID: <xmqqzhx21jzn.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com> writes:

> This a new iteration of `stash.c`. What is new?
>
>  * Some commits got squashed. The commit related to replacing
>  `git apply` child process was dropped since it wasn't the best
>  idea.
>
>  * In v7, there was a bug [1] related to config `git stash show`
>  The bug was fixed and a test file was added for this.
>
>  * Fixed `git stash [push]` [2]. In v7, `git stash -q drop` would
>  act like `git stash push -q drop`.
>
>  * Fixed coding-style nits. Verified that messages are marked
>  for translation and are going to the correct output stream.
>
>  * Fixed one memory leak (related to `strbuf_detach`).
>
>  * Simplified the code a little bit.

Also worth noting.

  * Rebased on a recent 'master', in which the calling convention
    for functions like dir_path_match() has been updated.  It won't
    compile when applied to anything older than dc0f6f9e ("Merge
    branch 'nd/no-the-index'", 2018-08-20).

