Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F85D22CBEC
	for <git@vger.kernel.org>; Tue, 15 Jul 2025 08:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752568955; cv=none; b=U0En3UaiIwEaTk2ytwWGv0fz3VQK+nxRvvFj2wB1cSW/P666LMEfxHz94BTjRpWt/fPmstMDn2UVqTsf+0pxGHlSTBQT6esiriKo4iex5DiQu3ZJKd3Iyk3AJxk7kJaGT20FirkYKI7Uz3Q048F3pLQf5CIzcC1ALpc9viANytM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752568955; c=relaxed/simple;
	bh=BDXous5VpsLU5cSGXDjTQca0B2+e70RzOB3hS5BgXVU=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X0uNvpdzB3k9t1qrjo1Uk9GKjEb3yBKuYeX0DF8tAgt9AVms0pjwio5Qg2bXpnb5CqJ7jkgNvH4k6E7duW83vR4bxVkuXwfJnDTvMft2PgMks+tDNPbkacK2LU7PESiH8/WRK3YcNJvbTKXJX8x38hbrJ5l8H04xsMs2fJRhko4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i4ZneKQ+; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i4ZneKQ+"
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-528ce9731dbso2065082e0c.0
        for <git@vger.kernel.org>; Tue, 15 Jul 2025 01:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752568952; x=1753173752; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=pOai+fCDIQRFW5Fb8u3S60IHxS5SPInmNBxabKRNadI=;
        b=i4ZneKQ+Ln8oHY156ZSgHuUZOmSyiKkzc9AFrD2Z6MAQL16eB5q9klvqYgQPgHPvph
         Gv9v0QqdIknKx/ZkJ39/DckV1iHJLCC8AdHNL3up3UlXetRk6ajS1XP1gTmQZfSPVgPS
         XETikrTQ9nrtaPgTQDf8NQfuYj7SVCfYrEd774rKbKgd+3hgn0TVV+55OPhAJYeK9nh1
         xkmMojmQV9WKSV1Dz9PcYCYkOn8Ak41yx+uHuNHJ1M3lYxUDgXiY1pbwt2/j7jY7tj+C
         UbVoBuF0cLDesJjfrbGrGDPXEKiphS5tA0IGidJao2bu/qz6JN12fbVnc8PMGOm9jf4I
         Be6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752568952; x=1753173752;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pOai+fCDIQRFW5Fb8u3S60IHxS5SPInmNBxabKRNadI=;
        b=IV1ja0UMGg9O67hqUqN3nT2/i/rx/eRRVNKRqvKzVWXrK+nnLZK+S7MNooANrWCw34
         isRHPdcy74ERFNdEAsUbzNf6WCHGT8U25UgIbgdxU8aY7M7g51IeTZ6Lg0rVqlhF9ROd
         Rk0ScHnnRFX1y2LW01lYrvCQt5QSLh5lfOkgIU25lNwWl4pj7m6OnBjOuT0kAldxr53Q
         i/MfG0BUK7xZprd6YU21ylbhojXTQXPAwY+9CVY9xlSsFOnz1VbgterkdSDX5uyPUUTR
         VtrneoHX/at/i8yhKsQrKLZnsDhr+gN4zv3fo+5z1A5rAaLRd32p0QtImb93g6eUaIKN
         7a6w==
X-Gm-Message-State: AOJu0YwhBTSKGXL4qtp2Sb9WpO5ehKyrNT3w25P7jesAxRr94AxA9NsV
	8Az+R3v0IlYES4pcH3TUIY+BwMU2d3uznDUPvPCOuzurfuXQWh/LUUlf9va0pagU3RxIBEHjRAX
	sk7fjG1wosvK9KMlubiYWF0tuUctHjeE=
X-Gm-Gg: ASbGncvcGx2XsuIInFlmIEVEH6l3foY4CCNj25gvOyBzau8LQqhUJRr+FyrVFcV8qPc
	8kaaAYcmXtQ1QuPcIp8y1JAyw9pl+YqBrlmpDD9Y2ZIJihTMKLZQC6zS393PDvMkxXqJYHAHdhu
	mqwPosGrD/TPQggfoBMtybTOowcC/4BaKlEnssXcto9kzeSl/ZaW+DK3Ncrh/PGMXPmdgjjcQCl
	W5Wppun0tC2NcxBFs83eD+gHzpGCY6B5aqK8Nas8A==
