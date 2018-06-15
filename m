Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D4F501F403
	for <e@80x24.org>; Fri, 15 Jun 2018 08:16:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755985AbeFOIP6 (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Jun 2018 04:15:58 -0400
Received: from mail-ot0-f196.google.com ([74.125.82.196]:33508 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755755AbeFOIP5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Jun 2018 04:15:57 -0400
Received: by mail-ot0-f196.google.com with SMTP id h6-v6so10133909otj.0
        for <git@vger.kernel.org>; Fri, 15 Jun 2018 01:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=neosmart.net; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=0Nv7WhKYVxJfGBOHiVRPk7f4x8dDvfznFph2rbTKH+I=;
        b=TPtR3Db1QQPdoCsrHYw9QBTtpj9In/PFxE85Oe0b1iTP4MFVj4txIYM+aORV1INUq9
         nyuOnJl0ZoVmkwEW6HJhuw6GXjSM6id6jvwal7aDuEKBVNIrROV8pWnCtYkIib7nAZWM
         cy0mTZiQXUAxpe1hBkq7qU6RX33cRfn36iiPU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=0Nv7WhKYVxJfGBOHiVRPk7f4x8dDvfznFph2rbTKH+I=;
        b=EOjw96Eey3jxz6vevTrUsL90ezOzFBqdC9IEFLUUcvEcbAH7zRRCtlW5r510zFXf5o
         aGcJXv2NT8FYGUy+meIJGFm5DNgnxegJ1TeVYmZnUV0u3qGwjPM/yMQEMtNYs9iDBK0D
         pdFl3YZJQX3haXMYzIY2nvts0krtW64v6KLFlRJBXaXq/NMB5b9OY+FiIge3NAiwd26P
         gILWcjm79SwBLGxKTLdSkoBZfvqqZTKihw3v/OexqmlMhxZ9FfQBaea168M1s4YnbUAM
         RtPcHKlXzD/SOA1EvkTvFODrbPg907PeEvuDy8OCi1PrdfhHIpQxGWjzBndFGAbtl0WE
         Z6Qg==
X-Gm-Message-State: APt69E3DAeMQ14QgHgGJvoizRN+Ipag7oBAZouo9sn1IsCBnYBXund5v
        BzdCvcuYy/XlyIdo/mI/yiS5h8Vu9RIPKe+fVTv5fISH
X-Google-Smtp-Source: ADUXVKJx3SnlUPnU4/zaueqqj/sKPm9QUfljQnFyMoLE2GSH0YJh0A78Ke1XiV7cXoG7/n6zKWOdCG6aZzYnVDpc/pU=
X-Received: by 2002:a9d:42dd:: with SMTP id c29-v6mr402834otj.351.1529050557323;
 Fri, 15 Jun 2018 01:15:57 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:e8f:0:0:0:0:0 with HTTP; Fri, 15 Jun 2018 01:15:36 -0700 (PDT)
In-Reply-To: <20180615022503.34111-1-sunshine@sunshineco.com>
References: <CACcTrKePbgyCbXneN5NZ+cS-tiDyYe_dkdwttXpP0CUeEicvHw@mail.gmail.com>
 <20180615022503.34111-1-sunshine@sunshineco.com>
From:   Mahmoud Al-Qudsi <mqudsi@neosmart.net>
Date:   Fri, 15 Jun 2018 03:15:36 -0500
Message-ID: <CACcTrKcocbznJZc7PL_6Ld_Rbm9mu3iaUf1R_G6MWaQf2LbC=Q@mail.gmail.com>
Subject: Re: [PATCH] Makefile: make NO_ICONV really mean "no iconv"
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 14, 2018 at 9:25 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> The Makefile tweak NO_ICONV is meant to allow Git to be built without
> iconv in case iconv is not installed or is otherwise dysfunctional.
> However, NO_ICONV's disabling of iconv is incomplete and can incorrectly
> allow "-liconv" to slip into the linker flags when NEEDS_LIBICONV is
> defined, which breaks the build when iconv is not installed.
>
> On some platforms, iconv lives directly in libc, whereas, on others it
> resides in libiconv. For the latter case, NEEDS_LIBICONV instructs the
> Makefile to add "-liconv" to the linker flags. config.mak.uname
> automatically defines NEEDS_LIBICONV for platforms which require it.
> The adding of "-liconv" is done unconditionally, despite NO_ICONV.
>
> Work around this problem by making NO_ICONV take precedence over
> NEEDS_LIBICONV.
>
> Reported by: Mahmoud Al-Qudsi <mqudsi@neosmart.net>
> Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
> ---
> ...

Thanks, Eric. I can confirm that on a clean FreeBSD 12 installation with
libiconv and with this patch applied, git builds and installs from source
(though other dependencies are obviously needed).

Mahmoud Al-Qudsi
NeoSmart Technologies
