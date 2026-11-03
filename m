Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793702333;
	b=i33RqfMDdKz0aRWu0XRz1hqay7BEBlw246u8kxtUSOP+BisdBD/5tZQ6E8z8eD94PYil
	 4PiJjfpy9yAnQpWcvWcLfDqMQSphu3I6F0jrEY62P3udoua66znPUpD33VsmiFXr8qSXV
	 DNDrBU0ocztT7UjzHPoR4KGoWmPioEeiSOfcLOUc4VrPUHpKd98Ful3+WeYwEMF87tfd9
	 33dDVEOK97odKnU7nJJHMdMx6/poWVAFAQkAbk0eGphe53uEWD6525Y83yvP47BLkr4lt
	 ZpZgevT2A0wZJWGjLjdRvHnHwtt8+kEZsvyOql9mCDqbX1VFeYaLOGl6gMo4J7aHnHw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793702333;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=JrfNG6K8NRHtHGCcqkNUr+MITIlnNblDVBm9Rpq4Vnc=;
	b=CdZzh3iq7yGLeiWzn4JEY9biDP/clIFF01o2wWG14g34DoPBefTE7k9UP1sIqBLj+YHY
	 T0snemW78PanCaBB8XwkQpC2T+80SxaWBTnf4IFcIMikbbeBf5ro8JQzKW1t+TU27ZFbw
	 UMxf/PuhKm2mLAN+/r0jZIkVkCOpVxbf9/5w2a1Fw9tURyeutrUssMRo+CeYQYO4g/9Qb
	 7UFfIUsfKe5Z/MWLxqENyNetd+xwIAJiuRZA+g9FYajGZpWU0YWraerSXX5tmoFc7NWNm
	 kiqUTSEJQNXjpGtPEt4KJ4iSbpGjL2h1q4kt3RB+ApQb6K2+0/LNv5G3STKfRAPBkDQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=spotify.com;
	spf=pass smtp.mailfrom=spotify.com;
	dkim=pass header.d=spotify.com header.i=@spotify.com header.a=rsa-sha256 header.s=google header.b=X+bDHWsn;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.50
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A69BA6074A2C
	for <git@vger.kernel.org>; Tue,  3 Nov 2026 10:38:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A69BA6074A2C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=spotify.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=spotify.com header.i=@spotify.com header.a=rsa-sha256 header.s=google header.b=X+bDHWsn
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c450ab1483cso662186266b.3
        for <git@vger.kernel.org>; Tue, 03 Nov 2026 02:38:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793702331; cv=none;
        d=google.com; s=arc-20260327;
        b=YajpNSDXMAbAREMJDqQ7MS+Y0ckeeepRIbReAOBz3dyZzoaB9xzNry8zUjUvS1GNN7
         xU+i3cq1KZOuoRFgDpJl9D2sgTg/33LrRQWboIpM//hvj11gycIkEyOwLhCYybdNIWNo
         2tlxJhUXc76CnndoNTRERjwUYkXKCwyxv9oF9UGKJbAwXI4XtQ/lOkhdST7jdKpRYunQ
         npARNSeerUXd98K5uOlBUfUPSOb1D98kXvvKMBNZbZ27rdkW5vOlKhmNdzjcFstesjv0
         sledNpvXHuXCzyzXosizD4UqLYRWXQyl6whtXPktwHa1dtMWmbLqL7jsIUA+yRNEXC6Y
         S7AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=JrfNG6K8NRHtHGCcqkNUr+MITIlnNblDVBm9Rpq4Vnc=;
        fh=W/J1SiISQEApwmOXYgX7Q2J2cou0N6u/MkPSsuSB8Uo=;
        b=LRE/lbyVmy3GJkq5ElGPO6E7er0S8OAV6lob8uRX465oM3ZQ+MWFJwe7HKEoSaI9FN
         Myf6201Ty5SaXrjBRt0n9rk4LdtDHhC2Tz6/EN6FkWnbF5BTM4lqbnXr6DTEjJ3w9OmG
         X8oI5tdlgiZ4jzznP24G0ypyc146UL+Z9av6iEKbdBOjNeL51ivAUyA9E7qsmkHstsL3
         m6sixfvuwPFEyho6oksdUmA4YRtT70WVihal5O0wco1oLVjxzCaTLso36NRRAsltIMTT
         XsM5bOpvsOr4myKmX5v8Q/0ZmvFkTejhEg50/96Xc3AGEj3QgdMsjUdV3U0iBY5/z3VV
         IVIQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spotify.com; s=google; t=1793702331; x=1794307131; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JrfNG6K8NRHtHGCcqkNUr+MITIlnNblDVBm9Rpq4Vnc=;
        b=X+bDHWsnkGPmSE67E6asfQ2Xnsxs0dTTKa6DahOkGImfaHrOB3DwaYDjTNp0Tu4nvY
         Ec2o49CosAVO75wgcuCKSEEmzV2sgYVwnEylDzktkqYbxv9N/RkBfmbP+8isKnfVhD4/
         yIMHOkfddqvqHi/GE7NDrydzoeDMI1b/MkXuM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793702331; x=1794307131;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=JrfNG6K8NRHtHGCcqkNUr+MITIlnNblDVBm9Rpq4Vnc=;
        b=Cr+mg66pKgjwWUHaoKyBeiVQroFBrDG5SRKg1NG3fQrshYqCTlFktFhhovqeqyiJoK
         lq7cG2rkr5SwMhtscwsPNf5a+9igfkbCTetdVubl1+tHEqmVIYozH2Ql7Z1b8+xpbnLm
         5pHaH5ReXr1wyczGZ3Xr6PQkMtf4NG9JLRwZBS6ewbkPuNgQlLOn8p2fSK5hHTWneJCx
         9uD5oroRxkNtk365Lkr3oCZob74wcabsmVb5TAoxMSOg1N/upj7zqQg+LMqKfVMlDRQI
         ZFvtsXs+WFQkC9OyQjjiLRQH2QVHlrP3L3scxcT4Ab0WCKKJJQBBk+9M3LGWErVu0Q03
         mrfA==
