Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 268F6161939
	for <git@vger.kernel.org>; Thu, 11 Jul 2024 18:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720724095; cv=none; b=h00x7YjOvqEgpAf3SWpMsjYYQGTkbLtOG4sE6KLlgrqjCO6GqN0MaB3V8BI7SaIsArT6DVwARwCv2htSOgqfjFDzhIN069MmC58oLADqtIN9oQUOenu68JsorIIsNIk8ArlMpoAhTCC0tCEzWItonVH8jbgBDhAL0XEd0chFkV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720724095; c=relaxed/simple;
	bh=f2zstfyD2WiVynebkFbZgczJ57pisnKc1GRCplEJNCM=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:
	 References:In-Reply-To; b=lYJ6BhqQBKa6K5PifdFRQr3extZUqCVtIEx/HZbN4nwMi0hBFqxJjzMwba+73dvceGEpMq6bPAyf8lOJRPOQaYwoQYacd7By57u1Do95wD62qdQIB7XEHRyIpzSMONzwh3Izpsq/bkFBEJ4ZE8XNLig9HDm/fnSlxx8MBwvSkKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PZBaV/eR; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PZBaV/eR"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-78512d44a13so838490a12.1
        for <git@vger.kernel.org>; Thu, 11 Jul 2024 11:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720724093; x=1721328893; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G1+jX8Vc4s1lXK535rY96/l6cOtYnEsQ0Q2xAyspe0o=;
        b=PZBaV/eRVCcG/T6usDUaYfZS+UFgsFclWOqMrQpYlmBhfY2TGAowbVXp+gUupPTLTi
         Qvqn3ucOTI4NOFZywE9f4B3kuQ6RBTNIrF2UPjWNwQsmCD6TZ1TqumInUeieI4Knxnyu
         wmHVWv+OjdNZH9ZjRyhmJ019UEcYi4iNqixhhvxLFx3GAJghAYO3AYN4SJQhpnQegFSu
         7k0nRTItZXCadYyuJsEH4lkGGgFKQlmBSsCHBMsG5eK57DLJC/j5PCGbNIiITrnpY34I
         dN/tBKkGIKrupyjpyseCCtvsKwarPeNRGv8pYnHDwLGD6lgnYOUtzJmbx81PaBTiUays
         asTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720724093; x=1721328893;
        h=in-reply-to:references:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=G1+jX8Vc4s1lXK535rY96/l6cOtYnEsQ0Q2xAyspe0o=;
        b=kPI9nGPHv41oEDTZ15rk/u/7MX8bELEyG3ssqixYDtBFJ+0SJx/sxliUYgayUfuwgt
         9WdGQ+QtJcGrHdoXUu/qL2n4GkSNGNN1joxFugj4wX7NNL/1bqJcU3AemgzWuS0BG2pr
         wzdxz9nVRkpuBaXXIjY37qu5rwxwBaRxtMoLzaknJL7gzl26UC6iNIYLCzpoiB2Wn2c+
         3mo2012MbeB9iffIWtLnzE0TCO5gAG1z9xSwx8WqI9DsiJ6CqgScjYkjrH9J9i2RshgS
         3ogtRhcQCLCeuoXMOxpwpgG/qPm5x71Qa+RHQJG7o6L+U6ZUeea+RRT4RHggCqqNLysC
         qNaQ==
X-Forwarded-Encrypted: i=1; AJvYcCXMXUsKVOgmhHZrjQ6yGc1VDUwXCz5KWssqEKD/rJyflQ54ijAinWCqdnhoCvBs9ZNYuNmNQyJZ3Lu+x2qysv2chdWg
X-Gm-Message-State: AOJu0Ywqsv90cwqsWrf3+/JXBYJSMwAAyDOEIO/+CtYP5CIWGB6I/fzg
	DuxExjSMf5tCmbP3ElkcaqJB3guFu3eZ3ZvKQ4P6kYSVxxG6ASYO
X-Google-Smtp-Source: AGHT+IFmhiHi0RByUx/lZtRwWJblK5PzajfJo++G2j9PGKBw6ukANVBNzVcjBEkpHnt8byGG6+GsmA==
X-Received: by 2002:a05:6a20:2588:b0:1c0:eba5:e187 with SMTP id adf61e73a8af0-1c2981ff8c9mr13225542637.6.1720724093259;
        Thu, 11 Jul 2024 11:54:53 -0700 (PDT)
Received: from localhost ([2402:a00:401:a99b:b1ca:de8:cd9e:bf98])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fbb6ad3837sm53891465ad.300.2024.07.11.11.54.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jul 2024 11:54:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 12 Jul 2024 00:24:48 +0530
Message-Id: <D2MXS5A9M8RF.Z7ACS9BB2NOC@gmail.com>
Subject: Re: [GSoC][PATCH v2] t: port helper/test-hashmap.c to
 unit-tests/t-hashmap.c
From: "Ghanshyam Thakkar" <shyamthakkar001@gmail.com>
To: <phillip.wood@dunelm.org.uk>, "Josh Steadmon" <steadmon@google.com>,
 <git@vger.kernel.org>, "Christian Couder" <christian.couder@gmail.com>,
 "Christian Couder" <chriscool@tuxfamily.org>, "Kaartic Sivaraam"
 <kaartic.sivaraam@gmail.com>
