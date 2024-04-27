Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D627E1E515
	for <git@vger.kernel.org>; Sat, 27 Apr 2024 12:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714222237; cv=none; b=fQx3H5LLZlrBIon8QHMEi5/HXw9ZRXdBz7pXIC4HDI0hwhp2J8UxZnl2ZCVGJAB6e/9cy5niQNUsq6nMJgfZJ2h+Vy+U1mZTR3N9/0gRS9EziY4+qruP/PhXFeglwpLbtb9/FKwM4yX9AXDmiEgWbupuJCZaI+Two9886NWd/2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714222237; c=relaxed/simple;
	bh=2lvLeGBiIOGWf2ohlueH5SaAxfoyl8eh1ClbqRpiBqw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n0koNXxaBJzTMghNBhhH3gQJbX5Fog+gxM3cMTzk0tZShZAZRnA+cs5MBHeJqYIn0MMG9Ab6OSiF25a3y23Zj8ccD9GPkOaVB6Vk28CMJICqvRQOcPL9hYsmf9TjTyqZE1aMnOdqBm2Hq39x9zCBo/TdQ7vceLykpbBjcmNi0+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kHB2qIKs; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kHB2qIKs"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-56e47843cc7so3017314a12.0
        for <git@vger.kernel.org>; Sat, 27 Apr 2024 05:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714222234; x=1714827034; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fZQmWPJXpepAwAfL+zLRbuCbh+1tRCU0Kwm/f9VYrjM=;
        b=kHB2qIKsdy3i3NlGzVmS2PCGXnDOrUrLotueLpZKY5sAy9in96aOsTT93Vl7TzHhvN
         0NFui/ntn9B7fH4/jOIP8Nw5qakwwGvoLyrK7j211kxMIBm/cMPnrhQYXPLodNwBvSJN
         1x0qt/iapl7oP14rVAlcb7dcUGqm3v8lxtdsxfpQOg+wTOpWwO+CsLVkU/UjelLRMN/y
         fYxGH60tg2CM587i0BWDQdBcGsm9yIsD49L2DgD/KW7FrnrCJ9ZPIkBB9yzQgkXhOQT+
         T0f4LMQH5y2RBeISM6vAK6ucV9AAOwllzfabV1vg4M2wkAkGz4x/DQxNRzBNWhgkRw47
         3GzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714222234; x=1714827034;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fZQmWPJXpepAwAfL+zLRbuCbh+1tRCU0Kwm/f9VYrjM=;
        b=sJGe74NigvVyQ1CO99e2LDHRxg4B1SFGuTaQm1WJcKnaqVevxqhZBH1q9BCsbHajLr
         891CK6Zif5yUvo9o5oOOGGoSlTpAvbogDIKUBuSOjSUQ2xqVw6edkwg0N/kOf0wvYe2m
         uh9Iz2kqO0sQiQl4dSvlxjfuVWHNlqwkj7tG9Vr5E2Yw/mGCrmru9ayP7l8LbnbuMuZu
         Regj0v/yRmHk3w9ZL5SsdZYH571snWvnyLPnO6Uq16BsccGNeR58TS1XidE7RL2K3/tS
         nUGvzU1hPLcvhI/6m+si5yDZ6+ko6IPNuXko94CqcPSNc6cjkEj4nVy/QY37aE08v/N7
         weng==
X-Gm-Message-State: AOJu0Ywu4Ne2mzfwfnT91WOnIiQObG7BQUVpVvbsdSwquc+ODBWrrXIu
	pB0DsgAYnwj6oE3m4NoZC7dNNbCnbmpTphSxmSCVtKXrt4EkT0mcXdH3HTi/kayjv/rOi2oA0c8
	QD8lAlJE5jMH9oYTo9iEWvQPot4s=
X-Google-Smtp-Source: AGHT+IHfXUfl8p0ifQOKlRGMTp7YdlZ/jR4VOAg43hK/TxGFXhf43fY0are4KiJcuMztsfFi0WWgeQjLYvHaSBHvAn4=
X-Received: by 2002:a05:6402:1cb8:b0:572:5310:4ae1 with SMTP id
 cz24-20020a0564021cb800b0057253104ae1mr2804112edb.0.1714222233773; Sat, 27
 Apr 2024 05:50:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1696.v2.git.1713504153.gitgitgadget@gmail.com>
 <pull.1696.v3.git.1714091170.gitgitgadget@gmail.com> <9077d5a315d0d7272266856bf75a75b0a24df91d.1714091170.git.gitgitgadget@gmail.com>
In-Reply-To: <9077d5a315d0d7272266856bf75a75b0a24df91d.1714091170.git.gitgitgadget@gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Sat, 27 Apr 2024 14:50:21 +0200
Message-ID: <CAP8UFD0OATdCaEN1SrvYMTZP3b1uWCZw57cXHhUNPW9eTj+x0Q@mail.gmail.com>
Subject: Re: [PATCH v3 03/10] trailer: teach iterator about non-trailer lines
To: Linus Arver via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>, 
	Junio C Hamano <gitster@pobox.com>, Emily Shaffer <nasamuffin@google.com>, 
	Josh Steadmon <steadmon@google.com>, "Randall S. Becker" <rsbecker@nexbridge.com>, 
	Kristoffer Haugsbakk <code@khaugsbakk.name>, Linus Arver <linus@ucla.edu>, Linus Arver <linusa@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

