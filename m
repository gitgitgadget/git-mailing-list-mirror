Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE8DA3603D5
	for <git@vger.kernel.org>; Mon, 29 Jun 2026 23:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782775768; cv=pass; b=pWDnfI2JrewYFW9hpWM9lUVIRdNFAvYXNoPXMCsqJGzvWIIlFJJz3OPcKd52M2zIXI3+uASPgbsQ/kncdbSq8Z/zdvAeQwQn9OqLkMbozWuqcftnW6hGr2ODBoU7XjHlqKmaAVQmttywVYHpouPX0lbpH4kHi87YcgOE1cuQefM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782775768; c=relaxed/simple;
	bh=+QRtQLguYWZlFRV/qY7dRfj3bhICbE0s6ZmjXAGWC2s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VePApeN59xRBCwCPv06XlrCx+gj9X8jCGVaFyBt2/JGGGg9hLBBHoIPB2+WV9kLXLZ5e4LWkrTOudIZQXh+oOJUpHQc0qc873EHJ+FdeOlS+3ZZg42cMQNU48Wrs+WhhwH5iM8fdl5HqpOgKfmL0+N0WAaOXQqjINibr9TOrvFw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Iim15e3c; arc=pass smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Iim15e3c"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-80f602d8785so16998897b3.1
        for <git@vger.kernel.org>; Mon, 29 Jun 2026 16:29:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782775766; cv=none;
        d=google.com; s=arc-20260327;
        b=PdLPj9RM70J2y+ONxXaCmakLrdccAjgtQPwibnlGHlMR4qlLdwbhhg0LUCRerFvKQy
         EJpQ4vYlMA0mnmivkdXZaXpu5eezsIHQkNk9e6zb/fpPCwGqJ/Zp/Ez/Llgs65cwGJtE
         PDXYw13ruPx42N2T3pBFGbPdnFRGq9IgyPsJAGP0ip282tM1dsw6xXVUw1UGqhCA4bxF
         ORpbg5tvKhg4c8KKB0hEL4hh3wcW8iVOSiNIGDJmSeskx2oRHxC9CP78IRu27T6BOeeJ
         J89/8BBITyJKlv1jpTe8K0g8EuM8nYk/vReSpSWh1BYPP4Lvtu8ys9LetCkRaDl5sJQ2
         Wd+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Kmd7+YHwQs+JBRw9tziywhHkZ+rASEFUMc1HkPeHRJs=;
        fh=I6NP/4O7qhCLZXFq6sf6/84uPv00ZK3cR5OcoMIkJfc=;
        b=nsh9kXUbRrbmfkoLgwJp4Ln80CvxVl2N6Rlx/CemwXHmbUAcDbYOLISrpST8nATc66
         vHgAs915+bkM8ntvdM7BFSrUy0pJiw247vClLu0uM+QPuuFLYn0yoi/o2+TDX8poBXqI
         khAPAfw70wfDhkWwXvZEt16kjtowPz5ixMTIiC1s2eRpiCchy1duBHqOjcQVCwr05Bsn
         JBeL6Hz9KxVr3e0ycBqp1/hqSQcFDYmkUByYzKBZLZbVQZXKo9SzSMS9uxYvP8NjxYVN
         UUw2/rqsMG//yTySMyU6oTY4dA+P5FtvuF90Jl3i+D2TWj8lx/j3PWETnGW9rsxP8puv
         clzg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782775766; x=1783380566; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Kmd7+YHwQs+JBRw9tziywhHkZ+rASEFUMc1HkPeHRJs=;
        b=Iim15e3c/gsDkow1WOMieti7J31aflpYCPPcxd0e8xo+6W67WmrwfF1E/gaJnGJS+5
         q55t2Vvp+SzkLObpObN3xxY4qdMhDcUXlzvxmtwpvL8+EIfJ9A5F+uq91ZnKZr7uceVw
         qz/LAQ4LLvt9J/zAyuM356cNLEPKzTshLrpFzsnZfEf0+CydIUAiurcWtoWd92Mdd1ak
         zCzNpvGSa6zBGpFJUPtEqJOyt583v6Se9Q3MWuEtPqx+rim75HfFe/QtAxxMJB9FygMD
         wUUAtG4LhyuIq5sFXoVhPFhPVuVYdEYuCeag60zQgoV7T/L9WUt8MaH7j8xBdmWN8DHE
         bRmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782775766; x=1783380566;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Kmd7+YHwQs+JBRw9tziywhHkZ+rASEFUMc1HkPeHRJs=;
        b=T+n9WvU3cgTuWuQ1o2Bhjgl9Gy2wSQrn2Yn2/mpgU9VomWYyB+/m9nJMvdKhCqTgfO
         qJHgCCjOdtaANYvGV0rgHgzx0Jb0zx5j5t7Wx4U4f1jU17kn6qJn2ULdmK+G8AU3e5VE
         BaK6RERGd9KVSU4+79SHfDtrfMWT1B4s+2YUryXln1Qb3HeTzGyb+uheqpsnBvchoUEw
         RLi9hopB9nn5HYrdFjU0x9k53FLq87dE5ruji4/+eO4OaJBIoXvAhg25iIyOZo1hyyC+
         F/T3sD5hWos0XRqUFqnJfwnLAs66qzsyt3yleNPLAM/t4rKQWisFT9/aA90tWRdFhmTa
         n69g==
