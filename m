Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 85C591FAFC
	for <e@80x24.org>; Mon,  6 Feb 2017 21:29:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752017AbdBFV35 (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Feb 2017 16:29:57 -0500
Received: from mail-pf0-f196.google.com ([209.85.192.196]:36149 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750980AbdBFV35 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Feb 2017 16:29:57 -0500
Received: by mail-pf0-f196.google.com with SMTP id 19so7656565pfo.3
        for <git@vger.kernel.org>; Mon, 06 Feb 2017 13:29:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=leWsB120A0rgaIUuFHqczDm7mW3cMhf5nV1gNam6P64=;
        b=QjeJ5V+qAbnUBSEzcc3spDJU0Zuqy/COn9v+/Trz/tdI+K3/HnCQkQ70SonIw+BTaT
         U3qEDP0KJOqAUcy047WbzadjD4OKTpNELSc446VPbZPns5Yj3TttKJBwnb/8vkg1Y2Qw
         vqIwxG7tT6PFRw+c40jEhZHFvFp9RKJTtLiENeHrMd8Gvqq/SHag+F8WZz5OqRHBUw4c
         xXQcdNfHti81E3B1s8etxqKKaDfujTsV6C34VtL3ZyT7M6Z2cwyjaDXacRDKFSaFfJIl
         WHln2cGnoKflIlVT4cWwAhm7H6TKztZt81S0QzCBCuVGThYSZfxjwuCt4nNOkH1aiYgJ
         m2EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=leWsB120A0rgaIUuFHqczDm7mW3cMhf5nV1gNam6P64=;
        b=SayPgjmD7ootA+htGT9wYAHdsGRn58phX3EgH3lfOZ61x5At6lvUzIMHzNozs8nTQZ
         EmbNut40hYCuOjYSrG5KLsVmbvc2ltH8YwSDbUxbDjQkmtgis9jxxHkrsU9tY4MHD5mJ
         pj7PwfZ5P/0aHjr8GGo2+Bci4YbDZbJZOvfdv/9d2Zn6QQ7Xn0geXGCpe5w/YqRxInmw
         fpp+ehjAwhvY++ZxDPUyLKcWNJP0fhJ9Aui8r2N3s+BI7tAw0zwxMLsarEPprzrQ/pUA
         M3Mc7E6+2Qq9zv0NstV4xoeu6I80G/uRaOJSoO7MHv8E/NPdskiF6+lif1AywHOCk11V
         pmeA==
X-Gm-Message-State: AIkVDXKMfOZPyXW9jginC1sNvnIJTIrYlZPVdZgAExo8fjXkrffuDTx4fmzIx2koBIZZxQ==
X-Received: by 10.98.202.139 with SMTP id y11mr15295473pfk.98.1486416596437;
        Mon, 06 Feb 2017 13:29:56 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:310c:cda4:fdbc:2aa2])
        by smtp.gmail.com with ESMTPSA id r8sm4877359pfi.82.2017.02.06.13.29.55
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 06 Feb 2017 13:29:55 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCHv2 00/21] completion: various __gitdir()-related improvements
References: <20170203024829.8071-1-szeder.dev@gmail.com>
Date:   Mon, 06 Feb 2017 13:29:55 -0800
In-Reply-To: <20170203024829.8071-1-szeder.dev@gmail.com> ("SZEDER
 =?utf-8?Q?G=C3=A1bor=22's?=
        message of "Fri, 3 Feb 2017 03:48:08 +0100")
Message-ID: <xmqq8tpj0zzg.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER Gábor <szeder.dev@gmail.com> writes:

> This is a long overdue reroll of a bunch of bugfixes, cleanups and
> optimizations related to how the completion script finds the path to
> the repository and how it uses that path.  Most importantly this
> series adds support for completion following 'git -C path', and it
> eliminates a few subshells and git processes, for the sake of
> fork()+exec() challenged OSes.

Thanks. Queued.
