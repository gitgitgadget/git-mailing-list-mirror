Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2522218E8B
	for <git@vger.kernel.org>; Fri, 16 May 2025 05:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747374165; cv=pass; b=K7gMvzSEGSOxHKGDA15lqnrol0NjS36h1PaRUQafNxC1JB/3qZA+WMTN9d0tDYTlf3FPoUEBMIXEczsIJc/ZKcsSTilAQrAMOpOe93jSZekap6zqOi2vWYLBXmHItf7xPnlT4kgFk8ezxF5NVnL+2Qcc6UoJMX0D0b/IBcVsTTQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747374165; c=relaxed/simple;
	bh=pYPBJkE8D42Fv72snBCqpZlLqkobyzRqE5vePIAXMWU=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=DBmnThsouucRJ/WM7AOGn3GGB1nsZAaBe6S5b9qKh3I6yrTMF/Ctg3AbAv4iabil6OMAvZfGoicMhUTFWav8awn2JkNF61MLqQfpErbZIlp++6uid1nDi5vfWFoKlA00+r+7FjS6ViV7DBWvN3kpX9ta29hb+9Dx0nhFAj2hlSM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty; spf=pass smtp.mailfrom=linux.beauty; dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b=nwlPFjwx; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.beauty
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b="nwlPFjwx"
ARC-Seal: i=1; a=rsa-sha256; t=1747374152; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=GABA7TJ2fQAo9X0Vmu6uJSRIx0bS2tBq/FaaSdGU8JNttwVrVwX3gPTIE80u0QS71NvMjqQzOXZAw6+o9MvoDA4B7WtjfH/3ZNuwrRjeS7NfF0mJRYyA1N9drKJSww53yZUcW0qNNY9kVw/X6BmiaHM3fqR9BMyf/8MrhN60Ies=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1747374152; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=6qVWMs68au2jUcze7SZjm5TRUCdBJotYegubgxaoCIo=; 
	b=P+rv1de+IUrpIK5dUGH/ToWIyjN5SPuSG4ENeJVfQZcHuRqT7wl7hM5OUTiItsNwyn+cJV8Q2qlSuE6LP6AqWWfTjZQR5DHBffjGH822OkXWtXSvLDr404CdSvxgnuiiYbEaV24S3HYfzaRKy0AnjDvgEP9RS2S/k+XPiI1RnVk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=linux.beauty;
	spf=pass  smtp.mailfrom=me@linux.beauty;
	dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1747374152;
	s=zmail; d=linux.beauty; i=me@linux.beauty;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=6qVWMs68au2jUcze7SZjm5TRUCdBJotYegubgxaoCIo=;
	b=nwlPFjwxltZZ2uvNBhT0iGSG1Uv66xN+uLcNbedof927sbiPsMMMcQXfpUlnxSt9
	DX0RUydZh41Vg71BGz8yh8T2EJJevc7jb9jODl5AkUnuRZ6DXXoVc9WdCFy5h+mAZKz
	L+H+dfxy9SLCXY/5ZpWNxobGQfupQXpnqMwwBWL0=
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 1747374150249393.6106774602381; Thu, 15 May 2025 22:42:30 -0700 (PDT)
Date: Fri, 16 May 2025 13:42:30 +0800
From: Li Chen <me@linux.beauty>
To: "phillipwood" <phillip.wood@dunelm.org.uk>
Cc: "git" <git@vger.kernel.org>, "Junio C Hamano" <gitster@pobox.com>
Message-ID: <196d79d922d.127d7eb7f870411.3309775784450179401@linux.beauty>
In-Reply-To: <951d3343-fe97-4e7e-bb73-1c569ff10ee6@gmail.com>
References: <196a5ac1393.f5b4db7d187309.2451613571977217927@linux.beauty>
 <196a5ad7fff.c587c495188189.5980390754046003962@linux.beauty> <951d3343-fe97-4e7e-bb73-1c569ff10ee6@gmail.com>
Subject: Re: [RFC PATCH 2/2] rebase: support --trailer
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail

Hi Phillip,

 ---- On Thu, 08 May 2025 22:17:17 +0800  Phillip Wood <phillip.wood123@gma=
il.com> wrote ---=20
 > Hi Li
 >=20
 > On 06/05/2025 13:58, Li Chen wrote:
 > > From: Li Chen <chenl311@chinatelecom.cn>
 > >=20
 > > Implement a new `--trailer <text>` option for `git rebase`
 > > (support merge backend only now), which appends arbitrary
 > > trailer lines to each rebased commit message. Reject early
 > > if used with the apply backend (git am) since it lacks
 > > message=E2=80=91filter/trailer hook. Automatically set REBASE_FORCE wh=
en
 > > any trailer is supplied.
 >=20
 > I think this is a reasonable idea but unfortunately I think the trailer=
=20
 > API needs improving so that the implementation
 >=20
 > (a) ...
 >=20
 > (b) ...
 >=20
 > (c) Only adds the trailers on the commandline. I'm a bit confused by the=
=20
 > various trailer config options - the man page reads to me like "git=20
 > interpret-trailers" can add missing trailers that are configured but not=
=20
 > passed on the commandline.

About part (c), just to be sure I understand correctly:

Do you want the trailer implementation to completely drop any handling of t=
railer configuration=20
(i.e. remove parse_trailers_from_config() and related config-based behavior=
 from the codepath and man page/documents)?

Or would you rather leave the config machinery in place, but have rebase --=
trailer explicitly
ignore all trailer.* configuration and only append the exact trailers passe=
d on its command line?

Please let me know which you prefer (or if there=E2=80=99s a third path I=
=E2=80=99m missing) and I=E2=80=99ll add the patches accordingly.

Regards,
Li
