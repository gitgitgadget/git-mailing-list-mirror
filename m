Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7C39C1FD99
	for <e@80x24.org>; Tue, 30 Aug 2016 00:02:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756911AbcH3AC3 (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Aug 2016 20:02:29 -0400
Received: from mail-yw0-f170.google.com ([209.85.161.170]:36856 "EHLO
        mail-yw0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755526AbcH3AC2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Aug 2016 20:02:28 -0400
Received: by mail-yw0-f170.google.com with SMTP id u134so2051169ywg.3
        for <git@vger.kernel.org>; Mon, 29 Aug 2016 17:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ZnBf8Pj37Tyg3DoGnJbH4Z+WN5wBGKd0zJ5vGxgpZYE=;
        b=dg6VQqsgoAwsWJJa3pzUgM3XikJoO9L8cCcI0589uqyi6/oYv/ywr0oG9nAHd8qB66
         YeRsyIWECaP4tkuG0O2FS5//q57Fi7NCgiWIjk625TxeQb+DpVbq1CvJ1dA7Bq4cZEXP
         LJCF7/iPSTb/G7MU6t0CR3vA0ESfpICXWXnQyqfI9hCcPhqUZPgqNyAhC2ZnRK8zyk1b
         eP1+2i9Kut094HWJBkTxlgESlZ2ayZx1TzCejKVoICptMBjbp0QaE7Zw1zOXUAuyEy7S
         ECCvFAlmKrdjarwS9cRYF6qRfSJkuRqAnuFFhXuEvztT3q60N9QlSZjLuAO3GYzirUM2
         bBIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ZnBf8Pj37Tyg3DoGnJbH4Z+WN5wBGKd0zJ5vGxgpZYE=;
        b=ECfTEgy6+9JM9n1W6PJoPe7RRELEj/jqu6TWT6GGClgxxguSHSwFSkRAkUz0yL076h
         iBts2AP8fdjoDcVMTKZGA2YP3tXZRku3UWiYpUMSlfgdURDhiLF13+ZIp0AdEliMqEWJ
         gF1/3wORKEeXGN8kYjDkn1hBelo+P8DL2ANLaNcvLk73QgNwTXC6yZynd19pwRY5bctX
         vf1DjA1d6gXYwQC84kYqwfc4ASuFvA+MuVH3CxhDgN3mJfNcpDrI+Yj06BrB/lKI8tsF
         x+rmz4Z/ka6SnhC2aSFz67w4ehawDheFo6pbVGzHRa5Ny3sg4sF1eZ6nS5Wf4J8zFph6
         Ih7A==
X-Gm-Message-State: AE9vXwPGABz0mNcRJgOB1zjoYB/kJE5hUPcyM+yv4NyyNV7gE4vAW23x8tSfOsBUB2+rpEU5PaCk5fj4wIeWvg==
X-Received: by 10.129.135.2 with SMTP id x2mr573680ywf.310.1472515347072; Mon,
 29 Aug 2016 17:02:27 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.96.195 with HTTP; Mon, 29 Aug 2016 17:02:06 -0700 (PDT)
In-Reply-To: <xmqqbn0b6ua8.fsf@gitster.mtv.corp.google.com>
References: <CAN5XQftQH8B+hWVh4JQgZwAp+rkbz51P5NZDc_+Tfm0EB1zkew@mail.gmail.com>
 <xmqqlgzf9wch.fsf@gitster.mtv.corp.google.com> <CAN5XQft6S+LG0mBgRFPrMZiOxHSfRhjLmQdeMdBeHKoWQSRUEA@mail.gmail.com>
 <CAPc5daVhY6WdHkXGLYea48uOw0-rTzLLZ=7mNo=VPebZ9AG4jQ@mail.gmail.com>
 <CAN5XQfty6Fshzf6kN7eXhFekU9+=VPwbzEPN1a92yVB=9nm0Vg@mail.gmail.com>
 <CAN5XQfsg_sJbyjfdc=-e85jiCQNUqagwgh6TVOXN+NskZ7KkVw@mail.gmail.com> <xmqqbn0b6ua8.fsf@gitster.mtv.corp.google.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Mon, 29 Aug 2016 17:02:06 -0700
Message-ID: <CA+P7+xosGg955msq-gyKz_HyCZf7fPFQJdKZ3P8U3+poBBfuWA@mail.gmail.com>
Subject: Re: git submodules implementation question
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Uma Srinivasan <usrinivasan@twitter.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jens Lehmann <Jens.Lehmann@web.de>,
        Heiko Voigt <hvoigt@hvoigt.net>,
        Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 29, 2016 at 4:15 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Uma Srinivasan <usrinivasan@twitter.com> writes:
>> This fixes my issue but what do you think? Is this the right way to
>> fix it? Is there a better way?
>
> I think we already have a helper function that does a lot better
> than "does it have a file called HEAD" to ask "is this a git
> directory?" and its name I think is "is_git_directory" (I know, we
> are not imaginative when naming our functions).
>
> As to the check makes sense in the context of this function, I am
> not an expert to judge.  I'd expect Jens, Heiko and/or Stefan to
> know better than I do.

One of my patches adds a "is_git_directory()" call to this, and if we
fail falls back to checking the .gitmodules and git-config for
information regarding the submodule should it no longer be checked
out. I suspect this patch will address your concern.

Thanks,
Jake
