Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792449916;
	b=aIKjFGbq/aTlog9OToXiJ7zCZ6QYelUja4ZXgB2UzSFjY26plTzTPLYmFC5AdLMt4xnh
	 /G97h6M2GUqRNDw9zRknJU1HcJz+NyfSEsoI9fTket72yfFrCbdANHPnzcHNbRFDFH/UZ
	 xBK6Oo8c27cSfE5E1bQTNWFNjV/m87sZaErmgm8e+himCVXXFRHw2HBqS3f5it2Jfe1a4
	 WpgxRyXNteGOUBaKW625XaBPR3gjqC6OZIF7f8WQyA1XB35oDU9MrfcrUr4YehXVKmfUx
	 nNLl+vpGuJqgMP4J4tz8iV9gG3lA2TlkKxIBUkNNM0Dc4a6CtU1Y4vHWA9CDRkiAoZQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792449916;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=u9SrfrsI/k9Vz2x1DzECnuhltUIsvSUtr+DsehjYBR0=;
	b=QqxJrkesx6V0wTpbVGcBh8HXgj1GV51OFjumhyEO9VxjeHO/+mIpsvKar3RQU3diXjEV
	 qt5Wu4+Wo3VxwhKewYpeF5AT7uBy/WZf8bXmHlodnXTPH7b6CiJf1aUAt6TlI977S0F8D
	 6m7r5dGQeidY9xWEfNnk54UuYonZNRkKkG0wnYcRtAjEcsFaUO7jgB6T3TkXq1aC+yHoD
	 7VvD2YDd01jkXRrb2Z/dzT+o5rd+cFMY4B29WcoB22QMshA0pvBQpYwBSOSl9FtVIlDmH
	 6QZ3t3ppqA+b0ByP5cbr0b6TKKDV3mUlI1gU3KHO2Rtmg5RRx7mxzKmGD6gtS0jVclA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=m5xWTbDE;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.46
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28007606A31A
	for <git@vger.kernel.org>; Mon, 19 Oct 2026 22:45:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 28007606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=m5xWTbDE
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c43373ae89aso271066166b.3
        for <git@vger.kernel.org>; Mon, 19 Oct 2026 15:45:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792449914; cv=none;
        d=google.com; s=arc-20260327;
        b=a4SRgG7oVhuSDk1/kXjLosgBvgaOGZxmOKQGVlDCm/htNGD3YaGP28a29mTrqeifBy
         B6RnRHd994R93s3ytbq2+KycIeLVlPKUjOXvyN/aCkVWt3VJ0RFGwgZ2JJLzIB+a6NoT
         lSmWuqzrnpcBC59GramQOp0bSIeeCLaBZcwDzmLBs0uLxqVSO75mrfTL7J4Nn1hD0IuY
         RRUC0++hCZuJzaiiXsqo1V+JUO1/Gp6POqEK02+QNFBFSUCyeM6aiofSK4Bz0LBflhjI
         +j6ecsSgXXhLu3xg2ftGe5kso1GANMR+fmrs2EYx9bWIVODCICwQsyqzp8M8yebjSWZG
         sa7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=u9SrfrsI/k9Vz2x1DzECnuhltUIsvSUtr+DsehjYBR0=;
        fh=An0DuzeCbvFbwhQSon+Ev+poFLfSTfml6LPwagjKmhs=;
        b=pl5L7u8xbF7a0L2EImpn9XSOp1FityRMvXWrOeKv6HEwcBViObDtmkOh0u/lQ0Tx+H
         jBqX1FG7AErQ6dc2SSOIwS91H6jMlGBO1PqdT6d8815bRaLpX8iGko2yE9sXkN755Cs8
         IuRt8fP9rM3TEVE8xj04HxNDnumlfnJwC/BvKzN22k8eO3FWZs2BHAXqia2XrlLRlbYB
         eKHo3QX6D6Cct285J4/9XFRtbf1O6YfYPGLplSCG17uUP/BOqNkYvUaFFE+sy/Bdsz8+
         K05lvfLIFFxqmB+HxLzNg59dGKg9rhn7SW0DUOXey3sKpBRBORxtjxLK2CLF4hs/3Det
         39Sg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792449914; x=1793054714; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=u9SrfrsI/k9Vz2x1DzECnuhltUIsvSUtr+DsehjYBR0=;
        b=m5xWTbDEbfLjRjTUDNbePVj7dDs8i9o/HXgeuv5EVupv237FcDgXciSNWLvaXGKPy0
         lqv7JYHVG46RVdXoYN0xhPxOe/bXfckJX8ZS/HKkCc0WMMiU4M690PAoajdlWQToCTr5
         9a7C317dDdZCX2jaLf2urdQG8Ak6AwD39ItTiAv4KegynFWDkQYw1OPhisbeCGRZW5+a
         HSVYUarzMLu4LD1mGKbMTJlUTGwlqWgi32i8LOHsTC00lbKfGzDYQik/F2t8rwj2atD2
         fxdzmUpo3gDDLX6fn0saP1SzEGqMNfIgTihmLf6IKvnKrBVWkPybAzxBEh6cPdJhJTck
         1Big==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792449914; x=1793054714;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=u9SrfrsI/k9Vz2x1DzECnuhltUIsvSUtr+DsehjYBR0=;
        b=PpNrFtPCuSXT4jy1oQ2ipbX5p9nXgde8IDSksOX0To4xt93JdEs4JjbJC2j3DVoj97
         tW/c41kbpJBOz5sHHLtk9O9O1iuyVvpDPgdDYemNpqp0MNnDAvL/5ZsflipC1SUX8FbF
         RtH5jG7E0+FZZFwp9CxWsRX8L2v7mFfFDng2igZk24EPZSmI1+FYPMUM+SIpaTIzkCMy
         gLXHoL9qhT+nstFNJwWv6m8DHZzmy4CA4wFrvszFkP85ccfFzhiJfCkTgUuyNmIrlqtU
         XmEUFhfre7QP89i/gCRjFo2lGxEv9RlZNrJCe3w6+go2XVwyOusJrw3M1ewkyslOSQ5g
         Ka5w==
