Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B84D944D6BD
	for <git@vger.kernel.org>; Mon, 11 May 2026 19:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778527432; cv=pass; b=uelaUyCdimuCnrgFveKM+HH1vjvcA0d7uIc6Q+zFiuS31yjcZm42rHYPD2hzuGHZx+tVvKaxATwQnZ4JRDZhsr4v1W2NXqXLAtzP1jawx3IR83AXbcoTXmcMlwdr5RMdOmdzEqk3e09NIgqZxxvbk36FjcX9eJAgi8f5JU+YQIg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778527432; c=relaxed/simple;
	bh=awLlJNqToWAj4cXi2ayKiiC+RVNzuuy5Dvk9BMoqV6Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gQ35QsS0133kGzKnVY7oxd0zPb7pMupOM9xh+Xno1MVbjO+MIiEUxKuzFJzBhdWcFga7cRTb+q0uLyMqzv+5gM5NXFrPo71i7Boxco7fnITC2gUlHDtFhFT9OqChU9ZF4qziTJ2A4hmXOItFK58pPYRlx92Law22zftMvIPcF1o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nWCQH/Qb; arc=pass smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nWCQH/Qb"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2bc85eda6b6so10208405ad.1
        for <git@vger.kernel.org>; Mon, 11 May 2026 12:23:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778527430; cv=none;
        d=google.com; s=arc-20240605;
        b=XixnecF471GM4XrX7dWElgnqFTid3TNa9yzVpdzkBAfSE98X6crMbd2CMnLII1XXGn
         OMTIFMm/kz1pTnWyOrN0H547hdcCf6UXN3fGHzMB6pmwvqSjrR7TGtOPSgQ636OU/9Vy
         PtmDugPhMb9jYYA53dt+7DcQGczkAADJ82rVC2efDOlLCjlQ97GCyj4wseTnIwkC1OXT
         BhmWCSq+oO0vEygszE5gEdiVTbg5/fVFEqVPa4r04ORgXCA9Azli+U3qWj0Ez5vpr4Dg
         FEWliyO/HC3eABeScfeGc/KVD3imS5QnPzHCCWZdwoFgCFUiVq4hWkbUnkvEt0sTrlE2
         mZAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ypU4MXH9po9wdSH08L3xace3F4PLV76C+/o+1iRruW8=;
        fh=E9EUIk6HzAqBusaJAZmGeq23PjJ5viedv66RQNilrn0=;
        b=MTxaBgA6N3VXuJGFdUwf5m1mmawPZtig2IJzjG7Nd865EsBjemUMpxGwrTR9VAbHvn
         lzb6VWJfRuCEV88OCFYn+ZN3ugDorPPwjZxD0gt9VEvRulgoG4v6duD7fpQGaqRY91gz
         DpFEQxRJJyqLZUSjKcTlsjwC2CPefkwpFh2dX/xNw4p1hmHOtVD3J1lUc7+bd+jSEsrL
         XITMYN0lAN2gJqtECCqZxjsfjg1JOhp/1lG+I9SL1DqkVBMlkzCF3zD4jGpA4qgWw/Ip
         fOd7X4LI2y9+zpEV739a6GpS0MOHFeKK2qdkCoQnyJzAzqUqR6kfyIh44m7c2zn4ueNQ
         V5NQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778527430; x=1779132230; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ypU4MXH9po9wdSH08L3xace3F4PLV76C+/o+1iRruW8=;
        b=nWCQH/Qb1iq9gZBn+bVITtQceRsFTR1j2Lt5ETx40+SU1Ed7VTwY3T/Fx1t/EEzTdP
         dqpl9N9vMeRgRfqAPXsUFJKkTViJPaIownpLn6KX1Ln325cCJp0IVkWlEx6PK+kjRTtu
         xE1HcAxi8De5TSRPKBSTJtE4wG4c/yLBW+oYmwVfgInv/hQNZHQRoR9gWixD+6Q8hapW
         R2+vx9OlOf46pgcIFiNAhpQoRZpHR3sVI2eCtu+TiKgG/S3mxvBv46DYXJjEBGS2Qqgy
         fABoBNM9/3Tam4TmHRfqzGxNPuN+72SzF6yMlemi1/llrg+UoFb45QTuDso1PW9Zj/IC
         C6/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778527430; x=1779132230;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ypU4MXH9po9wdSH08L3xace3F4PLV76C+/o+1iRruW8=;
        b=AYxsaFq4v+zaq4a3LgiGF9i2VJ9srzm9xs8sk7VQZgZVuTIGSmffJV6UOrLcs18v10
         UYqkhjLc6EKOeBHdpMjy2oMHuKISI3OFm2XoA7faDy46Av+9ZyBwj6V9RzJsFq/ZksyW
         beYR52x5TNVOALbogHys/H0q/m9OLahUe/GpYx9C2J4yHqU5+y0/vSNnhYbHwm/J5Odw
         WnQJ91hmu2m8mPveOsU4PpaskL3xdfS66HI3cyY8a1M8Y0LUwyH+zbF1WCD3d6+AQuhm
         BEn+QXidF/q4xp4NudmPx36BDSX3JE1fp3wDHvOBUj2QUSPGc2zCmmEXoTQeljFdNwu2
         2/6w==
