Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3AB4D211B4
	for <e@80x24.org>; Wed, 16 Jan 2019 15:50:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404787AbfAPPuA (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Jan 2019 10:50:00 -0500
Received: from mout.web.de ([212.227.17.12]:41941 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727060AbfAPPuA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Jan 2019 10:50:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1547653785;
        bh=8XhhAxgZtQJj1Ff42E9CqOtVgoqZVr4IHqj0BQzltvM=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=H+Wb741Wzqay+FEkmbE8iX2lIkQgx8rdpZcruh9f4rMFKIkrC4D9RFZCu5ohiuKQL
         ny4cxkz59LFJErzHEaRp7Faue1SWSVPhmWwiQCKSHB+v7uNvS8EO6HF5dxCLpCGcDY
         fhaevBXGH2b64GZ1eL22bkHADgQcnLi5keiJIOKE=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.36] ([79.237.240.227]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MAdx1-1gY0wt4BPH-00BvC8; Wed, 16
 Jan 2019 16:49:45 +0100
Subject: Re: null pointer dereference in refs/file-backend
To:     Carlo Arenas <carenas@gmail.com>, git@vger.kernel.org
Cc:     mhagger@alum.mit.edu, sandals@crustytoothpaste.net
References: <CAPUEspiz3RxwRsEJW2MwbVVEQh55Q9eA264=RPjtjkx8T-m7iw@mail.gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <410a950b-3cbf-1936-aea6-0d4894206a20@web.de>
Date:   Wed, 16 Jan 2019 16:49:44 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAPUEspiz3RxwRsEJW2MwbVVEQh55Q9eA264=RPjtjkx8T-m7iw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:9e+f7dKdJ4iXTFmJ81nfbQQjap3dEvuOcmQxdJIPcFi4JYAgYO9
 EwoI6Bx5ILDt4ysH/yJHh8aulswEUhaxWaWW3tHluPCONZDNdwdLreBvNdObK14Dv9tlvBR
 HCxoI1ihZ4GFwC9EWAr8kIZ2+MbAox+U9F53QJFJChP+JwwitzljzH8234zEw8vLpc3CgZy
 nKW+wrwPDZ/0Sw1PfL8eQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:WGtBbzBuw/k=:H2upkSeKx125aFzMVVJ6cB
 qINHowGAaJrtK3P0hK48dn9ntBYbzYNBcmFgZBUikAB/s46VS6QEacEcwhh/CGjTIEGJFoUsX
 gpVTbp9Z7EIGE6q8eCUmlswNZPBfz5S2wWcfFmYVyOFRmCMA/IuAoRAbUWwyR2K0WoGtA39M+
 BDJQJUZOxatX4xjEcoEn4dwffXz5ggHTxpAc3kC9KADCDBZN5yaGI2TErNpCTPfbqtxdtFuo2
 nshGgrRFhjx991tXbnsx0K6xaBev2x8dQ7S8F6zZk3lGhhZrWpCgiN5E2i+u3ux8OJ6la2OaW
 aDCjJA7fd//jNAvsHuBfHsAFPgP4AqJOiU4Ul9eYgBgOzw8KmIHHgrOstMoazFY+Fy5lNOj04
 Jvh6TLIE/pcwhFmhAbzsSzLVegEoR/Qo5QJXNAVSjeCokDl405V+2sxHJeNaVI4+fycF/OaHJ
 UBryxZrp+34MD708as6AmGVzEGFhn11m4+INvM72nZtk+D3YTJJa+M7shF2eRe1NJDoypyxEc
 VjsShrc2oCX3KhVcdH0mqMHF70DmjP3qB5ds6b+KAlEfguYsZBz4GgIlvu4s9UshLhkNWCIED
 fvq95OL4h2NwX3BcsSMZz0ZCii50k3NkViGA11cespM+eBX3JDwCY3/L69XCrnSJf8Fa6SxrP
 dwEM1b4yXBgzk3yyLmHvr0imDpwzGf3lHbb8tgvzEKqwG7Othl2YTpiw+OCfbqJHMeshM8PZU
 nySlreM2q33itmP47oMtZG8b+eUZ2TxYn4Mhc/GodiUdsv+Ozn8DMLgpC9ggd4U2Y/JOXNWqi
 ILnpfqQ7gL1wGmQzgYPLbmdIqBxM9n0wJpYgI2lAV/GnMppi3NOCm5WABZNAunPxdfJYXEBIa
 laEtc5QNpXskg4VBYpoPJSBUYHhug6mbFdhQ8ijHp1SwsGA4ToYcD+gZtzyACr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 16.01.2019 um 10:18 schrieb Carlo Arenas:
> while running HEAD cppcheck against git HEAD got the following error,
> that seem to be in the code all the way to maint:
>
> [refs/files-backend.c:2681] -> [refs.c:1044] -> [cache.h:1075]:
> (error) Null pointer dereference: src
>
> the code that uses NULL as the source OID was introduced with
> b0ca411051 ("files_transaction_prepare(): don't leak flags to packed
> transaction", 2017-11-05) and doesn't seem to be a false positive,
> hence why I am hoping someone else with a better understanding of it
> could come out with a solution

Tl;dr: It's safe.


The statement at line 2681 ff. of refs/files-backend.c is:

	ref_transaction_add_update(
			packed_transaction, update->refname,
			REF_HAVE_NEW | REF_NO_DEREF,
			&update->new_oid, NULL,
			NULL);

The function is defined in refs/files-backend.c; here are the lines
up to no. 1044:

	struct ref_update *ref_transaction_add_update(
			struct ref_transaction *transaction,
			const char *refname, unsigned int flags,
			const struct object_id *new_oid,
			const struct object_id *old_oid,
			const char *msg)
	{
		struct ref_update *update;

		if (transaction->state !=3D REF_TRANSACTION_OPEN)
			BUG("update called for transaction that is not open");

		FLEX_ALLOC_STR(update, refname, refname);
		ALLOC_GROW(transaction->updates, transaction->nr + 1, transaction->alloc=
);
		transaction->updates[transaction->nr++] =3D update;

		update->flags =3D flags;

		if (flags & REF_HAVE_NEW)
			oidcpy(&update->new_oid, new_oid);
		if (flags & REF_HAVE_OLD)
			oidcpy(&update->old_oid, old_oid);

The "src" in the message "Null pointer dereference: src" refers to
the second parameter of oidcpy() in the line above, i.e. to old_oid.
That's the fifth parameter to ref_transaction_add_update(), and it
is NULL in the invocation mentioned at the top.

oidcopy() is only executed if the flag REF_HAVE_OLD is set, and that
caller passes only REF_HAVE_NEW and REF_NO_DEREF.  So let's look at
their values:

	$ git grep -E 'define (REF_HAVE_OLD|REF_HAVE_NEW|REF_NO_DEREF)'
	refs.h:#define REF_NO_DEREF (1 << 0)
	refs/refs-internal.h:#define REF_HAVE_NEW (1 << 2)
	refs/refs-internal.h:#define REF_HAVE_OLD (1 << 3)

So these three flags don't overlap; oidcpy() in line 1044 is skipped
by the invocation of ref_transaction_add_update() that offended
cppcheck, i.e. NULL is not actually dereferenced.


I guess the function requires callers to indicate the presence of
non-NULL object ID pointers using flags instead of checking for
NULL directly because the new_oid and old_oid members of struct
ref_update are not nullable, yet they are used as (partial) input
for ref_transaction_add_update().

Ren=C3=A9
