Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A79BE37F8D7
	for <git@vger.kernel.org>; Mon, 12 Oct 2026 14:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791815525; cv=pass; b=QhF9OEuJVTuockyBXEA2C/15HKG0hQHL56Iq7yt6OJxy5D2jb7Ip9jBJhDvNGIlqXeP4LUgNqed8qhfnk7ZOrSiOXsQyDapba8WYBy4SnukeiyqPi6u3uwAeGYmbWDof+Rm/Uja1l/8HkKVepbd0wtoEnfxqosG1EEG9V699004=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791815525; c=relaxed/simple;
	bh=dl9NjtbLY6OeAWVEnlbEMYp4an2OjNLolIRlMYlwXvo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UYsu9FadhZ5TnSqcjVLloh1Ghu8mGyYJQj7Hy6oITpN6jEcW+0y7Nx7GzsgfH0cIq+AveEO/3IP2kkwFek2i8E7vCnLISH8JN/naQABfp73CVyeZJZ2V6UxpPohWuiUJo0g9jv4nhMFiiTHS+iCT/KgbzHGFXMt8FOlsSgaf5Rs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NJg3clGt; arc=pass smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NJg3clGt"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6acb9c018ffso3136733a12.1
        for <git@vger.kernel.org>; Mon, 12 Oct 2026 07:32:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791815522; cv=none;
        d=google.com; s=arc-20260327;
        b=kojKHRhlm/JG5NNMDFBOtDfqbFZWVblAyVZiF5b1Oa+yNPgrZQpd/UzsMpolDVJPPL
         IDvXnfXqE7Ru8uwg05Va6uQI9xMkim86m2bOhneUEDymhmwL1MEdi0vTxVh2r6Ju2X+e
         Hk0XZJiv5z+65vypq4UkkaLMLGnUH6he9DNiU2Zl95wcbO5+zvVEcJYLpGyBIL71IS7S
         R8FPIRFtQIgG46K1jTUsmaxE6svJiP9hISyGzHsVc09MvMRHCsQOtc7NP62He7GsekFd
         dgeMqRUe+Mu+2jljVBJfftSVUSelgHjV5s1NjSNPhTJY+yRs7b8o6Yy6wLnnTHrAHUNP
         1ZIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=eOV/GKbsfKmunqWVBOXxpecC1nWdwILH+ufwSsxNPPQ=;
        fh=ltPqI4P87IZ56WchPfU2I1nfMiW2J5iXPZBMG4zvByY=;
        b=l+Xa39vGCHufvYcVq9nv3XuyRR5cvWsy+Sm/5NIZcXnuSEm0YBHTYusXud51ZV0TfF
         p7UKwPhx6yMaL0/2f8+k1XmwEpDqSpX1cIxRhoEtzAfp/iHNHbHtvw5prKHG9VZ6tbYs
         RkfiMkBziFt2yiH91mELMCNuN1HKAqSfB/VUP76kUO+rqPqiSfL20xtaC2dioKx5729C
         sn4rOCVkyrVY+7ipjawnGgJUEa5nhZMz3EYzV18SKBB7GrNisjwaPn+VoVrGaeqSZ92U
         4cLCEPGNXiY9mWM0kU9QCbefCE3z2WZ9yVxRGIefkQhVIS3NtWv54PmuoqjpbMbsmgIP
         LGYA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791815522; x=1792420322; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eOV/GKbsfKmunqWVBOXxpecC1nWdwILH+ufwSsxNPPQ=;
        b=NJg3clGtm6iikqEo0qyYgcI4xrULibDhy5keeEDIJlFxeW0t6L5OK60nqt8PksVIsO
         fEEx5Db+cD1/+dE0oiPI+eEYFkv3fEtPa5vGvpUMxmMJl7MfPlHW4mjRfXsX8OWTGxCk
         lNT4upEKNNwTwzXhl4J0MAIGZunKU0cyBnvfnsDN7+ngRlYsvTxKt7J5vEh+g5RwzcFE
         BO5HkV6aEPoi+MvMZTNDDExX/Rc5ipo8auVWb7ghQRboB/CIa+Khbx8CL9tJeKtpB8M4
         Gf8fieyniBD7sQVZ3oDWeKlf77sBDhfD5DPVD9MdFfQCOTRMKF7JJE6IED3PiYW/yLAR
         g7xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791815522; x=1792420322;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=eOV/GKbsfKmunqWVBOXxpecC1nWdwILH+ufwSsxNPPQ=;
        b=058XGnzcpDZTcKD4Q3hAltrzIWVcSrr4MWC8U14cyazwLkD+xTBxFbJCuCTYfvYXtU
         Ovep0EQpQ+pxgDb63bhcu7qR79SYErk5OEBeHAzxsk9c8TA35oiDtzcMytWYXnZN1EmO
         inBxFPddvCq3oIVvPj6ZvvClCXL949NNnFOx9MrPCPxD/wjxiImcBBlJVR7DTvyJvQgY
         hHGhUDWr3VdAQlPQ85kDjFX9BibNBk//befsaN8xt2eF07/dRUi+Xs+7eGAsSrQHv285
         MFdiMtXRbkRja4hU1IasHY7+rRvKgVlr2cz3p1y+UvEZMxF/9MOI1YVJQqiy1E0TWNFA
         KHQg==
