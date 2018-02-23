Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CEC211F404
	for <e@80x24.org>; Fri, 23 Feb 2018 19:03:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935497AbeBWTDe (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Feb 2018 14:03:34 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:42548 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933842AbeBWTDd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Feb 2018 14:03:33 -0500
Received: by mail-wr0-f196.google.com with SMTP id k9so15121289wre.9
        for <git@vger.kernel.org>; Fri, 23 Feb 2018 11:03:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=+CC+HfpnwG4ryT8qYGKtNhA0Bm8sib+RpfbVDjWpIt8=;
        b=dx6OttqE/Jpevo4Hy5PgxAjK7xLBaXOZVpDoIKlSQOiCEYLdsrxEVTbOfUo2cg8mDz
         8hGVSJN0M04Eznw1iCRiefSLKl7TWRejy3wv4HjTjBiczl34cOE1z/1AOGtjL7PEsywy
         8Bfnz6i+gwADgr6tghQ/rFMIuO//ESa3SgGkZJkKOPFvinXpv4OBjzDckZza9efmMhsR
         H/fWDvMhW4wDMv3SwmXCyTCKEza3IGtIgw7TJIxsl/5V8ev6Zkgz2nhjWC6Ij+L6NULR
         bNCEWnmOpUR0iOBRW6cNIAW+dqG20Q/AZ2/z+9LFog/J//nIHISfUOV9aptazFPYxhef
         MRXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=+CC+HfpnwG4ryT8qYGKtNhA0Bm8sib+RpfbVDjWpIt8=;
        b=tyVZSn9oSXjQsZs/Hn78/2L9fT7aVExJ5PMHM+0Xde3CReb/UrUzX/DGsTqCzxuFvi
         Xal7YND+UGmD0ZSw9qkOtrXvDDH5pGg1cpHFN9zwZ3YkYXeoV6ScD92/q+9xzAMvZYnx
         9f8E8n0LYolmn0TmJjA8C5I4YbPymtldbQStoWFrI6g8OL/UTjA63Jcf0MsE/bE+wxfk
         1xD3X8XVklfZq1GfCX0tXpcW7EOloaxtIp0GtMEaPPeVcnp0RJgROuA2P4GO/E7/YUaz
         uLF762W3vUo3GjCtuRUQmNZggtcpi7GskbMaKZmEdCq7Zo0gfWeZo9BosEsjKLKr5EzA
         veRg==
X-Gm-Message-State: APf1xPD8rS1LVF7XVhSElc5CdKABanb8wg82lsJhaYHQUl+vhLLAl1Sr
        3B6FQpWLlrGU+8aYG/uax5Hjkigh
X-Google-Smtp-Source: AH8x226ODgvUPfLy5Kb6BOoXXki/pxKPhBm8skxsP85fw+npxNHql39Em965qPJpHr2IZBkoc8CCJA==
X-Received: by 10.223.134.12 with SMTP id 12mr2487197wrv.193.1519412611627;
        Fri, 23 Feb 2018 11:03:31 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id r6sm3947301wrg.63.2018.02.23.11.03.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 23 Feb 2018 11:03:30 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Feb 2018, #03; Wed, 21)
References: <xmqq1shdyidz.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1802231310120.56@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
Date:   Fri, 23 Feb 2018 11:03:30 -0800
In-Reply-To: <nycvar.QRO.7.76.6.1802231310120.56@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
        (Johannes Schindelin's message of "Fri, 23 Feb 2018 13:11:01 +0100
        (STD)")
Message-ID: <xmqqwoz3ttod.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi Junio,
>
> On Wed, 21 Feb 2018, Junio C Hamano wrote:
>
>> * js/rebase-recreate-merge (2018-02-12) 12 commits
>>  ...
>> 
>>  "git rebase" learned "--recreate-merges" to transplant the whole
>>  topology of commit graph elsewhere.
>> 
>>  Is this ready for 'next'?
>
> Not quite. I have two more changes lined up. Let me send v4.

Picked up and started looking at it.  Thanks.
