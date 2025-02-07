Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4C032561D
	for <git@vger.kernel.org>; Fri,  7 Feb 2025 07:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738911891; cv=none; b=Z1DeLjt+LjH+t0or35EDt0VmEqyYM/EOpNhdp2yCCUdeF9Noh//NPI9IEkxWO/CEstmFTxdqJbnuOtXhRM1UJvsc5Zaj3z2Lra/GVZykVKJzZOd2mBL/VT3z1sDGAlFyyqWlzvsJOp+Zf7v6uMgKWvYhc0uK6pOTcLdJK8f1fNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738911891; c=relaxed/simple;
	bh=YIrfhTYI/UltHzAJcLGVb0mC1ZU5PBOqvCtrWZ7+/no=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qZG9GvzH/zml/QWCW3WMA8mwLmkve8YRDvsZHOrKwphE7BO8gxlAWzXHDxSlSuTlaQ+opp2Sgt62Ex3BpfouBbiHS+n420k7u7cajdF90v/kIoeKPoC61XEgcNtSaW9leRrFif1hbbGWdtvJTga0i3Sl7C9RlJ2glre2YO12F4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RkvOFp99; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RkvOFp99"
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-51e902b58c0so843013e0c.0
        for <git@vger.kernel.org>; Thu, 06 Feb 2025 23:04:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738911888; x=1739516688; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=dbWPxL/gJKrVwn+BidLxnXacxsP87lJrqx9jVAdSpPM=;
        b=RkvOFp99ZOp/FzNpcEffQ4CbO1nADze0ptKENyWNykoXsG+wCdCNijZkyZ8crWQuab
         P//20woybNTawUn56naK14AXJyyzeZlQd/UKtsyiWBO2MT8tRkPcz5LQfYs94Q1JXeB1
         Lf/IR02wOsywLJ4c8GUxZff03o/y190hjMXylxi0Ycy3G8M+z27aMhiYRMLtc+LkuCv2
         KCLbcWEJd4O22p6/bExB6GzQRYxqEFiHzFzYwl1dAa68JkdsmL8yjWHoFZ68FvRuAoGa
         h7XXFcKqkmSbpPGUdb3852+WK18rY2ndv/2Upkndz9EoaQsopohPRFxnYlnwnxzIYJfB
         +Mzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738911888; x=1739516688;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dbWPxL/gJKrVwn+BidLxnXacxsP87lJrqx9jVAdSpPM=;
        b=nzUcDOyNiaS77agkTjWE22slDHbcrGW8sOa/VnEd90rcwKq7KVueCnqiMQfOLuACSc
         JiFUd4pz/yNxh5JD7pJc8xs93USkWQEXa9qWbAEH33OWN5jpzA+mz8hRIvxC3EwjLzWX
         D1PP4c2CVcnG80GVsjniCpJcpUkH4dCnoAUymBxB94RPLc+TD8x2NvMeDCDi//B1M/UG
         tErIl5wYnBruDWOP9yomBY+0I6ZRAIjXGlUpN+ym5w1hdreuVTg2HGQ6bMIYcRLzdYN9
         qKxG3IcwAW5ZGyA46a8jk9ggjXlFhIEWPVTgPjWieBZzFYEnH6GIqvqmYdvPQ/wZTcAk
         ns8A==
X-Gm-Message-State: AOJu0YwxLOvGHEIMoKKVMq9MaxKwsAgwRA15bj2rSbLa92aKOpmaoqPx
	inRxHYD+uiXAXaUVgrP7FjFOfSU2Kot8GwNMJH7OoEJqphJDixDnqfrR1BwSuWtRs7bfbO1Dgkd
	7rG/RlB7i8exVHzY/oGffPdkZ/yViZafL
X-Gm-Gg: ASbGncuL5yzflRZjB8DY8SOWqCwluALZxfbhaqp5j0RYBSxagb8icvuJgCCSmB0uZKT
	6uG6QaCcgqH6f/8qGKEdtZyGJzXw66HswrGvxEbVucfHQ29vdxkMNRihZica2mT+VHR5+ULyLsa
	GVXLTW9zdrZ1k7P1EOym4j0dc734iacLw=
X-Google-Smtp-Source: AGHT+IFesqX8wcf3TcnS1BzLk5R8n/TfyOth37JW+gcpIgj22V8mrnPkgXi0ltJzU0Zhi4kBEYm+qCdxK8MyWWkF0t8=
X-Received: by 2002:a05:6122:65a6:b0:518:7ab7:afa9 with SMTP id
 71dfb90a1353d-51f2e2c8f49mr1211489e0c.10.1738911888531; Thu, 06 Feb 2025
 23:04:48 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 6 Feb 2025 23:04:47 -0800
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <Z6WlONTM0lNaXTH5@pks.im>
References: <20250206-b4-pks-path-drop-the-repository-v1-0-4e77f0313206@pks.im>
 <20250206-b4-pks-path-drop-the-repository-v1-5-4e77f0313206@pks.im>
 <CAOLa=ZTJ7ef9rP3fQfNwSCD54zeVPL1Rd_hQfzDpEpFiStx_PQ@mail.gmail.com> <Z6WlONTM0lNaXTH5@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 6 Feb 2025 23:04:47 -0800