X-Forwarded-Encrypted: i=1; AKwUvBxYphOv7vkfISQDEvWwQZgWLfzJ9VTZv7+ifqYQvnerWT673TA4oJ1VGLVhyrS29nPf2nc=@vger.kernel.org
X-Gm-Message-State: APuU4Z9EjY96kjUwERD8ylg/9nIGC8Q+c651nVaOfxHc6drHf6YcO1r2
	PxNvucRYD6olmNf8rIO15iq4g4K4yMMX0bD3NrejEEL9/aa3c/EQ6MVLNqnwyglkQrFHlbHFrUu
	TaEQjv0SbBcsumj31oXspi2Xfb9mP7At0wPcuyiadUg==
X-Gm-Gg: AYBFou11ZPzVZyRHvLFy3cTra2zcYfEscCmdAB9OUpm70QYI6QY5/CocWqhCY92WSmy
	cTk2CYP4GJFp5qLDO31wQqq+5ivch92e5ziUgnDfxw7EUnzjNLsYSs02CPG7bU5Vo5BKemaYUdp
	5GOojPF0TinEbqcsItur+JrNg0BAkR+T+R/9AJwuypmmB8j39a2yjYhXS3A3XFvSUdZE7VBNzh7
	QFtPIq+zikbS6YX6hSiFUudkMd40s/kg9gnR9StA70OrgdGNZFV28zzISckx8g9TnZQfIGjPxi9
	cdNnThONFVLhizn5o2iC/P7kOQ5IjR5uPpSyjcbsNyDztnSiuyyLpP586IKtlCq5i5OaoMuleiJ
	ZTVqgq3NTlLjTj8TmR6luuglkZin9czz32eyOIA==
