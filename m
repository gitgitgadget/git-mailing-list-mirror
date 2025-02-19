Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86BC11DE4FA
	for <git@vger.kernel.org>; Wed, 19 Feb 2025 10:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.126.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739962190; cv=none; b=fG7G7rABH0Iepsykn2xAsPK5eID+WfDIY3kaRqQn3T6ZGfvw17VJG1MwuGMe5pTqnELyB1QvyKDPsPAmPWpcgZocXTAG0O2pbSxZXTYhxKVWS6Dbu+2SYBF5ypRxCECZNNsy/2JgE+o5V5NxxK1D23k9NRdpTbTnOKE+IQ4yW6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739962190; c=relaxed/simple;
	bh=9XYeCDJmnRf6FmAqypBwL6pwacq4NPwrxFl9ExMoZ+I=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=qD22yh+QG77Om/JCZvGpJAZQttD7uTAklrJGqJEVRyjTSV5ID8p4IQYwsb9Jdx3DpzuTmUfRI/32GoglmRJmEmayhnCq3CWuD/lR2aJJoTGKkSZoo5LGAs+pxYv68ZwJ6yLZvHW8pvN6ALk5vLA7n2xus1BtfEAUsNJN61PAhzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=anselmschueler.com; spf=pass smtp.mailfrom=anselmschueler.com; arc=none smtp.client-ip=212.227.126.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=anselmschueler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=anselmschueler.com
Received: from [141.23.193.159] ([141.23.193.159]) by mrelayeu.kundenserver.de
 (mreue009 [213.165.67.97]) with ESMTPSA (Nemesis) id 1MPXpS-1tyV8w3IH4-00Oskt
 for <git@vger.kernel.org>; Wed, 19 Feb 2025 11:49:41 +0100
Message-ID: <216a7288-b599-4333-ba62-10665d6a94d8@anselmschueler.com>
Date: Wed, 19 Feb 2025 11:49:39 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: git@vger.kernel.org
From: =?UTF-8?Q?Anselm_Sch=C3=BCler?= <mail@anselmschueler.com>
Subject: Possible bug: Empty magic word list in pathspec is handled
 differently in short vs. long form
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:56BAj3XKHpWsHot/qDKE8PBsU5kC+WV3jJLEHQ7crD/vd3F3f3h
 CjV7mpKQjx0c4YjnhrzNCm79xMVkY4RcUGfwYDRgvwd8aKxLcqdxOAWvwkj9BZx/w76AaLd
 hO8Ar8kd/9b6358LYMRnoWTkAxXOiHLF/zdCUVjgf6Cw42FCR4wCr7hq6aN7YWnffWvOS+M
 fM/PHW0qsW/cBY4IQLqeg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ja98qlFShYA=;B9/4D/TNQK25LKmSQ9GjOyNN3tZ
 i7MX4nsVv7vcO0Bl453/wibZh2yiurM0xc4hwQFTLRNxNw2h98rC8xUpTn3Ai1LiBKPjeYfaC
 vKAOqVijDCoYAtbcQab0NxbL9TTKS6le82WgF8V+pzLX4Wb+vCgCsnoVn08g9JyJucQJKDQOF
 k26/NMaOVx9qiqMPwJGpeeP9UcbtftFo8RVeCANAHiQrprgKsiwyCKIMoNheEKLc69tPOQ5RJ
 z8ef2pCB8tV9LN5WkNlgj90Ve8QFiwSGIZOnbscBOEis/yrr1pg8BNp79mHQfRopU/WMUR1ZL
 6cN9qJ8oYQ5kdqzKISkw389b+A2uGlLlxz4DbPs+0PEwnFoquoPUMzFVjxOH/AULK9z/JT7zb
 yIztOi/sljg7KsnvcJ9QDFoiPEvlR/NkTOu7U23ejAbROWy84xJU9G5sOPM6Cc21qM72i24OH
 cxTVW6rTdEE7TqHYdleu2TTBENlw0A00m+hNxqHMhYRxsxmtRfYzcV8xzgJYofH7P4Y4FS6NB
 FVAAs7ocWYFufytn4/Z4BzEDgrYCXDSQi1zHrJsZERloO6GrNpOobkEg3Ccosmbtgsb0nkfSN
 vzRpi9F31Jwq2gOj2EBGYy9SCCAGiawB4LwhbfhbaxM1hFxAjra7faeWoLEajOJEjjMRBCpPL
 K/nuKcJ0VG/lMOLPA3emTaCIvQnydejiOK4PQS924uDt46soJmjv9DmF/y66+ePYSb8F6rST4
 i0tKIMdj0FIwgISZyDrCUFs11I9GRANk2lIZEOt4l42iLv5sOh5KrTsu8F5hOQu2CDN57kAG8
 l9elmUlzZ2A+24MoLjK8qcUa6MNOTAn+KF5sOUfCpaeQQQMWoGgmFHEPNyiQa1fI5ObYbpPbd
 QquE8gcQW8ZC4RLfM+f3U8M5PdCbfI8t0JLyVVzHG3WiLP7742JX9Z64r9edBYySzn9hq7hfl
 hO30a/ZqdKpiVAGfnKoR/OV77kMt2ulQIzKlt+6AHXnGaHIS9/PqMuBsQIsm3HurVTL/QzK6n
 RbXcUoySjoXruyNxY3+Z7djgoePrYYGUI17bsTEymqTHHycwd241zaV3Ki54jqL47Y9IhX0Db
 LrP7v0PRSEnN5cEGBbLXc7OwCusZy7xPW4gVOVjvrGEKaYvzLiRZdk02bTGtHZJAfGfsP52A0
 kjhZdz1ANrYDw9ICPPr77SfCjC3G5SqY96+6riX8lI7Rq0sMR4YNTYo5sEIOBEw+6e7fo6bPq
 tbXD5s09PcZXbSg7xDP8m41RTbf0cT6ufDlbjFqa7/QAYWuTfznXilxbg6tRKIGmWcKMF4tZW
 5ZpRxUx1qlsMlNDb+I5HeaYXY5ffR7duj3gpD/NuMIov8tadbDM2f/gKCNZHUckDyKWCVZEX5
 Rg8hueW8qET3ZuKURxGf5kkYhLhylsX0ygsio=

﻿If you run git diff for a pathspec with an empty magic word/symbol list 
in short form (prefixed by ::) and in long form (prefixed by :():), you 
get different results.

Here’s an example use of git that illustrates this:

~☭ mkdir gittest
~☭ y gittest/
~/gittest☭ git init
Initialized empty Git repository in /home/anselmschueler/gittest/.git/
~/gittest (b0)☭ uuidgen >file
~/gittest (b0)☭ git add file && git commit -m "$(read)"
read> initial commit
[b0 (root-commit) cd3bd43] initial commit
  1 file changed, 1 insertion(+)
  create mode 100644 file
~/gittest (b0)☭ uuidgen >file
~/gittest (b0)☭ git diff -- "::file"

file
──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────

───┐
1: │
───┘
66d18ffa-1128-42a5-8d4e-f9d75eb86b92
9acea2b5-50a6-4f87-ae1a-64019a93e55e
~/gittest (b0)☭ git diff -- ":():file"
~/gittest (b0)☭

Is there a reason for this? I couldn’t find it documented in the git 
glossary <https://git-scm.com/docs/gitglossary>.

I’m running git 2.47.2, built with Nix (nixpkgs commit 2ff53fe) from the 
kernel.org source tarball.

~Anselm Schüler ⚙️

