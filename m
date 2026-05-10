Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB765196C7C
	for <git@vger.kernel.org>; Sun, 10 May 2026 22:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778452246; cv=pass; b=Fo4E96qKsLXPmTDjVOKC5HZK1SiYIyvWa/gOQIjJll0zs3XvSQa6Ptg+cjdLSAbX5ykYPtP1eTmIOwYx0KW/sM3JAEMloFRIG3HotFl5uFKArG1h0GSxxPg0bEZQIdL2hO8MJQg9S80DjJ3IoOaUMwWd9O4p4Qbllu3pkvcM3hY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778452246; c=relaxed/simple;
	bh=PqYzn8qEnoOrP6bwmeJ3iczPWHV3ZiZ1s5YTTDZPmRM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JWE8o4wIwB1CmN2/3NmtQI5ec4HUGK3G8n26XmcnxOdQ/ZowT2smdQ6m9WnLEKazW60J9m28Z33Ywi0cn/lg61jFROsJnQcGhnRsKK+gGz/W3hrdTwMUotD2O/jXk4QT3fhdCb45X88QRogiWYtwAUvZxz/gNQLaHW5piNI+DWI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=agiJX0y7; arc=pass smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="agiJX0y7"
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-39380e79936so47164081fa.2
        for <git@vger.kernel.org>; Sun, 10 May 2026 15:30:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778452243; cv=none;
        d=google.com; s=arc-20240605;
        b=YJg0a30gmqSfASBA2UOVvSYdZvMZNiTOdCOJqzSjljEYLhJvsgLxGa+yHg5Ij9P5w6
         RvOjd/e8TqamQljFsRS+bXoOHkn7tJm3yL0EtabKkqXg7gTzzq84hPiey/+F/Gk6ABkv
         x6Zhv9zlrEa0Tyl4PdQfRDrr8KpNnYD0GavFx3PNZAa/SlOCeIOEgQUffEdwtbQuZRD2
         G+b9zKsE5tL4ROnuTC2BRy3QkFB7AzUEIKmc2PbatRBOYc+gWo9HRpGSiKZzztwpLBtM
         lZOSr2hT2PHpL/qUHtex1pvsaYVqgJwueXLkfY6tWJZJW3+tTKOOtdthT5J9EdxL2c7t
         kNcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qptOMmbWoJQDGzjjxYbVIvVjob2ZVIsyD6U8baFzCOM=;
        fh=DOj4aov6QCZNHIut7J9bRSVLpYXeERrLPgwttad+t8s=;
        b=IoAR9sxt4/0hHmvZyDUrujVYMiJhovGnI1Y+11gjW6H5DsddNX9jRTk1cf010XLN8E
         r5g2U9oL/I/TLkVRQ3IzybxzwTLbRizynuAAcSN1/z7VE4UuXjk98Bqs7btiv064TG2E
         +L9QXjidLzyLuZxBKkLfmXMMKprKrMOb2A9XCMSvHEIsvpWfMZYKNvCU8GF9K0L2ftr9
         At14JQJHgY6BB7v8PMJo4sD6jb7X/TzZyAXlPK0LBf4kV2hGXFZkVQjF/60WXD5FCJhP
         oYVOGYXXP/G77aKBtjPwuaIREeDidw3ZkY958GmosNWo7NbPwnoCkv0GR2jQwdwggEn/
         TRCA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778452243; x=1779057043; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qptOMmbWoJQDGzjjxYbVIvVjob2ZVIsyD6U8baFzCOM=;
        b=agiJX0y7IzQsuWz60Y04JoZm/Il0FLMHjMvGEGNbuEvSqEVxo+AUxgsdzmQ6smSFPm
         YsnbYgVhRIkywWna16BvGEj+T5epwA+s5o8X4hBg6tfbMYJnxVBnJ/oXrw646njNBs1y
         XloNl+ap7tHJhmCxTzXtf/YqXkJ9O/mCP5J0eD7zEQqoSLEuc1rZZNHUPnW1oiGuNtUf
         A77KgxOJOjmYWzF8lFBKIF+hate3v4jOLuRVTjpmT39g+B+sDU0oQzHeZMsQ9z/taXPr
         D56Nxw3rRFvH0pdjHXtBkn3PfBqsHuw2+4PQ9bcazALMwD52yoyFAKmRTgbJNi1l7OFL
         mBfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778452243; x=1779057043;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qptOMmbWoJQDGzjjxYbVIvVjob2ZVIsyD6U8baFzCOM=;
        b=XKc04rxuz/B15DNV7uD2hgIsGl7s4+s5/6r95R9+sQ+0oMtVYUakGVX2JCbePkgAyc
         DY2xLsljzMyJYjx+eFLh1ZTC3uqfHIJCAtQ4QM/+t1pdTm4RV6Q3JMfns0H5u6bzQN7E
         joPTK9fI5IKLGKO3+sjZDKrg+6DAWB9Pew4gAaTKWRYQjp9tKBDH1AgfvBM3Vj21cvrl
         FUJVN2KbLlR3s2ssIqmJ4wyOubZmGejo7s0/Wd98knmV/+A8CabsiaIXn474hIINkkY4
         2xL0+EJLyx6wvafRqar/zXlJ+y2oIy4L2RTRkWx2iqhy8K7TiHgmnUhSrEfeQuhN5Mww
         r7Aw==
