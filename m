Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795320088;
	b=yLsxJLmqNlbLuSBBPZgsz8nU8ESuTLCwykK/t7yE8Wb05cgxuLD5fGKUtu9nG4eiZ0ES
	 K9QG2DSzaeeXw+fautPWapdFIXkZNc70HD54wXz7YwHJAvI31R48O32NsNw0Z6fobyvVU
	 9RqOhwt0gP0+o1E31x5FyaiKff4feckq9q8wFbkm09wVKGO0Tn7JzdX+wVSGZ2x0VxEtN
	 zPa3hiZzj7zz0hRv8FpFt6n94cYxS/7tJ0uxXQRdwDAWb32PMmqCqlxXMnHLeFB9GcDQa
	 Xasm91NyffvCCCeolQHprzLKbB21T+jpEDgKYwWiDkeFgrvPBQc2vx8q5y+XKCYAKDA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795320088;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=LydJ0W3IWYGy/i0Lo0mW44OJaXBL3YKVlzm84MRRu4Q=;
	b=SncZ+DaAYVGYSO9kuxQFH/f9CewlCpNSOqm8A7RPcXGen5IrJ1s7Z8gP4JeHIX6F1myx
	 wAfdEPRAzjUXWYgxRT998cp1Xk0uthSpRNrSQxB/yTLDF5wa44JBD24FVu5SvLIWpQDLx
	 WwiJWCZezGn/rJJ/zcl6oIyZ6MQde7kIrtORrx+DMSy5kxBX3uwu7cJ2lwN+NBnkrrgzP
	 XYG00Y0DWNEJKATygsK7a29MhyNhNER0WtbIDMBPQxhorQBlWI7WB6wqWmBe12ZKE8hlT
	 7nbd5OCurEvb0mXzSDevysTo9mPsJ3iJhWrkvXISCLh97+iwPEfMqt8CA3lEVXrz4kg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=korea.ac.kr;
	spf=pass smtp.mailfrom=korea.ac.kr;
	dkim=pass header.d=korea.ac.kr header.i=@korea.ac.kr header.a=rsa-sha256 header.s=google header.b=OaQ9CsOU;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.49
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C726D606A320
	for <git@vger.kernel.org>; Sun, 22 Nov 2026 04:01:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C726D606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=korea.ac.kr header.i=@korea.ac.kr header.a=rsa-sha256 header.s=google header.b=OaQ9CsOU
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-c4d28f75d62so374353166b.0
        for <git@vger.kernel.org>; Sat, 21 Nov 2026 20:01:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795320086; cv=none;
        d=google.com; s=arc-20260327;
        b=nhYjggbNyM/LBzOzPO9xENJcnDyjDarWqVyZXRSs8Z7+7wMJ9iYSHo7AWQAcc6prFX
         jiecH+65fLG26T3ZVVKdvV4TJlc6NuGGnBW5LBzNTEo7UJoJLlhJ32hGintk8P1blRbb
         WqyMhDnEPqbM9mm2dHyJSpkGyc0pAc1r/bg5HTCzt76HqqjIG6I/4XY0/h/Pgxm/s07k
         ZnsxfQuB2LERswJ//1TFjKrUDFRH/qYTx+f28qAvzZoeJPkKifQarCEq64ImoIdDs537
         mr3h7zjTIGjgZ9mCqFPPc6Ani1mX02tXOZ9ZmBGDkMxpBV4qJIbqRmJQP+WneAxs2xCP
         SI4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LydJ0W3IWYGy/i0Lo0mW44OJaXBL3YKVlzm84MRRu4Q=;
        fh=1/3dtt18tXnIvB8syWQ2wTvDn6umrk66dlnjmb+I9bo=;
        b=CC47a8h0JngmORh+dp8LiX70VuE1o4BivFvjf7aMBQMyHrls2JGgUusdvaOOljPiK+
         4+PrtzZWrtX6aH87xHfZUZVOYaBRcVJv0AGZHG4tM9f0OLzXPweEzcWYIc8mUGpGcNim
         6qUFnV3EOG012hC7in2RTT8dP7VSMVps1h/++JKYZZfJudlp68WMwx68jzdrCXMejDrf
         UlWMFhsZHvLWGcbIC4Mo+Xy/vmqw2Zd7ZSV8B/t1OXY8PGZSVnXy7IdzGGyqWBoHZMly
         pYUJv6R7tUaENXtahy4Eyr5voWHmHZablhX5En04u+d8uDnB9S2subEB6mxjowu0CCom
         U6BQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=korea.ac.kr; s=google; t=1795320086; x=1795924886; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LydJ0W3IWYGy/i0Lo0mW44OJaXBL3YKVlzm84MRRu4Q=;
        b=OaQ9CsOU1EQHUU3wNDt6wchJcM85fbLDoRjX1HsgxyWw7twbhV+cBW+LISXDQDgOjS
         XhkGFzA2xrSLvUKi5Z5uQWdhPIEQJ3BoMPbf7+HB2B7lXKjTUzqHA/lTCbjt1qRJmC8V
         RhfV6oK5eCP0qysNrOmsyZhW0ywqDDSN1R6WSmZ8LGwzMdqVsZKnKPwE2MIMWt2JTdoK
         UNRTKO7/1pRzOyXhhmmsWsUasVHMKhF9nRlRyPd6JebFvivA181L4S99pOgYCYtgYuCH
         9Zd77oKXJVIwCBTH2GRyVHcs31Fb1S0tjMcT3bujAB7/JWVQ+Tm1sgB2QJ1CsoT7XdiS
         UQxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795320086; x=1795924886;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LydJ0W3IWYGy/i0Lo0mW44OJaXBL3YKVlzm84MRRu4Q=;
        b=NNKDsl5UNjnkFlcsYRir6mGES0l0j5ZUWaICMOZjmQQLAnEw+p5+lN6xl6Jgx1Tdq1
         vgllaPUCQx5EtLzKNtgFeelG/FL8ox9wis3GkP4vayWQhj5FQ1cGhHAWGGhc6Z4mUGHb
         mU7f+LBCshNBte+kHGBvU3g7NxR6o7GpE3LC09UB4bh/DVhdHfJc4mO2cbxSR2HQVT17
         xvjC4HLbCiQE9kW/wAlFMZOm9b2Va4be1bbdWIdzP8thxFCaUK6JE8UDgCcit/yGmanz
         CtYBu1TOi/9UStWNt5d2J/MsrMQIMOWXgGcyl2TuhP3UsuqoEZZa45tpGjTkleqEufYL
         BQfg==
