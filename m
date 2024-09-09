Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21DBB189BBA
	for <git@vger.kernel.org>; Mon,  9 Sep 2024 19:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725910144; cv=none; b=KfljbShGIKQWbOJu1Fv37Tbmtj/SvlQRoq+Gf5EpKgm2yRSsSUeIjq714/iEY2eEH/k7n+Mm48iNqCO90Ig/rN6bsGNkWdVaD89MDlBXaxnkWkKVdQw+4Ns+rGjbVE+A0ARLbj9X8Hedq/af767BN6O2TCo4W6LD4I13T8/fBZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725910144; c=relaxed/simple;
	bh=QYPMSBwe/kwWWgBPYbJh57Db60gL/kMXDuYTXVnOuEs=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=XY3MFcz1DuA8xGf01D7neiUVTTSsyqnA1O0BVZKIp7KE4kVsnpGIbxIz9mrQci+oFEHDqZC6iqZS+tEbVHypiRL/cD1GlBmCm91AX2PlbCVSbE9lK/Ju188STmi5hwI8w3h00NPu0jTwLoOoh8J8SoBjD/NCXtDvG1zBuPVAWes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-67-183.cpe.net.cable.rogers.com [99.228.67.183])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 489JSvY72717336
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 9 Sep 2024 19:28:58 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Junio C Hamano'" <gitster@pobox.com>
Cc: "'Okke Timm'" <okke@timm.sh>, <git@vger.kernel.org>
References: <2886189B-4BB5-4230-B7AF-94F97A13D72F@timm.sh>	<05b501db02ce$3bd49e30$b37dda90$@nexbridge.com> <xmqqy140pt67.fsf@gitster.g>
In-Reply-To: <xmqqy140pt67.fsf@gitster.g>
Subject: RE: [bug?] git diff --cached in a non-git directory
Date: Mon, 9 Sep 2024 15:28:52 -0400
Organization: Nexbridge Inc.
Message-ID: <05e201db02ee$84787380$8d695a80$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQECtl5qQJJXZVv1FQUxSbqG32FkJgKxJaxYAkSHU26z2MK5IA==

On September 9, 2024 2:40 PM, Junio C Hamano wrote:
><rsbecker@nexbridge.com> writes:
>
>>>error: unknown option `cached'
>>>usage: git diff --no-index [<options>] <path> <path> [...]
>> ...
>> Because you are not in a git repository clone, the --cached option has
>> no meaning.
>
>Yes.  "git diff" unfortunately has a mode where a limited subset of its
features is
>available and that is called the "--no-index" mode.
>
>Because the command is capable of working outside a repository, "You are
not in a
>repository" is a not a good error message in this situation, either.  It is
not that you
>stepped outside a repository that is your error.  It is not that you used
"--cached"
>that is your error, either.  You used "--cached" outside a repository, that
is where
>your error is.
>
>A patch to improve the error messages in such a situation is certainly
welcome.

Glad to. Can you point me at where this is generated?

