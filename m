Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795712256;
	b=aA+SypuF1o0YPnVMbJPhg6SVPgjqsUzUfc02yZLK7TqRojH8hWu5jETiS/z0dq1vx7bC
	 NX6JRlsE6h9l3/+j8ghMIh09fJ8hYt9LTGhAaQjUM5mJRhfMSrwEe8LSV+XulvcfVxUXW
	 5M7/hp3J1pqJ5fmX7qlXEN0yJPmVX+xteZTJp+jKY4F+wReAFnyS/1UKiJ+LkZe2MiIy7
	 AOqzUnm4mgsyNkVV/BR1ejXfj+R2kG4ce8+IjTBOZluGrtgMCqqqEAxiVYp3uzPRo9Jic
	 d/qI3uZK571kpwORRJe4+vtp8YQMDzPDCYfRtuVZYKT1b74Cx5OO9Vs2c9JExSPyKog==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795712256;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=DkEo0pB7r7hLBoz4ASCntD8fZTYJ5TXSxKQunftLimc=;
	b=QClE68Z+Uqhk9pn247mBpCQBvYTLb+Qozbbm4P3vTFtJspzKUv6qOm6WH2oce3WbEkP1
	 1tz/LfOUQ4zUi1uTepPz2OLhRTz6Mmp5ce6OI/vnN3/UleWYaQGN6WeEqK1w45ejVM3u1
	 ku5pWn64jOool8P3amt1iLAQ7hPDRS7b+R9d20lExz/41gANUDGRwQWtCbG/951Tfw8Y8
	 ETMlXDW3XJ4zYfnif0hvapxWkKjgCNw2pWqynSXei7AFZaeN5z8/nfPN7lWelFmSUkmFu
	 GDmW5sS194P+/zqLfnRDiIX6jwqL5N/nb8BobTqp3qyFIrAntgv1pGeS/TSBflOiP0g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JkPVIJtT;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.45
Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FBF3606A31E
	for <git@vger.kernel.org>; Thu, 26 Nov 2026 16:57:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0FBF3606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JkPVIJtT
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-67db8985419so8966425d50.1
        for <git@vger.kernel.org>; Thu, 26 Nov 2026 08:57:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795712255; cv=none;
        d=google.com; s=arc-20260327;
        b=N9/nw61axY23axfuxB41wNXIAo9k6yNiSSfYdwn+b4aHAxNi8xsGPEMWd57gDqGq5t
         p9QPUK29np6euKnfD9jXxMxnvAqovFhB759eNilq/Rrp53BwxjBtWOC53wjSN1b/4TX9
         orN8SycO7WBvw56F1Zo6scGGAq3OHrRmoIzpGhWUqVD9mIQJtuNZcDCCzif41GYfFwI5
         t9XDoj4xahwEkxfxS0AP3ObUnItL7YAFLrzs0UX+Uni+LvMZ2+p88Vv0KDA1nyoMfImF
         T+IwTc4Jb+1on7SAzOyDDwSypg8N8tBoxIHiAhiEgr6EZ6hIkGxaNm3NEkQG+xRJo/bp
         MCwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DkEo0pB7r7hLBoz4ASCntD8fZTYJ5TXSxKQunftLimc=;
        fh=zEQd+5l/OBjEyzF6GIR9zxz6BTrbCyvCTKJbHzWgHEc=;
        b=YvPld5K/lIHsqRRR+FPnAZH5VXwjpmuXL7dYhG0mk5FbatTmPjEHAIlm0mAlcK+az9
         MN0rwY1iHUZIyzuB5403RVlTfSZUnTBAP37RlKTL3Ri5mvZUk2zoHjRSYIdN5EGDYu5V
         begj2wJmKCOWO9QOaj5tUsIsKNG9qgplzu1cmOVFpvhHhkok3/fUEf5zIcKB1NirPx83
         hkqqOZOCxcBgtfl0qbv0Z0zdM/bxM/89isyUD3qaF6ZytZEpjNaLMB8grFA1oKSSPjL4
         fLbKFr8JVUoNdDorR5nvoy3xhRxLJudCVxzH4HGH69N0dPuFCMyC13NJ2AXzrAdso3iE
         dGSA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795712255; x=1796317055; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DkEo0pB7r7hLBoz4ASCntD8fZTYJ5TXSxKQunftLimc=;
        b=JkPVIJtTiLNZlkxSiamliaqvsS8a4h8n+Rtx9AeRUbdqOZeWQ0O0afW9Mi6Fjw1QKF
         tF+uxfRfTonjeFoKzoYLg6zXs6MGXMcKPwiglP3dnIbPtGQ23TLih4canc2Yo5BBYJxg
         Zsw7sPNNRXxNM/L1xWwSyYia/NO7Q3RF3gOPynlL+qbwrkSgR+8z3u4Pn8Z8VQ/NCnYs
         Y7VLjhTjZfbpZKAnLcioj2VYm3fnCPmBckE6nqmjOWo9iVsDXLKyJoc4RA7bZX7eCJGW
         bWtN3kbxHexU5SAvm9bs+yxve+0wmqKYuB3kGBHsyDnG8hMvkeS9yjneol3EKbFNS8Q7
         zgrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795712255; x=1796317055;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DkEo0pB7r7hLBoz4ASCntD8fZTYJ5TXSxKQunftLimc=;
        b=dimfvifUuXSBkSqFrlZw0nzmkEwVNrlJgqXFyZpczxq4egxnkSJAD3mgNadnnciqUx
         gh5obLh22TeLUPBUiaybDiDjfeUZWtO8yex8zF5C/P8WLnbefY2SeRbsQI1fA7ppR2BK
         nqDIrD91Kn3AaTMt7SAF9jbMxsfHreb+nv01fQ6gXPz/pXljDbHZ9x9UlEY94uMBKdLi
         CGCVlPBtmNGGfESuOh73TyHDRdvD4/1HMSEUKJqaLMTG8vBIBSoXYlALgAVj10wLFYXX
         IwSEwK2ptrJQps8oxn8AVv1fpN2RSJbcb8MF0aXncCK7UpBov1f/yj3tFc7Vb4z8DwXe
         TZKA==