X-Google-Smtp-Source: AGHT+IF/pigCCS4U4YFb7tfIxpGCMOkU6Yq/GhN7ANK9oZBMjYKsHETEa3eTFhYODMfMkptwm+yyc/S1D+vB3WpnN1A=
X-Received: by 2002:a05:6122:134f:b0:534:76cf:4900 with SMTP id
 71dfb90a1353d-535f47bfe49mr9780811e0c.6.1752568952379; Tue, 15 Jul 2025
 01:42:32 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 15 Jul 2025 01:42:31 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 15 Jul 2025 01:42:31 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <CAP8UFD1wRxZDCRC76VuuA8_rpNn__TQnL9RnNumCE33wAjSrMQ@mail.gmail.com>
References: <20250711-306-git-for-each-ref-pagination-v4-0-ed3303ad5b89@gmail.com>
 <20250711-306-git-for-each-ref-pagination-v4-4-ed3303ad5b89@gmail.com> <CAP8UFD1wRxZDCRC76VuuA8_rpNn__TQnL9RnNumCE33wAjSrMQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 15 Jul 2025 01:42:31 -0700
X-Gm-Features: Ac12FXyPOFybNupgCK0UOEpli7J5YkP4vje6oix4GNPQMsV7auQRe_pidgjIn2k
Message-ID: <CAOLa=ZSyVh1cWZL=F8Gk-URh7p6GTnPpOpWjGwCbwYX=a+-TNQ@mail.gmail.com>
Subject: Re: [PATCH v4 4/4] for-each-ref: introduce a '--start-after' option
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, ps@pks.im, schwab@linux-m68k.org, 
	phillip.wood123@gmail.com
Content-Type: multipart/mixed; boundary="000000000000da01f60639f3c11e"

--000000000000da01f60639f3c11e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Christian Couder <christian.couder@gmail.com> writes:

