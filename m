Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 57BD6201B0
	for <e@80x24.org>; Tue, 28 Feb 2017 18:38:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751420AbdB1SiZ (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Feb 2017 13:38:25 -0500
Received: from mail-io0-f179.google.com ([209.85.223.179]:36706 "EHLO
        mail-io0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751243AbdB1SiY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Feb 2017 13:38:24 -0500
Received: by mail-io0-f179.google.com with SMTP id l7so15324756ioe.3
        for <git@vger.kernel.org>; Tue, 28 Feb 2017 10:36:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=IZIufu2Tt0ShoMUsOku0HUxvcUXQ2B65QJ5ARqgfoXA=;
        b=ITGxD4/FNQv212E94popJODZ0d25R8QNYzSyl4Gi/wSS1JdUGFh93rM6KQPa9l/XG0
         FOBcQ/WGepcEvzOeM+mg/4uX8YIefNo/Qn+AL4HL6xQVCcmVfyjemeWzo2vWjkx3E7B7
         A0aHBcwnYcWS1KAHHi2K4yworvQFTOS9wytoNEdbq++nHyBrNKglNU3D0AgN0gbiJKi1
         BAHRr/CdZ0PxoAfxBAQ5EbPBLxjYOgxpFnKfYjgQe2aLH5Uh1O9Hwxi5sKQJ9rbj/+yz
         hhnhLMGLfFJOwB+32DpoX9/x8KZMOQGDPLupNQi7ymKyBwDEsNEAH9txKVHMIT0/hycv
         Hlag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=IZIufu2Tt0ShoMUsOku0HUxvcUXQ2B65QJ5ARqgfoXA=;
        b=dAG5Aqbl98AdQhokXVJLpkUu6l0lnnoiSFnRuThz9h/IZYDcLuC3AXBo/dftYdy+PL
         M+opv7jQ2giGCNO9xa34l4vYBk8niNXzzIGZbEZBT58/1UFIu39rwTI+yBkITsFO5Jdz
         sfF3XakttddCatzwiDOPs1QxxkdXa9oXHanqogQ7QcbY6XFFJm/suq5j8/x+YaksvqBz
         OcYcb2SVb2aPqWts3wUsSHEcnu+tmxVzDnGJxkOeeC3AkAEVwwyf75nhdKBA+Zzu4UWZ
         s3ZwYGQR38ZsXkuqp2XioUScm85KZjN3qmUCK7zfRSvhQGXvcib9wecRQqInQaxZCLZN
         JmLA==
X-Gm-Message-State: AMke39mvlcYNXcIumB2I1iYAPc/8sKYZ1bZQysY6oWAOGYoVMLtq3TIXdPHo+ZDhyZ1EtBcqpW5WUNxd0SxiDQJl
X-Received: by 10.107.16.96 with SMTP id y93mr3870776ioi.164.1488305125051;
 Tue, 28 Feb 2017 10:05:25 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.13.1 with HTTP; Tue, 28 Feb 2017 10:05:24 -0800 (PST)
In-Reply-To: <20170228143710.smbzo6b7wefjc62r@sigill.intra.peff.net>
References: <CAC+L6n0YeX_n_AysCLtBWkA+jPHwg7HmOWq2PLj75byxOZE=qQ@mail.gmail.com>
 <CAGZ79ka8saQMKeutE415WxOQ71MnEw1A4uV3b0Pa4gcehx8pdw@mail.gmail.com> <20170228143710.smbzo6b7wefjc62r@sigill.intra.peff.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 28 Feb 2017 10:05:24 -0800
Message-ID: <CAGZ79kb8F9_9fd9uhfPpHVPQj-zm99qt5Tr=3TUhpe=K6JknEg@mail.gmail.com>
Subject: Re: 'git submodules update' ignores credential.helper config of the
 parent repository
To:     Jeff King <peff@peff.net>
Cc:     Dmitry Neverov <dmitry.neverov@gmail.com>,
        Duy Nguyen <pclouds@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 28, 2017 at 6:37 AM, Jeff King <peff@peff.net> wrote:
>>
>> This would change the semantics of a config file as the attribute for
>> each setting depends on the location (was attribute.FOO.read =
>> {true, false} read before).
>
> I'm not enthused by this, just because there is a hidden dependency
> between attribute.* sections and other ones. They _look_ like regular
> config keys, but they really aren't.

True.

> I have a feeling that something like this would create unwelcome corner
> cases in the config-writer, which is otherwise does not have to care
> about which existing section of a file it adds a key to.

Yeah the writer would become a lot more involved, if we're not going
the stupid way (add these sections for nearly all keys. that would be
a mess but easy to implement)

So I guess then we rather settle with multiple config files or a white/blacklist
of config options to propagate from the superproject to its submodules.
