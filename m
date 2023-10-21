Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54FD9EBD
	for <git@vger.kernel.org>; Sat, 21 Oct 2023 09:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=abc.se header.i=@abc.se header.b="FTNDA7et"
X-Greylist: delayed 399 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 21 Oct 2023 02:37:15 PDT
Received: from hekla.abc.se (hekla.abc.se [158.174.61.227])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D500019E
	for <git@vger.kernel.org>; Sat, 21 Oct 2023 02:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=default; bh=Y7BEU8sQqr
	lPssIPZLbZH67dRsaYfp087dUlEzEBM2s=; h=references:in-reply-to:subject:
	to:from:date; d=abc.se; b=FTNDA7ettZ5DCqWjhK/1aWLVeivoP7vRYoFLSZOFIGQv
	aYACxEjmaZ1IgxT+hLVIFbOrcMJcLYnf5vQGg7MLFARW+7rruJcnPX4QmfsMTZsFF4jLjF
	ozFzGCf4No2wZcLaJZo/E04QKgM9uitTSKY7qvrhNSs/wUJsmF13hmFc3fv0CdaV49r6ye
	IhXmizaIwgOZ5XD9FhHzC+ZhG7PxDcY84Vy3OEjUMChDevLHJhMOCtzTkQi7dABmK6G1F4
	6PBic3TcJawVbdZlgY63d2z0RtfTUyjIAVWqxCmusncxbu8w4GEtcjchu66FW0myhcsfJr
	EP0J2wjeXxFVcItPVA==
Received: from perkele.intern.softwolves.pp.se (cm-84.209.5.132.get.no [84.209.5.132])
	by hekla.abc.se (OpenSMTPD) with ESMTPSA id 7100aa1d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Sat, 21 Oct 2023 11:30:33 +0200 (CEST)
Date: Sat, 21 Oct 2023 10:30:32 +0100 (CET)
From: Peter Krefting <peter@softwolves.pp.se>
To: Git List <git@vger.kernel.org>
Subject: Re: Is there any interest in localizing term delimiters in git
 messages?
In-Reply-To: <CAP6f5Mmi=f4DPcFwfvEiJMdKMa0BUyZ019mc8uFXyOufgD4NjA@mail.gmail.com>
Message-ID: <f6d7e29c-3532-428b-2c1-371eedaa5492@softwolves.pp.se>
References: <CAP6f5Mmi=f4DPcFwfvEiJMdKMa0BUyZ019mc8uFXyOufgD4NjA@mail.gmail.com>
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
Organization: /universe/earth/europe/norway/oslo
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

Alexander Shopov:

> Hello all,
>
> Is there any interest in being able to change the delimiters of the
> changeable terms in git messages?
>
> Typical example:
> ORIGINAL
> msgid "  (use \"git rm --cached <file>...\" to unstage)"

I think there should be something indicating the variables, and with 
Unicode there are better choices than the ASCII 
less-than-greater-than, for instance U+2039/U+203A. In the same way, 
we could also fix the quotation marks:

   "  (use “git rm --cached ‹file›...” to unstage)"

The source should perhaps still be ASCII-only to be compatible with 
older systems, but we could create a en_US.UTF-8 localization file 
that does the above, and apply similar changes to other localizations 
(I have been thinking about doing it to the Swedish translation for a 
while, but so far have not come around to; of course quoting differs 
from language to language, with different styles for ‘English’, 
“American”, „German”, ”Swedish” and «Norwegian», for instance; it is 
all very confusing and difficult to get right).

-- 
\\// Peter - http://www.softwolves.pp.se/
