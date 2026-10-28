Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793188633;
	b=RyCZTRflFAoblXy6DHccZMx1U5xfM6kvdU/6n+inZAxx5Z9eAA5k/OR3BqbukHtYT7ix
	 3gDY2+G7qYmR8vKdZKed9fzKrBDNnguZMNJhLYNIsyQjqfNAK5+Ew3FPrazuq5Fk+IlLG
	 uBJXYjB6VgEmVrefIcu8DpCn91K1QJMBLk+EQHK2LGb7sQhIlTpnQke35VTR/t7mea36/
	 lB+s/M9a6wqXTlWc1noHY/wJ8w63WTUmoeZnKgUXh37B2pBbMoWG8vU/+xIMK+IA+A708
	 oPQuGxUlzrZqf4ZRJIEHND2b8zMh/1Iqy2TPR/hlqZprFzq0UZsiai+2ccnDIAESm8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793188633;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=mjewHx/5gD0a3YbCfumxYh0u3Tb79+eczTV+d1xS/5c=;
	b=HXpIlJuXWnqaVF2i7p/69/x4RIM7wpVClu34qY+/jKcQf2NkZUpM7756Lc9feu5abCwJ
	 T8pK6gjmL76wmyuytfDibDUuA5c6zOjmg5FiQM4PWqoybfhZXj0PLVNLhUoeJSng19lQ9
	 hadeibK68O03AdKgmtUzn0eSkikvnnKM6XA2CAQrhmGxktDCQ4ZGMoy1noFDL+6YMP7/f
	 TKtRpGnbPRnYW0abs9PTzY8VA+ewehVTmTklDBb/jHAThvYMs58w9R6WIXbzUpI4e/SIW
	 plMQds+YPD7hRfrzrY5+/cllrxseQ9yI759pNvgJzKv51Rp6txoXfodrh6/pJKnYcSA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CPeJQvwy;
	arc=none smtp.remote-ip=74.125.82.173
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4594606A31A
	for <git@vger.kernel.org>; Wed, 28 Oct 2026 11:57:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E4594606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CPeJQvwy
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-369f3e9e431so636089eec.1
        for <git@vger.kernel.org>; Wed, 28 Oct 2026 04:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793188632; x=1793793432; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mjewHx/5gD0a3YbCfumxYh0u3Tb79+eczTV+d1xS/5c=;
        b=CPeJQvwyQwmPXsMBplZ2kbqv1RsLqchRZDIgSVThKnuKbGGakeH4dWwLDR4jzBOVgp
         26r2JqDurfEqNEteZq6zq3UWh98fp0LEmhg/Y8t8C5MvV59OyVMWucSvRaiI26DUNas8
         +faW0bRw/vDK+gmaDPhyynU8IJ5xJ5bg0SwzzJ3JdFqvhjU618s05pQpX2GWmhSuKxGG
         FERU2uF/SxcavnVqPsyFjg0eL81kpEU2Qcbx+RKHb//FTYwGyuMHIEe1ZWu1SWMY+aOx
         1MEq3MBag7US/1h0BTz52cI+RoCDrKP1YN/8p8F6Nb/MpvZvH7WmBSaEgMzr+YZCY3zT
         +D3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793188632; x=1793793432;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mjewHx/5gD0a3YbCfumxYh0u3Tb79+eczTV+d1xS/5c=;
        b=GdEKAiFzfclj38mW1F69POBYx0it7Sexqht6fplTiVl07yH+DWEyRufu45ITdtDPs0
         5rkbi/5AEWSVAnHcWK35NMfwsLX0B7e3d3DDJ2CwR59G636YOVQJ6WYnlwBoITsODi5z
         bGGxrdURR/K6p56tynKgp0CoypQjEyQawoZDD9suU8ueh/oMUbCQV3rT1w1MuS3/FS40
         9E9gNf/JUU/XUtRzqypcmj3bnxyAv03f2WarbxlvF1Xbl5K++ZGrkBi9v9CobW2ZjQKN
         9I9k93laTk6V19SkXYui/RO2VJ8kXv0OkeMaojIqf0i7CoeCRiiSCaZez2AQgrO8a5jr
         +Jng==
X-Gm-Message-State: AFq9FYIya/cs1/uyXvusHRKt/S6MFyU9x1idtAj238otLvlAWwhDOfTT
	JTsQRY2RMySbqkqAGP2LhsShcnVlJunS7fz50PoVRn5T5ahBOoKVTTdI
