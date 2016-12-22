Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5AEFE20A80
	for <e@80x24.org>; Thu, 22 Dec 2016 21:41:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S941244AbcLVVlx (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Dec 2016 16:41:53 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51736 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S938967AbcLVVlw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Dec 2016 16:41:52 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5E67C58224;
        Thu, 22 Dec 2016 16:41:51 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=JFk4hdO4oOy68zdXTUMgg7AJrik=; b=Nj5xom
        Fm113lpwrhLjs+p3hUU7poZf7rXmdGcfbxd6bCqqWSO9muOuEg5QJ9xrAaSBnsKC
        pwPWkX/+3UCSXy7ZVOliUwdyMq50zNrEMmO9o8zPTDBgG3HS1kn3lf1C85t5SnE8
        bK7AskIzme5YUyx0O+vbbwJr77So1wSmsciuQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=JJi0bbi+855Pz5cNqq2Fl4GzTqgcKNA4
        rsEjJpavCHBJCtpxWjqIrCdC3B0N0q9kSPxe8Homl7KwDlKTi8PECZh2T2SiPAQR
        lh9CMi2QAV/Eq75Gl5QeYhSzEftTe4b24Gcle+g29agpRBzT983+p0otX+rOuQG5
        HPPHWZPQOxs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5667A58221;
        Thu, 22 Dec 2016 16:41:51 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id CAFE358219;
        Thu, 22 Dec 2016 16:41:50 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Monov <logixoul@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Making it possible to do =?utf-8?Q?=E2=80=9Cgit?= push
 =?utf-8?Q?origin=E2=80=9D?= instead of =?utf-8?Q?=E2=80=9Cgit?= push origin
 =?utf-8?Q?=3Cbranch=3E=E2=80=9D=2C?= without having to one-time prepare
 each branch for it
References: <CAJtFkWtjowyGaFfsCVd-HAZM2-3e0=CkkyYfxne8KRdYq5kJ9g@mail.gmail.com>
Date:   Thu, 22 Dec 2016 13:41:49 -0800
In-Reply-To: <CAJtFkWtjowyGaFfsCVd-HAZM2-3e0=CkkyYfxne8KRdYq5kJ9g@mail.gmail.com>
        (Stefan Monov's message of "Thu, 22 Dec 2016 23:14:31 +0200")
Message-ID: <xmqq7f6rfxpe.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 72833062-C88F-11E6-84C1-B2917B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Monov <logixoul@gmail.com> writes:

> I'd like to use just:
>
>     git push
>
> or at most:
>
>     git push origin
>
> rather than having to first check which is the active branch with `git
> branch --list`, then type:
>
>     git push origin <branch>

Perhaps you are a target audience of

    $ git config push.default current

then?
