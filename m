Return-Path: <SRS0=oq1W=ZN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61D45C432C0
	for <git@archiver.kernel.org>; Thu, 21 Nov 2019 19:02:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3225B206D8
	for <git@archiver.kernel.org>; Thu, 21 Nov 2019 19:02:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="rgFG9LIU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727110AbfKUTCC (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Nov 2019 14:02:02 -0500
Received: from mout.web.de ([212.227.15.4]:40441 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727102AbfKUTCB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Nov 2019 14:02:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1574362919;
        bh=M7RrnsvFlI+vHX5g+T1l/AHl+K+jHyDx8/SM49KwoH0=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=rgFG9LIUovL7UyC8/RQlzoOn8Hd7i2YPgLe7mDXTgGKpj9f96cy4FIMvdOw0fHSSS
         h+LsjxCKGaenhGvachPtyAE78ur0mR1iucFyLl3q5ams81JFEckZrZ7sCr7VMLFBnx
         L46g+kHjPp8JS/GWBMRcird6zNNAo8v8bzNSo28k=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([91.47.146.29]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LjJWR-1hzL6u3Nkd-00dTO7; Thu, 21
 Nov 2019 20:01:59 +0100
Subject: Re: coccinelle: adjustments for array.cocci?
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     git@vger.kernel.org
References: <50c77cdc-2b2d-16c8-b413-5eb6a2bae749@web.de>
 <5189f847-1af1-f050-6c72-576a977f6f12@web.de>
 <75b9417b-14a7-c9c6-25eb-f6e05f340376@web.de>
 <fc56b970-4ca1-7734-c4bb-f57cae7a273f@web.de>
 <57b5d1c9-72c1-6fff-a242-90f5f24f0972@web.de>
 <37c84512-ba83-51ce-4253-ea0f7bd41de0@web.de>
 <eff19da9-3f9f-0cf0-1e88-64d2acdbabcd@web.de>
 <321802c9-e5ea-452f-a3fd-7e01ab84b1f9@web.de>
 <a4a882eb-5e0d-dbcf-fd01-9d5831c4a8e6@web.de>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <d4a5d22a-7ea3-641c-c502-fc99ce194f2a@web.de>
Date:   Thu, 21 Nov 2019 20:01:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <a4a882eb-5e0d-dbcf-fd01-9d5831c4a8e6@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:T4nwuFrKdytRPiHdfO+ftRNlKoY5vevxHcv2wqXBzR0Zh8Eh4aP
 1nt7efkkDzht4wAeiPVRsZYc6BBgtHZhymmuagW9YYulWCCzrdbaMkHLykgCXrXqLrfj6zy
 AQ1pUN/3Lo9nbF2upjWvquIRxYeurfLGUEHN6l5vByFuFUvfRzuA+NXLmHtOUO707jTdJ3t
 tGh8FHrxzY9u6Yoy+DDeA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:kizk4dgWua8=:tPm91kEGFl+9SjWf9/w6Mw
 Vm3CYQcolXpKeuzSND54B9Ksr0xgQ9Mzk6OgVEaRUgPHFMc46gWjCvB+RcloVE3zkpqjsRILG
 0iH+dbkJQN7KFF8+CVj/Ud3+4SVuZ4vC5mpT2H/wU4aR5f+0sVDp3ATZl2cp3c88jY8DRoDDn
 SDZ242xW2nxzIdqAECQlNt91wU1pERoOyGIrGpnz4LvCo0WnW7CFAF+DYqIArn8e2yyAD22Ju
 XLFlgJnx4VI+hYCXOgY76zUDtD3aPjAeWVN8Bh6uhgm6uvDVdgJ45wrWLtin66QNi4FBBJEx6
 oWJiJiqkTjBFMeJsbzbCwwReY8eeJlv+WEKW8nj5ZA55LFz0tE53PYCK3CXhGCU8lY+hgLglN
 AKV0HbLb2paHrP6CX8c3VJySCHjEGDGAl6vx1+U4UmaiDBiSMtZq3A6/elB0aHb+moWHBUUsZ
 g/Wfjt6Z2f6BZDI3WfHQAZTtrtudTmk7TUtP3UvPbBxYcx/gKZt5sYDz+VgGCL+HU1df8D1kB
 88GWja8MAakjWCz2bDK7ay/ywQ6ILveYWS5upgaL2TSCuHgN07Nt/uT85PN8BZcAokEZyCdy3
 HNELSt9fCzKQDkRtzBoyHIv56f7UDXBH2YWkIZOJAN2q0v7VOvwdvJZaTJpJxtK5eN0Yyq+zN
 WeTDGbYwazffYXjvgUVEV/X1nbX9xaI6ihERfXn95ir0XscRbjw5b8dG68s1vHkvKA5VQZUsd
 4GuE19ucyp5MK2Nl4kSstCT7+7Aot6qcgB7oGO+c2rfhcqv4ASnHMwZw9JRSmpDOWY05ArSMl
 HNlOAxqwucHc7wQJxC1Lqix2t/nEKETRGOPHBN8h9rZUioceQUPHzS/QuP3638PvcQP/OwB3L
 yQoixjWlF6Gg+mOfQ3BRUHMTuLnUC8CCFVtDmkMRi85rzBX6HS/Gjyu/O6QOgo9ELyl7/Kg5D
 50NOFfR08H5HozMPLapU1tbu2pgJrVsYpNXGwcrFcgvBoXHux2e2KZeVBYmKwcoVyWvwPJUks
 qf3y1Ck5ORsokvVw7bV3fo8FBORuD22HmSQ3ut41neKpQzglKjpQ041gv8goz+MaNmTEZKrog
 N8gXt6fno990rtmwSfEtvteI5wt+T5podAh0Qc4PnjsRZnQCqZ+DJz3xH1k/omibMvN/NQ8lq
 jyE/ZaI4iFADetKatL2O7B3GxS/GqRDBPt0TqJQQu8gUloRZRSPm69Al1jE3Ah0G6JMnJMG8B
 fugsudAGsJ2Rb/UpGYENg23v0TnXd59XqcWn3RQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 19.11.19 um 21:21 schrieb Markus Elfring:
>>> Will there occasionally be a need to change only the required source c=
ode parts?
>>
>> Changing parts that don't need to be changed does not make sense to me.
>> Why do you ask and how does it relate to the example at hand?
>
> How does such feedback fit to the discussed SmPL change specification?
>
> - E[...]
> + *(E)

The cited fragment is from a rule that normalizes references to array
elements which are fed to sizeof.  It reduces the number of combinations
to consider in the rules following it, but it's not in itself a change
we'd want to apply.

The next helper rule turns sizeof operating on array elements to sizeof
on specific types.  That one is much uglier, as it removes the
information from whence the inferred type came.

In practice none of these helpers transformed any code that wasn't
matched by the final rule for using COPY_ARRAY.  It would be nice to get
rid of them nevertheless, to rule out such side-effects.  I just don't
see a practical way to make do without them, though.

Ren=C3=A9
