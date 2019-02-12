Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D6FE91F453
	for <e@80x24.org>; Tue, 12 Feb 2019 12:45:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728273AbfBLMpx (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Feb 2019 07:45:53 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:33177 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726550AbfBLMpx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Feb 2019 07:45:53 -0500
Received: by mail-it1-f195.google.com with SMTP id q78so1680477itc.0
        for <git@vger.kernel.org>; Tue, 12 Feb 2019 04:45:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dZXampR1vCNDN8fqAZdWnzWGbaJYKsVMIxqt0m/jHHI=;
        b=uWlv/koVJSu1sfy2AmX3xiNQlrhdZpfGqZZVhSepAb5ywwHal/8Pbs7eLZt6PH/0pY
         LKvLZxwLCUWjyju8eKAnPhWw201ljwO//piB+NNJ8uf+SPaKdcpNepNl6ZfGuRzfTL32
         ly7M2Iop9UOS29T/Vlt1mw5b0ibwWmPW67pd5xujLyLiWwAQFGDzWnu+7yxCvxUVwUeq
         +3Jf+e7uTI115Ze0Exfu98MOd3smOqCCTuPAftUWIuVNL/txhA+df9uku/9qxwQuvsFx
         m2gubvXbGHl/w0Qyje6x9GBchN3wXnNPEl8GFDlUfiGbz06Y/dBaAMqYOpd2ZoK7Ws/M
         zsww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dZXampR1vCNDN8fqAZdWnzWGbaJYKsVMIxqt0m/jHHI=;
        b=kIDm02j/Vc1S/maogbHBqa580VnAPReD3Ct3Xv1/p2CJa3W8YHcIAblxRQU+drHH9S
         I5WfHysetcZ83NsG8jnq8cWFF3+yrULzZzPbMtMO76qHlbwCCllDgq9OiY3IwcFB7gx/
         8gokufog5TlXFI+Z1CvuY9fVmLe128r663irDmIfc9TrDhnJj6ziFGvoxPiVJwDzfiuP
         1IVComs3hmUP+WFtknIwn24WrXZUBYeOShbtw/gClsbdNlmTYJyU5PYvg+VTrU0yYwKY
         ciU1u1jb6+ZqE3OZgQJQ3gJ8XmhPcXDorZB8HTkuyDAOQ5sv0e6PDD1FYacjFMVJ3LgM
         r8fA==
X-Gm-Message-State: AHQUAuZHRlrYDKH5AluknNN8K3wZju6Myl6ZceL2zvsosFMg4JuS0+90
        PeCcfnHhJTjyqHep2I7cH7Ehm7K/FNmKWN6vpqc=
X-Google-Smtp-Source: AHgI3IZoj1CdS4OVVjZ4I0OY04w4zlJPwBbFKxiOYWnm31j7GI0aWx7fuUFz0MIFZi/k+/439RrC5Y9uxlYvtfXwUA0=
X-Received: by 2002:a6b:c544:: with SMTP id v65mr1893341iof.118.1549975552900;
 Tue, 12 Feb 2019 04:45:52 -0800 (PST)
MIME-Version: 1.0
References: <xmqqh8dgqcqn.fsf@gitster-ct.c.googlers.com> <87sgwtjjbk.fsf@evledraar.gmail.com>
 <20190212124323.GA11677@ash>
In-Reply-To: <20190212124323.GA11677@ash>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 12 Feb 2019 19:45:26 +0700
Message-ID: <CACsJy8D-FVGXHbqKf8BAVWEFchbF5LAN6x8UM5g7v_HLO29CLQ@mail.gmail.com>
Subject: Re: Git v2.21.0-rc0 broken on *BSD, maybe others
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        git-packagers@googlegroups.com,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 12, 2019 at 7:43 PM Duy Nguyen <pclouds@gmail.com> wrote:
> The test failures on NetBSD and Solaris/Sparc, not sure if we can do
> anything without test logs or access to these systems.

Actually if you could tweak your ci script a bit to run tests with -v,
that would help.
-- 
Duy
