Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 044F120D09
	for <e@80x24.org>; Tue,  6 Jun 2017 11:55:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751462AbdFFLzH (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Jun 2017 07:55:07 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:35911 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751422AbdFFLzG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Jun 2017 07:55:06 -0400
Received: by mail-pf0-f193.google.com with SMTP id y7so5602957pfd.3
        for <git@vger.kernel.org>; Tue, 06 Jun 2017 04:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=fLLklXbd25EtxmqlLHGcTJrMwPJ17nBzgHXE6l3aEsU=;
        b=goef9yd6kyEaR6OAyL7UeQ0LHvHs4kZVSCEAAe4MxiKbXtz46CnhshdarDw9P/xYwg
         vYCaLCFve+Mlo+FkWgUHydwOwiT0UusRVJyldxZOaM8W1yBrOUUUmRdwXYWFkC01pC/A
         rgxQGP3XYRZtlJoQLJXGeGZIKE7vuQLG+Ycdj43TW0pSzqSOZrQ7qYsjGEwA/OoBlyBX
         ozJSY66qoCJfTDL1wHkjrGwKbO++lFq3f9sCD8g2tjF1HxpD+D/jRgvc8VPcZd46KW1Q
         WxWj4aBauD7h28k9h1ey27OKhVUiNUIsLYQqXzXfFvTDlC1YLDfHJd3UuVFAoe1KrXjf
         +gOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=fLLklXbd25EtxmqlLHGcTJrMwPJ17nBzgHXE6l3aEsU=;
        b=W50YUtQhSSFPDjf53maocZLhXUdVmkZ9L2PHxu2ngb1xYCc6Zb7h/irM87O7u+REQx
         NADUkN+QghAScl5lQ7Vr0vYFatCseYD8jh9hltKMORUI4UrRekGcHN5OONqhNhl6lYdy
         jNdPMfA0GX3tn02wwm+LrqE2LKyRtNERXzYb7K+l9g1WQQRzdHE/8BVyrW8PpUhE5GKp
         9fvUU5jG1kYzkNxo1eIn5QArwNaHmSYb24pwh4+KcLLOBRlUaI58lwZXoz+ZVjx304DC
         v0D8JWogELZUKhgNVj1TohFmjK7lmzz0jzvUpN5/9UAexKoGBIDF1n7Y5zl+APMZ131g
         +fkg==
X-Gm-Message-State: AODbwcBI8kn7l4Xo0icQWDlgZhmyOCDSGbWDQt0fEQDEL7AJaFpmUDbh
        9V+ZgOTZ1mJXng==
X-Received: by 10.98.55.198 with SMTP id e189mr25674219pfa.38.1496750105383;
        Tue, 06 Jun 2017 04:55:05 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:411:1ad6:6716:25ff])
        by smtp.gmail.com with ESMTPSA id s10sm34174183pfi.16.2017.06.06.04.55.04
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 06 Jun 2017 04:55:04 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Adam Dinwoodie <adam@dinwoodie.org>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: Git v2.13.1 SHA1 very broken
References: <20170605203409.GB25777@dinwoodie.org>
        <CACBZZX6vOr+ZjUaAf8i1xdjEFfY_Exj+_Xn2-1u0RcWoLy+X1g@mail.gmail.com>
        <xmqq4lvtap3m.fsf@gitster.mtv.corp.google.com>
        <20170606100355.GC25777@dinwoodie.org>
Date:   Tue, 06 Jun 2017 20:55:04 +0900
In-Reply-To: <20170606100355.GC25777@dinwoodie.org> (Adam Dinwoodie's message
        of "Tue, 6 Jun 2017 11:03:55 +0100")
Message-ID: <xmqqmv9l8h5z.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Adam Dinwoodie <adam@dinwoodie.org> writes:

> Digging briefly into the endianness detection, it appears Cygwin has
> both _LITTLE_ENDIAN and _BIG_ENDIAN defined.  Git's detection works by
> assuming it's in a little endian environment and switching to big endian
> if it detects any of the defines that indicate such, and a010391 adds
> _BIG_ENDIAN to the set of defines that indicate big endianness.

I suspect that the upstream has already fixed this one to cope with
FreeBSD.  My preference is that we do another import on top of the
ab/sha1dc-maint topic, below the commit on ab/sha1dc that adds the
upstream as a submodule.