> On Fri, Jul 11, 2025 at 6:21=E2=80=AFPM Karthik Nayak <karthik.188@gmail.=
com> wrote:
>
>>  /*
>>   * This is the same as for_each_fullref_in(), but it tries to iterate
>>   * only over the patterns we'll care about. Note that it _doesn't_ do a=
 full
>> @@ -2692,10 +2710,13 @@ static int for_each_fullref_in_pattern(struct re=
f_filter *filter,
>>                                        each_ref_fn cb,
>>                                        void *cb_data)
>>  {
>> +       struct ref_iterator *iter;
>> +       int flags =3D 0, ret =3D 0;
>> +
>>         if (filter->kind & FILTER_REFS_ROOT_REFS) {
>>                 /* In this case, we want to print all refs including roo=
t refs. */
>> -               return refs_for_each_include_root_refs(get_main_ref_stor=
e(the_repository),
>> -                                                      cb, cb_data);
>> +               flags |=3D DO_FOR_EACH_INCLUDE_ROOT_REFS;
>> +               goto non_prefix_iter;
>>         }
>>
>>         if (!filter->match_as_path) {
>> @@ -2704,8 +2725,7 @@ static int for_each_fullref_in_pattern(struct ref_=
filter *filter,
>>                  * prefixes like "refs/heads/" etc. are stripped off,
>>                  * so we have to look at everything:
>>                  */
>> -               return refs_for_each_fullref_in(get_main_ref_store(the_r=
epository),
>> -                                               "", NULL, cb, cb_data);
>> +               goto non_prefix_iter;
>>         }
>>
>>         if (filter->ignore_case) {
>> @@ -2714,20 +2734,29 @@ static int for_each_fullref_in_pattern(struct re=
f_filter *filter,
>>                  * so just return everything and let the caller
>>                  * sort it out.
>>                  */
>> -               return refs_for_each_fullref_in(get_main_ref_store(the_r=
epository),
>> -                                               "", NULL, cb, cb_data);
>> +               goto non_prefix_iter;
>>         }
>>
>>         if (!filter->name_patterns[0]) {
>>                 /* no patterns; we have to look at everything */
>> -               return refs_for_each_fullref_in(get_main_ref_store(the_r=
epository),
>> -                                                "", filter->exclude.v, =
cb, cb_data);
>> +               goto non_prefix_iter;
>>         }
>>
>>         return refs_for_each_fullref_in_prefixes(get_main_ref_store(the_=
repository),
>>                                                  NULL, filter->name_patt=
erns,
>>                                                  filter->exclude.v,
>>                                                  cb, cb_data);
>> +
>> +non_prefix_iter:
>> +       iter =3D refs_ref_iterator_begin(get_main_ref_store(the_reposito=
ry), "",
>> +                                      NULL, 0, flags);
>> +       if (filter->start_after)
>> +               ret =3D start_ref_iterator_after(iter, filter->start_aft=
er);
>> +
>> +       if (ret)
>> +               return ret;
>> +
>> +       return do_for_each_ref_iterator(iter, cb, cb_data);
>>  }
>
> Nit: I wonder if what is under the 'non_prefix_iter' label could be in
> a new function and instead of `goto non_prefix_iter` we could return
> the result of the new function.
>

Yeah, that would work too. Let me do that and make it nicer! Thanks for
the suggestion.

>>  /*
>> @@ -3197,9 +3226,11 @@ static int do_filter_refs(struct ref_filter *filt=
er, unsigned int type, each_ref
>>         init_contains_cache(&filter->internal.no_contains_cache);
>>
>>         /*  Simple per-ref filtering */
>> -       if (!filter->kind)
>> +       if (!filter->kind) {
>>                 die("filter_refs: invalid type");
>> -       else {
>> +       } else {
>
> Nit: the `else` could be removed altogether here, but maybe that
> should be done in a preparatory patch.
>

Indeed, since I plan to re-roll with the changes you've suggested, I
will add this in too.

>> +               const char *prefix =3D NULL;
>> +
>
> [...]
>
>> +test_expect_success 'start after with specific directory and trailing s=
lash' '
>> +       cat >expect <<-\EOF &&
>> +       refs/odd/spot
>> +       refs/tags/annotated-tag
>> +       refs/tags/doubly-annotated-tag
>> +       refs/tags/doubly-signed-tag
>> +       refs/tags/foo1.10
>> +       refs/tags/foo1.3
>> +       refs/tags/foo1.6
>> +       refs/tags/four
>> +       refs/tags/one
>> +       refs/tags/signed-tag
>> +       refs/tags/three
>> +       refs/tags/two
>> +       EOF
>> +       git for-each-ref --format=3D"%(refname)" --start-after=3Drefs/lo=
st >actual &&
>
> I don't see a trailing slash.
>

>> +       test_cmp expect actual
>> +'
>> +
>> +test_expect_success 'start after, just behind a specific directory' '
>> +       cat >expect <<-\EOF &&
>> +       refs/odd/spot
>> +       refs/tags/annotated-tag
>> +       refs/tags/doubly-annotated-tag
>> +       refs/tags/doubly-signed-tag
>> +       refs/tags/foo1.10
>> +       refs/tags/foo1.3
>> +       refs/tags/foo1.6
>> +       refs/tags/four
>> +       refs/tags/one
>> +       refs/tags/signed-tag
>> +       refs/tags/three
>> +       refs/tags/two
>> +       EOF
>> +       git for-each-ref --format=3D"%(refname)" --start-after=3Drefs/od=
d/ >actual &&
>
> Here there is a trailing slash though.

I think these tests would make more sense in the newer versions with the
values swapped. Let me do that.

Thanks Christian for the thorough review.

--000000000000da01f60639f3c11e
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 8a33d16d9ea80a03_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1oMkZIWVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1melVSREFDY0E4enFQSlRwZkRUZXppVFJPS2R4bVh2Zwo5QURQVko3QlVB
ZFYza21FREowbE04V2I5UE5TbEdQTSt6SmZ3WjB2TmFGTGk1R29YanJBV25qZEMyZkJ5ZVFHCnYz
akxPb0FPaUpYQjlMOGp5SEo3S0c0QVI4aHhucnU2QXhzRHdkTUFrTGZidnVrQmZVYkVvekVkb3dO
aE9OVS8KcmZJMkVHd0J5RVRNUyt6R2hzbHphUVVJK05ZOG9mRTdyVGNqVzI3S2ZTaDdOVjNVRENa
MVlhREIveFJBMTJNeAp6Zk05VDNiQXFLN2VndHM4b0RVdXNYYmZvZGdNaVFyTHAzQ1JjUHdsblNX
eVdiTzZ5bXd4ZGJOMmFNTTJtK21SCnF4aVJqWE5rZys0Nyt4bGw4bFVWT05iWmN3Z3Z3bEhVRU9z
Z3FQR0RaLytHcGFSNmNwdXhVUWI4SEt2SlFzSGwKNFFYd2NyK1dqOW9DbjA5RFhUcTJYSEcvWFFO
cnNEUzlMWCtMeVdmbkdnZjFwazlXVFB1TDRtQ01zU0hJSEphcQpNTWxUTHFhR0ErMlFhbmZrcHpt
T1l5VDVlTGtQQ2JYbXJXT0lLTEZGMVhDK09qV1h5azU3OHJaMlBoSGprcnVzCkJ3VGErcjZMZTIv
TGtFUVp4VGZMMlVWQTh6MzM3REZmKzhZczBqQT0KPXBEU1MKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000da01f60639f3c11e--