X-Gm-Gg: AYBFou0MUahaUbmYAoIt7VokSvWhZ4+wxrnIDwhpJywSCWKQjSBFa/AEfEjN/zt42+N
	Bwj58vpNgv1OOsvX3sUoXhJe2dld7clJUiODgus/I+xXNWxKEW6uYmQ/MwzGTD7PRAqJAzo8zx6
	ZQ/trS72ArXWwC2LA6+Rs5J3Bverko+PHNbPssizPmNg9woTNP+dd6cuPhLEWvPWLMn2S4O8Eai
	B4F6lnhjrq9cedFk/3nI4OikJAGJUt6k4jDW6pEFmK8kTqF7wyEffq8iPoFyWkB+UC2ivF8yh+i
	Cb2LKWuYwRgeq52h01Ds7dNyUhyn35PEr4S7fL1zIWzDRCnKlZtnVrnj5VE+Xlna83QXiZVrsmd
	P/zBAVtIesQzfPjZlovfGzj0CR0z7IZieafTQUkx3TYh/7iAl2AwFf6qrZcqQ5FT2aj/0MCBdiU
	y41J80uzGuamp16yfeUSqBaev4BKfkwqZEyxKmE4sK2BVrcxW6h3reyG+tQE+ZsAglLl+Zsm2rU
	y7x3stMkPqSuu2MiAcn6jzAGrcOiq6r4tjyKIB4I9E1ifbiAt+aV4lFaCFsBkplFXQaZz5AxDLj
	zxylfCZgmoSwe4rvGcEi64N/vT7iqDFu/oby97Lf7lldeqgQuUQ6JvzdJQ6JJu63VjGC9mKb5Cd
	TPl+ggQ==
X-Received: by 2002:a05:7300:f40c:b0:341:c383:9afb with SMTP id 5a478bee46e88-36a0f8a9ea6mr6745024eec.20.1793188631716;
        Wed, 28 Oct 2026 04:57:11 -0700 (PDT)
Received: from ?IPV6:2406:7400:12b:66b5:b36d:2c4:846e:bbe6? ([2406:7400:12b:66b5:b36d:2c4:846e:bbe6])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a2390c6dbsm5386706eec.13.2026.10.28.04.57.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Oct 2026 04:57:11 -0700 (PDT)
Message-ID: <38881eb1-d97c-43f0-94b2-d6957221fe1e@gmail.com>
Date: Wed, 28 Oct 2026 17:27:03 +0530
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
Subject: Re: [RFC PATCH v2 3/4] setup: introduce new helper
 'is_git_directory_verbose'
To: Junio C Hamano <gitster@pobox.com>
Cc: Git mailing list <git@vger.kernel.org>
References: <20260924120502.2642141-1-kaartic.sivaraam@gmail.com>
 <20260929102513.712181-1-kaartic.sivaraam@gmail.com>
 <20260929102513.712181-4-kaartic.sivaraam@gmail.com>
 <xmqqv77ma8ty.fsf@gitster.g>
Content-Language: en-US
From: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
In-Reply-To: <xmqqv77ma8ty.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/1/26 00:02, Junio C Hamano wrote:
> Kaartic Sivaraam <kaartic.sivaraam@gmail.com> writes:
> 
>> Introduce a new helper is_git_directory_verbose() as a
>> counterpart to the existing is_git_directory().
>>
>> is_git_directory_verbose() also populates an optional
>> string strbuf with reasoning around why the given suspect
>> is not a valid git directory. This strbuf in turn can be
>> used to improve the error reporting which is currently blunt:
>>
>>    fatal: not a git repository
>>
>> This is not helpful as the user does not get any hint about "why"
>> the repository is not considered valid.
> 
> I suspect that it is much less the failure to report the reason that
> may confuse users than the failure to report which directory was
> inspected and why we picked that directory.  Once we make it clear
> which directory was used as the repository to run the Git operation
> the user specified, they can visit the directory themselves and see
> that there is no HEAD, etc.  The user may have a leftover GIT_DIR in
> the environment that is interfering with their operation without
> their remembering they still had it, for example.  For this reason,
> I am not so enthused to see this much code churn to tell the user
> the subtle differences among a dangling symlink HEAD, a HEAD
> pointing outside refs, and a missing HEAD.
> 
> What would be preferable is a much less invasive patch that reports
> which path was assumed to be the repository and where it came from
> (among GIT_DIR, auto-discovery stopped at GIT_CEILING_DIRECTORIES,
> etc.).  It would help the user figure out why the directory they
> thought was the Git directory is not what the git binary inspected.
> 
> This patch does report which path we thought HEAD should be at in its
> messages, but does not explain where that assumption came from,
> unlike the verification of the objects/ directory, which mentions the
> environment variable if it is involved.  This feels uneven.
>

Thank you for your insights and excuse the delay. I have tried to take 
this into consideration and just sent a v3. Kindly check the same and 
let me know your thoughts.

   v3: <20261028115412.169748-1-kaartic.sivaraam@gmail.com/>

-- 
Sivaraam

