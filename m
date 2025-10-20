Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F0BD2E0B69
	for <git@vger.kernel.org>; Mon, 20 Oct 2025 08:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760948102; cv=none; b=Ee0brsyxHR+sTAc8w8mfnyDo7REdal7ZmmAB9KyCLuQtnLYlIn7p/ygiO8SBjVmroNEHnuxmq88pVK//+SpPnGXR7y0oKbGTx3PObgUFIZxnkYniknc6tkw+z+hMkoVgwUdNfpVgrvSVxbGEKxJzqpPLf75/CRVixHAwfxxfhlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760948102; c=relaxed/simple;
	bh=maupxKEq5D1NYZeXxsc8oSwCFi73jfR1Ecli53AzX6o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F9SVQUrsWLqiWDJupUQrTWituvS7ORquOThuyojMjmmBfKJzWs5S4tAlZgI5gJvyDt2D6y+gJfmUl+2mfkaEaiASlS4+OsqNUDXt063ypKYn/PZBdqPS7Zp8HJ8pY0YTfCts4MxikwGChVd5gO7hay1JusGe2NZXqSfTVvv4UFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ANTakZC4; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ANTakZC4"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b679450ecb6so2997112a12.2
        for <git@vger.kernel.org>; Mon, 20 Oct 2025 01:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760948100; x=1761552900; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4XE/r4N72LhYAIrx+9e8CIhHixTXwTDBdQaDzYZY7wM=;
        b=ANTakZC4htTj7jWhRWSx3t9v/P2Y1DnEM8iYbncZI9BcDmD250iBNMAgIrRJMRMw/Z
         ugMKSHMvByivBxyMW0xsOb4h9Nn6bERaoXa1frZ8YatzWB5Qa2UcB9Kc2KdE8Nar7UaM
         Uz9ej7fMF9xgAswdRhPtq1vHWyngsz5hNQuVdxh6LFGvhu1q0IgUAUWFDS9/c6iKB5la
         gKmgcAejCr1sdQPkrtKjyqaumSWb/tlngf/O12z65CQJI2poduLho7C45iNCKuIPqt01
         bI2Cqht4tkEj9tXLLTeRMJxF/tB+eTPrIXNQCMOnpzot2TZkPYdxuUOydB30qARdVAJT
         PKag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760948100; x=1761552900;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4XE/r4N72LhYAIrx+9e8CIhHixTXwTDBdQaDzYZY7wM=;
        b=a2eqzooYdJRUb6F7nqDQL0m9wDCQsjaXgt7f48GasCDHrIPblTB36BqKmQcOTLl9ir
         w6x4imL+C5VlnKl01/8XaOXFeSpijJxhuINg11L+fDqZnlUFxzGVnk1D4Drrr1NtxRhY
         G9XEziT68jHR/dNgbGqYl9yhXq2+/rH13o7RYF1VNa4Sz3YK+PXgQvddDZ3JX78j8ELk
         /wChxyUs1Ozv2PKIkIw8zx9ROwCxpAPTPhJAY0CCF6nw1iMaba0ndd0/THUD33bfvmuz
         C/Sf8KPKYfpeEy6vR7HgTn6WT3hECE8g2woVoBOmE9O/r65QSds4XwgEXJFsfplv2NKq
         op0g==
X-Gm-Message-State: AOJu0YweZRC8P3BkxoYbL7FU28tgRZHU86/sp7ZNJTbVGHuhYMZ9cvf4
	2+OrI7fC/cnKk2hJQsvkvOZHOruwOIFBbEO/dd+CET655TonaneKGx3/MiPZfmEIAxrQ0dcpVga
	4D6Dl1xlmDIDhgJYessHpaAL0gtRRjPw=
X-Gm-Gg: ASbGncsdLcqFLu4L6UO2WPiIIUYQRyUiHsdwGUDPJgbtuM3+3CC4djZklS1hczRij/V
	zQcY4uc7U2REzsgl0QMZmgZ0fbj55Sm8dF2LJilSV1e1FV3dC+V0C6Gkg5VAvkXXsnO+FSqwVDc
	0IUGoIpG8fgSl+GYjh4GjnbIE3qsFFdLrAekfeTYpJEQKap7KwGr+RThUqLsX3plUVqX+AqDGnE
	CKmNM0VNqxwhSMTYzv2e35rfF8MLdtDZUexX3b2RIRljkhQr04SDMsAylYMPUTviQ==
