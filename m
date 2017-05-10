Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3FC382018D
	for <e@80x24.org>; Wed, 10 May 2017 05:53:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751806AbdEJFxg (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 May 2017 01:53:36 -0400
Received: from mail-pg0-f46.google.com ([74.125.83.46]:35747 "EHLO
        mail-pg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751768AbdEJFxe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 May 2017 01:53:34 -0400
Received: by mail-pg0-f46.google.com with SMTP id o3so11100634pgn.2
        for <git@vger.kernel.org>; Tue, 09 May 2017 22:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=+VvncGS4ttDY5oiCxWp8z8c0WFGkgnC1CoUAnwAOpbY=;
        b=AJNhDJvSTXQvmPb0IzSW+BMNLwugh0gpafjLoe6GIqRxaextJuTaZpugAriXB5XOBG
         ld0FO/d/N4CJWJDxFXS8txHZhJCTyKxNBaQD/+WVdzeczepIRy9OcD6jSmctr+bnuvup
         iOG3jp7m28IpldE4l/37sDbEzfwgn7LDrNZAd/YTbPa+mjyb/EfYPA5dA1QYZtrN9O2J
         w0BWCDX3E1B2Rq7UUFON6nWb9R6wnYDafxjBFfVfTqlK6ED0pUu4QzDILfP/2D2doSEz
         3pzp0YmMkBX52kMdyl4atL7adgzVMMDztSwbdSUWiG2ktBz2GRFWncNLkOW70qm/HkYz
         zz7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=+VvncGS4ttDY5oiCxWp8z8c0WFGkgnC1CoUAnwAOpbY=;
        b=FdEf5swC75WBs0MbzqgbYg04wSHjJb4+QOk8yn6NwJv8rhKh+0nU6mKsmIMY8cNcaJ
         kKz1hZUDtT4Z/RfVsTMhrWjDTudyygp0vyk/vNA35tnB0YY6ninjw4RCEyJtXWVXskm9
         3MRTicbYY6tw04/3l6RuWgN/5vVm4M/gcN7JvDzr4XSUg+i/DMAPshoc3qD4MxkrVhsp
         MrhYKypUaux72gAD6YMKnmtbHmCKZLMLZSkJkytbqKYl+LpdArfIpu6UI7LXNcE0ETII
         T3W25He6BOdZ8RkfWGfARPTjQ6xdAsW1EgmA6PvBqt+s0rmW3uhV7L9MPvupRKNbNQrW
         h6Ig==
X-Gm-Message-State: AODbwcCzMqo2frQ1StMRPf7PxwNYRZICdgJD5LkAUiGbUppzFFaA3i4T
        Lx5ETLcgH945NnccNko=
X-Received: by 10.84.178.131 with SMTP id z3mr5554932plb.175.1494395614045;
        Tue, 09 May 2017 22:53:34 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:4994:7ba7:e883:c475])
        by smtp.gmail.com with ESMTPSA id l7sm3530946pgn.10.2017.05.09.22.53.33
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 09 May 2017 22:53:33 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 4/8] pathspec: rename PATHSPEC_STRIP_SUBMODULE_SLASH_CHEAP
References: <20170509191805.176266-1-bmwill@google.com>
        <20170509191805.176266-5-bmwill@google.com>
Date:   Wed, 10 May 2017 14:53:32 +0900
In-Reply-To: <20170509191805.176266-5-bmwill@google.com> (Brandon Williams's
        message of "Tue, 9 May 2017 12:18:01 -0700")
Message-ID: <xmqqa86lxnoj.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

> Now that there is only a single flag which strips a submodule slash,
> rename PATHSPEC_STRIP_SUBMODULE_SLASH_CHEAP to
> PATHSPEC_STRIP_SUBMODULE_SLASH.

This is a logical follow-up to the previous step.


