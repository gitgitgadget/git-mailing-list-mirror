Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4F3E820248
	for <e@80x24.org>; Sat,  9 Mar 2019 18:58:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726360AbfCIS64 (ORCPT <rfc822;e@80x24.org>);
        Sat, 9 Mar 2019 13:58:56 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:45456 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726340AbfCIS6z (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Mar 2019 13:58:55 -0500
Received: by mail-vs1-f68.google.com with SMTP id n14so485750vsp.12
        for <git@vger.kernel.org>; Sat, 09 Mar 2019 10:58:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=PhgqXpE/obG2vMKFJYrTCo3MIsbnTEFOuEySqvXlijk=;
        b=k8mNUcnIHrxf0On+4SurW3AxR/k0bZ3xjlS84CiqHhkK5ppNRs0kGx8rSrHdWiJn9I
         uPLyY5Bw5ilMeZeilotLbEZuDNAQS/VVqF3dnCJwGPjxJ+UZoblf9bpSVPk0bGEguOz5
         7+ic/g1+8Brcx1SQzySvdz8lzYuXxCN9PRfd3Av8B/okpj57kfQnvXO2ksvS/bgSrs13
         Tk+aBRNGy5T98CHhAgFzJ2OGExMH/0pfSjK+mUV4zSAPrwEncXPIKIF5mRoZmYXJ/nEj
         jXMBkAJP8CGrRZBsk/EBwR5AxAz6dzid97CwZRFZuK97cA3yqoMwzOuNj19oDIBkG1eY
         i/8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=PhgqXpE/obG2vMKFJYrTCo3MIsbnTEFOuEySqvXlijk=;
        b=R4UZfyPa1ckwi4A5lo+QnD/svou2kdCP7km5BSLEyWnE485YXw+47FQC8eokpoq6wn
         xzXWdY352/kYI+EHXgC9sNyUfU1ulQUS4rp7WMOLf1V6U4CgsXf/Kb0jaAhd+Qmsn22G
         juf7hDdkyhJSBYtGhq1LfvFJHFHXzR5y6ImT9En2y9uI2+IHjVEf2vH1w1Tb2ARdifgt
         cN1xrUPRn6rS+dce5r4praqSQ/yAS32dUoInnc/+36VmWt2tqV9ldB5h0u4j9gP/8GTC
         yVw/VYxdFUv5j6f8hhmHgYvVDtLEgIa54qvCBYa/5a8572uMPAAq8LcT4cPYwKStDy9k
         eSmg==
X-Gm-Message-State: APjAAAW3IJuxuowaO027heYsVGu4a1okmsvr7oCURw+z8CQuxNxqVM+j
        SAvf5+L/F8x5rZLll0ouw+uE6dOrtQUDylJefis=
X-Google-Smtp-Source: APXvYqw490lnGfIGKC/g0sMrw9kaRT8Nfqdndy3s+GL+bGPNeHzaRdGTVPtUxGf+worEHQackuPHXsL0eqPtsFq+6D0=
X-Received: by 2002:a67:b145:: with SMTP id z5mr12675017vsl.53.1552157934831;
 Sat, 09 Mar 2019 10:58:54 -0800 (PST)
MIME-Version: 1.0
References: <20190308101655.9767-1-pclouds@gmail.com> <20190308101655.9767-8-pclouds@gmail.com>
In-Reply-To: <20190308101655.9767-8-pclouds@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 9 Mar 2019 10:58:44 -0800
Message-ID: <CABPp-BEW3NBBoVrpZWiopgKnFZAK7RCZ5mAzdjeSN7wAPoLm2g@mail.gmail.com>
Subject: Re: [PATCH v1 07/11] restore: default to --source=HEAD when only
 --index is specified
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 8, 2019 at 2:17 AM Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <p=
clouds@gmail.com> wrote:
>
> "git restore --index" does not make much sense since we're told to
> restore the index from the (by default) index. Set default source to
> HEAD in this case. This is basically the same as "git reset -- <paths>".

Can I suggest a slight rewording to the commit message?

"git restore --index" without --source does not make much sense since by
default we restore from the index.  Instead of copying the index to
itself, set the default source to HEAD in this case, yielding behavior
that matches "git reset -- <paths>".


The rest looks good to me.
