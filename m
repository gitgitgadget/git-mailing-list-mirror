Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C64264BD34F
	for <git@vger.kernel.org>; Mon, 21 Sep 2026 16:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.126.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790006893; cv=none; b=L9R1DRZTgNKhmw5k3tSF2amaanzWSFiwgtmf8wHsT6uZJ5wF5atFCyr1ztHA/+zoYc5jALRHoQLEsJ8BhEcOCRHtuUTLgQfpyz+SW3nyJiCYo1LpzUa+69MOooYDS5xvAnYH9EPftVgQpUjztS4sxlVxjEdLi5VYyJcXwU/H6e4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790006893; c=relaxed/simple;
	bh=hVUw5P5+LZR/py1xpLVlEhsRnPzXGrELDKv35VDy2zA=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type; b=ud4OzSk5QwEWx0sECxXvEmhom+i6la8hD6g5UdTKOrqQHHrentiErU54ru1tt4tfS86WkXB9rGd4la5U7493vl3QaLbTBIbFF9+9zpLoNbBYzJbFO9uKBlQpDZhxihaPMGhfSXxnyuLdGWlavctq8No9TusyIczL4/TmvHLM1zA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=delpeuch.eu; spf=pass smtp.mailfrom=delpeuch.eu; dkim=pass (2048-bit key) header.d=delpeuch.eu header.i=antonin@delpeuch.eu header.b=r1GnHN/R; arc=none smtp.client-ip=212.227.126.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=delpeuch.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=delpeuch.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=delpeuch.eu header.i=antonin@delpeuch.eu header.b="r1GnHN/R"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=delpeuch.eu;
	s=s1-ionos; t=1790006883; x=1790611683; i=antonin@delpeuch.eu;
	bh=hVUw5P5+LZR/py1xpLVlEhsRnPzXGrELDKv35VDy2zA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:From:Subject:To:
	 Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=r1GnHN/RGIERQlQ6ycKRxjG9uPhfPHbVp2rO83hL/zvbY+1fnzs3UvaeyDKGTqLy
	 KDujK0tYFh6q+ddD0e9ihKGTYw4hUd4o+Dni47C4R5FGAeL1dej1cJ521MPSkCY0M
	 R4feRSauUUP61k97YG4h63MKmdbu2Oshm8Ye6uP2/35H7xGnREQRBxW49FNuQXuBi
	 flVkzg6bKeWF5qDjiVnFQYMGpHV3hTsZYfDiM6MwyTKr56oQ8p+MyPjJgOuGSeEOG
	 H87DV7AbVJf7YeGLR8lTiE9j9GfxDf+MRdWLEMZlAMITWZPC/PLgJw8YwIXlgP0l2
	 r8avof0jJXCP5hsOVw==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from client.hidden.invalid by mrelayeu.kundenserver.de (mreue012
 [212.227.15.167]) with ESMTPSA (Nemesis) id 1MBSJT-1x3UxI23g7-009L4z for
 <git@vger.kernel.org>; Mon, 21 Sep 2026 18:08:03 +0200
Message-ID: <1aee1829-d7ad-47e2-b7d1-1a946bd59991@delpeuch.eu>
Date: Mon, 21 Sep 2026 18:08:02 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Antonin Delpeuch <antonin@delpeuch.eu>
Subject: Documenting the governance of the git project?
Autocrypt: addr=antonin@delpeuch.eu; keydata=
 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
To: "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:NTOmS1vMF9pNLD9kVq+Ll2xqPABWtZpjauzKaflDNx3H6ogxx6A
 ocRWuxkeaCl+jBtxIP+bDebBpENt5ommwjLhVhJGrnqFImKJ3ZK42lJhKMlzqQC8hjH+Wz0
 0E+7eMBfwJdBggRK7K8C/DPh2iXDU0hYrwToUSP00BwLShOqcbpiNGz+6r7GDvzr3FmkI30
 IebPDhiYytl9sQYOIasmw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:A/bA2sGoE2c=;+213KcNcylz2X7uqJNfKQ23xpSV
 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
 uLqO75WhFAOff7ftY/0XIfxid8ImvWoI4LSg==

Hi all,

As an occasional contributor to Git, I have been interested in getting a=
=20
clear picture of the project's governance. By governance, I primarily=20
mean a list of roles people can have in the project, the associated=20
privileges and expectations, the ways people get in and out of those=20
roles, and any decision processes in place for important matters (which=20
`Documentation/DecisionMaking.adoc` already does a pretty good job at=20
describing).

For instance, I'm aware that Junio is the one merging patches, but are=20
any other responsibilities delegated to other contributors? What are the=
=20
responsibilities of the Project Leadership Committee and how are its=20
members renewed? If Junio wasn't available anymore, would there be an=20
agreed on process to find a successor? Are those aspects of the project=20
documented anywhere?

Through my experience in other projects, I have learned that it can be=20
beneficial to write such things down.=C2=A0I think it can help avoid some=
=20
conflicts, help onboard contributors, spread responsibilities in a more=20
intentional way and increase the bus factor.=C2=A0See [1] for more backgro=
und=20
on the why and how of documenting governance.=C2=A0There is an emerging=20
convention to document those things in a `GOVERNANCE.md` file at the=20
root of the repository, but many projects choose to publish this=20
information in other ways (such as on their website).

If there is interest, I would be happy to try and document this. All I=20
need is the confirmation that people see value in maintaining such a=20
piece of documentation, and the readiness of project leadership to=20
answer my questions (which I would try to do in a way that respects=20
their time, using the communication channel they prefer). I would then=20
submit my write-up as a patch in the location/format you prefer. I would=
=20
of course be delighted to team up with others in this endeavor.

Best,

Antonin

[1]:=20
https://theopensourceway.github.io/production/en/growing-contributors/proj=
ect-and-community-governance.html

