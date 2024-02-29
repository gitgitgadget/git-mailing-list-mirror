Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B3B17A158
	for <git@vger.kernel.org>; Thu, 29 Feb 2024 22:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709247438; cv=none; b=GX6jpOtJMtnCM5s/2SYOzcL7XcfHn4F9uJRUbbUxZv+jegJCa091WsVUHGTXqaffAK4Zhaz4Ubp+ATfaDf/NMJP781U1+QpX4pwcSw9wyGnA3+QrS3cE9IIsy5E6kZaO7rpDRlcREJs4Gdiz+6abpVH+bnzu9S3Lo/+KWyR2XC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709247438; c=relaxed/simple;
	bh=5T4jNpDcjk/o5T57kxnTiWke9PRlQnj1Rp/5HKhAdzQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gTNoCR1oPM0+QGMVLwi+j3cVaRqXHhN8DZoVvxShfByC7JX27sId2rT+u+vFYWlGmU0iv5lvPdTunDX2FE5sR3fhnbyya1sqfTnk5/rhhRbxnWf9zTVwjA5M4ittkDSnE3Z1867M17wUsfYqCa/6ynjn7wiIsHY0wqtD4o3JkDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=EAk+dO9S; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="EAk+dO9S"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 92E941E79C1;
	Thu, 29 Feb 2024 17:57:15 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=5T4jNpDcjk/o5T57kxnTiWke9PRlQnj1Rp/5HK
	hAdzQ=; b=EAk+dO9SsYf+sa9bkekNWn5EXuRsY82whU7BCNTzE4ad3aO1a0+geA
	+8qCU9+5YIXvw++X1xzfNGOk9Cc4K4ykjcdQYZbssv5ZnRq1EuMMkqNUuFDN7qTh
	2x975rISNdB2OdEhm7mrTSIAg3ojE7tpQBM7OKXUatporZQMPWc+8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 895AA1E79C0;
	Thu, 29 Feb 2024 17:57:15 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.176.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id F1DA91E79BE;
	Thu, 29 Feb 2024 17:57:14 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Dirk Gouders <dirk@gouders.net>
Cc: git list <git@vger.kernel.org>
Subject: Re: [PATCH 1/1] Documentation/user-manual.txt: example for
 generating object hashes
In-Reply-To: <gha5nigaq0.fsf@gouders.net> (Dirk Gouders's message of "Thu, 29
	Feb 2024 23:35:35 +0100")
References: <cover.1709240261.git.dirk@gouders.net>
	<a3902dad424983a4f0dfcda68e0b8bf64a0b2113.1709240261.git.dirk@gouders.net>
	<xmqqil27c5p1.fsf@gitster.g> <gha5nigaq0.fsf@gouders.net>
Date: Thu, 29 Feb 2024 14:57:13 -0800
Message-ID: <xmqqedcudgl2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 E179350C-D755-11EE-9589-25B3960A682E-77302942!pb-smtp2.pobox.com

Dirk Gouders <dirk@gouders.net> writes:

>> I'd rather not to waste readers' attention to historical wart.
>
> Yes, but -- I should have mentioned it -- the document itself suggests
> to read the initial commit.

Ahh, yes, we'd need to hedge that part.  Good thinking.

I am still not sure if the first hunk below is a good idea or it is
too much detail.  The second hunk may be worth doing.

Thanks.

 Documentation/user-manual.txt | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git c/Documentation/user-manual.txt w/Documentation/user-manual.txt
index 6433903491..1027055784 100644
--- c/Documentation/user-manual.txt
+++ w/Documentation/user-manual.txt
@@ -4093,7 +4093,8 @@ that not only specifies their type, but also provides size information
 about the data in the object.  It's worth noting that the SHA-1 hash
 that is used to name the object is the hash of the original data
 plus this header, so `sha1sum` 'file' does not match the object name
-for 'file'.
+for 'file' (the earliest versions of Git hashed slightly differently
+but the conclusion is still the same).
 
 As a result, the general consistency of an object can always be tested
 independently of the contents or the type of the object: all objects can
@@ -4123,7 +4124,8 @@ $ git switch --detach e83c5163
 ----------------------------------------------------
 
 The initial revision lays the foundation for almost everything Git has
-today, but is small enough to read in one sitting.
+today (even though details may differ in a few places), but is small
+enough to read in one sitting.
 
 Note that terminology has changed since that revision.  For example, the
 README in that revision uses the word "changeset" to describe what we
