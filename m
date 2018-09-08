Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B66341F404
	for <e@80x24.org>; Sat,  8 Sep 2018 08:57:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726351AbeIHNms (ORCPT <rfc822;e@80x24.org>);
        Sat, 8 Sep 2018 09:42:48 -0400
Received: from mail-it0-f48.google.com ([209.85.214.48]:51476 "EHLO
        mail-it0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726291AbeIHNms (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Sep 2018 09:42:48 -0400
Received: by mail-it0-f48.google.com with SMTP id e14-v6so23623853itf.1
        for <git@vger.kernel.org>; Sat, 08 Sep 2018 01:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=WFPu4jhikIDPJxFKHJNPFG7X5wMlWnh2SVB18gYCvLs=;
        b=pgW7taaTOntjcYBRO274xuxRxIu7MDUHntgniUHDTepxICTi8qnrtWvgfjLSKHpw1B
         GMIzPFGTEZZEtemis0FMv5QyZ6sTgLARlTSvP0rJ6c1Fo85RedmhYeHrYkmt03L0f0u7
         fC4gpOD71Ymmx9xFmrxlCf5ugvni6OMc5dMtcQnFdMyQqFqOCOQ9YHWJPJcacdSOZXjd
         LwV5Sh8Ulw72Z04HNQGjCnEIrbPQviriVRSxn2awpYEOmRg5FwPteVJKkY/qY0O7mRNa
         crfLlr0E+fFoHsY5fU2yone+GnYr1F1a36nO3XY+F83VoPxdqWERgrLyZxdU6Qnwo4ls
         SL9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=WFPu4jhikIDPJxFKHJNPFG7X5wMlWnh2SVB18gYCvLs=;
        b=qeVTt4cpsJkZEB34otPFAWVC3gHdc/gKojzuc4kh1+yZL3BXzKazTb1r7dhmnoPgT9
         n+I8aWUf80hsdaT7QNWKyCXwgAzijR4Y4XdV/CBjv8oMVUWT/OUTbPcNvQmLMoRS+tzR
         Tn4SguUygaGBExbZ/LgE6lg7wslR5vUbgAhueVodJGWa/oLKJrNaXK5hFfVC/4s9xJuP
         ZvU7TDP8OhCE+ubl4W206BaSaAg1rTpehInMCxvaUuNS2neoMvASRGvXFyp+D8M+QF8U
         pbtdGL8bcYrLqsdV7WKOqpZFOydImuPjCYZ/r22q+PZ4KGp17SlOUl0aw9Uex7wR4PFw
         vwhQ==
X-Gm-Message-State: APzg51COcS5SyTNjKS0DQv7PLDQ6X7FmIH121dgvBqAYrucngKeobFdZ
        yYZ/81QkslGLjui1Tj8JQ3hsOT/Un0IyCdmvYHs=
X-Google-Smtp-Source: ANB0Vda8uSKwPODl32ti4Gzi0awJ90IGx0r+6uN1Kl/WIcZp1uJJ25gHGtOQnaEMkBPMklq2AePw+sxZ6FAsx3I7CJo=
X-Received: by 2002:a24:70b:: with SMTP id f11-v6mr10276827itf.137.1536397067616;
 Sat, 08 Sep 2018 01:57:47 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:22a7:0:0:0:0:0 with HTTP; Sat, 8 Sep 2018 01:57:46 -0700 (PDT)
In-Reply-To: <20180906193130.GA28588@sigill.intra.peff.net>
References: <20180828151419.GA17467@sigill.intra.peff.net> <CAP8UFD0SYECLk--7JsZkxBdQeJPuG1Ut5GMLsCJHqM+jG7C0jQ@mail.gmail.com>
 <20180901084321.GC25852@sigill.intra.peff.net> <CAP8UFD0qk3SkBhuEiG+-qhTjXry1SH0SmoFjSNmPr6WZrLfijw@mail.gmail.com>
 <20180906012143.GA7477@sigill.intra.peff.net> <CAP8UFD1nbv6=6JLnOCkmCcZjNOcDfOm4oH7pxHsYcddUYUxBPw@mail.gmail.com>
 <20180906193130.GA28588@sigill.intra.peff.net>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sat, 8 Sep 2018 10:57:46 +0200
Message-ID: <CAP8UFD3y=p_w5scnB0dggqK7jb5x-2x=d4LUCXLVVGkRcAOcJg@mail.gmail.com>
Subject: Re: Git in Outreachy Dec-Mar?
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 6, 2018 at 9:31 PM, Jeff King <peff@peff.net> wrote:
> On Thu, Sep 06, 2018 at 11:51:49AM +0200, Christian Couder wrote:
>
>> Yeah, I think the https://git.github.io/Outreachy-17/ is not actually necessary.
>
> I think it still may be helpful for explaining in further detail things
> like #leftoverbits (though I see you put some of that in your project
> description).

You mean in https://git.github.io/Outreachy-17/ or somewhere else?

It is already described in https://git.github.io/SoC-2018-Microprojects/.

>> I did that for the "Improve `git bisect`" project. As the
>> "coordinator", you will need to approve that project.
>
> Thanks. I approved it, though a few of the descriptions are a little
> funny. For instance, the text says "we use an issue tracker", which then
> links to public-inbox. I assume this is because you filled in a field
> for "issue tracker" and then the system generated the text.

Yeah, it was generated from fields that I filled in.

> I don't know if there's a way go into more detail there.

I don't think so, though we could perhaps improve our web pages.
