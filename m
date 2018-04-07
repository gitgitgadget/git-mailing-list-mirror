Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID,T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3004A1F424
	for <e@80x24.org>; Sat,  7 Apr 2018 06:53:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751069AbeDGGxZ (ORCPT <rfc822;e@80x24.org>);
        Sat, 7 Apr 2018 02:53:25 -0400
Received: from mail-qt0-f176.google.com ([209.85.216.176]:35844 "EHLO
        mail-qt0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750945AbeDGGxY (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Apr 2018 02:53:24 -0400
Received: by mail-qt0-f176.google.com with SMTP id w23so3572372qtn.3
        for <git@vger.kernel.org>; Fri, 06 Apr 2018 23:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=nj/OYpXKzuJPWuKmBPurV1jzZ0M1O0yB7exoHzDE4tc=;
        b=YIlaDx4JjMd8zCdPJXOQqKJC69qmY0iS4vs3KCH9cwFjWN93JZZlsbtgBObtgq5fBK
         AAO83Mq+Bf6HdM5k6QERERxx0L8wNRAUrz7UWPUwgTXNzL1+otu5z9h6GBfCXH3XWczi
         hKVrQxYgN8Eyqduwwk1nIPgttn6CDW6kAk+Tb1cmfVwYewsP2gomr03ni0F/UIDJMKgB
         RlG4w80oi6f65bflTmjYdz72hgePmgEjtolFitq8pV+/RuG5OMaTRJBppxNVgf+Usn+h
         r8BHMVPmm/cxpO/EDbksZdMhf1PJx+ybqHYb5cbh3dp74mbE4wZU84Y9PuOI5Ng//Q4j
         cJ2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=nj/OYpXKzuJPWuKmBPurV1jzZ0M1O0yB7exoHzDE4tc=;
        b=OP/Ps7MFsZ4D0/u16bv2WJBV6p8LV02dpOUaYIC6+MpRuKjtMa/3/+nBnjhVvInGMh
         ggO5nMfRW2zWMNRwtQ4rDDcnyNxv03uM6yHC76i7mCMgX+QdXQx96uhC8EI3s07Vtlfb
         V0qYKIGbrgfcnFNgt2IVvXcbVAQ4egigaAaMwA3iM75emePYdDKsNYsiysxYXCUmypBB
         x9LwiUnnEfKWa6/qTOMKdzdNlS7ZphStQcxhsUTF7FHBL/nKo54hEPdIh+HC/INfxMpd
         JF47OvqtcZBxqYRRRNamyo727qbUPryfIOQr7nqy0xgbCYtnV70tRlIpZ4fWn2BPX7XF
         BeNg==
X-Gm-Message-State: ALQs6tDKBt4mZXRjT4tDDpk+AATGij6ypVhbvdwJ51qGJ3SxnIsSStiD
        SHKIckUHJ28K8zVzdsPhddUfXXbgwZ+ClqPZTgo=
X-Google-Smtp-Source: AIpwx4+cBav9U+akdxtdn9P3y2zaVvNyaYqB0Q+mxS1snpDqOhx0bIFmUdPjnqPwT7vRR3eVon2ZwfVb1Pb90Dll3+M=
X-Received: by 10.200.80.78 with SMTP id h14mr16651116qtm.154.1523084003820;
 Fri, 06 Apr 2018 23:53:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.174.202 with HTTP; Fri, 6 Apr 2018 23:53:23 -0700 (PDT)
In-Reply-To: <20180406232136.253950-7-sbeller@google.com>
References: <20180406232136.253950-1-sbeller@google.com> <20180406232136.253950-7-sbeller@google.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sat, 7 Apr 2018 02:53:23 -0400
X-Google-Sender-Auth: YAuJQJ9aru991vOO176bdI19GmM
Message-ID: <CAPig+cQT0Cgd4gto0dv91XUPDbweG97=waoDCOP-r3S2LbXpUA@mail.gmail.com>
Subject: Re: [PATCH 06/19] refs: add repository argument to get_main_ref_store
To:     Stefan Beller <sbeller@google.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Git List <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 6, 2018 at 7:21 PM, Stefan Beller <sbeller@google.com> wrote:
> Add a repository argument to allow the get_main_ref_store caller
> to be more specific about which repository to handle. This is a small
> mechanical change; it doesn't change the implementation to handle
> repositories other than the_repository yet.
>
> As with the previous commits, use a macro to catch callers passing a
> repository other than the_repository at compile time.
>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> Signed-off-by: Stefan Beller <sbeller@google.com>
>
> # Conflicts:
> #       t/helper/test-ref-store.c

Meh.
