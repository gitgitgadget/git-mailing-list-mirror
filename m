Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E38CD4825C1
	for <git@vger.kernel.org>; Thu, 10 Sep 2026 12:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789042901; cv=none; b=BqI/puuIwS5UZ2bPsQD+8jDNtX1iR09HE5OrPMtYwGM+pJ/MhYbxJB3iF1LViU9EKFe8S1Nw7Oz8rDl63UtoX3krHsySNcyogjoyrVpsdkgZu4s85QT3bHvFMNqNV4INdN7/JapU+ue0k1BDDdRODqJP3vmeoBLv4idbRNNqQdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789042901; c=relaxed/simple;
	bh=Nbx6lqnAbh+wkqJWRdtKr08cxgHYzKfS1Mr8u5ghK4w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZWZkHUSOultZ/xBC+WMM/5RlMluFIWZhqCWLa8ACqb7Jj22bWLw5Dmxdw6zLnVGnVpmEEHgnmqjuiH3ZL2ZVqJYgVu5u8sOqOkChnBRmRb2c87miktRyeS1wSeMx0uUujp25VswtbFhzkXjblWf2QJ5uSS/txIwc8lOQcYxup3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=qOYgAeVo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=A/ItEXzk; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="qOYgAeVo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="A/ItEXzk"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id C13B4EC0118;
	Thu, 10 Sep 2026 08:21:38 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-07.internal (MEProxy); Thu, 10 Sep 2026 08:21:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1789042898; x=1789129298; bh=zBjgpvrkK+
	rOgx6dipPcUTQNtsOlH1/VU95dloBK0g8=; b=qOYgAeVojq2qmxLDOy7Bx9bfv1
	FJNQUuzgsxA65Qz3+ldz9oFZ3ikV4IFnhgfeuH5Ll+XeFEUnCJxqzD96BlDMAdFJ
	CrVScoZfsfkl5i75oa+brEX+z1G1F4iVHb0oIUD6d8c8uPRiyd8FLZGEeAtYVtAR
	gTPV3ELa+vHr8caylSCerw3bLXqqtFVP2MOm29eG+Cy2PGOu2vqdpyMi2XxdODlT
	7YXAocwxd/c/LTB8OTOsmm/dSI3Oix3rff6WI5x3IXg0BJi6DJ/NgjysU5CzDDY+
	FojRi4Kda/VVMoYBoLz4xqjDjsec+dCJn+gTeDSZosI1UBLkHVUu61lOcVdQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1789042898; x=1789129298; bh=zBjgpvrkK+rOgx6dipPcUTQNtsOlH1/VU95
	dloBK0g8=; b=A/ItEXzkmY5YGddxRA6YgMhjujLpaWmocKWhFsTBw2MfCV3TYfK
	7zI3HlTUXh5XYVDpmrIYQzkC0TBtwmaed35eWPoeV/LzXNS/yIN1AEwjEFr9b8kL
	WTpJvdPl11qHC1jyXTOzhqSwDT8IXunrtLKyWAde2dzsHjH0npPiCniEHvqivQbj
	iyZv+pBOmKfyg98/MBitGXSRC6eB1YWS9g9NnTTKrys6FHqWz6xYNXkNWn04ZaNB
	78YKYr5TQ16TylYvFaNJKPHS2QxlR9mM0avm/legRi35UwFDwAmA/td73uHIXHBe
	Izb0875JjZcg7td06hHsZIml2b4/eMRdWrw==
X-ME-Sender: <xms:0qCiaqlY-mPudfETGCf3Zwj4JovrjDzYx0fMW_4WbaDzUOlJDNeQpw>
    <xme:0qCialjXfL5bUaaJu0YaZhGP6zd5n2rBd2NAd0rZyHGBYDSnzo4ig6FUqc2Rw1B9-
    x4f4I1J6XpIRYZDBCWcaBglaCKchbZDSPzhhdFw32ObTlzGuuxQm54>
