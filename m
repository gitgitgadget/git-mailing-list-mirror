Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC8D42750F3
	for <git@vger.kernel.org>; Fri, 26 Sep 2025 13:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758891775; cv=pass; b=gB4NzHQZrEG02+K0aFsdLRgcbbMtZuyQ/b9WzOwh0eOI/wCyZz8C+0v/B/C+tbecgonPUCiJU1n+E5S4+ru3I219XJAsbIc/eu77iv+o9hilXaHM7Bhlrgj8pRVtLQIEObSxF35f1s0rhqEX3itP3qSFhz+rRai1lR8A/6hdnR8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758891775; c=relaxed/simple;
	bh=J+YrwNgoRvvtP22vKWbfl7T9AciK2HMb8L8Pns9+vxk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qidfePSnU1EfSf1EZdhkZKzc59p+ALu/C3Z9BFTf8TJ/K0ysxkzb1dlUfKlVxL0ZtwvkDV503iGSkrx3hrPRakN4vGAKH40ReSwl8wtBGAwRKsCSvkTuiXBk6K6YaLk2H1NXM0jIQI8lPL3YmyoAwoYDvtiHTruheB291g6iXc8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=a71RvAxw; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="a71RvAxw"
ARC-Seal: i=1; a=rsa-sha256; t=1758891756; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=APWShsm0yXmNAUuAzOGZV+tahJFkZGWIYM3zlFKr+Yzo1uvRXqs1nS/sLlq7ixm9duptoOL5+h1guqZFGMaiu0OAKj+Glqr7B4230uGRhIy6b9FtXuspS20Wc0Y/heiWjgVk4CgTpzeclAuKMyOcyV44xLn7qTv2nCZyxhSrrws=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1758891756; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=J+YrwNgoRvvtP22vKWbfl7T9AciK2HMb8L8Pns9+vxk=; 
	b=YOQs7fhWXuIDyskzO3vKoPBMS8rlNfoKSUkJwTiJnWRSKLEwLL6NiNxjwEKqyDRg+hVKksKcs8muXQfgaCgVAYITtDCrpeiObLeX/SPyWdeRoK6y6D99arrEPDh/U6BaHIYaMCWgkriDqqR1NyZytSVyW4i6EJWyuLTqvORe9ng=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1758891756;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:In-Reply-To:References:Date:Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=J+YrwNgoRvvtP22vKWbfl7T9AciK2HMb8L8Pns9+vxk=;
	b=a71RvAxwHmXJI59LNVja/e83a+/ggus1wAOf2TnKXpSkEsFy8uL4lFY8bF6jIsVj
	kQknWPAg/rTgBNWcL3SA1iAJYc4ITB2PRryKmN2vQqsI4dRXligoQEQ/WVdxz0Wn2Vc
	9ccxl9aGhK4Jyb1iSdlmj+11OAXw4RphpUNOLW3k=
Received: by mx.zohomail.com with SMTPS id 1758891752544386.1412599506805;
	Fri, 26 Sep 2025 06:02:32 -0700 (PDT)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>, Rodrigo
 Damazio Bovendorp <rdamazio@google.com>, Junio C Hamano
 <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>, Josh Steadmon
 <steadmon@google.com>, =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason
 <avarab@gmail.com>
Subject: Re: [PATCH 04/10] transport: convert pre-push hook to hook.h
In-Reply-To: <CALnO6CB0786UDZ_P7WHEETNj5YV0NigEjeOa2BSXvJzt6X4t0A@mail.gmail.com>
References: <20250925125352.1728840-1-adrian.ratiu@collabora.com>
 <20250925125352.1728840-5-adrian.ratiu@collabora.com>
 <CALnO6CB0786UDZ_P7WHEETNj5YV0NigEjeOa2BSXvJzt6X4t0A@mail.gmail.com>
Date: Fri, 26 Sep 2025 16:02:25 +0300
Message-ID: <878qi1nz8e.fsf@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ZohoMailClient: External

On Thu, 25 Sep 2025, "D. Ben Knoble" <ben.knoble@gmail.com> wrote:
> On Thu, Sep 25, 2025 at 8:54=E2=80=AFAM Adrian Ratiu=20
> <adrian.ratiu@collabora.com> wrote:=20
>>=20
>> From: Emily Shaffer <emilyshaffer@google.com>=20
>>=20
>> Move the pre-push hook away from run-command.h to and over to=20
>> the new hook.h library.=20
>=20
> Perhaps s/to and// ?=20

Ack, will reword in v2.
