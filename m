Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8CF438A702
	for <git@vger.kernel.org>; Fri, 11 Sep 2026 23:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789170450; cv=pass; b=D3U3KV44TkwoL2vWiHpKgXAyVzNc1D59TBlXG3DR/E8XPW+n5v4Ya/qaQi34YdoTMT1bMF9yu5nudQSPirZzEDnomUdTsmpP/qeLQpmezoOg9zKLzH2fpO3yXLLUdQ45f2ZdcxtjV7HJ4sjl1mSLZZ5XaU1NrwYUrjdFOCzQZ6s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789170450; c=relaxed/simple;
	bh=dji3XmCB5+m9UvZbb6SpnoqPhuYkuNA0ZVTEE3Ck/mE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UZKH3u1WtzvwfSxvR4fRot44LzHwOUiDpzy4I0VvYKqvY9r31P/dgRw4/5gHw8oUuuSUmT2iQq7tbUd88axlzid09IC2cUaCPvQ+w3j0vsantuutx4CD/974Q7vZr5GGaP6YkbVA5tq3FyaRaU5tp60OjCo+NVyDPwl9ABEtQik=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tylercipriani.com; spf=none smtp.mailfrom=tylercipriani.com; dkim=pass (2048-bit key) header.d=tylercipriani-com.20251104.gappssmtp.com header.i=@tylercipriani-com.20251104.gappssmtp.com header.b=ggZU9rWn; arc=pass smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tylercipriani.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=tylercipriani.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tylercipriani-com.20251104.gappssmtp.com header.i=@tylercipriani-com.20251104.gappssmtp.com header.b="ggZU9rWn"
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-6b34face6d0so668679eaf.0
        for <git@vger.kernel.org>; Fri, 11 Sep 2026 16:47:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789170446; cv=none;
        d=google.com; s=arc-20260327;
        b=euqFqCwdRVLe2soBJxjftLSl/8u7ewF1fIKppqU4CYxij0Jfq+fJeJTntOqd8NyoUW
         qI+WjYFPlOgIQMa7UdHeQSDzlNJIokeEzUS0PEY+auylxPYo3n9ILJL+bKstSDa8B7T2
         CyMlyyuDVHNTRiWP0yic8e8mTi2zjGXROXb6K8Vz38hrOLm9JiB1KqJpuk5XA3HyA7ru
         Hs/Q/oYMAIh31SPqjyLbwkhabq2vitdHXxlVD1m5p75G2uQiOBYeWeaRXEtl9qwOao2q
         P4MLkmEqBSgK8aQXjjx9lhNoVPOZxmaJCuXDjRxJ0Iig6hXIbkK180uOQO6gBEzV07SF
         YSKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SJ1t+lcUKDzixdwGmd+q4xQyyvxXv1Fu0WJrAZqYeYo=;
        fh=7on8cIw3NIZWw4JuZrn4//f1JrEE7LsGYupBvUWTs8g=;
        b=SG3QpVlFaPyAaGxOaXrwxliG+Ax3Invok3bekUpRD3k3eDM5VrxiU9peUm+Wz1GAuY
         maa8iJdCK9vzfAHnXDqRnK2UrZqvq1HwZH1eE6MlbquVl0X1nvlqwTrMn1Or0PsGKSLR
         N2OXysq8YrCOfdqRNHlx1eXv607fBqQU9zxNULMFkTWorbKB0LcSMLsaKWYYylEvtyw9
         1kVxBPTJOUI6DD2Wirg1ARFoxBd/S3t9H6EdSZ+ctgY042m21lMbh4VlEExmFZfXb4gW
         G3ZIiobdH5FNTFKqf1da0hEDXs4He8veCzIFnLnb82KxMelalVzxQ9N82gAJgPQvMwvy
         j+FA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tylercipriani-com.20251104.gappssmtp.com; s=20251104; t=1789170446; x=1789775246; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SJ1t+lcUKDzixdwGmd+q4xQyyvxXv1Fu0WJrAZqYeYo=;
        b=ggZU9rWnGdceZN9WAxvqjLzokdDwZ7SF2DcVaqwoAiwyFPa9xJJSEE61PZqaaQ8pJx
         urv88Ih9Vq/5fKSvTWC0K1f9hdcxF9rUc9KFNKObqbplFFzgEI4Obi7U/ZVQdBga0epT
         tlOn9W3MBlCebMlx+mkkMWhce3L66X1JoyUj4Dq2q9Rgqjd5kY3nMnANpLQ91ZZ9T83X
         boyr6BN5S24JdO2NAOu+v0Af4pxoimytpehLQqzz7ittyEHYvm421+ehIEDhd5h5yd/f
         o2rbmW+xugYMwztuGLIfrAq/zCfXHrKuwx9X6R5gttvZMDZ4Jw/0ZonoQUPpF/1Uuhvf
         gPgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789170446; x=1789775246;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SJ1t+lcUKDzixdwGmd+q4xQyyvxXv1Fu0WJrAZqYeYo=;
        b=QH31g+4Qy+oLOoaume8IbAD//c8XmS8BiTZEyqx7oF7ZPo0ED2m2b+UhRkEWAV2+fM
         e2s//GuxfMywbttcDhGv7B5y49zUQYVG/6MXe+ExbHZd1SFJkIym4K4+cULiEoLAm978
         k0ES6mp1qaOBLCsOWtgnOIphaytqxkLJ9NBOnHaPa4Escv4Fo17jTG404N8V6noZ+hf8
         AQ3xyxrrTVNeYY0+u25f7puGM3qw7Fuv3T2NHWI17ZT8I5je5w1XuueXn4LqCo4k5OpH
         02/lkFbdgxk7se/SNL8OJcdp0raslH7Rq+6peaYIRdiwcbIOYXfVyItoQm20rRLwzAi8
         hlgw==