X-ME-Received: <xmr:0qCiaicbhGIVfAvYZTZPtRkDNKE4FzYEp3GLbHZLMknhwonVdKfzOlF1dIiiRb9aQU2NpAFNbLEg5aZxGpeV4sj87UeRUmhqsLhy>
X-ME-Proxy-Cause: dmFkZTFz2S7e1xIWPOv6DV7PRhnx/HOOgPPe/ZGDyYT/rXjl+hp2oY2C36ir0tyvK0W/hU
    VjBKTY/VxPmXcv4NmCE+FqMhPq7ZXaSHbjBy63uF779aPBhXQpk+V2HyDSEOCM66KB+MXh
    DkD3MMTfYK0pgzrdS60l9NtYwzzNjPwDjTKg+qxndTyff+Xauws5Bm9nHem6hy7RKE3NzE
    37zlWgy6dfwB+PNCGCLf5/R+ojTwMkRDNOO/EqWQzZenuIRyE/qztbaTUe1Pvgw6Qsen0y
    DsNJSCTBs8Mp2NrEXZHyYJrnWd+NZRphc/0hmKXxHkpMxVEsResY59FeWBpYwVaGsXthN3
    Vq5ibAubN9YtQ/QiJFenVftqvOuBonihTspTgKVj+niq53xnx1wzkmm9zGUH+gaxegrimm
    Q//9LEz/t8+WyxW9ierCTRXXKyMoXuMwmbA/m4ofelynhHrG8Jb7b1HRx77DtjpfiGAI+E
    f531bN0NE6N7HFY+xSrn3kBdcPwO0HD0ZeuRKIu3pGST63XFQr4QDKQWRCRThExn8ITP4z
    7vUdM+1qNeeznMe8OO/buHyabYekdkiWKQcwH/xbw8kTbbpvjm+srUtK7eUcmG71X3fSJN
    oQrllAIrcOkrzX/3Rf/5etM6IcQAKhwlp3BRnIwkWCP347ThapMjhO7x96TQ
X-ME-Proxy: <xmx:0qCialgJhmBud9TGyvPqh528vi6Mmzg6JDHSZKvTpU6ewuJZSwhgAw>
    <xmx:0qCiaqzZDNnxh5SOo_U9z0Fbt9RbvW64hOYYYhWg5Di3YF1P9cJ6_A>
    <xmx:0qCiahNVyVdqa85nez5Pd00dolCF03w3z8GLnMG16gXrAzMRIEh86w>
    <xmx:0qCiarXBtDioocy6zgU5A09HdU-p_QHid4YSrEir93jOqyrsARTLPA>
    <xmx:0qCiapA5vUhu1iuOjAndDx6wWBXNHNtS7q8N62fKLwBj8M8nZnN1fS_x>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 10 Sep 2026 08:21:37 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Tuomas Ahola <taahol@utu.fi>
Cc: Mike Hommey <mh@glandium.org>,  <git@vger.kernel.org>,  <ps@pks.im>,
  <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v3] Move rust gitcore crate to a different subdirectory
In-Reply-To: <20260910062758.RcjdX%taahol@utu.fi> (Tuomas Ahola's message of
	"Thu, 10 Sep 2026 09:27:58 +0300")
References: <20260209224847.1416916-1-mh@glandium.org>
	<20260909013858.1729643-1-mh@glandium.org>
	<20260910062758.RcjdX%taahol@utu.fi>
Date: Thu, 10 Sep 2026 05:21:36 -0700
Message-ID: <xmqqwlst2t67.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Tuomas Ahola <taahol@utu.fi> writes:

> Mike Hommey <mh@glandium.org> wrote:
>
>> [...]
>
>> diff --git a/meson.build b/meson.build
>> index d86f2acd2b..b91d30666e 100644
>> --- a/meson.build
>> +++ b/meson.build
>> @@ -1782,7 +1782,7 @@ libgit_sources += version_def_h
>>  
>>  rust_option = get_option('rust')
>>  if rust_option.allowed()
>> -  subdir('src')
>> +  subdir('rust/src')
>>    libgit_c_args += '-DWITH_RUST'
>>  
>
> I think that's bound to fail---there's no meson.build in rust/src, right?

Thanks for catching it.  Indeed our CI builds are failing since this
topic was injested in 'seen'.

Will kick it out and wait for updates.

Thanks.
