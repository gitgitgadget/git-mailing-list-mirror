Received: from mail-pj1-f65.google.com (mail-pj1-f65.google.com [209.85.216.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 356382C190
	for <git@vger.kernel.org>; Sun,  3 Aug 2025 08:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754210585; cv=none; b=MilhoDOb5N04Q1yTcHWbP+jjlGr6Ht+iC0TgzoDjTKeuRMQSueTwOODN3pgtDN95WTQr987eF5b6uYsqJQ9F2cplK1p3u+ObgzBxW9EaA8x2xhbeMrNz0TcsDcmS9ljCsqNvHEVEZZb7dHbxuPbAA6qFCmAzgHyHN4MOi+XAacw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754210585; c=relaxed/simple;
	bh=J0K4EcG+BWC3qza0JnTHKUHEZmU7t8b4uBokI+VWKh0=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=Vgq1RxqzUNihY163ZKRSHlm0T5YWxcSSfbDihgVyfu/V422EMKSxq2E8RAHfMXN5kh84x4my+3m0QnKBFwVHWU23rFCOI3KBhroCUDcmZtkO1QsPhMFGrgGNsEb3ogyCHUqy95dhFRkp/LjXIxRi6up+k2gH6xvgl8wGopEy8Lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sipao5+9; arc=none smtp.client-ip=209.85.216.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sipao5+9"
Received: by mail-pj1-f65.google.com with SMTP id 98e67ed59e1d1-313bb9b2f5bso3668397a91.3
        for <git@vger.kernel.org>; Sun, 03 Aug 2025 01:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754210583; x=1754815383; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pJXTWChRaRopwitNWbFA0TWgB02gOzT6l1o+CzQGBzg=;
        b=Sipao5+98igkI7l+ArMDoTksc6UC5XFYIMf9v4c547ppNvQo8Jc31IP4wET7UiE75r
         xa2ut1vZb84o8cVOHwNtDg7pyC70xdV8sqCePjPBMpiDCUZ3jC8gsA3E1Hb8ozUBx0NU
         JEdT8G1QBVnGwEznrtG2o7LmO0xUmDpYaS0ywgOVN+KQ7U82aAu2irETBlfduQWUPEAz
         7rrMc0XX+v/LeRF49DyP3pieNe1a2UWt+HzU53EqUuMLxfCGG18IX3vIfwOoFi5ViO7t
         x6WxV06WJHAjgXWc2CDMlQ5IW8LeQMpQMBTvE6Xewp2j+KFOzCkLzny/JvJHPzbRaqdN
         H5TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754210583; x=1754815383;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pJXTWChRaRopwitNWbFA0TWgB02gOzT6l1o+CzQGBzg=;
        b=jjO/POF8TXuxWh8d4RzyMyT+XV1zuUibr/uBXeviNTxbRAHHR1AB23e6DpWD5Z+Pgn
         dXJgbaLuMZ5d6GyitGzdkOfDvkbDe9YpB96f6mu/GF8SB61TNSAY6sBaXxeoblJEVpWn
         a1JT/xgFmYtskyej1ARzYHEtATE63YQaFw86buHJsVTl3f+YsfiuupEHg2esbxt9SYHD
         J/j1UgLuVVK+pCWkZti7Y5afp86I62MSKWbqDzcG3N70tcuctqrKUP4UOFOfcazonmHK
         8Ru3OtHN2dNtne0uJC+FTWp748FRYCFPUnKV6XmUyLRNwZQTY6FEGgC/wrHKW8s75Er1
         dMMg==
X-Gm-Message-State: AOJu0YzogoLjry28SPUPCgSGno39Y/l1Pp3G121fY/0LsUpD1g2QS4SM
	jEfAXKCebInjHpQs6ukfEBkM3eNs5TLVw+xerbFsmnE0qt6B3aPJKmANZBrPyB2jtfG0Pw==
X-Gm-Gg: ASbGncuWechDys7qT/ppdhHhcpmH3ZVqQZ1J8WNN6RJUTTSvGFscof+4MeTj8LltfAS
	DCb996RmKhcxbo+ap5JIZmoWZfYNpZMwWed2JbBnwwlSh12CJDrHeB1bDz9N9na5kN1E2NgAKsL
	L9vGmPYUr/vpbee4KOHTg1DInNA1voUXNshIEvuQlfd2j1mKMso2TGQLkgYGw1El9X3iLOijTGf
	5OyGBiHXnJvY23HrxHbE9S2VfCFeO2mGNl/vptq8h+K3v9PHEiMUCynwmcR0qyUKRwnJJVuxCaQ
	2OfJZQL1mHzBdA266nFp6ZTrUvEVDBf6ZsY2xT7Qpj7qUtLsHWO2pdtwDy20DOCdqKUWwwdGZ8M
	mNHo7cbIs2Rhk2KwDtuUuAKmBiuiDXm2gArl0ENUGAPzrU9QC2GNycUblRWkF+vnG+sHXliHbOW
	l/Jc4Z4fiTvx2tf4Bi3UxhyQIN7i6jg8LyRw==
X-Google-Smtp-Source: AGHT+IEGjwjDUw5aJmO1Oe2S9eRetNURg3bQvwx4ruTdTC7iz0Wn9+/FeI6wfH5qsiqyrHLbrjjXpw==
X-Received: by 2002:a17:90b:5110:b0:31f:6ddd:ef3 with SMTP id 98e67ed59e1d1-32116330b8amr7609811a91.35.1754210583393;
        Sun, 03 Aug 2025 01:43:03 -0700 (PDT)
Received: from smtpclient.apple (awork062145.netvigator.com. [203.198.28.145])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b422b7e21adsm6877526a12.26.2025.08.03.01.43.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 03 Aug 2025 01:43:02 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [PATCH] diff: ensure consistent diff behavior with -I<regex>
 across output formats
From: Lidong Yan <yldhome2d2@gmail.com>
In-Reply-To: <20250802102249.GA3738980@coredump.intra.peff.net>
Date: Sun, 3 Aug 2025 16:42:48 +0800
Cc: git@vger.kernel.org,
 hi@arnes.space,
 michal@isc.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <2C9BB1AD-A958-4AE6-9B85-E57437D00535@gmail.com>
References: <xmqqikjg47qt.fsf@gitster.g>
 <20250729081820.34626-1-yldhome2d2@gmail.com> <xmqqcy9io73j.fsf@gitster.g>
 <20250802102249.GA3738980@coredump.intra.peff.net>
To: Jeff King <peff@peff.net>,
 Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3826.600.51.1.1)

On Sun, Aug 2, 2025 at 06:22PM, Jeff King <peff@peff.net> wrote:
>=20
> So here's a naive application of the same technique:
>=20
> diff --git a/diff.c b/diff.c
> index 76291e238c..0fe6eb7443 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -6845,8 +6845,28 @@ void diff_flush(struct diff_options *options)
>     DIFF_FORMAT_CHECKDIFF)) {
> for (i =3D 0; i < q->nr; i++) {
> struct diff_filepair *p =3D q->queue[i];
> - if (check_pair_status(p))
> - flush_one_pair(p, options);
> +
> + if (!check_pair_status(p))
> + continue;
> +
> + if (options->flags.diff_from_contents) {
> + FILE *orig_out =3D options->file;
> + int orig_changes =3D options->found_changes;
> + int skip;
> +
> + options->file =3D xfopen("/dev/null", "w");
> + diff_flush_patch(p, options);
> + skip =3D !options->found_changes;
> +
> + fclose(options->file);
> + options->file =3D orig_out;
> + options->found_changes =3D orig_changes;
> +
> + if (skip)
> + continue;
> + }
> +
> + flush_one_pair(p, options);
> }
> separator++;
> }
>=20
> which works on a trivial example. It affects all of raw, name-only,
> name-status, and checkdiff. I know Junio said that --raw should not be
> affected, but I'm not sure I agree. Anyway, it should be possible to
> split the logic by output type.

