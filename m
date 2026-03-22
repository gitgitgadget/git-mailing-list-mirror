Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D41DE1E633C
	for <git@vger.kernel.org>; Sun, 22 Mar 2026 14:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774189279; cv=pass; b=j5EraLZoKGhmsVsBSUWgqgp9TPGvQz7C2BGoUm0qipW6g/QVCAd5pvsAovRKqT+Q0eaRpxI2crVvXHV49zVw4fP9/OsmBj9QnhDxd7nI8khc2t6b/roS9e0ZBPA0hujTWY4wsApusxwkJfSa1UTf04nM9V8BtORctliY9tW1hy0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774189279; c=relaxed/simple;
	bh=w45MuFcItWbdrM6vXFgsqUuWexcXsu+HNRWPU1pH6ts=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZzEtnhrGyIQZ8r6Eolpr7krUXIckUdCnZqsHMvTkn0toLbMGz7fSj+gVUPgPqGfOhEHm/6XJw8W26tydN3kAPQz+JOBetDyubzQo2Zg9ubsHS73EC5biDT+R5V7YlZ5YrLgdqSnMSodXF2NOr7jQwB+2Ai2ML2bK7XR6lm33jPw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dy+TNXJs; arc=pass smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dy+TNXJs"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-c6dd5b01e14so1159465a12.0
        for <git@vger.kernel.org>; Sun, 22 Mar 2026 07:21:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774189278; cv=none;
        d=google.com; s=arc-20240605;
        b=ORE23yljH7of6AD+WxvRs87QS381tfzIn5HGDEwq42Q+SsL3e7D/u20JUo1rPCL2HT
         XGCdjAjoxvS1Nn7Zy0wDoKz53Zeco4Rq11uJevzf/nxoqgVT8mfNXjeFVzMf78WYjQc6
         l/EM+tF2Sl3Qya9TsoU93tWWQC5OOPdSZcDvVQk5pHBztCE+3ZnGpqO+8y809mBIocFx
         YnPflL7BD88PSU/k/+zG2U/bznI6ZBnqDTNIhzyoVP6ltxtbS/ZkaPlUpYM4WvX9I+1/
         l1v1DxRJ+N8PouxhcOFmFfMDw0LFrpD/JYlpQVaDHUtJ66GkijC53MKfWx+YQ/AagTCO
         n0Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ILm7m6JRzq0yu+V1CPuvziNrvu66v0XxgbYiwnIe1OA=;
        fh=jrv706kHZ1PbHC7DODvLER2hn65uQoijSiU06XzQ4m8=;
        b=UvBnPJ0XwXQZuLXb2dcDkGwlZYh5AZj5BvWcYWUGpHH+RPfRkFZcVn/yRZflxhXM52
         bQUVsWklG4pLE3kLV+ISC9MwunlgSWnuXEVRo29FrNRoWxYGZUQsBa92u78yyUznZhGZ
         L9WdlAbGX7zqayZaRo2/0zOH0ZbsmaqzqVs9P5+sLzWSTplIf9CP63mWnHMQRrxxOh7t
         V6ZcNH0Y4/lGQAqNAWkDZEYBnORN94Yj4dE6JRyBdcXxHwZBIOt4evpXL63gLxq0xm74
         C+EVvwcMkR0tsO5GHext4EBrPWEw1XXq6UT72qTK1OxyW7frGBhK46lwbXJvazuj0G2y
         oXrA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774189278; x=1774794078; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ILm7m6JRzq0yu+V1CPuvziNrvu66v0XxgbYiwnIe1OA=;
        b=dy+TNXJsPCGWl7d7xY82g6hciR2/zdlGBFpC1hgPtGSJHurEsgl0eXWQ140g2IqpV2
         mjc5FFWGBjs46Jc2f24Vy+DEYcZFnAw+c3Sj51vq1Au1LtQOOQgZDQR7w0IDUpVdoqNk
         J7PKm/hhG8u0EHrM52gSPh6WS0po+e8TspkSh46DduzD9Wu1mILLzBtp1Ws8dLsntHHp
         rXMJb65BXjco9LBhQS86A6q/KbgJzAjzfN9GSEiMVMvu9xJppmz6zUABbtLUc2sBFSlL
         g67S9xuUenI5VD3YEbgP8c6XdMsWehqIh20g849VA49UzgzKmVtgGoeXIvrrCcgrdZzp
         i0dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774189278; x=1774794078;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ILm7m6JRzq0yu+V1CPuvziNrvu66v0XxgbYiwnIe1OA=;
        b=h0T8auT1PiRYrAQ8rD+5IIs3QOsU9CayQWi7uXV28gGVPRCBQ6P/5FOZmcMrYaMDSJ
         N+scrPjoXspOAXUG86CcBzezeoHSQdHCGNv+p5nJJs1QMcBUPG6RmQWO/A5E+/JPew3/
         Iz+8wQW72MiiqN+V52SmepOlYWh9w8hryVjV3Cp1hftzYkxDH0Ue39gE1mMHwivTiD4C
         TRctY3Q4/ZIMap0++i7OgO+hgDKKb6Rp15CgvfqdDJyEvACDfR6qx10rt7ASAYS9z0jv
         uTK+1BvRCNz4Aynl3WDx7wzjGldmDNOmWcAQIWv8tudOb+sVhWOU/G5QeqFXOOXcfJLq
         0p0A==