X-Google-Smtp-Source: AGHT+IGoASog+amNQvYtuVJ7Cvap9KS4c2L5SK8G9Jhy9YAHZyENeIY5CF8cvRykO09GNfDQMucX1ZA0YXfARcm8x+c=
X-Received: by 2002:a17:902:f551:b0:290:dc5d:c0d0 with SMTP id
 d9443c01a7336-290dc5dc3d6mr158979495ad.49.1760948099576; Mon, 20 Oct 2025
 01:14:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1760869186.git.belkid98@gmail.com> <9a6eb6ff8b92a94de990303cc78026029a669cf8.1760869186.git.belkid98@gmail.com>
 <xmqqikga3mqj.fsf@gitster.g>
In-Reply-To: <xmqqikga3mqj.fsf@gitster.g>
From: Bello Olamide <belkid98@gmail.com>
Date: Mon, 20 Oct 2025 09:15:00 +0100
X-Gm-Features: AS18NWAfo28hMfXVWrSX3SsyLHxVbkcNn_ESa_pQYnfI6_YO6fRQh8ktZQJejmA
Message-ID: <CAD=f0L9Bu2xcOt98n_iB6Td2+pdniOP-wU_KyigJdt+3Oy3wxw@mail.gmail.com>
Subject: Re: [Outreachy PATCH v3 2/2] gpg-interface: use string_list_split*()
 instead of strbuf_split*()
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, usmanakinyemi202@gmail.com, 
	christian.couder@gmail.com
Content-Type: text/plain; charset="UTF-8"

On Sun, 19 Oct 2025 at 17:00, Junio C Hamano <gitster@pobox.com> wrote:
>
> Olamide Caleb Bello <belkid98@gmail.com> writes:
>
> > In get_default_ssh_signing_key(), the default ssh signing key is
> > retrieved in `key_stdout`, which is then split using
> > strbuf_split_max() into two tokens
> >
> > The string in `key_stdout` is then split using strbuf_split_max() into
> > two tokens at a new line and the first token is returned as a `char *`
> > and not a strbuf.
> > This makes the function lack the use of strbuf API as no edits are
> > performed on the split tokens.
> >
> > Replace strbuf_split_max() with string_list_split_in_place() for
> > simplicity
> >
> > Note that strbuf_split_max() uses `2` to indicate the number of tokens
> > to extract from the string, while string_list_split_in_place() uses `1`
> > to specify the number of times the split will be done on the string,
> > so 1 gives 2 tokens as it is in the original instance.
> >
> > string_list_split_in_place() returns the number of substrings added to the
> > list keys.items, so we check that at least one substring is added to the
> > list since we just want to return the first substring.
> >
> > Signed-off-by: Olamide Caleb Bello <belkid98@gmail.com>
> > Reported-by: Junio Hamano <gister@pobox.com>
> > Helped-by: Christian Couder <christian.couder@gmail.com>
> > ---
> >  gpg-interface.c | 10 +++++-----
> >  1 file changed, 5 insertions(+), 5 deletions(-)
>
> Exactly the same comment as [1/2] (including the part about the
> first paragraph seemingly missing something at the end ;-).
>
> Also, it may not be necessary to highlight the quirky way the
> string_list_split*() function counts numbers again, as it is done in
> the previous patch so readers have already been warned against it.

Okay noted.
>
> And the same comment applies about the round-about way the original
> was written in the first place.  Isn't it merely the matter of
> finding the first line-feed and making a copy of a string up to that
> point?

Yes that is the goal.
>
> Perhaps we would be better off if we revise the theme of the topic
> "use string_list_split*() to replace strbuf_split*()" to "do not use
> misdesigned strbuf_split*() function" and do the rewrite without
> using string_list_split*() after all?  It may result in a much
> cleaner and simpler code at the end.

Okay something like this?
       char *begin;
       char *end;
       char *new_line, *line_end, first_line;
       size_t line_len;

       if (!ret) {
         ...
       begin = key_stdout.buf;
       end = key_stdout.len;
       new_line = memchr(begin, '\n', key_stdout.len)
       line_end = new_line ? new_line : end;
       if (line_end > begin && *(line_end - 1) == '\r')
            line_end--;
       line_len = (size_t)(line_end - begin)
       if (line_len > 0) {
       firstline = xmemdupz(begin, line_len)
       }
       default_key = first_line
       ...
       return default_key

I am just asking to know if something like this
should be done within the respective functions or I will need
to write functions for each and just call here.

Thanks
Bello
