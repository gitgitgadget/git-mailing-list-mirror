Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D7BD12CD8B
	for <git@vger.kernel.org>; Sat,  7 Mar 2026 21:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772920378; cv=pass; b=GBB5MDTg5daMhutXEthPCSVR1mcshGzxFIMPyVvdqmMVYhnLchCKjlERaL6CaD1NI4L0dibByrzNcQ5KnDDnvu//LPeclu6LHS98bqVz3+R0vY0luLMLmGiDQobb22MDhs7t3pcC4+tQqiM5vFI2B80uGizY/3+DPfKuvJN8hME=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772920378; c=relaxed/simple;
	bh=POppObKhmb69yPbH7uti7DlHjKlXgYejPF/AThhBAOo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=rfIsKNM1+iKmIA7cPihY8k6WYN82hGuJYzPOjc7HnWpdrNY9w3HQDaWJN40M+KfX72Kei8a/aKa4AtZv7/oM8Uuor91WAatHZRnH0bw2AahTLuKig9ggRje553gF1JJnDTHf/kF+eSTypWQXtIFufHWxEZ5N0uBa7+dIMRvEwh8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jnPSZdES; arc=pass smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jnPSZdES"
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7d4c3896e32so5700882a34.0
        for <git@vger.kernel.org>; Sat, 07 Mar 2026 13:52:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772920376; cv=none;
        d=google.com; s=arc-20240605;
        b=KcVae5dDP8iyt7uAzIq2pyGyTunrnhlZ/FXdBdobSDLT0PgKRILNlGlCvTcE/fnzIY
         +qBYIOG6Fv3RQQnv4d3qzH8Ouf4eohi2ynYOYRI1owRC04uln/bIqCDBJ3363Q6JlRu7
         W+Oh04FBDRgRTpgXkOGgBYI10ygfjnth4iABBB3sHECICwlEeaJokc2KGuFUbHLonQkG
         cOJSltkp+3AyMse0MRNrER/XaSmswwimU7Bv0+ztzU5tebl8R1AXbYN+0PSQGtEJZU7b
         /QV7lK28DEUVipqpwEZil+NRk6EjYeY0NJZwbuTAh5HGEw7dfq9Cmw/fRdgNlkQTiRbl
         PmXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :dkim-signature;
        bh=POppObKhmb69yPbH7uti7DlHjKlXgYejPF/AThhBAOo=;
        fh=AdLvfp5rDLFEqEXBqPWoMWgsTSDK6pd8NZNu0VEubK4=;
        b=BoLbMYIxpkI/slgwanzCm6Kfj6P+OpMuJ42n4uqGEBF1REGifIH6WxfOyHmmoQFog7
         XzGVOOX25SHys1tDNax0W95tTvi4JhHLqGMxlfX49jjEmBwfEeS6jlGWY6qQmzqblDUN
         WgKjaKBaY2WB5bDD5xsD9ZulFvL++0/hBc7bE9t3RCQtTaPAoIia7sztc0cV3+KgNYwM
         SfrRVjWT1AygBggvxhNV7FQIDC1G2tdtTe8YbfeCW5vfkXD/zX5BfcgY0x+mdP3uuWAa
         wJmGuHMNds0qq64xzG8/g9ly4/2XQUDf6BhUMLPgUnWB2LemSdipwtXOXdSjGLC/UEDm
         +9Qg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772920376; x=1773525176; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=POppObKhmb69yPbH7uti7DlHjKlXgYejPF/AThhBAOo=;
        b=jnPSZdESbmxTEE2PQbR+RDkxU67pIa233bcbuI30AvhpKcuXF5VtMOOZFSn2P63U0/
         +DTnPfGVvryjxkjf6G+PWuR+GNgs+ho8IXW5LNBd7CLfYwEzNdZb2lynn5oA9wK55X05
         e/HEdlezPPsJ3Y2rh6OpFavfe8YYhJOLxucpAvV1bc7/4BXdu1elUPf19hIwjScIiItx
         kguHGL2in2Iw9aZVwT0j+h0gYk4/k6gc7Dp1yQJe/hwJdjBGFIIZtsfW4Y1V62pl0DTe
         I5i7NMGSpjXcoE+vz+5SA34psabhne2m2ALTWg2ViVazO5i+3SBbqbdzXUCBn611IKD9
         WnIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772920376; x=1773525176;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=POppObKhmb69yPbH7uti7DlHjKlXgYejPF/AThhBAOo=;
        b=NPv3eaX4ureTBfMqVeHfrRN0QgNVD+dBy1FNpzCCNrHwf349P4Ilmv3HPqWgDvi+QS
         tSHlb6/UUJC6IxgH36wfEwA6Hcbr+LNX+RZWMdyjRaS6483QpaeJ3a/T3oce9mdPZ2ky
         qdpBp1WFR4TaTfdjeaK/7EtYrmvXmXULu9t9IyUwfOBNxfYF6uVwu9pS9dZII2n7TXf/
         yU2vZ4LEO6zNcYHJsmxuJmnjSPodCkjkksw04UREWXb15lDpZd0VXU0dD2mlY8qGP7uW
         du0CqlWZNjqR1iqkADV1wQiBAq44GAKakZreaEZB7Ub4xWEXSzQbt/5QOUsr/Toi+ZXR
         7VxA==
