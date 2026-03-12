Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B5FB3CCFAC
	for <git@vger.kernel.org>; Thu, 12 Mar 2026 16:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773332062; cv=none; b=TVESelo22akGLGeqEAQeDEuLp53jL5AG1PQfoiLLDeET2tUmQ5jFC6ymvq21TT8tjDj2PfgcR0iNr7L4oToZe8rpMUGxCQqBPzQbxcWM0cZ1iYwHM8Pqo3EHOM211h7E/SfX8JOk4f0tM+qoPniw3ZT7WLR84JTy7wmG2HELT5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773332062; c=relaxed/simple;
	bh=mDV3uz+41BdWZ49RO8u2XRG3zEztYdChVpkM4aJwzVg=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=nJVIaxTvrWtTcrP6f6UTycXzgTFANoyNRkfAg/pkdFZKKS83ZfHNMiAosPGBbKc1lR4XtXEFkcJ4oWZ5V3WYw9tEY3kyE8dhX6fbNewCDdJSnDhYGIxkb58vW/GiPbay9mIB6dreT8NgTVDBlUgKp5Ov6pET7XHEV8osxwT3ujg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JagavqV4; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JagavqV4"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-38a45bc61e9so10059581fa.0
        for <git@vger.kernel.org>; Thu, 12 Mar 2026 09:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773332057; x=1773936857; darn=vger.kernel.org;
        h=content-transfer-encoding:autocrypt:subject:from:content-language
         :to:user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TMZqdY1IMGDB8fd+BygrezHqRWCpVCPh8SygNQrrqOo=;
        b=JagavqV4mclIVeKten2oB8qzQYWYrw1pCVQmdxcyqTojWqZrGNQI9qzrja3TiZowZl
         xbJrqajZnBuQB4WUwFxWMX33uYl43lITBBsFQ/O7lwsrQ6gSrAOzTuh9WP7tjwelE5Wj
         pbD11eRhouGeFRWVqjk+IGXG3JQPLe2SjK1cM7vj/63ygO8JbAcgAbZ0Y9EiGEPDyM59
         yCpejSHSh0+vK0bsRZ5bgaTzSS0UsZIsQKZuw2JOjjoojrTs0U6kEEDXr5rpJ2TWwWW8
         HjKOq1UOhNKPCeNNLtsJksfTg6UovO6rBifGMDP4Yu+slLHnBwDdCs0InZIsM68GIyjV
         SYqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773332057; x=1773936857;
        h=content-transfer-encoding:autocrypt:subject:from:content-language
         :to:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TMZqdY1IMGDB8fd+BygrezHqRWCpVCPh8SygNQrrqOo=;
        b=hIEVtEuIXsazlvvVWkyAbvwXfEEr1ukyCizhxC5ZA+oypgeBMCB42hJjNBuSORCWti
         d5+D6Rl6K3p3CXa4ubqiY6PkFGVbl6Lm87o06WJPHwbPWSr0VsFc9odA5i7ZlYcxH2A+
         ETMfstRNVpgOntmhsmevfiZkXMR62y6/XdrlGCnDYO4DVp31UR/DlClTIw0N+JODQdMo
         ViCWWvXfNWOMcdl1cPe1eOIgbL3kizBmd7lfqCw9FGNpblUCNTNmFMlskJ/fX4uNEb5q
         peppMuatmw853diU7F/MRex0/p7bn8AFO4d+lV614k0DqyZ6IIKKLszJwp1YO9+H5Whg
         TNwA==
X-Gm-Message-State: AOJu0YwvtIbF5ZigG/jbWqCGCX9IbWGMcIK6KMj7y2fv1n//m6q0X6eA
	FQJOeerp9b764BimUJrZk8M/1hgXesh1Y/7EUxOyaH2T1/CU8gsqDN+jtCANVJc3JhA=
X-Gm-Gg: ATEYQzw/afTSx/4rWoF+mxIzl4htkaqvNaKioWjN8moMQbCzwZmgbSOg6wj9w6diXzr
	N2o6XPioCsuL1L+y14KCrCGOTq6kM07Yry34He8n+9+oGkjItIPKumteUYIr6XupRq8mMDzhrs9
	fl4dLdgspTAma//GDn/Uq4ZunBfvbdQFmNCVR29lV3Wt/tODSInQsWYEpd5Sq/jB4rMEt0ABXbS
	TTutpi1ioOwjTDs6gCYraxajLwPY7FIJPka56OFS9ej3m6g2olB/GsfkfFb4ax+YxDRmKIrXB/D
	eG9Y7Ugi5BjYy2SBgIubWvPA8PjeVR/bQ/Q40UN5pmHexCQ7PkGoiODdP14g7kQG0v/mfek6KEh
	3O3iRaEbHL3BNWZKPYFH/8OIElfezb4O22UrHXuLIo/KIZK4Fe5brU2OJab8RRR+P2eNMMu1toH
	12yhpccVADyY3Xc12muLAahURA1Hk4thDIlP+TX91Ox/7MpfxlCQEl+Krnv5PaxCBd4iCX3NC3
X-Received: by 2002:a2e:a542:0:b0:389:fe5d:5676 with SMTP id 38308e7fff4ca-38a67ab95c6mr22692031fa.0.1773332057328;
        Thu, 12 Mar 2026 09:14:17 -0700 (PDT)
Received: from ?IPV6:2a02:2168:8772:9800:eb6d:4393:98f8:641a? ([2a02:2168:8772:9800:eb6d:4393:98f8:641a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38a67d6185csm10146291fa.3.2026.03.12.09.14.16
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Mar 2026 09:14:16 -0700 (PDT)
Message-ID: <c1e0c05b-c767-4fcc-859a-4da6b90c4497@gmail.com>
Date: Thu, 12 Mar 2026 19:14:16 +0300
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: git@vger.kernel.org
Content-Language: en-US
From: Andrey <butirsky@gmail.com>
Subject: bash completion bug: "symbolic-ref" subcommand doesn't complete
Autocrypt: addr=butirsky@gmail.com; keydata=
 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
 VVOdns/k4krQA8QXLlOOXh+F
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Bash can't complete some commands, e.g. symbolic-ref, bugreport, maybe 
others.

These commands are not seen in the completion output:

|$ git #press Tab
add               blame             citool            diff         gitk  
             log               prune  refs              restore          
  show submodule
am                branch            clean             difftool         
grep              maintenance       pull remote            revert        
     show-branch       switch
apply             bundle            clone             fetch        gui  
              merge             push repack            rm                
sparse-checkout   tag
archive           checkout          commit format-patch      help        
       mergetool  range-diff        replace           scalar            
stage          whatchanged
backfill          cherry            config            fsck         init  
             mv                rebase request-pull      send-email      
   stash             worktree
bisect            cherry-pick       describe          gc         
instaweb          notes             reflog reset             shortlog    
       status |

|
|

There is no such problem with Zsh.

[System Info]
GNU bash, version 5.3.0(1)-release (x86_64-redhat-linux-gnu)
git version 2.53.0
rust: disabled
gettext: enabled
libc info: glibc: 2.42

