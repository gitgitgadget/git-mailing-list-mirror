Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.227.17.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795606802;
	b=YP5N8bMURuRwyjqJXsGqr047IgVs3N80vUV1Xwtc+ZbKlAF6OS1AOsrONzPoQtGLOgf/
	 3yVmwEdN5uhJ4LdG4j6pLbLP7rsSftU+N5fKTvLzIOtGyf+LISxi/aA/UWVDeCFc0rhYU
	 6fac+kd2uOLtI/zy4QtFdkD0b1Vwjo/oX/m/nZ8z+1Tp5An1iy9HUoOk8NBY5PVBctLXS
	 4hup+Qs+BU1Fpbssf4h8tZ2yLt762fTaeugGCKcGNCFMQkvFJ/8NQvVCIsQZTpC+Id+bw
	 U2rr1JUMTjEQigRKnRFGwfYG1Pi+oxCp55y5SdBBn2XNJG7pSTj2RWukX8aC5nia6DA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795606802;
	h=DMARC-Filter:DKIM2-Signature:Message-Instance:DKIM-Signature:
	 X-UI-Sender-Class:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Provags-ID:X-Spam-Flag:
	 UI-OutboundReport;
	bh=rcNuBmJ2UdCA+ksCqBvFT7kjSqKX+dqHOk8eoh7UlII=;
	b=Ql9f/A1uuGrzl/WquSIIwtyJDOLCobYi/udHJuJYTWkypsHBY3bhvm3Pdw9bc03cjR30
	 ZhRvDG9rvTFKUCks/DlFkP2fy9kNEIbpzKFaXPvI3VTyqc3c0f7kJYaIt5lQXxZCYHP11
	 BKXn7Rhwyq2Ieg2bhUtMNatb1M4GbP7kND/XXvMP1Vo/rWvxI5oskb+Ljpft0icKjS1Ip
	 9euyz00Gw1ITrZMBRU4NBwp+KmcPEITjpoD7LTt1GYP4xaKncW6ZM8SikVXfx77uGBNJn
	 MUzuybunRqtwgrNVzIfJzaCuXY9X/O3XyKXEBjAz1KFq7QlpzxOwqXTrd7fzVmcza9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=web.de;
	spf=pass smtp.mailfrom=web.de;
	dkim=pass header.d=web.de header.i=l.s.r@web.de header.a=rsa-sha256 header.s=s29768273 header.b=DLstBdLS;
	arc=none smtp.remote-ip=212.227.17.12
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F419D606A323
	for <git@vger.kernel.org>; Wed, 25 Nov 2026 11:40:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F419D606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.a=rsa-sha256 header.s=s29768273 header.b=DLstBdLS
DKIM2-Signature:  i=1; m=1; t=1795606800;
 mf=PGwucy5yQHdlYi5kZT4=;
 rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
 d=web.de;
 s=s29768273:rsa-sha256:dLMXXXMKXAjt7etbS8r4XzxU1c6u
   TmO85VkB1olwWyZdfw3B08g1aNoMYY/+ZuYZqYJyk4D0fYwNDnbX00NLya9YXk7H+wtnCJowjt5
   U9Wz+9PrNXgyhuR0aO5LLEnpGQxv9IKyTLkNYlbQNde0hp4jK3c/89dg6u/FU6k8/XW2no3z0Gz
   1knKh1u5Y23aAT2A5YLROfuoYV/cHCy1pT/TEVk1HTXzfqmok/taxc5qSvV5JfTL6BQvFLYbqcm
   Fr/KmW23dF669R6BEQBAI9N22A0ECv+lrNkRcsHgZFSomncsL55YnHPH5hiHFK4CQOgANqf6fJx
   HhArlP5vpjuEtQ==;
Message-Instance:  m=1;
 h=sha256:
   rnvg2Vjt1zsFMDo/Aq2v36ziG0Qp8GLfc9p65btIK6o=:
   x+aZ5NJHO9PsnMEJLVcDCDub7wTTU6206ClVk2tFrTA=,
  sha512:
   J6Paoh0G2CP+crwEi8ul6AuyPduRdUxUEGJ4rwS2s0jdxrt0RjZapNWJhBFdp6I2CqmPwS/pxwPys8WM7LN7AA==:
   Kh6xMQ4sXA5ACpn2nJPsObLc1QHKvwp963URsKIUsRxP+6zM6z9dLcLC9lj3Ew5LYDCdbxCD6Jwn1zHuSoj+2A==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1795606800; x=1796211600; i=l.s.r@web.de;
	bh=rcNuBmJ2UdCA+ksCqBvFT7kjSqKX+dqHOk8eoh7UlII=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=DLstBdLS60l+fQ9FqgfZHZFr3BKL0HK1EEg/PEebkbu15v82WJV+/JKJf3pe7pZj
	 MvYVmvZvuGCaFWgY2ZuUFypxYlB4xx/FnB1U46j3PKbZRHkfJPOiEufyjHyUeJgfK
	 0M9SfnElY5kcMHJOUvkY7YFicDUlxvPMf08UYDJdNyZ5BQE7WtsSC8nQNUlmVRYlI
	 QzUKcJPdlm5I128kqYpSszVpF4bvRoMHYWsTtOtGqXtmn94tZ9dE/dw/a+uZTnH3X
	 uUHHyMoi4FlxVwEmYfmqrWtKysJgfnFrncNohZXcgGuhTHhipokkIkXh6RjZQSLDY
	 rCu/CbAyhmLMR0yjXQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N0Zo6-1yQ5vf42GC-00xp3U; Wed, 25
 Nov 2026 12:40:00 +0100
