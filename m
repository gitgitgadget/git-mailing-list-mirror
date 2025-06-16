Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27E951A4E9D
	for <git@vger.kernel.org>; Mon, 16 Jun 2025 01:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.92.39.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750037840; cv=none; b=tQX4/f9GSaPN/Fd0lio1/kaxJs2cjuT3xZc32xWO83ZZz46hiN3KXysoHIzrZgRoiLfLmlnm2SIGqAbAOr7JcDZ6f8dH9RF7KdhTe0u/7z+zqOyHefRpEgM/etkQE7oHg6DaeZvb0MXjLQ2Jc4GzOl+OqJ1t6mpThlLkRb4Z99U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750037840; c=relaxed/simple;
	bh=TVvYazM94YWM+yWuDvIJhl98qK+MvJNw/t/fYSLWRWc=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=klH+dRYnAd8pXyn1e6nrT49LGySSY3K8FbSoLZMavg+Jyyj0riM2n2GnmUWA/wP4V9NOny7yIjqQtwWPULhaddOJBHSCqh2dsP1Pi6w68JG7NRB+/A19E+WEmuKGF5pC85gF+PouFZBKnOhgXo25vZBKHFTNm7ZJQ60c0ljE22o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn; spf=pass smtp.mailfrom=smail.nju.edu.cn; arc=none smtp.client-ip=54.92.39.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smail.nju.edu.cn
X-QQ-mid: esmtpsz16t1750037806tb6abc293
X-QQ-Originating-IP: Wsu8yO2monF7wvXwXnGPJhyEfEYqr+Du80cxjLFkAvE=
Received: from smtpclient.apple ( [36.152.24.169])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 16 Jun 2025 09:36:44 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 11394354650335228698
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [RFC PATCH v3 0/2] small fixes for git.c and setup.c
From: Lidong Yan <502024330056@smail.nju.edu.cn>
In-Reply-To: <xmqqbjqo4gw7.fsf@gitster.g>
Date: Mon, 16 Jun 2025 09:36:34 +0800
Cc: git@vger.kernel.org,
 ayu.chandekar@gmail.com,
 christian.couder@gmail.com,
 shyamthakkar001@gmail.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <0AE631DC-F4C6-4896-BAE0-F0D35E4E642A@smail.nju.edu.cn>
References: <20250614050331.304405-1-502024330056@smail.nju.edu.cn>
 <20250615144604.1447302-1-502024330056@smail.nju.edu.cn>
 <xmqqbjqo4gw7.fsf@gitster.g>
To: Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3826.600.51.1.1)
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:smail.nju.edu.cn:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: OHTF91J1Rz8hE8FNa9SA2Eh1KkyQFBeYl+N0dZZA/I7OzlweAEvDV6KY
	TH8FlgLhC0slK0mEVQb+LEO6lLWS1f3vVW9WuBGrX0ZrnJDmsxxX+eq0WF9qucNhjnbAolO
	UXcoes7B+2Ie+Uwk/Pz05At7F8VgmgRHe7e+ezbbiVhuJT1tshmvLcNHf72DONintPOrEXo
	tYiFeOgXnzhNdOFGDgo5Eyoz4grj72H6nv4gZekOktz9ljnDRjF5voD38E+1HbzJY23q+ew
	3CX41tIe1R9E0m6i8YlRQ5+VKwp3sh11k9VUgS7tjaxmr9N5KivJDFxOYyIa4Muil2n4A2H
	4c8WcscIppbRa6EBCLbNJ21HQJDlZORXtK0q9kPnn4GC+zei0FF359N0/GJtw4pl5pXuo9E
	fNkS/dRmrqqVf62a9OzDLznU2dRE2r/r3+F77f1sb3Vr7pbgNILOP/3g1XwcE4kKknIf1Tl
	V1NiXMQejMq+LQBfCZEnmHba/wcs+TfUjJPII6DgF1VumAZ4fiYZI5iwDXBU5yquUNCiN+z
	AZ0slGHi4euSNd/oeegJYCZKmbd/fuHdKrQGD0U1PpYSaII3yO0sYyzWm94I2zz4uq8m4nj
	X49FlNuFgcot15DveGXQK+5ULQrV6AZCXWXu2+3IkCEPpuqwsGR2mNCq0XB2EKy3oZLcOjK
	6WT+/l6+Dx71ByHuc/v2myiKYS3QdG3+b4AVefpc0bJ6RB/sSQNivC7OmX8vwMBsK1K0mlD
	z8B0I0WQe2xFP0Pl65bwmV6FDdNK+isAEBBK9IpDK7p8Szi106msf0YiBBw/5twsCfGex8Y
	QwP6Mn8f1l88VcEaH1TmWew1OqVsNb8teDLGFwu4OaZg6emRsnYFoAsHtuwnc5D34rQTvVR
	Yf8Y9QazviBZgDM8o00Xz2QVxyf/3JiS30O/s2aH1k2L7FZUd8DfrRRt+dqaiVPIf/LxiKA
	uMsV8V+VJ3+dIk1YuZexO7zNsHZGx5ZJfbz/amFSpeG1vLsDuShxxF4Y/AaTAxb820EasBY
	ZRY2iO4+OX6CW7H3r+
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
X-QQ-RECHKSPAM: 0

Junio C Hamano <gitster@pobox.com> writes=EF=BC=9A
>=20
> Lidong Yan <yldhome2d2@gmail.com> writes:
>=20
>> I've been reading through the git code from the beginning. This
>> patch series fixes some NEEDSWORKs and cleans up some unnecessary
>> uses of the_repository that I came across.
>=20
> FYI, when we have "NEEDSWORK: do X", the intention is often "we
> haven't spent enough brain cycles when we wrote this comment, so the
> first step is to evaluate if doing X is a sensible thing in the
> first place, and only if that is the case, do X".

Understood. I initially thought that NEEDSWORK indicated work that was
guaranteed to be implemented later.

>=20
>> The first commit replace the use of the_repository to run_builtin()'s
>> argument repo. Since each caller pass the_repository to =
run_builtin(),
>> this replacement is safe.
>=20
> That change is safe.  I'd rather see the comment left intact or
> reverted to the original shape to clarify what code the comment
> applies to (see the other message).

I=E2=80=99d like to revert the comment to original shape and split it =
into separate commit.
The reason I changed this comment was simply because I found it a bit =
confusing
when reading through the code.

>=20
>> The second commit takes care of a NEEDSWORK in =
setup_git_directory_gently()
>> we now properly error out if we hit a .git that is not a file or =
directory
>> when looking for the .git.
>=20
> We used to just ignore and keep going to check the parent directory,
> right?  Now we would error out when .git is a FIFO or device or any
> other random things.  Is a bit of behaviour change, but I am not
> sure if it is worth doing.  As finding these weird non-file things
> in your working tree and naming them ".git" is extremely rare and
> useless (from Git's point of view), I suspect that the user is
> deliberately doing so for whatever reason they have, so it smells
> like this change has very little chance to detect a real problem
> with a larger chance to break a set-up that was deliberately done by
> the end-user.  I dunno.
>=20
> Thanks.

I would just discard the commit about NEEDSWORK.

Thanks for your review,
Lidong

