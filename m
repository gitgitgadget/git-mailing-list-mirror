Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5084727A128
	for <git@vger.kernel.org>; Wed,  7 May 2025 12:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746621254; cv=none; b=FfrqsBVolIFoa85M3Ec/9Uqq02fEDvwgdXfvvdtkWmEuaVCnAt7ISvnRQpyrI3orgIwl0XU9nHsqamNOIOu/8w3lDXxAdVF750qwz5Qg2uQA2vNnp5LLItQ01SnQtFZbsh7LI9zH9CrKtl0ParYarneM9PZIs34taQguc52fC8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746621254; c=relaxed/simple;
	bh=IgReTOx2E79dQfFteFB/l7GUSfokTzURdPVojHC/1tU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GeBdxp5LTHzGQ3S2N8pbFom+EjRxp8r54iQvdq8HQpn3ATWGUnkjmWvulOjRSlDYK2z5AvMKM6ZB+Zy22l8VnG9ynmft5bKIyW1QEcngWCO9+3V/x9WnjOmueqjCGTbaVKh4MWv2BU2b0vIb3Vell9JIufLS66bpCHN/nyhhsms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K42uoxfg; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K42uoxfg"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-ae727e87c26so4286032a12.0
        for <git@vger.kernel.org>; Wed, 07 May 2025 05:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746621252; x=1747226052; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sIwkJ9AqYI23cgqsvHo2ginDx2BPQMmNPw7DxxJN9Uc=;
        b=K42uoxfgEBtt1heYA8IhOxDIYYbTJLKVIUPlY28allBE+1k8f1WFwiMVO8MUqPnnm4
         zunfki3Zqj0mEuesN7c5qcWOYAA0KeO9wPUZFXVsJRLslXdRov5cNlft8uBCRcZXW84W
         qlm8l7RqfMAZpvv1/PhsqiL6y1N2UkBML/02354kh28BNjvzOqeZHVTwcHiUH2RdXXl2
         L4HKxYT90bMrdOKxG78i1fBNb1158Aaff0J9hpdjvu3P5QwpYDdxoVCUrhFRvd7TrG1c
         0qE4FtafyjGXG8gQO2TiKzuIBUxn74WKW+LAw49ff0O5BwKEzdrzENDwV1aV4AohtYHA
         iBUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746621252; x=1747226052;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sIwkJ9AqYI23cgqsvHo2ginDx2BPQMmNPw7DxxJN9Uc=;
        b=mAziYpx9IuykVVkb8rrcnkin3xKKn8K5SeOjWqmEN8V9SrR/Oz6zPgDQeX+qfB1RON
         0I83pHgnRpVvIJupPvxH0mBg4LQ9RXytkBGMrI8coxYFR/cyUkv2e/Fh8DTFG6W/FGyt
         G+u1KIFjL3SxaJyJz6GuUOWEosQFw0808a3WauB7NL5WfiqRI4Tw+2VqGoIbTobFnhYF
         32MyWmmzkOnx1EZ25Li2nuI0SHJehk/7ZClWIB5yaRMauDD2M6+8liXxNqn4XbY17U/A
         4BK9qKKxDWo8LAvSjurAaH9Bj/aZ39EHOpgxL3hDh6demHcTOZRS9BBo4J69BNUQCfgC
         ZuHQ==
X-Gm-Message-State: AOJu0YypulrpU6lwB3pyBEZ7YIj+418fct9nKcUkHFT0q3QzIhAOCGiy
	tuw76JMKIIZ6pcRJWiaCKQB85TGZT7LRJMho3EP1eLJKpOp1Qrcx
X-Gm-Gg: ASbGncvaofBFOTl7ADW9nMUeuI3hYaP04s4s+i7mHXIWUp9cRIzShbJqHdIvqxQn54d
	skWEUPsF1f+cd7Y3JD4NLjHPolw9buXVlIo1vgoKTMZJc2T0s8jpVVIs6d+c9kSLsqsbaFtzP9l
	dQ0CdRsOLVl9RF68p9fcblW9Ju2CMn9C5L1/BitJtRtkkkI0VpxBjW5SUs63t4GEQ+TYP6poJIA
	qvQVo4mtHmOFJ2q1jnQ9RmkxCoqr+hT4025ACoAsV/1gUCPpVnkeMrlSdKa0QUR6LXX1mBGoHBN
	tD/FXGKDGWoLUyb58nOLc1d6WsupP3VfSL+w
X-Google-Smtp-Source: AGHT+IHD226jbbIUWv4/lVgWHbt1Itc+K1mwM90UnLpOmVcnX0xIjMmfpYJapYLa25ES2UperQuzVQ==
X-Received: by 2002:a17:90b:394f:b0:305:5f55:899 with SMTP id 98e67ed59e1d1-30aac184a9fmr5501363a91.11.1746621252467;
        Wed, 07 May 2025 05:34:12 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-22e150eb8f5sm92907575ad.43.2025.05.07.05.34.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 May 2025 05:34:11 -0700 (PDT)
Date: Wed, 7 May 2025 20:34:36 +0800
From: shejialuo <shejialuo@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH 4/4] packed-backend: use mmap when opening large
 "packed-refs" file
Message-ID: <aBtTXIpCPlQJtVqr@ArchLinux>
References: <aBo7OiCKHTyT4DzH@ArchLinux>
 <aBo7tOkheM6zOJpe@ArchLinux>
 <xmqqecx1k1ig.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqecx1k1ig.fsf@gitster.g>

On Tue, May 06, 2025 at 12:00:39PM -0700, Junio C Hamano wrote:
> shejialuo <shejialuo@gmail.com> writes:
> 
> > We use "strbuf_read" to read the content of "packed-refs". However, this
> > is a bad practice which would consume a lot of memory usage if there are
> > multiple processes reading large "packed-refs".
> 
> Neither this nor the commit title says that the issue is limited to
> the code path that runs fsck on packed-refs file, but I thought the
> code paths to use packed-refs to resolve refs correctly uses mmap()
> and does not share this issue?  If it is limited to one single code
> path, please mention it explicitly.
> 

Nice advice, I will improve this in the next version.

> Also, I think it was already pointed out that "multiple processes"
> is not all that interesting issue.  Even if there is a single
> process using a single large packed-refs file, alloc+read gives the
> system more memory pressure than the read-only mmap like we do.
> 

That's right. Even there is only one process, we could avoid copying the
file content from kernel space to the user space. I will improve the
commit message.

> As to the title
> 
> 	packed-backend: use mmap when opening large "packed-refs" file
> 	packed-backend: mmap large "packed-refs" file during fsck
> 
> would be shorter and clearer.
> 

Yes, the second one is better. Will improve this.

