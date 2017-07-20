Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B6A411F600
	for <e@80x24.org>; Thu, 20 Jul 2017 21:04:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936069AbdGTVEU (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Jul 2017 17:04:20 -0400
Received: from mail-qk0-f172.google.com ([209.85.220.172]:35070 "EHLO
        mail-qk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935711AbdGTVET (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jul 2017 17:04:19 -0400
Received: by mail-qk0-f172.google.com with SMTP id d145so6113285qkc.2
        for <git@vger.kernel.org>; Thu, 20 Jul 2017 14:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=/vrQ+vp3/5QApa6EcKCxb+gYc9PEqYId+CW9xeCWfyQ=;
        b=SzSNg/wFM8xHGDDc5qEL90JpnukbeVuJz8Bnz9s/HPR4gl0IuUxp/0+AHFRBPq1xjy
         pvWqbzmDhrXzTmGGOzWLKWLmYQ2rKwbri8KSEyKn53cibvf4dYDL5kjqODHAsgW8i0E1
         qeB7D/Yuq422Q5/XmOEjOUDIRLAaUcouoJtW1oUNVzbuOKvAk4Nhom9L7nvXuCDWYK6S
         VSW0mZ1NvBZaaO145oenkPpUElyDa+k2U+7YN2gaF82UaFaRi73U4pnJO1GYuBVWcfyd
         jIXjuFMcme0tVHgzn0NvvzhMEGVh1gmaMHNBOaDtl6O7gTsdgFVi2giaVaN4hD01W+hY
         wojw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=/vrQ+vp3/5QApa6EcKCxb+gYc9PEqYId+CW9xeCWfyQ=;
        b=jrzPwC4n96HPIepUbildjVYj55lGC1xlODgpq7KTz457VKkUVzB+owV66Kybga5aqI
         PEzeFulynu4nq4ty3yOfIGpGsWx15Gi8geWK/9CKXbXUTArejKb7WQFvnpQstddODnQ3
         rUo12AfKxqgvjnbj8L0saAwirdHA5v3OIoK4uSgJU5sYiU0YXFDKwRLbOgG4WnWwwk64
         y9oXh3UJ/F6xXgq7/QBhrdFfrahDYneMRTObXDCV5RQGfZPpkOJI93wcvQUMZZiL34KX
         2i/Kx4Hz7osm5Mq1OCNQkh10znp8uLSITz3QGOYJjH+Y1ZRCmfPUMe6tMm8bOSxV0DEG
         IdpA==
X-Gm-Message-State: AIVw112BTiABg/9TJjVtRplhywHX0iH53WQY3Jz4stFQbbzYWUbd5p2B
        jqQG5NHoPW+kdPLf3s3657upP7blZw==
X-Received: by 10.55.82.139 with SMTP id g133mr7080708qkb.2.1500584658704;
 Thu, 20 Jul 2017 14:04:18 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.237.58.135 with HTTP; Thu, 20 Jul 2017 14:03:48 -0700 (PDT)
In-Reply-To: <xmqqwp72kg03.fsf@gitster.mtv.corp.google.com>
References: <CAG0OSgdEE3g-ugEJU4EZqfbxZ=3h2WPdLC4W4mG7b6UeTaXQ-Q@mail.gmail.com>
 <xmqq7ez2lwsv.fsf@gitster.mtv.corp.google.com> <20170720200523.GA13792@hashpling.org>
 <xmqqwp72kg03.fsf@gitster.mtv.corp.google.com>
From:   Victor Toni <victor.toni@gmail.com>
Date:   Thu, 20 Jul 2017 23:03:48 +0200
Message-ID: <CAG0OSgfWZAbr1_j-SYYZyAzOvW4mrSFa7bBkfhRbJskgdGmsZQ@mail.gmail.com>
Subject: Re: Handling of paths
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Charles Bailey <charles@hashpling.org>, git@vger.kernel.org,
        Charles Bailey <cbailey32@bloomberg.net>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

2017-07-20 22:30 GMT+02:00 Junio C Hamano <gitster@pobox.com>:
>
> I've read the function again and I think the attached patch covers
> everything that ought to be a filename.
>
Your swift reaction is very much appreciated.
With the background you gave I just started to to create a patch
myself just to see that you already finished the patch.

Thanks a lot!

Best regards,
Victor
