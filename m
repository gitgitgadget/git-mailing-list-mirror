Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EBB169950
	for <git@vger.kernel.org>; Tue, 14 May 2024 10:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715683721; cv=none; b=er57MPuEvCEhCBopiy5Gd4VKUknMqcnysVh/mPnREsyKe42DbFtPBYpskVtYlsUIemXmWWbFCOd/UuU+8pQOF+YIhOCowrTEtX8fsCLwNo9MVq5q2cFMN+mYjLFkBbc9b3ATx4v6PgHjXjZBin15m29TqQjPbwZ61wYppmOQYlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715683721; c=relaxed/simple;
	bh=DmQ+wwTMkxDgWwC1X/GRIgDuSHaNs2qcMrJqh3QdXLU=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sc/EIQuwXRKrigwmlBXTDVBo98xL3k/EeVfiGwtaDChgo3zgRP2u8Ulx0noJGogNz4FCmBxL980wU1oFSa7eZEIBLcKdb51y5LjdVDoLJdPZVDFej+8xWuuGo1WtVpBrK2WSKOhlUt23sZpXZcsfoBjQwGTYy7bVypFkyC1rOK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BQzNThHh; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BQzNThHh"
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-23f02e15fd6so2762928fac.1
        for <git@vger.kernel.org>; Tue, 14 May 2024 03:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715683719; x=1716288519; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=P/UOSgoUMJN8agJ5DxNMZ6GQCBiSCqZ6u1R8CdJcyr4=;
        b=BQzNThHhkAY5bNLTm7nsbw78KhW7o1a3ZCkyJqhBV8ZCQxQ4/mAvu6/4slaG1sovkS
         vxmLjboNJYWjpeUiKd2AwII+gz82nX2yheU5edYHa58yDrh9TZOmrC5Zvza13O91fOey
         1vDMC2O9Zb9uVw94zt+qz9iwcd7JfioheJXVWViiYGtDFwcEiN22UUvAVvWISqvZOC/a
         L3A4U5sBTHWDAcVQc2FuIhKT8wVqX4sYEnv/EQAjLw/DWMrMQMrFOk8isd3w1DEjZ6NM
         MmSJmRNF1TFc+hyZKXfYgIc2UUZaUAA0gHr0eQiaoVQlfsCMrqLOLTWRs8nN1cHFmBMC
         TTSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715683719; x=1716288519;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P/UOSgoUMJN8agJ5DxNMZ6GQCBiSCqZ6u1R8CdJcyr4=;
        b=I9OV3k6Tp0emCxa0v7C0YbLvI2ojhZ92xzXAhstF9ms0ec4gLV0GTJcHa0+K4wCTt3
         P3XFGsRB7yAQg5/mqpllm6mippQZuUJI+6BTygdB1lRutdu9R4+tvkHk6GIG0O5Vfm0n
         N0aTG7t5tEbZEns1tKnFFrfGmDdr3fG0m5bLfbQaWjdYTz68XiH0sgO8qxodcqWx54Mj
         o0dRZk0O2zjN6ltvVohBfKkNpa2c6IFK+fgyzhnq/ApGtKgA4j5yUKIymWVipF4qykyl
         gSljbOOEkG46C1b4UAo2HXf+ygKC9P70Zi17LdmcuGT8da3hOHl85hLLPdy7Mze1z0Ce
         2IlQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0p4LG9vp/ptVFz+vRdQr3py3nMdjNsNDBFaDhdr2Dr1eyzC/B4COH4TITS6F6gz5ovRUtfIJljufcW21JaUNiuOsq
X-Gm-Message-State: AOJu0Ywbo43qwHtziOK2kE1txhIsIGZvO6gsgZVeTDcZFOx2cmASmPLA
	KqW34FEsLVGsAVcJYw45Foy67frbUG7PA4I/29xKOg1TTAid6wn/7FJkJyZ4wS5nkd7ecHGe+iO
	FMKPa+M+6sQTnEqYfZWHS6eklUMg=