X-Gm-Message-State: APuU4Z/7Aw6VeIsq5zaopM3PRJI9rSIXpkeOmXH2t+ZdQEsxdqOfVw/U
	EA936NFcj/QL1ZxdaXUfr9GIUaGuddr9XHof6eO9jGQh7VTpUsLFj2eINmEUiepeUg+ffl1AIfv
	keo8RR7Xk6vEzotcLxjrF41Ca+kNIlF7fbIm6cpRMZpRQs49Kh9ldY28=
X-Gm-Gg: AZFdTZen+cwjFEj0cno9YLgeHuzc1TJe1n0QKzO2CuSoNHdwgeBIDw705lVN/1DzDsH
	3FK73jKrVucj6sV6418CsDpfrXiD/QXESGmh0ELxn0IXM0xyHLOlRj6AKRmLSK5jO58pBgEDhd+
	+0sNvhNiX/TxckhANJEgUfz82Lhr6JULiaGb9A1dEqoTTBM8zNqN8hMMkmiln3T5qZDsN1Ov9vP
	4IxS2jDPGm0Odv9lwMDLualAKSiD02WeR8lx19eQEDtt8BW7nvmqif3Bbb4Z10oqwTyXtUUmSoJ
	uS1r2JO/j7ljcoZU6IEgG8wa8NoDgskewdKkXYYf/4F1IoFeD3Iy4ESzjCI6h+sANxYys8DL7sK
	GagutjVo4B75OrzSKj1XGOg0cLnbH7jv/tYmVix29TpGOPkcWTYQGYiQaihoULPB4ihs5RaJB3h
	mwEfb5+GzMe0JRaA==
X-Received: by 2002:a17:906:9fd0:b0:c50:5a93:3bd7 with SMTP id
 a640c23a62f3a-c513a52b574mr591064466b.3.1795320086129; Sat, 21 Nov 2026
 20:01:26 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <pull.2323.git.1795246845186.gitgitgadget@gmail.com>
 <xmqqeccekl3l.fsf@gitster.g> <CAD2pp5sCB8kj6243g63X+Msg=cFR4ODYto5OUA3rYrnioVxShQ@mail.gmail.com>
In-Reply-To: <CAD2pp5sCB8kj6243g63X+Msg=cFR4ODYto5OUA3rYrnioVxShQ@mail.gmail.com>
From: Wonseok Oh <wonseok_oh@korea.ac.kr>
Date: Sun, 22 Nov 2026 13:01:15 +0900
X-Gm-Features: Aa3M54ppq9yZiGOtqv81OzA8xD0cMbgwBfwUNIbP-zzmi0ysTgvHuUXqs2v_gow
Message-ID: <CAD2pp5tBFNQdJyxvF6ZyywgCytrwVJCX0j+O6s47Fb-KYMkaGA@mail.gmail.com>
Subject: Re: [PATCH] fast-import: catch missing data after inline M at EOF
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

(Resending in plain text, as the list rejected my previous message for
its HTML part. Sorry for the duplicate.)

You're right.
After an inline "M" command, this loop should only exit after reading
a "data" command.
Any other command is already rejected by parse_data(),
but EOF just ends the loop and lets the uninitialized object ID go
into the tree.
So I think EOF should be rejected in the same way, by dying as soon as
read_next_command() returns EOF:

-    while (read_next_command(state) !=3D EOF) {
+    for (;;) {
         const char *v;
+        if (read_next_command(state) =3D=3D EOF)
+            die(_("expected 'data n' command, found end of input"));
         if (skip_prefix(command_buf.buf, "cat-blob ", &v))
             parse_cat_blob(state, v);
         else {
             parse_and_store_blob(&last_blob, &oid, 0);
             break;
         }
     }

This fixes both the original bug and the infinite loop you pointed out.
I picked the error message arbitrarily, so I'm happy to change it

Thank you.


2026=EB=85=84 11=EC=9B=94 22=EC=9D=BC (=EC=9D=BC) =EC=98=A4=ED=9B=84 12:46,=
 Wonseok Oh <wonseok_oh@korea.ac.kr>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> You're right.
> After an inline "M" command, this loop should only exit after reading a "=
data" command.
> Any other command is already rejected by parse_data(),
> but EOF just ends the loop and lets the uninitialized object ID go into t=
he tree.
> So I think EOF should be rejected in the same way, by dying as soon as re=
ad_next_command() returns EOF:
>
> -    while (read_next_command(state) !=3D EOF) {
> +    for (;;) {
>          const char *v;
> +        if (read_next_command(state) =3D=3D EOF)
> +            die(_("expected 'data n' command, found end of input"));
>          if (skip_prefix(command_buf.buf, "cat-blob ", &v))
>              parse_cat_blob(state, v);
>          else {
>              parse_and_store_blob(&last_blob, &oid, 0);
>              break;
>          }
>      }
>
> This fixes both the original bug and the infinite loop you pointed out.
> I picked the error message arbitrarily, so I'm happy to change it
>
> Thank you.
>
> 2026=EB=85=84 11=EC=9B=94 22=EC=9D=BC (=EC=9D=BC) =EC=98=A4=EC=A0=84 5:04=
, Junio C Hamano <gitster@pobox.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>>
>> "Wonseok Oh via GitGitGadget" <gitgitgadget@gmail.com> writes:
>>
>> > If `M <mode> inline <path>` appears at the end of input,
>> > file_change_m() exits its read loop on EOF without reading a `data`
>> > command. It then puts an uninitialized stack object ID into the tree
>> > and exits 0, leaving a tree entry for a missing blob that `git fsck`
>> > flags.
>> >
>> > note_change_n() avoids this by calling parse_and_store_blob() at EOF,
>> > which dies on the missing `data` command. Do the same in
>> > file_change_m(), and add a test.
>>
>> This reasoning seems wrong.  The reason note_change_n() can afford
>> to call parse_and_store_blob() is because it does not loop.  This
>> codepath needs a separate solution, I am afraid.
>>
>> > diff --git a/builtin/fast-import.c b/builtin/fast-import.c
>> > index ab5d2a2344..2b271222e1 100644
>> > --- a/builtin/fast-import.c
>> > +++ b/builtin/fast-import.c
>> > @@ -2456,8 +2456,9 @@ static void file_change_m(struct fast_import_sta=
te *state,
>> >               if (S_ISDIR(mode))
>> >                       die(_("directories cannot be specified 'inline':=
 %s"),
>> >                               command_buf.buf);
>> > -             while (read_next_command(state) !=3D EOF) {
>> > +             for (;;) {
>> >                       const char *v;
>> > +                     read_next_command(state);
>> >                       if (skip_prefix(command_buf.buf, "cat-blob ", &v=
))
>> >                               parse_cat_blob(state, v);
>> >                       else {
>>
>> Imagine that "cat-blob <object name>" appears on an incomplete line
>> without a trailing LF at the end of the stream.  The updated code
>> ignores the return value of read_next_command(), which would make us
>> loop forever here, I suspect.
>>
>>  * We are about to read the final line "cat-blob <object name>".
>>    read_next_command() calls strbuf_getline_lf(), which returns 0
>>    (which is assigned to stdin_eof), stuffs the incomplete line in
>>    command_buf.buf and returns.  We have "cat-blob <object name>"
>>    in the command_buf (without the terminating LF).
>>
>>  * We call skip_prefix() and call parse_cat_blob().  It does its
>>    thing, but does not do anything to affect this loop.
>>
>>  * The loop calls read_next_command() again.  strbuf_getline_lf() is
>>    called, because stdin_eof in read_next_command() is still 0.  It
>>    notices that the underlying stdin stream has already given EOF,
>>    and returns EOF.  read_next_command() reacts to this EOF, sets
>>    stdin_eof =3D EOF, and returns EOF.
>>
>>  * You updated the code to ignore this EOF.  In the meantime, nobody
>>    touched command_buf in the previous step.  We call skip_prefix()
>>    and call parse_cat_blob() with the same "cat-blob <object name>"
>>    that lacks the terminating newline.
>>
>>  * The loop calls read_next_command() again.  strbuf_getline_lf() is
>>    not even called and we get EOF back.  Again you ignore it and we
>>    do the parse_cat_blob() dance once again.  Nobody will get us out
>>    of this loop.
>>
>> In short, you have to pay attention to what read_next_command()
>> returns, even if that does not mean you have to leave the function
>> immediately, I think.
