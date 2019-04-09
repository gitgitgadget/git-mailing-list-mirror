Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 446FC20248
	for <e@80x24.org>; Tue,  9 Apr 2019 07:03:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726236AbfDIHD1 (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Apr 2019 03:03:27 -0400
Received: from mail-qt1-f174.google.com ([209.85.160.174]:46872 "EHLO
        mail-qt1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbfDIHD1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Apr 2019 03:03:27 -0400
Received: by mail-qt1-f174.google.com with SMTP id z17so18468208qts.13
        for <git@vger.kernel.org>; Tue, 09 Apr 2019 00:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qskdKIiZ4+yipU6hbRYFUPDxWurRJoVH44duW92UPco=;
        b=IP+b5FKIm+8daxnrzyqZVpbw6eKWA3pCyOwJKZXuNIKs0YDtw/0eCoILx6BkpPYyO7
         xacpvxJLDhogBb6ZlmGPOh3UK72/ZHazo5d/Zi3gpgcgtVOCTNqCuVMtISBJw3BC4odF
         /QgC3g/QaqESasqoRgZDtSB73uaAHJ2bNXQnGk607UVAkBaPkh67Gse25F9/rWmkJBd5
         /sQk+MqBPiNRTDWQvK+5OoR/NeoNKe85GE775DP02r1qGSS17rlHVc1c9wfPdp3yIHjv
         DqJhsqllgvBdz/6SVOGjQp7pgG48T2NQlVOu84OVU7bij5PbNJrwYc1fVbE9JarlVRgx
         nSpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qskdKIiZ4+yipU6hbRYFUPDxWurRJoVH44duW92UPco=;
        b=hMVit11XI8lUI2RCrMBG9A53V5VtyVQLVUmV8U8TG3cgkBFVq0IxYMX8UKAyj0vtG3
         cwjmL/e+0NMBWscYup4bLIaELQXHlAFlEeEGNtJqXw7Wlsb1+eB+1GMD/bJlzo0g4psE
         XQHgfvwuStoQr32y8tahrOOQdRXpJtip0HSW6NFMKdeDPFdgZwT9usYdjC9WFCm1dujI
         ptRq/aNUsr/mSabbINzOlCANV3fd+EtIW4ACGlY48fpuEKbrEms0M+f8HkTLEKgWLCDQ
         dDfgDWkKdgcFZlydjPQ0gCHW7RnvzDWh5ZZY6JZB58x3PAmHU5IXPb87QehPHFc7KEbc
         U3Tw==
X-Gm-Message-State: APjAAAWlK9d3N9odDETRMwqgSsdjMhdyuW5sJ0J56NuuO+rKARapL27o
        qDMMVK4uuFrdsrKMKvOpD9rqzlG3oBTxYjJxj8A=
X-Google-Smtp-Source: APXvYqxZIeQFAQFyJXYPlDH/xPziYKr7Lern1QGDE65J4Tz3eBgfuzmkwmSdIIaI5vGMR/LSvHcDctTGPdpihU/MVd4=
X-Received: by 2002:a0c:8a54:: with SMTP id 20mr27847477qvu.167.1554793406061;
 Tue, 09 Apr 2019 00:03:26 -0700 (PDT)
MIME-Version: 1.0
References: <CAA01Csp7y9=2n9=TNYMMw9LUO_cENz7FBeZjFrUd2FvHFT9NCQ@mail.gmail.com>
 <8636mvng8n.fsf@gmail.com> <xmqq36mt9e7l.fsf@gitster-ct.c.googlers.com>
 <CAA01CsqAt8osKArhdgATNj29+a9VO6wUwhX6=cRebnDBFx_EVg@mail.gmail.com>
 <86y34kn4c8.fsf@gmail.com> <CAA01CspJAPnBFsQsXP4Dpweeg6oBVj==TB0aEnK5o1Et5zS30Q@mail.gmail.com>
 <xmqq7ec38zam.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqq7ec38zam.fsf@gitster-ct.c.googlers.com>
From:   Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
Date:   Tue, 9 Apr 2019 09:03:12 +0200
Message-ID: <CAA01CsrO8NyzG8zfRY3=k5T2EvPJvJzMrfBgH19=ib-x69mEQg@mail.gmail.com>
Subject: Re: "commit --author=..." does not work if global email and name is
 not set
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 9, 2019 at 8:31 AM Junio C Hamano <gitster@pobox.com> wrote:
> I do not think 4. is what Jakub meant, which is to make the author
> and committer identity for real humans come from the configuration
> that becomes in effect automatically by merely logging in.

Unfortunately this is not possible


> If that cannot be arranged, something like 4. may have to serve as a
> rough approximation; that sound like the best you could do under
> that limitation without breaking the general usability of the
> system.

What do you think about my "--user" idea?


-- 
Piotr Krukowiecki
