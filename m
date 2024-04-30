Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08E0279DE
	for <git@vger.kernel.org>; Tue, 30 Apr 2024 04:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714452141; cv=none; b=CZtzE0SYyQKwGy99vsA0Bit6UmbJqDWmk3Zl1gfwggme3XBvoCErIsGCO29TzkrQPfPiiGAh8WFcFDFy+MYcd3cyojo0WcvD53sTqEW6ZngFw66FQdS3fZd9Ws/SNXEPPWVFJn+PugvGwreZf8dXNoePmmHnkvmvTly/mv9LfqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714452141; c=relaxed/simple;
	bh=H5mNJaH5Jn5819dOO+ue5ZwFKrTCOzHYQrN7CAwzltU=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fmePRAdKqgWftcE4Druwt8LGXvxurbT8varmXetrlbxsP1zg0eBEEgDhn1DOb/yKhnACHRp7EOgoqLlGBHP+IMLSyFlLyTeAf6hyTCI07BzbgDU9J1URdSQuIa3IQ40ajwCM0gGyFWtm6D9I+Uw4TtkHsug7McHRA38A04FCILI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ucla.edu; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail-com.20230601.gappssmtp.com header.i=@gmail-com.20230601.gappssmtp.com header.b=N8e2VM5T; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ucla.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail-com.20230601.gappssmtp.com header.i=@gmail-com.20230601.gappssmtp.com header.b="N8e2VM5T"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1e651a9f3ffso25815375ad.1
        for <git@vger.kernel.org>; Mon, 29 Apr 2024 21:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail-com.20230601.gappssmtp.com; s=20230601; t=1714452139; x=1715056939; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date
         :mime-version:references:in-reply-to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JexrEgE9d4a3UHLV5wR4asSENRi0JKIuZDj7u48708w=;
        b=N8e2VM5T9x5IqPWAvVVP0ULQSoEYvZR2jpGE7vNjtxCMMUqlf5bxceBGTbhiy1CPGH
         XjmZj/QLbOBxEYyqOGExFSrcCjS7x09zV+KEb41kn+Hs50rIaqioal1x6onnnACdjEUB
         RglcomBtO5eNiT+bQRlK2oHd6c6/SuU9PPKCbfopZ5SoQ9EIE/oH3f86hCBr5/923foo
         uLJhnH08+cgo7xz3kMDhjhU66MP2r5yII4HlSLxWHvdrarPNqsK2qTA3gzkusct/Os/n
         onEzTV4KR5G0Tp6GENvPKqfcGbdqQgGJLyoTtf9V1dEay5/VYkkP1/QR8Cp9w7Rcrq5k
         s0XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714452139; x=1715056939;
        h=content-transfer-encoding:cc:to:subject:message-id:date
         :mime-version:references:in-reply-to:from:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JexrEgE9d4a3UHLV5wR4asSENRi0JKIuZDj7u48708w=;
        b=q5T4mQ80l6IRrlJc8SbEchs3x4StBYkzwlnz0LxLZe2LsbSaYrFm5A+qtS9viav2A3
         +8WhRyu02uyib8f+KXaMyLmJyH52X9UeYFTdsKfAHUx7QEETOJloqhLpozv+8/fkcENz
         zzItDCJpUjgehWDrOyqkr2b/PpveTkHDKxpprx5MoclvdhmS08CycPvDs4xt1wqtBOtg
         pSVVR+O8f9SvW16vt24cuLVzAbxoN8w9/OC6GPnB1StVBZihE9/BdcJFSol4f1PHdnWO
         Vn3/wlSUxknLse3dKmZC7Ev36ppA5AsxwJ/leceu1gt/mM06vT8OuVyraxLAIgVqfT0W
         izIA==
