Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BCBFE1F4B5
	for <e@80x24.org>; Sun, 17 Nov 2019 08:19:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725963AbfKQITi (ORCPT <rfc822;e@80x24.org>);
        Sun, 17 Nov 2019 03:19:38 -0500
Received: from mout.web.de ([212.227.17.12]:43531 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725283AbfKQITh (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Nov 2019 03:19:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1573978775;
        bh=Egme1oPR09WK1mMaX9SSr1ORJA4miGWEDnst+wUeZds=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=CoFHIVdqExvQL4Rpa+3YK7BhzPBzhgO6cjLmDDE0oqx6gk2KB43wbMiyYO5YsrexE
         PQDaL5KKCwO+s7KnKdwXeiVNksK6Z44aq9vti4UVpusYsbRr5w034x9A2dUNYbEgrT
         23p5HNmiySUNAOOH+g/yn6p32Q+CIJwtDgXk1DZA=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([93.131.59.42]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LshKH-1hqQoA21GL-012HeY; Sun, 17
 Nov 2019 09:19:35 +0100
Subject: Re: coccinelle: adjustments for array.cocci?
To:     =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Cc:     git@vger.kernel.org
References: <50c77cdc-2b2d-16c8-b413-5eb6a2bae749@web.de>
 <5189f847-1af1-f050-6c72-576a977f6f12@web.de>
 <05ab1110-2115-7886-f890-9983caabc52c@web.de>
 <fd15e721-de74-1a4f-be88-7700d583e2f9@web.de>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <50b265f0-bcab-d0ec-a714-07e94ceaa508@web.de>
Date:   Sun, 17 Nov 2019 09:19:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <fd15e721-de74-1a4f-be88-7700d583e2f9@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:3UvtICzUMf7HGEBgS261y7KzghcH3ZBdY2GfovZyYswRJ+XY/nA
 W07jKvx2aXtNwSiKgL+fJMQIOLE9/IRFATVb3XfsCTbb0MEFac5x7GXjDt2mpQos0wmjZ1v
 QzBk+tpK4oEW82kmbZzx+SX150wwtQgO/pczS6BgWnydRVq4G+641ETF89Q1samDYBKa23B
 TeuxmOsNSSHf6+7FQ0Yxg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:zN58jBHY/qU=:SgmceoNxlNQ/cKDqf73wit
 C2978Q6811VzwFurqxQHfEeaGJdRWRKBdjCX/4Oom3uqb5StWoHSaQADEkBJizxLiafq5EewP
 nxC9hVZRXdY5Cc0BuJSCYOKAzSpPJtDlQg8dX31LQ5+ErrOwfveEazqF0dpkcG92Iefilt8vt
 LleLVF6UhwCSTKMz3nXwHghliJWI8HYu25nP2zuY0DC9mhiNNhzw6tR8WHvYNvs2tkXVtWjwg
 lfXAcI0G6CF1j6U4fSe7D3d0KtbbGCy/s74kafNiYM5BJboKh9sZRPA7wgj9LDpg0O/vRn+Vc
 gqvtapDH9XIeLdxXNsoik5E14c0Zd5ZLFwKDH+7ZVmIBvzBzK3YsCHM0j+3tSC2OdRiZ73aJr
 +0fRUUZd8vCtkyzRY8M/BoarJYJezCYOJ/9BO56qZFHlmEBPFcZK9FRXMmkgo324OYjr1n/6j
 x5hs+ky3RLKxSOPp1NuQz/H5jQvHFVM7OZ2WaBOOqPLvyJ9nTzEwmlZW1GsaJL5i8zEAGJg3v
 jkAMEr9kguV8EVRLpCwkWr703gGkanf2qIWTTB78QTB7DMDgFdHUaR09LWQBk9K4irwh72zli
 p7XFWiHi+WAHJgxLaeDIRuVJNNYhcK0Q2i8g0w5zOJw6CCFsbcyNcjsXaII7dS0uIIg7lCoUZ
 SH9d5zExqWPBZ4qoVbP4qy1ir8/ruiKCZORl8y8xiFfHdbsLYFPQx0ym+79eYhojQ4EQJJGJK
 wTzYPQBFrn+jMSRzWBDuuBwoV4w54Vy1u79H3IrEbMmBdwl5j1d2O2hDWkt5WXCH7zlQ6WiUT
 13EhxLTll2NyLJLP6LWCTsnqXng9YMGWpijU21Kh8yG0NNObRbJDQuqskztkOsOOcbOapcelO
 0wjeTePO85qf/hFbJgFfVkPNRMDfKXO6sfWxXPDsde4zxhaKiF6/QL7AT94zGDRnHY1xy/bHw
 sBj0+Ctc9qu3VaqSdKH/fykZ38p6urqpGW4zUb14On8jfR+ZkJ9lwCmmKQBEvHveKf7daFJE3
 6uDLE/xtcELkDMYT0vwfZk5wUtuiedGWewZ/PgyLpEZgPJq0WaSp+FGlq1N1MtLF9Drub0hU7
 iF8tQaDeVxmN3PL9Y+9YNzOhMrIcrxDa7lHQ9cZfx0EFFkfX5hcDBAEo4aP6UlhpmpC3ztMv/
 lohlR6L7MvfZtqGtY2dVcCZ0XpQZ++EY4eAJPuvQCKEmCGJ9QNhomICX2c19a5KoZemiC4zAL
 W3uIdF3kCUydtw8HZmOEQ04/uPBH9CxpdYi1/LcXy/qbOlKgvLr6OKntOXGM=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Which transformation rules are questionable and why?

It was chosen to transform source code fragments (pointer expressions)
by two SmPL rules so that the search pattern =E2=80=9Csizeof(T)=E2=80=9D w=
ould work
in the third rule.


> Removing broken or ineffective rules would be very welcome.

I suggest to reconsider programming opportunities also by the means of
the semantic patch language.


> Specifying disjunctions inline can make rules shorter, but harder to
> understand due to mixing languages.  Perhaps this is a matter of
> getting used to it, and syntax highlighting might help a bit.

I agree to this view.


> Mixing in the unrelated xmalloc/ALLOC_ARRAY transformation does
> not make sense to me, though.

I propose to increase the sharing (or reuse) of involved metavariables.


> Matching sizeof of anything (with the x) can produce inaccurate
> transformations, as mentioned in the other reply I just sent.

Would you like to apply any further SmPL code fine-tuning?

Regards,
Markus
