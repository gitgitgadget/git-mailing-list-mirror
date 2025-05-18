Received: from outbound.st.icloud.com (p-east2-cluster4-host7-snip4-10.eps.apple.com [57.103.78.241])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F5420E328
	for <git@vger.kernel.org>; Sun, 18 May 2025 22:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.78.241
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747608909; cv=none; b=gMKEIED3Apw3purjAheUnSyFu59K6v1PPbc4IRj8rmqciA8WRe9W2obBNchkAmf3zsIhWKz3ABzfAFLtLXJC1a5utY5uecqeTGYRbqjq56CuUi5Q/51tG9LBsmBYHviBYqXxpP0bwD3fSD8fndx7XvKZGwRBbgtYUoiH/cbmEJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747608909; c=relaxed/simple;
	bh=b2I46yt0tAAt3YLFsqPQvPX1j0nQZ5sqsz9nsYoL8SE=;
	h=Content-Type:From:Mime-Version:Date:Subject:Message-Id:Cc:To; b=P9W40ekwzN6qR40DCiUSB1HNA2gAZRXx6KoNWBjql+uSSWvZhOjuR8an4YaQZ9PyUlW5Bxi3Iyl+T5AmBmBsqGj5uwRupUJUjDZEASYEFhWuhnsqZ6KspGjyiZEvzy09DgOt2hiOfRczhZ2fs/40kcfTdhnJqt590RoDO/y1aqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=0eyHhh45; arc=none smtp.client-ip=57.103.78.241
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="0eyHhh45"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; bh=E5kErvsTc3BQd9hOaWnfoZ9I6Eqp9vog1tr10nf41CY=;
	h=Content-Type:From:Mime-Version:Date:Subject:Message-Id:To:x-icloud-hme;
	b=0eyHhh4545J9z948Jarw9ZlyPCTQj6RiHdxWCaVoLo2rkSUJONVAzMBzB0Sg6VNBS
	 5QdGYE2JFVWas6i64vthnwd0Y21N4iIBt6q81wngfGPWHR3J484KBVPlpvODEcly/Q
	 TnyFEeTg8so9gAMia0xuf5+g4PoWIHufmDyLn3q69p5G+FKq0gCmZatimOfxHGr4h4
	 528l/NpAxKjoJfCvNhl5/OCTXSY1H73/YlQGDhnHix3md7EiV9zenvF/8P4rEYDWfK
	 bzQ5udfldLhsWDQPRarZz0ZVy+Q8bNQZ9MaHoQcOI7JLBdZcRyw9J2e/xEV95rzone
	 tL/YfeRkOrcSw==
Received: from outbound.st.icloud.com (localhost [127.0.0.1])
	by outbound.st.icloud.com (Postfix) with ESMTPS id 10868180010B;
	Sun, 18 May 2025 22:55:04 +0000 (UTC)
Received: from smtpclient.apple (unknown [17.42.251.67])
	by outbound.st.icloud.com (Postfix) with ESMTPSA id 03A9F18000B5;
	Sun, 18 May 2025 22:55:04 +0000 (UTC)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Evaldas Svidras <svidrasevaldas5188@icloud.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Date: Sun, 18 May 2025 23:55:01 +0100
Subject: Re: [PATCH] git-diff: Introduce --index and deprecate --cached.
Message-Id: <DCF1AAF1-9985-4048-9AC5-6BCC2EB568AC@icloud.com>
Cc: ae@op5.se, git@vger.kernel.org, junkio@cox.net
To: jakesteward0916@gmail.com
X-Mailer: iPhone Mail (22E252)
X-Proofpoint-ORIG-GUID: Knl67qvI5mNV3pWRM089x8J_WaoJ7HVB
X-Proofpoint-GUID: Knl67qvI5mNV3pWRM089x8J_WaoJ7HVB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-18_11,2025-05-16_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 mlxlogscore=671
 clxscore=1011 malwarescore=0 adultscore=0 spamscore=0 suspectscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2505180228


Efka 

