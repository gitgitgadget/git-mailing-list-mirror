Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 820292027C
	for <e@80x24.org>; Tue, 30 May 2017 13:28:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751355AbdE3N2T (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 May 2017 09:28:19 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:34387 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751170AbdE3N2S (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 May 2017 09:28:18 -0400
Received: by mail-pf0-f196.google.com with SMTP id w69so17945350pfk.1
        for <git@vger.kernel.org>; Tue, 30 May 2017 06:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=U4ts28+26RBfHEkeiy5DmYLvksxKBEGZlyPqYdEZf7o=;
        b=gN66jBmLKReYhIHC9/KEQgCjcVgZ0nhfrW+KWgZVLjDlziAqjWiKg1X3pJhKZgGpd3
         8SgCUD+akp4qlH4CP4i44kLX0KbNgAl41IRz+8cNyeBwLZMgWN7WMOpZmuv8aEbdXje1
         2bYY1SBp5ismb11Rfz7pDewhGeM9u30CzKdl4/LAFDTXyama4J1x1Kk+bMiXuvIbydYV
         F7oXVcrdICdgpDNyx/xTrjJCAkVR2ln8FAk51CnBbkf6Q4UfYc8MGlIU5j2y5pFfHlJQ
         SUgaSsjTP8wnwkiXWM2uIA06XLIVYGocf7UsQAaDgP6e0ygvWAdO4H81nhqfKeWt3NvZ
         OJCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=U4ts28+26RBfHEkeiy5DmYLvksxKBEGZlyPqYdEZf7o=;
        b=EjxWUL1dYPokRAiI0UdT9OsiiPvGHkePb26P6Q/fSo8nxBD7KFB1A8szZMuJ89TIjW
         VSk1kErqL2/36BYUoTwfgv4dOlcG7FqlP9ErUEJRCXh4bQEX2ZjeBv6ZZGoqx1fxRKYz
         0Y8egYW53UJLfUXx7bQq5IzAm7XaVNEC7Q1ADfiwlFBfTBIuncFDMN6x7Jhh4c+Gq65c
         uSBebOVwaxhAEh8S0gsF1DMbgCC0rmz26ByKdooxgh0pFMThpsbEp4BGSJIMLCmVecqn
         R2YsZCmsI+kvGLXdfHcWe/opG48nhN/L5xx6LpHVb+tfKaTzmnPAH3BsCnTblMfs8+KA
         0zTw==
X-Gm-Message-State: AODbwcDQcTXMScDe/EPGcsRodY4LTAcHct4s6K8lWQw0n4mQ0/cIeqiS
        xgmBn1C2WKYquKN2s3k=
X-Received: by 10.98.15.148 with SMTP id 20mr23963441pfp.32.1496150897900;
        Tue, 30 May 2017 06:28:17 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:f830:fc5f:a16b:f475])
        by smtp.gmail.com with ESMTPSA id h84sm24293279pfh.45.2017.05.30.06.28.16
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 30 May 2017 06:28:17 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Laszlo Ersek <lersek@redhat.com>
Cc:     git@vger.kernel.org
Subject: Re: FORMAT_PATCH_NAME_MAX increase
References: <99ac8ee7-67b5-5ae7-51cf-6be38de6217f@redhat.com>
        <xmqqh903dt4w.fsf@gitster.mtv.corp.google.com>
        <70d34f37-7209-e392-c269-21a61228a041@redhat.com>
Date:   Tue, 30 May 2017 22:28:16 +0900
In-Reply-To: <70d34f37-7209-e392-c269-21a61228a041@redhat.com> (Laszlo Ersek's
        message of "Tue, 30 May 2017 13:03:38 +0200")
Message-ID: <xmqqk24ybhjj.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Laszlo Ersek <lersek@redhat.com> writes:

> The problem is that I can't really automate the subject munging. The
> concrete subjects in this case were:
>
>> OvmfPkg/QemuFwCfgLib: Implement SEV internal function for SEC phase
>> OvmfPkg/QemuFwCfgLib: Implement SEV internal functions for PEI phase
>> OvmfPkg/QemuFwCfgLib: Implement SEV internal function for Dxe phase
> ...
> So, even in kernel land, if subjects up to 75 columns are permitted, but
> FORMAT_PATCH_NAME_MAX is 64, conflicts are possible, at least in theory,
> aren't they? With the numbers stripped, of course.

Yup, configurable lengthening or unconditional lengthening to 75 or
so do not sound _too_ bad.

If I sounded like I was opposed to lengthening, that wasn't what I
meant.  It was more like "if you can meaningfully abbreviate, you
may help not just format-patch filenames but other use cases, and
you might even be able to get away without lengthening"; if there
is no meaningful way to abbreviate, raising the max length may be
the only workable solution.

