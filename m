Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 186AE207A0
	for <e@80x24.org>; Wed,  3 Aug 2016 15:31:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754697AbcHCPbX (ORCPT <rfc822;e@80x24.org>);
	Wed, 3 Aug 2016 11:31:23 -0400
Received: from mail-yw0-f174.google.com ([209.85.161.174]:33588 "EHLO
	mail-yw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754020AbcHCPbW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2016 11:31:22 -0400
Received: by mail-yw0-f174.google.com with SMTP id r9so231013135ywg.0
        for <git@vger.kernel.org>; Wed, 03 Aug 2016 08:30:36 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=Hw7u3zgnKcYcYkVDlM7IZmj6XfktcwrSzqjMLikYbAE=;
        b=z6ObpnLonXbIqv1e2pvRhBH6+J/ll036ZsxvwRvr0oGquEGhJAXVwmGbRFUh6NxSzv
         W0wf0Nsj3DJyabq6LvlGU//RxWjUuLKOK9fNseNZOZ8UU1UelPn8zudcUr33/5MT9pEa
         LJXaB4JqYrAX07YwroWlHobJhrhI5XAVJIaUihNTjuY9gPZQg+0R115TaUJGqxr2CGEk
         +UlLn2zEH1cgDhfWTc8b5I/ViJux4uw5hUcMYn7sPy2BWzY8QN87UhrerqGJzBoOLUtl
         3DTj69KnN8Dq38dSjxKsKU7QYPuf7e2bGZvzIwslgtvf+/oXp5wohaViD0cEsQwoP5iC
         Ka4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=Hw7u3zgnKcYcYkVDlM7IZmj6XfktcwrSzqjMLikYbAE=;
        b=YWAdlQ9DE1XvH2EI59610AErEmwhH9OPbcfvsUaQof+GVau0i7cmFOSqRB10lZfif3
         KM3NMf2oMYMA+rkC24OxvKb8rwQl+s2vYfKcfm7YdJeywGmw7cCbdIg1rSXApOqeZ8jn
         5Wal4Kzl+sMI/XxkeJsrcxVTzlNSNsG/NGd4sxlESmMrUgLtmND1yDUaNuZ09I2jvd7N
         r1Yg00Bn845ePr12wml7FAEY0SQW3XVotWkzGTF0KDAWtSQ46d04ys3qkk+15vE2BWL0
         FenXvN16BQSeTcuR/PC08s9KT1CCH/6QXnDnN92C6ogtAJ+D4yJTN57zpWbGyXDRu5zd
         ubqw==
X-Gm-Message-State: AEkooustW6Dc/clRAYgX40mHoamXUuCgopPtoJBemWeB7+KNJ1vS66aHqWFf+mZ4YnSY8H6f2DoB5VW/02Uitg==
X-Received: by 10.129.106.139 with SMTP id f133mr55401595ywc.163.1470237816613;
 Wed, 03 Aug 2016 08:23:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.13.250.4 with HTTP; Wed, 3 Aug 2016 08:23:16 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.20.1608031708560.107993@virtualbox>
References: <1470147137-17498-1-git-send-email-git@jeffhostetler.com> <alpine.DEB.2.20.1608031708560.107993@virtualbox>
From:	Junio C Hamano <gitster@pobox.com>
Date:	Wed, 3 Aug 2016 08:23:16 -0700
X-Google-Sender-Auth: jrhgP2pSEpSr27_r3ETOVcm8XNY
Message-ID: <CAPc5daVuD7K7zKEG4yHTjBU77rUbdVcbSeBgX9eAJVMWMmxC2w@mail.gmail.com>
Subject: Re: [PATCH v4 0/8] status: V2 porcelain status
To:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:	Jeff Hostetler <git@jeffhostetler.com>,
	Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Wed, Aug 3, 2016 at 8:09 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi Junio,
>
> Any word when it will be included in `pu`, at least?

I've been waiting to see that the amount and quality of
comments from others indicate that the series passed
the phase that goes through frequent rerolls. Having a
serious review in the thread that demonstrates and
concludes that it is well designed, well implemented,
and ready to go would help, of course.
