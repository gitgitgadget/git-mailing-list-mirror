Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793046744;
	b=ILIst/XknKZ1I21QeRvJxFPcQXwiHD2qLX/Lu/mEFnf81Kw1zpRW8/Qgs1PRLhO+G6Yf
	 GGPbTq0mUGsNhkAAmSWluWBRlveZ8HrMElECvQ1tgetvoGdhWIzS1Jbheki6BUwRz1hds
	 jZg2GIUHZYskOk8KsPsEavh2YSdtqU9WPV1NPcO6GUyXRS08MivfTXGstq6eN/tj54HM/
	 6zzxGb8/ZF3xIYmxxYP+jW/7ZSAoLHKLH0tNPROwAArFNNV/ZIIBMXjh9qQHJN9jg/UH4
	 RV4mTSv7Btfq8n1pc/mZdAGeyUba87buqCmadUw58aWbNUE6/xBSATkZ29s+LJIvxEA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793046744;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=jOrR7vj6r3rVI1kRj8pmrGNJZ/Ph4+mWHam6ZH0i9VU=;
	b=yyPDhbuxoYqVFofhxl4aW9VTjSPhZhSJn2pxpjx3Rz/If7IKO6rYDexNT/nWRAAymNRA
	 jocxKpGbxoh2/AT6u0liCCVJFhqKJ65CIR1N0ZcAqsiun/3WCoj2hNM4RnLSKCfdSo0h+
	 I9px7zcMNJOuuB0PNgjilnrY3QsX+tCi0fLoAP9lXXA3aKO4MbBR0cdlUskPw/YrNkB8v
	 /w32Zap375PcPTo6wPx3rTz9uQ+OnfO5k7n8hX0FIRdttyGyxVn1HMQMfgBePdaaPj3jH
	 buOFkmm4M+3O5QX8Ej67Wfbt76Tf89eEtNnfqE5BbDHHSKg+bVUWSQUkus62rYr3RbQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Ag4gPRlh;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.45
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F02B606A33F
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 20:32:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5F02B606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Ag4gPRlh
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c46822eefb6so446721666b.2
        for <git@vger.kernel.org>; Mon, 26 Oct 2026 13:32:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793046743; cv=none;
        d=google.com; s=arc-20260327;
        b=Ykz/lYLZ4QzWzmg2WtI5wNgt1KCsIewUOelKIxswMGzg8kBkxEX/bhBZvFNBetWGoD
         IpzLZvqYXX2VAWtGPZWkvff3RCAHUDOimONKVuiMehiTLxkDdtZgobO8c+ofVez7YnTe
         HGRk18doYg28Wm9WhFwEvgiz60EcXGCUSWk7saQtaa97eR+Y3jR6HW4+RTwQHQmtNxPe
         wamgXag4AWM0QOf90QyZJQDFc6wgDap1saJ1aTTn4JnWFgJWM6B1XkDQTyOA+YHvZP4F
         ePUuyPkHk1ajFyHZ9bOvvuJ6xaA/jWbeZWUxBMX0/kX5ck45Rw3/mAcqyHWXQJOhcwCk
         Cd7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=jOrR7vj6r3rVI1kRj8pmrGNJZ/Ph4+mWHam6ZH0i9VU=;
        fh=2neGNSFCezYEn8XotWoEp1Z60aJip6GkaOlz6pz9/oc=;
        b=lj/CkI7vqeSyxmkC/fllTflEKfvjV43eHRndoiXcyy4eBOG029VwRhr3/uPKJ3ytaW
         4pxgclwMODEkvnnbHRpSQbcKAZdhdDwUK5Sp71g7gdgcS5bFyLP4rPK0RYu6WjiMuf2w
         4SbG3etemC1M8j9//DpsJEaXZPUHuU2wmmgkZFCy8FyjBORVp99A4v3lynpPpWEKdCT7
         +W4tVLImj9m675ICTh/pUU7u9U29LJf1XrbZX9VdNlwtgqXnsmBOQgfBlt0dqs2KJH26
         3tqxIMMA5P0yCvbfB/1vONXN2vPavavQyGJzJYEa9ZN0UPFyj5zmNPs/GppJruK4Dmh/
         sSpA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793046743; x=1793651543; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jOrR7vj6r3rVI1kRj8pmrGNJZ/Ph4+mWHam6ZH0i9VU=;
        b=Ag4gPRlhXIinKliJi/GBHpBCA0mCPmDJe2Su497mf7HK2pOM8vTrTNQKwrMjIwkKjM
         OkBUuX+/VKKwpJWiKI9xY5xFHjnl1oRNP16pNLV7BMs9st3rR9Vy28HB9ux7ms6AU0QD
         1QTDHfENofddv/YkK3QqNx2U4K8nWA4QPbAj1EoWjk0TUioEQddWlYB1anId3TLkLUbw
         oHJ9zLuvrj9spSxEbhUO2yCsjoIKg8GG9GuY6ZubpvuKapnMiIEiFmgQU1PuMLdlNY13
         aKG8ytsEZK25s4JLalK01/Vlkwzhvy9d7FU2Xe/0nMDa5LAB6zl87a++YFcIDJx+FFsY
         yoBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793046743; x=1793651543;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=jOrR7vj6r3rVI1kRj8pmrGNJZ/Ph4+mWHam6ZH0i9VU=;
        b=UTA/7gnr3f6Zy7Cu9bPkMWKZ8e8Hp/2zrjEuyIGmPVPQnltGVtjGKcLmzQ4RnTF/CS
         Bbl4HSo/5Jr0pAiqHTanmrYPVU2+eII+ZxHWiKu/hXv7HLOXiS2TLHsdlDlK8I7D5h3P
         RX2piFKqyX0X8xCWJW7tiqsQorNgnGMYYLCu82lnoiWJ+VWqSNUvrA2aWGcchV53eE10
         HgdZZzMqtGRHGylHdI6Ajy/PDnHzEuJB3ykuzNe+aYBW58Rx7DR719/dZaa2hX/c1QtU
         9wvfXGe1iFzl7ElfKKRJpnSrYYENNMMX8f4JTGNq6B/4xG4HTHQfPV2AJIKSVgLNhi/v
         JdVw==
