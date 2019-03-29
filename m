Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A77DE20248
	for <e@80x24.org>; Fri, 29 Mar 2019 13:54:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729691AbfC2Nyf (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Mar 2019 09:54:35 -0400
Received: from mail-oi1-f172.google.com ([209.85.167.172]:36992 "EHLO
        mail-oi1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729639AbfC2Nyf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Mar 2019 09:54:35 -0400
Received: by mail-oi1-f172.google.com with SMTP id v84so1709367oif.4
        for <git@vger.kernel.org>; Fri, 29 Mar 2019 06:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pCqpii4TdwK7fA7Q8974FYzUJR2DmUmu4EstZjYF92o=;
        b=fPZGMTp8SfXScAZ9AsW5NJ3ie4ytX0KmETGnjpnxRfG5OWVqUB0/G24ZajVJv1LHPw
         zfJfrkVYbWLP1X3f4yI0RLAQ1oLM0wJWlfbBdX0Z5iDANvIIQ+Mg9DeE32owJnFsUaMG
         rtngNLJc8tFOuViMx72dpMJOubrjgrb3p0Onj117EwmaLHpMtzJhNXvMeA3B60BsdNh5
         vuG8JQMiNyvMUu+uQo5bwBN/ggmONCvTALizXjUl/wxty6d9VtRGwfvNTx5fq1UeJ2h5
         rRUX14I0UM5HCjK8L1kqLsl0AcaYljCHq4sad0AxFPDi+NXSDrz29OKyf2/HhH+GpANr
         Fwqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pCqpii4TdwK7fA7Q8974FYzUJR2DmUmu4EstZjYF92o=;
        b=OwvQ0LmsEyBItvW0QGnKghhGOHG95hXAvlfOjLRFYvwqSju1I6SVlzJZ4vhfnDCjI2
         TqipuvLdvq3D03E1sSxW+ZhAUbGQJKkZeMHiOTRKxM/WXvxsvT63WDc94oGwN8WvRAuM
         +1/JSnW/VBfmfvCU0MmVzlYe3eYyzrB6syShXXtWmDvTNcjKhvFmRBfwUQ99P2a0G0J9
         WwkfQVr3ZGl0vI1AVPTYsmRBeLpgcH+FG4YjzBPVtBuJWsgZ3I4/DEMMxPMexGZnLzxW
         l5aalkMSyZOTDkqVVMdm9kJ7w/uMxZfvUDBcQ261pCRqdz6fgbyqrKpkfTQ0L9xkZNCt
         +q3w==
X-Gm-Message-State: APjAAAWMlJQAeN3sDtJMvYB12LrdrPpwT6A2P8I46OL7UMJRQC2rkEHt
        PrWnDmOdZ85lJxRNSkhN1Avmwu0KlLj4rd5h7ss=
X-Google-Smtp-Source: APXvYqw0rRu1ehHZCQnF4rYks2jHytSzyqdxLHo7vYTvC34UtObqp0I8mPqphp+ctSgKgI1W4ctIiaZrkr3PRgkMaMI=
X-Received: by 2002:aca:5348:: with SMTP id h69mr3539699oib.119.1553867674156;
 Fri, 29 Mar 2019 06:54:34 -0700 (PDT)
MIME-Version: 1.0
References: <CAMknYEPrrpxESK0onwTHRbVwcZE2YQpT=RVzjb9JfEBEXt4NRA@mail.gmail.com>
 <CAL21Bmn0BQirS=vyTRHBx_kfuEp1JY4uw2wkjm5w_pgwgjA5iA@mail.gmail.com>
 <CAMknYENndiGBkC75aaYwWQZ0rkR5Nn=2L8f-PTzBNOXmhhHWZA@mail.gmail.com> <CAL21Bmm+KVsBWm8BJoqMP6LLBr1620quyTO4K7=yPoNWkvvxUg@mail.gmail.com>
In-Reply-To: <CAL21Bmm+KVsBWm8BJoqMP6LLBr1620quyTO4K7=yPoNWkvvxUg@mail.gmail.com>
From:   Kapil Jain <jkapil.cs@gmail.com>
Date:   Fri, 29 Mar 2019 19:23:54 +0530
Message-ID: <CAMknYENqM1Q_2v+0_DJtw41M85otpYzbVbbKPyh2NVZ++u=fpg@mail.gmail.com>
Subject: Re: [GSoC] Unify ref-filter formats with other --pretty formats
To:     Olga Telezhnaya <olyatelezhnaya@gmail.com>
Cc:     git <git@vger.kernel.org>, Thomas Gummerer <t.gummerer@gmail.com>,
        Christian Couder <christian.couder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 28, 2019 at 11:14 PM Olga Telezhnaya
<olyatelezhnaya@gmail.com> wrote:
>
> Unfortunately, I can't consult you properly about structure of
> pretty.c. I guess that would be your first task of the internship to
> dive into it and think how to improve it. By the way, you could try to
> make more detailed documentation and that could be one of your first
> contributions. It will help you to understand the system better, and
> other contributors will be happy to read it.

ok, i will be reading pretty.c and will document its structure at
required places.
