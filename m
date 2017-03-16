Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8D11320323
	for <e@80x24.org>; Thu, 16 Mar 2017 19:52:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752844AbdCPTvt (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Mar 2017 15:51:49 -0400
Received: from mail-it0-f46.google.com ([209.85.214.46]:33203 "EHLO
        mail-it0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752578AbdCPTvs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Mar 2017 15:51:48 -0400
Received: by mail-it0-f46.google.com with SMTP id w124so6623833itb.0
        for <git@vger.kernel.org>; Thu, 16 Mar 2017 12:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=575venuVEy+4UYHVA9Cll9O7RwZ26zvyM1D6PGbrmts=;
        b=Hy5FsiV10Ryiy/ME+zh9yBqvwDc3jr6s6JQb+HYW9fEfEKRNVi+FMte7LzzhK49VD+
         Gis6GdbYrJlCOa1YDN3RveGbFwWcUL17NG1WAVGwGVRfOZ6WDTmyNDCxcYX80A3lF+W7
         +aeVtGqfAZYqK5DsrjojTJp0ovQ9fJYRD9QcFa4iNT2uJcWqXhsZqVKlE5kSFFPMNWXA
         99uW24dNfUO8ItHs0rON+DnThSpp0f2bc/rWY0TM4JFr8VZtMkbrMm7P7apLSV7XLeQv
         iaLBGHhLpuxNBvNRD8uBEgO8A3w/k9PGmFFBk5o1TjC1x4R8CKkxfKaVpS1AcYqT0aPA
         /qBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=575venuVEy+4UYHVA9Cll9O7RwZ26zvyM1D6PGbrmts=;
        b=QH8Mf+4QbLfKW9CqYCZZuS/3uokgUoff/kCRlElqoCkeIfS4L9S9NcdpPXW3gx2fsf
         54Sq6xc4hsUvaLTXEYENHaUnAXBI9Ud9Aq/GyH6tMplYqmbSibS/IVlX+BLe93VMNHwC
         3pmJGiRD/y8Wl8K4OJhDCAM7Mj4UTrzV+VC6avsK75IPYAZ78XKYq2nJt91fgR7ntZQq
         96hCP7OyDWb/8mlxynIIz7u2xffdRyz6Jiuni84lPzY7Gl+rICLAq6eRYcMVN3g9UqXE
         yTcMIcqCUn9PKBviqzBzzJdnHbyTltO351fODVIBWV0jXHXrfiOU48LYQJxuo9gZLVo3
         G6Gg==
X-Gm-Message-State: AFeK/H2BqTn7hEu5DUsgv+ry4haDI7sMigiDz/hC5i/VqL2I1CgC8qUWplieFps1Osx/NnET7C88UFimRb8KSQ==
X-Received: by 10.36.204.137 with SMTP id x131mr11691828itf.35.1489693882578;
 Thu, 16 Mar 2017 12:51:22 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.136.102 with HTTP; Thu, 16 Mar 2017 12:51:22 -0700 (PDT)
In-Reply-To: <xmqqbmt1atta.fsf@gitster.mtv.corp.google.com>
References: <CA+55aFzJ3NFVoN6K9__nM_LWYfegxGo_YxB0OudTNBCG+qq+3Q@mail.gmail.com>
 <20170316194110.756ipu7xud2s3w2m@sigill.intra.peff.net> <CA+55aFzp_dxevLEbRVWCmbx=zY=8hwqEBKK=Pcs7Au+rdg4pRQ@mail.gmail.com>
 <xmqqbmt1atta.fsf@gitster.mtv.corp.google.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 16 Mar 2017 12:51:22 -0700
X-Google-Sender-Auth: mZhr8PJkVAUKTSCSI0c8w2-hPy0
Message-ID: <CA+55aFzVB2gAXJ2rn3vPDtCJU7Rgozs0e_HhnK-nFziixCCfFQ@mail.gmail.com>
Subject: Re: USE_SHA1DC is broken in pu
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 16, 2017 at 12:46 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
> That's easy to answer.  What we have on 'pu' is a fair game for
> wholesale replacement.  That is the whole point of not merging
> topics in flux to 'next' and declaring that 'pu' will constantly
> rewind.

Ok.

I'll send a patch on top of 'next', which already has the header file changes.

                 Linus