Message-ID: <16fa9275-b2d6-457a-ab30-932c98a52c1a@web.de>
Date: Wed, 25 Nov 2026 12:39:59 +0100
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] archive-zip: fix prefix stripping for extra and
 virtual files
To: Junio C Hamano <gitster@pobox.com>, Dominik Maier <dmnk@google.com>
Cc: git@vger.kernel.org, dmnk+artist@google.com
References: <20261119192311.2685319-1-dmnk@google.com>
 <cover.1795543448.git.dmnk@google.com>
 <72c0d0c0a43cadcc61f0187c86b9bd9361079a42.1795543448.git.dmnk@google.com>
 <xmqqbj7dhiv8.fsf@gitster.g>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <xmqqbj7dhiv8.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:148pTv/XfAwTMteqEvDigoP3WnmECP1QzicTE4kgAXClsmysKYA
 K/ogcAMD/766JKQ2inpdkBPvYcUt8ScUAnZ8GUCG+aIvoP0HCQU0l5QxxGYtvdOawAlk13G
 cYjBGDa1uKWme7YDSnOG+dmZmTFdFVQiw0fkcXnIyr5qEQEt+Mt8KFdfynqXlWFoiTtehlK
 DfGl4wYimEqaliho9c6JA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:H+9iQfIAAbA=;pb10ZbN6uP0GObVNohlzh705j7U
 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
 KSd+G84SN4dzFZwEwGH5k8bVNnYQ==

On 11/25/26 1:09 AM, Junio C Hamano wrote:
> Dominik Maier <dmnk@google.com> writes:
>=20
>> write_zip_entry() unconditionally computes path + args->baselen before
>> passing path_without_prefix to entry_is_binary(). That matches tracked
>> tree entries, which always begin with the final --prefix stored in
>> args->base.
>>
>> Extra files added via --add-file use the per-entry prefix recorded when
>> the option was parsed (info->base), and entries from --add-virtual-file
>> do not carry --prefix at all. When a later --prefix is longer than the
>> extra or virtual file's archive path, path + args->baselen steps past
>> the end of path (and for --add-virtual-file, looks up worktree
>> gitattributes along an arbitrary virtual path).

Oh, good find and straightforward fix.

> Because by default parse_treeish_arg() directs attribute lookups to the
> index with GIT_ATTR_INDEX, and only consults worktree attributes when
> --worktree-attributes is passed, saying just "gitattributes", not
> "worktree gitattributes", would be slightly more accurate, I think.
>=20
> It does not affect the conclusion, though ;-)
>=20
>> diff --git a/archive-zip.c b/archive-zip.c
>> index 279c3a2d72..db4a96553b 100644
>> --- a/archive-zip.c
>> +++ b/archive-zip.c
>> @@ -271,7 +271,8 @@ static int has_only_ascii(const char *s)
>>  static int entry_is_binary(struct index_state *istate, const char *pat=
h,
>>  			   const void *buffer, size_t size)
>>  {
>> -	struct userdiff_driver *driver =3D userdiff_find_by_path(istate, path=
);
>> +	struct userdiff_driver *driver =3D path ?
>> +		userdiff_find_by_path(istate, path) : NULL;
>=20
> Checking path =3D=3D NULL case here may make it easy for readers to see =
what
> is going on, but because userdiff_find_by_path() already returns NULL
> when path is NULL, the only effect of this change is that we now avoid
> the overhead of initializing the static attr_check, when only virtual
> files are checked, in userdiff_find_by_path().
>=20
> As an optimizaiton, swapping the check of !path and one-time
> initializing of attr_check in userdiff_find_by_path() may be more
> effective.

That would help workloads that only ever call userdiff_find_by_path()
without a path.  "git archive --add-virtual-file=3Dfoo:bar $EMPTY_TREE"
is the only example I can come up with on the spot.  It would also skip
the sanity checks in attr_check_initl() for those workloads.  Not sure
if that's a good deal.

> Either way, falling back to the "default" driver (whose '.binary' is -1
> unless configured) correctly drops through to buffer_is_binary().
>=20
>> @@ -365,6 +367,8 @@ int write_archive_entries(struct archiver_args *arg=
s,
>>  						  canon_mode(info->stat.st_mode),
>>  						  content.buf, content.len);
>>  		} else {
>> +			args->base =3D NULL;
>> +			args->baselen =3D 0;
>>  			err =3D write_entry(args, &fake_oid,
>>  					  path, strlen(path),
>>  					  canon_mode(info->stat.st_mode),
>=20
> For entries added by '--add-virtual-file', clearing '.base' to NULL
> stops write_zip_entry() from doing path + args->baselen or attribute
> lookup, and the next '--add-file' iteration restores '.base' and
> '.baselen' if needed.
>=20
> Mutating args->base and args->baselen inside this loop leaves them
> pointing at the last extra file's prefix (or NULL) when
> write_archive_entries() returns.  None of the current callers in
> archive-zip.c, archive-tar.c, or write_archive() inspect them afterward,
> and extra_file_info_clear() runs only after write_archive() finishes, so
> this is safe as-is, though saving and restoring them around the loop may
> avoid surprising any future caller.
I wonder if it's time for a struct archive_entry prepared by
write_archive_entry() to avoid per-entry changes to struct archiver_args
and pointer arithmetic in the tar and zip handlers.  Out of scope for
this series, of course.

Ren=C3=A9