X-Gm-Message-State: APuU4Z8kZnpCyvWsh/uc13CFb9Uhe92KEyT9iF9q9+gJAQL6ebEOafcP
	ffCXK9D8I897fQ1HID3FrnYOWpM7KymWUxWyr3dWcWlxXud1blyul2C7STaDuFjkelDnY2AtSdw
	xHz/7clAaltGx5B4vLTnFMhXrVurs3OsZHpQpefDihg==
X-Gm-Gg: AZFdTZc/D+nzGUREE07ch21V6xXfj/nAaKMOMYisU6ZU8+0k+WDonK+UT1DUljGIYKA
	S3zAT0ZJDW1gdQw2OTdhL9ijjC0pasksEfoTY7RsjIpQiMf+xgg3cMY4kDHeyQ3x1/WXKYw0JNV
	UX3gB18iArcxyykrEMYwVewZnResOwND8PpGsOtOp3HwU2MWs+2zFUJGSqfdFmMQDcDfIAaj48a
	0Wfbloerd258KhrD1KiaDtVMhvAksmS9Pz62XngP6eG4rQM5ZnMcHHv1//p0rswSk2m3T2wYWT6
	wRvPoZdkStK7Ve9kpSMrc9xe+JnvLQZVbIFei/ZZdgcZx68h1+ssuI7wqXb0Rv2B3tZOCIqkY9z
	XXiPAumv0Yb/CPoe18ojPO/M970rZ9ytHDmY8LUPEkM6YR3waekovA6gzEkpKvsYCirqguY62xq
	1wwyvQdML/jR06CHwjW3A+cFW8NUEmHcYTpS8FlYFe7vkf/Vivshj06R2qaRHrhbfLIv8PDptXK
	lWqiKL4WcSl0XGHkdB5evx5d+1UhTR6g3ip0jQ=
