Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A3834CFA1
	for <git@vger.kernel.org>; Mon, 20 Apr 2026 16:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776703144; cv=none; b=hDvkhWKNcEem13mFpOswzBx1SpGTvNwiEkvd0WLiICTXmpKM6PeU32rjRuCLFszeVwyK0mloackOG5gJH500+I/EcfeSCwgmKU7ctyp0bps8mJCA61kmlzb2fL4g5otdysgoP8TiM/06TaTtlDbk/F81zJ2EHpXqVVJ/5a0YGdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776703144; c=relaxed/simple;
	bh=Jnre7hoor1oMI1yxT3MEdgAGX9j93SOSkhxQdoxtUhk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XAtRXBK3lw+1Jip6Unou+vQ5Mp8X1v6rL2X+qCOeJpdVwxKX8K0RSgatEcE/VyxGgIyqYAaS+ngSbaWhY9Eyngw9LLaCDO8m5lMQTX+aq6P9IQo1KQgQL6/6olhpDz0xp7LFruXDcLHAk33VhdA6Me81qH3MsDwnzFPvz0WzZvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev; spf=pass smtp.mailfrom=malon.dev; dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b=iNJsujvx; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=S47GjDEJ; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=malon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b="iNJsujvx";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="S47GjDEJ"
DKIM-Signature: a=rsa-sha256; b=iNJsujvxpsVoDcDtHehBuVbg+ML7tKx/zJo8Tee+8aFDpnqIXvnMkn5IJpDDze3Vm6qokdpBRHij6ztXMWHvHNJgHs1rP3CA59VP9LA6FR4UC//4n78dQCnUJfW3B78XkPq1zZvZYAuozYpCNmY3MaYWKc98Ktsd/g/qeZUeGh5U0y6lTQC+ATUXF0ZD28eFAbWUel9qhh5UlTh4ZX8uLcM04claEyvj9MfduI9o7fVDS+L4CORbQyTL9bDGduZIxlNiPALeM9qbAJneGNm+pwT+hsxH/hSZhq5p8RhZzKue8evkuJSAFzdruZP3Yfz5gbxlG0/PMhTlMi8iymcfYg==; s=purelymail1; d=malon.dev; v=1; bh=Jnre7hoor1oMI1yxT3MEdgAGX9j93SOSkhxQdoxtUhk=; h=Received:Date:Subject:To:From;
DKIM-Signature: a=rsa-sha256; b=S47GjDEJ5vciVKP/3WjtAjnc+Nz5PJgUg7lquhv9LnFwi8/E+aVnVtIB99E5uNbY3w9pG/+BIIyCkDLaxueyLJKZg//KksKkwcnT8IksqDOrWNz1aivhLuquNkJ6TFdMCWVHjkcOb+Ap0DGXPqPy83fuhE9Fori0V7Tjgre3XS62DyHHo1TESUiDBTpdtUFBs8JGBrp4dW6KT/ETq+6aJTV8tUVkiiy7R2nCntx+rzfxx6OBtkWG9mdh1NJuJ94+Tf1Df3YAqJ4TVNtyNdc6q5Tc+OlsP45UDj4RoDomHkcVrEDC/jtHGdL+QppiN7H2Fy4zt6CPs32bu5bOrdJrcA==; s=purelymail1; d=purelymail.com; v=1; bh=Jnre7hoor1oMI1yxT3MEdgAGX9j93SOSkhxQdoxtUhk=; h=Feedback-ID:Received:Date:Subject:To:From;
Feedback-ID: 599969:32685:null:purelymail
X-Pm-Original-To: git@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -784593937;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Mon, 20 Apr 2026 16:38:57 +0000 (UTC)
Message-ID: <b62a96c5-fab4-4c6d-9768-ade48a8476ca@malon.dev>
Date: Tue, 21 Apr 2026 00:38:54 +0800
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] status: improve rebase todo list parsing
To: Phillip Wood <phillip.wood@dunelm.org.uk>, git@vger.kernel.org
Cc: Phillip Wood <phillip.wood123@gmail.com>
References: <cover.1776697483.git.phillip.wood@dunelm.org.uk>
 <d20dc1f6550078883995ae963b91faaa00984c6e.1776697483.git.phillip.wood@dunelm.org.uk>
Content-Language: en-US
From: Tian Yuchen <cat@malon.dev>
In-Reply-To: <d20dc1f6550078883995ae963b91faaa00984c6e.1776697483.git.phillip.wood@dunelm.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail

Hi Phillip,

On 4/20/26 23:04, Phillip Wood wrote:

> +=09if (!starts_with(p, abbrev))
> +=09=09goto out; /* object name was a refname containing only xdigits */
> +=09p +=3D strlen(abbrev);
> +=09strbuf_remove(line, p - line->buf, end_of_object_name - p);
> +=09end_of_object_name =3D p;


> -=09if ((2 <=3D string_list_split(&split, line->buf, " ", 2)) &&
> -=09    !repo_get_oid(r, split.items[1].string, &oid)) {
> -=09=09strbuf_reset(line);
> -=09=09strbuf_addf(line, "%s ", split.items[0].string);
> -=09=09strbuf_add_unique_abbrev(line, &oid, DEFAULT_ABBREV);
> -=09=09for (size_t i =3D 2; i < split.nr; i++)
> -=09=09=09strbuf_addf(line, " %s", split.items[i].string);

I noticed that after this patch, refnames shorter than seven characters=20
are no longer standardised to the standard seven-character length,=20
because the 'start_with()' function always returns FALSE. The code jumps=20
directly to 'out', without completing or cutting the refname.

I=E2=80=99m not sure if this was your intention, but I just want to point i=
t out=20
for your information.

(Also noted that there is a very rare scenario where the OID of a=20
refname longer than 7 characters happens to begin with the refname=20
itself; in this case, 'start_with' returns TRUE and the string is cut=20
incorrectly. However, I think we can safely ignore this.)

Regards, Yuchen