X-Gm-Message-State: AFq9FYIAgCzMgCR9scYHNHWdWJceTmMP50nxP7igLRAkFevpS0kOyfsr
	bPEYSasR0tvTIHPlarhrzlcI9h5Sjv7tgE9a9czuvoC7TRYALHlD+izzYNuZcGAG6bH6Ksa8rKS
	DBu+Po/sfhQ8KwNgDYqiC+yzeL3JXgCo=
X-Gm-Gg: AYBFou0CU2icRcbnxrWomhdc9jWE9qIz8azrnO/PMQxm4582Xxz7lTiGwtPPVE/VLlS
	+aZgDTLx18pPbYYDGvBn4EZpSMCQpznhNnQ+UNlDgARQDhDxj+uZuqXiE0szAKfT+92iwAJs4jl
	0FHNmLdtdVay9Uy4kzek+aK1yhhwPkuG1qdktpRfr+c/jKGS/ruf1QbGL95AzTaD/eZpr/Snwyv
	HDOLgdRWjiDyPY0e2hOyDRMw/mAXxnNpoO4izSvQzo3i5uY+dyX5NU8aN4c+DricnbYx98Y888+
	/CR33MAdwG/LCJhIG2mI+pVV/YGiRSetds+jXfLtBm7LrjaeKgFyKjUIV2ufqzk2SONHGBOH3mT
	4CFMAWYkP42dSeND9WVtPru2XNrFueeO0xSyEICPuoGUTPpJfBNIdahxd9Dj9dJYvaXMijB4=
X-Received: by 2002:a17:906:f5a4:b0:c29:5b0c:1b44 with SMTP id
 a640c23a62f3a-c46bde8ad37mr927038566b.37.1793046742392; Mon, 26 Oct 2026
 13:32:22 -0700 (PDT)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261023154851.7876-1-ogundipesolataiwo12@gmail.com>
In-Reply-To: <20261023154851.7876-1-ogundipesolataiwo12@gmail.com>
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
Date: Mon, 26 Oct 2026 21:32:11 +0100
X-Gm-Features: AclHuK-BwWsLsEFOFaEozuK-XOwsZlfxHweyfmzILjFicXcD4c019tvqkUJ-7AQ
Message-ID: <CAPSxiM-xyBNHuA5Lm=e-L6z5zu8dGN5kLwGCPjaYQT8XO9Gizg@mail.gmail.com>
Subject: Re: [Outreachy] Microproject: Modernize file check in t5300-pack-object.sh
To: Ogundipe Sola Taiwo <ogundipesolataiwo12@gmail.com>
Cc: git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>, 
	Siddharth Asthana <siddharthasthana31@gmail.com>
Content-Type: text/plain; charset="UTF-8"

>
> Hi everyone,
>
> My name is Sola Ogundipe. I'm an Outreachy applicant for the December 2026 round.
> I've cloned and setup the repo locally and also played around with adding a git command
> following the "My First Contribution Tutorial".
Hello Sola,

Welcome to the Git project and thanks for your interest to the Git project.
>
> I'd like to work on modernizing the 5 occurences of file check in the t5300-pack-object.sh
> file. I've checked the public inbox and found no one working on fixing the same issue for
> this file.
>
> Please let me know if I should proceed with the changes.
>
You can work on it.
> Best regards,
> Sola
>
Thanks.
