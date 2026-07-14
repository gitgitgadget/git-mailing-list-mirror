Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 162BD4EA36E
	for <git@vger.kernel.org>; Tue, 14 Jul 2026 17:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784048466; cv=pass; b=SSfHx739+s4VkHKsYsHOF9O4yYBZiKVpa9FbMz6qRShLyvkXBLBv/SrnUTwUgMrO+zOSpsIkzxtORGXO4As+VrgFwl2WnQSDWQ/itR5WyoNxh/d42pB7wIiHsVMlP32HOp9Qs+3bAsdBfQDm/11l1zt6dadb40pvXxfh459WN2Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784048466; c=relaxed/simple;
	bh=HHXHYvxK2AzmKLA2rVgQaoSYxlyfPFdavf0f62FwxLg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rrYX9e9V8HrHNaNgqlUkeHwysokxbJ3eL7+7qRxAP4gVh4KK5yUP/EW//FfmRBj8tG07dE0lrAGUr7vSVbrx0mqglpxzi1Ls38upKGIfv/nkakxjBE61uTSA3zJvK+XV04EIjXE0JDiMj3A5GROqaby2uQVVzFlcd18RrCk9m4U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pc1y9IWb; arc=pass smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pc1y9IWb"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-69a50189d25so7933033a12.3
        for <git@vger.kernel.org>; Tue, 14 Jul 2026 10:01:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784048463; cv=none;
        d=google.com; s=arc-20260327;
        b=BPc9bZ0hfl3uj+wJlXPUfka9aeryFehuocU5T8NV0Td6nNsl9i8Ia46nXt1XqpsbwO
         PwoIL6s3YerDroG+7mVWHOKrngFwnIcCq6c4gXCg+hiASLSVxZW4QqE9gWt7SuJ/Cq4T
         xfNma2Wf9INC9RG5PkyidJA2cYHihhA6CL+SBdm2Dbh2D0XYJN90qe4NzbxyZH9cZpH5
         2mcMmXX7Jww9gZ7x/qzWnWsKwfe108HNINpgfLhKhfEZYsQut6MzpHSgmUCYxP7y18Vv
         GelIWEF+DahXCntMzJB2lr6oLarrKexyBu+nJOct374m+ce7nwa7Bz22y2Y+eSyprPhJ
         KUug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=HHXHYvxK2AzmKLA2rVgQaoSYxlyfPFdavf0f62FwxLg=;
        fh=9OLsl0anSSJCEp6Fq72L2jXpUdAB0ZC3+IP/8jt+voM=;
        b=FZ7QpWVCUd2+jfD+9CwsJIdzkwxuc9jXeFLgFBppcps+KvIyH8eqMDdo45WDcG2qMt
         7Dvrg7TYxFEUjWuaW4MwFmxj6zwmYvpXtzeaxsDX9mKOjJcq3y+AwHHd0/RtX0BQKh3Q
         Y7wyWAg7T2mMp+gWyaAWjlR5oipGO5EXh8HeJ9FDk9AqKJsVTKl5ezPRbJb0kZfI+fPD
         yaabVMBZYzfqtyzRSGvdMqAZ1btBhZQSvmnMYpddyXpdj1Zjiv+7BrtZtl9MGMWXHgqt
         bvM4HaVUjuLp31jL2fNmgPAxYSYILm/67wm0ZoO485/+c3i8ijQdbYxVre4x603xfaby
         FEdA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784048463; x=1784653263; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HHXHYvxK2AzmKLA2rVgQaoSYxlyfPFdavf0f62FwxLg=;
        b=pc1y9IWbpP9UrqwiUQbKKPRxgddbQR/HDMTfK3btadzVTw2Z3ZmmmFp9GR7iDHlxJL
         jh145owKjsKpgfMo2NSZ1oos1E6iaqoHmrSqDvQYmxFXzH59wTKye12CNGiPIEFlAqF9
         JZ1Eg3Ww0bsY9UlsGgzv9HUKGAKVjveQty+May6WOA7MJ3sVGTG9PT+q4dzcQDlLa51C
         hkgArZwnWKz+khX1mWfPLqKfHlaM1+kKE/U9+vMyTaa9KGLRtTxOWqKGQAPebn5cOo4h
         0NjMUcwOOQ5YgHad1WwmPNQCMf454jsCYhF/bBTVmwToEqyrc8Qm25RQ1iCokfiyNHe7
         dJyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784048463; x=1784653263;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=HHXHYvxK2AzmKLA2rVgQaoSYxlyfPFdavf0f62FwxLg=;
        b=T0cKGhn8zXgYiBdr43G+u4lYO6pHuy9HL7BWX/vfEbvXjTlE/8yQVFHFdx35dzGfu8
         iwei2lW5+lWUQz62AC5F1mqfENdhwuOIYQhy5W1kHEZooanURE4svQCq04sLPKORg4KK
         u6oIY6/UKvQK9+V0JbLNA+1uWhvhR7nUWaNv3hybOddpPfZEWO4ONDygd5WWREDhxL/O
         VShUSVu/P0oKb7liCMzfCxRG2xAWZiIvAgKNhAXf4V6I1Zk/raiMFm2tH8JMDqXFJtYo
         FSIRsx1kmYcmxT2csVMSJh1/Rv10rbBPwayQPcQgfy3egSW8Lx8OW9Nror51NeMkfJnf
         7xtQ==
