Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04CEA3D3CF6
	for <git@vger.kernel.org>; Tue, 25 Aug 2026 07:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787643497; cv=pass; b=HfAzWPKNJuce07m6hbJbjgSwaoBiN8vDtUu3Nrn72TAO/CFGYRvc2o+MbIbhFgQoSn5WaKwh6lLVGxxiVZByWXujMgzHJEIt+SJh2B9eBwpYBFISgY65O7Y0cjINz1Qsvtphl5zYWB8dPaHfXQiRQmrQLg43AzKW4QT1iGXTjyI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787643497; c=relaxed/simple;
	bh=Vom4Qj9uOj5FzffEwKRIGDUr9hHqHuiMQg25kAdDVv4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cDwqGbRm7ElATD8rac/sJyUoXZ5Fya+PHdwbXbdCcvIIcDA81ShMIof+7JmA83uo7x/o57gmpuAYVCB6krZlHr2do13C+Es+aiWpx1kE/390cf8YvrK8abX5vASe787n/a7HGJhZDAf6srvuZ787JmfVY83/QJm6mUVJk50UYUQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YjVnrM5U; arc=pass smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YjVnrM5U"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7f48c750afcso2149652a34.0
        for <git@vger.kernel.org>; Tue, 25 Aug 2026 00:38:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787643495; cv=none;
        d=google.com; s=arc-20260327;
        b=GChyv7d7m7O22KPDoCw9Ps9P5LJL9djMkrUSf9dED0olku7pgAl8eX8EW1LOWOvDtV
         q0w+6FXDROzWcKA0MyXbYUIqgATb2zAcI63U0yx9ptD7fxa0a3vJgWbA/iDDcYdvziCf
         /1HdzSuHZ6eHdCqtjzhnM33FXnNFpxxgpGRKxm+nA4XYxLTwMg03OhqAiB9ZW+dzV2/v
         gaBdpWOjR3Ofs/sxtCg9eyMxPlzNd9fEIajLd4DHoG9DmLlaOiN0cBDBz+pcQJCsrbE9
         lAQHtB8aPmlj2FvbldjSnwNonwClVXLrEl94Le+ra+frAcdmq6NjcZUc9pGlBAvQhPz3
         Wkgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Vom4Qj9uOj5FzffEwKRIGDUr9hHqHuiMQg25kAdDVv4=;
        fh=Ba9z7kyRPt4xZWAZ8GUeDBWwTrSuTF36HfsJM4LGxKk=;
        b=aSRxBPOuwsbaMXXz/A9h4vJKri20NOkyEJhL5u/+g7RZSqtEEGGC1aj/4renxTDLqI
         GG9W9PBqjvxqLyW5gU380lC6zNbzckzniuf+29k2s+uslPtoy6hnVl2B1i0aFSLqBxoF
         NQaIXmgRXWHKlMmZnMQjjtHO4KfgpS80u1MD6IPeyS91T/oyvy7fo/Tp9IUx+OyY4F9Q
         BWZKT1wRbvCaPdnuRy0feDHKrRf2avZ67O75kSGyoSylB4ZLB7XgDzVfjuZs88Ssbcz2
         DzVigE02BAcjsNERaVGVwarLrv1u7+5UrCIM76OPSXGCiKrrtja8Biysk/axsmZxeqEm
         sDlg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787643495; x=1788248295; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Vom4Qj9uOj5FzffEwKRIGDUr9hHqHuiMQg25kAdDVv4=;
        b=YjVnrM5UAEHYP+pYvs2zbHzT9/hEEafTWKIiZ2eAWkwsVlWPWAP2h5WWYB7LRjZdey
         bkWorGLF9q5lqKxPzyUQwy/rzt9j8ks9xUXLG+lS3oBTadWf/xRavG475ce65kN+JriW
         OkLeTSLAF12B23ecGHhyLRZlmTQPehIco5CPL4/pUjChm1Hbm4TdnldmuBbWl7aL0h+b
         xiNo8/sO58pAIXhA49DDStk3lAaJVsNAo6ptsl6gx0WQRExeR/nWIWSwPpkc1ZBOsP2l
         /DksVBiSb50HtTVeOn+4HGGBEA6rUyrhGhMIiEVTc0jTycKqSC9mAiWpiaAnq4/ibsVx
         fBNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787643495; x=1788248295;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Vom4Qj9uOj5FzffEwKRIGDUr9hHqHuiMQg25kAdDVv4=;
        b=J9DRV6la92tWt+7dAeQNpps5T6krLN75jMgsJhVbOHw+nMrVDvHUFejWjZnuCNQXMO
         8/5IcANtVrca6zB5utD0UCgPtIs6jGQDqH3cGOqpKC7QMOJ05MynnI1aCU6ZVQqnHmCj
         J061FiJ334HtFMDHlQqV1uBLkb/zJ7UCw3D2d5Rv65IjHcS80C0qNoqh4qXixhMZjIUY
         IEeMH7iqeC5RfUYsnHA9WKr6Xl20PqEvbsOziPsbEHkhnDeDcZbItzCRkPehl/IVGK2O
         d+6U0ibmYyFftJ3AWjx4Njw0OApy9oNdNrOA4v4sB5FR4mvJtLOXrz2f0vlT6NZV/wuZ
         oEIw==