References: <20240628124149.43688-1-shyamthakkar001@gmail.com>
 <20240708161641.10335-2-shyamthakkar001@gmail.com>
 <mlnerj7j6knamzj3ipnd7rgqd6xm5xrjep35rldhv6sikzipu5@72szgbso6cpo>
 <2d7fd61d-0b2c-465f-9f24-47c99ab5b56c@gmail.com>
In-Reply-To: <2d7fd61d-0b2c-465f-9f24-47c99ab5b56c@gmail.com>

Phillip Wood <phillip.wood123@gmail.com> wrote:
> On 09/07/2024 20:34, Josh Steadmon wrote:
> > On 2024.07.08 21:45, Ghanshyam Thakkar wrote:
>
> >> +static void t_put(struct hashmap *map, int ignore_case)
> >> +{
> >> +	struct test_entry *entry;
> >> +	const char *key_val[][2] =3D { { "key1", "value1" },
> >> +				     { "key2", "value2" },
> >> +				     { "fooBarFrotz", "value3" } };
> >> +
> >> +	for (size_t i =3D 0; i < ARRAY_SIZE(key_val); i++) {
> >> +		entry =3D alloc_test_entry(ignore_case, key_val[i][0], key_val[i][1=
]);
> >> +		check(hashmap_put_entry(map, entry, ent) =3D=3D NULL);
> >> +	}
> >> +
> >> +	entry =3D alloc_test_entry(ignore_case, "foobarfrotz", "value4");
> >> +	entry =3D hashmap_put_entry(map, entry, ent);
> >> +	check(ignore_case ? entry !=3D NULL : entry =3D=3D NULL);
> >> +	free(entry);
> >> +
> >> +	check_int(map->tablesize, =3D=3D, 64);
> >> +	check_int(hashmap_get_size(map), =3D=3D,
> >> +		  ignore_case ? ARRAY_SIZE(key_val) : ARRAY_SIZE(key_val) + 1);
> >> +}
> >=20
> > Ahhh, so you're using the same function for both case-sensitive and
> > -insensitive tests. So I guess TEST_RUN isn't useful here after all.
> > Personally I'd still rather get rid of setup(), but I don't feel super
> > strongly about it.
>
> I'm not sure - we have to pass ignore_case to HASHMAP_INIT and the test
> function so using setup() means we cannot pass different values to the
> two different functions.
>
> For parameterized tests where we calling the same function with
> different inputs using a setup function allows us to
> - write more concise test code
> - easily change the setup of all the tests if the api changes in the
> future.
> - consistently free resources at the end of a test making it easier to
> write leak-free tests
> - assert pre- and post- conditions on all tests
>
> Using TEST_RUN is useful to declare the different inputs for each test.
> For example in the oid-array tests it allows us to write
>
> TEST_RUN("ordered enumeration") {
> const char *input[] =3D { "88", "44", "aa", "55" };
> const char *expected[] =3D { "44", "55", "88", "aa" };
>
> TEST_ENUMERATION(input, expected)
> }
>
> rather than declaring a bunch of variables up front a long way from
> where they are used.

Yeah, I changed my mind from removing setup(). I'll keep it as it does
not have anything complex to make manual verifying harder. Also, since
this test does not have any variable inputs, we can just use TEST(),
although TEST_RUN() with variable inputs is very useful in other tests.

> >> +static void t_add(struct hashmap *map, int ignore_case)
> >> +{
> >> +	struct test_entry *entry;
> >> +	const char *key_val[][3] =3D {
> >> +		{ "key1", "value1", "UNUSED" },
> >> +		{ ignore_case ? "Key1" : "key1", "value2", "UNUSED" },
> >> +		{ "fooBarFrotz", "value3", "UNUSED" },
> >> +		{ ignore_case ? "Foobarfrotz" : "fooBarFrotz", "value4", "UNUSED" }
> >> +	};
> >> +	const char *queries[] =3D { "key1",
> >> +				  ignore_case ? "Foobarfrotz" : "fooBarFrotz" };
> >> +
> >> +	for (size_t i =3D 0; i < ARRAY_SIZE(key_val); i++) {
> >> +		entry =3D alloc_test_entry(ignore_case, key_val[i][0], key_val[i][1=
]);
> >> +		hashmap_add(map, &entry->ent);
> >> +	}
> >> +
> >> +	for (size_t i =3D 0; i < ARRAY_SIZE(queries); i++) {
> >=20
> > Since we only have one query, can we remove the loop and simplify the
> > following block of code?
> >=20
> > Also (here and elsewhere), it might be less confusing to say "UNSEEN" /
> > "SEEN" instead of "UNUSED" / "USED". The latter makes it sound to me
> > like there's some API requirement to have a 3-item array that we don't
> > actually need, but in this case those fields are actually used in
> > key_val_contains() to track duplicates.
>
> The third element just needs to be a boolean flag so it might be better
> to use a struct
>
> const struct {
> char *key;
> char *val;
> char seen;
> } key_val[] =3D {
> { .key =3D "key1", .val =3D "value1" },
> { .key =3D ignore_case ? "Key1" : "key1" .val =3D "value2" }, { .key =3D
> "fooBarFrotz" .val =3D "value3" },
> { .key =3D ignore_case ? "Foobarfrotz" : "fooBarFrotz", .value =3D "value=
4"
> }
> };

I think we can just use an extra 'char seen[]' for markings and modify
key_val_contains() to have this parameter, instead of having it as a
struct.

Thanks.

