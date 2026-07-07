Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2820F397688
	for <git@vger.kernel.org>; Tue,  7 Jul 2026 09:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783416623; cv=none; b=TBGysYmOlr5AIjtJ+lXfONQWD9r56dEJilmoNNmkaHSPn2597UAV9T7+ji1JHfc2GIGGe4jNhHrixnwZfBOzNfCtULyl00eMH+MywUYfQjkkIxbKIY46Fl7DKOMld19+tfI7A4wCOkWIKnoecu9Z2bqOnwtTGs4vGITY6KUBfnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783416623; c=relaxed/simple;
	bh=0tlTf5yI5fP2131jAvgDcUHT2h7pH7t36lMpcK3oCq0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k6eUkUIJB4aX3RTAaKrs7jjdPr1Hn14e6uImZWshB5cDsz8s144ugJM7yvAlGrxwnSPebruB/yppQZaPG2U0Pu2RV1E8m2PlW7ouXcXyVWLNSp1VWiysFpn/CvrknLvtUXRgw7+Fszxl2OrmmOFAV7xtYuWRJhS5rz90W3wgHL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QFfIRmTK; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QFfIRmTK"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-c1268d56234so512540566b.2
        for <git@vger.kernel.org>; Tue, 07 Jul 2026 02:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783416620; x=1784021420; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=rwdeoVRSg9V/jo7DxugWx0tVX+WCgqNhg2Ya1YMjZtU=;
        b=QFfIRmTK1TQFcJstCOM5+onpd5gDLoG/022WUUrBappyTMGxefZFhw4st9yzGsdXnq
         C6C77MuJvCUDaGxQwVNMk61b9pfMR3DVs3nyymSx2QP4vDpMBRU3o2wM4qP1ep2oI5be
         +aafUbKD1a7SPv8iyBq5ZSXLKlR1Ry8UVzF9uGACZWOi9FnUtqNYRJVohg4u3RqOJ1BZ
         45h3QCXEbhHr+2gmJP1x0Lx/Tp3OaGRwGzPpEK9Mj0TSdQr+uEQ3/FYgxp/IOWBC0DY2
         4fP3dktGAY4RIdxVh7Nsv2FJ/5NEbDtwAR1Bbea/v6YmFETV4+eBmFtRnPz5tYW02UnW
         v27g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783416620; x=1784021420;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rwdeoVRSg9V/jo7DxugWx0tVX+WCgqNhg2Ya1YMjZtU=;
        b=othnyCrap2DJlASTWcbDZpoQm+7/OyE1n+Rb2lmz0a0cSeWvnlZQTaz4BRmN/2XNda
         tXIjW7EW0K88STrF61Z4kFSU8osVo8hL6nWM8ytI2b9DfeY1lNbvGrwrSjSK26/3pzKs
         OWgo/OELPAtwOlC5nQnnpK0zpDVFZKPwfeseVUEqgc2AnO/uhnK6JAN7uqayRF8zOILb
         3rr1H0nGB8S7bAFBy61qwAT49y2Z08PAokVIIQ7+m61acfGTY/3YrlxYCk8H4Nimo3Ie
         JvSY7W83hVaOPkG7R1hlyyEFqtHYQpdZL8dTR/PGugUSyoO1BSh9AT6dOoA5XiQqIrea
         pPAw==
X-Forwarded-Encrypted: i=1; AHgh+RqZv4sbixaSFLfPJGA7d3NyVsXDQ3hZf8vgauuts5AbwrVh200i6NMTGfTmnGBOGGb2xlA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqXqLMYva1BJHtp1APTyY+wHcc4HGaV0dgMzy8o39jTts1qt3v
	NezOJfn4qtmHX77TrXKm3grxC3m0gLyZKT9FNc0SkreTct6m4zIFBrPx
