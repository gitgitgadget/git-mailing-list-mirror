Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D64B948DB43
	for <git@vger.kernel.org>; Fri, 16 Oct 2026 18:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792174553; cv=pass; b=UIUTEzzKx8bVErRcG80ERef+XCEuNT4MrTimvc97y7+0lEf83EWHcuUlEe10g5QEQ+jD9mvaCOvJkXQxFYJVobvWrZZetyqKQTkWuJi/owoAHo6wNH5YyvIlB6k+QBE7cl7sJW2LNVcrL76JgOYdGCOmmGjYKvG7lMRfXASkSUs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792174553; c=relaxed/simple;
	bh=h5a3hwLqZUQhQDJ+XFa3fXgsi271ingxPCo7eceCurQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dbD8t+MVEIFWOcDyUnMNyp7emTHexHJ97v9dOfpcXGzkFs2ZYTnYvwnL/mSCv3IQWB3TqpuWrKW//12bqhY+X4eFzqgdJffcwqOfVlzvyTQKnguLjDDPAneKQfEh+4RJ3cMWxoWecWg41NHDT1IQ1D7U875dl0puEJpTFHThB98=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lbnXf2dM; arc=pass smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lbnXf2dM"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-886e61fa30fso109990b3a.1
        for <git@vger.kernel.org>; Fri, 16 Oct 2026 11:15:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792174551; cv=none;
        d=google.com; s=arc-20260327;
        b=cBRdIAGHDarZqolUcLIIuoVr0D4OSQgywP5cxuhN8SZ3lk9fFEzizrUQQ1+XPQt1aG
         orE7n9cDN3d4IQ9ahOzgiEntY2/Uu4nQOqy++rkxhXTLejy2Nu5AJn9ipTpH7bNXvTRg
         jDscgBZ3pAkWYagyVCGAExCuW+L8lQzpwCpP4oJ4RjxmBRf9C8g0zzdjClESbWINZzNl
         2H0SDvhA45OF8oWKwH+iF/xvGw5dHHIdTL6CLDkn3CqRpUnY9WPESwiQEIo7671Aj8Mw
         eDosj72TPh5KhgXCttoJMjEcKDjTQyE7caT//EdmUkb3omSC1v5CvGoUZE59Tm8kbqXH
         EnTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Gu2uMkA0piaBgr5cf+OmPJXEaLiqKCviGPB8pB0KXdE=;
        fh=+9djzrzTUc2J4LctT7qO/0DNX1YhCb4SrVbEETNdVl4=;
        b=S1e4LqO/2pUSURYWmOPTGSgEcPRCQodXPqRjsv/R9n+2R7H2OclBaA6vTlYwpCWP5A
         hdRAmwpnXVSisHw2wGI+G9JYjuegBKsPYRDarPkj354M4pybSCzGZ5E+y4NjgC1I3K9j
         O7XtM4C6ZSEI6zLF3/aHmW07iM1CXaVBUa7uDcvvdqgeI3KRvcc6JwsjH9IKUjO4jt9G
         iA9wVNL2BMM6OdP8o7rZdInPlADn5jLyJkwBRfAQqxCik2x4Fk2A5ywgjMMTgFG7K8cw
         X8+ez22CPK7G/l+mJ+kK4yRs/dWwcukZRSO0bP9OKL9VqZkoYNqzzvjVAhsimQSLZRki
         NoNA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792174551; x=1792779351; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Gu2uMkA0piaBgr5cf+OmPJXEaLiqKCviGPB8pB0KXdE=;
        b=lbnXf2dMv79c6fsjFjP+87dHt+sLlv+eULsG8qxPaorcbrNiZLc6mTbjPDMibg9uX5
         AwkvGXHdQaAg1kig3c24HyPsQPIpKRcwV5EkyMpt3a8cQCzfd/W4AnNeKEApS5mjeVrV
         okuY+KriAFLV7g60u6VRL+iu7blD2vskSzb4OghrH6cyE0ExgC6vIc+yY6zvYs+mfcl3
         3Yetp2ovNKWPBLmtXErRzIfzU33wxFJ6OPKcFy45Sz4utd1IzYtTGBALZOD4QuVJ+YBw
         xuS1DXrKX/1g2n4x+h9PQN0Nt0DW0TnvALlO4QS+y+A8FyYxtYwvGldCAzxxI4WjMQox
         nrbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792174551; x=1792779351;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Gu2uMkA0piaBgr5cf+OmPJXEaLiqKCviGPB8pB0KXdE=;
        b=Pi4Gm8zbG2k8FjL5Atn4uOvoXvURFRzR0VJdD3stu1eLU6nCl1B8Z65yWJGiN0m+Hd
         +59h2zQ7wckRnf9I5IB7qNDr0FOsvAervlh0Rpp6F3+aHDewF+YXtQsJ34Wn1FXkokow
         57lkXGfOEhCgqJ4W2lLCmK5inlsuH1R3l0B6Tkd5ESSKFjBP+p+mZzSMIhTSUmCGG8VV
         UsXVZEhQbhh3K1jpS0P763RtNP0ATn8bkLHyfeBbI8UzpAcO2RenQT88ErWxJvBx8jHu
         6SAjS/iF6z+PW8YUaNPCL20J6GUwYyqZhixjHZ5xtqsyv1x9k9c/0cWWn3Mg2iGJrOLa
         Z/kw==