X-Gm-Message-State: AFq9FYIEfTpE/yNb5P3ROwyd6F2VuG6szLz2FGCmYXSpYR6FgQnLgl0p
	xeiubmC1/f2bKp9P27SbOHrdwx1GGIw08cP1tpv+JaqbIMMHs3eqJMsLf9IS2+bcnb50nou6+3i
	VH1yFzGJ5f5KfPjNzjiDnrspLbKG3Zma1GBAkhIM=
X-Gm-Gg: AYBFou28yZVd7gInBbHNz1Vvb9vrKphU4uR4TFQ3bYc17IC9xL+5C1Z9CF9enZMqjbe
	2UHzmcu6XqWQOrmIvNPM4ALBm995U28Bgj4n81fEUly0nyUWjNBWIBwSXotenvLzaDEsJ0EWIp/
	3XfNzhGVWHmRAl8/BcwOQvSAgcK9hV3TMtNNOVSodjlSjfkpJ6G5EpDvrxFBvLu/KHb/zxwHeVm
	bny/YOeKiZGlDQIGHtGZTTxTnwzuUaLkSnlT6hGWxoFH53rjEXWRcMKgSNdcri9bi6LPoGdlKX3
	jgx9BrUA+q8oHpxgXrVH/h6Rh2eXg+gBkDZ0xiXUKEbH7P6wgk5uye4=
X-Received: by 2002:a17:906:9c96:b0:c40:5de7:33cc with SMTP id
 a640c23a62f3a-c419f706de3mr647634466b.36.1792449914524; Mon, 19 Oct 2026
 15:45:14 -0700 (PDT)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <CAOcE0wJ88hbd9n-A2C0RxksKVtnt76u4vGxvhQ4rdNDEdGTmOw@mail.gmail.com>
 <CAPSxiM-dxHUE5tHf830=zHnLfg1U5jyb211-ZODS7bu8OjqEnw@mail.gmail.com>
In-Reply-To: <CAPSxiM-dxHUE5tHf830=zHnLfg1U5jyb211-ZODS7bu8OjqEnw@mail.gmail.com>
From: Priestess <herroyalpriestess@gmail.com>
Date: Mon, 19 Oct 2026 23:45:02 +0100
X-Gm-Features: AclHuK8yea7obekinxS3PgdPv607OdqckS-yH4QrVbRHNCIL6qYaAK2CCi7NgeA
Message-ID: <CAOcE0w+EciSBZDTTNzbi8hEzZAZjB6gut=Pc9qB5yEgs-w1f2g@mail.gmail.com>
Subject: Re: [Outreachy] Applicant Introduction
To: git@vger.kernel.org
Cc: christian.couder@gmail.com, Usman Akinyemi <usmanakinyemi202@gmail.com>, 
	Siddharth Asthana <siddharthasthana31@gmail.com>, kaartic.sivaraam@gmail.com
Content-Type: text/plain; charset="UTF-8"

(Resending in plain text, since my first mail was rejected by the list.)

Hi everyone,

I hope you're doing well.

(Thank you for your welcome, Usman.)

For my microproject, I'd like to work on avoiding suppressed git exit
codes in test scripts, in t/t2104-update-index-skip-worktree.sh.

In that script, `git ls-files -t` is piped into `test_cmp` in four
places (the 'setup', 'update-index --skip-worktree', 'ls-files -t' and
'update-index --no-skip-worktree' tests). If `git ls-files` crashed,
the test would still pass. I plan to write the output to a file first
and compare the file, changing only those four spots.

To check that nobody else is on this file, I did the following:

 + I searched lore for "t2104" and "update-index-skip-worktree" and
   found no recent patches touching it
 + I ran `git log` on the file against origin/master, origin/next and
   origin/seen and found nothing in flight
 + I also checked GitGitGadget pull requests & issues for "t2104"

I found a GSoC 2024 attempt on this file but I could not find that it
was merged. Also, Junio's "t2104: style fixes" commit did not
change these pipe lines. So, I believe the exit code issue is still
there.

I'd like to know if I'm clear to proceed with a patch.

Thanks,
Cynthia
