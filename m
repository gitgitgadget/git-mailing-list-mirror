Received: from mail.normalmode.org (h01.normalmode.org [157.230.60.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D85BD309DDB
	for <git@vger.kernel.org>; Thu, 11 Jun 2026 03:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.230.60.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781147441; cv=none; b=lwhVEh9zEIin71d7NWmwxe9+YBRdEngS97maQkWJZKkwX3i9IKe41wZBXeGn9Xs71DI7Zn6dSiVcpPOMOaihSqHllD2VZZE8VLJzz1SVqDjXcvAJu4qaVzIEGtM6Rt4jlO+rG7kpcycW2bFbBYTBnbZmaohQxMWAyoj1+jC5jYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781147441; c=relaxed/simple;
	bh=Krx+bnEoSx8HPzCt9VUCdatrpfGAceAoren8rdFjMPk=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:From:Subject:Cc:
	 References:In-Reply-To; b=UObR1pG+n3nR5JWu+KR/nG+CfzVesNleZ977tO5pWvTPp2qwtSYAi0LdZBJbZGEJyfBmtYud31sLrn28ZxnI9KnHGNjq1eo3Ttty24s420mFXBQ5Iye8XJlW80g1WCgjy+7jFx5C5ff+4T3Io25X069IxuuevnM6bSEGXrpbTNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lfurio.us; spf=pass smtp.mailfrom=lfurio.us; dkim=pass (1024-bit key) header.d=lfurio.us header.i=@lfurio.us header.b=AQ1aGAEp; arc=none smtp.client-ip=157.230.60.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lfurio.us
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lfurio.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lfurio.us header.i=@lfurio.us header.b="AQ1aGAEp"
Received: by mail.normalmode.org (Postfix) with ESMTPSA id 9235460035;
	Thu, 11 Jun 2026 03:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lfurio.us; s=default;
	t=1781147432; bh=Krx+bnEoSx8HPzCt9VUCdatrpfGAceAoren8rdFjMPk=;
	h=Date:To:From:Subject:Cc:References:In-Reply-To:From;
	b=AQ1aGAEpJEUGSEASo1HFseTLMC9TF9uc4ZT72oytT1EKuYaOhhZ9ESf8FVSRHcjU6
	 k8iSe2mT/aR32uYzHNxAblnkqOKqokWVFxV7Pg+YmhG0yAKP2VJDVmGC9Gvy1OsYGc
	 3KBgY3V0gRUlv4g7WXu+1tVwTEbglmBUTzEolnQc=
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 10 Jun 2026 23:10:32 -0400
Message-Id: <DJ5W2I8UYXAA.3O4JQUHFMKP5X@lfurio.us>
To: <kristofferhaugsbakk@fastmail.com>, <git@vger.kernel.org>
From: "Matt Hunter" <m@lfurio.us>
Subject: =?utf-8?q?Re:_[PATCH_v3_02/11]_doc:_interpret-trailers:_replace_=E2=80=9C?= =?utf-8?q?lines=E2=80=9D_with_=E2=80=9Cmetadata=E2=80=9D?=
Cc: "Kristoffer Haugsbakk" <code@khaugsbakk.name>,
 <christian.couder@gmail.com>, <jackmanb@google.com>, "Linus Arver"
 <linus@ucla.edu>, "D . Ben Knoble" <ben.knoble@gmail.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <CV_doc_int-tr_key_format.533@msgid.xyz>
 <V3_CV_doc_int-tr_key_format.8a3@msgid.xyz>
 <V3_metadata_not_lines.8a5@msgid.xyz>
In-Reply-To: <V3_metadata_not_lines.8a5@msgid.xyz>

On Wed Jun 10, 2026 at 5:21 PM EDT, kristofferhaugsbakk wrote:
>
> diff --git a/Documentation/git-interpret-trailers.adoc b/Documentation/gi=
t-interpret-trailers.adoc
> index 1878848ad2a..3f60fd9b720 100644
> --- a/Documentation/git-interpret-trailers.adoc
> +++ b/Documentation/git-interpret-trailers.adoc
> @@ -14,7 +14,7 @@ git interpret-trailers [--in-place] [--trim-empty]
> =20
>  DESCRIPTION
>  -----------
> -Add or parse _trailer_ lines at the end of the otherwise
> +Add or parse trailers metadata at the end of the otherwise

fwiw, I think "trailer metadata" reads more naturally.
