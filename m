Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E0C5378839
	for <git@vger.kernel.org>; Mon, 25 May 2026 10:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779706748; cv=pass; b=A9AabwlTsvldJa/k27j+nAIdA/hsYF9tomQbBPdAi1JDgrbBNj5N0FtAbA0086DikO2+9i+7IbCMYxuVUdbYmEa7mqiJsadFOo/t6qRgIqnn8ZhVDRIg5ojnACfFYNSiXFWdZG++uvCCqC3Spnz26Pg5wzwXVRLLg7op2KhVnAU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779706748; c=relaxed/simple;
	bh=I59NkEqE7UVZa94sGAjqWqeDkVUJ6eMz7EzciT1C25M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=p1awz6m7c98k2ERL056Zo9GFE5kzxQ09pH+OADlQJ9nMYFsvbnAGPtUcQFi9bS3qb9bPs0fBethOKRrlt1GRxVo28/aS+gFQTYe6q82j+5n9K/Fs8jJ1W7PQm893/cmlk1I/xx5aaAZM8GUbG+ULMZrCUcHSSULxXWTJtDbD780=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=Re7LJNlt; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="Re7LJNlt"
ARC-Seal: i=1; a=rsa-sha256; t=1779706737; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=e4tQ5jOGtODGlWuEPqh8FLMwVg1UgnR1sm6s/JgXAxI/wZhd4DtnatnRgZujZ6GesAGE9xg5gOXoY3zJ5j2v8iBd2JTqXixxpLsLpMEos77nU2sLs97gPoGIMD1mNdlaphn2bwUsKQLWyMG0WLT6+sWYyMZWSZAs+G8LKaAuWT4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1779706737; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=VV5HDdQiKedYlpU3q6FnIFw6JxCbi82WIDUkdxPiATw=; 
	b=JFe+Ml8zmJ/uJc1Okhy8W1ZUL3oLR8veQA3M4EfHUU6cVjsGwwmlYmjEFwkt3ySlZ20SCH/XQACjddtxG8MdTev4eOIMg4ObPNBQjzELJBCBaUFnNH4oL+E3ihColgib06FET2umy9F1Rxq6fjBBCPrYkyG7JbJQlWD09lQB93w=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1779706737;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:In-Reply-To:References:Date:Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=VV5HDdQiKedYlpU3q6FnIFw6JxCbi82WIDUkdxPiATw=;
	b=Re7LJNltcYi3EyBKRQpqC5wfZsFSPDnK83nIS/Rt/jI8hfK6rCPiWUc/Waa4Y+6i
	MeNnusOHCyrjC6BpbLTVT8w78Hh9zy/GyfmUTu3jqaYOgbMLGxVseSP7ldK+yWnsAMm
	YPd47j+1UVIasCfwvxrnpLaV9eb1DVaegsuW9SZY=
Received: by mx.zohomail.com with SMTPS id 1779706733456472.65309623006704;
	Mon, 25 May 2026 03:58:53 -0700 (PDT)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: kristofferhaugsbakk@fastmail.com, git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>, jn.avila@free.fr
Subject: Re: [PATCH 0/4] doc: hook: small improvements
In-Reply-To: <CV_doc_hook.6f0@msgid.xyz>
References: <CV_doc_hook.6f0@msgid.xyz>
Date: Mon, 25 May 2026 13:58:49 +0300
Message-ID: <87fr3fsql2.fsf@gentoo.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ZohoMailClient: External

On Thu, 21 May 2026, kristofferhaugsbakk@fastmail.com wrote:
> From: Kristoffer Haugsbakk <code@khaugsbakk.name>
>
> Topic name: kh/doc-hook
>
> Topic summary: Small improvements to git-hook(1) and the associated confi=
g.
>
> [1/4] doc: hook: remove stray backtick
> [2/4] doc: hook: consistently capitalize Git
> [3/4] doc: config: include existing git-hook(1) section
> [4/4] doc: hook: don=E2=80=99t self-link via config include
>
>  Documentation/config.adoc      |  2 ++
>  Documentation/config/hook.adoc | 19 +++++++++++++------
>  Documentation/git-hook.adoc    | 11 ++++++-----
>  3 files changed, 21 insertions(+), 11 deletions(-)
>
>
> base-commit: aec3f587505a472db67e9462d0702e7d463a449d

LGTM as well. Thanks!
