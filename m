Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CF2AD20133
	for <e@80x24.org>; Mon,  6 Mar 2017 20:10:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753776AbdCFUKh (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Mar 2017 15:10:37 -0500
Received: from mail-pf0-f173.google.com ([209.85.192.173]:36168 "EHLO
        mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753951AbdCFUKf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Mar 2017 15:10:35 -0500
Received: by mail-pf0-f173.google.com with SMTP id o126so17391693pfb.3
        for <git@vger.kernel.org>; Mon, 06 Mar 2017 12:10:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=HbxJWWOSoDHbNIQzpMAM3EUGcSlXsocw/ohmtuUdP5k=;
        b=asiqOw38mY51jliuqQ6i/znD86WHx4GEMFJhjlA0LutqnPDPLpVnqTHir09Y1Ew2x3
         s4nvi6b43vVJY1OYHvHsSA7alwl6PMa1219Gk4uAiC4mlrTlVwQp9mrdVOabS5Sm2a0z
         ltqMCudsphAMV+u3zaqVVcZH7H71I5qc9oUIaY6vgLU6tNq3hFWH8/GOsVsl+LZQWRIy
         3xaBx+I85ZP5QoV+DxwkI+depEM85Dba9viJbX1y8UZqLVh7PwyVwuTdTbhYXsxRvTrc
         sFCx3cJaU8MZtKIM77Ljq2EW3VbjDFcfVP4stBA59g1OziTbSP3Wr7zgtI9pIUeOwTej
         eefQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=HbxJWWOSoDHbNIQzpMAM3EUGcSlXsocw/ohmtuUdP5k=;
        b=by0FbnQoiivPB/KMK9Gmy9aynHACXNatip3uj4cjr3DEtkPzEOsqrVBiz84+/xEvTq
         cEKmbmE5UESW54GuQTmtAUEYJk/ZoLl2WZ7yChz/n4mue9jInWI2jw4xUzJgCBFDaqCp
         26YxDb5k3jVVvIPPc2gofOQ9Tcd1QH/qSk4YcDpunW6lGvOByxj8CWQxuzp3bXSv1zO7
         t2tXfyZ1mkZeEFmgXhcvHUd1qANzq4ne2+B56p4PYvW6ACQOGuYCgDUi1iABeRYiUXTu
         Qb578Qt61ffvP8PgFIjdo/7LwipLyv7qo+J9lQ+0aw4ChAuMZPZOn5PkCvM8qg7cusXo
         O0RQ==
X-Gm-Message-State: AMke39kdR9SYM4SlkmxkaImkmtK1QNhtFatRbBy8BXssQnz7ISuE62WWb6U8QdobvExFanQs86s4oO1Q22Wnj8RQ
X-Received: by 10.84.224.133 with SMTP id s5mr28300634plj.93.1488830495626;
 Mon, 06 Mar 2017 12:01:35 -0800 (PST)
MIME-Version: 1.0
Received: by 10.100.187.5 with HTTP; Mon, 6 Mar 2017 12:01:35 -0800 (PST)
In-Reply-To: <c8788f30-263b-c96a-239d-940743b96b53@google.com>
References: <20170304191901.9622-1-markbt@efaref.net> <c8788f30-263b-c96a-239d-940743b96b53@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 6 Mar 2017 12:01:35 -0800
Message-ID: <CAGZ79kZ1K-4PJC45nSZLX3m+FrYrsz8yy__dpwmMd8niRZX_dQ@mail.gmail.com>
Subject: Re: [RFC 0/4] Shallow clones with on-demand fetch
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Mark Thomas <markbt@efaref.net>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Ben Peart <peartben@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 6, 2017 at 11:16 AM, Jonathan Tan <jonathantanmy@google.com> wrote:

> [1] <20170113155253.1644-1-benpeart@microsoft.com> (you can search for
> emails by Message ID in online archives like https://public-inbox.org/git if
> you don't already have them)

Not just search, but the immediate lookup is
 https://public-inbox.org/git/<message-id>
so
 https://public-inbox.org/git/20170113155253.1644-1-benpeart@microsoft.com

> [2] <cover.1487984670.git.jonathantanmy@google.com>

and
  https://public-inbox.org/git/cover.1487984670.git.jonathantanmy@google.com
