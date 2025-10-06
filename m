Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0783F2DF3F9
	for <git@vger.kernel.org>; Mon,  6 Oct 2025 18:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759774907; cv=none; b=SybpBt7RnvszNyTyUW6T7zXh6fXFmLSTcQsEgzgu4j589fP2t4j6MFfQ+XNtxOOVkK9W+HGnekSukpv8yzTwNVjSfLOMMwbCgI+T9o4eUTY/sxacXG+uzIYfrtM6WfGmQf0kA4KixMxTfLzlW6vQKTs00to4uyEVCFc2nofy2/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759774907; c=relaxed/simple;
	bh=CB91LQ0p75AGHXbX+Zd+wOSe+V6SGg2RheR9pfP7lsY=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=WsbITYTO/SCz5gQM/ZvePLm/7msJvF3P6ygQddAEiTpjN9nGPgn2K2gAl+jYWVKj7lA1v2etcMkBijtbguluxtPWD7yQgqNOIiF+E7pxSWKQKGmXF3T2Fn/jwZT5xw/NjF9diJFEwsNAvJGTqfXwLPTVBVeUk68aIi8wbi5p6AI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=DQ6LYaJ9; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="DQ6LYaJ9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1759774896; x=1760379696; i=markus.elfring@web.de;
	bh=mBRLi3fGp8fzLe/Ojt0Mn0eLrPd44YfY68MEor15Atk=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=DQ6LYaJ9Ue7aR+4zO9+JIZovto0Xi+5W9zniVEgFRHkfPG4Za/yS5NZE1PAaAEW8
	 3ogj0AXkFiigKan1UDCYg+JkMg9AurTubmj/sroPnDnoflp0I+m8F7fQfkcJg9GNw
	 l5A0tvWndhwB2HGRGeKVyz2DFjGEOu74UDABwFPm1G6wbWvrVwHyJZdhiXPPFUQoG
	 Q2L8r1q4FA91aZSWrpLfxJY1/29KeYfw4ChmWhQaqeL6HDy7NAulrN+Tjk78E+GVn
	 QUAWQEaU10aAkBWQBrVWSFGbFLkSuvNs4PG+FXcGxynGFLZsJjLNvZwn80Goz0xg5
	 bQ7frY9FeYQNJVMiJQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.214]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MpCqh-1uULkd2xvL-00malh; Mon, 06
 Oct 2025 20:21:36 +0200
Message-ID: <9daf163d-d2e8-48b4-8c3c-b718d39c68c9@web.de>
Date: Mon, 6 Oct 2025 20:21:35 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: git@vger.kernel.org
Content-Language: en-GB, de-DE
Cc: Steve French <smfrench@gmail.com>
From: Markus Elfring <Markus.Elfring@web.de>
Subject: Failing application of patches despite of successful data export by
 git format-patch command
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Njyk/d3/D+Gz6Bb04ixMCOIxtKg17f57Q1GTwIJC7dsrL2PTnej
 wjNtkXl6BC2LvF9NUGdIhKB3XLEZEfcBCaKHd6JiBaHhfnTCs2mX+omZiXXFjHjxNv6CT0T
 cNOUptmVMJKTvbiLhqIlahvdAC+i5bcMmG0sIDcWH7FXz/2T7vvYeh/Dhi7w3AskitTV11o
 iesXqTbgkKS6PUyRySnaA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:E9JpHTMu16Y=;9g/PTRPaSyac7PIEAnjNW4TGlD8
 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
 QDAdQ==

Hello,

I published development ideas like the following.

* smb: client: Use common code in cifs_lookup()
  https://lore.kernel.org/linux-cifs/7811a101-2d81-4f4b-8e33-db3154c6137a@=
web.de/
  https://lkml.org/lkml/2025/10/5/170

* smb: client: Reduce the scopes for a few variables in two functions
  https://lore.kernel.org/linux-cifs/468cf96a-5dd9-4aa5-a8ce-930cf16952b3@=
web.de/
  https://lkml.org/lkml/2025/10/5/183


Steve French informed me that these patches would be corrupted and won't m=
erge.

They were generated based on single commits for a source file of the softw=
are
=E2=80=9CLinux next-20251003=E2=80=9D by the subcommand =E2=80=9Cformat-pa=
tch=E2=80=9D of the tool =E2=80=9Cgit 2.51.0-2.1=E2=80=9D
on my Linux system.
Thus I wonder also about the following questionable information at the mom=
ent.

Markus_Elfring@Sonne:=E2=80=A6/Projekte/Linux/next2-patched> git checkout =
next_adjustments-20251003
=E2=80=A6
Markus_Elfring@Sonne:=E2=80=A6/Projekte/Linux/next2-patched> LANG=3DC git =
apply '=E2=80=A6/Projekte/Bau/Linux/scripts/Coccinelle/tuning1/next/202510=
03/Flicken/0001-smb-client-Use-common-code-in-cifs_lookup.patch'
error: patch failed: fs/smb/client/dir.c:679
error: fs/smb/client/dir.c: patch does not apply
Markus_Elfring@Sonne:=E2=80=A6/Projekte/Linux/next2-patched> LANG=3DC git =
apply '=E2=80=A6/Projekte/Bau/Linux/scripts/Coccinelle/tuning1/next/202510=
03/Flicken/0001-smb-client-Reduce-the-scopes-for-a-few-variables.patch'
error: patch failed: fs/smb/client/dir.c:678
error: fs/smb/client/dir.c: patch does not apply


How do you think about to clarify and improve any aspects of such data pro=
cessing?

Regards,
Markus
