Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795589113;
	b=JWzcTTg8W91lo9aZRSHE/H3bMOroWo2NJvUHfzn+j+wtaM1hmnQqe6MDYv0qJKyjVR7P
	 jLo96nq4TsXbcED7slUymqAlowl3itDUfe2vKCZsjbDu5rGUbxByUXExG8TsU9PATFiD0
	 wZ6HJsEu9EJNYXoTGbuJCcGK637FMju18MLw1UdchfSAzJNmSotcTo2tXUK0mOQUd12gs
	 Vk2yMYj0TRsVQ9uXA2X7Dp079DrdHXGh5+BXlMWF+m0n55atoWzhoCJ5X4FLNosC2Ng5a
	 eupIq6rtnu4u5P3XeIubhaVHT0llhMr/BXj1PwAaTX7CxBH0VQ+qQCm+xaFhIRSQFIA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795589113;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=EVkKq4vKGZFEsMEj4p5LGUx2WPPpsLwLUIgokwy/1WA=;
	b=19MbmgMHbxctZY0oNYy2PQpCh6ADP2r/mSPi6hFHKHu/RPrJis8lG6HAudGBH8a1a2LG
	 C4g/nVl1U0IrKFPLAsSF0SKwL8Xj2LaPfv/tkYc7UwLJxV0KbRWQOmjCV24xvNtOC+9Zu
	 tutXtg7JnQ5SD4pAiptZ4IKNbN3F3WlUsPrlCwH6cmDQxZvISFbnbth9VPo13s0+lmW9m
	 Mu4XnyA1JOakSSddf2w1PcpsA5SZaAUDWNKMcFv8glhAjJIQfqeuk2/PBLDH71rbTrHnH
	 hcYSUw7rgYesR7dE9GkeXJKvTn5xOg0cyeT0gGuXwbkw2wbrtpK0KmdwjzSEPnGAPhQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=D7kGivWg;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.43
Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B253606A337
	for <git@vger.kernel.org>; Wed, 25 Nov 2026 06:45:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1B253606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=D7kGivWg
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-67db0791748so6178464d50.1
        for <git@vger.kernel.org>; Tue, 24 Nov 2026 22:45:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795589112; cv=none;
        d=google.com; s=arc-20260327;
        b=P9BXmkmGF5nPqa5FBSJWucZ8mhIPei4ztjowD9QKAJ2hwvkV/XDE+s23VCpCjdEVdE
         78lWvV+m7PlJyWA6G186fPSsTV7xn9ormTleb3L19eAxLmpTpVQ2eZGfBze9/Nv2ko1S
         1m/2DYN0ohMjQIDGI1uGbd1CNvijBsfYUnccUXDKMTDiT6wUKQhzBsTlVPU2runvaNXx
         Chck9uHJEmUfd37pR/ja9pXqOne6cdB5DLwNUInndwHfcARMJfZAIxxvflvzgZRYu6yI
         00QQ9FVlzSxmqDL1FZ8G/FpU7xL4swSsBEHF7B7In/Nk39EmJ5hShmuPGIoH2q9myTKZ
         ghsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=EVkKq4vKGZFEsMEj4p5LGUx2WPPpsLwLUIgokwy/1WA=;
        fh=zEQd+5l/OBjEyzF6GIR9zxz6BTrbCyvCTKJbHzWgHEc=;
        b=EZiKUbISSSNZr/mz5WxFgUUiIZfdR4nPxcLmB5rLSnuNYpXzcQk4Zf/LJMHXbNltHv
         G9jnjlihn01JVdzpnL1QgSLfaGlJYncv+wadF3MwOQaxcFpIhF+eqWZe3OjS7J09k683
         CwLAz8lBd/iAtAIv+eJa+4D3vaOusd+GnbFWq5gfFF3t/N3SMQbx/fRqi9nu4+RmBKT0
         F5KcE8a2me2oYhqsCeFRmEemgnf+JRk792h4gug5WnkXSR9jXuZEkSD3rlhUHl0fvKQa
         o63BSA+9bQGKJbL44CKVvGhr3qPVnjQOqc599X1rQnqQtxkdkUznrEHZrg96R0vBbgVN
         XTPw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795589112; x=1796193912; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=EVkKq4vKGZFEsMEj4p5LGUx2WPPpsLwLUIgokwy/1WA=;
        b=D7kGivWgwUr29i62wrNu/E9X678An0ufMTcZuUB2wGurXVlh2N0BwXtU0EKOeIBMjt
         G84aq76B0nneDwNFUi8jlgX7T4Q7Q2SUZR3mY193AscJClC9BgNiWdhktHHCNlWj5JL2
         CWyb3GirENtSZoG4lom2cwardt7b7us0hKJ0a4+D10tRNNKRoUs2vxDEj8taMzDmcast
         SXJVldolyjZt6I+66ibanH2VfYNct/3a0uihC8m+dNJDULzKAMz5uaOazJsqbgPsSuTd
         LIaOf1qZ9+XdekPV/ULHxMPvm/TcVj96KHGD5HEnmodAm829+VW68MC3nvbOkDQfIY4x
         O8ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795589112; x=1796193912;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EVkKq4vKGZFEsMEj4p5LGUx2WPPpsLwLUIgokwy/1WA=;
        b=b202s6Zg+Xbq/abpj77UCX0wM/4ROGG6VgcLHtLFaMxfiaUMbmJtADFpeIMak6yL9j
         eOcD1pdJKYUG1GMg5OT42hpcA9mGcsHf0v6mT4NqgSzMLdhPVefl+m3MLhDPhv2JA0yX
         7NUVMDSZqNq8UPppBhp+wsjNtppA8ZWELXY+Ctdjt3DHcyx4pyQ2phBYTMSZXAg25mYZ
         M4zv4qdPdqwkZX89ng8Hkfs0QOwkLqTMv6wQjpvAxIoVMJUwKqmUh2wtVoKlc35vCTOy
         0Ax7FW4lQZghV7JU2klhJjC9l+7WF+LUhmZqTWjv7/aKT4HHSvnPNr414Nj10V9uW9wc
         7vNw==
