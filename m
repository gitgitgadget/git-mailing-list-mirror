Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E49735C6B4
	for <git@vger.kernel.org>; Wed, 22 Jul 2026 20:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784753239; cv=none; b=b2XE7isCKZQHs7qzKvROWP29SAX3VyAXbWx8UrM01cr3M7Dd6kid7gwBoUQ+EBOrVPOUfkvD+fWL81KFqkdgdcvKpeyaZQOnQ5Tmumhf/yfgAnDIEmq4IbxpkcDgiqx6A/Bgrk9ZSVRBRX7N+O4WNv3W4DrFRxIhXed55QyROwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784753239; c=relaxed/simple;
	bh=e361Qv6hTPtwW7TYO9ALsqQ7E+SntY1vHpe+xYZ2wao=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=BYxkzoOOZ4xwsnhW1QgZFJ5TxLvMQcPN7obtel7JyitJm8/8BLfRVbxuPJFrnroQCSmoR52kPa2GyGsnJ5b+oCt05w03VwB3AF+7SoBWxzGtulCkqXCEGHmNrrudOH2MKTN/+lwxALS0jbq9EvIcht8eKHSqxgFDJ2eGnQD0lgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WR9QgYWd; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WR9QgYWd"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-47f3b39f2a1so7102879f8f.2
        for <git@vger.kernel.org>; Wed, 22 Jul 2026 13:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784753235; x=1785358035; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=pnIIjNbnwUbPpk4UlmkUIuyIgPSeqZ7RnQt9cf0XHds=;
        b=WR9QgYWdJR3WM7P1gR8jkmwHeQzfWXJeehMbmV95zHn5J4tvexUhnfS0kLynQ3Wisk
         DNWcQ4bTyg/sAbwjDn/RqMY59DijRjbj63pnam4uXFvJqvZLGJrI652CHi0IxLn1YVAC
         QYczKUOAWKSACzJBaD/jlioMAGs4Dgk9OzpfQocbnJav/FidQTBCrRqRuok3Qh/myC5t
         tpgMUeWJ897KTo65EZb8dxwfUQibfdDIE8KudCCsp6sRG+jFyN74ID+v080hvU25zRZT
         HiLtvqXAc0CDTAvUmwGrMXaSvLB6uVx2cYWjM9BYik1Yaod7I08F7msbmx14RQb5wb5q
         9HNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784753235; x=1785358035;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pnIIjNbnwUbPpk4UlmkUIuyIgPSeqZ7RnQt9cf0XHds=;
        b=iAw6/OVPr9FhIa4rHpGODvIP69l6y+qW3Af9uiBSUjUhbIMK2TKL/iuiwoPxI7mooc
         z6VKc7Y6H8tSIEwvgIVELtgrg4439I4tkGF6y9Gu0W/QXPbSNOZf6YF8jSt3ZSUrI6q0
         LI844w0hmbK6RSGHuXqP23T6I6XuC6a/gwss/8Qr1nmtosYW/BTCmVUQdZMamtRVVBAM
         29rhv3M/tGYXHbtu9+C/iK1CgCwumSL1XdB5wCR0iubexxRJjuzEU6fcOlXlaRmakABG
         bxlcLTOwMnLDKkFlB8wYVn6a3jkTmO7+Q3TJP4RFqIDlB6l4uyy3SYwEavRLcxzeGT53
         qHeg==
X-Forwarded-Encrypted: i=1; AHgh+Rru9PqrbV69l4MOwlJ0TYMS6QCaOe7jVDa8s7TAkrweMuceHdO1NpvQ9zUKlMJDR4bsMZk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUJdVdki4lrctobnHDJWv8/bvLUhG8zds2EXB5rsHVGPpo8h72
	7IREpVZOsX+rgWVmh3MEoNQnBEz9yzQo1+jHX7LdMafi1mN0sN0/fc59
