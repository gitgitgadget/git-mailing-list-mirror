Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 835E31F6BF
	for <e@80x24.org>; Thu,  1 Sep 2016 16:05:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934211AbcIAQFb (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Sep 2016 12:05:31 -0400
Received: from mail-oi0-f51.google.com ([209.85.218.51]:35357 "EHLO
        mail-oi0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933972AbcIAQFa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Sep 2016 12:05:30 -0400
Received: by mail-oi0-f51.google.com with SMTP id p186so88038692oia.2
        for <git@vger.kernel.org>; Thu, 01 Sep 2016 09:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twitter.com; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=p/jodPc4gIO2NSY78iBtiBzcQTfBfx70oLkWUwcsS1A=;
        b=NJZKjTIMwMX7X9FYSDNLZA4aZZpKx7JH4EcE8j5XJbjV1/jPpAr+OHVtUU/75Yqc/H
         jSxRsxp4IFXXTJPakjHdpIJqHqN8BqREpvlMIXVgUYt+vm0L4C3ie3jnkDrr3RgB42BW
         ywJJfyU8miJJXkhODfxqN+6WKvjGzw71FpP6w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=p/jodPc4gIO2NSY78iBtiBzcQTfBfx70oLkWUwcsS1A=;
        b=jzJrudG4Zso0BGdZWL8zc6My7MEYLi2CuEUnXFt9CIn4AxngEPLh+ULbW9VBEBn9yQ
         UtIrH//nIqgxndwz2GG/4i/K3CGykTN9Is8IvtNRvlImdXaFinRoWGWNyFEJdA4FT3G1
         pQgVxjou1dRdSl/0YRcFYZaacmSBgs5ER35+zkkAI1xbqH09bPNckGrul7muokWWtK2I
         uHjFxFp3tkgMgj+3/+he23Z3/aknOd2nlml37T6zREb6o4EZIKDm7w/jDhFwOO4FEEoD
         SgaBSQz7HwxcjNy8OIcJ6DRo+tu7azTi4Dq/2NZoI/PbT1LZkHQqIMhdUguNmdM/tAH/
         bqMA==
X-Gm-Message-State: AE9vXwNHC9CV983QYbAZ8EzH8J7yGiPuQ09mwhtadw8ognNUD7occUkQcZMQoN4gIghefbke+XE2oEkY3mUbhtyi
X-Received: by 10.157.22.156 with SMTP id c28mr15457332ote.155.1472745929039;
 Thu, 01 Sep 2016 09:05:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.157.55.226 with HTTP; Thu, 1 Sep 2016 09:05:28 -0700 (PDT)
In-Reply-To: <xmqqk2ewxnui.fsf@gitster.mtv.corp.google.com>
References: <CAN5XQftQH8B+hWVh4JQgZwAp+rkbz51P5NZDc_+Tfm0EB1zkew@mail.gmail.com>
 <xmqqlgzf9wch.fsf@gitster.mtv.corp.google.com> <CAN5XQft6S+LG0mBgRFPrMZiOxHSfRhjLmQdeMdBeHKoWQSRUEA@mail.gmail.com>
 <CAPc5daVhY6WdHkXGLYea48uOw0-rTzLLZ=7mNo=VPebZ9AG4jQ@mail.gmail.com>
 <CAN5XQfty6Fshzf6kN7eXhFekU9+=VPwbzEPN1a92yVB=9nm0Vg@mail.gmail.com>
 <CAN5XQfsg_sJbyjfdc=-e85jiCQNUqagwgh6TVOXN+NskZ7KkVw@mail.gmail.com>
 <xmqqbn0b6ua8.fsf@gitster.mtv.corp.google.com> <CA+P7+xosGg955msq-gyKz_HyCZf7fPFQJdKZ3P8U3+poBBfuWA@mail.gmail.com>
 <CAN5XQfsv+BEYDWR6Xjs4mCtYDVR12a2UzB1-_H4A_xfjUUOe2g@mail.gmail.com>
 <CA+P7+xohfRsoV9VXgUrRaXPb9HvCc5gs4-KSWp38X_d_6EfkTA@mail.gmail.com>
 <CA+P7+xpGnsKzBPLVgPNSmZ7K00vY7-eJp7kSHWMRHM+cOsL_XQ@mail.gmail.com>
 <CAN5XQftCC+TUm2Jx4q3V9oFbXndtFx3H+daoB3TD3eWUs6s54A@mail.gmail.com>
 <xmqqzinu3zyw.fsf@gitster.mtv.corp.google.com> <CAN5XQfuoq6MV4e98RzUCG02KvZO6VZAbs1oxAzpdg5zswqpHGw@mail.gmail.com>
 <xmqq7faw3n5w.fsf@gitster.mtv.corp.google.com> <xmqqk2ewxnui.fsf@gitster.mtv.corp.google.com>
From:   Uma Srinivasan <usrinivasan@twitter.com>
Date:   Thu, 1 Sep 2016 09:05:28 -0700
Message-ID: <CAN5XQftt3qVoU9gB2oyimY328VK0W6xq5FSCQYvcB9dEgkxVWA@mail.gmail.com>
Subject: Re: git submodules implementation question
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jacob Keller <jacob.keller@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jens Lehmann <Jens.Lehmann@web.de>,
        Heiko Voigt <hvoigt@hvoigt.net>,
        Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Yes, this one line fix addresses my problem.

So, what is the next step? Will someone submit a patch or should I?
Please note that I've never submitted a patch before, but I don't mind
learning how to.

Thanks,
Uma

> --- a/submodule.c
> +++ b/submodule.c
> @@ -1160,4 +1160,5 @@ void prepare_submodule_repo_env(struct argv_array *out)
>                 if (strcmp(*var, CONFIG_DATA_ENVIRONMENT))
>                         argv_array_push(out, *var);
>         }
> +       argv_array_push(out, "GIT_DIR=.git");
>  }
>
