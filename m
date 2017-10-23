Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C9648202A0
	for <e@80x24.org>; Mon, 23 Oct 2017 21:48:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751623AbdJWVsY (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Oct 2017 17:48:24 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:43969 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751465AbdJWVsW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Oct 2017 17:48:22 -0400
Received: by mail-qt0-f196.google.com with SMTP id j58so28097829qtj.0
        for <git@vger.kernel.org>; Mon, 23 Oct 2017 14:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=4m+NGUkgm4Ij/8wkuWvkJ5Li4Yzsa8i7adwumA2Z5jk=;
        b=UgJx+SSsx1WkHyBeumi7khPcopB6z/mUTZtoUgWk0Yx1IZZ178HMDiIAqMKtGKt6Do
         DhYvmbiZys20jzQljLtrgzIqTsCWHtWOtEYND0CC2VicMwI1Evn94IwasYqQkQRVqgb3
         B9FgfrGTtqoE9K6agYjkeKYVY3aNAfyOH/yoiESCL/5qeZOkV3QnMEVN9eKj3V+BiOx/
         rWW5tif/mPcoXoUp1Aa+A5MjRnvrCShttA5yGslB4bwDXn23UTj2/rzKGVjh8cuqdHr7
         Sscj0ZYPuWASc2QCjgTCghXoHTeEV7CCNSyavYu4nyUS6ke/zV920pgoDO9qQJdbwyYb
         KYyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=4m+NGUkgm4Ij/8wkuWvkJ5Li4Yzsa8i7adwumA2Z5jk=;
        b=p5DIKP4qQV1GeMvoWnczyf2mCQ0R4SYZlgn5pUZLtENHnvzmwlY0honm33anGi+fMd
         F1XFk46VdpNRY0nydvZ7QlTKIgnYu7Y1Jaq/5S5UET/XPZFywtIfxp7gFfJnK2psu4/n
         PKAjTYjZR8Oly7ukRw+reJERlktHpTTyUT2gJFFdqAb/dfXtmO9+6754EMMqJx0gNomo
         S+9mOlaRfE3xjBUIpQWZR/xa79yBDlmQLVqw6AJ7DRIPbhr+/xm+PRMfT7MUq8ax0p8o
         cPkzSoyfYZUz7RPH7T72y7Q5GuGLGCDvutR7Fc+i3saQ82XR5t+0i9l9VQ16QKFfSqIX
         FKsA==
X-Gm-Message-State: AMCzsaXmiPHu79gGnzq+i5aX3cuSmRvLIg+dWpsefLWyeDVQCn4IFiUR
        IIF6wPXuMbT4emSVs2jeJVDtl/JQetcOLN0uLaPv6w==
X-Google-Smtp-Source: ABhQp+REojgcPHPe1hEgOq7zWL88leCy0wZotLUep02Oxgtdp51tYqpbZn4KRgrczW4zyOM2m9ztVN8yco4ZH8wfQ8Q=
X-Received: by 10.237.37.71 with SMTP id w7mr21826368qtc.299.1508795302100;
 Mon, 23 Oct 2017 14:48:22 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.102.70 with HTTP; Mon, 23 Oct 2017 14:48:21 -0700 (PDT)
In-Reply-To: <20171023213016.4eakv4fok2mfjt6e@aiede.mtv.corp.google.com>
References: <20170926235627.79606-1-bmwill@google.com> <20171003201507.3589-1-bmwill@google.com>
 <20171003201507.3589-11-bmwill@google.com> <20171003214206.GY19555@aiede.mtv.corp.google.com>
 <20171016171812.GA4487@google.com> <20171023212740.qodxzsq5w7rn2r6y@aiede.mtv.corp.google.com>
 <20171023213016.4eakv4fok2mfjt6e@aiede.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 23 Oct 2017 14:48:21 -0700
Message-ID: <CAGZ79kYTbWNw04n7Dmv5_1gPR51jgUFgXQn9KYQajG4WEsyfMQ@mail.gmail.com>
Subject: Re: [PATCH 2/5] connect: split ssh command line options into separate function
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Brandon Williams <bmwill@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Bryan Turner <bturner@atlassian.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jeff King <peff@peff.net>, William Yan <wyan@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 23, 2017 at 2:30 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> The git_connect function is growing long.  Split the portion that
> discovers an ssh command and options it accepts before the service
> name and path to a separate function to make it easier to read.
>
> No functional change intended.
>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>

and
Reviewed-by: Stefan Beller <sbeller@google.com>

Thanks,
Stefan
