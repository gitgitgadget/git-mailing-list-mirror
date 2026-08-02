Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6921E26B2CE
	for <git@vger.kernel.org>; Sun,  2 Aug 2026 06:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785652010; cv=none; b=u4C8bSUQxjdcP1wvcbe0IwG5BBzxBEgA/AMpZjdOLoLx9oo42+D325elN4wr8RhQQAy17XDk0MfalNFrONQtkyi0QhaAvXOtz7js9KFzIeba5yAO4ViF1nO+MTiti7mtb5McVSp0i71sOM9ydGmVTiKN9hq4oettOyE+XilzLrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785652010; c=relaxed/simple;
	bh=QeC7jK95hdGimeWFDUV+Ph4Qmcvc1mzG09sKmH5b4KI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aRcqEXfe7DYTm5qQC9F5JuZRm277QxxH+2qohnZ/Fi22OcITT3amoFahybMAYu//AO3VIF/UkomPDjbmHW1rulHhYRN/w3coXLgsBZSmU65LbtJlrE9ELp2eDn0376fNNvBf+zo8szmydip6SjRxD5uF+twgok1BKqXN7bX1NGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=EDcUbAjC; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="EDcUbAjC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1785651999; x=1786256799; i=l.s.r@web.de;
	bh=Y4ewUrW+g3x/k0NOlzcNQOPKDHugbXLA7srvaFHNe0w=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=EDcUbAjC7OS2/4epBcjtU79IHXQ7bRcw2JgoJUkHronwmMMBqoZIN2hfRaso9npC
	 EiR1Z4S+NsKFzXWlZXDmnVUuB03DsQoqFOCRr3Y2HGgbB6HOUKtkgM6MGNdkXD5iJ
	 NHiXCxrAjAFLLUes9aiL+XSWaNT+rjWxhHeXc8KAklHc9hZ2ehZTF0AnQV912hwEh
	 LQikCa2wsVZiECYigxZAxIlTl1VmCg76AlMy3fULZ5tsG+/OXKnOttyCBuGALvm4Z
	 oNC2zPqCGulJVDk2RnYedndslRvRRcpYnTA5RfnThvXo8FqsE0vq9/cga3pfs9JUA
	 D6HGodv9og7sqD3KJQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MwR4D-1x6z6I3NAL-00wV7U; Sun, 02
 Aug 2026 08:26:39 +0200
Message-ID: <f6b7af1a-29fd-4bec-b819-34b7962180fb@web.de>
Date: Sun, 2 Aug 2026 08:26:39 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] worktree: reject empty string
To: =?UTF-8?Q?Matthias_A=C3=9Fhauer_via_GitGitGadget?=
 <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc: Marc Branchaud <marcnarc@xiplink.com>,
 =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= <pclouds@gmail.com>,
 Eric Sunshine <sunshine@sunshineco.com>, =?UTF-8?Q?Matthias_A=C3=9Fhauer?=
 <mha1993@live.de>
References: <pull.2187.git.1784978348.gitgitgadget@gmail.com>
 <ec682d75f3a7848dc36f82cf36bbdff6fd283e2d.1784978348.git.gitgitgadget@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <ec682d75f3a7848dc36f82cf36bbdff6fd283e2d.1784978348.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0nezP/oZUQXoETH4y1DwJQNb7BChyL3jWRZNq+tB89II/iSvZfS
 yV2pHcAQH3U8IT6Bi74f+pcER29gHwTEh9nzgHgIKjLLcxQZL+mVG7eKzG5xKiTfzXLLZSY
 3D2zitzq0evVwjxcPRBJiYmpuOinnY18ChNER1A4p/RXqvSvde+O5oxdn3bmybUBJS5reZO
 YJBbA4B7JYMZuxXiYz79w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:S6i4/In982g=;QtMbDuh9K4YWWxMT0twWc2E02Lg
 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

On 7/25/26 1:19 PM, Matthias A=C3=83hauer via GitGitGadget wrote:
> From: =3D?UTF-8?q?Matthias=3D20A=3DC3=3D9Fhauer?=3D <mha1993@live.de>
>=20
> `git worktree add ""` errors out with the message `BUG: How come ''
> becomes empty after sanitization?`, but not due to a bug in the
> sanitization code. An empty string should remain empty during
> sanitization. Instead reject the argument as invalid user input,
> if it's already empty before sanitization.
>=20
> Signed-off-by: Matthias A=C3=9Fhauer <mha1993@live.de>
> ---
>  builtin/worktree.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/builtin/worktree.c b/builtin/worktree.c
> index d8188035db..113dbf98d3 100644
> --- a/builtin/worktree.c
> +++ b/builtin/worktree.c
> @@ -496,6 +496,8 @@ static int add_worktree(const char *path, const char=
 *refname,
>  		die(_("invalid reference: %s"), refname);
> =20
>  	name =3D worktree_basename(path, &len);
> +	if (!len)
> +		die(_("the empty string is not a valid worktree"));
>  	strbuf_add(&sb, name, path + len - name);
>  	sanitize_refname_component(sb.buf, &sb_name);
>  	if (!sb_name.len)

Hmm, on my machine, with or without this patch:

   $ git worktree add ""
   Preparing worktree (new branch '')
   fatal: '' is not a valid branch name
   hint: See 'git help check-ref-format'
   hint: Disable this message with "git config set advice.refSyntax false"

and

   $ git worktree add /
   Preparing worktree (new branch '')
   fatal: '' is not a valid branch name
   hint: See 'git help check-ref-format'
   hint: Disable this message with "git config set advice.refSyntax false"

This error message is produced by the command 'git branch "" HEAD'
issued using run_command() in add(), just before the the add_worktree()
call, which is then skipped.

Ren=C3=A9

