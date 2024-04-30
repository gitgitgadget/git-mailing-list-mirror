Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66912134BE
	for <git@vger.kernel.org>; Tue, 30 Apr 2024 04:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714452955; cv=none; b=CfDwkQj7BujYe4eEwhjOp0d8705oz9mBBEFmP7lV0d46oGHKTcngpEkIq84n14NEv7u/2WOzhgZMTarLMDv3pj1RuVfVJB5pfU2IWs3EJkaRjA4SoSrJWczCn0LJ4kknZjXgOZK8I+tge0eejY+J1Ej2dAnyrRBBEwVnyOfjzO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714452955; c=relaxed/simple;
	bh=wNqsEVjh2cSMtVxVusxuS9smEXjvE8uNRR2HD9jK0QU=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jtaupfF25yKA63uHaS8GM51HH/wpTwJTRWxH+JU12y3sPVyuG1pE0u6otSN7z02TxoXT8OW4TQaXvWHgBr7OJS5edXKFVNRAP1eoa5xaNRgXgF1vRYFRiuTToOPDQwUmmod9d9CVboRk8KxUTRI+avIYTqL/h64lWEVvq1H0khU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ucla.edu; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail-com.20230601.gappssmtp.com header.i=@gmail-com.20230601.gappssmtp.com header.b=BFKxddXv; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ucla.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail-com.20230601.gappssmtp.com header.i=@gmail-com.20230601.gappssmtp.com header.b="BFKxddXv"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2a2d0ca3c92so3711482a91.0
        for <git@vger.kernel.org>; Mon, 29 Apr 2024 21:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail-com.20230601.gappssmtp.com; s=20230601; t=1714452954; x=1715057754; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date
         :mime-version:references:in-reply-to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fZzp2/nOG7vUA5QgRwEUVgHkEhKryHv2dnaDl/9QPX0=;
        b=BFKxddXvjbXJG1qIjgj1jqlfRp1DuuucHeEh/E67OYEvrvBI0nd5ICWQRUcMAv3oD+
         dA3h9SEwdfjc+9kK+mKijQIwFP5yz2ouWlYtsct0zxSZ54LWoHEUYzQ7hHPyzat51JgQ
         xt2Iy/0rWpUYkzoYhtcNd7nK98appePghbuMYsd+pDFHxZCzD8vS6Rz/53Qd+XwWYPqT
         o7gz9HN23O5gYQyveXoHsAzj4z+F86vZjyrP0SSxfJ2qgn8LHVaE5wlnzgdxoKYhSfpr
         OBgttFWDsbAI4Zo66WKXXh1KQnNfAPDGi85Expe67kOkfeZafAInbPsNwd4DXvtb+06S
         3TnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714452954; x=1715057754;
        h=content-transfer-encoding:cc:to:subject:message-id:date
         :mime-version:references:in-reply-to:from:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fZzp2/nOG7vUA5QgRwEUVgHkEhKryHv2dnaDl/9QPX0=;
        b=ubKMtVhQ7kuxWjkWZBwsn7tubiJVhG/sGU4HQ/2f5q06NyUvgW3VW5F6ccSZhwQeef
         5qi82lPm802JHJGUq4Rqe39eEEvd17oGq2+b+YjZzS9a5Bf+3kyfIZ4V6w+d1KwBIE/D
         kuyTsoALKcUXGPCEOpQht0tde7rbrbtqiG5YOPAixADb0462JW1hGphLxqupObUDVek/
         91oaxyPV/mpOyAcR4RvsSga7HeB4tuC+3JuBkZsKMD1fSUBkwRKRC039XFtIvkp6hYRz
         fhvOFURdBJShDmJJpukxduLh0KTdabAGEVvoTjmtOmOujBECSLdVPjm0/0W/ehNbkOaT
         Apkg==
X-Gm-Message-State: AOJu0YxonYFbBejxxvwYUZuPiLV3foy15tME0RXcynXu7+8VmA5ubCCI
	daHoQ/+Zh7RMhJ2Vw9VXC/XgiKPVurA8Hs5wWdlvEoeUnlb+rVHLNVaxzWNo49H1jvGqwbrlMMQ
	YqR/cUm63twMjpQTVRd25gkpafE8=
X-Google-Smtp-Source: AGHT+IEZv5kMJkstdJp+PqaUgH1b2sFLuTEbE2OdMJyWG89nUeRDYapbdP2g3eSHQcWAg5B95tzNmNT7/qd5182YyrY=
X-Received: by 2002:a17:90a:4384:b0:2b2:9783:d0ca with SMTP id
 r4-20020a17090a438400b002b29783d0camr777980pjg.12.1714452953567; Mon, 29 Apr
 2024 21:55:53 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 29 Apr 2024 21:55:53 -0700