X-Forwarded-Encrypted: i=1; AFNElJ8OkbUgyGTMrbbW70ptJrrqmPPEByZxZnsRYFMopXpe7FL4l24aNBgK6Hy3wVHGypq7xfw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzml4QNfmLYXCsWpYr24ADeP28o9Sf1Et6QucNJAmJoIooB0x/5
	v8fwMHTMGai0vxIIPekdD5e65vjD12HbcE84+jVaZs25o1/RMgoOJu2WF+Ivt+0IbFSP8PWScJU
	w9+5qeeta70/XUFFZvo40iNDZloX9TXI=
X-Gm-Gg: Acq92OEfeO+LAkIpNUUq1vKQ0AJt7X5cnYE4cXoHCw62MTv7uCOl7DD18+vg8mfZQxJ
	cYzgG94SHM5TtsZpiupUqnrSj+h3DjvXpGSG/NcalG4RLsR6fZOEsmaGTJ9Nvp/eXJrjcmdalcc
	D3zINn0uvwI+IJXNo1CyRFYEi0c7VN4Jl6judlyE1LDYGbrvxOMMkvcsvOQtuoUXIoxCoOVSOPy
	pbKVDshKILDNsT3OrYdRvjSbdembA9/ImQ3fALliE5iVTAVbq/l5Lb/hcdUACS/a/nTSE61PBea
	zaFk5TDM0bZ0sePsXyNts4+7YCPbVoXWgSn6p2oAioZfAcZLO7XX4hy5i19xEOmCCQ0khPJbW2p
	PzBS7yaP93PSX70NT2+sK6raF5w==
X-Received: by 2002:a17:903:390f:b0:2b7:88d8:efee with SMTP id
 d9443c01a7336-2baf0e045c2mr171359795ad.28.1778527429909; Mon, 11 May 2026
 12:23:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CV_doc_int-tr_key_format.533@msgid.xyz> <V2_CV_doc_int-tr_key_format.613@msgid.xyz>
 <55d5d53a-ec30-4b72-9ff4-c5a0631620ec@app.fastmail.com> <xmqq1pfivfa3.fsf@gitster.g>
In-Reply-To: <xmqq1pfivfa3.fsf@gitster.g>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Mon, 11 May 2026 15:23:38 -0400
X-Gm-Features: AVHnY4JUHegcYPlbXThln554PgAqJdvdmkRi5_VOj-iK5qcbonLLyL9ls22HnBY
Message-ID: <CALnO6CBiRefHNT6tjskCQRUOj5Y--K3okR_RFPmth6O7s1_VKQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/9] doc: interpret-trailers: explain key format
To: Junio C Hamano <gitster@pobox.com>
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, git@vger.kernel.org, 
	Christian Couder <christian.couder@gmail.com>, jackmanb@google.com, 
	Linus Arver <linus@ucla.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Overall looks good to me. Repeating a few points throughout the doc
might create headaches if format restrictions are changed, but I think
they are essential points worth repeating for now.

On Sun, May 10, 2026 at 10:41=E2=80=AFPM Junio C Hamano <gitster@pobox.com>=
 wrote:
>
> "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com> writes:
>
> > On Mon, Apr 13, 2026, at 12:20, kristofferhaugsbakk@fastmail.com wrote:
> >> From: Kristoffer Haugsbakk <code@khaugsbakk.name>
> >>[snip]
> >
> > Sorry to Ben here who I forgot to set on copy. :/
> >
> > +Cc now.
>
> It has been quite a while and I have no recollection if there were
> still necessary adjustments or not.  Is everybody happy with the
> final text?
>
> https://lore.kernel.org/git/V2_CV_doc_int-tr_key_format.613@msgid.xyz/
>
>
>  Documentation/git-interpret-trailers.adoc | 68 +++++++++++++++++++++++--=
------
>  1 file changed, 50 insertions(+), 18 deletions(-)
>
> diff --git a/Documentation/git-interpret-trailers.adoc b/Documentation/gi=
t-interpret-trailers.adoc
> index 77b4f63b05..b42f957d66 100644
> --- a/Documentation/git-interpret-trailers.adoc
> +++ b/Documentation/git-interpret-trailers.adoc
> @@ -3,7 +3,7 @@ git-interpret-trailers(1)
>
>  NAME
>  ----
> -git-interpret-trailers - Add or parse structured information in commit m=
essages
> +git-interpret-trailers - Add or parse metadata in commit messages
>
>  SYNOPSIS
>  --------
> @@ -14,9 +14,15 @@ git interpret-trailers [--in-place] [--trim-empty]
>
>  DESCRIPTION
>  -----------
> -Add or parse _trailer_ lines that look similar to RFC 822 e-mail
> -headers, at the end of the otherwise free-form part of a commit
> -message. For example, in the following commit message
> +Add or parse trailers metadata at the end of the otherwise
> +free-form part of a commit message, or any other kind of text.
> +
> +A _trailer_ in its simplest form is a key-value pair with a colon as a
> +separator. The _key_ consists of ASCII alphanumeric characters and
> +hyphens (`-`). A _trailer block_ consists of one or more trailers. The
> +trailer block needs to be preceded by a blank line, where a _blank line_
> +is either an empty or a whitespace-only line. For example, in the
> +following commit message
>
>  ------------------------------------------------
>  subject
> @@ -81,19 +87,25 @@ trailer.sign.key "Signed-off-by: "
>  in your configuration, you only need to specify `--trailer=3D"sign: foo"=
`
>  on the command line instead of `--trailer=3D"Signed-off-by: foo"`.
>
> -By default the new trailer will appear at the end of all the existing
> -trailers. If there is no existing trailer, the new trailer will appear
> -at the end of the input. A blank line will be added before the new
> -trailer if there isn't one already.
> +By default the new trailer will appear at the end of the trailer block.
> +A trailer block will be created with only that trailer if a trailer
> +block does not already exist. Recall that a trailer block needs to be
> +preceded by a blank line, so a blank line (specifically an empty line)
> +will be inserted before the new trailer block in that case.

[not strictly related to this patch, but while we're here=E2=80=A6]

Even in context, I find the original (and new) paragraph somewhat
jarring. In "the new trailer," there's no antecedent for "the
trailer", so which new trailer are we talking about? The previous
paragraph is about "<key-alias>es" for --trailer=3D"<key>: value".

We _could_ move this paragraph up one, so that it follows the
paragraph on trailers being appended when given with --trailer.

Either way, adjusting "the new trailer" to "a new trailer" might feel
better to me. Other suggestions welcome.

> -Existing trailers are extracted from the input by looking for
> -a group of one or more lines that (i) is all trailers, or (ii) contains =
at
> -least one Git-generated or user-configured trailer and consists of at
> +Existing trailers are extracted from the input by looking for the
> +trailer block. Concretely, that is a group of one or more lines that (i)
> +is all trailers, or (ii) contains at least one Git-generated or
> +user-configured trailer and consists of at
>  least 25% trailers.
> -The group must be preceded by one or more empty (or whitespace-only) lin=
es.
> -The group must either be at the end of the input or be the last
> -non-whitespace lines before a line that starts with `---` (followed by a
> -space or the end of the line).
> +The trailer block is by definition at the end the the message. The end
> +of the message in turn is either (i) at the end of the input, or (ii)
> +the last non-whitespace lines before a line that starts with `---`
> +(followed by a space or the end of the line).
> +
> +This command ignores comment lines (see `core.commentString` in
> +linkgit:git-config[1]). This is for use with the `prepare-commit-msg`
> +and `commit-msg` hooks.
>
>  When reading trailers, there can be no whitespace before or inside the
>  _<key>_, but any number of regular space and tab characters are allowed
> @@ -107,9 +119,6 @@ key: This is a very long value, with spaces and
>    newlines in it.
>  ------------------------------------------------
>
> -Note that trailers do not follow (nor are they intended to follow) many =
of the
> -rules for RFC 822 headers. For example they do not follow the encoding r=
ule.
> -
>  OPTIONS
>  -------
>  `--in-place`::
> @@ -402,6 +411,29 @@ mv "\$1.new" "\$1"
>  $ chmod +x .git/hooks/commit-msg
>  ------------
>
> +* Here we try to to use three different trailer keys. But it fails
> +  because two of them are not recognized as trailer keys.
> ++
> +----
> +$ cat msg.txt
> +subject
> +
> +Skapad-p=C3=A5: some-branch
> +Hash-in-v6.11: 45c12d3269fe48f22834320c782ffe86c3560f2c
> +Reviewed-by: Alice <alice@example.com>
> +$ git interpret-trailers --only-trailers <msg.txt
> +$
> +----
> ++
> +Recall that a trailer key has to consist of only ASCII alphanumeric
> +characters and hyphens, and this does not hold for the two first
> +supposed trailer keys. And now none are recognized as trailers because
> +the candidate trailer block has at least one non-trailer line, even
> +though `Reviewed-by` is a valid trailer key. Recall that a trailer block
> +has to either (i) be all trailers, or (ii) consist of at least one
> +Git-generated or user-configured trailer (and some other conditions).
> +And (ii) is not satisfied since we have not configured any trailer keys.
> +
>  SEE ALSO
>  --------
>  linkgit:git-commit[1], linkgit:git-format-patch[1], linkgit:git-config[1=
]



--=20
D. Ben Knoble
