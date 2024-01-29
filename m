Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63E41524BA
	for <git@vger.kernel.org>; Mon, 29 Jan 2024 23:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706570431; cv=none; b=eZKgNQIkVhBk7lNzE/zpnA96ZoD6FVvzNJaX6PhlIDnXU4ko9gLO/rkSHK7v9tNeyrXFbvEL3uYOnFtEMWZuV0ZCSa/E106G69UlzqdPs7zYGbMKmAlInXzRMOoGa7LU/mK5ZL8PQQHE6w7bruHUxXZoio+nHaAempxSmX3Xqko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706570431; c=relaxed/simple;
	bh=y/v3Y7fF3PST/jvGv2u2MwHDFUDOPKBBNGlxRrL/aok=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oTndhGdpEq/ljSf0+Ndrhpb7NIMXOkS2x5V4oMFrStvoDArxq2xsIvfai4XGVxh03ziH+Nw2xyT66ZkilOG6M6ZSwpyGjIY/c+BaIzxTACxSniCKN1TsbuUvigQxelx7a4PTVAYYyFlGOJsS7Bl2GCnfRSn0Lu11LARLmsLen+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g2kLu6r2; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g2kLu6r2"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-33af4a0beb3so657316f8f.2
        for <git@vger.kernel.org>; Mon, 29 Jan 2024 15:20:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706570427; x=1707175227; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eyyC0XlEfvx4V4o25gLXLvGMPun3KBZLabIcJhuz2yI=;
        b=g2kLu6r2tG5EG1fhUrmcTYBv/NToGzjLav1jgz92MBjZ1IVGId9I/r7dPVfjDjCqn6
         XVvDWf59bJAc/NS5PY+1b4O6xE7vkxaBcQzqQuMfmgh1d3JxqWgS0Wbi2uV+cAN6qhEG
         vgF3NyUth9XIPDjLtxFJOJ2hcsUNb/Idx2K68jImTesk+WBOiBy9Zvdx5TB7JZbgZUph
         XuEaWU/qmoq82c98MlB+Dcug9XXEOE+txdcE3qCTOqrdedc1yY220rsLq++KkCkSkS33
         ZgfJb0mxSQxAYWtcJ7TOwRWPEVZIhmuNchessRCQP0MoI6Oyg/S+yWUS9Tn08qPYrwjC
         g5NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706570427; x=1707175227;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eyyC0XlEfvx4V4o25gLXLvGMPun3KBZLabIcJhuz2yI=;
        b=cR0h+CZCDbj1qUmgMNpeCTOwI2znhWFONzJqIjdL9Dq3YyeDEJ8czYJbXRp/xrm4Ds
         x7M06M6deA42x4HJ/9MJ/ahHZrQbI1w8euQNuygyB/9KT2B5striaXydI8Aj+O5DjVJR
         jGe4kZOsN8Vi+bZOJllq+Ymq2O8s/nl2dCIaKVAcZZ0FBFM4PO/kA3X66wqCDzw0W1vd
         TJ+a1Lq/DYmqIJ0iLgJH2SBhsljbdJe5LpAcSSn1kY8a8ng0JGOK7Kw5zA/C1HTIPOJx
         M/3ujuOH6FRLN4Dgmktzf1fS1b4tzj7v6kazn1fDSsMLWxnlqIQ2YflnL5ENGJ/NhzQG
         zSjQ==
X-Gm-Message-State: AOJu0Yzjud43lmcZabdMplTfSiWsUuHQxoBSJvChUdv1iOyhGnqcDtZp
	5iHlnLfdfXcxLSwMemmOj0EW8s+Qo1/LInUSTHSJt9r+W7l4bOoN
X-Google-Smtp-Source: AGHT+IG4nZh6FuPh0vItuvaMLCrJZ4SDxSR3jF9PQ9AHIRJfb4r97LTpyEnImcAWnanSUqLKjYXkKg==
X-Received: by 2002:adf:f8c5:0:b0:33a:f4b4:8013 with SMTP id f5-20020adff8c5000000b0033af4b48013mr1950814wrq.36.1706570427305;
        Mon, 29 Jan 2024 15:20:27 -0800 (PST)
Received: from gmail.com (77.red-88-14-198.dynamicip.rima-tde.net. [88.14.198.77])
        by smtp.gmail.com with ESMTPSA id i8-20020adfefc8000000b0033af093e296sm2910608wrp.15.2024.01.29.15.20.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jan 2024 15:20:26 -0800 (PST)
Message-ID: <c932fbfc-f14f-4403-bfc5-cf1d616b22de@gmail.com>
Date: Tue, 30 Jan 2024 00:20:22 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] t0080: mark as leak-free
To: Junio C Hamano <gitster@pobox.com>
Cc: Git List <git@vger.kernel.org>
References: <45eb0748-6415-4e52-a54f-8d4e5ad57dde@gmail.com>
 <4adfcba4-0f2b-44f5-a312-97f00f979435@gmail.com> <xmqqa5onhjm4.fsf@gitster.g>
Content-Language: en-US
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
In-Reply-To: <xmqqa5onhjm4.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 29-ene-2024 14:15:15, Junio C Hamano wrote:
> Rubén Justo <rjusto@gmail.com> writes:
> 
> > This test is leak-free since it was added in e137fe3b29 (unit tests: add
> > TAP unit test framework, 2023-11-09)
> >
> > Let's mark it as leak-free to make sure it stays that way (and to reduce
> > noise when looking for other leak-free scripts after we fix some leaks).
> 
> For other tests in this series, that rationale is a very sensible
> thing, but does it apply to this one?
> 
> The point of the t-basic tests is to ensure the lightweight unit
> test framework that requires nothing from Git behaves (and keeps
> behaving) sensibly.  The point of running t[0-9][0-9][0-9][0-9]
> tests under leak sanitizer is to exercise production Git code to
> catch leaks in Git code.
> 
> So it is not quite clear if we even want to run this t0080 under
> leak sanitizer to begin with.  t0080 is a relatively tiny test, but
> do we even want to spend leak sanitizer cycles on it?  I dunno.

IIUC, that would imply building test-tool with a different set of flags
than Git, new artifacts ...  or running test-tool with some LSAN_OPTIONS
options, to disable it ...  or both ... or ...

And that is assuming that with test-tool we won't catch a leak in Git
that we're not seeing in the other tests ...

Maybe this is tangential to this series but,  while a decision is being
made, annotating the test makes GIT_TEST_PASSING_SANITIZE_LEAK=check
pass, which is the objective in this series. 

> 
> > Signed-off-by: Rubén Justo <rjusto@gmail.com>
> > ---
> >  t/t0080-unit-test-output.sh | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/t/t0080-unit-test-output.sh b/t/t0080-unit-test-output.sh
> > index 961b54b06c..6657c114a3 100755
> > --- a/t/t0080-unit-test-output.sh
> > +++ b/t/t0080-unit-test-output.sh
> > @@ -2,6 +2,7 @@
> >  
> >  test_description='Test the output of the unit test framework'
> >  
> > +TEST_PASSES_SANITIZE_LEAK=true
> >  . ./test-lib.sh
> >  
> >  test_expect_success 'TAP output from unit tests' '
