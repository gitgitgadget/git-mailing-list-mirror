Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.176
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794230020;
	b=hT1F4UtdgOVA+5L0ZofMAQeptW50lRABx0qxddN0UwZlXJbQN0tlX7xAkuWqWh3/cvyl
	 f8iwrUSMgb7pkWt8MKnCj/4DPyvicb+Jdi2Z1BlAKWGeXXH7U9tlV20khoVUP8BuBvFq6
	 AOrd5jHZb/jtP5pJZeDBd/Llf3iN2WZTjnS7NMuRUz/t4zry3Chc61GPQZRXf85QoeuK2
	 mWjhHY3qNB4gI/vBhLIO8T2yCUTrLOQT1GY14AyLrC4y1v+c/dwzL0GPVzVSY1vXFkZhh
	 Se1JEoqQ+tfXSPRi9WlRS+YHWBE3vhh0LUsd98jyxxu1+g+GRmBpPqaXFhufBBDgzbg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794230020;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=ovO8qhhwQb/PIfCCRywax16NDpwySQZEzjobbYaQSE4=;
	b=01oKHfvVh++iBGOUQQNFwOB4oBM5cVKGXcxljwdQpEWyjfaNHcXEyz53btkbOmbmw8IP
	 Oshx1f1LmyGY2oaCu9mZYpRbPm9hGOTVCX/l1MCjZu6VQGGi9WLRvl0OGcma17TRB9TXt
	 tCpK3iB0kbkRFDfytdhdlNAsfeD5EJHPt0Aa4KZlJzeWrBoSE050MM/B8ZIzNhIg3om1p
	 UjOr+RIGoQO3i+EnK86166hSk//gcHxPQrNAwHgK6iudEEXCPFaoeZVJN4PgubdF4vzmW
	 6VWYut3hDMNu9yGvVE0/kndI8bYaYhDLeNobO1ecSYplCGMjnhEdFMkCUMwDwI9+liA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zYhO87lD;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.176
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF8C8606A31C
	for <git@vger.kernel.org>; Mon,  9 Nov 2026 13:13:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CF8C8606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zYhO87lD
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-53656465d1dso372200b6e.2
        for <git@vger.kernel.org>; Mon, 09 Nov 2026 05:13:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794230019; cv=none;
        d=google.com; s=arc-20260327;
        b=lA8PkYBa7kPSUDA3ReN5V8hco/jx5nTh9OBug2XwXX1nHQpFwXnlomztb6qkWeOLhU
         tiwfauGTZZroJH1fH4sIdXk8F5JtDYfvoofCSduL2Gvmd/HIkGKWumGQSNCrVbVzRc4L
         E3qvZdAABU1Ug2vjpUT2jboOWXNJNvIiTZ58QohdeaEiiAC3NRIgWpod0N9/ycs+ViY5
         V76BUDIdrWUddFbfjOZzC1pAl73jR/0BDW+kdnx/cXtZPrr/5Y1dg8+7vVMXW2i1epjz
         yqBADuUEMF0Jc5ar9PLgj7xQA+oPgb4fPnsHQRya7DsgGnAnk7yky1d1ecHBy/xJMNcx
         3ZcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=ovO8qhhwQb/PIfCCRywax16NDpwySQZEzjobbYaQSE4=;
        fh=cjbW3SH7o/dwg/y6kqpWD0l++1enyM58I2wH5n1Cris=;
        b=BoIzk/Efcu5nD0ZYFgOOfa5PA12OtfLI3iXhXQZixme0IsFhhQe7ewUyhGOgTZnLdb
         DCYe0ZITp5zGYMqqaPiti/u0I/2tEJeUfx1FtTYM+JCsd9SBU5mjyygrw7yTBdoINvHy
         jv266yfiJdlOdGlR0zwo3P0EuULXDIBdB8b/wiNaIZlaKXQlZUVAu4j4DEyDAno8ESpz
         n1I/31V5dLEBk4NnA9u20LYmWFyq5W2NTskdgAmO8nUlFHxmCOBoD94VWwdNkR2pfpTa
         2YZaUa7nt8DKGbi4+P7JGsGMgHQEbMvVRa+gHNXLKyBnMAKKQYdKuwspF4VoYOHAjnjO
         bhFQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794230019; x=1794834819; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ovO8qhhwQb/PIfCCRywax16NDpwySQZEzjobbYaQSE4=;
        b=zYhO87lDHqspHKB27j7lUJHZerfdTT7MiASfnI01z276bjM8a/IDkoTaBs3L0vcKmY
         QCIXRSikjBjGApScboN7Eo5z0ZBz7u6MxInaEx9bzWUmuzt6aNrE+d9E6Plpfe4M0rqN
         biSbuORKmfrEnFei/dGEkhemgYQMN87uBY+M+CU2MKyDDeBfQhfbPN/Ef/VMgFFtwhy9
         HE1VOzxFHI2dWDUImQinMG88QQTKZbZ0/M/R/aTw84zv1gfl4zSEatGT6wrlfhIZywJA
         AfeMuBSm8vXSeBbz39ZbamCpmm4uWyD3qWPCxDFNSnk1MPme6JjpOvqDJy+/we37gwhs
         pSZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794230019; x=1794834819;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ovO8qhhwQb/PIfCCRywax16NDpwySQZEzjobbYaQSE4=;
        b=nVvnkioWdFdHIXvS7jqaBgHpaMMQZ/fE+nBSFHTP5cVI2idOy1N4ClM7rmAgvkNTy8
         wHdLOVHQp8bfmSTHjueTRLQGfLDoi1EvzaH8GmCMl5rPIXTqGrbIOVbUNu7kYlaDG3mC
         gd+h6i4hbuo9gfp1pVmLnIEbeFeTL6HZ2mA5OroPDKv4oiBtL04Hkqfzbi5npX4VnmXF
         RWEThv6BrAKsDfrO8hdRhGjVHw0sQv4osXCF5OGENvPidVsVLGpEgq+ZUX9mK5ZbVJiA
         phqIghPYNi5XDCKFJoop6KR+gchad9pTCvGKuhaGR6zJgplwz2CYjNgzNe4nJ8v5tts7
         n3xA==