X-Gm-Gg: AR+sD13619BoKDOR8aFifinhRkzYBFiY6kgSesrTSYWuZV6g3yiy0uD2GOxRr6ynkuB
	h1FVgInhJHBEaOZNMWS7dVY6H96/SC9MvazdXG8TRz5SREtpMeJ1AnAVurLCF5F6KcqMIe0kXLq
	muX/EJWlBg8WZOFsE6Rjz1pBDtHhc9G2IP18uzG+hAKFSWRY5tZnjWYHSsg239TEYsyagctBNJW
	iQVziHQuytRDFeS2BnR391TuNFn15RfXvyBPjHoevQ3o8+DZIhUGKVjT3Xq5G/wGQeI0LpMEytg
	ygV6RiKmOOJTKhiQtgOrOmJc/qiIFtiYYrR10nUyARosUY3hXKXWBqQOXLfyyKoH/ixwiVSscL1
	icp+QrmFZIs1sF/YVtaLAXCmd39oSsN+ELA5MHpaO1GacLGhXL4juSltdkkqQNaj02kaKY5Vo9C
	6geARxKxD5IIax6WUU5oWzR7+f5gIlSlr8dvgR67x7Dce0+D7Bo0mAJryE2gDS2aGMb3UtW/RLW
	HoJTbiaAufe1W9kPvDLoI05V6MXmHB3wg4lAe/A+MlTUkwCxDW4lT5pDieuhaumOTBxN0H/R4eJ
	ah4JAn3f6LLqj6scUhCgdMOTw90kmQIIUHllzdBZcyXZWvz1fr9t+Yrm
X-Received: by 2002:a05:6000:402a:b0:47f:4c9b:99b1 with SMTP id ffacd0b85a97d-47f8d754483mr448079f8f.32.1784753235301;
        Wed, 22 Jul 2026 13:47:15 -0700 (PDT)
Received: from localhost (82.159.183.80.static.user.ono.com. [82.159.183.80])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85bb81dcsm9073571f8f.12.2026.07.22.13.47.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jul 2026 13:47:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 22 Jul 2026 22:47:12 +0200
Message-Id: <DK5E7W7M0G8G.306LUAYVXFJ2N@gmail.com>
Cc: <chandrapratap3519@gmail.com>, <chriscool@tuxfamily.org>,
 <eric.peijian@gmail.com>, <gitster@pobox.com>, <jltobler@gmail.com>,
 <peff@peff.net>, <toon@iotcl.com>, <szeder.dev@gmail.com>
Subject: Re: [PATCH GSoC v20 00/13] cat-file: add remote-object-info to
 batch-command
From: "Pablo Sabater" <pabloosabaterr@gmail.com>
To: "Karthik Nayak" <karthik.188@gmail.com>, "Pablo Sabater"
 <pabloosabaterr@gmail.com>, <git@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <20260717-ps-eric-work-rebase-v19-0-d4faee35764b@gmail.com>
 <20260718-ps-eric-work-rebase-v20-0-0c13962ac532@gmail.com>
 <CAOLa=ZT77L39-jSZxgrvVFwdY6_rapBmKv8gCxr7QpdkCsEzXg@mail.gmail.com>
 <DK549LIZS8BS.3PL9CQQIR2LAA@gmail.com>
 <CAOLa=ZS8J4t12ab1=3-LRYNuZOwqSHG861iYm97JjF3mGprvJA@mail.gmail.com>
In-Reply-To: <CAOLa=ZS8J4t12ab1=3-LRYNuZOwqSHG861iYm97JjF3mGprvJA@mail.gmail.com>

On Wed Jul 22, 2026 at 6:13 PM CEST, Karthik Nayak wrote:
> "Pablo Sabater" <pabloosabaterr@gmail.com> writes:
>
>> On Tue Jul 21, 2026 at 10:12 PM CEST, Karthik Nayak wrote:
>>> Pablo Sabater <pabloosabaterr@gmail.com> writes:
>>>
>>> [snip]
>>>
>>>> Changes in v20:
>>>> - Moved the prep patch that fixes hash_algo's type to be before
>>>>   write_fetch_command_and_capabilities() being moved to 'connect.c'
>>>> - Reverted git-cat-file.adoc documentation comments about CAVEATS
>>>> - Fixed style for EXPAND_DATA_INIT
>>>> - Added more context for comman line die()
>>>>
>>>
>>> [snip]
>>>
>>>> Range-diff versus v19:

[snip]

