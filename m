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
	by dcvr.yhbt.net (Postfix) with ESMTP id 8450B1F4B5
	for <e@80x24.org>; Tue, 19 Nov 2019 19:15:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726874AbfKSTPB (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Nov 2019 14:15:01 -0500
Received: from mout.web.de ([217.72.192.78]:56817 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726711AbfKSTPB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Nov 2019 14:15:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1574190899;
        bh=+xO3CH9V9lx4L26omrY8X9V7xeP708gorzSYi5ncuOM=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=N/J1ucED0nFGmEkV3GQa7z3DC88HAxs751orSoKR4kU0SnOKLYokyGwb9+TPhUUpq
         OWFhpzLFsjm1okTAvvlWbEwtjkDP5pqDSCtO9wW7UPXuzuC+2KuOIuP7UxbZpUrJ+j
         VoUXBCI4ZjnBjmcHC3O/BvUuE3qL6Pv4Z2THNuF0=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([91.47.146.29]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LshWf-1hrmg602en-012LPp; Tue, 19
 Nov 2019 20:14:59 +0100
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
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <321802c9-e5ea-452f-a3fd-7e01ab84b1f9@web.de>
Date:   Tue, 19 Nov 2019 20:14:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <eff19da9-3f9f-0cf0-1e88-64d2acdbabcd@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:00+5w6fCdJXrHIu4FDYYvZssNK9wmeRnyGAHqCuvvbTgh1fkJVp
 Crsttw9HnoDFD10qKqF1anKl7QIULcCgG/bWDbzaQ6JB+QoeH8x3V1rAKjihVtXV2ntoD5w
 R+d0BWoPkp3T3KwDeEQNdyRD4++N3h15PVh+5Q6MNX0Qw0nL4uaRoxokDCN1mHCvXQw5D2/
 JhA/4OirQUW/FkWK17zGQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:xyWMVum7zRc=:IKqAEBHCDwuoFjBuuZHUL0
 YlUFExsRgTq3qdFn5qcZGM9IMnVudOqGmWK4tTP/7hCzIf31cmUflVIgix6RU4zinATNiFdsW
 pgN/046ZU5oiNB4IV9jSWXscMBNnjJEb83joLg8g2XwCpPb+KR43eFL8N4X0nOuGUzuL75tTA
 Vq28946+Q8aferplYbhrqWYLVJhuHlc+xtTGZ3SVGzS/s1o9HXTZYiwduvd6TNGa7B45LimLr
 PrXFJz7jBtQOMm4jO7Om+wVOayTvW7RbpA0d07wms66rg7KIQkQ2iHT/vZg8H2QjoCuhf4FBa
 6qd0fDCklaUHrI5Uk7sOMRI5n8z0iUtbEDpuB9DgO6f2VXL2L4X7PDtHoClG5wHBIauPF/PdZ
 R7AqG8VM4Ut/1fYiPz4Z+jdsJlCElbFSdswVbBMdSI4CHJCruYcOeQSslX/wlptwKjOtuaZMz
 66ozdmmCTCCPTHqce1CzeEH4EQs0GENSAFBE7hZxCNjInD8azDMG3WPJITJ7EQSwSjjHOpp1m
 ESxNQNtuNwVwmarReDG7Mp/nxWcoWwc3K1yL40w+Z1u1WTlqd0pVJA+P/h0CPBAOWbVXhd4pz
 I/XA9IFyFFny6KMrb2sTLJniYzkzxqyBwwPxHIXjUlspXb4gr5RYSVCi5nNuwpXlfcCclFpAE
 86Tot7NL0JUPDyqkf3DNobHGA5LbH8VEquC9/D+IhNWlHGpyJIaVffEvxk0nOydtW7PifdZ+0
 U4uV0X8YMFSoHnAaKhjAbqJoqdrSiEoYS7RdJq7JirwUDP68/tFNxFSx3th756CC6wh1tCwVl
 Vl6tFOzVfkdOE86fS4MUoBb0teoXCXxijxVMsZamwxP6eRWV4m1Z0FwPsrfJLj1vzCeZ4kBlH
 NyMazNmzUYOAqG/CD0FSaUKkaYGC3rwTIrpAuLrKsGe1F+TZh53EHLWolxotuQVtMYthoIuc6
 hhyHxVHv9xlvWm4mDV1zzo9IeGxnsEVkWYyxwbO/vYHcqFRYk4Ct9r8PKuYZ3z26YbpOrrGVK
 gvMnqQW/PsDJwUUgWI1iaeKMKkgZqQ/0BbUaFQMBoIRbxPC+hrLVWLuHDLbtghI3thYr26nox
 UVQ2h+/3XS1iXWvBxjsqESRYcKdNblIzLGEPfZhEBY43GcJs1h975sDFTr64DNLgqn4rXknLe
 +Xhbo7QWONnri6aasVi0ZWOKT0UVhRuwpbCrF3/PPSrw7sZTcsRd9c27G+qqfozU0J1pbJySE
 /qIExUmAcSEFdJ1zH1kTB/vqPS2UPEdb/8SVLNg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 17.11.19 um 19:19 schrieb Markus Elfring:
>> Whitespace is not what makes the above example more complicated than th=
e
>> equivalent rule below;
>
> A different code layout might help in a better understanding for such
> change specifications.
>
>
>> separating the pieces of simple expressions does.
>
> Will there occasionally be a need to change only the required source cod=
e parts?

Changing parts that don't need to be changed does not make sense to me.
Why do you ask and how does it relate to the example at hand?

>>>> than what we currently have:
>>>>   @@
>>>>   expression dst, src, n, E;
>>>>   @@
>>>>     memcpy(dst, src, n * sizeof(
>>>>   - E[...]
>>>>   + *(E)
>>>>     ))
>
> Are any circumstances to consider where only the essential implementatio=
n details
> should be touched by an automatic software transformation?

I don't understand this question.

>> It looks like a bug in Coccinelle to me
>
> We might stumble also on just another (temporary) software limitation.
>
>
>> and I'd like to see it fixed
>
> Would you like to support corresponding development anyhow?

I don't see me learning OCaml in the near future.  Or are you looking
for donations? :)

>> But at least until then our semantic patches need to work around it.
>
> Would another concrete fix for the currently discussed SmPL script
> be better than a =E2=80=9Cworkaround=E2=80=9D?

These are different things.  Fixes (repairs) are always welcome.  But
they should not rely on SmPL constructs that only work properly using
unreleased versions of Coccinelle.

>>> Would you like to use the SmPL code =E2=80=9C*( \( src_ptr \| src_arr =
\) )=E2=80=9D instead?
>>
>> That leaves out dst_ptr and dst_arr.
>
> How many items should finally be filtered in the discussed SmPL disjunct=
ion?

Let's see: dst and src can be pointers or array references, which makes
four combinations.  sizeof could either operate the shared type or on an
element of dst or an element of src.  An element can be accessed either
using dereference (*) or subscript ([]).  That makes five possible
variations for the sizeof, right?  So twenty combinations in total.

>> And what would it mean to match e.g. this ?
>>
>> 	memcpy(dst_ptr, src_ptr, n * sizeof(*src_arr))
>
> The Coccinelle software takes care for commutativity by isomorphisms.
> https://github.com/coccinelle/coccinelle/blob/19ee1697bf152d37a78a20cefe=
148775bf4b0e0d/standard.iso#L241

OK, but I had a different concern (more below).

>> At least the element size would be the same, but I'd rather shy away fr=
om
>> transforming weird cases like this automatically.
>
> Do you mean to specify additional restrictions by SmPL code?

Let's take this silly C fragment as an example:

	char *src =3D strdup("foo");
	size_t src_len =3D strlen(src);
	char *dst =3D malloc(src_len);
	char unrelated[17];
	memcpy(dst, src, src_len * sizeof(*unrelated));

My point is that taking the size of something that is neither source nor
destination is weird enough that it should be left alone by semantic
patches.  Matching should be precise enough to avoid false
transformations.

>>   void *memmove(void *dest, const void *src, size_t n);
>>   void *memcpy(void *dest, const void *src, size_t n);
>>
>>   COPY_ARRAY(dst, src, n)
>>   MOVE_ARRAY(dst, src, n)
>
> Can the replacement of these functions by macro calls be combined furthe=
r
> by improved SmPL code?

Very likely.

>>> Possible nicer run time characteristics by the Coccinelle software.
>>
>> How much faster is it exactly?
>
> The answer will depend on efforts which you would like to invest
> in corresponding (representative) measurements.

Is that some kind of quantum effect? ;-)

When I try to convince people to apply a patch that is intended to
speed up something, I often use https://github.com/sharkdp/hyperfine
these days.

Ren=C3=A9
