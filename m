Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F09BC2021E
	for <e@80x24.org>; Sat, 29 Oct 2016 03:31:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754971AbcJ2DbA (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Oct 2016 23:31:00 -0400
Received: from mail-it0-f53.google.com ([209.85.214.53]:35574 "EHLO
        mail-it0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751223AbcJ2Da7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Oct 2016 23:30:59 -0400
Received: by mail-it0-f53.google.com with SMTP id e187so7934884itc.0
        for <git@vger.kernel.org>; Fri, 28 Oct 2016 20:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=NIkKCG7qP4NchO0PitL7TimxU+YXtq5THD5u1PfRG/o=;
        b=DhdLOTMM49w93kXgqr7V5zBIbdJj+YNv+JNgY+sli1i/gSeEZ/yZImGg2x3FtdeGXR
         e67bj72vm6pFr3oLgX+vsYu7oAd2TEgg7KOjtcnwvb/VIkhdMLecTB8c2SocsZLU3XA+
         Fn/Sm8/nqRyoYAjXtU4T1LcdlgIlhgisjHOZFPPrU04CHQ38+egUHqzo1Ztiew4BAy2F
         uQ4GXYG8MqBjrLX/pB1YMCvx/uLewowvrmX/9G8KbiNKuDkwAag3Aga6IEdYZMkUXEDW
         vb1QIiZw7DCwTW5O93hk0J+e0+qlTx9MpoiGg87P3YWvfI5hgcGbzG0D/OotnVlGE+86
         d4DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=NIkKCG7qP4NchO0PitL7TimxU+YXtq5THD5u1PfRG/o=;
        b=fKKl/wFDwXf3m7DUfGFk1mPcBhCVQ7Wj/kjLsEuyQ3MFtu8MJ4y/Gp/v71s2ltLrhs
         Jl+wEjR1qdNK7hKn8tVSN/SrpbasiblosICMMRgLSx9QepWwWJXSNjO3R6kbph41A7WK
         PHSYbT3VL7ZLC8ew3AzUN8WGlrTfsOCle5Kc5pbC/yJsSAa5WjN1yFeMrZCofRX60Viq
         5wLXmMQFEHyPnFCOSxET5QyfMfuRF5Vj5A3addZvYTJxS4wDVA1Sb07jNTDg0vF5xLkP
         yQORUXGeSoJlQlzwv2rUoV6Tq77tNXRLWxPzJLlMiFv3ZZzYCjAlnXq9CsFqCGbzPaGU
         Kekg==
X-Gm-Message-State: ABUngvdq9RxxADlNo89Ks8a011Hgj9E6FieiSviDA7QJNlVUsJWkVYsBPOzb11Ne7vg25WiyZh+r2EGhB4PE2g==
X-Received: by 10.36.206.71 with SMTP id v68mr1314590itg.50.1477711858655;
 Fri, 28 Oct 2016 20:30:58 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.164.102 with HTTP; Fri, 28 Oct 2016 20:30:27 -0700 (PDT)
In-Reply-To: <xmqq4m3x93e1.fsf@gitster.mtv.corp.google.com>
References: <20161023092648.12086-1-chriscool@tuxfamily.org>
 <20161023092648.12086-17-chriscool@tuxfamily.org> <CACsJy8C4Qd76LSYxk9BJtN3n3Knv_RCDgBOO-ybkNHFZK61ahQ@mail.gmail.com>
 <CACsJy8BPe085Qu4GpJ3MLTPeZM_7pbVrX31enQrGQn0oyjSrdg@mail.gmail.com> <xmqq4m3x93e1.fsf@gitster.mtv.corp.google.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sat, 29 Oct 2016 10:30:27 +0700
Message-ID: <CACsJy8BU4EH=yzkEFzTPJSQ61HMJWVperjf67L9JK9bqeUEC4A@mail.gmail.com>
Subject: Re: [PATCH v1 16/19] read-cache: unlink old sharedindex files
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Christian Couder <christian.couder@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 27, 2016 at 11:13 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> git-gc just can't match this because while it's running, somebody else
>> may be updating $GIT_DIR/index. Handling races would be a lot harder.
>
> It could attempt to take a lock on the primary index while it runs,
> and refrain to do anything if it can't take the lock ("gc --auto"
> may want to silently retry), and then the race is no longer an
> issue, no?

No, I thought of that. But if gc is holding the lock, another program
that wants to update the index may fail. And git-gc is supposed to be
non-intrusive
-- 
Duy