X-Google-Smtp-Source: AGHT+IH3XZ6YnsCKoO4Ztaqy/eoJtjSA7G5nNn9etYfhVhPZn+BqyoI5d042WyEIxa8VnAcLlfz1RePNbEfxb0+mA/k=
X-Received: by 2002:a05:6870:f684:b0:239:4aad:777c with SMTP id
 586e51a60fabf-24172a7e2ddmr14780185fac.13.1715683719181; Tue, 14 May 2024
 03:48:39 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 14 May 2024 06:48:38 -0400
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <2ef53ff98b12fe9373a15ec3a795235f040d9049.1715667067.git.ps@pks.im>
References: <fc1a9fa03de7330f79dc56b0f2712834cb236b5a.1715070296.git.ps@pks.im>
 <2ef53ff98b12fe9373a15ec3a795235f040d9049.1715667067.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 14 May 2024 06:48:38 -0400
Message-ID: <CAOLa=ZRkLpi-DSNsTgVf5OCk6gEP7VTx2SeJRKT_Lv+pVu1Nyw@mail.gmail.com>
Subject: Re: [RFC PATCH v2] docs: document upcoming breaking changes
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>, Phillip Wood <phillip.wood123@gmail.com>, 
	Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
	Dragan Simic <dsimic@manjaro.org>
Content-Type: multipart/mixed; boundary="000000000000a11100061867be4f"

--000000000000a11100061867be4f
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

[snip]

> +### Removals
> +
> + - git-http-push(1) can be used to push objects to a remote repository via
> +   HTTP/DAV. Support for write support via WebDAV is not in widespread use
 > +   nowadays anymore and will be removed together with the command.
