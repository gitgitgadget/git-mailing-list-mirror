Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794341368;
	b=wf21LDi68oHVsltDlXH9hxLTvUBw4hJjEqhk7X+ysjH0d+elZR0zTuz+bNTmOk3COAnS
	 Kykr8cjghdcosZZOV5b9ADuW0eajyEPUnmHNPwV8go3ZxYQKBwsF4nq1s923j13BsnrqX
	 BmxSi79oJ2kIXatCO8n+Wzc2KeE3GQ1AxO5cz1Ruysgp0eBQbiOQ2zNGtEbTW9+364I81
	 Hib+7YTpjDpZyVLIM0H+K8jNPfNkWeHv/xp1xvGd9+FWKmSBNRaOfU7zPiRKkaxU/8W9x
	 V/DIPamIA/hva6KS/r29qUVFReU6eXULyp73TebCEJgqrjCmQNAyz5QGRu/zSoR1ewg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794341368;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:References:Content-Language:From:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=GfleX0qFCSDGQQINu91KnLRjUrneb9FHMPmUce3/8q4=;
	b=Oj8hqgEejbiUFoqz5H0IWLZHW3hFP3Vv0q78sLpw/61Pv4B4s44gtx/m7eeeLwHNSBT7
	 K1eJ0t8HAnUL5ZQGv1Sg4Og60h00N5irflZmBb2g41vC/eCHXfT7PPOKyK08OcNpCDNcu
	 XbjlsFpffH+we31EeEYkgF05tfMPqgLyNNEdAWbindIaTul2Q4I11kIzRRBvIKMJEjmxP
	 5telyQ7yqUIbGWt7Gr2U6ZCOiy/w2MDSYhwScxZRlxKQfb5qvVvHz7MI4sLDZfuhkAUt5
	 TP53r2BP6UjbqP9nLUq1qFKEl/58g9WqtPUqsFmx7LvNOB/gunpyl15c0sbpvvX1DXg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zL4yguG+;
	arc=none smtp.remote-ip=74.125.82.177
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA377606A31C
	for <git@vger.kernel.org>; Tue, 10 Nov 2026 20:09:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CA377606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zL4yguG+
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-37071c0f42aso4296003eec.0
        for <git@vger.kernel.org>; Tue, 10 Nov 2026 12:09:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794341367; x=1794946167; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=GfleX0qFCSDGQQINu91KnLRjUrneb9FHMPmUce3/8q4=;
        b=zL4yguG+zUkuaT8B2dKxMp6P1z4qPpHvJh6p3ICAGK3cxov8q5l75ukZeFrI3XH0zL
         79L6tEBNLecRCu1PefD21caA+Z2PsClSqXOPLiJjw0f6CCs/I3yHz9D27Nue/5mQZac8
         FaIdCJX8RLFqowD/HUytF/mDs72fRS5Z3KhN6o7luLaWpL1DVkBanQEFdwtPIbajLiPs
         NJwury/iahnRKD8h2oJ6Ghyk5RY/D81TclrWuB89ih2R4NpBRiJo944DppKv5uxRPeek
         3zf0rXzM29OxxE3Zzm2USzfM5mzJ8sW5ybjdy7JyzTqMUTZFWfEoE+y0AQgRmp8NA0j0
         fS8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794341367; x=1794946167;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GfleX0qFCSDGQQINu91KnLRjUrneb9FHMPmUce3/8q4=;
        b=e4bONkU/GDoHt+/VCCbAP+0NfgEpWkgcKKwtteMDWEJg7sEyJPzcBRSnT/GHLyycl3
         MIVGnZxWJlOxdawIIpz3tflDU0uIdCZZnvLnuq/7dwcLnpRHGir3ahCD1APntdMihHa8
         ONUYB6GVzy973qpLKUTUnyxxPJJpBtk285Rjn0KeIuKjVpfuIDS3KuTOcm4WkfvW15Kq
         T7O9z3IqmweO+me1gmNlo5J2YOhe43JBRXeP0pUt5YlcSibqPLEoTkT8HsdbOnQ9fIiF
         Nt2+RTI7M7H75ueamOB0Ayw36moaMCi+3PJce3WC2upINRK49k9DV0m0ZE8vCy02prq7
         XPIw==
X-Gm-Message-State: APuU4Z+9nOP+MtMRfKUcIdJ8ybNhAUXPWX/fnaJVe79khivi3IJb57Qm
	iqbo7Use5YWpS+VYZHHkKXVrq6It2qvoMFiGHqfAV2HyBsKWOTOkSB+Xzw8MPPDZEoakMQ==
