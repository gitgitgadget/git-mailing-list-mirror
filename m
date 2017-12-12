Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DB4AA1F406
	for <e@80x24.org>; Tue, 12 Dec 2017 21:12:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752527AbdLLVMC (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Dec 2017 16:12:02 -0500
Received: from mail-it0-f47.google.com ([209.85.214.47]:45072 "EHLO
        mail-it0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752498AbdLLVMB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Dec 2017 16:12:01 -0500
Received: by mail-it0-f47.google.com with SMTP id z6so1213899iti.4
        for <git@vger.kernel.org>; Tue, 12 Dec 2017 13:12:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JQemeoUCrDHG8HDO8yPX0ectC8zx/1GnpUSCPgiRDXA=;
        b=m/tHj28gfyYdciK+8RX9d7CkzqJwy7iv0j/1gGe4kfGN6BMXYG6uTx72kSc+hkbBIz
         d3EZs0QHcbkSrHi/pk+AsEi0hscOwxX24F3IzeecjH4b4OwnwhAk4HY+zvYfEs5bY1k+
         XLJ2ZMh12jYYSC4pGGAFLKcL8REeIjeicDJ6T6A97CgE+e4yjmJt5lNjPqOx6u6iON+Y
         21/kHBQBaNXZhCKFU6/0W4s+/ivcmHl8qEi60n/EdarmoG+fu4s4g1qO5zSJ/WSCoBYx
         AYx9i58bdg17veROF6o48DTctXNNnhkioMHPgFJLtFIqs0xuAE5vnxN/6muD2JrqT8h8
         sNIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JQemeoUCrDHG8HDO8yPX0ectC8zx/1GnpUSCPgiRDXA=;
        b=pWY+wGqR2fH9W0aBFvdtyjHBS5hNZB4R+a+yj5ErOf9/Mg54xJHyJo5dSWhX4u7MmH
         aF2+Guiz7w4+b4lm3Iz+vf8mqAqGQo/96CBs8c/tM15E7D6mmDLy7rp7R/f16Clq5ulE
         vGmLvtTK5uxS5eANQvxmpGuA2p2R/bF9bAvfX2jTCqjX1zIucyDbILBzMpqfzQF0Er17
         bE4CHSpKAUXHjMYTIwkG0ARnZ9vpUvHJtzG7xm8qIgtOwFIE9R/Tb+kvla431VR3JH2T
         NFVfzqo0KhgV2ABdjYZZFIrtevGQUOPX3P5JBlwrAFAxWlYuKT+to2Xs5OGEKu/DuC02
         s4Zw==
X-Gm-Message-State: AKGB3mKNwvHzD/XgBaoXSIsdx6yu6yixlNlU3KHG/R2hX4URKGj3ZY2U
        v6zX6rbBQ9D9fqG6vO1Jb99p4Q==
X-Google-Smtp-Source: ACJfBot1eFBczhwsbOehvwl4IT2ysR3LlxjVXHq1CpSxx4SYWCny59SU/i/1J6hr8umGaI2cN9RGcw==
X-Received: by 10.36.120.135 with SMTP id p129mr188457itc.87.1513113120423;
        Tue, 12 Dec 2017 13:12:00 -0800 (PST)
Received: from twelve3.mtv.corp.google.com ([2620:0:100e:422:1553:d448:d6d7:162b])
        by smtp.gmail.com with ESMTPSA id u128sm234387itb.1.2017.12.12.13.11.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Dec 2017 13:11:59 -0800 (PST)
Date:   Tue, 12 Dec 2017 13:11:58 -0800
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Ramsay Jones <ramsay@ramsayjones.plus.com>,
        GIT Mailing-list <git@vger.kernel.org>,
        =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH] Makefile: allow NO_DC_SHA1_SUBMODULE to be set in
 config.mak
Message-Id: <20171212131158.ec87dcde2a74dd879068cd95@google.com>
In-Reply-To: <xmqqfu8f1zyv.fsf@gitster.mtv.corp.google.com>
References: <7272c221-c1b6-ca41-3be4-329275e94b8a@ramsayjones.plus.com>
        <xmqqk1xr204t.fsf@gitster.mtv.corp.google.com>
        <xmqqfu8f1zyv.fsf@gitster.mtv.corp.google.com>
X-Mailer: Sylpheed 3.4.1 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 12 Dec 2017 11:57:28 -0800
Junio C Hamano <gitster@pobox.com> wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Makes sense.  The patch looks scary by appearing to move the
> > includes far to the front of the Makefile, but it in fact is moving
> > the NO_DC_SHA1_SUBMODULE block slightly down and it is a sensible
> > and safe move.
> 
> A completely unrelated tangent.  This was a good change to try your
> anchored diff on.  Viewing this change with
> 
>    $ git show --anchored='include config.mak'
> 
> looks a lot less scary than the way it is shown by default (which
> matches what was posted on the list).
> 
> Good job.

Thanks, glad that it helped.