> +
> + - The dumb HTTP protocol can be used to serve repositories via a plain HTTP
> +   server like Apache. The protocol has not seen any updates recently and is
> +   neither compatible with alternative hash functions nor with alternative ref
> +   backends. It will thus be removed.
> +
> + - git-update-server-info(1) generates data required when serving data via the
> +   dumb HTTP protocol. Given the removal of that protocol, it serves no purpose
> +   anymore and will be removed together with the protocol. This includes the
> +   "receive.updateServerInfo" and "repack.updateServerInfo" config keys and the
> +   `git repack -n` flag.
> +
> + - `$GIT_DIR/branches/` and `$GIT_DIR/remotes/` can be used to specify
> +   shorthands for URLs for git-fetch(1), git-pull(1) and git-push(1). This
> +   concept has long been replaced by remotes and will thus be removed.
> +
> + - "gitweb" and git-instaweb(1) can be used to browse Git repositories via an
> +   HTTP server. These scripts have been unmaintained for a significant amount of
> +   time and will be removed.
> +
> + - git-filter-branch(1) can be used to rewrite history of a repository. It is
> +   very slow, hard to use and has many gotchas. It will thus be removed in favor
> +   of [git-filter-repo](https://github.com/newren/git-filter-repo).
> +
> + - The "dashed form", i.e. support for calling `git-<command>` instead of
> +   `git <command>` in scripts, has been deprecated for a long time and will be
> +   removed.
> +
> + - The command to import patches from Quilt seems to be used rarely, if
> +   ever, and will be removed.
> +
> + - Support for importing repositories from GNU Arch will be removed because
> +   it would not appear to have any users.
> +
> + - Support for interacting with CVS repositories (via `cvsimport`,
> +   `cvsexportcommit` and `cvsserver`) is of dubious use by now, judging by
> +   the number of times these commands have been mentioned recently. The
> +   code has been essentially unmaintained, too, and will be removed.
> +
> + - Support for grafting commits has long been superseded by git-replace(1).
> +   Grafts are inferior to replacement refs as the mechanism can lead to
> +   hard-to-diagnose problems when transferring objects between repositories.
> +   They have been outdated since e650d0643b (docs: mark info/grafts as outdated,
> +   2014-03-05) and will be removed.

I think it is worthwhile also looking at the number of commands we have
and see that some of these could possibly be marked deprecated, maybe
removal could follow too:

* add, stage
Here, `stage` is synonym and can be just dropped.

* prune, prune-packed
`prune-packed` prunes objects from packed files, perhaps could be a
sub-command on the existing `prune` command.

* annotate, blame, pickaxe
You've mentioned `annotate` below, but we could also remove `pickaxe`.

* log, whatchanged, shortlog
Here `log` already handles what the other two commands do.

* for-each-ref, show-ref
These two commands do very similar things, i.e. list references. Both
diverge in the features they provided, but its not clear why we have the
two.

* verify-commit, verify-pack, verify-tag
These could probably be subcommands under the verify command.

* diff, diff-files, diff-index, diff-tree
Here, `diff` seems to handle everything that the others do.

> +## Superseded features that will not be deprecated
> +
> +Some features have gained newer replacements that aim to improve the design in
> +certain ways. The fact that there is a replacement does not automatically mean
> +that the old way of doing things will eventually be removed. This section tracks
> +those superseded features.
> +
> + - git-annotate(1) is an alias for git-blame(1) with the `-c` flag. As
> +   the maintenance burden of carrying both of these commands is negligible, both
> +   commands will stay.
> +
>

While maintenance burden is an issue for us. There is also an user
experience point of view, having similar commands doing similar
operations is often a cause for confusion.

> + - git-restore(1) and git-switch(1) have been introduced as a replacement for
> +   git-checkout(1). As git-checkout(1) is quite established, and as the benefit
> +   of switching to git-restore(1) and git-switch(1) is contended, all three
> +   commands will stay.
> +
> + - git-config(1) has learned to use subcommands that replace implicit actions
> +   (e.g. `git config foo.bar baz`) as well as the action flags (e.g. `git config
> +   --unset-all`). The action flags will not be removed in the next major Git
> +   release as there likely exist a lot of scripts out there that use the old
> +   syntax.

--000000000000a11100061867be4f
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: ab5c6af7de49f70_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1aRFFZVVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mODMzREFDYy9oejUvSjk5aFdnV3hTNHlFVURCRlpnNAp6QXVxQk8yNlBF
cWpScGZZYmpweUs1LzcvTEJqYTdSN2F1TUlJU2x3Y3o3QUgzR0VEc3pEcDlueDR0U2dsQ2hpCndY
QzlZT09YbFNFTnBpNElwb0loTVZmVzMydmRMWUQwQXdlSWpSMjJocDBoYUdsazhVMkxHUDZOVEFY
d2ZvZHoKZlBKMG9wV1dRWnJkQ3ZaV3N0N1BiY2VrNDBsQjBOUUlKREFRWUVTemQ3WnljS01uVXNo
RldzMExPY2dJOXNCMwpnTXY5eTJzWm5kWjR2Tk5wTk9vWmFRMHdWRWdSMStSckxjeHhpTzBGZjZq
Z3o0M1RnRzFPUkJYK3N4ZW1Yd3UrCjlNcE1ZSnFDSER6Zkhwc1dpczBualRWTUc0cFU4Uyt4dEoz
dkJBdjJrTDZ2cEV4ZGlLcnpURHd6WGxCQzFrWVcKeXd4VnZ4cGxjQUhoZmp1Q3RTM2ZCRWhBMDV3
TXdYNHkxN1R5eHFzd3M0YmhrY2hpd2hzdjd3SjN0VW1tckVvTQpKQUJwZVNhNDVhZUUzMWh1S3Fk
bmhhdDlPajVpcm85bGRQRklVMjRnd3lsK1RiU2pKTkJ3S3RXbGRWeWRZZXFrCndhWnM2Z2g2cVVm
UWFET3gySlF0OVR1M2dPMnhhQTN4Rk1JUXdHTT0KPWR3Q24KLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000a11100061867be4f--