X-Forwarded-Encrypted: i=1; AHgh+RpzvDeXvu5ZJWRTwCnmQ8xuwb2HRO7j7OyjvXmzGDGW52HF3ix7lkN4prKlDsKgt/s54yE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQCxZ2rqT7qRtlQme4cGZxB7p3OC3VRA9JL2cUAWwMhcsY7oFp
	6k9Zql8ORiD6KhaSBWPbWGMHld4cGBz8N+OwqBqPi61Kw5Ykty7XMcmFc3pR2mq94iecn87V/mi
	j9MV1S68gOEJO6NToEx2y/LuV82WvPXk=
X-Gm-Gg: AfdE7cm2MRLTGc7AkPf7iicp/02AKLWFAck3SLb6CGuGEPk+lZxVmWvk2IEGKKe3ve4
	VoYJ7lEOtbAkva7IQvsiCrBeKESXuXBK7YHD0w92kE4832dSmgI3Axx+ChVcKz++Ao7+mtp4ML3
	aJ/AAWfV9qbFyJIPGyA2O3n7Q1KyXSucSk2DEAyBl7AILFc8UrhRKb9EQDef1M9zpmVBouw8D89
	w5DANhtF2EPWmZeqzZRPbrzN4IRRrcKuSp65k9ht5O1GLHM7jdxBwrk+U20a2ZC823C6noaZcnm
	90qV+Sw=
X-Received: by 2002:a05:6402:5516:b0:69e:8ad:5162 with SMTP id
 4fb4d7f45d1cf-69e08ad5303mr872606a12.1.1784048463076; Tue, 14 Jul 2026
 10:01:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2285.v17.git.git.1782113388.gitgitgadget@gmail.com>
 <pull.2285.v18.git.git.1782338106.gitgitgadget@gmail.com> <a84c555d99c98abcd4618833c14fa35b191fbda2.1782338106.git.gitgitgadget@gmail.com>
 <e35f1268-2518-4a44-9c7c-28ba13ca7b7b@gmail.com> <CAHwyqnU0ifHu0+GfMR9GqWKgFrTOyQn-FbUH0wTm_07nCa26tA@mail.gmail.com>
 <CAHwyqnWspUTSnqmkMyXtWuAnENDSzrRLhhUR=Ljtt1xer3tphA@mail.gmail.com>
 <5212d968-6121-466c-8225-36b4bad6b211@gmail.com> <279e6d69-191b-437a-b1b1-ecd879343f3d@gmail.com>
 <CAHwyqnUKSD=G1jkdc6n5mVA-NvCgL+c9zCEW_Lr8OBP5q2fKkw@mail.gmail.com> <2fe8c5e0-96d1-46ce-8fda-1b8f521d3c4b@gmail.com>
In-Reply-To: <2fe8c5e0-96d1-46ce-8fda-1b8f521d3c4b@gmail.com>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Tue, 14 Jul 2026 19:00:25 +0200
X-Gm-Features: AUfX_mz53ugMt6zb_EKva3dlM8Gr5Aw9wgeS_jUtBz72gjFmlG4ZqlRoseFF4TA
Message-ID: <CAHwyqnVoh=V9TL2=-MmoB+RUgx_qL=VdVL_0=p4md83d_9PKyQ@mail.gmail.com>
Subject: Re: [PATCH v18 5/7] branch: add --delete-merged <branch>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: phillip.wood@dunelm.org.uk, 
	Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, Johannes Sixt <j6t@kdbg.org>
Content-Type: text/plain; charset="UTF-8"

> Yes, though I've just remembered that when we were discussing protecting
> branches that are the upstreams of another branch Junio was keen for us
> to extend that protection to "git branch -d" as well.

Sure, not a bad idea, I'll put it on my list of things to do after
this topic has landed.


Harald