X-Gm-Gg: AYBFou0z6u5WTUSkd8YFir0wnz5eNE44kCJS346aJLPfgTh4XrTMffGA6B9fUokLOIl
	zsy8+Ld1o0sZWPIbHSXrlIO6zlsZ7xGLrrO/FNzR6fp/JA5dzg2BQoxUoxUL+Fh4sTeaCLk8m+v
	i4814/2JM8v47m6yHkFjwAWRqTIptpxjduy0A7kBOi06QELx4ux3D9PT+HNf1+eTDnQMJC+O9lt
	td9V40HI1VLEupdQ0+jBddvKcRjx2FoKHgxRrxtg0P0HkuhCZkPcjYxhfMPv8Z51NWFzYb/rC0K
	tnFZKHa5ChJSJBTTbhHUhK7dsl0MY73WpkW0RbEMMMREuQqY1/lfmJaJ4b7/9BOflRU2C/qMFNm
	5IorYOXFBLSfgVmsrJOLTPOjjWiak1tAgXvWKs4EfXkgUVmJKswIUJnBqdW/UILMEYZOExYmSaG
	K7EJrz+LIXjxwuOLTox6Asv0G6GtCDcJbiqTppM5V3T+63jjEca7xkEZC+rKKa4eOguPUoWfPkG
	+0fRttmYvBE5el3NNAthugt3qW3plStmiQwDgWDgzs/OTm5p8pRu4GUtk2EfzYoY183i07u9UwO
	Cq8O62KRcKcCjkTJiba7GM1Z7WzpY37Hv75Jj8lwwFddt3XXTguw3wxqlDRZTgdzApymxoKpt7a
	mJe1hH8gszhCb+hJ9sJIdQXUpGJiRgG1ZTQaOvDJmMtKtZtIg7H91JfW8DM/IhDgx2C+Eybhg9g
	7rRCWaYeTuwzJ3SmUT8ufV9vl2D8t3RpCFo5H4Ssa9TtKcd0ekkG/lsv+mb4yR2p8to22TwEc+K
	7g7eBZrQCDSPuFV4k8yv00Qwkw5wYcdGltQDLZhxmFpGR/2jjOrayeclbl0nImk78iVGThJlxs=
X-Received: by 2002:a05:7300:d404:b0:372:32a1:b384 with SMTP id 5a478bee46e88-3768695036dmr449505eec.33.1794341366587;
        Tue, 10 Nov 2026 12:09:26 -0800 (PST)
Received: from ?IPV6:2a00:79e1:2e01:1:e003:49d4:658a:e51a? ([2a00:79e1:2e01:1:e003:49d4:658a:e51a])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3751fe3261csm7965317eec.4.2026.11.10.12.09.25
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Nov 2026 12:09:25 -0800 (PST)
Message-ID: <6572a59d-e2d2-4930-bc32-add248529d48@gmail.com>
Date: Tue, 10 Nov 2026 12:09:24 -0800
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: My summary of the Git Contributors' Summit 2026, was Re: Git v3.0
 timeline, was Re: What's cooking in git.git (Sep 2026, #08)
To: git@vger.kernel.org
References: <xmqqwlsei1pv.fsf@gitster.g>
 <76ac51df-cef8-c6a9-2610-8c21f03c6999@gmx.de> <xmqq4ifhgzvx.fsf@gitster.g>
 <5cc325c6-579e-4fed-7071-a3ff98d51ccb@gmx.de>
 <BEEE94B1-EEFB-48CA-8B45-EEDB10FE244F@gmail.com> <xmqqfqy4b7oq.fsf@gitster.g>
 <xmqqjymkqx9i.fsf@gitster.g>
Content-Language: en-US
From: Daniele Sassoli <danielesassoli@gmail.com>
In-Reply-To: <xmqqjymkqx9i.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 10/11/2026 11:52, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> Luca Milanesio <luca.milanesio@gmail.com> writes:
>>
>> [Administrivia: PLEASE TRIM YOUR QUOTES.  Most parts of what you
>> quoted from the long message are irrelevant and did not help giving
>> context to your comments below].
>>
>>>> SHA-256 support across the ecosystem had been a blocker. GitHub reported
>>>> experimental support, with general availability expected around November.
>>>> GitLab already had public, non-experimental support, and libgit2 supports
>>>> it, too. JGit remains a gap; Google was not planning to fund that work.
>>> It looks like the above statement needs amending, see:
>>> https://gus26.gerritforge.com/schedule.html
>>>
>>> Google will present their plans for SHA-256 at the forthcoming Gerrit User Summit
>>> and jj Mini-Summit at the Google Campus in Sunnyvale CA.
>>>
>>> The talk is at 2:00 PM PDT: "SHA-256 in JGit: Why, What, and When (Xing Huang - Google)”
>>>
>>> Anyone joining from the Git community?
>> You forgot to mention that the talk is scheduled for Tuesday,
>> November 10th.
> And then we no longer see that talk on the Schedule page anymore.
> Sigh...
Yes, unfortunately the speaker's had a last minute family emergency and 
couldn't make it
to the conference nor present remotely.
It's unfortunate that this happened, but we'll try to have this 
presented at other follow-up
events very soon.
