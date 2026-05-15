Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D3283D9DC0
	for <git@vger.kernel.org>; Fri, 15 May 2026 17:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778865343; cv=none; b=P7yfK1eMi2CPpqyFz+kBfkKOiYZqh+QHaQbAbWK0Bik9leeWYo5uTcjRB0j8DKw8AvxcnTNjtTW+y3auj8UuLjRf7Q7mnZMcpwustOdUzfbKLOP03JWR9suczhv19nFtXuOrInlI1Huc6Lj0mGNKZS8zgLGPgw1Xa1Se85ZW080=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778865343; c=relaxed/simple;
	bh=mKBzZX0tXAVl1x233E9Mx9xtFDgn18iyrNdLTz0yW78=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OQFvvu53gZxi3NKZ7XPcTvqsjRB8sv4weMgUyrJzu4zkDGFQ8KBWPkySjad67IQPt/NDc+V8oVHfUSXTlcp6r3izjXDPwVpQjSHXA9QrVJtuuRQh1l6V03mtYb8qYbnmRuNJoouAIKIDoNPKmLipdC5aDHggpTrJcdxrJ8Ya7ZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev; spf=pass smtp.mailfrom=malon.dev; dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b=jYEcty7M; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=FoqJRVC7; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=malon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b="jYEcty7M";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="FoqJRVC7"
DKIM-Signature: a=rsa-sha256; b=jYEcty7M4yDjz3OeFz17Cc1s5qBGq9yQYyZDEX6fW7xkGwxoQ5nr37U2OeZyjM+nl+cuJpG+C88yWm/2rfyj8UQfYBK6vGI5lqvxxx8q4+IwJqwbGQBeoTpHwdQ05oY+fnRlAcIhno8N3LMb1gl70JFyS/g1PUkiUPlWihAZq1RELBRpAwec58kvgx2/WZq/eN2yb0TeprpZF05AEf3w+3JU29T8T6eEN+Jed+pMRtMcqyChIRMrvBxjpZYlmpP+VNfK7tem3weTaIcqFierIk2zok3wlENdPyD7dHTTm09LBtmQhmxvobMK2oiF/V4wYC/MrnMEtkwTGuKtBWEwIg==; s=purelymail2; d=malon.dev; v=1; bh=mKBzZX0tXAVl1x233E9Mx9xtFDgn18iyrNdLTz0yW78=; h=Received:Date:Subject:To:From;
DKIM-Signature: a=rsa-sha256; b=FoqJRVC76o1Til4LvXVfd11r7fQe5gP5lNfFAcyf3p6WxjoeOdPDJLwvB5WecaL5jfRhwiV0uDyzN07QyW8IMua7fhi0kgsSulBPXwzFRoeuZoBlBfXS5ujYdntFsaNzhho+5/F1yqZj17eX8E+Xyy7WVXecZhJ4IDbad9Rvir8wibcMAk+pyHisxLzYIctivosr6p0LZZg3nB8SA90c8mT6JlFsNPc1ceL3IBGpDYYesUg1al+P0VdHFNS4WM1iQ/AOyxHR5BwN2nKZtgxHp4BXhQQBG0LJ4064kP07kxgeiY/zzvFtzlDNihzIWM7iHFvztfDvZtp7Kd2W6+/d7w==; s=purelymail2; d=purelymail.com; v=1; bh=mKBzZX0tXAVl1x233E9Mx9xtFDgn18iyrNdLTz0yW78=; h=Feedback-ID:Received:Date:Subject:To:From;
Feedback-ID: 599969:32685:null:purelymail
X-Pm-Original-To: git@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -980752005;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Fri, 15 May 2026 17:15:33 +0000 (UTC)
Message-ID: <f4aa8cac-232a-440e-ae12-5e76c799a110@malon.dev>
Date: Sat, 16 May 2026 01:15:28 +0800
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/8] environment: move "precomposed_unicode" into
 `struct repo_config_values`
Content-Language: en-US
To: Olamide Caleb Bello <belkid98@gmail.com>, git@vger.kernel.org
Cc: phillip.wood123@gmail.com, gitster@pobox.com, christian.couder@gmail.com,
 usmanakinyemi202@gmail.com, kaartic.sivaraam@gmail.com, me@ttaylorr.com
References: <CAOLa=ZQDXn7181VfHpcWtNOSjTh9nzM3YnDTG_X1Vqh_v64bwg@mail.gmail.com>
 <20260423165432.143598-1-belkid98@gmail.com>
 <20260423165432.143598-6-belkid98@gmail.com>
From: Tian Yuchen <cat@malon.dev>
In-Reply-To: <20260423165432.143598-6-belkid98@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail

On 4/24/26 00:54, Olamide Caleb Bello wrote:
>   struct dirent_prec_psx *precompose_utf8_readdir(PREC_DIR *prec_dir)
>   {
> +=09struct repo_config_values *cfg =3D repo_config_values(the_repository)=
;
>   =09struct dirent *res;
> +
>   =09res =3D readdir(prec_dir->dirp);
>   =09if (res) {
>   =09=09size_t namelenz =3D strlen(res->d_name) + 1; /* \0 */
This 'precompose_utf8_readdir()' appears to be a wrapper for=20
'readdir()', so that Git thinks it is calling a standard POSIX function.=20
Looking at it this way, I feel the architectural design here is a bit=20
ambiguous. I think the role of 'readdir()' (or its wrapper) should be:=20
"You give me a directory handle, and I give you a file entry".=20
Conceptually, it shouldn=E2=80=99t even be related to Git: you can take a l=
ook=20
at the rest of code of this wrapper.

Since there is a wrapper for 'readdir()', there must also be one for=20
'opendir()'. To me, initializing a flag like 'perform_precompose' when=20
the PREC_DIR handle is created in 'opendir()' , and pass it down through=20
the handle looks a bit more optimal. In other words, If one of them has=20
to handle the repo pointer, I think it would be better to leave that to=20
'opendir()' ;)

Good night, yuchen