X-Gm-Message-State: AOJu0YwYkmDHXxlrsLEecs0Fxec6WYPKuxL8fZlXft5IxZtly0LXoy1H
	TcWat4vZB/1i8JscPVqlSwMM6jqrav2jQUVe6Wu8CaVGKEyOmAMUBCw4LKGB2IgIc4UTbDQ3CWF
	Q+Y5BQQLEcZwxyQPFRgwjHtUeKWY=
X-Google-Smtp-Source: AGHT+IH6O9wxQwaFgD/7s75nLSS6bANUVRWP3+hvjv8K5YDhbsC4zDm2LoC4INWrcn5p4a0ZyQ1lnDZNdWQ6IBTgg2k=
X-Received: by 2002:a17:902:eb81:b0:1eb:bc78:1ef5 with SMTP id
 q1-20020a170902eb8100b001ebbc781ef5mr6252940plg.17.1714452139065; Mon, 29 Apr
 2024 21:42:19 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 30 Apr 2024 00:42:18 -0400
From: Linus Arver <linus@ucla.edu>
In-Reply-To: <CAP8UFD0OATdCaEN1SrvYMTZP3b1uWCZw57cXHhUNPW9eTj+x0Q@mail.gmail.com>
References: <pull.1696.v2.git.1713504153.gitgitgadget@gmail.com>
 <pull.1696.v3.git.1714091170.gitgitgadget@gmail.com> <9077d5a315d0d7272266856bf75a75b0a24df91d.1714091170.git.gitgitgadget@gmail.com>
 <CAP8UFD0OATdCaEN1SrvYMTZP3b1uWCZw57cXHhUNPW9eTj+x0Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 30 Apr 2024 00:42:18 -0400
Message-ID: <CAMo6p=EggYjK60fWmNC2XRFf0zRf4PCcUT-vmFM6RH2J0i3hrw@mail.gmail.com>
Subject: Re: [PATCH v3 03/10] trailer: teach iterator about non-trailer lines
To: Christian Couder <christian.couder@gmail.com>, 
	Linus Arver via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>, 
	Junio C Hamano <gitster@pobox.com>, Emily Shaffer <nasamuffin@google.com>, 
	Josh Steadmon <steadmon@google.com>, "Randall S. Becker" <rsbecker@nexbridge.com>, 
	Kristoffer Haugsbakk <code@khaugsbakk.name>, Linus Arver <linusa@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Christian Couder <christian.couder@gmail.com> writes:

