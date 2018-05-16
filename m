Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5FE2F1F406
	for <e@80x24.org>; Wed, 16 May 2018 21:47:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751406AbeEPVrD (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 May 2018 17:47:03 -0400
Received: from mail-yw0-f194.google.com ([209.85.161.194]:44570 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751028AbeEPVrC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 May 2018 17:47:02 -0400
Received: by mail-yw0-f194.google.com with SMTP id l142-v6so715166ywc.11
        for <git@vger.kernel.org>; Wed, 16 May 2018 14:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=GNbzT8sUlENzOwsUK0C3PZhhRyfkJmIAXhdMi5LVZw4=;
        b=EWJvzKrm3OneEG71HoOpjWWStRy6ZpJyusbaWqOxvAa4kmIZ6I3KF3ppGjAMYuPJdr
         K0FZ3KHAdiH37RN3J3jGRk+JfkHOJeY+rkgMKdyOYB1rH85oGPh3Hca8HY9Da+iLtPBo
         caPqhCxH7esPrBE7REflqVQO590qNd6V2z3kLQw956Hf7InnsFRcozsEym2vJiV9D4JT
         BlZGIL8m2yUNLM6bkVls54qX0obU2j8Mz+LOMUMGIIamgu99acIIrLkwruO2Q/6n4Qj+
         5Ue3nKhBq8d+zX3ABzXy4+IwEeDuZj0D5k78S2FqyxhLgCrMFHJDFnsv0+Jaw425jp6w
         F+jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=GNbzT8sUlENzOwsUK0C3PZhhRyfkJmIAXhdMi5LVZw4=;
        b=XtzdU2saWGwk4P5FEEYyrvgsXzugoIqi7uVdHArRYLCAxDjSLPtM+pJj3U3ni64vVZ
         fRkkjHVwbib6jr8MTtveyeX350y9cqfdd7iuobk/fD2+fbiTBEwtLP3MzYxocQGdbT9M
         IjUOLbugM1BIub5HjUqpvgNYON5btoVEE22eCugn0FcVYBVaqom+7gBpI3JFnU8Yua94
         bPTQF3tY3BAwSG61kZywtaNeekte89MQktPi2lQSh1YXW11pWA+4lXHcxqIiFXZhHkNi
         zKRZyzStiUwD5wWYOrG3yUl14DVRE0G+S1pLRvYNr/DR0Fz5ig/iOrkWe1QjuUzg3nSR
         oVnw==
X-Gm-Message-State: ALKqPwcePQVrMZg67JM0Ctld+er7FBMPsHuysi217CkY3SNS7dfZ8J/8
        VpjWBvikAgN9W+QqIPSYvHhA1i3Mrc8qqbNxhskidg==
X-Google-Smtp-Source: AB8JxZooDaA7KCm0AaaIGk9jVBPqbpjMNakskVbY2nYlunYOLv1WPCOyegWSC6G7DLYCZYZO4Gy2hPeVqyKNEdvfZu4=
X-Received: by 2002:a81:37ce:: with SMTP id e197-v6mr1370999ywa.340.1526507221045;
 Wed, 16 May 2018 14:47:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:cfd8:0:0:0:0:0 with HTTP; Wed, 16 May 2018 14:47:00
 -0700 (PDT)
In-Reply-To: <20180516214251.GA60301@google.com>
References: <29f60a43-9c95-512a-ef85-558906a08ed0@ramsayjones.plus.com> <20180516214251.GA60301@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 16 May 2018 14:47:00 -0700
Message-ID: <CAGZ79kbPNJPtcvbgu81y3UYmKsUd6UNNr9kmQ7qjEfB0ZBTJwQ@mail.gmail.com>
Subject: Re: [PATCH] refspec.h: reinstate 'extern' to fix sparse warning
To:     Brandon Williams <bmwill@google.com>
Cc:     Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Junio C Hamano <gitster@pobox.com>,
        GIT Mailing-list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 16, 2018 at 2:42 PM, Brandon Williams <bmwill@google.com> wrote:
> On 05/16, Ramsay Jones wrote:
>>
>> Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
>> ---
>>
>> Hi Brandon,
>>
>> If you need to re-roll your 'bw/refspec-api' branch, could you please
>> squash this, or the equivalent change before the 'struct refname' to
>> 'struct refname_item' name change, into the relevant patch. (which
>> would be patch #1, commit 8999381ed).
>>
>> This patch was built on top of 'pu', but as I said above, patch #1
>> is where the original 'extern' keyword was dropped. (see first hunk
>> of the diff to 'remote.h').
>
> Of course I'll do that, I'm planning on sending out a v2 by the end of
> the day and I'll incorporate that.
>
> Though now I'm confused, I thought we were going towards eliminating
> using the extern keyword? ...of course I guess it means something
> _slightly_ different when using with a variable vs a function :)

We're only eliminating it when it is redundant. :-)

For variables this is not redundant as we need it to tell apart the
declaration and definition of it, so we have to keep it.
