Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5CCB43172
	for <git@vger.kernel.org>; Wed, 15 Jan 2025 02:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736906744; cv=none; b=msmme26q6YJWC2DtsdaDQ+JW+sklGX12w+ccL3uGZx7nu9OVwf59nJatwKCPOmMW8Clu5Q2eiiz6EA8drOolXtryVh2XINiZ91h5VJQbcOdRqf+AYzqaxswD3BYnPNhr3naiaxvXdmDY77V1bzph0xGyZPY7JaTXRSVv7rp92Ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736906744; c=relaxed/simple;
	bh=c3r1opwPMtX26HUWeJh4s17qrFz7xVlOM9nw4XI50ik=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=bMxPoCtbXJNNIWstRoTP37WDNFN1zJmy7/7pgz0+4EgaozsNK1BIgjTp2ZcewvtThaaQgR+TRh+prLoeSQo22NEyPCLs0ITYhKIzXxBxX+VQrdbtNrqOzVegnmlhMlsm8hGhkOKIne5c7RgFmYzfegyOGAcUaW9pOXqFrCX9CIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-67-183.cpe.net.cable.rogers.com [99.228.67.183])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 50F25Umw3172040
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Jan 2025 02:05:31 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Junio C Hamano'" <gitster@pobox.com>
Cc: "'Johannes Schindelin'" <Johannes.Schindelin@gmx.de>,
        <git@vger.kernel.org>, <git-packagers@googlegroups.com>
References: <xmqq5xmh46oc.fsf@gitster.g>	<4a3c949a-416f-734d-f63b-cb1b7f9b362f@gmx.de>	<041901db66b7$c0c759a0$42560ce0$@nexbridge.com>	<41d5de4e-c4b5-9564-6210-d9b8efddacb7@gmx.de>	<045701db66da$36a358a0$a3ea09e0$@nexbridge.com> <xmqqo70827df.fsf@gitster.g>
In-Reply-To: <xmqqo70827df.fsf@gitster.g>
Subject: RE: [ANNOUNCE] Git v2.48.1 and friends
Date: Tue, 14 Jan 2025 21:05:25 -0500
Organization: Nexbridge Inc.
Message-ID: <047401db66f1$f4ba6790$de2f36b0$@nexbridge.com>
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
Thread-Index: AQJA+s9gUSp+JMiiyH5dwYSAPcfMpgJ3TneHAO5qL90CiAGurAELKD7eActdH5yyBcp68A==
Content-Language: en-ca
X-Antivirus: Norton (VPS 250114-22, 1/14/2025), Outbound message
X-Antivirus-Status: Clean

On January 14, 2025 8:28 PM, Junio C Hamano wrote:
><rsbecker@nexbridge.com> writes:
>
>> I will not be able to package this. The reason is that only official
>> commits are permitted in the highly regulated customer base that I
>> have to support.
>
>Well, you probably want to be a bit more careful.
>
>Think what *exactly* is *this* in "package this" in your message, for
example.
>
>Will it be the resulting checkout of "git clone --single" of that tag?
Then you can go
>there and say "make", and as Dscho explained, what Dscho wrote in DEF_VER
does
>not matter.  The tag that points at that checked out commit is v2.47.2 and
that is
>what resulting "git version" would say.
>
>Will it be the tarball extract from the git-2.47.2.tar.gz that is available
at
>https://www.kernel.org/pub/software/scm/git/?  Then you can go there and
say
>"make", and what Dscho wrote in DEF_VER does not matter, either, because
the
>official tarball contains the 'version' file that says "2.47.2" and that is
the version
>used by the resulting "git version".

In order to accept our builds, the NonStop community needs to be able to
correlate what we build to a real commit from the git git repository. We
cannot
build from tarballs, as this cannot be certified by the community users.  If
they
cannot certify what I am building for them, they will not use it. It is that
simple,
sadly. That is why we worked so hard to have our builds 100% consistent with
the official git commits. Tarballs can be hacked. Now, if members of the
community wanted to do that, I would be elated at the prospect, and it would
save me hundreds of hours a year, but they are not willing (or able) to do
that. My key role is as a trusted build manager for the platform. I cannot
package a modified set of files, so I must skip this element of the friends
of
2.48.1, and ask them to go directly to that version instead of 2.47.2.

I ask you sincerely to please understand the constraints I am under.