I think I could do the same thing in diffcore_ignore(). Like:

+void diffcore_ignore(struct diff_options *o)
+{
+	struct diff_queue_struct *q =3D &diff_queued_diff;
+	struct diff_queue_struct outq =3D DIFF_QUEUE_INIT;
+
+	if (!(o->output_format &
+	    (DIFF_FORMAT_NAME |
+	     DIFF_FORMAT_NAME_STATUS)))
+		return;
+
+	for (int i =3D 0; i < q->nr; i++) {
+		struct diff_filepair *p =3D q->queue[i];
+		if (ignore_match(p, o))
+			diff_free_filepair(p);
+		else
+			diff_q(&outq, p);
+	}
+
+	free(q->queue);
+	*q =3D outq;
+}

And ignore_match(p, o) will run xdl_diff() for file pair p. This =
approach
ensures that the behavior of `git diff --raw` and `git diff --check` =
remains
unaffected.

> I'm not sure if stuff like --stat would need something similar. It's
> already doing a content comparison, so presumably it handles it
> internally. Maybe stuff like --dirstat would need it, too? In which =
case
> we'd maybe want to annotate each filepair in an initial loop with
> whether it's modified at the content-level, and then take that into
> account in various code paths.
>=20
> And of course it's horribly hacky looking. Some refactoring might =
help.
> Certainly it is silly to open /dev/null each time through the loop.
> There might also be a better way of checking whether the diff found
> anything than the found_changes flag.
>=20
> So this is really just sketching out the direction, and somebody would
> need to figure out the details.

