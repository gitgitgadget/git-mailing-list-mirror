Received: from avasout-peh-003.plus.net (avasout-peh-003.plus.net [212.159.14.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D119E28C845
	for <git@vger.kernel.org>; Fri, 15 Aug 2025 15:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.159.14.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755270617; cv=none; b=hAWKPOw69GXscijsmrO8OW+ewAG5hhJy+iE73zKOpKoqLstF2lcICrqDwLNgcXI1Eby5VGN9HOt0Aa2FYHDwjHUisfAMOL31wV4kPDFQzjRzvBdkKNlilGGcJXSkrVgr3MhNgkuZ6+aIJuLmngjGgsByc3mtUACM8n9P1Q7mqIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755270617; c=relaxed/simple;
	bh=yPFNJ1U2pIOflHOH2/N2tEHgwTcz9q/ahsoHdcr2uE0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ZAF9aWNhyPPSUhOkFxO3KT02d391MjBbOcUeZAaXxXJJtodZV5heQaSTQvgtQKhOeke7hrp0I7TpTasFBsYj1HJw1EYZWzVmOtqIbPpOBezIR9kvF5pF/mVjDFjnxYLKe5lRKLsdrdoVOQclhPW/erg6ssm1ONehgjsgTCGqHM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ramsayjones.plus.com; spf=pass smtp.mailfrom=ramsayjones.plus.com; dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b=k6t0yLLm; arc=none smtp.client-ip=212.159.14.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="k6t0yLLm"
Received: from [10.0.2.15] ([80.189.83.109])
	by smtp with ESMTPA
	id mw1GuNeZyCM9imw1HuqkeB; Fri, 15 Aug 2025 16:07:04 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1755270424; bh=S4ZzTVSOtzMFlvPfFaR2rbVfa3jEVY82v2Hqac/gwpU=;
	h=Date:Subject:To:References:From:In-Reply-To;
	b=k6t0yLLm2hPH9xpYb54l8O2W6oALVXbILOhhiN5NnAP87BdE3eeJjJ1HN0BWXxZzC
	 9fq15hXcoUeFDrDtVXxOfhrkJW9vdKOYTlCnrPRygRfoI5ucHbUscNuaIJtpjLuaty
	 uxpIy2zvEO8ciqq4Zwy4NtDePEW6Rk1zDU1Vn+ZlikJfVNzl/7zNtfsEqPwZA9YcS4
	 dEEknu/WbRg+1brlOdBo1Lgr9lZViZWdC0jEjImA/N0SU1tDA/4CvipYGfW7mVA2yJ
	 tbO06wHjtBbQb+DSTMG5/Wrd9DSb88P1j3IyTFOPP5cEIpRDny22s2we7f6QcbAQwf
	 T5WRJMhk6h6Jg==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=A7XPPLWG c=1 sm=1 tr=0 ts=689f4d18
 a=oM5NSl/Bl4BpjFr0C8iQlQ==:117 a=oM5NSl/Bl4BpjFr0C8iQlQ==:17
 a=IkcTkHD0fZMA:10 a=NEAV23lmAAAA:8 a=Qm9lS0mAhHZJruEG1UwA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Message-ID: <2d5ae8f6-69f1-486b-bd38-337f0b54f737@ramsayjones.plus.com>
Date: Fri, 15 Aug 2025 16:07:02 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [-SPAM-] [PATCH v2 00/17] RFC: Accelerate xdiff and begin its
 rustification
To: Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
References: <pull.1980.git.git.1752784344.gitgitgadget@gmail.com>
 <pull.1980.v2.git.git.1755220973.gitgitgadget@gmail.com>
Content-Language: en-US
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
In-Reply-To: <pull.1980.v2.git.git.1755220973.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfAjJKih0Es1qeXsrkJMRkLmJlhTcjaeiNy8IuESI4KzFYkXU7SbnyGmEa5ANqy1yf0T3weztB65XS/8TIzlrwNARfPNhds++OGEoqtVvIp23Ey0OFVrJ
 dK1nGooZv/l0RbIlFYMu1ltdeh/4UIl5eIROxcLyF59X9F6M6Rn4cjyVkzaEPg49vaHMqruj2tmeBYk4oWMIHtZveJGUx+If0Rw=



On 15/08/2025 02:22, Ezekiel Newren via GitGitGadget wrote:
> Changes in this second round of this RFC:
> 
>  * Now builds and passes tests on all platforms (example run:
>    https://github.com/ezekielnewren/git/actions/runs/16974821401). Special
>    thanks to Johannes Schindelin for patches to things for Windows and
>    linux32.

Hmm, builds on *all* platforms may be a bit optimistic (it doesn't on
cygwin, for instance), so I'm guessing you mean all platforms which
have CI defined. Perhaps you could mention the platforms which you
have tested on. :)

ATB,
Ramsay Jones

