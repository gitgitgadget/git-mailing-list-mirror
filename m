Received: from mailout3.zih.tu-dresden.de (mailout3.zih.tu-dresden.de [141.30.67.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB217253B52
	for <git@vger.kernel.org>; Fri,  7 Nov 2025 11:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.30.67.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762515957; cv=none; b=OuiBuJhpfHzy9mje6zg6xOQyYIrAfViVk6YNTKP3McsLy+WaGzW4a5McwA7DQsC/H9emaGxKKz5dgYTRHwLZQtta7Re0Ws7jQX5XO0GcQh+IPiE9JSSlsKdj9aIZlfaKtWM2hfecpLvFBzjJVKPe5sYmvGHWESiOYQqz9do1a0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762515957; c=relaxed/simple;
	bh=Iap+gBp6HmWTHuzCjT5ULB1GKiVkab9YXpuHv74lqMY=;
	h=Date:From:To:CC:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=jsayQWo7fg6CwqjJfJ4A8u7PAa/+3qV116B0kLVKnid+e1nL331hWvEvAc3mEx951pFci5wjaqdFSG3o5gGq8+Wx9DQOO9pw1w/C7C0t9SCOu7wlbmZHSb2cNQmaw6Z1kkrhLSM1OkSXuotD4EQdA/U4M681Oha/glQZtcU4kcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mailbox.tu-dresden.de; spf=pass smtp.mailfrom=tu-dresden.de; dkim=pass (2048-bit key) header.d=tu-dresden.de header.i=@tu-dresden.de header.b=slyUtGTq; arc=none smtp.client-ip=141.30.67.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mailbox.tu-dresden.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tu-dresden.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tu-dresden.de header.i=@tu-dresden.de header.b="slyUtGTq"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=tu-dresden.de; s=dkim2022; h=Content-Type:MIME-Version:References:
	Message-ID:In-Reply-To:Subject:CC:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=rM7sNXB6AuCg3lbRiX2LsY+6T4p+0evvUXc9LhuEEM0=; b=slyUtGTqiEoWhv9AG+3wk5tzUc
	3iN5BcK4wkIU34MkgY112zUoV9LYijhnKVYGhCT4X/Mpr9ElnRewC5mDXRoabtXM/jAXYe3qlJfgh
	N5fMTCUgYq2aiD6UcRLP7NJqdBSI2bdguLXjA5qlIKyv6pGl4TDpSjP/gwPMNHVd5J177eDG1UEv0
	4UOvpEa5o3hCqzDow1PNxmCg0FeKXYNtQSjXyBERJp1izbiDUjwT9GoJbYH5VzZmeMdcJMJqOUFZz
	gCc9/WxnREWO/UZHfo2CDbuXhyyYvm1FSC8V5bnoZBx/kHQV/2PPOwOcenhGxqA7iZret3/jlcuGf
	Q5KjFCoQ==;
Received: from msx-t414.msx.ad.zih.tu-dresden.de ([172.26.35.134] helo=msx.tu-dresden.de)
	by mailout3.zih.tu-dresden.de with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <thomas.uhle@tu-dresden.de>)
	id 1vHKub-00BYXl-AO; Fri, 07 Nov 2025 12:45:49 +0100
Received: from login2 (141.76.13.149) by msx-t414.msx.ad.zih.tu-dresden.de
 (172.26.35.134) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Fri, 7 Nov
 2025 12:45:37 +0100
Date: Fri, 7 Nov 2025 12:45:33 +0100
From: Thomas Uhle <thomas.uhle@mailbox.tu-dresden.de>
To: <git@vger.kernel.org>
CC: Junio C Hamano <gitster@pobox.com>, Johannes Schindelin
	<Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] wincred: align Makefile with other Makefiles in
 contrib
In-Reply-To: <xmqqv7jnhzmh.fsf@gitster.g>
Message-ID: <19573251-81e1-e07d-0f21-1f90ea5153a3@mailbox.tu-dresden.de>
References: <3869ec21-e20d-cf9b-5913-6389c372a5f0@mailbox.tu-dresden.de> <927c2094-3654-edec-072e-1f6ca7d91f96@gmx.de> <xmqqv7jnhzmh.fsf@gitster.g>
User-Agent: Alpine 2.26 (DEB 649 2022-06-02)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="1284350480-1113763855-1762515937=:935858"
X-ClientProxiedBy: MSX-L421.msx.ad.zih.tu-dresden.de (172.26.34.141) To
 msx-t414.msx.ad.zih.tu-dresden.de (172.26.35.134)
