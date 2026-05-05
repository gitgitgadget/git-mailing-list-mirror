Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62ECB2556E
	for <git@vger.kernel.org>; Tue,  5 May 2026 00:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777941274; cv=pass; b=SAX8GsdqOLmqw4pfbW9mYXorWkapFJz9b3efzpFpLxzPmXf/q/1M3dYqbrQJBSQrDNH9V+8qMSr+VK2syi3sUHY8gyc0CRioiGGdVaOz19NZq87fA/H77V9d+lOTamj128sq2qWEYdweLNgH2jn2xXiMBcZNJeluSqDhnIu6kPY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777941274; c=relaxed/simple;
	bh=BWdXlFolO7ccvtJ+p0GWKD0Z870VO0RFNanMrKjo7ME=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t6sd97pRcyL2udZkwCwuTKomxyJ9OqVCHWXhqP8DeIGsNvSUK0HZ25D0R8jaq7A5MBttPZGv5FxlB8ellXVsaWe2GscP+94BPDzc1rwghrQqSMe0IoYUN2BUwAXQMFxeq3GeaRDqkIL6J3d6ITo4w6E8JVD4TYWubqtZH5RhfTc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dtAyQjfP; arc=pass smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dtAyQjfP"
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-39389398838so20566581fa.3
        for <git@vger.kernel.org>; Mon, 04 May 2026 17:34:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777941270; cv=none;
        d=google.com; s=arc-20240605;
        b=czKyM0jeD+pv/OkRKLNrsWj02KbqoWnGTAatSZvz1Ldsy8+rwKNREDqDjJEfIf07fB
         ijvDhaFHKLxS4oCTsjN3+VjR+NHrFgbPhPQ2ehT38yODlhyQNNrnw5H1rpUWWdmBChU1
         JfJRRipX/VRBN/IBIUVf4E6oK1cFzRGUdUFdIQ+xRLoqPTaynpEz92hH0WBSyREVVWsc
         XGMsliF0CNivM27rTWUUyXivPodJPcgeYbij061t3KR3LVPRDqYLFxHIK0g3n6y4B+Cu
         PlhrxHIN02veTOM7UUzYfj8iVSeMt5AjeQF99V32OO6iAuQ3DUGjBCV5C+mrk9mq/U9v
         ogpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BWdXlFolO7ccvtJ+p0GWKD0Z870VO0RFNanMrKjo7ME=;
        fh=TvJNO+rJreHiIe/P9PBSp2UjZQ18Q+mmajMR58IAADk=;
        b=Rj6G1utFnonox0kAJdzDSDaRcyLKbXY000CgxY88w9mCe8omTehRZL7z8RdIMFH/UG
         BVYOnQDELAY+kRZPK7wFnyphB7bLR7TqQqBsLYYAFbVKzlcyYFV7YTcoLw8uBNsy3YBM
         GM48vVL6Ns1Ej7HZzWCuXj/lMvSYOkcVaP3pgK/haVLMD0RWJuxflP4/t+3ejvf4abrp
         KM/icndMX+Z9AyLyoW7dqnKUoCm5SIZpe/7KACLr6SZYlntjTt1NSb14SNxJD1N+BK9+
         hVBVkKsVClqSt9J1RWN3KeP0+Dy0Iz7cq6KssH0eOqLMfICk4OC2D1+jWSBAObz7WgeF
         cgsQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777941270; x=1778546070; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BWdXlFolO7ccvtJ+p0GWKD0Z870VO0RFNanMrKjo7ME=;
        b=dtAyQjfPMQF0i9ex51u9LFJdKvNkqB3WCxzvwusvDR3Tp2eo2Cz6qBkFRHF9NFJQ1M
         xq1YxqZlnUJ9xMtY5dBAsZKguWeWW+a2TyOv0HGGCecmuQMLB2GR6ALqYIo0eDOwJuts
         TJTrA0g4gkZPpH26zBzSJL67+ZCO6D3NhMREFIWbfNVObguuaRHHcKgExMqcgK2qDoCi
         4ws63bLWLWp1xz8ovfCzEahYnj3TICI3uYMam9ki3W72qA7EyotzybHGJZeDwjiAK6vX
         K1YfGnHjtz3XmcxWgm5d+D12EQ31F6XbUxhHtjIZ89cE1Hqtp6fOmZ/VC5mgWBhxjh4+
         M7vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777941270; x=1778546070;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BWdXlFolO7ccvtJ+p0GWKD0Z870VO0RFNanMrKjo7ME=;
        b=sBxuJbl6CnMKwvclySkQDFFZbZgel3XmiQkcsrGcSHGxN60cp+XmJMfHHYT/wtrgRE
         pQ5uhhrpKM7Qlx1W6Y1mszJuLsVEZwCnKEbzdlGY5eQWUAcFbNiZfMIc0WEMTdbEUyVD
         be3feIBoHD1+8BdVSnudcWecjVz2Q5PmHq97jWPZXw4R/TX+7X/BCXvUydYO7VI8fOxd
         Rm0mZhK7TNt4O7Zr8Cm5FUx48FkCyQ3DIIlP/DDkEz08amd/ea9fuWto+jlViNDP1IoH
         bNhkNQN7RiQnrOP8XJ1EtxVyCTxhP0Nbq34IW6AtcInW7BaIjzN4a/hLcT7NXsukBnbW
         IN3g==
