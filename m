Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE30E306767
	for <git@vger.kernel.org>; Thu, 24 Sep 2026 07:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790235706; cv=none; b=ALSLceiQNqPEleAU8eLspWBACdLJNZlrM6AoaEOi1Ovl2ial9WIydhCzMkQdyZK0vI+qSXMUSGbBATM53Dxd9TVuUzmktB3XxOnSy+SfveYjgFMAEXgIDY+LrGYf7ktQu0lNhdy1Op5sgQrjxGeVSsm/8Y1aBkB9BbFQLb/lt/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790235706; c=relaxed/simple;
	bh=Rndgb+b9Be+jXUsDpDF+n4rLusHgtk4zthJBw+xkEbg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A/NGNdNV5D/IyQV9718U0OlsX9V044ptLBjz9rvgvZk8bazfDcerSqnDrXQbvkBrjdVHERW+2qFxOI3FCiruY8OvesyhZnCCnZPBsErCqc2dqeQ+deLnuVSLA8G8n0jwMn+ULnSxr6eV+AvE1V3+XR4wIrbFJdsaVTziX96Pzlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T5uPImdw; arc=none smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T5uPImdw"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c254f9f0b20so268570266b.3
        for <git@vger.kernel.org>; Thu, 24 Sep 2026 00:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790235703; x=1790840503; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=WCBLx1IIB47Ndj23V1wCquR8UnQdD3MIJy58NFWb9bQ=;
        b=T5uPImdwvGtnbW3yYKr6BZI9A5E4R2OmUzUiudUVuTxg4WrBAqqx7VHrCyZ1LMu6ad
         yBqr2KoY5MZZX7PDHlIMVXDVbW/yOIt1MjWYGztnbv/RJEFLDzIUyplhpisI6NcRE/w3
         5n9KNZWja1Dg4/an+t6jqKL0f9hks4gk3JaQnz6IQTu8/H1nwx/ukX4yiAjrFKCmsKRn
         ic0G1ItepseAclrSV0UZqpsRPtL5NVScP25iscFHrWWVH+tqtpRY0+lm/cO5NSYqbH6b
         6qak4zsq8CcgZ7DDwc/oJh/4i/zTcPGb1Cb8I5jB83ig+zS5TZnE6/YA/bnsfhz4cAYB
         j6lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790235703; x=1790840503;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=WCBLx1IIB47Ndj23V1wCquR8UnQdD3MIJy58NFWb9bQ=;
        b=oLXjReZ0cn6s0iu51CVPjYO4I8ehisOR1QxU23Fu5ds2MgQsF313KyjUzL9jTwM6pX
         LIx403+kpBr0X8+atoexUSJs0rrgkVHKNhowaKUamYICDrhmnTuP79kOJPPb7GlXuiOy
         dVS3KQavI1ekhi4vCpzadroacBwEB2MEgBmCjx+KSxUuWWz9W1hr8HcSJ+zXqbqqjHjF
         oOsMPEy6YwiVO3xvH+7aNOvrItb2eCwJEco3MTCAHfuMstWGw3v5CW6a2iX6OrQoub6l
         Xb068146DBQ8byo/4uv0D19TesyRZART+CgqIRklvhNq3/y4zDEzVkvlgAMSWqZ79ciY
         g90w==
X-Forwarded-Encrypted: i=1; AKwUvBymUKffk6XWjERLlP5uJYaGQPIQHIjzHhnzlYUjogFqncGDEToP7IozpTjEXzAhrzHf+xY=@vger.kernel.org
X-Gm-Message-State: AFuF++nmJAswr7la5Tpc28wPsHIbG55phfSglhcCO1yzyWSVjJa5g/0Q
	DUXAkxjX+O3IWx39Fc6dQgK0wnonYNmjNkqA84asyW1eA8Uf6piUK5C5
X-Gm-Gg: AYBFou3OUxb199tCJLN7y+/8Ph6JEzaQBaOEOMnTt/Zu64SSeLEwpGLUjcVpz1S+XE5
	LRp9yW6FVJlElxqzYKodr5XiY2ESKLu8sQo7apvbaxx17At3UBCNSf++/w/K8O98414jBuYjMcB
	WQARw63oA+wiWj9qpkx3FJi1gNwuLUPOWwYfFFhasNbE8wZar+xWsk5PGWPn0CqPhf+brNOFSiZ
	AN5dNP+urwY9M7pTEWenpBIfom/lc5AbcZQhTgIAScmshih4RQcOy/t1rNo0pyrRN14dENbxZmo
	fTktPvH8Q5Tl7ymJ8gP0waYnzuszEb58DlRU8dPSnfFSYK1Lhk0IUMegK1QwqpMLLa24uwwx/pp
	1dc8o4LrTvCqE4E278xanP9Bf+UGJ825NuZLURBn9ijwhCb5EoHI7+1boFt1sy9q18azdYeBjvA
	VXfWePf+S3JlFhabNM0otKHEqnPOP8XZ5rkrMnMvF+5NC5eLICM35jnGeAcO40W8PrFPgcVrNqK
	ypbOC9bROFCe5J69IAkPDa/pHGGERTxDcCJtO6X0TGaSvrMFXWM1klwBkgO38MS4+KZEA==