X-Forwarded-Encrypted: i=1; AKwUvBxOdTiqjuhgRSuOpMsFJHd1PMCx//fGpu4ipdx6PtN6budJ8OVHezZch9Nm+108/H4TbEY=@vger.kernel.org
X-Gm-Message-State: AFq9FYL/OAYQ6q7buY2D5WUhopWkSU9R7Xe+LBXULT4TehrOyBHInysg
	6+KNDRVpwt+APbxTEAQGqV6ASHEyzzpJEURQH+p4IvqnTznOhj6MqtdQj5iZJ5G84aI1z7Yqote
	DoUcxQrI1/oVwZeazIEcUd/qcBfmkDjk=
X-Gm-Gg: AYBFou30AMd7TlDU6W4qSbX3vGvNG48gyISbSybRskpisojEMdtj5oiVAFBLZkgnPiK
	Xv8d02CthaMYHOnd/OZRA7UAfqGZVM2FWhilxexpBf/rnSZNLawu5zA6FCV6SKnqt34FIn03rCm
	EWv1jEdXqADXJuRFD7GZQDRvx9DY7jPYcgZsymYPhbgFACoicfv87rN386JepOtEzudPEnLfcJS
	7hUtes5EDwGNUHVyoA4epdQQCn+Jcx/e/NCsJXHEMqOQFsjoxOLycJFyaTcQuzuebMY9Gs6cRHt
	BPel+Obe5PNTFtQwcQY6eJG+zXelNUnE7BDu4JBpicwG9hwZoh3o84U=
X-Received: by 2002:a05:6402:a0c4:b0:6b1:c521:ebda with SMTP id
 4fb4d7f45d1cf-6b1c521edaamr1774326a12.14.1791815521628; Mon, 12 Oct 2026
 07:32:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2425.git.git.1790667030497.gitgitgadget@gmail.com>
 <pull.2425.v2.git.git.1791711665.gitgitgadget@gmail.com> <xmqq1p9vdalz.fsf@gitster.g>
 <03b187ae-bef2-426f-b6a4-def9f70c4a3f@gmail.com>
In-Reply-To: <03b187ae-bef2-426f-b6a4-def9f70c4a3f@gmail.com>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Mon, 12 Oct 2026 16:31:22 +0200
X-Gm-Features: AclHuK_evywX4xmvGn27idrFDrVKpi23_Zq-PvrTXyYgA78VxE7W9gh4EJFetzw
Message-ID: <CAHwyqnUP8Bgd4S=oE9g0TonqL-ohy4LXXG66AY8SeVk=6HCNUg@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] branch: let --delete-merged find squash merged branches
To: phillip.wood@dunelm.org.uk
Cc: Junio C Hamano <gitster@pobox.com>, 
	Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, "D. Ben Knoble" <ben.knoble@gmail.com>
Content-Type: text/plain; charset="UTF-8"

> I think it would be helpful if the cover letter explained in more detail
> what this series actually does to detect squashed merges and compared
> that to other approaches such as using patch ids or test merges.

Ok.

> As far
> as I can see the approach here is, to a first approximation, checking
>
>         $(git merge-tree B C) == C^{tree}
>
> to see if C is a squashed merge of B, only without using merge-ort but
> by calling merge_ll() on each path instead. That means we're not
> checking if C is the same as merging B into C^, C may contain additional
> changes as well. I think it also means we're missing out on rename
> detection.

The check is "does C already contain everything B changed", not "is C
exactly the squash of B". For deleting the branch it could be enough
since nothing is lost.

But it means "landed as" can point to a commit with other changes in
it as well, maybe that's not good.

I think following renames is a bad basis for assuming merged.
Sometimes the goal of a topic is a rename, and then it should not be
dropped.


Harald
