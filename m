Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1630D3B38B1
	for <git@vger.kernel.org>; Fri, 19 Jun 2026 16:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781884929; cv=none; b=Z1zI0Wd4dv+8ojfoJWH+iG2Ee49TgdSjb3cWW3EU2EZrIo06eTwHUx42gdGc82rK7Xc9SkXZ6qQZqRdGNr6EJtL9Ib0G+hDql5kHXxO0pR4C9g+RBq7LOps+yDF6hdswNu22+dBj575KrNaqaukx3bUw7ObZU6cuAdDntuUyClw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781884929; c=relaxed/simple;
	bh=Igy4eCMRa9yrkOvNGx2Goc29UssfSgm7c8JkwLSM1gw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J6cuEEV4Z0NvRpBOSTDabbW4nMxbSCk13cxIdbiOwwkkY57LU8v509Z0rqvEd+M2PivTCG0wa5J+YQ0TPLD7qOPcFbsoQ24sp2wevLzJGTsqEFOeUatLVoudVWsRmf9hZQsfrtttMmXvXE71jZsxFbWT5D7ZBgI5EqtncgFCHPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev; spf=pass smtp.mailfrom=malon.dev; dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b=denjiRjT; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=DcZW1Tjd; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=malon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b="denjiRjT";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="DcZW1Tjd"
DKIM-Signature: a=rsa-sha256; b=denjiRjTE/HUIV0IyezPKaGcQgeomoJ7gSMzvU0qoWjAfjzYgQX6xwhmMX3BcM0S8FzxNLJYg5TetAHqOi7BY01XgpmPeKdJRGCxcOMKwo7ueRem+frxRbI3CZ8+d6ViTHEf1G1M8L1gG2mnvPFI8lrILg7CwTcEzq7j4TFrO6eo/1odsfpgpQeGIzBDrn5Ko9GBCdQXiyzIXskty/O0OA6+dqz5atTpi1jvidF8pH2xIsh6V4Ujm9QkpyOxxvJhP/0sjOopLxToRug0O8miSwtKWo7sU+eicUtFllWjuc3t4W+8mbY95fJuydi2N0U08mMphW/iCkXUNFTK5EGLbQ==; s=purelymail1; d=malon.dev; v=1; bh=Igy4eCMRa9yrkOvNGx2Goc29UssfSgm7c8JkwLSM1gw=; h=Received:Date:Subject:To:From;
DKIM-Signature: a=rsa-sha256; b=DcZW1TjdfpBRnfP11TV/6WZ4r+i2cR2sYiW5ctwJyUqXuvdlyfh7ds84QZRk6vOG4//kZl1nr5vyWlBuIuuHi/lFn50LN+KjEHsTRJ/JNL9PHkUafKctNWrVaUGJyIKp0yFXsZ7OGgK1JOzJaYiRYr0KflHBmpH+IyCdXlQvXqvNjrmpScbUWXk+P5nCotJFjGdv+UXw3rtgNdApKbTa7sdDaQoWy6lNTrldet/XOMbfaU1KTuIPs55TBV21NZBOR55SUHB5AlPch2qynpGe7GspIb3c0KIYKeQgfjU/+ZDRg2qVqhpLM+X4mB+4MIg1Jvm4PY/tWqHQnM8boAWwIA==; s=purelymail1; d=purelymail.com; v=1; bh=Igy4eCMRa9yrkOvNGx2Goc29UssfSgm7c8JkwLSM1gw=; h=Feedback-ID:Received:Date:Subject:To:From;
Feedback-ID: 599969:32685:null:purelymail
X-Pm-Original-To: git@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 1735248667;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Fri, 19 Jun 2026 16:02:03 +0000 (UTC)
Message-ID: <b0ad1eba-a4e2-418b-816f-5861b029cf23@malon.dev>
Date: Sat, 20 Jun 2026 00:01:57 +0800
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] environment: move ignore_case into
 repo_config_values
Content-Language: en-US
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, ps@pks.im, phillip.wood123@gmail.com,
 johannes.schindelin@gmx.de, stolee@gmail.com
References: <20260617154929.564498-1-cat@malon.dev>
 <20260618114207.605211-1-cat@malon.dev> <xmqqldcct2hx.fsf@gitster.g>
From: Tian Yuchen <cat@malon.dev>
In-Reply-To: <xmqqldcct2hx.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail

On 6/18/26 21:14, Junio C Hamano wrote:
> Tian Yuchen <cat@malon.dev> writes:
>=20
>> Related materials:
>>
>>   [1] In this patch to migrate protect_hfs and protect_ntfs, the approac=
h
>> of introducing getters has been endorsed.
>>
>>   [2] Derrick Stolee's previous attempt. The reasons for the failure are
>> also mentioned in [1].
>=20
> [1] here refers to the starting message of the whole hfs/ntfs thing.
> Do you mean that people must read the entire thread to find out what
> the reasons for the failure was?  For that matter, it is not clear,
> unless readers read the whole thread, where the approach of using
> getters was "endorsed", either.
>

What I meant to say was that the reasons were already mentioned in the=20
_cover-letter_ for the patch which the link refers to. It=E2=80=99s certain=
ly my=20
fault for not expressing myself clearly. Nevertheless, I=E2=80=99ve briefly=
=20
explained the content of the link directly in the cover-letter for V3.

>> [1] https://lore.kernel.org/git/20260606143412.15443-1-cat@malon.dev/
>> [2] https://lore.kernel.org/git/2b4198c09cb6c04c60608d19072d419503dfe5df=
.1685716421.git.gitgitgadget@gmail.com/
>=20
>> Changes since V1:
>>
>>   - s/repo_get_ignore_case()/repo_ignore_case()
>>
>>   - Use repo->initialized instead of repo->gitdir
>=20
> I do not think I have any objections to these changes from the
> previous iteration.  There may be some other things in the new
> iteration but I'll have to go in and read the patches to find them
> out (if they exist).
>=20
> Thanks.

Additionally, I=E2=80=99ll change 'repo->gitdir' to using 'repo->initialize=
d'=20
for the previous three bits as well.

Regards, yuchen
