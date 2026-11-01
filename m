Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793576706;
	b=I0O+2abi/0MQoS+GdopmufNeSHmT35FX3nHH4DQ7uajuKdpfkABUsDqWQUZmjAQPr020
	 IcH7/lGZWX/V1kcPL+HlTcGtKm9NOYHESjwv97P7lfV6KgveuxY4TSagZM2Rw1sa5dWNZ
	 VpXE/WlHZ5N9drbbRb6xoz4ttkbIOoYFCLkN4x5OBBDSkTyJdnoSLIvspXGkOLii9TFjO
	 s6FUL7e1Nqt4ULUpyn4tpa/1rqJWhPz41Y1pT57a8vf4MdVuTlEK6qtzwkERREYm/vcwk
	 UzCIrxT4PExkVvX2Bwm5P8BUClna4rUYMKdxtcVl2tAEHiqJzMBqCgEkZrnmaYxmA0A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793576706;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=/aDzNsISMSaalB4/mSKq2yU4f1sldf7mcGv7ze4WWA4=;
	b=ZEGARTx/ExIdA5M4IgJdrl5RVO8kkAr/j1XTlAHuCmB/jc3k1QKGxzkmKv85bTM8CuyV
	 R5Hh/0VXpiNOaf4ILvNF5WoBgIIMafSV7nA/W5hx3w5ormrbFsoAWeMC0KyAYMIjYuQ5H
	 E3L8V2uKUlfPC5eEV5H4y/WLJ/hptcH4viMg/FEqEN7uKrYU9qpuHEY2S8nxVc8QiSkAY
	 3XsgkfPBeRSVc8Sgq4ssngY5B8yylR/5VTCXyClBGY+X2ur4MEbvgmcxUDInOIIGXePzI
	 X+/g45rbCwODM5jW4+W/oF0rQqfGzB77/GTwVVC703AglmcTbWsW2iMaVxpAELoO9Zg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SBNEM+nQ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.50
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC43606A32C
	for <git@vger.kernel.org>; Sun,  1 Nov 2026 23:45:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CDC43606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SBNEM+nQ
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-4a77dcc4ca0so1348975fac.2
        for <git@vger.kernel.org>; Sun, 01 Nov 2026 15:45:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793576705; cv=none;
        d=google.com; s=arc-20260327;
        b=SmMlQ/Ueypl5bE4He7RyATINd4rxByuAPtDbj+AJ4USSXgj5ViesTYQeX+WrvSAlbM
         pxYWbzkLGm06Q1oie/sfUsS6suoyAsx74QcmgoqDgQrSjb83WiQP3jTfteDA+qC5NCRP
         R31QuYKlfUKX2BnEML+7gEWUmOv0aVyKmQhtt1Db8CJe3uiEpENa7wHROo5skPtopNIi
         pJ62cC3DUY5yuL9Zbq+3cuyXYcu3VRbGCRTBvTmqJJ6gP9z3C+bHQQNl9ct0eiBsHRJ5
         r2mR4SUuEyhGk0JaA+3eT2Lgrx1SwDRCAa54DrE7MYP7rtsCTffU9y5ed3r2l7uCHvw1
         oDCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=/aDzNsISMSaalB4/mSKq2yU4f1sldf7mcGv7ze4WWA4=;
        fh=+Ve7dG4yAo6b6IJAJcsfAVXuA3IHmj+18im/3KFY0tU=;
        b=qQl8jpewuS+2AcDvrPiXxWUe95lXiVYqaPLoZFmBft6T1FnVw7k1SB5YcI7JKsFWWX
         TNyhldEdbPOjnLyNN3y9BRrgGKsHAolxRp8ECXKGxfHEI+H1HVwjB4wIwdUy9KMoJhD/
         qSOFZgcOxTWHxUbFBH400Xi1t9fV/Kj8TCgnTDx3GSkQ43srOAJFqJbwEfivtqobuO2V
         B4Leki1qK5FI168wk4OIzhaCkF/Ma/r98Mfb8ccvqcQkRYJYUnYH9kDFsZKgcDAXRn3Y
         Olo7GrkJq2pkByC6E49ymyfpETUD4xbYAiT06wMmOCgDPftX4pMKIa054yuYIPtqwP8j
         Ro6w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793576705; x=1794181505; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/aDzNsISMSaalB4/mSKq2yU4f1sldf7mcGv7ze4WWA4=;
        b=SBNEM+nQlnGp9MHNN1KSK4WHn5cHI+CBYde56ZHxhgdU1F0EOLXq4yEzHEjkl8qew0
         9HzpHJ67859qUXhz8XGoC2qZZjUkZ1hLRZoO2Ri+su9HCcLWkr3ZWpq7gAGur5jVR95G
         t3yNyebN9Mx+tqr9/a+uwKj9IIFZKfA0o3zq6tYCeuKr8svXmkhIQecO4oRTniyEJG5v
         inwiXAe8iVi9PWrT9Tgc7vVaq/dcPCua43ShIv1KvQQkQ3zB1/Xl1n6RT1PJFS1Cl/7Q
         JuMNxksOQMPvwjBNDD8smNpWCYf1YwmHxzRE9oWQo+lgHDaHZX7+RgH7E1/mCWhBMv9N
         W4kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793576705; x=1794181505;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=/aDzNsISMSaalB4/mSKq2yU4f1sldf7mcGv7ze4WWA4=;
        b=ufuUDmJK8k5nWfJOiXEu6jEy99kdcWBI+aMNn/JDCannd5+ZJjY/foRs2zeccQ5fz9
         XmcpP53xagFdOA2VvD8+R9bncyoI7+DVr3if8rBR08LZmzpRKKoeZUKbECHhsQd7ekYw
         sM+PEL91QeFHe6LdGom/Tb2MfWK9lnYVN3rR8In4eecIu3EpS4Rwg8BFNy75euhlQwP/
         HjFavCi64Ui8fbubH1L4TOOO+A3TQwPdfHwZ9fug702KOYl49MGqF1ulvZWnvgIw1c7x
         3dg6JlXkVOQvHBx3KhCDT8b/N2WWSPfSc1GWKJeL7KdiHVdaHF+hOxPMD/4CdmIMq9XJ
         tj0Q==
