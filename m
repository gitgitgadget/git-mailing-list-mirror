Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 341D61F406
	for <e@80x24.org>; Tue, 12 Dec 2017 20:09:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752368AbdLLUJG (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Dec 2017 15:09:06 -0500
Received: from mail-qt0-f180.google.com ([209.85.216.180]:33753 "EHLO
        mail-qt0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752321AbdLLUJA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Dec 2017 15:09:00 -0500
Received: by mail-qt0-f180.google.com with SMTP id e2so264891qti.0
        for <git@vger.kernel.org>; Tue, 12 Dec 2017 12:09:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=keKgmdkKnT/pmSrzYWJyWOebw4L4Jy4SfvotcuimASc=;
        b=ROkGGt4Q8Sgw5sHVMfxWs1sA2IhPpvLzg1EtbXF964KUlY8SCxFonTEp1FD+jcsmXC
         DwMquBD5/zWY/A9kG4AVlloOIxz5Vk6lhJHtZylme8Lne7jKhsQoExNXZmQFmjcXQfuP
         +aY61ld0jiJwJZCoYpKyl4CmdFhqCQ6LqT7Up/Bvz2nMXdpVD+ESHrPkE5V2uZIoZuos
         U+R+6MNsuDX2VFa9KKmdQo1pem3hlACXUQ15zluVu7gXomDwLDsXnu4IgV5lPjspn3+k
         8HD1Dj8ExWI+M/hXuaXCUefQuOB8E3aJuUk4cm95xLBk9q83hM123Z/pugshGKMgY5Yk
         W+WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=keKgmdkKnT/pmSrzYWJyWOebw4L4Jy4SfvotcuimASc=;
        b=TWIj47tuV37xjxrfVNwA3oGmEMmD+nwX/H7DQMBtAX5QYJQTjI4QcEL0seq0I8aG0w
         IyUpitrwyB+xh4rGWgQSewXmG1c7cfMfXUz0j0OkJK1MxxtPtRLRrZYphykK6FmdY50k
         MFA+jB5Vgom4vWD47UC9Dp98ZTdUUF1xZnbSHaQRBEcKs9dK1OQZ+DqV0yfAAVfpqu4O
         eljfdTuLYiZ23G3icoaFfBaFpg4PwGEjoH1fn62d9/Nky4zYQgLZo6cI5MmqcuY+qhRN
         9ivLQEKlywoHceRE/g12t+wV0sawaVkmIxErA7Cyq6dV3HQDg3jfF0mgXla0/VUJI+49
         /pFA==
X-Gm-Message-State: AKGB3mILB3JRnFLZMPRwN78MBGNrgrULUE6mAEHLhGAw72LltaZa8t+u
        pBYRrz/fD6bDGgDpnvQkxFStC3fDEQXYuVOMUymf6Avc
X-Google-Smtp-Source: ACJfBoso2KAURl0MAF+kE+ddpQ+IA4zpJLe44jEzKOIe0LZJ38w3qE1GmRSZjq0SqHdWSvrgNfiaUXQEm6lyJ04HO5c=
X-Received: by 10.237.42.22 with SMTP id c22mr7055329qtd.162.1513109339832;
 Tue, 12 Dec 2017 12:08:59 -0800 (PST)
MIME-Version: 1.0
Received: by 10.140.85.179 with HTTP; Tue, 12 Dec 2017 12:08:59 -0800 (PST)
In-Reply-To: <20171212195352.146675-1-bmwill@google.com>
References: <20171212195352.146675-1-bmwill@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 12 Dec 2017 12:08:59 -0800
Message-ID: <CAGZ79kZsTduEsrC-BWOuT6Y+QGn_SLngO4Fs78q2N8Rp+xnhCg@mail.gmail.com>
Subject: Re: [PATCH 0/3] convert submodule.c to not use the index compat macros
To:     Brandon Williams <bmwill@google.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 12, 2017 at 11:53 AM, Brandon Williams <bmwill@google.com> wrote:
> This series removes the remaining users of the index compatibility macros and
> ensures that future uses of the macros will result in compiler errors.

Thanks for converting the submodule code to avoid these old macros.
Specifically the submodule code will benefit once we have a repository
object available throughout the code base, so it is a great start.

I reviewed the series and would call out patch 2 to be a bugfix that could
go independently, but the whole series is fine as-is with me.

Thanks,
Stefan