X-Gm-Gg: AfdE7cm9YOOC8glhgG8NuADigOMtyMIE6RyWB00yd98m2SyOGR6xx18jN2pP4Rpt+5S
	yQDlxd+P6zDmgckeOuhRy85xhRjhbESDMl4ccPJt5a5aQ6/6ZzEwcvYluXehVfla+w0OOK/JfbJ
	G4sbSfnnxGtJifqYHsBsq212UM12pxbvhLMkGC6EBF5k+YMmFx5B0fuVYqXQphJe0ERTPbSqUrF
	nyevyIBfW9avkMR28t5K2Iv7PM32foWTW/O/ZTyOOis172lmWyXF8W7sDy+AnK8KEp4klc/0D/S
	iAumOIUIWYDH6Oc579+q0Y8DJLHWYQWZTqaUgko2g0Cb91hZJ12mclIRGQPBV1vjO3ilLfCoa4Z
	GmVc1LFSG5T9lHd5J1pmAn96lpbwJWbVTSTaFy96oybpS60HNYji5jUQ+wY6qBkBOL/R++/q7l6
	5OJTnjzNrQShe7B5cFnQsCYxVY9h77+zIjyLk3JbJtwizVCuC0P1gLDCyK3E0mO+kQa1k=
X-Received: by 2002:a17:907:6d23:b0:c12:76ed:5d5a with SMTP id a640c23a62f3a-c15a69b9042mr240202666b.65.1783416620181;
        Tue, 07 Jul 2026 02:30:20 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:69a:b801:201a:26ab:8d41:fb43? ([2a0a:ef40:69a:b801:201a:26ab:8d41:fb43])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c15ad844cacsm94782466b.19.2026.07.07.02.30.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jul 2026 02:30:19 -0700 (PDT)
Message-ID: <38493ca6-8fdd-4b6c-9972-5145f3bf0aa4@gmail.com>
Date: Tue, 7 Jul 2026 10:30:18 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v7 0/5] history: add squash subcommand to fold a range
To: Harald Nordgren <haraldnordgren@gmail.com>, phillip.wood@dunelm.org.uk
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>,
 Junio C Hamano <gitster@pobox.com>, Matt Hunter <m@lfurio.us>
References: <pull.2337.v6.git.git.1782635349.gitgitgadget@gmail.com>
 <pull.2337.v7.git.git.1783327849.gitgitgadget@gmail.com>
 <5a5dbfae-4525-4b00-9e44-936be606ee85@gmail.com>
 <CAHwyqnVxa34iGmFvL4Ujrc2dTbmtF+7j7b=q5v95y=-pzUf0NA@mail.gmail.com>
 <CAHwyqnVd2OsmD-Y4YKVr9GsYdHRRNDot5EKSSESoRM-mf82YSg@mail.gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <CAHwyqnVd2OsmD-Y4YKVr9GsYdHRRNDot5EKSSESoRM-mf82YSg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Harald

On 07/07/2026 09:55, Harald Nordgren wrote:
>>> The range-diff does not show any input sanitization - what happens when
>>> the user passes "--reverse" for example? As I said in [4] we should copy
>>> what "git replay" does to sanity check the rev-list options, otherwise
>>> we've got no idea whether the parent of the first commit returned by
>>> get_revision() is the commit we want to use as the parent of the
>>> squashed commit.
>>
>> Yeah, good point.
> 
> Well, the code already blocks "--reverse" and other unknown options,
> but I can clarify that better in the commit message.
Well it accepts

	git history squash -- --reverse ...

because after calling parse_options() everything after the "--" is 
passed to setup_revisions(). There was some discussion about accepting 
rev-list options [2] so it would have been helpful to reference that in 
the cover letter. The cover letter should explain both the changes you 
have made and the suggestions that were discussed that have not been 
implemented so readers can get an overview of how this version relates 
to the previous discussion. Without that it is impossible to know if you 
disagree with a suggestion or have just forgotten it.

"git replay" supports arbitrary rev-list options by passing

      PARSE_OPT_KEEP_ARGV0 | PARSE_OPT_KEEP_UNKNOWN_OPT

to parse_options(), then passing the remaining options to 
setup_revisions(). After that it checks the various members of `struct 
rev_info` that it cares about are still set appropriately.

Thanks

Phillip

[1] https://lore.kernel.org/git/xmqqzf0dwalx.fsf@gitster.g