> (Sorry I just realized that I had sent this email to Linus only.)
>
> On Fri, Apr 26, 2024 at 2:26=E2=80=AFAM Linus Arver via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>>
>> From: Linus Arver <linusa@google.com>
>>
>> Previously the iterator did not iterate over non-trailer lines. This was
>> somewhat unfortunate, because trailer blocks could have non-trailer
>> lines in them since 146245063e (trailer: allow non-trailers in trailer
>> block, 2016-10-21), which was before the iterator was created in
>> f0939a0eb1 (trailer: add interface for iterating over commit trailers,
>> 2020-09-27).
>>
>> So if trailer API users wanted to iterate over all lines in a trailer
>> block (including non-trailer lines), they could not use the iterator and
>> were forced to use the lower-level trailer_info struct directly (which
>> provides a raw string array that includes all lines in the trailer
>> block).
>>
>> Change the iterator's behavior so that we also iterate over non-trailer
>> lines, instead of skipping over them. The new "raw" member of the
>> iterator allows API users to access previously inaccessible non-trailer
>> lines. Reword the variable "trailer" to just "line" because this
>> variable can now hold both trailer lines _and_ non-trailer lines.
>>
>> The new "raw" member is important because anyone currently not using the
>> iterator is using trailer_info's raw string array directly to access
>> lines to check what the combined key + value looks like. If we didn't
>> provide a "raw" member here, iterator users would have to re-construct
>> the unparsed line by concatenating the key and value back together again
>> --- which places an undue burden for iterator users.
>>
>> The next commit demonstrates the use of the iterator in sequencer.c as a=
n
>> example of where "raw" will be useful, so that it can start using the
>> iterator.
>>
>> For the existing use of the iterator in builtin/shortlog.c, we don't
>> have to change the code there because that code does
>>
>>     trailer_iterator_init(&iter, body);
>>     while (trailer_iterator_advance(&iter)) {
>>         const char *value =3D iter.val.buf;
>>
>>         if (!string_list_has_string(&log->trailers, iter.key.buf))
>>             continue;
>>
>>         ...
>>
>> and the
>>
>>         if (!string_list_has_string(&log->trailers, iter.key.buf))
>>
>> condition already skips over non-trailer lines (iter.key.buf is empty
>> for non-trailer lines, making the comparison still work even with this
>> commit).
>>
>> Rename "num_expected_trailers" to "num_expected_objects" in
>> t/unit-tests/t-trailer.c because the items we iterate over now include
>> non-trailer lines.
>
> I think it would be simpler if the previous patch used just
> "num_expected" or "expected". It's not like the other fields in the
> struct ("msg" and "name") are very explicit, so why this one only?

I didn't give it much thought TBH. "num_expected" SGTM. Will update.

>> Signed-off-by: Linus Arver <linusa@google.com>
>
>
>> diff --git a/trailer.c b/trailer.c
>> index 3e4dab9c065..4700c441442 100644
>> --- a/trailer.c
>> +++ b/trailer.c
>> @@ -1146,17 +1146,15 @@ void trailer_iterator_init(struct trailer_iterat=
or *iter, const char *msg)
>>
>>  int trailer_iterator_advance(struct trailer_iterator *iter)
>>  {
>> -       while (iter->internal.cur < iter->internal.info.trailer_nr) {
>> -               char *trailer =3D iter->internal.info.trailers[iter->int=
ernal.cur++];
>> -               int separator_pos =3D find_separator(trailer, separators=
);
>> -
>> -               if (separator_pos < 1)
>> -                       continue; /* not a real trailer */
>> +       if (iter->internal.cur < iter->internal.info.trailer_nr) {
>> +               char *line =3D iter->internal.info.trailers[iter->intern=
al.cur++];
>> +               int separator_pos =3D find_separator(line, separators);
>>
>> +               iter->raw =3D line;
>>                 strbuf_reset(&iter->key);
>>                 strbuf_reset(&iter->val);
>>                 parse_trailer(&iter->key, &iter->val, NULL,
>> -                             trailer, separator_pos);
>> +                             line, separator_pos);
>>                 /* Always unfold values during iteration. */
>>                 unfold_value(&iter->val);
>>                 return 1;
>> diff --git a/trailer.h b/trailer.h
>> index 9f42aa75994..ebafa3657e4 100644
>> --- a/trailer.h
>> +++ b/trailer.h
>> @@ -125,6 +125,14 @@ void format_trailers_from_commit(const struct proce=
ss_trailer_options *,
>>   *   trailer_iterator_release(&iter);
>>   */
>>  struct trailer_iterator {
>> +       /*
>> +        * Raw line (e.g., "foo: bar baz") before being parsed as a trai=
ler
>> +        * key/val pair as part of a trailer block. A trailer block can =
be
>> +        * either 100% trailer lines, or mixed in with non-trailer lines=
 (in
>> +        * which case at least 25% must be trailer lines).
>
> I don't think 25% is important here.

SG, will remove 25% language (FWIW we already have such language in
trailer.c if devs want to take a more closer look, so it's not like
we're losing any info overall).

> What is more important is to just
> say that this field could not be an actual trailer, and to tell what
> the 'key' and 'val' fields below will contain then.

Will update.

>
>> +        */
>> +       const char *raw;
>> +
>>         struct strbuf key;
>>         struct strbuf val;


BTW I will be on vacation for the next several weeks. However as the
suggested changes are minor, I think I can still get to them and push up
a v4 sometime this week. Cheers.
