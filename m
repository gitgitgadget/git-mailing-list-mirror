Received: from out162-62-57-252.mail.qq.com (out162-62-57-252.mail.qq.com [162.62.57.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7591013C9A6
	for <git@vger.kernel.org>; Sun, 13 Oct 2024 15:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728834345; cv=none; b=VAwHWId5a7fxervO3m5bz7ySeWnYgjPGNs4woMwp6Wax3WgmLbEcYqBgk9V7sdaT4uVf5sCCFFCVC5x8VhEln7QapRdBLYLQbLUb0WLOqyvP6Q3B5IFYBs1M7YLaLlYC9pJdZL5g2nYrH25gxPoxskgrZL6jmaz7ZRoH/QCPZe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728834345; c=relaxed/simple;
	bh=fopDfpmZ/Ha5ZhPYNos5tuaCGqO1Jyf6r4LPEkSKnwU=;
	h=From:To:Subject:Mime-Version:Content-Type:Date:Message-ID; b=nfELg5srKOf8joDWiLs79Nnmz0cy6PCblS9VSjSSX72jmLbma3j9g2mMK0DNKgkPG56dWiHNtkea/bdTG/+bGwwHTnMUW3ByKwW9u2HdVO8f7TUQBNhudHkNOW+b9fFK3rUZ0WP5mRxOnlt8mwxk4YVrlaOJybn0NxeYGjrjkhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=pjnmzqMF; arc=none smtp.client-ip=162.62.57.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="pjnmzqMF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1728834332;
	bh=fopDfpmZ/Ha5ZhPYNos5tuaCGqO1Jyf6r4LPEkSKnwU=;
	h=From:To:Subject:Date;
	b=pjnmzqMF07PBB5BC+XkO8WuKGUI9E2rD7gO7ZK8LaXRzL2SFJo2+LI06+CNV6SEH0
	 AUXpo5E7ELndT+8zXNHKxa00zHM7hyv/jOoOryO7PHtFDhWL05aZKFcIaVI9pHAl68
	 wCYYfXOD/sDZDHnwsUHzJGJ3HiBgn+scGChY7vUo=
X-QQ-FEAT: oHWrrGTW1dDtz/MFGzupqCMH20Bzyq2O
X-QQ-SSF: 00000000000000F0000000000000
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
X-QQ-XMAILINFO: NH0oLxhOOEtdSCBd+i75yFxOgaWB/eUOVUPosx5o42MfF9cYo1zFAWlJ96VDkp
	 UAofP3KYRTCM5uC9ldP7/ojuqWHZ/D6bPRQSx0wiYq6GY/E9CE9HWNj3YcWFMqPolZuONQ4C6sFn6
	 4twTmJp54QVScvYE8iVlhxuJDNv5+IBB8KIR3Skwh0L63qf0v4CsGKq4DUd7IoTmm9K3snEG7bzhk
	 r6FedHFIqpOpT+7jtJIJpZHCUA4Zde7g5V/XPfc00YNzutMYtJyd28IFmOR4r3TQ6xKppAUip2tG4
	 Q9wANr9VdVOOpZTyNOf836FV3JRiVV8mpRVoA5pf2akMxbV5+gkOO0e7xOVDNrLJoPUG0Dj2meJVa
	 P4RgW9SA3yksixim8276H6TBdm7MgIpH07cXaGMsstZJBWuLRAobcpM2ksCgKqdmgo4O40utwyjVF
	 EOMh/nv4zyKtCy1kMsDqszmvxnncg6Dlmanmbuf+d9n1OlohcBHazcLP5yrxNQO0UlPVluZ3Z5gK1
	 PucQVfBzSjvt0p03Br46MfQf26CH88pMBP5rGJKpeGqGKSid5beMVvqt7jpTbZWpHiFNEd1ajoh+M
	 jOGMBrkAlZ52lxnitNSlijUbWnLVOumrfJeLq0Z+lo/rXHP2T1bFvadqn8NAL+5U9/7RiBorES4hU
	 z3FsEhsZd9fx+MuLnvIstVyW/da4T9t1IFQVgvzC5Zzlm7dgt/KPlmy57vfeEA69gXe7nY78cBPwS
	 kQHNvQHJnZRA88sHATnppQ7ge2tprPWU3pN0uxF5mwctyGjdks3UQUlEmiJPlyoFILDBJUW+SKh0s
	 kB21nCdi/33IjjmPTc86XKWa3qul6yt1Hk1XEBzZ8Kq/phtYac3Y1RqZ0wtbWyIdCiwjuaqjpFwYn
	 /kB4iB1ZQWuVie/9LpsMuIt8Tq4V0sv8HRYPI0f9HqKHIf7Ci4kx5UPafH8CFMMGhtIqq3iMvY=
X-HAS-ATTACH: no
X-QQ-BUSINESS-ORIGIN: 2
X-QQ-STYLE: 
X-QQ-mid: webmail649t1728834264t977557
From: "=?gb18030?B?zuLUqsrY?=" <wu.yuanshou@foxmail.com>
To: "=?gb18030?B?Z2l0?=" <git@vger.kernel.org>
Subject: Bug Report
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="gb18030"
Content-Transfer-Encoding: base64
Date: Sun, 13 Oct 2024 23:44:24 +0800
X-Priority: 3
Message-ID: <tencent_D0324DD61B7E04E0B4686FD8761E1CDDE108@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x

V2hhdCBkaWQgeW91IGRvIGJlZm9yZSB0aGUgYnVnIGhhcHBlbmVkPyAoU3RlcHMgdG8gcmVw
cm9kdWNlIHlvdXIgaXNzdWUpClVwZGF0ZSB0aGUgZ2l0IHZlcnNpb24gZnJvbSAyLjQ2LjIg
dG8gMi40Ny4wIC4KQ2xvbmUgYW55IHJlcG9zaXRvcnkgZnJvbSBHaXRodWIgdXNpbmcgc3No
KEhUVFAgaXMgbm90IGFmZmVjdGVkKS4KCldoYXQgZGlkIHlvdSBleHBlY3QgdG8gaGFwcGVu
PyAoRXhwZWN0ZWQgYmVoYXZpb3IpCkNsb25lIHN1Y2NlZWQuCgpXaGF0IGhhcHBlbmVkIGlu
c3RlYWQ/IChBY3R1YWwgYmVoYXZpb3IpCkdpdCBjbG9uZSBoYW5nIGZvciBhIGxvbmcgdGlt
ZSBkdXJpbmcgY2xvbmUoTWF5YmUgaGFuZyBmb3JldmVyKS4KJmd0OyBnaXQgY2xvbmUgZ2l0
QGdpdGh1Yi5jb206aWJibGVzL0xlYXJuaW5nVW5yZWFsLmdpdCBMZWFybmluZ1VucmVhbDIK
Q2xvbmluZyBpbnRvICdMZWFybmluZ1VucmVhbDInLi4uCnJlbW90ZTogRW51bWVyYXRpbmcg
b2JqZWN0czogMzQxNiwgZG9uZS4KcmVtb3RlOiBDb3VudGluZyBvYmplY3RzOiAxMDAlICgz
NjAvMzYwKSwgZG9uZS4KcmVtb3RlOiBDb21wcmVzc2luZyBvYmplY3RzOiAxMDAlICgyNjEv
MjYxKSwgZG9uZS4KUmVjZWl2aW5nIG9iamVjdHM6ICAgMiUgKDY5LzM0MTYpCgpBbnl0aGlu
ZyBlbHNlIHlvdSB3YW50IHRvIGFkZDoKSSBjYW4gcmVwcm9kdWNlIGl0IGluIHR3byBvZiBt
eSBtYWNoaW5lICwgYW5kIGl0IHNlZW1zIHRvIGJlIGVhc2lseSByZXByb2R1Y2FibGUuClRo
ZSBnaXQgcHJvY2VzcyB3aGljaCBpcyBoYW5naW5nIGZvcmV2ZXIgaGF2ZSBhIHN0YWNrIGFz
IGZvbGxvd2VkLgoKICAgICBudGRsbC5kbGwhTnRSZWFkRmlsZSgpCiAgICAgS2VybmVsQmFz
ZS5kbGwhMDAwMDdmZmNhNTkxYmQzYgogICAgIG1zdmNydC5kbGwhX3JlYWRfbm9sb2NrKCkK
ICAgICBtc3ZjcnQuZGxsIV9yZWFkKCkKICAgICBnaXQuZXhlIXhyZWFkKCkgTGluZSAyMzEK
Jmd0OyAgICBnaXQuZXhlIWZpbGwoKSBMaW5lIDMxMQogICAgIGdpdC5leGUhcGFyc2VfcGFj
a19vYmplY3RzKCkgTGluZSA0ODQKICAgICBnaXQuZXhlIWNtZF9pbmRleF9wYWNrKCkgTGlu
ZSAxOTI5CiAgICAgZ2l0LmV4ZSFoYW5kbGVfYnVpbHRpbigpIExpbmUgNDg0CiAgICAgZ2l0
LmV4ZSFydW5fYXJndigpIExpbmUgODIxCiAgICAgZ2l0LmV4ZSFjbWRfbWFpbigpIExpbmUg
OTU3CiAgICAgZ2l0LmV4ZSFtYWluKCkgTGluZSA2NwogICAgIGdpdC5leGUhd21haW4oKSBM
aW5lIDQxNDMKICAgICBnaXQuZXhlIV9fdG1haW5DUlRTdGFydHVwKCkgTGluZSAyNjAKICAg
ICBnaXQuZXhlIW1haW5DUlRTdGFydHVwKCkgTGluZSAxODIKICAgICBrZXJuZWwzMi5kbGwh
MDAwMDdmZmNhN2JmMjU3ZCgpCiAgICAgbnRkbGwuZGxsIVJ0bFVzZXJUaHJlYWRTdGFydCgp
CgpbU3lzdGVtIEluZm9dCmdpdCB2ZXJzaW9uOgpnaXQgdmVyc2lvbiAyLjQ3LjAud2luZG93
cy4xCmNwdTogeDg2XzY0CmJ1aWx0IGZyb20gY29tbWl0OiBkNTNlNDY0OGNiNjVlYjc1ZGQ4
ZDhhMDkzZDE3NDAwYTE4YTlhMTVkCnNpemVvZi1sb25nOiA0CnNpemVvZi1zaXplX3Q6IDgK
c2hlbGwtcGF0aDogRDovZ2l0LXNkay02NC1idWlsZC1pbnN0YWxsZXJzL3Vzci9iaW4vc2gK
ZmVhdHVyZTogZnNtb25pdG9yLS1kYWVtb24KbGliY3VybDogOC4xMC4xCk9wZW5TU0w6IE9w
ZW5TU0wgMy4yLjMgMyBTZXAgMjAyNAp6bGliOiAxLjMuMQp1bmFtZTogV2luZG93cyAxMC4w
IDIyNjMxCmNvbXBpbGVyIGluZm86IGdudWM6IDE0LjIKbGliYyBpbmZvOiBubyBsaWJjIGlu
Zm9ybWF0aW9uIGF2YWlsYWJsZQokU0hFTEwgKHR5cGljYWxseSwgaW50ZXJhY3RpdmUgc2hl
bGwpOiA8dW5zZXQ+CgoKW0VuYWJsZWQgSG9va3NdCm5vdCBydW4gZnJvbSBhIGdpdCByZXBv
c2l0b3J5IC0gbm8gaG9va3MgdG8gc2hvdzwvdW5zZXQ+
rCount