X-Gm-Message-State: AFuF++kaTqhD6HT5jKozDuORc7jlFZt1XKRNDAAlV1KUu+Vi7O2FmAN2
	je+8A3rfUCgw0mA95gZIzJQZ8XuI12pVUKN3AagUuIwlgrhPgtPHNbyW+pl3rfYPtTqTZ7bziS3
	+9groc4Xoz73xrScT8EJ8EahS0cVT5IG/Mt9nU8OVSLpJ1X22orhkebMwTw==
X-Gm-Gg: AYBFou3nQZHpd2IBKDYre67iygyvczwBVMdf7Xd8XxRPC4OFIlbOuE2Sz3Z02WxsRtx
	MsVbyo7golbf5LXK/jKkUMzx256Bq62SZqPQI2r9sHNPGbC1k29cJhTXokrMmBkpjK17LNAl5eb
	zIxfjPEqsRIeAtVeDyrpQ+FAqoZhtKvl4sh/rfiGVzQr4T8jGpWGHEXX+K0zW5DsGTJgd1QGCvq
	PdB7wvClDNxDaFUzVKQRBzxKbf8FYMGbcS7WX3MOOWgi4mejT6pYcZZ3WMtz2jK8oQ39OXMFFVh
	RbIRaeTaaViJugboARS1cZNrihA9zdxYplZFIbWGJsDr5MrdfUBjeAc=
X-Received: by 2002:a05:6820:81d7:b0:6b1:9b72:213c with SMTP id
 006d021491bc7-6bf43d77c6amr5663531eaf.3.1789170445940; Fri, 11 Sep 2026
 16:47:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260904210122.431757-1-tyler@tylercipriani.com>
 <20260910230506.1631656-1-tyler@tylercipriani.com> <20260910230506.1631656-2-tyler@tylercipriani.com>
 <xmqq4ifverdh.fsf@gitster.g>
