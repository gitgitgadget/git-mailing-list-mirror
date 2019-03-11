Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 67D3F20248
	for <e@80x24.org>; Mon, 11 Mar 2019 11:58:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726675AbfCKL6p (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Mar 2019 07:58:45 -0400
Received: from mail-io1-f41.google.com ([209.85.166.41]:47061 "EHLO
        mail-io1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726592AbfCKL6p (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Mar 2019 07:58:45 -0400
Received: by mail-io1-f41.google.com with SMTP id k21so3727555ior.13
        for <git@vger.kernel.org>; Mon, 11 Mar 2019 04:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4t1RqxeOpfmt8kiaMEuyzj1EUGopwI+Lmi8xHsFSBSQ=;
        b=i/z+6hyBbtxQfN2MwyZOzkBK/7653pwRkaj/MQLQVbOwvlReenBvwruwGTCmRxWNU3
         nhuTMpXh3vmsflhwygokULGGSZLSU5QwQwvpvOGLSJBVPmQXXxUYepu1uOjRWU3Hqv7u
         3SRu2F1p9ARYLV0tMqAc46WXTTJMWIgH8kRTnnJLnFphZS6yk916pth7dUrILzl8NKw+
         Qvp2BAzHdxJAK1haLLr9qktXRwpcYjCGpXlyxJHE5Z0VRZ1Gfuiu7ojJ3bVGAqA7mndh
         NijKh5+Y555KU4EKIDkX1B8WBJVMYyIXvKnqnkquEXd1puYCZOtif4Qq5LNFZuV5c4S8
         yHKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4t1RqxeOpfmt8kiaMEuyzj1EUGopwI+Lmi8xHsFSBSQ=;
        b=lxFyoxt0wbrs8Km6eCTQ4r6voClw1BCVmJe8zRoH8TDiNPJ6T2MrZWRki98exEjC6Y
         U5R1HgnXYPXjE3XEG4CXZQHBEsCq28OVrxVnICP1gPIK2/k5oaRpZEkWNe798iDcpquO
         yN5XXDYo+ABl+0gnTApSM7uldNx+KsrW8XV1tHExN0dXuJAvm1NsfGoS6Q6hFMDhdXcL
         2iTlrUdTxnqARMT9JiRHA5jIaW5pF5UjbR4KCemcGz2pqHGKJS+w0fWUSBVc3B+wQzG8
         fqDlnarGZ6jY7oj1bGSpgMCopJ2ZOtfVANIypdgbAzqBiVUsSgJ0ur4pxdc4X9nSrHWQ
         y20w==
X-Gm-Message-State: APjAAAVqf70REecUxwnh6P2zWtXXTR+MOvzpi56SOXG9C8esPyvCtKPC
        rGyFdWpVtNoojMh2RHgfc7Ukf+qT2iB655eCpgw=
X-Google-Smtp-Source: APXvYqyiYxvUPj827fYzeQ/ntodS9N2a5BSnelM2VHGxniTQgKykVAZQ1rOnHgO9QzIzJkNbqgFWdJtnfjvj5EDR96w=
X-Received: by 2002:a6b:3709:: with SMTP id e9mr7487130ioa.282.1552305524669;
 Mon, 11 Mar 2019 04:58:44 -0700 (PDT)
MIME-Version: 1.0
References: <CAH8yC8k_Zyi89uxTWTrjN65UAAc1L+jLho+P7O7UyvE-LvZuzA@mail.gmail.com>
 <20190308174343.GX31362@zaya.teonanacatl.net> <CAH8yC8mg3vjPoof5SDemQ_YiL+7e1ak535U2nFnPbaWJ8xSWOA@mail.gmail.com>
 <CAH8yC8kn=EmEm_UPrnpwaofv97S42Se6FC+hWcm0EHCX-4rewQ@mail.gmail.com>
 <xmqq1s3emapy.fsf@gitster-ct.c.googlers.com> <20190311033755.GB7087@sigill.intra.peff.net>
In-Reply-To: <20190311033755.GB7087@sigill.intra.peff.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 11 Mar 2019 18:58:18 +0700
Message-ID: <CACsJy8CdqbOKu7SHMt_Pz1EtRz08HGpwWHUHoZbUiow_pPh=+A@mail.gmail.com>
Subject: Re: disabling sha1dc unaligned access, was Re: One failed self test
 on Fedora 29
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jeffrey Walton <noloader@gmail.com>,
        Todd Zullinger <tmz@pobox.com>, Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 11, 2019 at 10:48 AM Jeff King <peff@peff.net> wrote:
> And AFAIK there is no good way to
> modify the submodule-provided content as part of the build. Why do we
> even have the submodule again? ;P

Because of dogfooding of course. This is an interesting use case
though. I wonder if people often want to "patch" submodules like this
(and what we could do if that's the case)
-- 
Duy