Seems like compute_diffstat() will run xdl_diff() to fill diffstat. =
Since diff_flush()
calls compute_diffstat() for --stat, --dirstat=3Dlines, --shortstat and =
--namestat, we
shouldn=E2=80=99t run an extra xdl_diff() for them. I don=E2=80=99t know =
if --dirstat=3Dfiles would
need an extra xdl_diff() though.

>> * Also, should we internally run diff twice, especially even when
>>   we are going to show the patch output and are not limited to
>>   FORMAT_NAME and FORMAT_NAME_STATUS?  Generally, running the real
>>   diff in any of the diffcore transformatin is a sign of trouble.
>=20
> The patch above also runs the diff twice for "-Ifoo --name-only -p". =
But
> I think we are kind of stuck there. We want to show all name-only
> entries before any content diffs. So either we have to run the content
> diff twice, or we have to buffer it to show after we decide whether to
> show name-only entries.

I haven=E2=80=99t thought of a good way to avoid running the diff twice =
either.
Caching the diff content seems quite complicated. Moreover, `git diff =
-G<regex> -p`
requires running the diff twice: the first diff is used to filter out =
file pairs
that don=E2=80=99t match, and the second diff outputs the patch.

On Tue, Jul 29, 2025 at 05:28:00PM -0700, Junio C Hamano wrote:
>=20
> The enthusiasm is appreciated, but the implementation raises two
> questions.
>=20
> * This special cases -I<pattern>, but any option that causes us to
>   set the .diff_from_contents flag, not just -I<pattern>, can cause
>   the raw blob comparison to be potentially different from what the
>   blob contents are compared with various "ignore this class of
>   changes" criteria.  Shouldn't "git diff -w --name-status" and the
>   like get the same treatment?

Yes, I think I could modify ignore_match() to support -w and other =
ignore options.

> Also, the usual way to compose a log message of this project is to
>=20
>     - Give an observation on how the current system works in the
>       present tense (so no need to say "Currently X is Y", or
>       "Previously X was Y" to describe the state before your change;
>       just "X is Y" is enough), and discuss what you perceive as a
>       problem in it.
>=20
>     - Propose a solution (optional---often, problem description
>       trivially leads to an obvious solution in reader's minds).
>=20
>     - Give commands to somebody editing the codebase to "make it so",
>       instead of saying "This commit does X".
>=20
> in this order.

Thank you once again for patiently explaining how to write proper log =
messages.
I=E2=80=99ve made notes and am ready to apply them to future commits.

Thanks,
Lidong


