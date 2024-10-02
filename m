Received: from st43p00im-ztdg10073201.me.com (st43p00im-ztdg10073201.me.com [17.58.63.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7FD2EAF6
	for <git@vger.kernel.org>; Wed,  2 Oct 2024 03:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.63.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727840412; cv=none; b=D9/jPfywH2KyejmpjxRysstMnl7e0QfX63kZTfFjzHEWTuH70CwQ9SafeO2JTf10PHMkqMEksZvWuJpLFDyCV6DtMkbi2bjpINSQEUWeOM2b/vxV9vUtq+z5KNQ5PM+beKr76GB5SP/0ESrAR0Qnyue/4KwaiLYbbnELtWNpcK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727840412; c=relaxed/simple;
	bh=oQVrm4JM1X0wDCMXvmOHv4D9tQl39pOLC72bTquZ9bE=;
	h=Content-Type:From:Mime-Version:Date:Subject:Message-Id:Cc:To; b=H2ef1HENW9XPggwdlT4kSikdz//b8n5zIx1DNE0CmZoBoyPvb0khSl+oBD+12vOlgndoad7mU7e/Mo1KahJ+/2izNCE/LalEbnJd4H9PVM/O4AxtDWdtvlYR958yXfuhIcHwct2jQZl2R6+sEJDjDRh+5j6rbiFqaGVMlZhKq/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=eQygrtic; arc=none smtp.client-ip=17.58.63.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="eQygrtic"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1727840410;
	bh=oQVrm4JM1X0wDCMXvmOHv4D9tQl39pOLC72bTquZ9bE=;
	h=Content-Type:From:Mime-Version:Date:Subject:Message-Id:To;
	b=eQygrticlGSKNHMNUIh3qiG/WTruUk9PvjX0ran/BQfZQcabVod4iK7XZvR7nwSY/
	 HUvYCiVVy23As2xIj2tXqcEf0euaSRBNItBbVqOeknSjKiHLLwXhji3LumZqXTwuZx
	 CtEOYa6lVXy/8wHTYrasIZbqAw8NQSBtVqnbaSy4i55mYd9HW4zgINVE1ztbGUk6Om
	 cP2iOthQhoGWmimYzZTbN01tInZJvK5zEfPtwmfF+Bkdy4DrLuWBXs4rzON1MTubA/
	 WqI+3W9vRedCoiDycwYqXSWHs7xVcQa9Rt/PAjIrXwoU9AhoVC3v4I5DcKyRjVAvJl
	 Kb8tMAzLyYEtQ==
Received: from smtpclient.apple (st43p00im-dlb-asmtp-mailmevip.me.com [17.42.251.41])
	by st43p00im-ztdg10073201.me.com (Postfix) with ESMTPSA id 939079C02B2;
	Wed,  2 Oct 2024 03:40:08 +0000 (UTC)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Crystal M Baker <bakerdot@icloud.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Date: Tue, 1 Oct 2024 23:39:56 -0400
Subject: Re: [PATCH 1/4] t3430: modernize one-shot "VAR=val shell-func" invocation
Message-Id: <951703E6-DB37-4167-8078-5AC16028560A@icloud.com>
Cc: git@vger.kernel.org, gitster@pobox.com, rjusto@gmail.com,
 sunshine@sunshineco.com
To: ericsunshine@charter.net
X-Mailer: iPhone Mail (21H16)
X-Proofpoint-GUID: IkBEUfCNv1X5A26mkhPyUQGxnarUvh0Y
X-Proofpoint-ORIG-GUID: IkBEUfCNv1X5A26mkhPyUQGxnarUvh0Y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-02_02,2024-09-30_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=618 clxscore=1011 spamscore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2410020026


Sent from my iPhone
