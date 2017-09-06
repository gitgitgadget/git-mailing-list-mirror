Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8E9ED209AB
	for <e@80x24.org>; Wed,  6 Sep 2017 11:23:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753008AbdIFLXo (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Sep 2017 07:23:44 -0400
Received: from mail-oi0-f46.google.com ([209.85.218.46]:34568 "EHLO
        mail-oi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752485AbdIFLXn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Sep 2017 07:23:43 -0400
Received: by mail-oi0-f46.google.com with SMTP id h70so39902262oic.1
        for <git@vger.kernel.org>; Wed, 06 Sep 2017 04:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=zjuouzH3mjNuUzmfl2MRl9AwYPA0ox7EFj0EiHgQgHc=;
        b=SfjbDM4LGhBi5y5iYMIvxOsWlAmZ7QscCv5RoAaUk4tTSk1foUGprmnZFMxNMC8osH
         TeOhQF+1BOcZox29mm6oov6k/jcGd0+YJWJwPpmdknJfZRCVPWjUyOK7ygOaulXaS89K
         xlPrCeC60jyjBWaDln/bYLdpT7HfMWd8RGWy7TODatMKedJbzRMvAS3gwf1TcS6TAILu
         dbuUZ6cWewt+M2v58hPccXB9H72dIExdhXpvNtW3Ymb3DfBrFFk0dw8nvb6RCJ5riYEf
         lnsDyi6dUeEtc4WeKrKi2g+psCWERJYlI8wLo+zSUT5u1JuGyRsGrSAHBLFvBXEfGYCk
         AbKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zjuouzH3mjNuUzmfl2MRl9AwYPA0ox7EFj0EiHgQgHc=;
        b=F1C02m5gzTmfmzouJUgp+LmTsVHvHIJvOloB4yjY+JLge8UZUFh4ez3f8Hf2AraxpK
         bi4N9lAf7Hq10uYPC3nJArPpapAejGaSZp3xg55tu0PgckCJC7OA5u/UZpMb6XQQf/Lx
         K7RJmUVrJO0tZDTqFUjZXcclf4ivYYZnwRGJYXEKebrVE4PonQU/gXsInGdMITaHLicU
         /F4ui1+L5wBHZPfYAhEjwJx6j2ZCMHDvJyQ3dkECkK1I4SQf3SeXWnuXU72KOOP/dMIH
         AOyBHp1qGj7+J/UtCX0fHEjvbRsGAc8XZzLQZSVAnoGV7Z+OVXzH1JN8VeZNsB+7OC4+
         GiVw==
X-Gm-Message-State: AHPjjUgmtkM+T0DpjRFoPnlZnAG9rtleotvr3j4RZU3Wo8wzyBYdszXM
        OBuoK4AyKcd/AmgsRhjQ02Iistr5Zw==
X-Google-Smtp-Source: ADKCNb6wGZzn6aAamgj1zzna/Qa2wYrcnuuEZHYuT9xqrbm8X0I2C01shEypTNZfalOt0/j+T+cYxCV4onnoENMP7z4=
X-Received: by 10.202.8.129 with SMTP id 123mr2772875oii.40.1504697023106;
 Wed, 06 Sep 2017 04:23:43 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.176.69 with HTTP; Wed, 6 Sep 2017 04:23:12 -0700 (PDT)
In-Reply-To: <xmqqfucgvdk8.fsf@gitster.mtv.corp.google.com>
References: <20170823123704.16518-1-pclouds@gmail.com> <20170823123704.16518-8-pclouds@gmail.com>
 <xmqqfucgvdk8.fsf@gitster.mtv.corp.google.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 6 Sep 2017 18:23:12 +0700
Message-ID: <CACsJy8BdyS0TpP6o+qyfQpQ1wyfSn63P8U70EkGoV4-+EFteHw@mail.gmail.com>
Subject: Re: [PATCH v4 07/16] refs: add refs_head_ref()
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 25, 2017 at 4:52 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:
>
> ... which does what?
>
>     Unlike refs_for_each_ref() and friends, this does not iterate.
>     It just uses the same function signature to make a single call
>     of fn on the "HEAD" ref.
>
> Did I capture what it does right?

It's basically head_ref() but can take any ref store (while head_ref()
always uses the main ref store). I'll update the commit message. What
you describe is correct, but I think I'll leave that out and assume
people know what head_ref() does.
--=20
Duy