X-Received: by 2002:a05:690e:128d:b0:67c:1bd8:179e with SMTP id
 956f58d0204a3-67df4518e56mr10508337d50.109.1795712254975; Thu, 26 Nov 2026
 08:57:34 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261124172146.18330-1-okhuomonajayi54@gmail.com>
 <20261125220214.35881-1-okhuomonajayi54@gmail.com> <20261125220214.35881-2-okhuomonajayi54@gmail.com>
 <xmqqh5h4s3j1.fsf@gitster.g>
In-Reply-To: <xmqqh5h4s3j1.fsf@gitster.g>
From: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
Date: Thu, 26 Nov 2026 17:57:22 +0100
X-Gm-Features: Aa3M54qePnx5cWqra3iCJp3-b7J3RamHkC7eR-Ca4hNgPL1d3QSv69je_qjQOSI
Message-ID: <CAFpMFfCpLdbLB0fs_vtgGgTcHsiga+_scmBYtYt+7cN-PZxLFg@mail.gmail.com>
Subject: Re: [PATCH v5 1/6] notes: add notes_tree_or_default()
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com, ps@pks.im, 
	usmanakinyemi202@gmail.com, siddharthasthana31@gmail.com, 
	kaartic.sivaraam@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Junio C Hamano <gitster@pobox.com> writes:

> At this point in the series, the initialization function is still called
> init_notes(), as the rename to notes_tree_init() happens in the next
> patch.

Right, I'll fix the message to refer to init_notes() at this step.

> I somehow thought you would leave assert() outside the helper, which
> might give us a better abstraction in the longer term, but I do not mind
> either way.

I kept the assert inside so every entry point shares the same
precondition in one place, but I take the point about the thinner
helper. I'll leave as it is for now unless you'd prefer it split out.

Thanks.


On Thu, Nov 26, 2026 at 3:57=E2=80=AFAM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Okhuomon Ajayi <okhuomonajayi54@gmail.com> writes:
>
> > Several notes entry points repeat the same check: a NULL tree
> > means the default notes tree, and the tree must already be
> > initialized.
> >
> > Use one helper for that check. notes_tree_init() asserts that
> > the tree is not yet initialized, free_notes() only frees what is
> > there, and format_note() initializes the tree when it is not, so
> > those three keep their own checks.
>
> At this point in the series, the initialization function is still called
> init_notes(), as the rename to notes_tree_init() happens in the next
> patch.
>
> > diff --git a/notes.c b/notes.c
> > index ec9c2cb150..a73a51e1a0 100644
> > --- a/notes.c
> > +++ b/notes.c
> > @@ -1140,14 +1140,20 @@ void load_display_notes(struct display_notes_op=
t *opt)
> >       string_list_clear(&display_notes_refs, 0);
> >  }
> >
> > +static struct notes_tree *notes_tree_or_default(struct notes_tree *t)
> > +{
> > +     if (!t)
> > +             t =3D &default_notes_tree;
> > +     assert(t->initialized);
> > +     return t;
> > +}
> > +
> >  int add_note(struct notes_tree *t, const struct object_id *object_oid,
> >               const struct object_id *note_oid, combine_notes_fn combin=
e_notes)
> >  {
> >       struct leaf_node *l;
> >
> > -     if (!t)
> > -             t =3D &default_notes_tree;
> > -     assert(t->initialized);
> > +     t =3D notes_tree_or_default(t);
>
> I somehow thought you would leave assert() outside the helper, which
> might give us a better abstraction in the longer term, but I do not mind
> either way.
>
> As a way to prepare for making copy_note() safer in a later step,
> keeping this step a pure refactoring makes sense.