X-Gm-Message-State: APuU4Z/431oEAQiDgz/rEJoV1bYE20xOYxs/T1vv+RpWJlMYnabyGB3T
	SGbAUpScdpxvb83BvugyJYjBN1NKeOoaA3Xf9CIkO+LF9l351TKzuWod5/UNLBMpHhu/CH+jdqi
	nnVDvRtQrIiMACdi5OE0tc+ZlYM9zFHU=
X-Gm-Gg: AYBFou33yXUMSolO6815d/9yHFhEDHJnY1IknP5OruzKmjhHvrrS7x+yxlw4/4dYJ1I
	rS1APzHRQVGHnAYMjd1XmeMsvPzz6ExhatC1tPPEWDsf0O9I4NETvFuycZOD5lWyA0RKfayiClb
	qkYjISod27Lkl9wBnclopOXM4OoHXS2vKaVDvlc6pZjl+KsuPzLxE7JiNX3MSQid+0WscMXHGeY
	lmviFMrj5eh4xN8v4BI0QE/xPlZNqVuZ+8AuBI7noY1QfclziEgCY4b3bBiburDsMx8TG1fT2le
	hxEzYoOcNrKVdowIH7N0vnq4grG09dVfE6uemMIvrX0MSt2w0Pk+oWz0HHfYxO93J5SGI+9+izf
	eBXEtI3juiTp+tS6pigjl6uiAsZTu8F8UPvxYSkdHTqU8ys9+2SLNUlPFfPcrhGBaeaY+m8Vq01
	oWNmeUPow8E4hF4QMWFLBHScivDtsAO5nZ5EGNUqmrGewOL6NleLGl4w==
X-Received: by 2002:a05:6808:4f2b:b0:4d6:90f4:48b7 with SMTP id
 5614622812f47-5681440715fmr2966866b6e.57.1794230018815; Mon, 09 Nov 2026
 05:13:38 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <CALdwsC1cMKZgRPZA+pBaJe4PPs9q9W0K9CQLmM2bgUCyysTB-w@mail.gmail.com>
 <20261107195429.96842-1-tangajoris@gmail.com> <7bd3360a-fb96-4631-8670-dde0d281532c@gmail.com>
In-Reply-To: <7bd3360a-fb96-4631-8670-dde0d281532c@gmail.com>
From: Tanga Joris <tangajoris@gmail.com>
Date: Mon, 9 Nov 2026 16:13:02 +0300
X-Gm-Features: AclHuK-jzQ4YAgDFVhgco_qyLUdoF8cHP_nZiuHXwbyW826WkBwBnP2l8PRSty0
Message-ID: <CAKrRMNr5VJmvws0asHgmDxCNxo19ctGTpM2eoTMT3iQ5v2cagQ@mail.gmail.com>
Subject: Re: [Outreachy PATCH 1/2] apply: do not keep names from an unused
 "diff --git" line
To: phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org, gitster@pobox.com, jackrawlings2011@gmail.com, 
	christian.couder@gmail.com, siddharthasthana31@gmail.com, 
	kaartic.sivaraam@gmail.com, usmanakinyemi202@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hey Phillip,

Thank you for reviewing my patch.

On Mon, 9 Nov 2026 at 13:52, Phillip Wood <phillip.wood123@gmail.com> wrote:
> These sound like corrupt patches which we should be rejecting with a
> better error message, rather than applying.

I now see and agree that accepting invalid patches was the wrong
call. Giving a clearer error seems to be a better direction to take.

> To me this looks like a corrupt patch because we have a blank line after
> the "diff --git" header followed by valid extended diff headers. Now
> that we accept this do we respect the file mode?

No, it does not respect the file mode. "new file mode 100755" is
ignored and the file gets the default mode.

> This looks like a corrupt patch as well where a space has been
> accidentally introduced at the start of the line.

Yes, I will treat this one the same way as the blank line.

> This is the only one that I think it is reasonable to accept - we have
> an empty patch for "f" followed by a valid patch for "g"

Alright, I will keep accepting this one.

For the next version, I plan to die with an error when a "diff --git"
line has no header lines after it, and a "---" and "+++" patch follows
before the next "diff --git" line. The error would name the line of
the "diff --git". An empty section followed by another "diff --git"
line would still be ignored.

One thing I would like to check with you. On master, a blank line
after "diff --git" is accepted in a patch that modifies a file. If
that patch has "old mode" and "new mode" lines, the mode change is
lost. The rule above would reject these patches too. What is your view
on this?

Thanks,
Tanga
