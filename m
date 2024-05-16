Received: from sonic306-19.consmr.mail.ir2.yahoo.com (sonic306-19.consmr.mail.ir2.yahoo.com [77.238.176.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6150145A06
	for <git@vger.kernel.org>; Thu, 16 May 2024 12:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.238.176.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715861100; cv=none; b=pYX41AVSWvcCGCzjRC7sqH3JLnL/3R2daGfHG0eUCw83Do27jOjMR65T4s7N+i4bGNyKBNV24CuqWkYqKkOuqnP6RwfjohYEzOJCs1f8/oWHE0BfXplLAwAHtBTr6b6OKqDpkYyLYk2bRqD3GfTyYmJFyH8SBGeGHkTSLsmuYto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715861100; c=relaxed/simple;
	bh=wnD7+pYlvnatYTBpwuIU2wmL2t+Sh0kP75j+SgnlEi8=;
	h=Content-Type:From:Mime-Version:Date:Subject:Message-Id:To:
	 References; b=CDmX9VhI9fV0k/appIJwFDVSIQTayBez6MiYVQO1qPj1yne+Lg73b/t2/1sdNPItVKTT+YLrLsarJ7dSZVx+UJFGq4eblhXXaZVNqbFUeanB26BJGVDYIUfBuPC8OfU0EFkCgLJmv/elRBaxROev60fqKwfX5W/IJ58EKh9ExrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.co.uk; spf=pass smtp.mailfrom=yahoo.co.uk; dkim=pass (2048-bit key) header.d=yahoo.co.uk header.i=@yahoo.co.uk header.b=gN7BcVaQ; arc=none smtp.client-ip=77.238.176.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.co.uk header.i=@yahoo.co.uk header.b="gN7BcVaQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.co.uk; s=s2048; t=1715861091; bh=wnD7+pYlvnatYTBpwuIU2wmL2t+Sh0kP75j+SgnlEi8=; h=From:Date:Subject:To:References:From:Subject:Reply-To; b=gN7BcVaQ1JJ+WzwUB4V6zgKC3FiPPSUGrjbThDLpMH2FnIaadfijyPQkI7IHM7EiA7fDXHwMMTe2pQF4M63saxI0tt/tQDhxzfpzjyzvjCAkAPI9/kAiwN6MtLk+TfFPY3n1sQxinjNhTJQ4RaZu8wjhW7cjCE0Wi7BUDZ/+0kvLz0hfaO6mIgiuvkyi4NYZRhCNesj77t8wBit/fvLnqMzM4ePu6yA+1xbAgW3iplR+o4JZnoSJtKyuWaC8EeJ8HJkFaDrVrfAubLPbXRqMUqcMaWdb1nfvHvha21eiQTaasb7wIn6Qmkx+iECZiivqQBUIg71BPnXXKee1nTb51g==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1715861091; bh=OqS5TaTRmJabFcSvhg7pccwGt9wbW4a7QJCJoSFcE5/=; h=X-Sonic-MF:From:Date:Subject:To:From:Subject; b=Y5tKsarqyqWpMmWicogl1G1jOWRCzWx6Nmk/UpwaRaYNi4AqyyGBB9fYESNj7BgsHq4HkKxkMlHwashkkDsRFsXmKYRH2xU6aE/o7yogTq521kKf6dvuo4bPRPM/xbIoxzLB3UvLwovjUtLcM1/8wOhfyBE2tij8HmRtV1TgrHFTC74+r61388Jz/B5y0uOXeE2q0apndm0C1iEyxMyvA5bUjFq+ngkezteptI502DcrW7XCin9NtuOzr1xJMWrK704PMwmKTK+JmnUCjSab6ZHwSH0P+kDUEeshH8jZ1bYhTxAnB+ESeQpU0qVvOijP4qaiPCXzaI3ygU70vOzrhw==
X-YMail-OSG: _WTjSD4VM1mjo_XU.DyZlLwILKdK50n775BiiMCTGtEPcOm7rT5SfW81HIRBqJf
 fS4A_OQsi9HsrGzpalBnSkYk1lUcwGgL9_aUf04Jl7DS22RD97KnV.E3jYQX_f451iEhfrzGleqH
 NTU6_18a3BAPhpIMOCdWHxHXQA5DspRw5CRLDn0T20KhtDPaBEY0IAfXLsjofl4HDvnu.kurqFO7
 8XFHaWxyE_QYR7y1AJCowVnDzHfLieBtFYyFXDLmcKRHFeNlG86QJCGlTfm9avHjebDW77paguQG
 9KbyHTXeYrbY5A5Q8A2yOMWfiotfiDUiw.sCPf97QUpTNaztQu3OLnvV2UR3L82ONnMSTsRJFKMI
 tYcd8iMVzdCl72KhRR4cSQg.kE1zX418E04hP2wDskvXnP7wNLBKdhwAk_wXm_u0mIpLgBE5qSh7
 ORpzn1nvmmhR7G3aozJeC1F2KOrvbIsF3hJdkNadXUHziRGxMSNghA8JVgWRwLdw2DmKI0WLhz8M
 lBfauAgL2Fz.qRAcIHMzpm.tIwG.2KMdwg512OFLS1PV8iuxP1xObk2eq0DN_DH9QCW1ppOIqumO
 d3F_MoTi5KmYrsz_NPermdFw69ahREDK_EdtxS5XpWMitEdTXn2IbhRKjTC4xSSLGteFOgo5hqPw
 dukN438RoFsFeEwMp5fJiRFSQl2aAuxUf4a_jmdIEaflLoEXmU.XXLfVEvqRJN0j7TZAS0fwp_LV
 OOzkX_ucg4doS8m.QL5fsj8VAiEVyUZbxD.cJdLtinFNAiZuVe6unWh_R78QHIPosIUbaPpIO9ZN
 9rz1pBWUzhjY6WK1T2L8L38x9BuzajSp9xpUL7Drlg5ewpSQ5ZPkpGLgx9Lw0hTNTGI8mkWMxFYe
 ZMNCKvJTH0u80jgTY70Gwc_BCMxoIbrwQ554xStUKuBneiw0ZWGlCnFQnB1uHWaDM5spDCEihp1_
 acJ_Z6pH4GLSRKcUYUXG5wBd9zUS8jMgFMc9DTDJ.uvnS4NRma4k7rCCdCz1HOD2HtkxgDUiG3oG
 sKD8.xLvkPl1mgmo_FfuWrLdQNb6J_t9YFSrH6iUAwLB6QK3tistosasuOMaergDSh_ToiEWSNUO
 ICljN1U2.cgk9MnUhbBFQgo2E0pxccfarCeONx0jxqD8XormMry2S7LM2EiBe_07IKr3SMaffbSW
 .CG9HwbVqs2RZDVdhmUfNAYSlKodmAmisMnBf1tCQAma6QVtE6dJkQxTgkSpmxyBXDr5UxhMtQXg
 YLl7QGwmKNk1CvndFQFTdjcVMaSX3nGc8l3FUKGECVMAPTeL_n2q2hK6zDhGuEBhdYurJHYQAR8g
 AgBDlXf_hnhTePRw1oX6tGPJFvulttYMa36vOzzXOceUnCrDx1T6fd3BAT3Tb5nP0kqKTsJ.xk0K
 dCHG7lfq69Xw2DSIp1oT7yEMOvDp12lbY8KCz4x0WuZMrr24PP2q9WGJuA_w8DsuAdqHHQffGXB9
 ZAJaCduus4Iw.3HA7B7KdtFv5zsq32NikBRABP_jsLPJflgE40xGXx9TR45rCNaeZAUFWx.Sv8Ws
 41LYIVA4kv53efPiN26bHgEOQJGlgU2_4I.wTgEkMPb9Sc22KK_KbpgfSd_o50A837OpNmdhmLk2
 H4c_z4qTCX6u6gGMhEMxtoUh2FpMofAuIa.11J9YJaTKm0LaFy34._kdwuAvZTvU.W4z0UudodVL
 dLDmFBCb41xjdo.wVHv2yy6RVAt2aT6XxHkXoFBUCeiHEamXa.9._oz6o8QuqTKjvEUr.tb4N03U
 f5sV_6ROkbOlWxCHBCJ3aQaCYyWkEOv0pnSyXBDg53z.GflNbCyoKGUxNp1PzDGhlW8NCoiZfMlq
 Zv465hhpwp9GXXUQNS_2hexp2o7kOsVuGreKyaYNqYHukLXRFFZsJp8QhVTGz.wmD81FI4WCsqZL
 AXMiib5DYJ1cBDZ9.U5O8XkCtSSls31wMOBstHB0pIg2kseSgBI8tsngPTA4J1oT29eY7mtgPnRH
 duOvGXaJCgOs15BaPLXID4JdcKi0I1UJOqrjZIDGqyMnyk0_uE4UmYA6N5Ty6PMSqi2pBpUfQQfq
 .VPjR6EuDF9fmKFeJyBfWIjrcEHBc.vQsCP7dvA8FeDLxOgCJAeFm9G638XKrNDyuHVzYtjGedaK
 qMiUIfPbSmSKK7JruhaT8e3iWscMI6w5IjlVcQoAi8w8jiQGq73KZduVX7m7DQrDau.pdt2wp1O0
 uE3WxKKGcwri3sXQuyxOdyApYNLeIAT8ZWLgI
X-Sonic-MF: <s7g2vp2@yahoo.co.uk>
X-Sonic-ID: 06d48ece-db45-42c6-a2f7-0237b4a96271
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ir2.yahoo.com with HTTP; Thu, 16 May 2024 12:04:51 +0000
Received: by hermes--production-ir2-7b99fc9bb6-457mg (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 3bbdae6becebfe83fea37701b618674d;
          Thu, 16 May 2024 12:04:50 +0000 (UTC)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Kevin Gale <s7g2vp2@yahoo.co.uk>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Date: Thu, 16 May 2024 13:04:35 +0100
Subject: Embedding Git Command Line
Message-Id: <36B52407-B52F-4394-8DF2-F2DF3D3F0504@yahoo.co.uk>
To: git@vger.kernel.org
X-Mailer: iPhone Mail (21F79)
References: <36B52407-B52F-4394-8DF2-F2DF3D3F0504.ref@yahoo.co.uk>

Hi.

We are looking to embed version control features into our commercially licen=
sed proprietary product.

We haven=E2=80=99t made a decision on which technology yet but Git would be a=
 popular choice.

I=E2=80=99ve read =E2=80=98Appendix B: Embedding Git in your applications=E2=
=80=99 on the website and determined that our choices would be either to inv=
oke the Git command line tools or integrate with libgit2.

In theory, the command line tools should be easier to integrate with and we w=
ould rely on the user=E2=80=99s Git install rather than bundling the Git sof=
tware.

What I would like to know is if integrating with the command line tools woul=
d still fall foul of the GPLv2 license or if there is an exception like ther=
e is for libgit2.


TIA
Kevin=

