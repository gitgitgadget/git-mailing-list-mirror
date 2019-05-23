Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 067B91F462
	for <e@80x24.org>; Thu, 23 May 2019 21:04:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730544AbfEWVEx (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 May 2019 17:04:53 -0400
Received: from mail-wm1-f41.google.com ([209.85.128.41]:54033 "EHLO
        mail-wm1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726222AbfEWVEw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 May 2019 17:04:52 -0400
Received: by mail-wm1-f41.google.com with SMTP id 198so7221990wme.3
        for <git@vger.kernel.org>; Thu, 23 May 2019 14:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=3hs7aDPjKqBV0YnWu5SjBk2F3x59OOJon5kVAkkYkUQ=;
        b=FXTncbp9FIBaNldhiA3o2qiwdViGeVg/79hN/TUWrJ7b/8PmQ1d3feCONkmlICDHXN
         ZvoVwnnQI7aDQ7eLtof9Dgql3KW+mxtyGnRFUL1cpFHQJ//JJfBH3d5o3pZ9QESGpaRH
         ABP87s/B53tehx6KN6rTlBhJs2EUpAohbNWMsNly3ogy5vuBkW1Z1W6Y+76WbpM4q1qE
         Hm7qv9ct3Lm2AJKU/4dQt64OGDwXbnyuU4vuA/OfRE8yoMSbV/4iwl3wkUOgKhux//KR
         J15k3h37cF53NjtK7VFWx7VU4EQTBb2AyTft/Zdz382PFP8voY1KVJeQlVc1HHBsoq38
         dYJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=3hs7aDPjKqBV0YnWu5SjBk2F3x59OOJon5kVAkkYkUQ=;
        b=YluS07qaCntx3QxPi4MqXXFdMTnwc/zZQLuGSiMPTYF2sjGjE3deH8yGalCIU/Ct03
         LvnIWMces2DpAA3faWjkiNTtq+XtzBw71GrBoHCwklwLod/HpNZruERUVFypf0FAjBKI
         1Ap+IEqAFaKX4Q8vkd0c+EQxONwiRFvnvQonJXjyvhi0l69YgAkmg8k+Xa7ghN0OUQda
         x497expxYjW1Gp0U7iK6P48YOrEDomjGCXvId/Ib8JRXjGBi8c/U/ZEJWJpRKNa5rtsh
         UQtIQ9D7vh/YtjuOqsV0F16HAJpmliiYZTW4Mbf1b/DhaN6s+Uex8A75JzvwzjLFB3MN
         pQYQ==
X-Gm-Message-State: APjAAAVbDEU+I4spR4SPxHKl9epLnKtmp8s8hXWt+AKhvkS6MTqCiD3D
        A+YKhpbBRaC65Tlyw15CmAGYPQ0PZOo=
X-Google-Smtp-Source: APXvYqwE4G1hFyqa3MRAwiF/J5/1t7+NadX/nJO24tzgSdOkmsMgyq01fCUTmYXXpDw2RsqnV7muqQ==
X-Received: by 2002:a7b:c7d5:: with SMTP id z21mr13275913wmk.56.1558645490619;
        Thu, 23 May 2019 14:04:50 -0700 (PDT)
Received: from Laptop-Acer-Aspire-F15 (ekn89.neoplus.adsl.tpnet.pl. [83.21.181.89])
        by smtp.gmail.com with ESMTPSA id y18sm436192wmi.37.2019.05.23.14.04.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 23 May 2019 14:04:49 -0700 (PDT)
From:   Jakub Narebski <jnareb@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Mike Hommey <mh@glandium.org>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org
Subject: Re: Revision walking, commit dates, slop
References: <20190518005412.n45pj5p2rrtm2bfj@glandium.org>
        <20190518015005.GA951@szeder.dev>
        <20190518035828.pjaqfrkkvldhri6v@glandium.org>
        <20190518041706.ct6ie5trvxgdhjar@glandium.org>
        <f14799c3-e343-eb41-3536-65de7e38fbd9@gmail.com>
        <86mujhpewj.fsf@gmail.com>
        <cfa2c367-5cd7-add5-0293-caa75b103f34@gmail.com>
        <86ftp9p7i8.fsf@gmail.com> <864l5opuz1.fsf@gmail.com>
        <88662e18-db51-cb48-3307-0ea2a91c4ebe@gmail.com>
        <86lfyyny0p.fsf@gmail.com>
        <f1f2c7f5-9b78-8404-2738-ab895a06c133@gmail.com>
Date:   Thu, 23 May 2019 23:04:49 +0200
In-Reply-To: <f1f2c7f5-9b78-8404-2738-ab895a06c133@gmail.com> (Derrick
        Stolee's message of "Wed, 22 May 2019 15:06:32 -0400")
Message-ID: <8636l4rifi.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:
> On 5/22/2019 2:29 PM, Jakub Narebski wrote:
>> Derrick Stolee <stolee@gmail.com> writes:
>>> On 5/20/2019 7:27 PM, Jakub Narebski wrote:
>>
>> Restating it yet again:
>>=20
>>    A.  corrected_date(C) =3D max(committer_date(C),
>>                                max_P(committer_date(P) + offset(P)) + 1)
>>=20
>>    B.  offset(C) =3D max(corrected_date(C) - committer_date(C),
>>                        max_P(offset(P)) + 1)
>
> The problem with this definition is that it "defines" the corrected date,=
 and
> then _adjusts_ it by updating the offset.

For me equation (A) was just an intermediate step; we might call it
adjusted_date(C) or temp_date(C) instead.

Note that with the following adjustment

          corrected_date(C) =3D max(committer_date(C),
                                  max_P(corrected_date(P)) + 1)

it is +1 corrected "V3: Corrected Commit Date" from gen-test.

> I consider
>
> 	corrected_date(C) =3D committer_date(C) + offset(C)
>
> to be part of the definition. You could restate the definition as follows:
>
> 	corrected_date =3D max(committer_date(C) + max_P(offset(P)) + 1,
>         	             max_P(corrected_date(P)))
>
> or, equivalently
>
> 	corrected_date =3D max(committer_date(C) + max_P(offset(P)) + 1,
>         	             max_P(committer_date(P) + offset(P)))
>
> This definition, in a single step, satisfies the conditions below:
>
>>=20
>>> The final definition needs two conditions on the offset of a commit C f=
or
>>> every parent P:
>>>
>>>  1. committer_date(C) + offset(C) > committer_date(P) + offset(P)
>>>  2. offset(C) > offset(P)

I think it is easier to prove the conditions (1) and (2) using two-step
definition (A) + (B), as I have shown in previous email.

Also, what we need to calculate and store is offset(C), not
offset_date(C) (i.e. corrected_date(C), if you prefer).

> Plus, the "+ 1" in the first step takes into account that "0" is a specia=
l offset
> value in the commit-graph file format meaning "not computed".

That assumes that max_P(function(P)) over empty set of P is taken to be
zero.  Also, I think two step definition has the same property.

>> Well, we should check/test if performance benefits of "offset date"
>> ("corrected date with rising offset") truly holds.
>
> Yes, a full performance test will be required. I have full confidence tha=
t the
> monotonic offset requirement will have only positive effect. That is, it =
will
> not affect the case where committer-date was better than generation numbe=
r, but will
> help the cases where all the committer-dates are equal.

I worry that monotonic offset corrected date would behave like
topological levels (i.e. like current generation number v1) in more
cases rather than like commit date heuristics.

P.S. there is _theoretical_ problem with all date-offset based
generation numbers (slightly more likely to occur for monotonical
offset), namely that in the commit-graph format v1 we have 34 bits for
commit date timestamp, but only 30 bits for offset; and there might be
the case where offset do not fit in 30 bits.  It would be however very
unlikely, e.g. commit date of 2028, then commit date of 1970 (timestamp
equal to zero).

Regards,
--
Jakub Nar=C4=99bski