X-Forwarded-Encrypted: i=1; AJvYcCVaeYfpWY2RLzffpCTaI16min6oG3N8am78GTYd6uMmjEoHvYwm9ci3aoLHyfRH+qTXtY8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyN6kFEjR+hF3GZuHgn3/d0ENtxuxWjo+aoctEg4MA2SLS2yzNg
	KpLYV6x7k+qG+f4jM/gJYbxRGEI4/Nbr++qXtpkkzqluO+i7a/ePlvS/WJsrQMaeHhWOR9+2/r4
	5WbmwLu0GalZ4X5bncLLXvfaXXlrlwk0HUg==
X-Gm-Gg: ATEYQzyubv+DPWU35YBIl1Gj+X5Ufma0600X2McC7laPz9Kvq4IhTfGBD5HfVZbCFJW
	4xYrDSkbeNF4mx/dh3oMs48zfKfzcBPe2C7ETX8EA3eqnN5koc4HDPglh6sbySObYBYRTIQjvjK
	ay0n66TKNfWOGPbXRg0RI0xzwYLpxtjMfQkGgE62iUHt25ONk9pOog7OR+vu77OstzreGNirmHS
	LoQ8EzZOsgHnV8jMyv8xsn6tDgl5JRhbFwgbcT2RvAdVGlUl26qWmV/49ZCHTbFxVoK1jg1dZ1X
	7BIaKT4pVcTEqkbSxW9WcMYLEewJBLdpiI+J2iBXqjLSWJDa51mNAY9o5vkv/8Qwc4yNVMDo2I3
	lrHUGyMyBh2aAeFHXQWPOjLgfXg==
X-Received: by 2002:a05:6a20:6a1c:b0:38d:ec8c:7e55 with SMTP id
 adf61e73a8af0-39bceb41cd4mr7881331637.32.1774189278119; Sun, 22 Mar 2026
 07:21:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260320114823.3151961-1-ysinghcin@gmail.com> <CALnO6CDnwYaAPhp67kaYWtV48ULjWAR6ks1khVXmSs1oWUbRDQ@mail.gmail.com>
 <98833ee0-4d63-4d72-9a0c-d668a421ece4@web.de>
In-Reply-To: <98833ee0-4d63-4d72-9a0c-d668a421ece4@web.de>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Sun, 22 Mar 2026 10:21:06 -0400
X-Gm-Features: AaiRm52__7NoY95lXae5WxVttcKGoICRIeqOJNLbgBEHQ1ySnrTxtWUOtiI3KAE
Message-ID: <CALnO6CB6RzTDy3=H2PzD339O6UaZ5GoEZZjK+3ihRABaDfv=VA@mail.gmail.com>
Subject: Re: [PATCH v1] path-walk: fix NULL pointer dereference in error message
To: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Cc: Yuvraj Singh Chauhan <ysinghcin@gmail.com>, git@vger.kernel.org, christian.couder@gmail.com, 
	stolee@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 20, 2026 at 2:54=E2=80=AFPM Ren=C3=A9 Scharfe <l.s.r@web.de> wr=
ote:
>
> On 3/20/26 4:16 PM, D. Ben Knoble wrote:
> >
> > When we compute "child" in either preceding branch using lookup_tree
> > or lookup_blob, we only return NULL if !quiet in the object_as_type
> > calls (assuming we hit the "else" case there, anyway). But quiet=3D=3D0=
 in
> > both callers along this path, so !quiet will be truthy and we'll
> > error() out there instead, never returning to add_tree_entries.
>
> error() just prints a message, it doesn't end the program.

Ah, thanks! The rest is probably moot then.

>
> > Since I didn't quickly come up with a reproduction, I can't quite
> > prove this, anyway. It's also possible my analysis is based on code
> > that has since changed (I happened to have a537e3e6e9 (Merge branch
> > 'sp/send-email-validate-charset' into next, 2026-03-06) checked out at
> > the moment).
>
> We could build a tree referencing an object using a mismatched
> type to hit that.  It's possible by removing the type check from
> builtin/mktree.c:mktree_line(), then using the resulting twisted tool:
>
>    $ commit=3D$(git rev-parse HEAD)
>    $ tree=3D$(printf "100644 blob $commit\tcommit\n" | git_evil mktree)
>
> > Still, fixing such obviously wrong dereference is good, but I wonder
> > if we should go further?
> >
> > You mentioned git-backfill with a tree missing from the local odb; do
> > you have a short reproduction script or test-case?
>
> I don't know about backfill, but this would work:
>
>   $ echo $tree | git pack-objects --path-walk --all foo
>
> Ren=C3=A9
>

Thanks all.

--=20
D. Ben Knoble
