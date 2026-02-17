Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD95836165C
	for <git@vger.kernel.org>; Tue, 17 Feb 2026 13:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771335494; cv=pass; b=TfSmHN+RMK0AgKGTw0vnxXMIhFKIdQP0uc009xJ+yg71MUbq8mvaMYH9M5yYSZLXaQa+61F9ha1ISvVlBFIknQe8kaMDH14Ng4XAk/ajOcbnU4/X1vZOOc0fvZWB6KG6WX4cZhazPvbZmj1XcRjlR0bNjSQwOFkp8iTqi+/WAEs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771335494; c=relaxed/simple;
	bh=xkspfgeK3/jAwAuHYuIiSyR1VWERXpOKeuULo3rcrk8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R/6iRqYjoYZemc9ufMZs9AAkCN4W3Ya1XKX33KcRiC+LHfbGLzfOIoA4C2izgiNDQjUgrRJTsHj1nxszRrBpTn5X2Oksq6lgdcwlD7tMjrwxF8kysd/fJDjpIc2kcw/RMnioX059T9BtgyGli7fAa2WVDK9NFvZmTJ0+IUs/+JI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c5ewFg7v; arc=pass smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c5ewFg7v"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2aad1bb5058so42892975ad.0
        for <git@vger.kernel.org>; Tue, 17 Feb 2026 05:38:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771335492; cv=none;
        d=google.com; s=arc-20240605;
        b=UDam1/Xd0dMgh9st7eopsEFrEvB49TaVXOMsjwyOcHdcPQwt25xzuWka9kaI+h6uW3
         hEURH7wE/t5tASeWdT9VYEFFZ2lMrnAZMs+hVepO90/+c2xhdYb3D477H+7kVPUodHt6
         fz9l5Nv6bs4YwaPbYebtiFDROgmFLrClBGVIfjv7uJecMUiqiKjfLMalwlmGtUBQJYeR
         KolYZgXZvw1fInGmJNNVgYBxkdzI9ZqIfrVYIn1xMjlxtohNbzBnXFopPZzZQbH44hUF
         0Eo5HFDHONMieWP1nWnohM3kNaaM89DBRcnQtaIMUFDbyhn3K6o0qwHsJFYfi231aGD1
         0toQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xVZkd/bLNDvardjQ8lFsDLBpqer4p0z/ui0jryxtxwQ=;
        fh=2YeeSUv7gXwScooycw339hMSf+vxlvL1kO6L8z28WvY=;
        b=Zom/p/sclkraW0UQYs4X38iJ5S8vc+HlcNkbiYfHV7GN+FD5khcU0dam+8+aGqVGjf
         rustzV9Urr6yyWKXEZN96bQboXYNEnjujQ5ioCQpjdqVlgpRC2SydWzWXkjydZtoZFYE
         q2FvExTgDheLzD9i3ctlfk4Bdnu45ymoPW3rgVlTIaLo+qe3EHB3P3iWRDHaM8o6iCtp
         a+cWt58jv2vWQ60fouh2vuxDEfs1gW+Yn2ztv/EegwGxDnMNN5Gw5bGZjDRQJmJhQuV+
         k2kuAIme5slnJoA8u8BDNt3y470A+rnqLJ2gWyFTeSSs3n6ksD4gXChRUZR3OGc19irv
         xKew==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771335492; x=1771940292; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xVZkd/bLNDvardjQ8lFsDLBpqer4p0z/ui0jryxtxwQ=;
        b=c5ewFg7vPI4f4P/fb6rvn/QNeCXDG3VZjhmpM5eMX9iftRxttHc/a/JhlYzJIN2eQB
         sjyZiQ+8nHY47i0kfFVAMKODVJpYYLMMnFLOGJcTfOL5ayYq0x6lywUpmL7IWU3civ9F
         XDAy0+Dq+oAHuwwUQJRfC6/VrI4M3p3k/Fhcq+Bx1QRrhRSWDlTG2o3ginradqnUb8N/
         QrOB6ik6BnLcjzu+j0BU8kocYQTGf3Fuekcgy3cc0+EZAB4ctVixWPKPCJuuDw6y2xAf
         T/zf37uT6f3jlM8qQkxEH0g2wThkts1UP5PpzbyKgNtSLrpNpeV+gX2r5ZfZlGEtKtfN
         A6uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771335492; x=1771940292;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xVZkd/bLNDvardjQ8lFsDLBpqer4p0z/ui0jryxtxwQ=;
        b=KTP6tsOOdrfDWRWRsCn6NcYXJNtMwt5qsr2g+kz6Vc4Zdy7KDtyDEDgupJEFyfHV4q
         v3wpmc6KuPm/mAHrS8O5pdA5k/HdTTQsP/i+nHWwWJx6hkzPGBZgGGgUkl3vjEVczQ8g
         5MEVAsXZrcy7axYoEYW5Mz68N1spufZz8SSp588+ZHvZwxKI6fYyCkJfmRKIGIibWj2G
         z/utn9Wi0of3Oeyafn5x96i3VBWYV5FXBkvCjYU3fkScBpKMi8dv+r/Q4HpNQXxqasdI
         Rnwd2mOHPYybGg5D7b0ajkhGvt6l04pkyxtPt030Fa7uUSJyPU02ZekxjOn+gP5qUkZK
         7pIQ==