>>>>
>>>>     @@ Documentation/git-cat-file.adoc: one per line, and print inform=
ation based on th
>>>>       You can specify the information shown for each object by using a=
 custom
>>>>       `<format>`. The `<format>` is copied literally to stdout for eac=
h
>>>>      @@ Documentation/git-cat-file.adoc: newline. The available atoms =
are:
>>>>     - 	reports).
>>>>     -
>>>>     - `objectsize:disk`::
>>>>     --	The size, in bytes, that the object takes up on disk. See the
>>>>     --	note about on-disk sizes in the `CAVEATS` section below.
>>>>     -+	The size, in bytes, that the object takes up on disk.
>>>>     -
>>>>       `deltabase`::
>>>>       	If the object is stored as a delta on-disk, this expands to the
>>>>       	full hex representation of the delta base object name.
>>>>      -	Otherwise, expands to the null OID (all zeroes). See `CAVEATS`
>>>>     --	below.
>>>>     -+	Otherwise, expands to the null OID (all zeroes).
>>>>     ++	Otherwise, expands to the null OID (all zeroes). See `CAVEATS` =
section
>>>>     + 	below.
>>>>
>>>
>>> This chagne is still unnecessary, no?
>>
>> I guess it is unnecessary. I added it because on top, at objectsize:disk
>> it says "`CAVEATS` section". So I tried to have it consistently.
>>
>> Is it worth a reroll?
>>
>
> No I don't think a re-roll is necessary. But something to avoid next
> time :)
>

[snip]

>>>
>>>> 13:  ebdfc22fb7 ! 13:  70a11d2aea cat-file: make remote-object-info al=
low-list adapt to the server
>>>>     @@ builtin/cat-file.c: struct expand_data {
>>>>       	 */
>>>>       	unsigned is_remote:1;
>>>>      -};
>>>>     +-
>>>>      -#define EXPAND_DATA_INIT  { .mode =3D S_IFINVALID, .type =3D OBJ=
_BAD }
>>>>
>>>>      -static const char *remote_object_info_atoms[] =3D {
>>>>      -	"objectname",
>>>>      -	"objectsize",
>>>>     ++	/*
>>>>     ++	 * List of atoms (i.e. "objectsize") that the server supports. =
Built
>>>>     ++	 * from the server's object-info advertised capabilities.
>>>>     ++	 */
>>>>      +	struct string_list remote_allowed_atoms;
>>>>       };
>>>>     -+#define EXPAND_DATA_INIT  { .mode =3D S_IFINVALID, .type =3D OBJ=
_BAD, \
>>>>     -+			    .remote_allowed_atoms =3D STRING_LIST_INIT_NODUP }
>>>>
>>>>     ++#define EXPAND_DATA_INIT  { .mode =3D S_IFINVALID, \
>>>>     ++			    .type =3D OBJ_BAD, \
>>>>     ++			    .remote_allowed_atoms =3D STRING_LIST_INIT_NODUP }
>>>>     ++
>>>
>>> I guess this is output of running the style check script (which I did
>>> recommend, but I should've mentioned that you should take it with a
>>> pinch of salt, it doesn't always provide the best solutions.)
>>
>> It comes in part from Junio's suggestion [1]. Although I don't think tha=
t
>> it will receive a lot of new fields, I thought that it would leave the
>> macro clean for that.
>>
>
> Then wouldn't something like this be better?
>
>      #define EXPAND_DATA_INIT  {  \
>              .mode =3D S_IFINVALID, \
>              .type =3D OBJ_BAD,     \
>              .remote_allowed_atoms =3D STRING_LIST_INIT_NODUP, \
>     }
>
> Note the difference:
> 1. The first line no longer has the '.mode' field, this would ensure
> that removal of the field is a diff which only contains the field and
> not movement of other fields to the top line.
> 2. Similar for the last time.
> 3. We also add a comma for the last field, this allows addition of new
> fields without modifying previous lines by adding a missing comma.
>
> I don't think this too warrants a re-roll, but this is something to
> definitely fix incase you do re-roll for other reasons :)

Yeah, this one is better formatted than what I did. Thanks for
the explanation. I'll definetely fix this two hunks if I have to reroll.

[snip]

Thanks,
Pablo
