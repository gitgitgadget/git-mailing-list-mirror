Received: from mail-vs2-f41.google.com (mail-vs2-f41.google.com [74.125.227.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BDDB3DB332
	for <git@vger.kernel.org>; Tue, 15 Sep 2026 21:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789506231; cv=pass; b=ThB7pQtsG+0UYZmuk+AJmrTDC6YeD1QMNz+q8ecugb6XNjgtHWJD9qrHbrAkfeHXplMhrFVOzjfUwv9N0MijNu38GzydM0DzygnBSyQtaf/44vyofqesMij6kgaAu3iLs2d7evbrJki8sLhEWNfC3I/k2CjDeZ0F6xkS5BzAOfI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789506231; c=relaxed/simple;
	bh=zEZC6pL7adrplriqzgEY0BTbxav+ztdlZI+LI2+DJBw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X+KvgBromKnvNAZQYrlxVD1gjJj4z/Bfb+0tZEeoN1lIlsXHRGRGtTQcFDPAyR8rbuD6oHu94M6xRY8s6LWR4mIRPaa0Nc3uvZ46CLBp2OnJrRqaWiqifNiydBQlrMSLoNwlrPX3U6kj06EKmTTRY968KVjlllu+2pjYd1sDGm0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JU8YXuJv; arc=pass smtp.client-ip=74.125.227.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JU8YXuJv"
Received: by mail-vs2-f41.google.com with SMTP id 71dfb90a1353d-5c9031e714dso95457e0c.3
        for <git@vger.kernel.org>; Tue, 15 Sep 2026 14:03:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789506225; cv=none;
        d=google.com; s=arc-20260327;
        b=GJqszwR2Me7ODMVLDmPkRjzUtozhRf24trM09j3Ep2eO4LHlFGpqwuSebqqjqTk16k
         qj5q0OFvTuiFhnO/IBpqFySSn5QwF/c5Zjb7q5aVtI99Vb88nGR0u273GD8MfPsf8/b3
         UvqQ74QySbAOw30RQftHBmqe5OxZZ5u+slxvMEGiVGQSogZO3o0ZNPzSnZcYKdqmWMiT
         RwzrxGaWTLivXTugTzx3B4CcHxeLl7bpfXQ2s53A4SUIYEuBmw4WWFu1Tuxnp9+KBrkz
         qsGjMrNV2kO9AHfIcNidY3EPE4Aoh8raP15tNbHZFcL5cKJ3PhWRGTXRSeEcFCIzGU/X
         3TLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=grM/eiAIKsbO6PMhahSUEmNQP0hcLOZNy/rKBvn3ZKI=;
        fh=1/3dtt18tXnIvB8syWQ2wTvDn6umrk66dlnjmb+I9bo=;
        b=jiK8tr/WOr6+QxaUydLDx2G1SXiNJQlV5K11qeeGchehWMnOXuX5OWa9apiVTFcYnP
         TWYkzCv8ZzZ3RwXQ/64aWYJ2wtrn2iVKf836+EdBontt/SAS+yWMZ7mamL5vApv8WcSB
         DhgvjGGLoEAhpDVKwSShn2AHHM0OTfj98laLXk1yC/JoIF3C5NcqQTkFnQrdH16CLPfQ
         mpasU0c7EuvpmBVh9+JI0MBdU6V0frWTm7RFmwvyd8lMoK7+xmKahryZPDZirDBcsEYz
         d1Q0nQ8KPxArBwnm04LTEjAFWNHn7/yZ50Uy2lomdGXrYCD6AF6Dbqskj2rX0dDfBUZz
         x6sQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789506225; x=1790111025; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=grM/eiAIKsbO6PMhahSUEmNQP0hcLOZNy/rKBvn3ZKI=;
        b=JU8YXuJvehZ9wk0O0XhpSzy5bCShs6RE1xtNb8LL/n99MeTlFf5x0V5kkobIAncpbJ
         GIBwWZVfda98RUbA83+RmhR4QKdbUVrQndenwCHq8JNv+HmxOEELoznkTauSDt3ks9F3
         LKAYA/qdGJ/RdRF1eOydciqj0imr2bDnzAHWLBh0JtISn2axw9f4j/vPvOr4Yaa1geoo
         G+cT7G0BzLFbIbSFFAJf5BLv3CkFOQNahx5ep3P9kzmR48IWScZHi08rc0G9LUJvQf8r
         Y1qZ8kzRWX0a5fd5xVy1L2nv7lTqsM5nAo4s5YmBEEHNxawCiy1lg3VRzwRGKyFs6UL+
         6GJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789506225; x=1790111025;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=grM/eiAIKsbO6PMhahSUEmNQP0hcLOZNy/rKBvn3ZKI=;
        b=lfvbgHLxDdjk/JqewXh/yMfnbeaQXzzF8OVfz03D1uWb0jcNlbDOtBkw/UBiZ16uIz
         8qtK0qeMGsnBinZtWCYpiNrpqxCGMOCWcTDoFMIMbFkk+u0BiO6pcJcFYKqo0bJHQdkg
         QGHb0Id8j06m1+ddgvJqSjsXTYxVsvicvzzlZNeZfTL9s8/xneN37n0oMw8k6lkeIfji
         SJJAV8PBSp8GMDJQuhfLPDd0DEs7msifJ1Q4Zdwbru4DjGebVLfBQucNRd5lYXqAmHZD
         z1vHRiRn/klI0JTts2YD7fMxfGduvVvSmURz/7pjg7yTLsDboSjiseBZO7RzxxBZPQ5x
         5vyQ==
X-Gm-Message-State: AFuF++kN4CgNk7Dqb/HXWoXQvMHJUfec9HB/Bb8vl14Jix95GxpBFByp
	qleXyzMegwMUwLJeMeqA22oqSkHAQNcjGjeJVOFVul5zvgLvxAFcVeF5b84yUr6E6DqA4rn1fR6
	uVYZaAlwV3/NSIMMOa/jZltDjFCZ8r6Q=
X-Gm-Gg: AYBFou2/XCIDPMPD6PF6BkCLSKocKNpRBPH8qJLtwBykPZZRU0PvU5uaACF9VBs4J+1
	eLSDPxLDBPt70KKvgSohWXq6izDEC55gpju+BwQ3sl3rKWyH9HH4JmeBCgP53iRQPmClTaZ8Qn2
	SYyTMgoGV9gNiFKt0DD45t9pXw3SYtjG0Ys2nGw8LCeMIJnUXE6xy/tyGo1Z43ZDCPcsL/FHhRr
	HLY1uXXpLiObIf4QKwS+A8qVIQTCqRN3nU8XRfxBzhnIkHH60KXknOZAGK4lewMgS4UIF9vzbJd
	aSBbvt0moHL42kcFNVGZD/46UtdMuXc+tXbRaKf2m3tFTieao5NO5AE=
X-Received: by 2002:a05:6122:30d3:b0:5bd:81fc:ebe9 with SMTP id
 71dfb90a1353d-5c99a9b020bmr99499e0c.0.1789506224879; Tue, 15 Sep 2026
 14:03:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260915193009.222678-1-royceremer@gmail.com> <xmqqa4piz3pn.fsf@gitster.g>
 <xmqq1pauz2ru.fsf@gitster.g>
In-Reply-To: <xmqq1pauz2ru.fsf@gitster.g>
From: Royce Gerard Remer <royceremer@gmail.com>
Date: Tue, 15 Sep 2026 14:03:33 -0700
X-Gm-Features: AcwNN1W9KU9-OCtAvDjDni6-b9lgtOb-PN_eWDueJW7ElKuWXLGLVj_RdbFQeaw
Message-ID: <CAH5QBqzG2BQMotUmwrzUc-m6oXE9C1LZPtRyeFQsCBbcMNppbQ@mail.gmail.com>
Subject: Re: [PATCH] [PATCH] Fix upload_pack_v2 response ordering for shallow
 fetch when server has uploadpack.allowRefInWant=true
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Apologies, clearly struggling with using git send-email for the first
time (and thank you for the reply). Here's the missing context from my
cover:

On my fleet of git severs (running Gitea, although it just shells out
to the git cli and uses this client verbatim), I enabled this in the
upload-pack config:
uploadpack.allowRefInWant=3Dtrue

Clients performing fetches and clones all worked as normal unless they
attempted a clone with the --depth parameter, where the client would
get this error:
fatal: expected 'packfile', received 'shallow-info'

Looking at Documentation/gitprotocol-v2.adoc, it seems like when this
feature was added, the ordering was just incorrect server-side. You
wouldn't notice unless:
1) the server enabled the config above (I suspect it's not a heavily
used feature in the wild)
2) the client performed a fetch operation with --depth

