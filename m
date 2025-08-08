Received: from outbound.pv.icloud.com (p-west1-cluster3-host11-snip4-2.eps.apple.com [57.103.66.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCC0526CE28
	for <git@vger.kernel.org>; Fri,  8 Aug 2025 09:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.66.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754644908; cv=none; b=VWHmTuqXca+xn/pv+Md1jpnr23V9aa6gRvMgtvYryrQzSKtDqr0oqWNbZLWceXcsh6TrqTZgWferGJ2o7Xxn3SQUWyVmhyoHlievky+RsLk3AHQKfHfLv//uRVSSi1KaYmgrtfpNcXz4LHnWZe7m3ZmWY+yxONmJP3Bj09H4yHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754644908; c=relaxed/simple;
	bh=5OMmqUiihSnr8vi5ZBX10lsahKFvQcc5UVMdLJgBtkI=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=pOMMKp5jAC4Pf4lXku2WNuWl/eMfFEQLY5/EZY1pfOB7n5qAXg4GY+ucLAY25PF1JYCCOoPauUtvdm93R/CPT3k9MB73fpAN+g9DWOTkpLiGUE3QNbPXKhsTUCj69ZgGXuUDXUWgH6D+qp6vDgiEPWAphc792ygW2xV+V5S63Ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=j1VKvBlb; arc=none smtp.client-ip=57.103.66.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="j1VKvBlb"
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-west-1a-100-percent-4 (Postfix) with ESMTPS id 24304180084C;
	Fri,  8 Aug 2025 09:21:45 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai; bh=5OMmqUiihSnr8vi5ZBX10lsahKFvQcc5UVMdLJgBtkI=; h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme; b=j1VKvBlb84oesaj7A4EbX7hayVBveq9Jo2FCW5afGGTl9N6leUPBHm3jgSzSIsXLoZBO+mqw5Y4jtZLBn17903/t7DNObyqzg2B8tcIAq5j3riHOTMNvY8Qj/j5HCVxJe1OMJ9Rz1d8Mw2lxLBWxNw817gpgLH8mGx6+G7urdJRxcPem0RQSJQr4AS3nlEwn+5VY7E3losPx0SKRAnDUk0ydQnqucQSIgEppnkZWxeYOCOGjKlvEhmN+aVrLVZofzrcgNDfVpNjGAnx5dGu9z2S2baLpphVFsbTXZ3Ulel3Xdn63J9QnHPI6MWznvtgr4eiDwWgQW6LJKXnQywm5Dg==
Received: from smtpclient.apple (pv-asmtp-me-k8s.p00.prod.me.com [17.56.9.36])
	by p00-icloudmta-asmtp-us-west-1a-100-percent-4 (Postfix) with ESMTPSA id 838E718014C2;
	Fri,  8 Aug 2025 09:21:42 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.400.131.1.6\))
Subject: Re: Discussion: Future-Proofing Git for Massive AI Parallelism
From: tanish desai <tanishdesai37@icloud.com>
In-Reply-To: <DB7PR02MB42658E4F3245CF0BA5B69AE4B326A@DB7PR02MB4265.eurprd02.prod.outlook.com>
Date: Fri, 8 Aug 2025 14:51:24 +0530
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
 Tanish Desai #TD <tanishdesai37@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <5309CDB2-8254-440A-BE22-778CD9B10009@icloud.com>
References: <VI1PR02MB4271E311313F60FB07359BB0B352A@VI1PR02MB4271.eurprd02.prod.outlook.com>
 <32989B0A-2DB0-4787-8A08-BDED46258C7D@icloud.com>
 <DB7PR02MB4265771098F7314E47D9F2C0B326A@DB7PR02MB4265.eurprd02.prod.outlook.com>
 <DB7PR02MB42658E4F3245CF0BA5B69AE4B326A@DB7PR02MB4265.eurprd02.prod.outlook.com>
To: Skybuck Flying <skybuck2000@hotmail.com>
X-Mailer: Apple Mail (2.3826.400.131.1.6)
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA4MDA3NiBTYWx0ZWRfX7C+d+WDkB3/i
 e2kGD9TQV9tEkJrcZ9m8X6aWrAzubmTGeUSdVAw3N2iihaGd5PkjK30lQcRuYM/EV9tqg972uOI
 9z1BWADEQDNbJm3uGUld2fK+4ZWbXcJ8ym9TbJbZMd03KIV0JAd3hcVI23ztNxK5NoLvwvDFEoM
 F85VDcY/WD3tvowd5qczKHfSTTayGFxwqYtotqnRHPg8jEgH+Qgji2KUZRa95oGojKC913SDxBE
 gcy4g5M2mF38mfP4rLQnuPvZd9dRTGmcOqz8NDIqNCvJn1b2zsbYBkT32gbfVFsBzEPEBqsEs=
X-Proofpoint-GUID: i5CC-LwSK36WP--8d1_xO3EDCkPxdYIl
X-Proofpoint-ORIG-GUID: i5CC-LwSK36WP--8d1_xO3EDCkPxdYIl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-08_02,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 suspectscore=0 clxscore=1015 malwarescore=0 spamscore=0 mlxlogscore=468
 mlxscore=0 adultscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506270000 definitions=main-2508080076

Yes, this approach can help resolve merge conflicts, but a major issue =
still remains: while resolving these conflicts, the LLM often removes =
parts of the program's functionality or unintentionally introduces bugs.
If we want to scale this system, we need a mechanism to run test cases =
from both branches being merged, so we can be confident that no =
functionality is lost during the merge and that the code remains stable.=20=


> On 2 Aug 2025, at 3:08=E2=80=AFAM, Skybuck Flying =
<skybuck2000@hotmail.com> wrote:
>=20
> The AI/Gemini in general seems good at resolving/manipulating source =
code bases/files, so it should be able to solve merge conflicts, the =
question remains how big of a merge conflict it can truely solve before =
becoming confused and human intervention might be necessary, but by that =
point it might be too big of a mess for a human as well, so far the AI =
seems to be doing ok, but to early to tell.

