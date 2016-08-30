Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2EEB81FD99
	for <e@80x24.org>; Tue, 30 Aug 2016 06:09:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754321AbcH3GJw (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Aug 2016 02:09:52 -0400
Received: from mail-yw0-f182.google.com ([209.85.161.182]:34812 "EHLO
        mail-yw0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752669AbcH3GJw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Aug 2016 02:09:52 -0400
Received: by mail-yw0-f182.google.com with SMTP id z8so5610756ywa.1
        for <git@vger.kernel.org>; Mon, 29 Aug 2016 23:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=guyj7201rqcCEiSmNoqH87QSsy/wEnQVsSHB1+Yv3+o=;
        b=xxv6NZYLCyp0TtlNcMgV0f+kiD+lwBYnhR7bFLxcYNUSlKf0QstMRU1vcOdBw6AxCu
         O9V68Z7TnKZTy1bQUfwVNY8AmsCBBASmyc/tuYZMo5pYrMX/g+tuGB2Ws1DicgRlJ2fb
         PnYFxFg0MEh0iBgEunxcAajPaJLCMQiBZ+oq5KnJSyoL2vHnxYrTHNb9nM5kFP8bSC5D
         iQrTnqD7ANXYxnDQV2oInJ1XxdIgCDpc6SI6oGqF2pcTKKnF4eP5sgJY4wEnGP8r2wdZ
         4lmJZIZGnx4nQvJqJURbFZCdsyyuothoC4n+oCDNH6mCyM0LzqNcrtAY7jekOpAOYpjW
         xoJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=guyj7201rqcCEiSmNoqH87QSsy/wEnQVsSHB1+Yv3+o=;
        b=mcjg3iFJlnvLntF38Jh3FWi80szOsu351XV8G6+Ir59qjD/8u1wWlIaiwvgKBG3Z1G
         IyZXhZH4QK1seI+MLADzf2aE0yZiqpIOO3QS+K5o3gOEi/XdkwbVd4CW9znB2feC9dYA
         rcpwg/UMsuI0u6Jh75jpZdflW0atIdy0VzobaqrcADcLNtLPlRsAh8ZPDgp+/kOB8KS9
         R8O27YOikUsVNeBXgt831RWQlW+twYbcJbrm2BtQ+WOMHxrT7T4arMp5dkO0gTeR26q7
         jjv/NAzrHWkJ6rdfWv8k353oImVFf7+s38cv4zhqy3+7/MEK7Dye61v27K+wyWOeTyA3
         D77A==
X-Gm-Message-State: AE9vXwNPs3pihGbrghjkoDEJFzV1aafy6RGvqReCuvwGYNAmovpdslrK7GCUukbK0lgmw8MAwTLcK1xEHBfEEA==
X-Received: by 10.129.46.136 with SMTP id u130mr1801787ywu.234.1472537391103;
 Mon, 29 Aug 2016 23:09:51 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.96.195 with HTTP; Mon, 29 Aug 2016 23:09:30 -0700 (PDT)
In-Reply-To: <CAN5XQfsv+BEYDWR6Xjs4mCtYDVR12a2UzB1-_H4A_xfjUUOe2g@mail.gmail.com>
References: <CAN5XQftQH8B+hWVh4JQgZwAp+rkbz51P5NZDc_+Tfm0EB1zkew@mail.gmail.com>
 <xmqqlgzf9wch.fsf@gitster.mtv.corp.google.com> <CAN5XQft6S+LG0mBgRFPrMZiOxHSfRhjLmQdeMdBeHKoWQSRUEA@mail.gmail.com>
 <CAPc5daVhY6WdHkXGLYea48uOw0-rTzLLZ=7mNo=VPebZ9AG4jQ@mail.gmail.com>
 <CAN5XQfty6Fshzf6kN7eXhFekU9+=VPwbzEPN1a92yVB=9nm0Vg@mail.gmail.com>
 <CAN5XQfsg_sJbyjfdc=-e85jiCQNUqagwgh6TVOXN+NskZ7KkVw@mail.gmail.com>
 <xmqqbn0b6ua8.fsf@gitster.mtv.corp.google.com> <CA+P7+xosGg955msq-gyKz_HyCZf7fPFQJdKZ3P8U3+poBBfuWA@mail.gmail.com>
 <CAN5XQfsv+BEYDWR6Xjs4mCtYDVR12a2UzB1-_H4A_xfjUUOe2g@mail.gmail.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Mon, 29 Aug 2016 23:09:30 -0700
Message-ID: <CA+P7+xohfRsoV9VXgUrRaXPb9HvCc5gs4-KSWp38X_d_6EfkTA@mail.gmail.com>
Subject: Re: git submodules implementation question
To:     Uma Srinivasan <usrinivasan@twitter.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jens Lehmann <Jens.Lehmann@web.de>,
        Heiko Voigt <hvoigt@hvoigt.net>,
        Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 29, 2016 at 5:12 PM, Uma Srinivasan <usrinivasan@twitter.com> wrote:
> This is great! Thanks Jake. If you happen to have the patch ID it
> would be helpful.
>
> Uma
>

http://public-inbox.org/git/1472236108.28343.5.camel@intel.com/
