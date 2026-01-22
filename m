Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F053037883E
	for <git@vger.kernel.org>; Thu, 22 Jan 2026 16:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769100053; cv=pass; b=koiv+DUorMs3IRBviREH5DZQfVksO2kTbMCC8LzYY3B7eO1b8pH9y+qLlFh3+zI/yM+vij5iTcxN1uBh4kdxs04mpYczUKU55i3JhtjW4K3PJKaC+y+TdYa5JgQoAjgOBs8ePdfHaAearWOXQheiMMLRx5PB5D97a/Gk0fX58cc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769100053; c=relaxed/simple;
	bh=kFUbfHszBpsRw+03uKnHqFgr9Xo6+9Pka28uaCp6UZo=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=Onlpj8nq0AmTwPprFJ6lUhvXMSeJu51H9DWGaOFWhKGcV30nUw/4mMTlNmKGzTq+aEBKKyqDijRf2Sc696uo8Sc/mluY+6kYxK47PwrcN4jPNlle55DtZ+cjeGmRts6rSjdthTUSjNE/oP81NKA7ATKvuoB5y2d2gnnhxGlFf+U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l81257cP; arc=pass smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l81257cP"
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-2b72e49776eso941010eec.1
        for <git@vger.kernel.org>; Thu, 22 Jan 2026 08:40:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769100042; cv=none;
        d=google.com; s=arc-20240605;
        b=S4O8CFnrOcBdFcP6dj70u4HKCh1pjqdjOGquBmRf49sPp7LNxO0iEukiHDqUvj5/JM
         HJm1slEJdR0l1HnHtK0omhvVyRfJkF+PH178llnDzPoZ5b4hm8+gak5fLl1X1+9anJGt
         eQTlEAm4T9pG8ZigbUbOCWchrnw1hcKXQrwRZtxVet1pKksawq/AQS12hP3yDVahQ+MJ
         qraL6i8FzfZJl8mKcTNNfHBdoOcUtn0eQH6jptY7kXsmwcRcWw8bBglX85cOCAItslOv
         VXqSEkS5rtDZgeU5x32S97TIMhT02qllH/3XMhWw8/ifJ8/2SPOSDRLusUwEEDpz3dLd
         uaFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:dkim-signature;
        bh=ev1UrCWyF18c3NCEA8pww0lfb7DeAGoN0K40fTaqV/w=;
        fh=AdLvfp5rDLFEqEXBqPWoMWgsTSDK6pd8NZNu0VEubK4=;
        b=Eu7l9Z+/h70XEgdzup5Ngdx26B6K6y98e97DVO54TCFtcL+eA1oTKDZVJAapfvKx4B
         fDL9yYureY+czpcITG8BmIZJRqlEr3SrsPGXAhbLmsYL2IcD/RYp+vBIpDKCcgf1ueCo
         ByDFE//3GlMDVDUJu82RDOhO9Vgd3orGjvn42h922tS/lO5519FIq3VmN3NmSZXF38e6
         s2QfjsR1BhGDYITQHMzGpCzhPmGPuvID7DUAyQn7FJM/b9TrNAfNFXp3Nav7vru4mpI6
         HjT4V4MxnZ+6oDI7qn98DdODg4mWdhF1gxq+sk7UFhOXotmzFT/4zvWZCy4is2nTw0/U
         VxoA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769100042; x=1769704842; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ev1UrCWyF18c3NCEA8pww0lfb7DeAGoN0K40fTaqV/w=;
        b=l81257cPKpjx2+BwYhBkZWThwCGrzjSWqKz9+R7mq3mHX4s8ToNC9A3fsGkXa7GUP6
         0NOv/ggkeo+/9XvzyV3KhG0QhDvOwU5m8QKjZxLP7f0l+CIz7mwS7zvGFV1H1iKPwsEE
         Hm9PfpqxhCuWjnth9rZo2NhHQx9Udiq8vXDCeikouk0PMTn5sKrCAG+hq2j1l8cgx43k
         yWIliABjFU9Gf6VWBUEBVhM/NWkeJocP2YJ14z7pEMXgFCkEvjrQlB9esdH6UosDm8Ud
         u2nQ2/Xci4nVh68EdmPfwued/B07fGad+GyFXjsM4zvXbcb0qGT1HuUN13+znPcZzr5P
         5XDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769100042; x=1769704842;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ev1UrCWyF18c3NCEA8pww0lfb7DeAGoN0K40fTaqV/w=;
        b=XnY7OXLjOaLasqJb7U1ldF8B2r0AI6JytiGPqoSTVsh+iDNfvv8Etwjz1Ny4I9AwQE
         EKbODnrP+wW//0RPh8X4r56Zqs8AvFIpu5rbEwNVK63o8jElYCrQFhePBa25FkrU1oxe
         9URB0CfsoV+BEiNJ4oOOp9JNcSV04+muGW/G5iREdsq5DmB0oP57mQytTAyGRgrCeF0x
         mEeEZ7BfHq1NzkP90YzEdqPvsp2KVRX4qE9VRyAcs8RjfMUV1RXlsfN2yNbWPSmVHo+V
         R77EAsSZhMDAc6uweIOEV0iMwVYpQoMVh20IBSj2yfX1anogM2vOShqdBjA4hHE3duSS
         CuQA==