In-Reply-To: <xmqq4ifverdh.fsf@gitster.g>
From: Tyler Cipriani <tyler@tylercipriani.com>
Date: Fri, 11 Sep 2026 17:47:15 -0600
X-Gm-Features: AcwNN1VG4smcwpB15wqHrmVjbR3d9R8FEPBGmfcp_urRWtFwuex3WjgHDMMZ8uA
Message-ID: <CAHLx=Om0-2J2ibJT+VeX3eEYsmsjY20QQcV_sns==7qOKLN7DA@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] push: check pushed ref for --force-if-includes
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Srinidhi Kaushik <shrinidhi.kaushik@gmail.com>, 
	Stefan Haller <lists@haller-berlin.de>, "D . Ben Knoble" <ben.knoble@gmail.com>, 
	Phillip Wood <phillip.wood123@gmail.com>, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 11, 2026 at 9:31=E2=80=AFAM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Tyler Cipriani <tyler@tylercipriani.com> writes:
>
> >  static void check_if_includes_upstream(struct ref *remote)
> >  {
> > -     struct ref *local =3D get_local_ref(remote->name);
> > +     struct ref *local;
> > +     const char *name;
> > +     int flag;
> > +
> > +     if (!remote->peer_ref)
> > +             return;
>
> This function signals its displeasure by setting remote->unreachble
> to true, so any early return means it is OK to force the push, right?

That's true, for each ref that will be pushed. But this return does
not imply it's OK to force push; refs with no peer_ref are not part of
the push. The caller (apply_push_cas) walks every ref in remote_refs,
then this function gets called for each ref that has check_reachable,
regardless of whether it will later be pushed.

We could move this check to apply_push_cas to winnow what
check_if_includes_upstream is responsible for checking and make every
bare return mean "OK to force"; i.e., change apply_push_cas from:

if (ref->check_reachable)
    check_if_includes_upstream(ref);

to:

if (ref->peer_ref && ref->check_reachable)
    check_if_includes_upstream(ref);

And drop this return (and probably add a comment). I like that better.

> What is the significance of remote not having peer_ref?  Is it a
> usage error (i.e., push is not updating anything over there, and it
> makes me wonder what the command line to do so looks like)?  Is it a
> programming error (i.e., if we are pushing to update no remote ref,
> this function should never be called)?  If the latter, I wonder if
> BUG() is more appropriate.

This is an ordinary path vs. BUG(). For the command:

git --force-with-lease --force-if-includes origin main

apply_push_cas checks all advertised refs. If there's no peer_ref,
then remote.c's set_ref_status_for_push skips the ref before even
checking ref->unreachable. When I ran the coverage report, this guard
was hit regularly.

> > +     /* A deletion has no local history to check against. */
> > +     if (is_null_oid(&remote->peer_ref->new_oid))
> > +             return;
>
> The comment for this condition is clear.  If we are pushing to
> delete, checking if our side once used to build on top of theirs
> does not guarantee us anything, so we accept the loss of history.

Agreed.

> > +     name =3D remote->peer_ref->name;
> > +     if (!strcmp(name, "HEAD")) {
> > +             name =3D refs_resolve_ref_unsafe(get_main_ref_store(the_r=
epository),
> > +                                            "HEAD", 0, NULL, &flag);
> > +             if (!name || !(flag & REF_ISSYMREF)) {
> > +                     /* detached HEAD: no per-branch reflog to consult=
 */
> > +                     remote->unreachable =3D 1;
> > +                     return;
> > +             }
> > +     }
> > +
> > +     local =3D get_local_ref(name);
> >       if (!local)
> >               return;
>
> The same question here.

get_local_ref should not return null. And when I ran the coverage
report, this guard never ran. I'd be happy to remove it in v4.

> Are any of these silent "punt" returns tested below?  It does not
> seem to add a new test about pushing-to-delete.

There is an existing test for push-to-delete that this patch set kept.

> Thanks.

Thanks for the review!

Patrick suggested generalizing away from checking "HEAD" and I think
that's the right call. I'll try that, plus adding your feedback (plus
some additional detail in comments) in a v4.