X-Gm-Message-State: AFq9FYLZ6i6w5qvA6n/213GvhJWA6z4pi/Q5BRp63UqiwvpZk68IiyCS
	wM4RQH2w6Z8FSct+fpst7jLnZkDxlCenRzowGqxSQt06cYg5sYL3YUTNaaoQsn5MjzCrRAdh2JS
	eiKkTNZbU5Cm1SvtakHYVwaS9WRerWtbxaWWc
X-Gm-Gg: AYBFou2GtjHtZIYfltu/cdKfEO3plkDtnTnvclsj0amE1I9TNRDMIng/ROo3btVlJ6u
	n8SSyGhnK/yjTsoEzGDJ7W/Q7z4TwT5eobpfS/mUecySFgiPYIncAmmHc6L35KUASjU7fxFwYjm
	RhE/5lvlqwFwP592Xxh52EvTvhvWTylCfr6RHFt8JjqQkZqKnTUeLCGlku5LqGStmOb8OrPbh0a
	GVK3bTUre6arGvfqMqo/bkcJLGYy4oc2oHd7XS75bcn3RdwQ8jzQcLw1tNyXufMK+MQPkevwnkM
	jI1GFs8LezavU8LaCTdnha+E/IQ/UIGmJR/ep/mrRia1htlBBSdn+21COoRH+tJDml21I2KmJ82
	w3E9y/MZHCqguW5csmesERuKhv0bFrqSeiG4=
X-Received: by 2002:a05:6870:8242:b0:456:5d8b:5681 with SMTP id
 586e51a60fabf-4a9072d45b8mr5483786fac.1.1793576704549; Sun, 01 Nov 2026
 15:45:04 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261022212903.177261-1-andy.koppe@gmail.com> <20261022212903.177261-4-andy.koppe@gmail.com>
 <atsPwpbD3YqmBds_@pks.im>
