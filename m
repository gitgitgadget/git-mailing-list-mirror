Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D46011E5B83
	for <git@vger.kernel.org>; Fri, 21 Mar 2025 18:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742581459; cv=none; b=p+BWrlLOPAjhJTGfxawfuNMIRMef8yyj/jlXXtOa3B/Lg9qoBVZxfZGxHt0UrLs+7Ign/Nliqox+Ah07zrOfUGS0+xeJqfunxpAtx00G51ms4UCa9ot1un//yA3wax1EDUam5ORDhmD48GunSM2x4p63q3biOTv/JoSlWRE04Bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742581459; c=relaxed/simple;
	bh=UlqsBl2ZpkS4PFmLqSrgQbKF9E2B2N9pTpcvbYzHzCU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qK4x6oYr6LIIOwySTjZVXtzAa8ygNL6sLfncmTqhuEXTZtQut3LBeJBKbsi7mxHEe3fQfiSzwCTGYfGV6ivaCB/eoHA8tVBGuJxriMz2TsxjBGWkA+NmbD5FkMrrgYpN0Amlkz5awlsDZW9SvNgjmvmFDG2TVTZyhcsmdC4qjEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lJ3eGhOu; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lJ3eGhOu"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-700b17551cdso21110827b3.0
        for <git@vger.kernel.org>; Fri, 21 Mar 2025 11:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742581456; x=1743186256; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+7D05iNBmDyo4u8rPNi6AznrMRiayZpCkRuIJq5lTVU=;
        b=lJ3eGhOusVdjgxnaQ15zarOw8WVy0IWJ4n5rT0dC159uzEID4HX/c0Qym0/uMEJGAG
         CFM/wDPWGMpKjn77VcfvWkUWazONOKTiVvSoGfBbcCHGsX1IzEZrZu+hKwXWwzWm6yJC
         joD+Dp8Xt4dS2VLYRvU07UTaraPNGRK8JNyfWjqdMOleHmWCYcqCrmjnJ78kQ/REJo4Z
         mlDk6G0fQPCXImAxSgMzrhFJnM8lZObFfiSsdg37jFJod/QjocuMDF/6OjQtV4Qcz6V0
         bIyaK2ob/kPZIUxbqxRxTNfAoC/qJmxXhGLJNicBRKUrcoxXhtWDnAiXQW7p13z3+MZb
         2jhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742581456; x=1743186256;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+7D05iNBmDyo4u8rPNi6AznrMRiayZpCkRuIJq5lTVU=;
        b=b59lcHGL8xQzsl1Vi9mTkSiXp/CrQ84oYNY25KTMWcfq35hWpGZcWChqvmidBGJSQa
         krVHuFvIbLA7mvjHybqod/rtIj25PQsh4FDkPlzmtaqChqkKK+pl5xTyCYU3yjNvS98L
         Kjd1M4DscK8FdAZ/3RbtLKmfI1xy3C0wrSKeACs0SojtmOBSIh/4Y/FeKj6d+e3jvVqp
         krw+KqqKDNYIqOonZ4BBamL1MlKdCHc9NKEb4/ZpoDLIyVIoHoT9tNm6VMazrxbo6nQi
         VKWZUajJIQ0y+Mrk8fK51/PHaRzlijdQNFRseFA9FVSF6YefyuH9Nv5qOIMyJhT1J5fn
         GBMA==
X-Gm-Message-State: AOJu0Yyk4g5ZuGS21aCUNUxdrQmDa1TYd7n9GRK/XAuUCmuXIVDjVOau
	xT4/Pk41QECUEqWBKy77KtEhX/32eQiCdL+FiU0HbTuMSmMM8SjpsGoDfzLAt753SsvSkQsXVUD
	EXk/4jfclWCVMJ0c2GfzH+4Gx7v0=
X-Gm-Gg: ASbGncuMJj9DGlW+5I5oVPDmNaA3yi63R5Lwr73vmYgSLUhdllSQdSuF+2OXHcduw2w
	sl4wz7hAfTm3qM2BVOYdUhmtra19Hurd9HtP0YgNrydeh0drtFjIhpaUYrXVP+TGz0jc69ADEbx
	kQiFYZxnfpDEbXmVm+g9lWTuwJSQ==
X-Google-Smtp-Source: AGHT+IF5v/nZKVWNGjhavbUX8NmdEgNVk4uelpnb4faiuPyziZTw2fieZDO0UruF0MzVwbob9WMVnrNFJdM+iHGBKjQ=
X-Received: by 2002:a05:690c:4d82:b0:6f2:96e7:8afc with SMTP id
 00721157ae682-700babed7a7mr60888297b3.3.1742581456516; Fri, 21 Mar 2025
 11:24:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240628190503.67389-1-eric.peijian@gmail.com>
 <20250221190451.12536-1-eric.peijian@gmail.com> <20250221190451.12536-9-eric.peijian@gmail.com>
 <20250224234720.GC729825@coredump.intra.peff.net> <CAN2LT1CsjA7V_y-OqDNREkpERHEBcx627JhCrzg9GHfWS=b0NA@mail.gmail.com>
 <20250313060250.GH94015@coredump.intra.peff.net>
