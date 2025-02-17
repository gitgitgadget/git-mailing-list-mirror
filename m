Received: from sender4-pp-o96.zoho.com (sender4-pp-o96.zoho.com [136.143.188.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B767217713
	for <git@vger.kernel.org>; Mon, 17 Feb 2025 11:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739791439; cv=pass; b=JVhVrveEkB3S5h0X0MpFeTMafV3Bmphl02DbK+cRHXRw0tlHcULrLytRqR8CyUQzj1i0zMZ5RBVY5JWEPB1SVnF8Qb8DY0wdrC8bKB4KRD/f/Sqo4q//Q97arb3uM4DF8IE1i1f7s5gPUM8JoE4T8oc15uVPimtcn8mktYTduYo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739791439; c=relaxed/simple;
	bh=q+Iw288XexFKd0vibKolDo7SkqDuUJTw9sqjwMo8XYQ=;
	h=Date:From:To:Message-ID:In-Reply-To:Subject:MIME-Version:
	 Content-Type; b=DWvltn+Wuy7Y4gMAxTF+dx+TD7eYzn6s1IYa6W2K9oHu7dGUEOi2lwB8tQagWcAKXgeWJaFmBtX4wL2iWDICSSr/nNaHRWccVh3P3XTGnbNbWa5Bn0MinkT9+nXQNUdi6d5ZlHCrmFTEQAK/S6I+sM23e8htMkr463ibMFDr8yM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=safinaskar@zohomail.com header.b=AMQY30nK; arc=pass smtp.client-ip=136.143.188.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=safinaskar@zohomail.com header.b="AMQY30nK"
ARC-Seal: i=1; a=rsa-sha256; t=1739791436; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=RmDIBal0sst5fxjCVkF4zlpaXQXgnIxZnPZQ0V1uuf2Ga2KL5btDEUIvzEQNDAjR11f8FVpFQK+D5efNyuWwvpZ3u8WdWa69UjOWHzZurpQ+EPtIuXIqeRYl9lRdtmG2/p7MQqfjQWiGULdv0gH1Pr3MJj0SLHaxUoH8waXhR1U=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1739791436; h=Content-Type:Content-Transfer-Encoding:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To:Cc; 
	bh=vdIq91Z6hR57ZCj6x00AgYVfYM9g3CxrIQw/XQGJ3zs=; 
	b=Z7pe5B1kdwjHMmVURjium3RsC+i4ZU8Wo7V984jAOnlJFCTOCrBhm9h/FM0xbUg+qkP7r/A3SlOYAaqhfARPWJ+oEDUnIPFxY2nwPnd/hzkfqun/MVYoG3b09yy0Cjk+b+HyIzeHYynTv+Ccu+dxwXw/YCoTnLHoFlfd5Bi6I48=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=safinaskar@zohomail.com;
	dmarc=pass header.from=<safinaskar@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1739791436;
	s=zm2022; d=zohomail.com; i=safinaskar@zohomail.com;
	h=Date:Date:From:From:To:To:Message-ID:In-Reply-To:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To:Cc;
	bh=vdIq91Z6hR57ZCj6x00AgYVfYM9g3CxrIQw/XQGJ3zs=;
	b=AMQY30nKnmewX7GOS1EH5mT6efOsrmzxe1TlAe+W9gS16+M13HFZGMm1xGt11MzO
	8TQhWKfuKAPsQqc70okLZycXZtpAk+NQhLgL4v3L0EwL7mytroMs1E76ASIw5DOyiyx
	9xNjw/xVo9ApBdArz1mjLEcGFtMgdF31bPk3UHY4=
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 1739791434333539.036340729668; Mon, 17 Feb 2025 03:23:54 -0800 (PST)
Received: from  [212.73.77.104] by mail.zoho.com
	with HTTP;Mon, 17 Feb 2025 03:23:54 -0800 (PST)
Date: Mon, 17 Feb 2025 15:23:54 +0400
From: Askar Safin <safinaskar@zohomail.com>
To: "git" <git@vger.kernel.org>
Message-ID: <19513a6824f.100ecd6fa87777.1312023226997891829@zohomail.com>
In-Reply-To: 
Subject: documentation bug: git send-email: manpage says that I will be
 prompted for everything, but this is not true
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
Feedback-ID: rr0801122c35b300fe017ae5844ce500240000476237352975c2d1f5460d3e59715b78e5185e816ca29d22c5fdf8536bb9:zu08011227a3cd16de9c879d1e9dee2b9c000074968ccd1f5a65d68c597308d1d5f1e402a0abe3b5e26f504d:rf0801122a0fd3f8d041ab7b517219332c0000e7fb092d2da52213493f7d32e3c69241b59d861292e4874f7caddc5c:ZohoMail

Hi. Manpage and reality disagree, so we have bug either in manpage, either in "git send-email".

Manpage for "git send-email" (v2.47.2) says:

===
The header of the email is configurable via command-line options. If not specified on the command line, the user will be prompted with a ReadLine enabled interface to provide the
necessary information
===

Also the manpage has this part, which states this again:
===
--subject=<string>
           Specify the initial subject of the email thread. Only necessary if --compose is also set. If --compose is not set, this will be prompted for.
===

But in reality "git send-email" simply gives error in case some headers are absent:

# echo hello > /tmp/aaa
# git send-email /tmp/aaa
/tmp/aaa
No subject line in /tmp/aaa? at /usr/lib/git-core/git-send-email line 845.

So, please, fix either manpage or git.

My git version is 2.47.2, my OS is debian sid x86_64, running in Docker. git is installed via debian repos.
My git config is so (password is ommited, of course):

===
[user]
        name = Askar Safin
        email = safinaskar@zohomail.com

[sendemail]
        smtpServer = smtp.zoho.com
        smtpServerPort = 587
        smtpEncryption = tls
        smtpUser = safinaskar
        smtpPass = (password ommited)
        from = "Askar Safin <safinaskar@zohomail.com>"
        suppresscc = self
===

My $TERM variable is equal to "xterm"

--
Askar Safin
https://types.pl/@safinaskar

