Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C1638FAD
	for <git@vger.kernel.org>; Fri, 29 Nov 2024 23:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732922288; cv=none; b=R1n71t1Ncpc4DiuJ2XMaz3TyRCPBlQD+NBZD0cmtAoRU1AKp+weWnePySR3jPK+0lKdoj/8SLiQ2lH/Uo6IEm3pm3n+00puVEA4VD2TMYk2/s9RaJ7wfCeuNCtBc+O0pD1FLNEOBh180hsltFEy+v2v27ZAcyZOeeep9UrRlfPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732922288; c=relaxed/simple;
	bh=P3lLZp4ghk/2dZI8sOzostsgOPzXqO1EbSS5il5UFiQ=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=QbhfFelEh6douRx9hx0rp+a1THt8yEKhlBJ5qFTVDtYTjxcupl5ovugyJ+xRxhD8AvHoQy6JXctGhzBv6q2JeCYMh5ps76RKYgKsPAU5pmhYYKy/4TWHN804NmIWv/vflM4LMnX6WeJhEe4Fkd25ep9SKHFFj620azsR6xl+q0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-67-183.cpe.net.cable.rogers.com [99.228.67.183])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 4ATNHq5O2430553
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Nov 2024 23:17:52 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Caleb White'" <cdwhite3@pm.me>, <git@vger.kernel.org>
Cc: "'shejialuo'" <shejialuo@gmail.com>,
        "'Junio C Hamano'" <gitster@pobox.com>
References: <20241129-wt_unique_ids-v2-0-ff444e9e625a@pm.me> <00c401db42b1$99c4d5a0$cd4e80e0$@nexbridge.com> <D5Z1L479JERN.80KZ7NA9BWNJ@pm.me>
In-Reply-To: <D5Z1L479JERN.80KZ7NA9BWNJ@pm.me>
Subject: RE: [PATCH v2 0/3] Ensure unique worktree ids across repositories
Date: Fri, 29 Nov 2024 18:17:47 -0500
Organization: Nexbridge Inc.
Message-ID: <00c501db42b4$ea97e050$bfc7a0f0$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHZQR+UqnR1y6U5HdhCIquXTuJIeQHx0ACsAfNKDdGys74hcA==
Content-Language: en-ca

On November 29, 2024 6:14 PM, Caleb White writes:
>On Fri Nov 29, 2024 at 4:54 PM CST, rsbecker wrote:
>> General comment on this series: Is there a mechanism of preserving
>> existing functionality for those of us who have existing scripts that
>> depend on the existing branch and worktree naming?
>
>Existing worktrees will continue to work as they do now. The only =
change is the
>worktree id for new worktrees. However, there's not an option to =
preserve the
>existing behavior for new worktrees (nor do I think there should be).

I do not agree. Companies that have existing scripts should have some =
way to
preserve their investment. Just saying "No more worktrees for you" is =
not
really considerate.

>As stated in the v1 threads, the worktree id is already not guaranteed =
to be equal to
>the worktree/branch name (there's several ways that this can occur), so =
it's buggy
>behavior for scripts to make this assumption.
>Any script that needs the worktree id should be parsing it from the =
`.git` file, `git rev-
>parse --git-dir`, or (with the changes in this
>series) `git worktree list`.

I agree, but I think having some kind of notice beyond one release is =
important, rather
than pulling the rug out from under people.

Just my suggestion that there should be a migration period of this =
critical function.
--Randall