From: Linus Arver <linus@ucla.edu>
In-Reply-To: <CAMo6p=EggYjK60fWmNC2XRFf0zRf4PCcUT-vmFM6RH2J0i3hrw@mail.gmail.com>
References: <pull.1696.v2.git.1713504153.gitgitgadget@gmail.com>
 <pull.1696.v3.git.1714091170.gitgitgadget@gmail.com> <9077d5a315d0d7272266856bf75a75b0a24df91d.1714091170.git.gitgitgadget@gmail.com>
 <CAP8UFD0OATdCaEN1SrvYMTZP3b1uWCZw57cXHhUNPW9eTj+x0Q@mail.gmail.com> <CAMo6p=EggYjK60fWmNC2XRFf0zRf4PCcUT-vmFM6RH2J0i3hrw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 29 Apr 2024 21:55:53 -0700
Message-ID: <CAMo6p=GRcmy6NDGRskuNrauMYTkAgk_p_0TJJTPC2=axVrWuvQ@mail.gmail.com>
Subject: Re: [PATCH v3 03/10] trailer: teach iterator about non-trailer lines
To: Christian Couder <christian.couder@gmail.com>, 
	Linus Arver via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>, 
	Junio C Hamano <gitster@pobox.com>, Emily Shaffer <nasamuffin@google.com>, 
	Josh Steadmon <steadmon@google.com>, "Randall S. Becker" <rsbecker@nexbridge.com>, 
	Kristoffer Haugsbakk <code@khaugsbakk.name>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Linus Arver <linus@ucla.edu> writes:

> Christian Couder <christian.couder@gmail.com> writes:
>
>> (Sorry I just realized that I had sent this email to Linus only.)
>>
>> On Fri, Apr 26, 2024 at 2:26=E2=80=AFAM Linus Arver via GitGitGadget
>> <gitgitgadget@gmail.com> wrote:
>>>
>>> From: Linus Arver <linusa@google.com>
>>>
>>> Previously the iterator did not iterate over non-trailer lines. This wa=
s
>>> somewhat unfortunate, because trailer blocks could have non-trailer
>>> lines in them since 146245063e (trailer: allow non-trailers in trailer
>>> block, 2016-10-21), which was before the iterator was created in
>>> f0939a0eb1 (trailer: add interface for iterating over commit trailers,
>>> 2020-09-27).
>>>
>>> So if trailer API users wanted to iterate over all lines in a trailer
>>> block (including non-trailer lines), they could not use the iterator an=
d
>>> were forced to use the lower-level trailer_info struct directly (which
>>> provides a raw string array that includes all lines in the trailer
>>> block).
>>>
>>> Change the iterator's behavior so that we also iterate over non-trailer
>>> lines, instead of skipping over them. The new "raw" member of the
>>> iterator allows API users to access previously inaccessible non-trailer
>>> lines. Reword the variable "trailer" to just "line" because this
>>> variable can now hold both trailer lines _and_ non-trailer lines.
>>>
>>> The new "raw" member is important because anyone currently not using th=
e
>>> iterator is using trailer_info's raw string array directly to access
>>> lines to check what the combined key + value looks like. If we didn't
>>> provide a "raw" member here, iterator users would have to re-construct
>>> the unparsed line by concatenating the key and value back together agai=
n
>>> --- which places an undue burden for iterator users.
>>>
>>> The next commit demonstrates the use of the iterator in sequencer.c as =
an
>>> example of where "raw" will be useful, so that it can start using the
>>> iterator.
>>>
>>> For the existing use of the iterator in builtin/shortlog.c, we don't
>>> have to change the code there because that code does
>>>
>>>     trailer_iterator_init(&iter, body);
>>>     while (trailer_iterator_advance(&iter)) {
>>>         const char *value =3D iter.val.buf;
>>>
>>>         if (!string_list_has_string(&log->trailers, iter.key.buf))
>>>             continue;
>>>
>>>         ...
>>>
>>> and the
>>>
>>>         if (!string_list_has_string(&log->trailers, iter.key.buf))
>>>
>>> condition already skips over non-trailer lines (iter.key.buf is empty
>>> for non-trailer lines, making the comparison still work even with this
>>> commit).
>>>
>>> Rename "num_expected_trailers" to "num_expected_objects" in
>>> t/unit-tests/t-trailer.c because the items we iterate over now include
>>> non-trailer lines.
>>
>> I think it would be simpler if the previous patch used just
>> "num_expected" or "expected". It's not like the other fields in the
>> struct ("msg" and "name") are very explicit, so why this one only?
>
> I didn't give it much thought TBH. "num_expected" SGTM. Will update.

Another thing: I will rename "trailer_assertions" in Path 10 to probably
"trailer_contents" because it sounds simpler. I am replying here instead
of on Patch 10 because my mail setup still has some rough edges for the
transition away from @google.com (I no longer work there).

And on that note, I'll have to update the SOB lines to match my new
email address.