X-Gm-Message-State: AOJu0YyZOXzyOxHWD/MbkUnNztoQSCskV3q4OMyUxXao238Sb3zCihhg
	PxRKmqIwl5gPNgJOoGiDj9/n7zPr8rtrKV68ukBM7TPPIXeIj6B1BjcbTgbNmDILELl4wE81qwU
	u8cG9vJNOGZVoSCdgfrR8Bq02pLfoyrCP7Mfn8lw=
X-Gm-Gg: AeBDiesXkbMEoQW94OrZrGK+5jo1qioWg7E0btoPekb8lyAtHJPoexcEMNFemEprZ+l
	XG3FMeefGy7OT0MnwR1I4T14BtmrGkWtQJU3fYVVyj4DT12nT1Aa3R6/2L4frZxqltBc1b/8jo2
	1Xz+lgpDzyFbUQyYKFL2DHdCTsrIaj4bMQDI4mq+G5cQNLnrOmNy9uOraoyFXGDl3HwlWm50jU7
	BdaEWaSvE+IduV+VUdEwZp1ce9VDlNH1t2ZejWFsFGgTdqP2mqstAS+bTqGChRWcQr7B+HylK1z
	KdU7MDkEGSVnolTHW+s=
X-Received: by 2002:a2e:8a88:0:b0:38f:e999:6a5a with SMTP id
 38308e7fff4ca-39378417850mr32111261fa.11.1777941270304; Mon, 04 May 2026
 17:34:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2d3f5504-f5dd-4171-96e8-b5633b6a1f5e@app.fastmail.com>
In-Reply-To: <2d3f5504-f5dd-4171-96e8-b5633b6a1f5e@app.fastmail.com>
From: Chris Torek <chris.torek@gmail.com>
Date: Mon, 4 May 2026 17:34:18 -0700
X-Gm-Features: AVHnY4I0U99X9clTxLfSnRYAL1Wawq1XqB83hJOEAxzaZg3fBhRJHRfwcMldPcQ
Message-ID: <CAPx1Gvf5Vts3oS2BdFQ4PpCR-UY=5cYW7fgOkRuQpi8ug2JXDg@mail.gmail.com>
Subject: Re: Git trims the last character of content from remotes
To: Hugo Osvaldo Barrera <hugo@whynothugo.nl>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 4, 2026 at 10:02=E2=80=AFAM Hugo Osvaldo Barrera <hugo@whynothu=
go.nl> wrote:
[snippage]
> When the width of a whole line is the same as my terminal width ...
[snippage]
> ... sideband.c prints ANSI_SUFFIX =3D "\033[K", this escape
> sequence being "clear the line from the current position until the end of=
 the
> line", and this is the root cause of the issue.

Interesting.

In Ye Olden Dayes of (n)curses, there was (and still is) a terminal
capacity boolean flag, "xn" or (in terminfo which is more verbose)
"xenl", the "terminal eats newline glitch".

Consider your bog-standard 80x24 "glass tty" from the late 1970s /
early 1980s. Printing a line of exactly 80 characters caused the
cursor to march from column 1, to 2, to 3, ..., to 80, to ... column
81? There is no column 81. So what is this "glass tty" to do?

Some acted like a print head, leaving the cursor stuck in column 80,
so that printing *more* characters just made that big black blob of
ink on the paper er I mean erased each previous character with the new
one printed on top. So then a final "new line" sequence left the
cursor on column 1 of the next line, which is where we want it.

Some thought this was annoying and/or stupid so they immediately
wrapped to column 1 of the next line, as if the computer had sent a
newline sequence. But if the line was in fact exactly 80 characters,
this meant the subsequent newline sequence moved to column 1 of the
*next* row, leaving a blank line (or scrolling the screen twice or
whatever). This is Obviously Bad Behavior, but the "overprint" answer
is equally Obviously Bad.

There were two ways of dealing with the problem intelligently: put the
cursor to an internal "column 81" that, if there's a newline, sends
the cursor to column 1 of the next row; or simply set a flag and eat
the next character if it's a newline. (This is a little trickier than
it sounds since the newline sequence is actually CR+LF, or LF+CR,
depending on certain computer-maker choices, but it works either way.)

The xn / xenl flag describes terminals that behave this way. The
screen-oriented programs (ex/vi, now vim and emacs and nano and so on,
plus things like "more"/"less"/other pagers, etc) would know to send
an extra newline here if the xn/xenl flag is true, and not if not
since the cursor was already on column 1 of the next line
automatically. (Though actually this depends on another boolean, "am",
auto-right-margin. Lacking "am", the cursor simply hammers on the
final column, the overprint Bad Behavior Mode.)

Alas, this does not describe what happens if one sends the "clear to
end of line" sequence. If the cursor is in the phantom "column 81",
perhaps that sequence does nothing. If it's lingering in column 80,
perhaps that clears the character under the cursor. All that xn tells
you is "send a newline anyway".

As for what to do, well, that could be tricky. Git *could* check for
"am" and "xn" / "xenl", but that requires parsing termcap/terminfo,
which is kind of a nightmare. It also requires counting cursor column
movements, which is something of a mug's game.[1] If you're willing to
play that game though, you could just count and, if at the last column
as determined by "tty column width" inquiry, omit the ESC [ K
entirely: there's nothing to clear. If you have a non-empty prefix
string before this "clear to end of line" suffix, the solution is more
obvious: print the ESC [ K as a *prefix* rather than a suffix, but
that fails with the empty prefix.

One last easy possibility is to print an extra space before the ESC [
K. It's imperfect, as it causes a blank line for these exact-width
lines, but avoids data loss.

Chris

[1]: https://www.merriam-webster.com/dictionary/mug%27s%20game