X-Gm-Message-State: AOJu0Yx9YFyzc5Io0lufXo2tqdVegcZeTvzfcA5bJuaEGX9b83hHdyut
	teO3QKp07QlRfZtKePVI3VUCMhj2FR++Ndm8AOLpSfpfbnL9yl6nwEv4BQUlukxARHTjyWiwuDG
	SK/p/uPGWBmucr4h/JvhiECc79mFKHsE=
X-Gm-Gg: AZuq6aKgts6gdLb6p3KksOn4l7BsHYDFu9s/wT+MhovOhSMzfK7HfwEfkOxfxi2wZE9
	D1sziY9AxBl9NZuG0EWWQHm0sBSIrMGK6P6Y566LurCWq9JAzLgqhIL1SaaBMiCyqDtke996MvL
	CFsB2zoC5pQFp03kRU2GFr+1AAM2A/zw2DbqTEj24xM+9LxXziqJjWdzSOLBUiDg39Pn2sbPRtp
	XX2/2NO/RP0BnXOw9woY4+qmi9hjSwN0x+CcsbAHxmHJmy6jRwi/P4b5Vb6C+B2FdkLiDFJ036f
	VPlO0ydD5RoDtu8yRlh9LEMfaPbZ3fzjQK425+l4A6qPTjCXbwzU18ClIfe8qfUfL3zECY353Rp
	CXuGd7kmvFKKP8Es/C0hp5m0BrA==
X-Received: by 2002:a17:903:2f8b:b0:2a9:48ce:b5f5 with SMTP id
 d9443c01a7336-2ab505d7914mr118388995ad.51.1771335492276; Tue, 17 Feb 2026
 05:38:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0a344f1f3ee4a5d95c6f46df030b9936db4354a1.1770853297.git.ben.knoble+github@gmail.com>
 <9cdcc9de04f0f8fff657f0474b31c063466ed808.1771280837.git.ben.knoble+github@gmail.com>
 <833b54f7-bb6b-4bb7-a5ec-fc0fa679abf8@gmail.com>
In-Reply-To: <833b54f7-bb6b-4bb7-a5ec-fc0fa679abf8@gmail.com>
From: "D. Ben Knoble" <ben.knoble+github@gmail.com>
Date: Tue, 17 Feb 2026 08:38:00 -0500
X-Gm-Features: AaiRm52LvKqRg0jy9bjGrfbMDk_OBlhBE8p41pb_kDqpzzl7-xXDLvyU-2NWFSA
Message-ID: <CALnO6CBqbJ3s6XO0s_bTagJxT0N8nseyJb1T-H7+B6qqWNKoUg@mail.gmail.com>
Subject: Re: [PATCH v4] meson: regenerate config-list.h when Documentation changes
To: phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>, Evan Martin <evan.martin@gmail.com>, 
	Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 17, 2026 at 4:20=E2=80=AFAM Phillip Wood <phillip.wood123@gmail=
.com> wrote:
> On 16/02/2026 22:28, D. Ben Knoble wrote:
> > +if test -n "$DEPFILE"
> > +then
> > +     for doc in "$SOURCE_DIR"/Documentation/*config.adoc \
> > +             "$SOURCE_DIR"/Documentation/config/*.adoc
> > +     do
> > +             printf "$OUTPUT: %s\n" "$(printf '%s\n' "$doc" | sed 's/[=
# ]/\\&/g')"\\
>
> This forks two processes for every file which is a bit inefficient and
> will be especially slow on windows.

Yeah. I couldn't find a way I trusted to behave in the presence of
strange characters, though=E2=80=A6

> If we quote $OUTPUT first we should
> be able to use a single sed process for all the files
>
>         QUOTED_OUTPUT=3D"$(printf '%s\n' "$OUTPUT"| sed 's|[/\]|\\&|g')"
>         printf '%s\n' "$SOURCE_DIR"/Documentation/*config.adoc \
>                 "$SOURCE_DIR"/Documentation/config/*.adoc |
>         sed -e 's/[# ]/\\&/g' -e "s/^/$QUOTED_OUTPUT: /" >"$DEPFILE"

=E2=80=A6and this version matches a concept I considered. Let me think alou=
d.

To quote output, we backslash-escape any "/" and "\"; we are going to
use it in the replacement side of sed's substitute command with "/"
delimiters.

My manual says "&" and "\[0-9]" are also special in the replacement
string. We have no backreferences for the latter, but my sed on macOS
complains about bad backreferences in cases like

    echo abc | sed 's/^/foo\1/'

OTOH, escaping backslashes already covers such backreferences. So I
think we'd need something closer to

    sed 's,[&/\],\\&,g'

? If you agree with that reasoning, I'll include this in the next
version. (I'll also try this out a bit first.)

PS in patterns with so many "vertical" characters, I find the commas a
bit easier to read than pipes :)