In-Reply-To: <20250313060250.GH94015@coredump.intra.peff.net>
From: Peijian Ju <eric.peijian@gmail.com>
Date: Fri, 21 Mar 2025 14:24:05 -0400
X-Gm-Features: AQ5f1JoEVS07RpfHcccumuQea4XF-bGL6Wp5SxMMTbYCRcPo2L_qJUaH9DGIdD8
Message-ID: <CAN2LT1D3d=yMYVhBjpj5PvyjfTVjwqcFPNViuCJ=f49YbCZuJg@mail.gmail.com>
Subject: Re: [PATCH v11 8/8] cat-file: add remote-object-info to batch-command
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, calvinwan@google.com, jonathantanmy@google.com, 
	chriscool@tuxfamily.org, karthik.188@gmail.com, toon@iotcl.com, 
	jltobler@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 13, 2025 at 2:02=E2=80=AFAM Jeff King <peff@peff.net> wrote:
>
> On Tue, Mar 11, 2025 at 10:19:55PM -0400, Peijian Ju wrote:
>
> > > BTW, this strstr() isn't quite sufficient to prevent problems, as it
> > > would not find placeholders which _do_ exist but which aren't handled=
.
> > > One of the first things I tried was:
> > >
> > >   git cat-file --batch-command=3D'%(objecttype) %(objectsize)'
> > >
> > > and feeding it "remote-object-info /path/to/repo some-oid". And it
> > > segfaulted.
> > >
> > > -Peff
> >
> > Thank you, Peff. Yes, you are right. It is a bug. I am adding a new
> > logic in v12:
> > 1. Iterating on the `opt->format` to see if there are any unsupported
> > placeholders. If there is,  error with unspported placeholders.
> > 2. Adding more test cases to cover different formats, e.g., just
> > `%(objectsize)`, just `%(objectname)`, mixed usage of supported and
> > unsupported placeholders.
>
> Yes, though it would be nice for step 1 to avoid re-parsing the string.
> I think you could either:
>
>   1. After the mark_query pass in batch_objects(), check for unsupported
>      pointers in expand_data. The downside here is that you'd have to
>      match each one that you _don't_ allow (so if somebody adds a new
>      one and forgets to update your list, it wouldn't be caught).
>
>   2. In expand_atom() or expand_format(), check an allow-list using
>      is_atom(), when remote-mode is in use. The downside here is that I
>      think we'd eventually want to move that parsing and formatting to
>      the shared ref-filter API. But maybe that API could provide some
>      kind of "check that this atom is allowed" function pointer.
>

Thank you, Peff. I prefer option 2. Maintaining an allow-list of
supported placeholders seems more practical than tracking unsupported
ones with a disallow-list. This approach has the added benefit that
any newly added placeholders would automatically be treated as
unsupported until explicitly added to the allow-list, reducing the
chance of oversights.

> I do wonder if there might be a way to also just notice that we don't
> have the requested information and handle it gracefully. I didn't
> reproduce it again just now, but I'd guess the segfault is due to
> feeding garbage to type_name() in expand_atom().
>
> So maybe if we initialized expand_data fully (so that data->type is
> always OBJ_BAD or something) and then checked for a NULL return from
> type_name(), we could do something sensible in expand_atom(), like
> insert a blank string or similar. And then it is not an error to ask for
> %(objecttype), but you will just not get useful data for those entries.
> From the description of the protocol, it sounds like you could actually
> intermix remote and local object requests?
>
> -Peff

Thank you Peff. I like the idea "... it is not an error to ask for
%(objecttype), but you will just not get useful data for those
entries."

So if we do remote-object-info with format "%(objectname)
%(objectsize) %(objecttype) %(objectsize:disk)", the response can be:

4346b22767c07e31d0f9b524fcb377972d957313 199 ??? ???


Where ??? means the placeholder is not yet supported. In this way we
don't have to change the default format, and as new support for the
placeholders is added, ??? will be replaced by meaningful data.

About intermixing remote and local object requests, do you mean what
happens when remote-object-info is passed oids of objects that are
available locally instead of on a remote? If so, I have these
scenarios:

1. An object is on remote but not on local. This is what
`remote-object-info` primarily focuses on: we retrieve info from
remote without downloading the object.
2. An object is on remote as well as on local. I think
`remote-object-info` should still retrieve info from remote instead of
checking local data. After all, if the user knows the object is on
local, they can use the `info` command. If remote-object-info is used,
it means we are interested in the information stored on the remote.
3. An object is not on remote, but only on local. I think
remote-object-info should fail in this case, since the remote doesn't
have the object. The info command should be used in this case.
