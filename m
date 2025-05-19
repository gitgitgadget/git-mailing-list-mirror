Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BD901DBB13
	for <git@vger.kernel.org>; Mon, 19 May 2025 05:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747633862; cv=none; b=ssY9AB79Gevlq5mRemb+LWkpWasl70m4hGvnETX7+qHlZzoPPZ3GQNRFuDfuZwdO55U6Q6jd73PeSQShL0Zrf2LgBLIGi8tC3BnOZ0pXQFuOANsvnQLqaQcXjoOgqSntj6lPPalgh/Y0VmNV7G3XFfTYZx/mAM+cbw8xOXGyL0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747633862; c=relaxed/simple;
	bh=s6eOBilTduGjosAKTVHkhAY+0N3cfBb0HGApao69f/Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Eb8DKefh0u+yEMzCsY3f8n6Wc6s6wnxlGac+4Rl/mbf9azMrJ6rjdu8qZjRkMo3ww0Qe9HrflDeCRW9pTVKKeGzR//M5/Jkl9SxWtvymWBC1x3KCYhhXeDHeEcQhMhtAMFRJFJymYdNHyM5n2KPGtPd5cRnQwyQ22VcbNpneolw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cE6j1P9L; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cE6j1P9L"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-30dfd9e7fa8so4997838a91.2
        for <git@vger.kernel.org>; Sun, 18 May 2025 22:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747633860; x=1748238660; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RPs7J3NJJQZSJrtZktW5BsXIX83aZBLYSiPebWsw0CE=;
        b=cE6j1P9LRaaUn6c6ykYbEfWTTQWYB8q81WVj4StyLfZkZH5mh9Q8BFPkVkAP5Y+fI8
         XiYdTrQdZBhKb2l4y6pg3eRoOQznm69/HrNMUrCxPIkmfWL1IkMPdXPTF7QFAETQvcPq
         jLSF5Ge6uQxghl2qc6WpUdAKS5/tSRtmjOlP7AmmjGzBflRIjOynFU8Q0bUoabaGMWUW
         D6g2fLPd7JG8ynHrrCRDyl+RXoVwFgEzuw7ta5d2lpa/jYMDLjRL2KeKOjnziYrVtuJ+
         Inu9LbcFXa1yP4ADLemT+5FH03m3AieBkzct4EJbSEp6NDZO7gzhtWWOa41wCLfXNL5h
         Mmaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747633860; x=1748238660;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RPs7J3NJJQZSJrtZktW5BsXIX83aZBLYSiPebWsw0CE=;
        b=cE+vndxgrTgv44PZtzkbAGPwOIWw3oEpVqJ3+BT0VmXhgJOZP7/ZtDwtRSsA7VYYM2
         diU1GE8E4GRkHbQTE9OSzWWjjDOcfee/UZLn8iiPpZGI+Euyl77Sf9XGD6lMl2Q7IghW
         2agIYUkhPb8JqUa2/IzuR2nudAgmuUnJQ+U4Gc615Enzs0Ofl0Jzc/S24LIBUgloXFg6
         iYoUdZ3fKqBTIbgKqV6lDoC7ZlYtgT7Q5EJllD8K6M6j2HRjtMqWpZoeQmRWLwZK9QTU
         CjIp78GdPGu+95j8aHjVGUofwBHODx2J2htuZ7j4vRuBKJBULekPGvs5a02ATpH+vIEU
         d0Mw==
X-Forwarded-Encrypted: i=1; AJvYcCUZXUedzPlvWetDSKuMOc1wdirL3TkIPuol6kvuNsvZ/kq0wDXZRghAnaZ8HsSEaUmOwxY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVc/sOO+UQhvifqAyTaeaLaYvjy/GLSb2mfFq+9M2Eldv8iUjj
	CEzxXi8Myataw5gKHA+WJ2/i4FMfYjoERU5jReQ2kCOaNzbJS0BwNCYNX/yeOvI4
X-Gm-Gg: ASbGncttBangHWqWlVkDw/pyhDrBfOYnm9qREPzUqkJSB8Uag1pwLyFoqVzcIHQNmRZ
	pzQ8RFA3EhtzVSgpAX6UPvBa4RE5b/bb3YrVm5Kd6Zh7AQISO1tGMO+foU65WzYSdgYHBX690PB
	pVRiyRkCGQdvFN5CNEdXkRhrksPK4GDwOnmmuvQ0eG63yXN8WT6N2pztEWURO0OphQsADk7IoFP
	UzzESTS+nHG2zOL9xWRb3Ym9iJ+fb5Jm4UMbi9JkrZ3NAEBS7hQnzJyJ3seTd+kMk2idcGWU20Y
	5KSaZRuCOjgAaUoKysojXH77yXS9lRjW0mspO6Cv0AHDXIQ=
X-Google-Smtp-Source: AGHT+IHEU6bF8a/ZZiwRtSqsUFMwFbFJsumZxVcSNEjnx44zfl2e7susjRtiIlOzpWrYcWFTdmhbkA==
X-Received: by 2002:a17:90b:2b45:b0:2ff:6a5f:9b39 with SMTP id 98e67ed59e1d1-30e8314fe2emr19847205a91.18.1747633860152;
        Sun, 18 May 2025 22:51:00 -0700 (PDT)
Received: from fedora ([138.199.43.83])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30e33401a81sm10354880a91.2.2025.05.18.22.50.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 May 2025 22:50:59 -0700 (PDT)
From: Collin Funk <collin.funk1@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Phillip Wood <phillip.wood123@gmail.com>,  git@matthieu-moy.fr,
  git@vger.kernel.org,  kristofferhaugsbakk@fastmail.com,
  phillip.wood@dunelm.org.uk,  sunshine@sunshineco.com,  tmz@pobox.com
Subject: Re: [PATCH v2] contrib: update thunderbird-patch-inline
In-Reply-To: <aCrD6RlO0xUmXr6i@pks.im>
References: <a3aaa11a-a842-4c10-8189-07b681663573@gmail.com>
	<20250516135540.218937-1-phillip.wood123@gmail.com>
	<aCrD6RlO0xUmXr6i@pks.im>
Date: Sun, 18 May 2025 22:50:58 -0700
Message-ID: <87zff9jghp.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> What I still don't quite understand: who is this update for? The
> existing script is broken for years and nobody showed interest so far to
> fix it. So I don't think it makes sense to fix the script just to keep
> on dragging it with us.
>
> If the answer is "you" then I'd be fine with it. But if the answer is
> a hypothetical "someone" then I'd honestly prefer to just remove dead
> weight and not bother with this update.

Without a further explanation, I agree.

I feel like doing:

    $ git format-patch -1
    $ cat 0001-subject.patch | xclip

And then pasting in the external editor opened by Thunderbird and
removing some headers is pretty simple. I'm not sure a script is really
needed for that.

And who knows when ExternalEditorRevivedRevived will end up being
needed.

Collin