X-Gm-Message-State: APuU4Z8am13F+JsS9tToI+jJNPYUlY46irncQbohsUt5x7/s3OOtaeAV
	2TwQkD6LFE4oQA7OCzJkyxtCOM9NyfoUvUC84NrkD7wjW9yLM90R8KS1JNm06riRAEuRFzC9RE8
	VbTsu5PETT6g26hUiiz1dLfHdUKwjf/E=
X-Gm-Gg: AZFdTZf19j1M55M4soUi3/BF1Lvsxt9ztXSLObtMC7YXwMCzGn4L72D+xCk+k8RTVLf
	YQhrmcEnrwmBMIcYrQKrgH8pufiXtEZ/ZqkmDvJyo9aFchnnhtEqmBJFlicsgAdhwgYL3CZB88P
	Ez6YWwXhC7WPwejErXdSJlrwazI5dSghtD4w6vxBPS6XyIzpSYp/zMwLeyBzJr0dr83Z37gwUGv
	l0cllP1OOCchlUgapuRQ90bnTPtjbygtyen7MyAeJMv/1lf2KKv+T1UG856Lo6JJetG7qjJpaBH
	fdbq/soKnF72LxAJ7uhvYxfTONYa91rnLCWrybH8WavWN9jBPjHyNSf3xg14ga9gWqr7x42DLYM
	mo6ScVZH79/B6XVRm75zH19b6b+2yemGNNpqRakQdsjafg0jHn+ofq1JzgJgKO4eVgP/2sjXzYg
	HUE1y73/dW7f8bwXrvPg/r4x/GrHgFZkkuobC8IR5nr4nT/Km/up38U9aBXpmUkX6HJDrxXUOVV
	5VR+sJy+4+yUPN0XgESKGq2eVtakaIrmrSGjOo3
X-Received: by 2002:a05:690e:1c1c:b0:67c:1dca:7e0 with SMTP id
 956f58d0204a3-67e03cff709mr5362425d50.14.1795589112169; Tue, 24 Nov 2026
 22:45:12 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261105203344.48513-1-okhuomonajayi54@gmail.com>
 <20261124172146.18330-1-okhuomonajayi54@gmail.com> <20261124172146.18330-3-okhuomonajayi54@gmail.com>
 <xmqqtsl5g28h.fsf@gitster.g>
In-Reply-To: <xmqqtsl5g28h.fsf@gitster.g>
From: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
Date: Wed, 25 Nov 2026 07:45:01 +0100
X-Gm-Features: Aa3M54rehO0dckVEFGrMobb0-lROvlE3O_hgx5PEC7yf409wx66ZBfECwJB2jmI
Message-ID: <CAFpMFfDnfJRt1HGx60esEeC-spfBbr4KKzp9ocLFceAMESx1yg@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] notes: use the tree's repository when reading notes
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com, ps@pks.im, 
	usmanakinyemi202@gmail.com, siddharthasthana31@gmail.com, 
	kaartic.sivaraam@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 24, 2026 at 1:34 AM Junio C Hamano <gitster@pobox.com> wrote:
> But others? note_tree_find() calls note_tree_search() which by itself
> does not touch 't' at all [...] The conversion in this step would cause
> them to dereference t->repo without checking if t is not NULL or
> t->initialized [...]

note_tree_find() has a single caller, get_note(). It replaces a NULL 't'
with &default_notes_tree and asserts t->initialized before passing
t->root down, so 't' is already non-NULL and initialized by the time we
read t->repo. note_tree_search() not touching 't' doesn't matter here,
since get_note() has already dereferenced it.

The other functions this patch converts are safe too, for slightly
different reasons: remove_note() and format_note() guard a NULL 't'
themselves, and add_non_note() and load_subtree() are only reached from
init_notes() (and load_subtree()'s own recursion), where 't' is the tree
being initialized and so is never NULL. So I believe this step is safe
as it stands.

Okhuomon

On Wed, Nov 25, 2026 at 1:54=E2=80=AFAM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Okhuomon Ajayi <okhuomonajayi54@gmail.com> writes:
>
> > note_tree_find(), add_non_note(), load_subtree(), remove_note()
> > and format_note() already have the notes tree, but still read
> > objects and hash algorithms from the_repository.
> >
> > Read them from t->repo, the repository stored on the tree.
>
> Hmph.
>
> Some of these functions like remove_note() and prune_notes() use
> default_notes_tree as a stand-in when NULL is passed to 't', and they
> also assert t->initialized before accessing t->repo.  So it should be
> safe to convert them to access t->repo instead of the_repository.
>
> But others?  note_tree_find() calls note_tree_search() which by itself
> does not touch 't' at all as far as I can tell (which means 't' can
> safely be NULL for notes_tree_search() because it does not dereference
> it to access t->repo).  The conversion in this step would cause them to
> dereference t->repo without checking if t is not NULL or t->initialized
> member.  If they are already dereferencing t in the existing code and
> assuming t is initialized, then this conversion is safe.  Otherwise, I
> am not sure if a mechanical the_repository -> t->repo replacement is
> good here.
>
