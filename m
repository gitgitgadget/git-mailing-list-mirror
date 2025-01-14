Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 244422139B0
	for <git@vger.kernel.org>; Tue, 14 Jan 2025 23:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736896550; cv=none; b=iffNtaLClEZ768i7RwreFru4DhqlwiVfMskCI0ecrKA1a7md7tYHhjqVdPplwzXiuSMq2HMIDmB07HjllG5QRWm4Uc4vr00mGqzOIep1ddS03CHioRzfGerva1ehRR4W0pBjw6nVkYorXixIHD3GhWgf4Aq2ziMI4VeQ/KuLiWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736896550; c=relaxed/simple;
	bh=JXJgebrThW/u7p5z9G8uktiGCX2sx7OLeNsbuoV9xVM=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=CGtOD7Fnd15WTMM1XrsWDMWs3IgcmjWBR0UNqYLSubyFb5v5fPwT2e2tDnC5xPoDllXEhBbwSFVvOV9LbmPwMvtw0W/hfPCXOmwnSKsnhc3dpA5B6e2o2XIvKUYuaiMa4EYOfpFk17RSQS/Ad0ItN9/nYlg0adxI/g9uTC5QeyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-67-183.cpe.net.cable.rogers.com [99.228.67.183])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 50ENFXKc3148378
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Jan 2025 23:15:34 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Johannes Schindelin'" <Johannes.Schindelin@gmx.de>
Cc: "'Junio C Hamano'" <gitster@pobox.com>, <git@vger.kernel.org>,
        <git-packagers@googlegroups.com>
References: <xmqq5xmh46oc.fsf@gitster.g> <4a3c949a-416f-734d-f63b-cb1b7f9b362f@gmx.de> <041901db66b7$c0c759a0$42560ce0$@nexbridge.com> <41d5de4e-c4b5-9564-6210-d9b8efddacb7@gmx.de>
In-Reply-To: <41d5de4e-c4b5-9564-6210-d9b8efddacb7@gmx.de>
Subject: RE: [ANNOUNCE] Git v2.48.1 and friends
Date: Tue, 14 Jan 2025 18:15:28 -0500
Organization: Nexbridge Inc.
Message-ID: <045701db66da$36a358a0$a3ea09e0$@nexbridge.com>
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
Thread-Index: AQJA+s9gUSp+JMiiyH5dwYSAPcfMpgJ3TneHAO5qL90CiAGurLIcT3tA
Content-Language: en-ca
X-Antivirus: Norton (VPS 250114-22, 1/14/2025), Outbound message
X-Antivirus-Status: Clean

On January 14, 2025 4:05 PM, Johannes Schindelin wrote:
>On Tue, 14 Jan 2025, rsbecker@nexbridge.com wrote:
>
>> On January 14, 2025 1:44 PM, Johannes Schindelin wrote:
>>
>> > my apologies, I only realized _now_ that I had forgotten to update
>> > `GIT-VERSION-GEN` in v2.47.2, it still has `DEF_VER=v2.47.1` (but
>> > all other mentioned tagged versions have a correct
>> > `GIT-VERSION-GEN`). I am very sorry about that.
>
>[I fixed the formatting, not sure how it got screwed up, it had verbatim
mbox
>headers and inconsistent `>` prefixes in the quoted lines.]
>
>> Oh gosh. Glad I did not hit the "build" button.
>
>Well, depending what that "build" button does when you hit it, it might not
even
>affect you, have you tried it or at least looked at what `GIT-VERSION-GEN`
does?
>`DEF_VER` only sets the default version when building e.g. from a tarball.
>
>When building from a Git checkout, though, it uses the tag and everything
is fine,
>the output of `git version` will say that this is 2.47.2:
>https://github.com/git/git/blob/v2.47.2/GIT-VERSION-GEN#L15
>
>Also, you can always hard-code the version by writing it to a file
called... wait for it...
>`version`, before calling `make`.
>
>> I will hold off packaging that version until this is resolved. It is
>> definitely needed by the NonStop community.
>
>I'm not sure what you're implying by "until this is resolved". I hope that
you don't
>intend to suggest to re-tag and force-push v2.47.2 because that's kind of a
serious
>no-go, those tags have been relayed to quite a few people well in advance
of today
>during the carefully-orchestrated coordination of the embargoed release
process.
>You cannot pull that
>v2.47.2 tag.
>
>In any case, if you don't want to build v2.48.1 instead, and if you cannot
build
>v2.47.2 from a Git checkout, at least that `version` file method should
work for you
>and you don't need to put pressure on anybody else to get the version that
is so
>definitely needed out to the NonStop community.

I will not be able to package this. The reason is that only official commits
are
permitted in the highly regulated customer base that I have to support. If I
modify any file in the git build to "get it out the door", my community will
not install the package, even if I make a fork of git and do it there. My
personal commit is not considered "sanctioned", so the package will be
ignored.

If 2.47.2 has a mistake, I will simply skip the release, and tell people to
move
to 2.48.1 to get the security fix instead of 2.47.2, which is not going to
make
them particularly happy. Sadly, this is my reality.

--Randall