In-Reply-To: <atsPwpbD3YqmBds_@pks.im>
From: Andy Koppe <andy.koppe@gmail.com>
Date: Sun, 1 Nov 2026 23:44:53 +0000
X-Gm-Features: AclHuK9RQ6Y_Bm_TdPD7HFZunUHrTpmllp4Bq-3FWFlMF_AEXS6xkR0pBi5PsCg
Message-ID: <CAHWeT-aa=6WByd4U9BB-6mMMUAxPQCC5GhyM1WMSSVVatvN0Tw@mail.gmail.com>
Subject: Re: [PATCH 3/5] doc: stop calling root refs pseudorefs
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>, Julia Evans <julia@jvns.ca>
Content-Type: text/plain; charset="UTF-8"

On Fri, 23 Oct 2026 at 08:42, Patrick Steinhardt <ps@pks.im> wrote:
> On Thu, Oct 22, 2026 at 10:28:51PM +0100, Andy Koppe wrote:
> > diff --git a/Documentation/git-update-ref.adoc b/Documentation/git-update-ref.adoc
> > index 37a5019a8b..c775334230 100644
> > --- a/Documentation/git-update-ref.adoc
> > +++ b/Documentation/git-update-ref.adoc
> > @@ -163,13 +163,12 @@ still see a subset of the modifications.
> >
> >  LOGGING UPDATES
> >  ---------------
> > -If config parameter "core.logAllRefUpdates" is true and the ref is one
> > -under "refs/heads/", "refs/remotes/", "refs/notes/", or a pseudoref
> > -like HEAD or ORIG_HEAD; or the file "$GIT_DIR/logs/<ref>" exists then
> > -`git update-ref` will append a line to the log file
> > -"$GIT_DIR/logs/<ref>" (dereferencing all symbolic refs before creating
> > -the log name) describing the change in ref value.  Log lines are
> > -formatted as:
> > +If config parameter "core.logAllRefUpdates" is true and the ref is
> > +HEAD or one under "refs/heads/", "refs/remotes/" or "refs/notes/", or
> > +if the file "$GIT_DIR/logs/<ref>" exists, then `git update-ref` will
>
> It's kind of hard to understand how the ANDs and ORs play together.
> Like, does the config parameter extend to all subsequent ORs? That's not
> really a new issue though.
>
> > +append a line to the log file "$GIT_DIR/logs/<ref>" (dereferencing all
>
> Also, this infomation about "$GIT_DIR/logs/<ref>" is out-of-date, as the
> reftable backend doesn't store its reflogs in there.
>
> I wonder whether we should maybe just stop explaining how
> "core.logAllRefUpdates" works and instead refer to git-config(1).

The whole LOGGING UPDATES section in git-update-ref(1) seems outdated
as it assumes ref files and SHA-256, but I think that's out of scope
of this patch series.

> > diff --git a/Documentation/git-worktree.adoc b/Documentation/git-worktree.adoc
> > index e6e77252ab..f0eb6d4137 100644
> > --- a/Documentation/git-worktree.adoc
> > +++ b/Documentation/git-worktree.adoc
> > @@ -303,11 +303,10 @@ but others are specific to an individual worktree. One example is `HEAD`,
> >  which is different for each worktree. This section is about the sharing
> >  rules and how to access refs of one worktree from another.
> >
> > -In general, all pseudo refs are per-worktree and all refs starting with
> > -`refs/` are shared. Pseudo refs are ones like `HEAD` which are directly
> > -under `$GIT_DIR` instead of inside `$GIT_DIR/refs`. There are exceptions,
> > -however: refs inside `refs/bisect`, `refs/worktree` and `refs/rewritten` are
> > -not shared.
> > +In general, all root refs and pseudorefs are per-worktree and all refs
> > +starting with `refs/` are shared. There are exceptions, however: refs
> > +inside `refs/bisect`, `refs/worktree` and `refs/rewritten` are not
> > +shared.
>
> It might make sense to have a bulleted list here, same as I proposed in
> a preceding patch.

Yep. Done in v2.

Andy