X-Gm-Message-State: AOJu0YzAEFUa+XbIvVeN+shxtXKmbn9ciEa6k3TUzcnnLdFUyEa9Wtgf
	8yoxrbNgnlPbnT4XUpxOsAEhftRNnuIWDneFO37vQrkfru/vdIWmuYjjFVBMLX0DUv4w68d03pb
	pkXaY8EUn0pqQdmyKv5vPtS/xcZCj3Ug=
X-Gm-Gg: Acq92OFO79nV5yCjQAB3XoMuHISR6chSGdbeB296zPu3xwY1Bto8ZL27aA5WrT+LWtR
	GIPbumdAj4EV56quEvU8e8KEN1yeDbwkJrLEsSy80AuFZlLSN6T3IvgRsuO9b9LXtjzu1rftVsh
	ybJ9rl38x2rQgzZmk4TQg5ZHOXej23zoI/I7wcSTrYx+AnAQzMAg6h6luaCZHzOAdcFIq7Uzsw0
	4Oql3Yd0I+xEbt7xU6Ixu+QXLppA+E/B3Nszctqs9fMzzEN5u+pHSrN9IL9pEcuukwM1tp05ZQP
	99KCAd0585kA5H+CABI+noNTgUXssbVjLnUPFfsT9ztn193/yH1r0xQRU/9gi0i27tIwtSL/C+z
	COqq/oL/QPtEGXwV51+fAY0xQrkyo0eDl8xiyT48GjCsUcpt1kn5h
X-Received: by 2002:a2e:b804:0:b0:386:fa6b:44e0 with SMTP id
 38308e7fff4ca-393c40ff2e3mr58322701fa.10.1778452242933; Sun, 10 May 2026
 15:30:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260507-document-log-no-follow-v1-1-46ce02490eba@gmail.com>
 <20260507-document-log-no-follow-v2-1-ee7bcbbe612f@gmail.com> <xmqqecjj9ckc.fsf@gitster.g>
In-Reply-To: <xmqqecjj9ckc.fsf@gitster.g>
From: Tamir Duberstein <tamird@gmail.com>
Date: Sun, 10 May 2026 18:30:06 -0400
X-Gm-Features: AVHnY4JNqHszcEns9C-prlFpjbldGe-fquTnpJgxVa_-pGHTYMpZjz9aC5sM7MY
Message-ID: <CAJ-ks9nb1pebMLqZ+GunkXLSMYRb_RmpDuBDrDsgJ+6m7nbzMg@mail.gmail.com>
Subject: Re: [PATCH v2] doc: git-log: clarify --follow options
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, =?UTF-8?Q?Jean=2DNo=C3=ABl_Avila?= <jn.avila@free.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 10, 2026 at 5:31=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Tamir Duberstein <tamird@gmail.com> writes:
>
> > Subject: Re: [PATCH v2] doc: git-log: clarify --follow options
>
> The second ':' feels quite funny.  I would have expected
>
>     doc: clarify "--follow" and log.follow for "git log"
>
> or something like that.
>
> > The --no-follow option was added by aebbcf5797 (diff: accept --no-follo=
w
> > option, 2012-09-21), but git-log(1) only documents the positive --follo=
w
> > form.
>
> OK.  Usually we document
>
>         --no-foo::
>         --foo::
>                 describe '--foo' and '--no-foo' here ...
>
> but we do not do so here, which is a good thng to fix.
>
> > Document --no-follow alongside --follow. While here, describe --follow
> > as limited to a single pathspec, rather than a single file, and mention
> > the override in the log.follow documentation.
>
> "Single file" is more accurate than "single pathspec", isn't it?

Yes, for the rename-following behavior.

The part that confused me is that `--follow` is not a no-op for a directory
pathspec. `git log --follow -- builtin` gives different output from `git lo=
g --
builtin`. But that is not because Git follows `builtin/` across the 81b50f3=
c
move to the old `builtin-*.c` paths.

The difference comes from the traversal mode. Setting `follow_renames` make=
s the
revision machinery run diffs and skip the usual pathspec pruning, because a
followed path may change. That can change which commits are shown for a
directory pathspec, especially merges. But the actual path rewrite in
`try_to_follow_renames()` only happens when a rename or copy destination ex=
actly
matches the single pathspec, so a directory pathspec is not rewritten to ea=
rlier
file names.

I will reroll to say that `--follow` follows a single file beyond renames, =
works
only with exactly one pathspec, and that directory pathspecs do not follow
directory renames even though they still use the same traversal mode and ca=
n
therefore show a different set of commits. I will also fix the subject and
option ordering as suggested.

> It is not like "git log --follow builtin" follows only changes to
> the paths for builtin commands across "builtin-foo.c ->
> builtin/foo.c" transition that happened at 81b50f3c (Move
> 'builtin-*' into a 'builtin/' subdirectory, 2010-02-22).
>
> And the way the machinery for this checkbox feature works is to notice
> when the file it was given disappears and then find the other file
> that the file we have been following came from, and start following
> that old file.
