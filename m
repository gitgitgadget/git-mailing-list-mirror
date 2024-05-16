Received: from sonic313-20.consmr.mail.ir2.yahoo.com (sonic313-20.consmr.mail.ir2.yahoo.com [77.238.179.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C54EC143747
	for <git@vger.kernel.org>; Thu, 16 May 2024 11:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.238.179.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715857958; cv=none; b=uTTMAmxiSA/57trFuhgI8stVTI289RdSqpM7Kdt/tcYCFhqIGvyUmKXXLKzDWnRnZcOf7A6LMr6Uj2CQkBOBmRw5hvDqfgVLJu9WIPfiJArbY0e2eEaxR5rcIosebUL6bLJnTXeqr8GkQ11XbVcVjP/0inSYuZfygXrU9rO+3VU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715857958; c=relaxed/simple;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	h=Content-Type:From:Mime-Version:Date:Subject:Message-Id:To:
	 References; b=BQo/MguTIQ2xfnE6NG9Sl16WZwZYuJenJCBVEMo8BepqJNuigt6xTE0hAI73oxETxX6vdbGHGXhZwGJ0KqSdcGr7739piJ+AO/DEhd2J8ewtgCseW6ke3uwO7Z0zUBGZLIP3HruWpdoBpycNA/5iCN7IU9FdHl4n7uFnuPxFHOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.co.uk; spf=pass smtp.mailfrom=yahoo.co.uk; dkim=pass (2048-bit key) header.d=yahoo.co.uk header.i=@yahoo.co.uk header.b=QL/3vko/; arc=none smtp.client-ip=77.238.179.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.co.uk header.i=@yahoo.co.uk header.b="QL/3vko/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.co.uk; s=s2048; t=1715857953; bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=; h=From:Date:Subject:To:References:From:Subject:Reply-To; b=QL/3vko/u1gGBSjOs1KoIKQQn0Nisq4HC5GYYjG3R3VOpNUiBopJAiXUfZ4veYSQeedU9NfquJT/w3I0DHPDhqaV4sJk4WgmTz4Fnhu5Xqy1DMVQZi7FqKNZrAgbLTDs8Mtd/iY80hFqC8bN1751xSh4fLZN5A+COLzWhlEX51tkDPjtbxv9aqPYjdLg+hFeabW5gZgPmom7skVVRdfUA4dEkFeY0VzIOmHcRd4VjBgX+MMbo8Ih7ewayiGWIpQCS0CwVwqC5X3yC78CPH/7pZgqReGhLW7aXN4FNc4NPz+HnFtDDH8XDtv+Nt6E1a7DdGN+ZUaaZCv321MmZNuWGw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1715857953; bh=p1ocimwff+hDY2ZmwtsJ2CVH/g49vVBVgz6PzzUjzqK=; h=X-Sonic-MF:From:Date:Subject:To:From:Subject; b=SDDGVU4gxK362B49+h5lfbO1MDG8rm6Amd2c9rbmkKBM/FfKHeD0L8R+tNhEwbYp7oOun1uEWNds4WuKJlhbJ0Y2nsfyzyf3NQ9vv9ZnqIKO6o88z4kf7M8HVX7zHLsRQwHuA4tTZ+k+GB4O+bV1kDOOlvFpwgRmNGqbI1jG5wIMsugm9RkqxpphrHGpsX7lFQaaFnKVdjraTEbDFMNFrFmdvJApCsxQRDYhSnMxUnsTWHE4w8T+89tuMbDMG+F79mI1905hrGqmjV6SNrF2NX6IwHIclK/TMF3iEkVXqWY44oceU7q2gWHSmtZUKtCg+74x3pLggcbnH7YtN6smUw==
X-YMail-OSG: k_LACIMVM1mRJc0UL6purYU24UJJNVJvhs5NtETAOMQJaZDWfYCPXYIVwHEYsXC
 HFLA85HJOGxZMia_0LNZ5GJcSmTYzBPpPjBn4VKtRg2jvIbe7_8Hi39KpbH2Nb6YuVf3HLWlCnQR
 XhFH1MJXKZu5ulsv3nFwl3.jyoCkYVBO.bODXPOa17d5Ze068DQJOBlhZkxh.xXJ0GRnmnlE2CW7
 UpGFg0Wi80_5l1jspuh9i5.4U4pNvQwauesmDqiTflZ_jcn8Q3tsoS9PRK1sfT9raa1AtQMC0EOo
 azrE0zdB5u60q_QhawKptbSE9aeX73E9PfmsQPgDRlmKhx.nHO4gN2yYcBGR7cMyKlpAJYclgG8w
 YD9dzTYnKe5fGpOZBzMw4kQdZxhob9HR734hau4T_hBf7HPBfJuNYIzkWY5Lt0_1VtIEl_QP7SYZ
 P.y87WKCRTi8Y0Ey7r0zKHyi8nRk1k3KPkuKOADFrm_766O5TgWiKxqf.lKTgKEVQFfwrbdVYp.A
 p7XivNFhLs6Znijj2OA.U6vIAlUkfGM59H3qGtYBEkcYWbcqkUV4i.qf474HHi02WoSXRPejSvki
 1TnRDP3BirlrSwqkAahum9YKmuPs.MmrlTDXEnwl__OHRssgaPAJyzKQrrIWUNGPcp.XFDC7Qls8
 ZnIMwew86DPP_0nqRI.Ep53nW7cIxDWTPyKfQQ6fcAX98X0vPHu7D8Gcv6VYFOyZGdBlhS4X0Ss6
 C04UF.ewJbOuOccfmxD5kPg22fS8DOweiqVfo1u_0oTDKqrXoi4_bDpe_zU2ZaLtHXZ2Ipd3sVLD
 bRAQwvpYHss4VtjX3Nb.J3sGZM9eJkrt7IfA0lnMr8rmpWCYkUrBYTwFaYZV9H5OYoJ6U4ajFi1v
 cyV.ggNYNAvlb8aAtX71BmZ9xmHYuo0MFZVj9haBLKSEfsbjPxJWyUD53m70Xciio3jmVcdKuhXe
 xjoPPgQxO77AiDrr6DZrwExieMSAF58LDhl3yj9Ch74rRBpziCTqw.hPO7.psMESudkjjxdr5IsQ
 SITHl8R98ek6T0dRQmm0tx0cYzjDFzdf8yG3zEXT39idaT9D83R43dL78_phDIshjddtzo7tRLit
 ipRA0aJ10XtllOv5ihmpuH3bLq9_8ls2OQBn58O2YZ3k4RC1RcEE80.FXkTboSGIppLWLCRCltQ1
 aWTksYszC0s0zRBgeqHkLCxFzsY2t6hEASePB3kPBxbCxIQTsNy.VNZ.Az0UF_4uJXihSV1BWACn
 JBeQue8gr.1MzEb2xRhGQ4Ktjnn5psxMVkXV77baGngrk.O7bjtEuyuGvxWIHlbjcit1iITQcGKA
 pnfGqVo54FWuuOAlcjZJN2Nki8jNN9nYEOAHmKoCIABVhmoxRIXYbDiMH3pRKyljBowmUx603pHo
 KFGe3QgDzgqSKz7_6HnsichryVqQXJOLscgw_BYbjRciUPVFydTCwVRAWuW1EjQKNlX.yIWNScmi
 gmyZQUtphDo6UgbQ.DrUu38gtgkP6s73wm1Bf7vlvsYv0x1gYtI4ohUv4dhRqOtXPKmUd5c5pIbc
 .PqUwSkoVPGwisBQraxxIs.ijErzpjr7Eth3WKjCGppPvJp05UmBhYZR2bdBor8kUoghUjI3jOoj
 XSELWYwymLXl.WBP2yttj0isD5fHc_xrbHxa8Q1Z75q2DVDUASgXYS8c49P77LlfNmJm4Ke26gcg
 pV5osqiVP0fCgiUmCo87_hTocfNKMkIcnQQ4YQFbD5FcxYqTQcKx8FmcD5byqi8NY1MClYJEuM9D
 DdEGxx9R1OSf3UgPKmVfg5FoBx1EonrJqEwubvKf5k4sjpHxQM4gIqSESwWQ7MTe9yjnI_iidqcg
 HzPy_G4TIsxJKpbSFJZhK3hmQaVN2t_H6JraiCJkDBzYRpJGZSidsF7CoB2M7HUy2w0Ys1SOfI5b
 1uN50TRX2J9zFfNhF.eoC1IE56Nj0HRZbrOCxXJg2mlJkMXwQYT0MK_iJIGXGcu_S8U8CexcnQSS
 SdzBTKU_OlUlqwbWqwEiG989tRBcXvGPo4sZ.ctStBE5Tp3cI.oDBkFjvbrkxKNpFjnbIxbXqFf7
 CnkTK06x5JgLaVbEcIaOKkbMLQakhap1hPfEB4NU.npumgJCKLaEy.XJhcZexPJXNu7dh9aP2i8P
 6NwvR8bfONxPZJrr.SpmJW0K3r1WJ_k2naYMaTC79jDMR8g01u7mHBOjGn7Q2wwxVAeaWldzy7b.
 EoDFu93ndojIYVwHLzxdPtbDvaBHSJ9z5
X-Sonic-MF: <s7g2vp2@yahoo.co.uk>
X-Sonic-ID: 8d1c8ee9-ce5a-4bfe-8ea7-873331a24dea
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.ir2.yahoo.com with HTTP; Thu, 16 May 2024 11:12:33 +0000
Received: by hermes--production-ir2-7b99fc9bb6-mp7rb (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 580fb1362ba9c7d0c3551660a98055e9;
          Thu, 16 May 2024 11:02:22 +0000 (UTC)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Kevin Gale <s7g2vp2@yahoo.co.uk>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Date: Thu, 16 May 2024 12:02:12 +0100
Subject: subscribe
Message-Id: <AA7553D9-B385-4745-8AA8-31BBFEF6A818@yahoo.co.uk>
To: git@vger.kernel.org
X-Mailer: iPhone Mail (21F79)
References: <AA7553D9-B385-4745-8AA8-31BBFEF6A818.ref@yahoo.co.uk>


