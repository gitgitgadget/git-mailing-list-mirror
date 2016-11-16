Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 456A22042F
	for <e@80x24.org>; Wed, 16 Nov 2016 21:51:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S941019AbcKPVvK (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Nov 2016 16:51:10 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60131 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932263AbcKPVvH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Nov 2016 16:51:07 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E707F50036;
        Wed, 16 Nov 2016 16:51:05 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=F2he2FQacEKD1I1kws6ZcyAAtt8=; b=M41o8H
        MTpBHC/WuPSrxmP0pg9Dc29Fq4PUne5hVMKTDs9D2EzPtHFgGtQXX/Kf2QXGMmny
        KxK/UzrxIittOnhboU4mB2DpgqFAFQTAOKeFuXWXKyW2u0ovzN9FcQNykFeNpfIC
        JECvKanYguWcORTtKRNsrb2sKvejRp9iB6CMw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=GVNYbKBtXg1/DctChCGRyjZbSAvhr9D0
        eo69F1dsehdnAL34xNtpid0tnUmNs//XNZj85GCwaDBpA6F2K6nY4CpaSS0cE842
        wjdUTrTeNoK7PsnrE6Ms202rpv/rGs6ooXRE5EqlsHgf8CXodq+WLz5WiZrMBVPu
        aBDMKSRa4oQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DBDF450035;
        Wed, 16 Nov 2016 16:51:05 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 3816150034;
        Wed, 16 Nov 2016 16:51:05 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Lars Schneider <larsxschneider@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>, git <git@vger.kernel.org>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH] t0021, t5615: use $PWD instead of $(pwd) in PATH-like shell variables
References: <f4336a7fa3df8c0b426c3d01ada8d7d8f38e588a.1478881741.git.johannes.schindelin@gmx.de>
        <xmqq37iy3q0s.fsf@gitster.mtv.corp.google.com>
        <fa11def5-a878-a5c8-6e7b-627ea8cda7e2@kdbg.org>
        <2b69d098-92ef-77b0-367a-516e9edbe257@kdbg.org>
        <xmqqa8d53ky9.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.20.1611121237230.3746@virtualbox>
        <xmqqtwbcyyfe.fsf@gitster.mtv.corp.google.com>
        <0BEC2674-20B5-4AD1-851A-97CA34C0CE7F@gmail.com>
        <xmqqshqux9il.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.20.1611151753300.3746@virtualbox>
        <alpine.DEB.2.20.1611161041040.3746@virtualbox>
Date:   Wed, 16 Nov 2016 13:51:03 -0800
In-Reply-To: <alpine.DEB.2.20.1611161041040.3746@virtualbox> (Johannes
        Schindelin's message of "Wed, 16 Nov 2016 10:47:08 +0100 (CET)")
Message-ID: <xmqqfumrozzs.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C6172D24-AC46-11E6-95ED-3AB77A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> This is the offending part from last night's build:
>
> -- snipsnap --
> 2016-11-16T00:31:57.5321220Z copy.c: In function 'copy_dir_1':
> 2016-11-16T00:31:57.5321220Z copy.c:369:8: error: implicit declaration of function 'lchown' [-Werror=implicit-function-declaration]
> 2016-11-16T00:31:57.5321220Z     if (lchown(dest, source_stat.st_uid, source_stat.st_gid) < 0)
> 2016-11-16T00:31:57.5321220Z         ^~~~~~
> 2016-11-16T00:31:57.5321220Z copy.c:391:7: error: implicit declaration of function 'mknod' [-Werror=implicit-function-declaration]
> 2016-11-16T00:31:57.5321220Z    if (mknod(dest, source_stat.st_mode, source_stat.st_rdev) < 0)
> 2016-11-16T00:31:57.5321220Z        ^~~~~
> 2016-11-16T00:31:57.5321220Z copy.c:405:7: error: implicit declaration of function 'utimes' [-Werror=implicit-function-declaration]
> 2016-11-16T00:31:57.5321220Z    if (utimes(dest, times) < 0)
> 2016-11-16T00:31:57.5321220Z        ^~~~~~
> 2016-11-16T00:31:57.5321220Z copy.c:407:7: error: implicit declaration of function 'chown' [-Werror=implicit-function-declaration]
> 2016-11-16T00:31:57.5321220Z    if (chown(dest, source_stat.st_uid, source_stat.st_gid) < 0) {
> 2016-11-16T00:31:57.5321220Z        ^~~~~
> 2016-11-16T00:31:57.7982432Z     CC ctype.o
> 2016-11-16T00:31:58.1418929Z cc1.exe: all warnings being treated as errors
> 2016-11-16T00:31:58.6368128Z make: *** [Makefile:1988: copy.o] Error 1

That looks like a part of the new 'instead of run_command("cp -R"),
let's borrow code from somewhere and do that ourselves' in the
nd/worktree-move topic.

The offending part is this:

+	if (S_ISBLK(source_stat.st_mode) ||
+	    S_ISCHR(source_stat.st_mode) ||
+	    S_ISSOCK(source_stat.st_mode) ||
+	    S_ISFIFO(source_stat.st_mode)) {
+		if (mknod(dest, source_stat.st_mode, source_stat.st_rdev) < 0)
+			return error_errno(_("can't create '%s'"), dest);
+	} else
+		return error(_("unrecognized file '%s' with mode %x"),
+			     source, source_stat.st_mode);

I think all of this is meant to be used to copy what is in the
working tree, and what is in the working tree is meant to be tracked
by Git, none of the four types that triggers mknod() would be
relevant for our purpose.  The simplest and cleanest would be to
make the above to return error("unsupported filetype").

I do not mind run_command("cp -R") and get rid of this code
altogether; that might be a more portable and sensible approach.

