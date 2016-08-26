Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2805C1FD99
	for <e@80x24.org>; Fri, 26 Aug 2016 22:29:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753976AbcHZW3J (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Aug 2016 18:29:09 -0400
Received: from mail-it0-f42.google.com ([209.85.214.42]:37240 "EHLO
        mail-it0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752118AbcHZW3I (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Aug 2016 18:29:08 -0400
Received: by mail-it0-f42.google.com with SMTP id d65so15193694ith.0
        for <git@vger.kernel.org>; Fri, 26 Aug 2016 15:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=beP6jU1mXBwoXgNOzbf4dj9fzoObPFA2TXCWO8bNMOk=;
        b=j1WBMj5R5Wxp/8XuuNyAHKz3WxuczlJd7cNUNDWqrqj7e4a7AD4O182XS0LUs+Qwzm
         tDowKzsO3N9M73XYoR1HihoJE1t4Um5O8jly5azFAE5okakuffoGF7XRxttgVZb5XWHP
         8vFVVFucBZUcjRerR4+qgr3PEVjHlTTlDSmmqDU13XjXHC5dGQ4XXq7vJW10FUd6wL8x
         0eIHcKh8qgHljVLvIj/PfwfkFBa4dRmkf8PPSwiZ24ACJfKU7A+9J8HzHsX4kLnTOcCx
         OKARuKsV2rHYrFYvXMUKl+G5mzlzK1dHkV4410Wl9Li97isXjDw2kcNE0dvGeu/51dHF
         Bt0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=beP6jU1mXBwoXgNOzbf4dj9fzoObPFA2TXCWO8bNMOk=;
        b=EWZr5Z+vDkCfZErp4v7tIe7bdSG7rZHb1U564tyk8vOBlFGuZkcQBoEsLnpeNRi4gM
         9aUllHMXFcn4pqsAj5r/+DC15FOJtP/TMCAKXYnt0I3sWSsLRAUvdlYoPRcbHrfvQXpN
         1oKXP29seT9UDy7FIWAeLorOc4gEo3jieH0PTYUVgECYP23MS05WmZd4eqp8dIYyilua
         Fdut5p9zToRwoSih+IhLH7yOYj4125+GcDe3fraydKWO3hwZgmWEr53aoLXi7hcaNiBD
         LxQ2Nd+j3bna/mrgG/LmA7enL1pvRjg6nZnONmfP+hfU3lAS0qW7Ka6NhLz8kDUyVSnR
         4NJA==
X-Gm-Message-State: AE9vXwN021EqV5uDe8GiVXzvUxxbKZ0V15vEhOKsVlcim9ZEcGtAw43z9OIyg0P6HJnyLXh5ixdAfAQbp1D4pPbD
X-Received: by 10.107.178.129 with SMTP id b123mr6908121iof.83.1472250547626;
 Fri, 26 Aug 2016 15:29:07 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.128.66 with HTTP; Fri, 26 Aug 2016 15:29:07 -0700 (PDT)
In-Reply-To: <xmqqtwe7dxuy.fsf@gitster.mtv.corp.google.com>
References: <1472230741-5161-1-git-send-email-dev+git@drbeat.li>
 <xmqqoa4fgzhv.fsf@gitster.mtv.corp.google.com> <CAGZ79kbL13b=iZiFKW8a=G+2zXRSwjYDTzu2TS47Ppohgzm0Gg@mail.gmail.com>
 <6afee090-fbe1-5d05-1f7e-6f0fc4901418@drbeat.li> <xmqqtwe7dxuy.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 26 Aug 2016 15:29:07 -0700
Message-ID: <CAGZ79kZmCgT5JzHrwjVLw--FtjTSVzrYb-ZX8kNCsvE-b8CREg@mail.gmail.com>
Subject: Re: [PATCH 1/2] gitk: align the commit summary format to the documentation
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Beat Bolli <dev+git@drbeat.li>, Heiko Voigt <hvoigt@hvoigt.net>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Paul Mackerras <paulus@samba.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 26, 2016 at 2:27 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Beat Bolli <dev+git@drbeat.li> writes:
>
>> On 26.08.16 21:16, Stefan Beller wrote:
>>> I agree we should fix that.
>>
>> So would you prepare a amendment to your documentation commit so that
>> Junio can disregard my two patches?
>
> I think the mention of gitk having a feature to easily give you a
> commit name in the preferred format added by your 2/2 is worth
> keeping.  I am not Stefan, though ;-)

I just sent a patch to the list to fix the formatting in SubmittingPatches.
Please keep 2/2, though ?

Thanks,
Stefan