X-Gm-Features: AWEUYZkojssCt7yTujf3BY24aqSEJ4_xFc2_Cr8qJNrq3uG5FLaoDF0fZQm7ri8
Message-ID: <CAOLa=ZTJDG+YgrP42b5x0NXxQn4kS2adKu2KncUd2Q2NTMGsaw@mail.gmail.com>
Subject: Re: [PATCH 05/16] path: refactor `repo_submodule_path()` family of functions
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000698dc7062d87f90c"

--000000000000698dc7062d87f90c
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> On Thu, Feb 06, 2025 at 04:05:13AM -0800, Karthik Nayak wrote:
>> Patrick Steinhardt <ps@pks.im> writes:
>>
>> [snip]
>>
>> > diff --git a/path.c b/path.c
>> > index d918d0409e..d721507be8 100644
>> > --- a/path.c
>> > +++ b/path.c
>> > @@ -560,14 +560,15 @@ const char *repo_worktree_path_replace(const struct repository *repo,
>> >  }
>> >
>> >  /* Returns 0 on success, negative on failure. */
>> > -static int do_submodule_path(struct strbuf *buf, const char *path,
>> > +static int do_submodule_path(struct repository *repo,
>> > +			     struct strbuf *buf, const char *path,
>> >  			     const char *fmt, va_list args)
>> >  {
>> >  	struct strbuf git_submodule_common_dir = STRBUF_INIT;
>> >  	struct strbuf git_submodule_dir = STRBUF_INIT;
>> >  	int ret;
>> >
>> > -	ret = submodule_to_gitdir(the_repository, &git_submodule_dir, path);
>> > +	ret = submodule_to_gitdir(repo, &git_submodule_dir, path);
>> >  	if (ret)
>> >  		goto cleanup;
>> >
>> > @@ -586,13 +587,14 @@ static int do_submodule_path(struct strbuf *buf, const char *path,
>> >  	return ret;
>> >  }
>> >
>> > -char *git_pathdup_submodule(const char *path, const char *fmt, ...)
>> > +char *repo_submodule_path(struct repository *repo,
>>
>> To stay consistent with the other repo_* functions, should we change
>> `struct repository *repo` to `const struct repository *repo`?
>
> Somebody noticed :) But no, we cannot, we need to internally pass the
> repo to functions that expect a non-const pointer. This is because deep
> down in the callstack we end up calling `repo_read_gitmodules()`, which
> modifies the repository.
>

Okay that makes sense.

> I'll add a comment to the commit message.
>
> Patrick
>

Okay perfect, thanks!

--000000000000698dc7062d87f90c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 612c00d5924a9a76_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1lbHNJMFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mM004Qy85M3UvZHVGbHJJK1ZKWXY3blB3THFUdGcyeAozTXF3RjBObC9w
RnczRnRaNzh4cmpSazhGeldwQUt5L1JOU1F5czNWdmV5ZUdvTVU4Y3FrSVY2T090T3VuTlFlCnBK
R1lqZk9MTUhmUjltTVg1clR5alVpMTltZGpScG5IMDBuMmdPKzllWDlwaXZHM1V4dHpoOHRzWjkz
TS9STmMKN3JNR053RDRwL2w3QUxMYWdxaHBvdWZwZ0ovUnowTWRmdVhjZncxVWlmSW52VFRGUjZ5
UnhmMGlPM0ZsRzg3RAovaWM4VHVEK3FEMzJUbU4zMzNmYVZNVW0vM3pkSFc3Q3hDcnNwZTFyY2JU
aEhjN2dqU00xbE9RV29rTHFEQ2JMCnZrZlcvdkZlVUVoMnFoT2s4VGdMdlpucnhvRWxLUU90M01Q
VUdZWVh6bFZ4OC82OHdTZFQ2Q0U3RXVMdkpHQkMKRHJ4Z01ydlAreG9VaytTL3hacVR3RGVYSi9C
SjlSelRyVzVnY0RrbnEwWXZJaSsvQy9aTTVFQm9PdUliNlhrUApadDRBRnJyejFjTmJEQThoZzJQ
TXFYY0FIS3RndU5kbDRNLzk0d0YzbXorREVNd2lOQUw4YkFkQUZKS0NjWnhSCnpxOU5PN1VBODVN
MkhyRU5Yb2VxRFhyQkl0NDdqY3RkYnlNcXFKST0KPXpBR20KLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000698dc7062d87f90c--