X-Gm-Message-State: AFq9FYJYKhXCVmCqmOxEVrRcGRyd2jRevEtTZrjrbFj7LuN5KhNtIo73
	51tm0et/U17Aa6UXrxNOG8UTgtLgNwcK5+XyBlGCniO65wzXXi/Rdekg+N2cirzZuhMGfNJCtvn
	V9mgeRt0R6dc80O1pKA6ALLNpIa8I1KDN3+EDSVE=
X-Gm-Gg: AYBFou0LRqGOun/RTfUcxD38DxeeksuTDaSr/2+SbVMc6uY1QJcDgSzVpPrFSUdh+Tt
	VKOdQf3vx3YSgMWWdlcDaT7LSeNgprLyiman/GsE2jlDDQi0TaD7R8p/qOtmKwv+KLdLjiM1DDy
	RlBDxjO6yXlIj++vEGM+lN60QyUxhlsmRCQw4NemPA7uVTTNAUP8zjvd3vGGKCJqGhLmLiUu5bv
	tHRgqUBJZfMFgZLlgH+E+Z++T0xzO3B+GPPtX012H37sU6TWvoXcbaTXWOMX+irrS+a16j904l7
	3k0XhfouantnDNAwxvfzxEtpebRWKyCkXoomabM2KrqnOfjfXTtCAQGVeZpYWbG0E4hjkPmPqv7
	2h4r+xpWTV5QE3SGve8qBu7XbJDHx7zwBf/OH62yolGzXYA4BO0d2DAGFj9YdC/71HtISJVA4yi
	E0+U6Ur21S6Q==
X-Received: by 2002:a05:6a00:4f92:b0:888:4f06:903f with SMTP id
 d2e1a72fcca58-8a04be3699bmr309031b3a.38.1792174551082; Fri, 16 Oct 2026
 11:15:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261008062521.25505-1-r.siddharth.shrimali@gmail.com>
 <20261010210050.76064-1-r.siddharth.shrimali@gmail.com> <as4WY96-KXQT_PTc@pks.im>
In-Reply-To: <as4WY96-KXQT_PTc@pks.im>
From: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
Date: Fri, 16 Oct 2026 23:45:14 +0530
X-Gm-Features: AclHuK8yg7Ze_-NfhsQuBI-RtTHWdZ5Qelq_AKQq4sAlwfZcaVRSSj-rL1f541E
Message-ID: <CAGWgyh-drgvmGzt9dKB6cijA+9YJjvpxNWSqKho135_rvL5MCw@mail.gmail.com>
Subject: Re: [PATCH v2] repack: do not rebuild packs on --dry-run
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, coygeek@gmail.com, ben.knoble@gmail.com, 
	gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"

Hi Patrick,
Sorry for the late reply, I was a bit occupied with my university work.

On Tue, 13 Oct 2026 at 17:00, Patrick Steinhardt <ps@pks.im> wrote:
> Okay, makes sense. I wonder though, we later have a check like this:
>
>         if (pack_everything & ALL_INTO_ONE) {
>                 repack_promisor_objects(repo, &po_args, &names, packtmp,
>                         (drop_filtered && !dry_run) ? &drop_oids : NULL);
>
> Is the `!dry_run` check redundant now because of the above early exit?

oh yes, now that we have an early exit, a dry run never gets past
the candidate listing, so dry_run is always false by the time we
reach repack_promisor_objects(). the same applies to the earlier

    if (!dry_run)
        delete_redundant = 1;

since nothing reads delete_redundant before the early exit

I will drop both checks in v3.

Thanks,
Siddharth