X-Received: by 2002:a17:906:f588:b0:c2a:6c3:9e98 with SMTP id a640c23a62f3a-c2ac22a7cf7mr117184866b.40.1790235702846;
        Thu, 24 Sep 2026 00:41:42 -0700 (PDT)
Received: from localhost (20014C4D24E72500D0AE99597D6BB771.dsl.pool.telekom.hu. [2001:4c4d:24e7:2500:d0ae:9959:7d6b:b771])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2aae639f10sm250740866b.32.2026.09.24.00.41.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 00:41:42 -0700 (PDT)
Date: Thu, 24 Sep 2026 09:41:41 +0200
From: SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: graysongordon-gl <graysongordon1@gmail.com>, ps@pks.im,
	git@vger.kernel.org, peff@peff.net, avarab@gmail.com
Subject: Re: [PATCH v7] http: add http.sslVerifyStatus to check stapled OCSP
 responses
Message-ID: <arTUNYVvCNwX1pDp@szeder.dev>
References: <xmqqecfez7ie.fsf@gitster.g>
 <20260915162348.97792-1-ggordon@gitlab.com>
 <arQ/nOH+o3XwQFD/@szeder.dev>
 <xmqqwlsb63o9.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqwlsb63o9.fsf@gitster.g>

On Wed, Sep 23, 2026 at 02:47:18PM -0700, Junio C Hamano wrote:
> SZEDER Gábor <szeder.dev@gmail.com> writes:
> 
> > On Tue, Sep 15, 2026 at 12:23:48PM -0400, graysongordon-gl wrote:
> >> From: Grayson Gordon <graysongordon1@gmail.com>
> >> 
> >> git never sets CURLOPT_SSL_VERIFYSTATUS, so libcurl never requests the
> >> OCSP "Certificate Status Request" extension and any stapled response a
> >> server sends is ignored, including responses that explicitly state the
> >> certificate has been revoked.
> > ...
> > This patch was merged to 'next' the other day, and the last test in
> > the new t5585 fails on my system.
> 
> Sorry about a premature merge.  Since we are not in a hurry to take
> this topic in (or no new feature topic in general), let me revert it
> out of 'next' and give it a clean slate to try again.

Well, if you hadn't merged it, we would perhaps still be none the
wiser, because, alas, I don't have the bandwidth to run tests on the
seen branch regularly...

However, CI does, but I can't seem to find any CI runs that failed
because of this, which makes me worried that something is wrong on my
end.

> > ...
> > I added that 'cat err' to see the error message.  Turns out that 'git
> > ls-remote' can't even find the repository on the remote, but the
> > prereq is still considered fulfilled.  Is that right?
> > ...
> > This time the error message talks about missing OCSP response, but the
> > prereq is still considered fulfilled.  Again: is that right?!
> >
> > Instead of the lack of a certain string in the error message, is
> > there something positive that we can test instead?
> 
> Oh, that is a very constructive and useful suggestion.  Greatly
> appreciated.

After having slept on it :) I now start to realize that this
SSL_VERIFYSTATUS prereq only checks that libcurl supports the
CURLOPT_SSL_VERIFYSTATUS option, and has nothing to do with the
capabilities and configuration of the web server.  If my understanding
is correct, then I think that:

  - Merely attempting a connection to somewhere is indeed sufficient
    to check this, and it doesn't matter that the server can't find
    the requested repository.  

  - Checking for the error message printed after curl_easy_setopt(...,
    CURLOPT_SSL_VERIFYSTATUS, ...) returns with error is indeed the
    right thing to do.

    However, in that new error message the second half is much more
    informative than the first, and if the prereq looked for the
    absence of "could not enable OCSP status verification" instead of
    "http.sslVerifyStatus is set", then I think I would have realized
    all this sooner.  Perhaps calling the prereq CURL_SSL_VERIFYSTATUS
    would have helped, too.