X-Gm-Message-State: AOJu0Yy1guSPQYbzIRLRDPbivXnnOeus1nr9rreNDp977nfQ6oobwC2w
	DW43KwXZcufZ1oAGeRXTL2xVnlinaiMURMduioE8iau2vUalOb3dkvqc19ybF0QtihlDsFpWPRj
	pbPURIw/cK89qZU1/I+v2ZYlwbk3NldfJob5X
X-Gm-Gg: AZuq6aLLQQIoH2wo9Y3gXR77/dIPoDiOvqjBqLw7m7fMA7QKepbgOCoNZFaaUMWrSBA
	oNHmzMra1Az/ikFBgyIYWo5oxGM0BTFCQ7iNTdjVJlBXsYl12+NDfa7/McOLKN7lvhIW3V99LKH
	45RLclXoAXx8fVwWQDgh12pOQzNX7jE3fJxI4qbBA0ce2EJnLhp+ZpW42QJ1uk6lBWd1p5P7Xl4
	ZRpqSE4x1KhpbGkhTapOljwy933ImbaynMhNRvNU9TYB0SdUmLSgbX1C/i1Pvw075bRXjlSAtUu
	7oD3DA==
X-Received: by 2002:a05:693c:6210:b0:2b7:2d5e:3f49 with SMTP id
 5a478bee46e88-2b72d5e4121mr777224eec.10.1769100041792; Thu, 22 Jan 2026
 08:40:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Luis Alvarado <luis.alvarado.torres@gmail.com>
Date: Thu, 22 Jan 2026 11:40:30 -0500
X-Gm-Features: AZwV_QiD1Y6ysQzHzUFdxYerXbvmkg5a7ynawege-ZHCzJq_VSxWciXgi7b_SUM
Message-ID: <CALFwtBbK6sNo0swy5k_+jgcKQmOpw3b=o8_UKhvLhtYYLqoUow@mail.gmail.com>
Subject: CVE-2025-66476
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello!

I need some help or guidance on how to remediate this vulnerability.
We have a customer with Git, which includes VIM and is vulnerable to
CVE-2025-66476. However, the GIT version for Windows was last updated
in November 2025. How can I remediate this issue, is there a way to
update VIM without updating git? if so , how.


File C:\Program Files\Git\usr\bin\vim.exe&; version &#96;9.1.1914&#96;
is vulnerable to &#96;CVE-2025-66476&#96;, which exists in versions
&#96;&lt; 9.1.1947&#96;.


Thank you!

--
Luis A. Alvarado, M.S., CISSP, CEH, (ISC)=C2=B2 CAP, Security+ | IT
Specialist (INFOSEC)
This e-mail message and any attachment(s) are intended only for use by
the addressee(s) named herein and may contain legally privileged
and/or confidential information.  If you are not the intended
recipient of this e-mail message, you are hereby notified that any
dissemination, distribution, or copying of this e-mail message,
including any attachment(s), is strictly prohibited.  If you have
received this e-mail message in error, please immediately notify me by
telephone or e-mail and permanently delete or destroy the original and
any copy (electronic or printout) of this e-mail message, including
any attachment(s).

... Truth is the only safe ground to stand on. - Anonymous