That's what the new test cases in t/t5703-upload-pack-ref-in-want.sh
are, those were written to prove the failure before the fix. I've been
running this in my dev fleet of servers for a day now, trying various
combinations of clone, with/without --depth, and fetches with
--unshallow-since . This is purely server-side to honor the existing
documented contract when these two features are in use together.

> If a new version of "git upload-pack" suddenly swapped the order of
them, would it break existing "git fetch" and "git clone"?

I think this is a question about backwards-compatibility? This
combination of features appears to have never worked, so clients which
were receiving failures would no longer. If servers were previously
configured to advertise allowRefInWant, clients could not have shallow
cloned. If they did not have this feature configured, shallow clones
would work the same way (the ordering of packets is unchanged).


On Tue, Sep 15, 2026 at 1:19=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Junio C Hamano <gitster@pobox.com> writes:
>
> >> diff --git a/upload-pack.c b/upload-pack.c
> >> index a52856d869..a70d237ad3 100644
> >> --- a/upload-pack.c
> >> +++ b/upload-pack.c
> >> @@ -1812,8 +1812,8 @@ int upload_pack_v2(struct repository *r, struct =
packet_reader *request)
> >>                              state =3D UPLOAD_DONE;
> >>                      break;
> >>              case UPLOAD_SEND_PACK:
> >> -                    send_wanted_ref_info(&data);
> >>                      send_shallow_info(&data);
> >> +                    send_wanted_ref_info(&data);
> >>
> >>                      if (data.uri_protocols.nr) {
> >>                              create_pack_file(&data, &data.uri_protoco=
ls);
>
> I am merely guessing what your reasoning is, but is this meant to
> match this part of the code on the other side of the connection?
>
>                 case FETCH_GET_PACK:
>                         trace2_region_leave("fetch-pack",
>                                             "negotiation_v2",
>                                             the_repository);
>                         trace2_data_intmax("negotiation_v2", the_reposito=
ry,
>                                            "total_rounds", negotiation_ro=
und);
>                         /* Check for shallow-info section */
>                         if (process_section_header(&reader, "shallow-info=
", 1))
>                                 receive_shallow_info(args, &reader, shall=
ows, si);
>
>                         if (process_section_header(&reader, "wanted-refs"=
, 1))
>                                 receive_wanted_refs(&reader, sought, nr_s=
ought);
>
>
> These process_section_header() calls are made with the peek bit set,
> signaling that it is OK if the packet we are about to receive is not
> the one that is being checked, so what may happen is
>
>  - upload-pack gives wanted-ref info and then shallow-info.
>
>  - fetch-pack sees wanted-refs, notices that it is not shallow-info,
>    ignores it, and the next process_section_header() call does
>    notice it is wanted-refs and processes it.
>
> But then, who consumes the shallow-info?  Does fetch-pack notices
> shallow-info that it did not expect to see and crashes?  If so, that
> is a very noteworthy thing to say in the proposed log message.  If
> it does not crash and goes on but without utilizing what was carried
> in the shallow-info packet, the resulting behaviour of fetch-pack
> would be different from what we would expect, and if that is the
> case, that difference is a noteworthy thing to decribe in the
> proposed log message.
>
> Thanks.
>