X-Received: by 2002:a17:907:9811:b0:c25:2688:8212 with SMTP id
 a640c23a62f3a-c4ca74209fcmr1020151966b.0.1793702330937; Tue, 03 Nov 2026
 02:38:50 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <pull.2279.git.1793634429929.gitgitgadget@gmail.com> <aum0sTUAqc27DU_W@pks.im>
In-Reply-To: <aum0sTUAqc27DU_W@pks.im>
From: Kristofer Karlsson <krka@spotify.com>
Date: Tue, 3 Nov 2026 11:38:38 +0100
X-Gm-Features: AclHuK9onEzQAOkQZ0badC3AbH0a7aEDCndj3TeGXrqxfGD8pP11kMxDsjK1_gI
Message-ID: <CAL71e4M4qBJ6aHu-vr9Ex53LQsrpxjn9GRtkgNa8KSOSYWo4Lw@mail.gmail.com>
Subject: Re: [PATCH] rev-list: ignore replacements in the connectivity check
To: Patrick Steinhardt <ps@pks.im>
Cc: Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Christian Couder <christian.couder@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 3 Nov 2026 at 11:17, Patrick Steinhardt <ps@pks.im> wrote:
>
> On Mon, Nov 02, 2026 at 03:47:09PM +0000, Kristofer Karlsson via GitGitGadget wrote:
> [snip]
> > The t5413 test that expected the check to accept a commit whose
> > original tree is incomplete because a replacement is complete now
> > expects a rejection, and the test that disabled replacements
> > explicitly to get one is redundant.
>
> This here makes me pause a bit. Do we know whether this specific test
> was introduced intentionally to make a specific edge case work?

Both the t5413 test and tree-verify.c were introduced as part
of my (recent) incremental connectivity check series.  I
noticed the replacement "oddity" back then, but deliberately
kept the existing behavior -- changing the semantics should be
separate and intentional.

>
> > diff --git a/tree-verify.c b/tree-verify.c
> > index 25db76d30b..c228235150 100644
> > --- a/tree-verify.c
> > +++ b/tree-verify.c
> > @@ -133,7 +133,6 @@ static int verify_blob(struct repository *repo,
> >       vs->blobs_checked++;
> >       oi.typep = &type;
> >       if (odb_read_object_info_extended(repo->objects, oid, &oi,
> > -                                       OBJECT_INFO_LOOKUP_REPLACE |
> >                                         OBJECT_INFO_SKIP_FETCH_OBJECT)) {
> >               if (vs->exclude_promisor_objects &&
> >                   is_promisor_object(repo, oid))
> > @@ -163,7 +162,6 @@ static int read_tree_object(struct object_database *odb,
> >       oi.sizep = sizep;
> >       oi.contentp = bufp;
> >       if (odb_read_object_info_extended(odb, oid, &oi,
> > -                                       OBJECT_INFO_LOOKUP_REPLACE |
> >                                         OBJECT_INFO_SKIP_FETCH_OBJECT))
> >               *bufp = NULL;
> >       if (*bufp && type != OBJ_TREE) {
>
> Nit: this might have warranted a separate commit as it isn't even
> related to the connectivity check, is it? Did you also vet all the other
> sites that that verify objects?

tree-verify.c is only used by rev-list
--connectivity-check=incremental, so the flag removal is part
of the same change: without it, the incremental check would
still nominally ask for replacements while the process has them
disabled.  The behavior would be the same, but it would look
confusing (why ask for replacements if they are always globally
disabled when this path is reached?)

This patch is intentionally limited to the connectivity check.
I did review the other users of OBJECT_INFO_LOOKUP_REPLACE, but
none of them seem related to it.  Longer term it would be nice
if each caller stated whether it wants replacements, rather
than relying on the global switch, but that is a much larger
change.

One of them does look like a separate issue, though: mktree
checks that each entry exists, following replacements, but
writes the original oid into the tree, so a missing object can
pass the check without --missing if it has a replace ref.  That
could be looked at separately as a bugfix maybe?  I have not
looked into it more though.

Thanks,
Kristofer
