Received: from sonic313-13.consmr.mail.bf2.yahoo.com (sonic313-13.consmr.mail.bf2.yahoo.com [74.6.133.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E6E57083C
	for <git@vger.kernel.org>; Wed, 18 Mar 2026 12:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.6.133.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773838389; cv=none; b=olZ1mn5UuQ2+gePfWwNRM5d/+vcD02AGSGxZVQiXwggUj4n/n633ncZGG2NNRGX8JGoBUWflNTgZ+Oppf5pRAe1qubiVa47EQ06RXBpB1kxk65aVe0rSltPlEIp2p0CN17d1WV9n4MmfafINNfjI/oj8xi/uVc3fsUsgBBnDSf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773838389; c=relaxed/simple;
	bh=pzwdmPZ+afy6BygN+4NuXkICDqQrKxibcHHrWQTFCcY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:References; b=JHPFA/98Jws77ethvtOg/2VdItfMSpTNlMRVOELnjp2n/gQslbgbTmt/3DxHgx+yEnHJtQL2IhupS/9H9RnhVrhwYOeh4WHj4f5Hav5eOj2cXCUF5adtRhcLouUvfUL98iy5pV0md30GGciaVu5Hj+HOL93Owy7PjQevVyfrsGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=WJoFNPQ1; arc=none smtp.client-ip=74.6.133.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="WJoFNPQ1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1773838387; bh=fNQ4V51pXD0WBlbYAN8Fyx6EL0C1xgBQIvrFironEoU=; h=From:To:Cc:Subject:Date:References:From:Subject:Reply-To; b=WJoFNPQ1ipMbhxxYZP41ekq5iVti643kz18Od/CfVxqhcuQWsKJR1wgk0N7SyHI/xqCwPGlt9pXEivwkCTmZIUCPSXJHA/W6rTuLRFzF9QKVRt/OS7Cw1Goj5iHcoAjo5uYtjWAFNfXFG8klD6awUvSV5VM7/e+O+A0QN7VLjKuJbO66OnKzeGCIrJEVw9hzBJq5prxJa0ttRCYhRd0JoiFLz3YrGSuaJ531dQKIhCi9OU5u9Hqj/uLMFh4laHudguoW/LNWHzwEv6s1bG7IbhVdkfn8D/fh2ZQX/U9VfUt1nUVjGR//q3QjODFOulnU/pQFzMk/m0dVvvKMTuG0iw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1773838387; bh=vs2V+NQ7Jjs0M1MPRR5bn2bcZsH87V+2MBZnZ9wm514=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=cxp5cjeo/cJ9N56oqz+CSlKLjrRExm6Ha3INJixVG1rHZEeE+g12tNFi7NbBHzN1hECdSu1mvEV1cwbLbfXwWB+XEVgKcKTE9Y6e1+Cm9y/jIxw6xDgEg67QRNMIm1FR+Nv1Sg6BC6J8Sf8hC5hfcJFD6EYZPh7rpI6eBTrnBLSfsksjvRqepoyUobWomTeyFc5M1M5C4FRrA84XkUdHvifGzptPkDJ7YpFlJbr2gGDh0r8P81zNKUgWmlN4j2MphNzMQOcPN0IUdtiKOVkWouGEjWayvL+frp5aG/QPne9xV6B4/9noWnwAieLvppQ0Vrll+TM5yQ5uqr62ERuZmA==
X-YMail-OSG: K9WCzr8VM1m6tvjM0qq0YlxaGXjEGJnF7DtHvkcabcV2QJHWuByJ2IqDRo5PuLm
 1VDUrkIZytc7uPTxEoyrM202qf1yTq0qywmngOP3DQkKSUp7N.ykjYeXpxbEyayPsAwdsOrVKZdR
 .T6f1ZiXaT1h4NhVERz4GCDmOpJC5ODVw0JDf1aNc.XCANlpnGmPTI19ZOFqejtsnmLGHXov15iu
 mxLBJNMbqDi0IH0xQ9dRmXwbwSEnY9TqN4nqgyv2o37z62jgM7jDwdD9P25GCC10AhLkkdvEdHbQ
 ht_U0urqF9XVHYY9wEkVQPiEGejZNxanXwvsBLfWZUhr4ZJcyriTwBywgQ7i1JrRrUJtzDUTM.4R
 sI5h5Y.b61YV7d3KZ9zMTCr.eLMTgX1O4us0z_uiYBvExJXgV0AP5m47X8wBYr3QMfui873ncoFn
 mfcZPhykfruW75gnyepGUnglbqnbfcUcbEGxZqaUG5d26vIsPCdKKRN3hJxpL1aEqZCtg1qJl82z
 fCM9MbBxVzKeEYi3oFgZzPYAaKBKDZ9o9IpCLjxq9HDUlBNhVLM0boSp8J1J4w2AQnrGnLbeOIRr
 Wl5nYdW9644tM0W3SzH82muPRfda_LEPt3.dG61b9Lln5VNjgip.GbpBvSf_7JyxRl4_OZXnh3Mc
 fbbB2baUHXQj9N2_DeBK5OzGijzNQJdGKVyynepXlK0R2nlei7.4znzkVbakCP5t73Y75LZrzuHN
 mc3uqv0F2y_6EQWEYw2Hf2.zmz4NPdKJwkmW9sPLUq3KgZtGwyuOM.zZ8snYZF.jt8cef9m1EWmE
 GB7jGdPj9vvFqtN4yczwVgMFIv_k_IO6_jVEAdIXqx_wuXqHAad96CNR0vAY94uPaYYZRec._tfT
 cCmphQEk_PcUvjONq6t3rG5Q8yjfOcKlTXA3YwNlrSTLM9J7LPso0FFPTC9cqckAhu3QCwWoJpew
 9TbZvg9l6N0CPdT1VQq6ty_bNKgAwqkrY31EppSp7dv3RWSQ.AW4v_M0dOCnwNz2WtSDdyMb4KmS
 G_8IDXwRFmI5lyn7kojvmPZW1dWfVIRhYQqYfOeApA4a9uiIzSnagA9uUh3kHPTHuFqKjqKXQniq
 pObRhowxDBSXAYLchglzZWlf5408Osr.NN_e9cRPPVw6YQOZSNlLS0RtgASg.TQs.hFOBexoeqV6
 QGpDHzxczGtBmJG10yb.kT7._yuEY5oT9UZIIQdkeoaY_hBPcLRNftmRNWn_lhaDbV3.SLnKLgae
 och4wEvzReCukd7lwamXT9k.5Ta3xwsYVrX4vzCVNnXiE8AtLQYSFri3pcLLM2JY5UIodEYKnSYj
 pOVXR5KfSB2uB0V4BWaszLN9AnA_6153xCSa8BiTB5Dq7zxKj1an_dkfwiaObkaXFgH5v2D5OXAL
 8Y8VweDOE8eVSeTcDp_nOgAvENf6OrdupSNHxVkP0Wzbt06ksgtjZIMPSfMSmgOuYGSnWA7Z14Ek
 CQNLl9I.vWGN1kENDXdMYJQTt1GbPLQlTpvY7JCf5Uwn7DGoaBl_kQ592dvFhcLFiewUmixfgaQE
 iTlgk7V5gISm3hVvfbHT_WuhynpErnwGNgT9W0HVhqbtgjTR1x0I6Q8JUbfuUYR3q6s5k5fyZ5QK
 1qSZlaDGk3_hJ8qrK31fFb7y6thlqAK.iRGbGqQKRT0kxzEn_26.x4i7mLW9G.p0nGwBngm64zWN
 10P9FH3FdKyUjQjJoEPpcQRwUJYGs1fH0udHN6.cv15OF9O_hriQiCoDMEfaqR9oyiGsPUMcGxRq
 EmmkZrzQEmjaEzZOdTGEVRBmC7gaZ0qHw9oSzafS_HWRYoBl0XV6fp2pkeZG7XCp1LBpWXr9RwDQ
 oX3qsgNM2QlKlHwWPM_kkbidgB0wc6JbZS20NFPm5EZtJn8zz5asnaTGiAPVPVmmqKyT0JIRHKbT
 fEW4VqvOi5Xm__p4OYftrTGFLaw2jsTjnJ1hB6MsW9BaMN2oV2xp4.SDzqQz9OCuDd7jEVTkbEwW
 oau2GdxAzMeWMapTZZPbq.Ez7Hdb4yYMEq295JKSNDIjfssgBxZAlVCQEfVN7mtgXK8XdQ.kfAFG
 CASPdKZSn0IppGBIczGBevJlo0n0mV9_7wFdbja8kIvTanbybfk9I8aj8f9l3CVKcl8UU0n0iX5A
 HbLZ55hkMfN0D26jHnew9rZYh8qMaqkvvex3gyp1oxbtVe0G02D2gZzCs261AkNKF7URritYtFxQ
 Ts5jFQEl.xqAeC._90uzf017nWOiUnTaiYXCPyEkrQDZT19q4pQNTJLIQsUytTNg818xjdwCPdVZ
 QjaqcwPIZduB8Sdv7WpnhhLmCTUYX
X-Sonic-MF: <jerrywang183@yahoo.com>
X-Sonic-ID: ea61cf02-c8a7-4ea2-a9e8-7cf5b3029f82
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.bf2.yahoo.com with HTTP; Wed, 18 Mar 2026 12:53:07 +0000
Received: by hermes--production-bf1-697f88457-thlw6 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 14fc1b424a46476ce353da9086e18cc6;
          Wed, 18 Mar 2026 12:53:04 +0000 (UTC)
From: Jialong Wang <jerrywang183@yahoo.com>
To: karthik.188@gmail.com
Cc: Jialong Wang <jerrywang183@yahoo.com>,
	git@vger.kernel.org
Subject: Re: [GSoC] Proposal draft: Improve the new git repo command
Date: Wed, 18 Mar 2026 08:53:03 -0400
Message-ID: <20260318125303.88730-1-jerrywang183@yahoo.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20260318125303.88730-1-jerrywang183.ref@yahoo.com>

Hi Karthik,

I wanted to send a brief follow-up on my proposal draft for the
"Improve the new git repo command" project.

Since sending the revised draft, I have continued working on small Git
patches to get more comfortable with the codebase and with the mailing
list workflow. In particular, I sent/rerolled:

 - an apply.c series on input-location reporting, starting from
   "apply: report the location of corrupt patches" and then extending it
   to header parsing errors and binary/garbage patch errors, which I
   rerolled as a single v4 0/3 series after review feedback
 - "t2203: avoid suppressing git status exit code"
 - "object-name: turn INTERPRET_BRANCH_* constants into enum values"

Working through these patches helped sharpen how I think about the repo
project's scope.

My current understanding is that the project should probably not try to
turn "git repo info" into a large catch-all for every possible
repository path/value right away. Instead, the core scope should be to
define and land a coherent initial set of path-oriented values that are
already grounded in existing repository setup / rev-parse style
plumbing, and to do that as a sequence of small self-contained patches,
each with its own tests and documentation updates.

For testing, I now expect the main command-level coverage to live in
t/t1900-repo-info.sh, while reusing patterns from existing rev-parse and
repository setup tests where the semantics overlap.

This also changed how I think about the timeline: I would prefer to keep
the initial milestones focused on a small useful subset with a clear
interface, and only treat broader expansion and cleanups as follow-up
work once the main direction is in good shape.

If you have time, I would really appreciate any feedback on whether this
updated framing is closer to the direction you had in mind.

Thanks,
Jialong