X-Forwarded-Encrypted: i=1; AHgh+RosONrn31ntg1nqGa7wk+rigTMfGgn6nyfoOwSLtA5gVPR/8z9989+Y6HnjmIkiKjUX3Dk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZy1oXasoxmQLxJgb4bCWIipNVCJA5dgUy9mSu3RQFB0Db8ncn
	u0pSAGfWmgjVB92c85ewt4UI6CFA9XmNb58XviylAt8gDUihFjrCmPeKVke4QP/b1LnIoM3huwn
	pVYuA7PLa9sLMa/sL8TkuFHaFwf6aXwjp1vR7
X-Gm-Gg: AfdE7cnSZDjktP8pK5Vkah5zTIchNm+p2KD9NOr8L7CUWce2tCVZR9b5fsKd1Ijicb7
	BNE5IblJ/fI+uniCwb0AHjar91rrNt1ZmtpvUBS5rZEwjXb/6wG6gjuwX6UQ68jaRZyAAe9rwq0
	wvQm2APKBxNvM5UQxBGWqIiqL1rhx3ynLpNjj7RmcEEnrKq/NqK981ilcS49nqKOO6flOZqa5xw
	z0tVEUIjmLtw9sIBJz3yIS+l4WItRLkjKqfvz0FSSK9D5//iALYslhQb8rxF0Za7j2tMfzgWVYg
	q+QjGhqPOfd/l36xgbFw4aolq+Nekvx/QAK+C7BzGRKPGM16U4Y4k0+XvdQkjFMmm9bJLF+vdHW
	rdq/m6HPg6pZQPCijwtOLBd4mM7QLVOa593g5Hf0VZqE2ikuLLNa5paieJbALHjMfkK5mSL1naY
	bsFCjJaw==
X-Received: by 2002:a05:690c:61c2:b0:80b:6160:38fc with SMTP id
 00721157ae682-810da505f24mr18917877b3.48.1782775765922; Mon, 29 Jun 2026
 16:29:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260613-ps-pre-commit-indent-v5-0-8d308efea63d@gmail.com>
 <20260620-ps-pre-commit-indent-v6-0-cdc6d8fd5fbc@gmail.com>
 <20260620-ps-pre-commit-indent-v6-2-cdc6d8fd5fbc@gmail.com>
 <CAL71e4OQ_kGb+UwHgikHG236-8BVtc7P9OdpV4i4UzYRCoPczw@mail.gmail.com> <xmqqechpt3i9.fsf@gitster.g>
In-Reply-To: <xmqqechpt3i9.fsf@gitster.g>
From: Pablo Sabater <pabloosabaterr@gmail.com>
Date: Tue, 30 Jun 2026 01:29:14 +0200
X-Gm-Features: AVVi8CdsrDOwRlr3_6vw1l2A9LQJ5KYXTKpso83u38EacRh0PzAu2jSDy7KBRBo
Message-ID: <CAN5EUNTQV68_eofa7BGb0BukMe=U2d4-FEVmJwW4dObQ2r6LuA@mail.gmail.com>
Subject: Re: [PATCH v6 2/3] revision: add peek functions for lookahead
To: Junio C Hamano <gitster@pobox.com>
Cc: Kristofer Karlsson <krka@spotify.com>, git@vger.kernel.org, ayu.chandekar@gmail.com, 
	chandrapratap3519@gmail.com, christian.couder@gmail.com, jltobler@gmail.com, 
	karthik.188@gmail.com, peff@peff.net, phillip.wood@dunelm.org.uk, 
	siddharthasthana31@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

El lun, 29 jun 2026 a las 23:56, Junio C Hamano (<gitster@pobox.com>) escri=
bi=C3=B3:
>
> Kristofer Karlsson <krka@spotify.com> writes:
>
> > The solution is to skip peeking entirely and instead call
> > get_revision_internal() to populate a small lookahead buffer -
> > it only needs two slots.
> >
> >     struct git_graph {
> >         // ...
> >         struct commit *lookahead[2];
> >         int lookahead_nr;
> >     }
> >
> >     while (revs->graph->lookahead_nr < 2) {
> >         struct commit *next =3D get_revision_internal(revs);
> >         if (!next)
> >             break;
> >         graph_push_lookahead(revs->graph, next);
> >     }
> >
> > After prototyping this locally, the three test_expect_failure
> > cases in t4218 went away (though I had to do some minor tweaks
> > to ensure it become fully deterministic by ticking the commit
> > timestamps.
> >
> > One subtlety worth mentioning: get_revision_internal() sets
> > SHOWN on commits, so lookahead commits are marked SHOWN before
> > graph_update() processes them. This makes graph_is_interesting()
> > think they are already displayed. The fix is a small check in
> > graph_is_interesting() that recognizes commits in the lookahead
> > buffer as interesting regardless of their SHOWN flag.
> >
> >     for (i =3D 0; i < graph->lookahead_nr; i++)
> >         if (graph->lookahead[i] =3D=3D commit)
> >             return 1;
> >     // other checks after this ...
> >
> > This approach ultimately removes the need for
> > revision_peek_next_commit() and revision_has_commits_after()
> > entirely - the graph code no longer needs to peek
> > at rev_info internals.
>
> Sorry I lost track, but I think the message I am responding to is
> one of the latest messages in the thread.  Whose court is the
> ball in right now?

Hi!

It's still mine :).
Sorry I haven't worked on this patch these last days, I tested this
morning what Kristofer told me to do, but I didn't finish it. I think
I'll have it by tomorrow.

So, the next step is a reroll from me.

>
> Thanks.
>

Thanks for the patience,
Pablo.