(Sorry I just realized that I had sent this email to Linus only.)

On Fri, Apr 26, 2024 at 2:26=E2=80=AFAM Linus Arver via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Linus Arver <linusa@google.com>
>
> Previously the iterator did not iterate over non-trailer lines. This was
> somewhat unfortunate, because trailer blocks could have non-trailer
> lines in them since 146245063e (trailer: allow non-trailers in trailer
> block, 2016-10-21), which was before the iterator was created in
> f0939a0eb1 (trailer: add interface for iterating over commit trailers,
> 2020-09-27).
>
> So if trailer API users wanted to iterate over all lines in a trailer
> block (including non-trailer lines), they could not use the iterator and
> were forced to use the lower-level trailer_info struct directly (which
> provides a raw string array that includes all lines in the trailer
> block).
>
> Change the iterator's behavior so that we also iterate over non-trailer
> lines, instead of skipping over them. The new "raw" member of the
> iterator allows API users to access previously inaccessible non-trailer
> lines. Reword the variable "trailer" to just "line" because this
> variable can now hold both trailer lines _and_ non-trailer lines.
>
> The new "raw" member is important because anyone currently not using the
> iterator is using trailer_info's raw string array directly to access
> lines to check what the combined key + value looks like. If we didn't
> provide a "raw" member here, iterator users would have to re-construct
> the unparsed line by concatenating the key and value back together again
> --- which places an undue burden for iterator users.
>
> The next commit demonstrates the use of the iterator in sequencer.c as an
> example of where "raw" will be useful, so that it can start using the
> iterator.
>
> For the existing use of the iterator in builtin/shortlog.c, we don't
> have to change the code there because that code does
>
>     trailer_iterator_init(&iter, body);
>     while (trailer_iterator_advance(&iter)) {
>         const char *value =3D iter.val.buf;
>
>         if (!string_list_has_string(&log->trailers, iter.key.buf))
>             continue;
>
>         ...
>
> and the
>
>         if (!string_list_has_string(&log->trailers, iter.key.buf))
>
> condition already skips over non-trailer lines (iter.key.buf is empty
> for non-trailer lines, making the comparison still work even with this
> commit).
>
> Rename "num_expected_trailers" to "num_expected_objects" in
> t/unit-tests/t-trailer.c because the items we iterate over now include
> non-trailer lines.

I think it would be simpler if the previous patch used just
"num_expected" or "expected". It's not like the other fields in the
struct ("msg" and "name") are very explicit, so why this one only?

> Signed-off-by: Linus Arver <linusa@google.com>


> diff --git a/trailer.c b/trailer.c
> index 3e4dab9c065..4700c441442 100644
> --- a/trailer.c
> +++ b/trailer.c
> @@ -1146,17 +1146,15 @@ void trailer_iterator_init(struct trailer_iterato=
r *iter, const char *msg)
>
>  int trailer_iterator_advance(struct trailer_iterator *iter)
>  {
> -       while (iter->internal.cur < iter->internal.info.trailer_nr) {
> -               char *trailer =3D iter->internal.info.trailers[iter->inte=
rnal.cur++];
> -               int separator_pos =3D find_separator(trailer, separators)=
;
> -
> -               if (separator_pos < 1)
> -                       continue; /* not a real trailer */
> +       if (iter->internal.cur < iter->internal.info.trailer_nr) {
> +               char *line =3D iter->internal.info.trailers[iter->interna=
l.cur++];
> +               int separator_pos =3D find_separator(line, separators);
>
> +               iter->raw =3D line;
>                 strbuf_reset(&iter->key);
>                 strbuf_reset(&iter->val);
>                 parse_trailer(&iter->key, &iter->val, NULL,
> -                             trailer, separator_pos);
> +                             line, separator_pos);
>                 /* Always unfold values during iteration. */
>                 unfold_value(&iter->val);
>                 return 1;
> diff --git a/trailer.h b/trailer.h
> index 9f42aa75994..ebafa3657e4 100644
> --- a/trailer.h
> +++ b/trailer.h
> @@ -125,6 +125,14 @@ void format_trailers_from_commit(const struct proces=
s_trailer_options *,
>   *   trailer_iterator_release(&iter);
>   */
>  struct trailer_iterator {
> +       /*
> +        * Raw line (e.g., "foo: bar baz") before being parsed as a trail=
er
> +        * key/val pair as part of a trailer block. A trailer block can b=
e
> +        * either 100% trailer lines, or mixed in with non-trailer lines =
(in
> +        * which case at least 25% must be trailer lines).

I don't think 25% is important here. What is more important is to just
say that this field could not be an actual trailer, and to tell what
the 'key' and 'val' fields below will contain then.


> +        */
> +       const char *raw;
> +
>         struct strbuf key;
>         struct strbuf val;