X-Gm-Message-State: AOJu0Yxh6TdDD/W3HqH1luGj0apPXmGRyV6OBVHaQ/8ZGZvBPXphHteg
	z3LnI6Ew625JLKCHwGxG1IlYjbUctrJimGsBs+8E28ROFE7Qk0CUnY0XjpkZEKiUzCFDU3EwCc+
	PqqpmIC3d9PM6PI455EtDU4T9Zuergqv+uCI+5Yk=
X-Gm-Gg: ATEYQzzixV0eeiuYT6VejfADumGyTxfROggYyM03oVKy70n6i+mBk21/OsIDgsdUiFj
	pqrWgFjtxz/p6prQ1/q9PBR02MKcOUorXjKij5gs2NPeOKEXIqwk3Ee5VPVF7WYBZZhvSSDf3JM
	SNm0k7w4IHRssX+0MuYnYhvViz2uU9XG+cxGhvqZmu2MPvdV7OrG7QlDHbTzKFS7sfEs5Dw926F
	XkZlMRJsM3ckWXQNQ8C3uacW2jydQJouOL8xgVsrf9PS5q4JLevBuNEODNv4uyf+Jh/60dz+vKX
	ugl1kf0=
X-Received: by 2002:a05:6830:6189:b0:7b0:826e:4002 with SMTP id
 46e09a7af769-7d727003ee8mr4196073a34.20.1772920376428; Sat, 07 Mar 2026
 13:52:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADCPJ26F633ftXb_pJrotQNrYCUNXCpBDDP12bBNtkGwudCqqA@mail.gmail.com>
In-Reply-To: <CADCPJ26F633ftXb_pJrotQNrYCUNXCpBDDP12bBNtkGwudCqqA@mail.gmail.com>
From: Dana Escoli <dana.escoli.2@gmail.com>
Date: Sat, 7 Mar 2026 18:52:44 -0300
X-Gm-Features: AaiRm50AMNKfjyX05NGrAy-qusuqPNbxBxFYnyl52LGDS1mxoHVgdSZkFmfmqic
Message-ID: <CADCPJ26LU9kXNH04mPk_+u6Y=m-eSEH6ifHzHWN5tkM=pGpwJA@mail.gmail.com>
Subject: Fwd: Issue with 'git add --patch' after editor closes
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi everyone.
Maybe you can help me.
The issue: I'm using the bash.exe from the Git installation in Windows
10 (git version 2.48.1.windows.1), and when I close the editor after
editing the hunk, the command line doesn't echo the keyboard inputs
anymore. Even ctrl+C doesn't respond; but, with ctrl+Z I see that it's
taking the inputs, but there seems to be a single quote at the
beginning, messing everything up:

'2/20) Stage this hunk [y,n,q,a,d,K,j,J,g,/,s,e,p,?]? Only one letter
is expected, got 'n

(2/20) Stage this hunk [y,n,q,a,d,K,j,J,g,/,s,e,p,?]?

In this example I typed "n" (it didn't appear in the console), then
pressed enter, and after nothing happened, I pressed ctrl+Z and got
those two lines (notice the single quote before the "n", and the one
at the beginning of the line) and the 'git add' finished.

Now, if I use the git-bash.exe this doesn't happen. It works fine. But
I'm using it from Intellij's terminal, and git-bash opens its own
independent window.
I tried with notepad and notepad++ with the same result.
Also tried from cmd with the same result, so I think Intellij has nothing to do.

Any idea why this is happening and how to solve it?
Thanks.
Dana
