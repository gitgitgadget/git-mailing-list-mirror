Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED4D13A88B
	for <git@vger.kernel.org>; Wed,  3 Apr 2024 16:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712162370; cv=none; b=VGgGTsQERb28eJyi2lsb9Uk9kxRcH+HN15jZSj4DvLpARjhmwOZxcmtz98YZcwfYC9uaenpZ0MdAmgO65jdlnaxJdExQv8Zors3/by2pks+RcH4vhvMVicldMFtEEIxBweboemKoaLuCTwR7q/J+QupXeIquKOMMyC9kFoC931g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712162370; c=relaxed/simple;
	bh=yjUjLmNCLHIFLsiiAkjXhDgSYf0zWJaI4/iGXWEX9OE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QFx40ZqNQ7YlFQ/b0WQOyrWVtRiWXzlt8D6qLmLyyO2UlGwMAOsGfNyZhu9eggv1eMn+LF8WHLh94QrD1HQt770u1QqYW26bQprgSGvE5EyX5Clm2sehmeF/hWWaEMKEuUw4Huk1bunU1hqW06tiQ0h7mufWWMvrhmhFS9FdKrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=tx/+4Ugl; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="tx/+4Ugl"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E47AE1DB295;
	Wed,  3 Apr 2024 12:39:21 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=yjUjLmNCLHIF
	LsiiAkjXhDgSYf0zWJaI4/iGXWEX9OE=; b=tx/+4Ugl3jkc6n8mySwAsoM9Acl+
	kVra+4fFJP7suRNsfx5riB3ZKQLH7aUQMiutVUgWG25J6K0AAZbUNXuBUVSWRhS8
	dj6YsrsEFum5/TTMrZ7fK51+VBMPVH/zOY2KrN5nTt57SyKxNbhHnOYahEsuDoPb
	g9iVm+YTacNZIng=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id DAD301DB294;
	Wed,  3 Apr 2024 12:39:21 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.229.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 45B4C1DB293;
	Wed,  3 Apr 2024 12:39:21 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Matthias =?utf-8?Q?A=C3=9Fhauer?= <mha1993@live.de>
Cc: Linus Arver via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Johannes Schindelin <Johannes.Schindelin@gmx.de>,
  Jonathan Tan <jonathantanmy@google.com>,  Emily Shaffer
 <nasamuffin@google.com>,  Matthieu MOY <matthieu.moy@univ-lyon1.fr>,
  Linus Arver <linusa@google.com>
Subject: Re: [RFC] git-contacts: exclude list
In-Reply-To: <DB9P250MB06923CE0F60A117A5CA5B028A53D2@DB9P250MB0692.EURP250.PROD.OUTLOOK.COM>
	("Matthias =?utf-8?Q?A=C3=9Fhauer=22's?= message of "Wed, 3 Apr 2024
 12:11:47 +0200
	(CEST)")
References: <pull.1704.git.1712017205754.gitgitgadget@gmail.com>
	<35192e61-c442-6719-caf0-1019bf3e44c9@live.de>
	<DB9P250MB06923CE0F60A117A5CA5B028A53D2@DB9P250MB0692.EURP250.PROD.OUTLOOK.COM>
Date: Wed, 03 Apr 2024 09:39:20 -0700
Message-ID: <xmqqsf028kp3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 B8EFD63E-F1D8-11EE-AABD-78DCEB2EC81B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable

Matthias A=C3=9Fhauer <mha1993@live.de> writes:

> Would it make sense to have a way to teach `git-contacts` to exclude a
> user defined list of known-bad recipient adresses? This could
> potentiallly be an extension of mailmap or a separate file.

The contacts script already uses "check-mailmap". =20

Unfortunately it only uses the default mailmap, which may not be
suitable for our purpose here, but it shouldn't be too hard to run
"git -c mailmap.file=3D<custom> check-mailmap", ship a custom mailmap
file with the contacts script to map defunct addresses to something
that is clearly invalid, and then filter them out from the output.

We want to add a mechanism to allow "including" another mailmap, so
that "../../.mailmap" is included from contrib/contacts/mailmap or
something like that.

On the other hand, if we want to use our primary mailmap to also
mark the defunct addresses, then we do not have to do anything
special.  Mark these defunct addresses to the primary mailmap to
map them to "$HumanReadableName <$name@defunct.invalid>" and then
doing something like the attached.

diff --git i/contrib/contacts/git-contacts w/contrib/contacts/git-contact=
s
index 85ad732fc0..00e77c4125 100755
--- i/contrib/contacts/git-contacts
+++ w/contrib/contacts/git-contacts
@@ -197,6 +197,7 @@ $contacts =3D mailmap_contacts($contacts);
=20
 my $ncommits =3D scalar(keys %commits);
 for my $contact (keys %$contacts) {
+	next if $contact =3D~ /\@defunct.invalid>$/;
 	my $percent =3D $contacts->{$contact} * 100 / $ncommits;
 	next if $percent < $min_percent;
 	print "$contact\n";