X-Forwarded-Encrypted: i=1; AHgh+RqZVv4wtqRO0YjyLkJWlnLRFFI+4KnuiMHvCa9ebAU95rF2RpDtr4DaQejnJSahrYO1ubI=@vger.kernel.org
X-Gm-Message-State: AFuF++kelxShYngmR8lFVxF79cYX6XJ2bsmm42kL5EdsB3EBIWZOVTBN
	jODCo209fGok8WqWApoWtiWQmQnfPe74PEV2U7BpNxz0Y7YcBFCnLbZxibAaDRSZbFzRmatsgjJ
	5a8/aW8d+3lwFExKrORYZgVJ1xlLQZdU=
X-Gm-Gg: AR+sD10bgtW2KcQdFVsz0z/BT7tQFPVsB2eyTvK0UqPfcYW8n0x5UsZ05RptsBdLBd2
	TgaGHiEmjHPI/wjvpfr6DHntELcvI1pc6OU7T+Bu/HS3KdmGBW57rd9avjQysDTAWx9AJJWUasV
	ZTZbh81GBm8r+oWqhQLLcaMse6aaRrWD9wPHyDePs3pM1st9jYeyMvFbHLswpqAiEx38s4HZApz
	DvbfxNUQeLKSsSC7RK5jeIsHPBYgj1GTKqPoaQLXk+Zk4uAVkIAQTyjGt2DZDVRQNf9XvJLAATa
	iq79MR4ZreCu66LGVnvOOxh+n84mXB7WfGF6BCcWXmJNr/yD3ELWC1727FI3Ky13rhNXeJgmDpd
	FvOXah/NFPErpfwnYNEhoCAjWY+3sLtNrnNrd9mdF+Y++CCCu4seeCbKZkpG3
X-Received: by 2002:a05:6820:1890:b0:6aa:e854:d05d with SMTP id
 006d021491bc7-6b1903cb6e7mr3835837eaf.3.1787643494742; Tue, 25 Aug 2026
 00:38:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2207.git.1787092446.gitgitgadget@gmail.com>
 <5792c08f4ee0f9627ab1432d91299fe676e0a2f5.1787092446.git.gitgitgadget@gmail.com>
 <aoayppoxHAkcFTBN@pks.im> <CABPp-BEBbdmE9q+98gWq-wLzDdhJOyazcHF=pP95o5AcmgCv1Q@mail.gmail.com>
 <20260824044822.GA142844@coredump.intra.peff.net> <aovTA4F04aX8SPTU@pks.im>
 <20260824065539.GA149254@coredump.intra.peff.net> <20260824070601.GC149254@coredump.intra.peff.net>
In-Reply-To: <20260824070601.GC149254@coredump.intra.peff.net>
From: Elijah Newren <newren@gmail.com>
Date: Tue, 25 Aug 2026 00:38:02 -0700
X-Gm-Features: AcwNN1V80152nLD35x79alJXkQv9IqpYjgMnwD3q1ncWRmKQBn47gf0FSwfpDMU
Message-ID: <CABPp-BEkqKgJ3WLt323ntLp07n8dojhEoLu80fSmvz2D1ci0bw@mail.gmail.com>
Subject: Re: [PATCH 2/2] packfile: recover when a multi-pack-index names a
 removed pack
To: Jeff King <peff@peff.net>
Cc: Patrick Steinhardt <ps@pks.im>, Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 24, 2026 at 12:06=E2=80=AFAM Jeff King <peff@peff.net> wrote:
>
> It's only the case that this patch is helping (when the object is not
> moved at all, but an existing duplicate is hidden in the midx) where we
> have to re-scan all of those packs. But we don't know which case is
> which until we get to the SECOND_READ stage. So I think this probably
> should only kick in for SECOND_READ.

I implemented that in v2.
