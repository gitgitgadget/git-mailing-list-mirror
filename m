Received: from mail-40132.protonmail.ch (mail-40132.protonmail.ch [185.70.40.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A2BAD5B
	for <git@vger.kernel.org>; Thu, 14 Nov 2024 18:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731607432; cv=none; b=s6cyZ3OE3g8k6QG6vDOSb3pJ1OhsZAgZRQKY8c9OsqQj/Iu19Z4LXtKqxwv9+G71MNSI9qkeyHsYRuxWqaBkkFtuctcjcSQ4HK8cUyjdDX28uVGmISvWHvlsDKS/vcJKNlOKBo3RLDdlmgmjSoytmnpUnB+n4twEAx+HkTjtjXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731607432; c=relaxed/simple;
	bh=3J04AkjzVxkqN+51utB+er9JRCPk/Mgk6Kn1uKJ/Lmw=;
	h=Date:To:From:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OXu1ptPQ2/YfGK3570SWtVxifgFRTGBUz5B59MDK2egVvaFxDsi9/HL4VqKCvw7HHWP+AVtavUekvPj001kw5VYugt8IvHcCKOLrijZqzF2cYPhTes7aKyZO9WcNgW9EAOVt+0E/UeiQ5Rv3HpomM8ZJYudUiVrVyeaUncePqkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=QlILyLM2; arc=none smtp.client-ip=185.70.40.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="QlILyLM2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1731607428; x=1731866628;
	bh=3J04AkjzVxkqN+51utB+er9JRCPk/Mgk6Kn1uKJ/Lmw=;
	h=Date:To:From:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=QlILyLM2pz+ZMSeSicjxo1FKoVhU9KmEhW8KvKUsxa+XxdYzCkOCXwwn3ZlgZCy0u
	 7TJq5VyFXMNQEUPdNr7cMhn30W0caQUVJaJRIQzmnbZ6BRqDTucqzAUrrW/OMTbP/h
	 6GiZiPE46zKtz2KXipNF5KnI7ti+nP8biGqkrlNh2Svg+fa6XebX3PxEbG608EHmhe
	 drrX+mrFCp/E0OJ84cjOr8Wst5z/YaGILxBAVf6P9TNVikb2a7Z44KX2F4ooiUmRlI
	 sAln+B1VVAj/OsT2glkqL5mxrk4oGT5/CFktuz6FhQKO/E1SmcZjIDQfvMf2A8TZtF
	 3uSLLMmlW0M9w==
Date: Thu, 14 Nov 2024 18:03:44 +0000
To: "git@vger.kernel.org" <git@vger.kernel.org>
From: A bughunter <A_bughunter@proton.me>
Subject: Fw: [bug] user may be cornered into delete files #9901
Message-ID: <XdBUcr7M60BIudOE7vay5rAdPqP06WOrPnt0ORM8QtlkEr980kTDIxtCJUySclvxfuFiyinGtvTmCBrhe4Y4mtwZcNgseoTb6JtzgIjrwWI=@proton.me>
In-Reply-To: <ZJaaSrglj_jUGE-7IfLWHaUIKKLGlw1SJfPP8MeyvdVKO7iMFhbTQaBKeJVLePFGkw3Dvo1co7B6MBKkTN7v5J6hRqjb8yHiB6_-4H8PnAs=@proton.me>
References: <P_ttzPnNTtUgpAy8cg_ntLvwskJhz7cmv-fFgDw0K4Y2vOCx8v_AXxHtHEuBtpREOQu9pxpvK6JgLusc5Uyn2wDZ4HZvC3ttM4k-Ry6jBs8=@proton.me> <ZJaaSrglj_jUGE-7IfLWHaUIKKLGlw1SJfPP8MeyvdVKO7iMFhbTQaBKeJVLePFGkw3Dvo1co7B6MBKkTN7v5J6hRqjb8yHiB6_-4H8PnAs=@proton.me>
Feedback-ID: 120910843:user:proton
X-Pm-Message-ID: d87bdfe2b2303c06468760e9540d9aebc9d65f1b
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="b1=_I08kjFQg5gXX5JLSjz8HsRUeqovftpumESLcsKhc"

--b1=_I08kjFQg5gXX5JLSjz8HsRUeqovftpumESLcsKhc
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable





from A_bughunter@proton.me

Sent with Proton Mail secure email.

------- Forwarded Message -------
From: A bughunter <A_bughunter@proton.me>
Date: On Thursday, November 14th, 2024 at 17:56
Subject: Fw: [bug] user may be cornered into delete files #9901
To: git@vger.kernel.org <git@vger.kernel.org>


>
>
>
>
> from A_bughunter@proton.me
>
> Sent with Proton Mail secure email.
>
>
> ------- Forwarded Message -------
> From: A bughunter A_bughunter@proton.me
>
> Date: On Thursday, November 14th, 2024 at 17:53
> Subject: [bug] user may be cornered into delete files #9901
> To: git@vger.kernel.org git@vger.kernel.org
>
>
>
> > [bug] user may be cornered into delete files #9901 pls see https://gith=
ub.com/cli/cli/issues/9901 and look into all of the links.
> >
> > from A_bughunter@proton.me
> >
> > Sent with Proton Mail secure email.
--b1=_I08kjFQg5gXX5JLSjz8HsRUeqovftpumESLcsKhc
Content-Type: application/pgp-keys; name="publickey - A_bughunter@proton.me - 0x66540805.asc"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="publickey - A_bughunter@proton.me - 0x66540805.asc"

LS0tLS1CRUdJTiBQR1AgUFVCTElDIEtFWSBCTE9DSy0tLS0tCgp4ak1FWnUwWDF4WUpLd1lCQkFI
YVJ3OEJBUWRBSDBJNDdqRHNQWjZndmIrWVVHQm5BeDdKeWYxNEFWT0gKeGE4eTArZG1ONWJOTFVG
ZlluVm5hSFZ1ZEdWeVFIQnliM1J2Ymk1dFpTQThRVjlpZFdkb2RXNTBaWEpBCmNISnZkRzl1TG0x
bFBzS01CQkFXQ2dBK0JZSm03UmZYQkFzSkJ3Z0prS2tXWlRsUXJ2S1pBeFVJQ2dRVwpBQUlCQWhr
QkFwc0RBaDRCRmlFRVpsUUlCY0F5Y1oybE85ejJxUlpsT1ZDdThwa0FBRDlGQVA5L2RkVDYKNTZH
a2E5TnRNdm1kb1k1a3ROZ3FiWTVYYmQ5Zng2a1BFNS80dFFEL1hpaWFsS1FIam13QXRiY1NlMVEr
CjNjeFlMeE5oalU3bXluUXNwdjlkeEFET09BUm03UmZYRWdvckJnRUVBWmRWQVFVQkFRZEFuZnAv
ejJGdwpSa3B2VWdmN21xWUk5UktuVFZhZHdHZmdhUUxobXdnM0x4TURBUWdId25nRUdCWUtBQ29G
Z21idEY5Y0oKa0trV1pUbFFydktaQXBzTUZpRUVabFFJQmNBeWNaMmxPOXoycVJabE9WQ3U4cGtB
QUppOEFRQytmbk9tCjRWajlRbUg0SDBHVnQ3UnVPUUsrd09RMVBSdnB5bVNqZXlCSk93RDlHWXV2
eE9BVks4aUF1cEorcHB3TQpyMzZWdWtJZTFwWHVIbzlSaGp2ZUF3MD0KPUZRRncKLS0tLS1FTkQg
UEdQIFBVQkxJQyBLRVkgQkxPQ0stLS0tLQo=

--b1=_I08kjFQg5gXX5JLSjz8HsRUeqovftpumESLcsKhc--