X-TUD-Virus-Scanned: mailout3.zih.tu-dresden.de

--1284350480-1113763855-1762515937=:935858
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 8BIT

On Thu, 6 Nov 2025, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
>> Hallo Thomas, wie geht's? Grüße an den Biergarten am Blauen Wunder!

Ich komme am Schillergarten so bald leider nicht vorbei, es ist einfach zu 
ungemütlich draußen, und Glühwein gibt es vermutlich auch noch nicht. ;)

>> On Wed, 5 Nov 2025, Thomas Uhle wrote:
>>
>>> * Replace $(LOADLIBES) because it is deprecated since long and it is
>>>   used nowhere else in the git project.
>>> * Use $(gitexecdir) instead of $(libexecdir) because config.mak defines
>>>   $(libexecdir) as $(prefix)/libexec, not as $(prefix)/libexec/git-core.
>>> * Similar to other Makefiles, let install target rule create
>>>   $(gitexecdir) to make sure the directory exists before copying the
>>>   executable and also let it respect $(DESTDIR).
>>> * Shuffle the lines for the default settings to align them with the
>>>   other Makefiles in contrib/credential.
>>> * Define .PHONY for all special targets (all, install, clean).
>>
>> These changes all make sense to me. Feel free to add
>>
>> 	Acked-by: Johannes Schindelin <johannes.schindelin@gmx.de>
>>
>> Thank you,
>> Johannes
>
> Thanks, both.  Will queue with your Ack.

Thank you!  Does this patch qualify for the final version 2.52.0 or is it 
already too late?  And if it is the latter, wouldn't it make sense to have 
it in an updated version 2.52.1?

Best regards,

Thomas


>>>
>>> Signed-off-by: Thomas Uhle <thomas.uhle@mailbox.tu-dresden.de>
>>> ---
>>>  contrib/credential/wincred/Makefile | 18 ++++++++++--------
>>>  1 file changed, 10 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/contrib/credential/wincred/Makefile b/contrib/credential/wincred/Makefile
>>> index 5b795fc..d92e721 100644
>>> --- a/contrib/credential/wincred/Makefile
>>> +++ b/contrib/credential/wincred/Makefile
>>> @@ -4,20 +4,22 @@
>>>  -include ../../../config.mak.autogen
>>>  -include ../../../config.mak
>>>
>>> -CC ?= gcc
>>> -RM ?= rm -f
>>> -CFLAGS ?= -O2 -Wall
>>> -
>>>  prefix ?= /usr/local
>>> -libexecdir ?= $(prefix)/libexec/git-core
>>> +gitexecdir ?= $(prefix)/libexec/git-core
>>>
>>> +CC ?= gcc
>>> +CFLAGS ?= -O2 -Wall
>>>  INSTALL ?= install
>>> +RM ?= rm -f
>>>
>>> -git-credential-wincred.exe : git-credential-wincred.c
>>> -	$(LINK.c) $^ $(LOADLIBES) $(LDLIBS) -o $@
>>> +git-credential-wincred.exe: git-credential-wincred.c
>>> +	$(LINK.c) -o $@ $^ $(LDFLAGS) $(LDLIBS)
>>>
>>>  install: git-credential-wincred.exe
>>> -	$(INSTALL) -m 755 $^ $(libexecdir)
>>> +	$(INSTALL) -d -m 755 $(DESTDIR)$(gitexecdir)
>>> +	$(INSTALL) -m 755 $< $(DESTDIR)$(gitexecdir)
>>>
>>>  clean:
>>>  	$(RM) git-credential-wincred.exe
>>> +
>>> +.PHONY: all install clean
>>>
>>> base-commit: 4cf919bd7b946477798af5414a371b23fd68bf93
>>> --
>>> 2.47.3
>>>
--1284350480-1113763855-1762515937=:935858--
