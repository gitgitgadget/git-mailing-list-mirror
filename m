Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5025140870
	for <git@vger.kernel.org>; Thu, 29 Aug 2024 05:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724908082; cv=none; b=kydc6IExuyb2p3/qSEoCbqEnJz+iB9hgeSYAPQiQNtz538eqMvFqdGPNySvATm+3IOA4IOZsnTJ420PztuP+XlcDv9vVuweE3GVhD10mwUixVf66V339yQVaA9JSzd3wuxH/HCZ/8J5017q5fKjBA0IlPyhtACGyPkbpDRWhtpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724908082; c=relaxed/simple;
	bh=zrucB2r9pSV6oZxUced5L/Su/UsS8Wwe1eKm7BfYcQc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gwEzsfG0m/nUB7psMHo3uSrMiLuauW42eKJwXyjs18qfqngMnLW1bCuzzbKXNPKQVwujOOI0OEiFQRsvS3GYEMFJ7VVzYBTmCHYFZqtMG3pkenVBLNxpAC7dmTZ99enaBcA/tQDKlaOUmfVO79xnJdEoOtCp+JqkXxtbtMuJ9n8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O7NWWmBY; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O7NWWmBY"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3718acbc87fso121579f8f.3
        for <git@vger.kernel.org>; Wed, 28 Aug 2024 22:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724908078; x=1725512878; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o2CcGJoRsnmk0SAzglHr+NOFpB2M23SfDJAs0CGvxjc=;
        b=O7NWWmBYARgw7qbklSCGlq6B8oicGQAFo+1390x4cuphk0cElpJBzaru75uR4tpE3g
         2hiRt497lj6XatuwnUnB5EX9nz4wT/iujeIP4YxM5moOVu8PbhrtgE7uENpuTdgkg0Ki
         +2zSAmddnfHgZfi0byacAOCN+42zfxwDecQWjTyTNx6tRSsDkTlvNDXyxZerM/UgxZN8
         dyHyICLrmKugWw2HTjPMrGJLlEPBg9pG6mQ6yGNWNXOqlCCboWixQlJXvnSMGvbDjsCw
         0t8uvuAygyyjEIgna9gN316mMYEGCnJyizSJacqwt03ucCD4KMJjtB5noI5mgwfdNfZS
         JIIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724908078; x=1725512878;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o2CcGJoRsnmk0SAzglHr+NOFpB2M23SfDJAs0CGvxjc=;
        b=cTXHx4e3QvT9Je64GWAZ29Y7m1QsZjV2EPJOMXagy+X3w++8R+IcZvNp3n1ENZYkc0
         lQJqh9URVUSFjwLjh8uVnxGPjmGYsVIc3hUQpQs6M8i57nm6uh1+iM93K/7uzq+ywy0m
         273GGse5nzMD+/IYEF+xK2Z8X9wtYhAg5OOieNcO/N7bhD+EVNkkqd/GkywQU+o6OW0V
         kY4Y2NFyXnt8pSOa95oLsT4btJKIaI9fIx4FfihQxfzSn83HbHwLI2gWK6PQcYTBQNUK
         h5dFlm7U0bXYy2hNPVK/4i8rMuOVfScOmojNeyTyX/j2Js/82rSU7Vz6+avpIYc7dZZW
         DmXg==
X-Gm-Message-State: AOJu0YwSmNIAcfwpJEAjVA072yowGhzZd2DkaOXll0YGjynqkEP5rsrw
	iJpp9G4qIhlIoSZG/yHXHvUMWULdYT9ER30c6b/16HANfTR5voya
X-Google-Smtp-Source: AGHT+IHFclKsWgh8svAZatRyZal10BMtYMYMY2SqQmCVI41/RMzcQ7tALC6jkLrJRZ+zt8gbmnYlTw==
X-Received: by 2002:a5d:420c:0:b0:371:83d6:9069 with SMTP id ffacd0b85a97d-3749b5468bamr983353f8f.15.1724908078143;
        Wed, 28 Aug 2024 22:07:58 -0700 (PDT)
Received: from gmail.com (102.red-95-127-38.staticip.rima-tde.net. [95.127.38.102])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3749ee720b3sm439183f8f.29.2024.08.28.22.07.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Aug 2024 22:07:57 -0700 (PDT)
Message-ID: <afade304-51e3-441d-9ae6-e0a422d00bc4@gmail.com>
Date: Thu, 29 Aug 2024 07:07:53 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] apply: honor `ignore_ws_none` with `correct_ws_error`
To: Junio C Hamano <gitster@pobox.com>
Cc: Git List <git@vger.kernel.org>
References: <6dd964c2-9dee-4257-8f1a-5bc31a73722e@gmail.com>
 <1eb33969-1739-4a27-a77b-3f4268f5519d@gmail.com> <xmqqseuqerb1.fsf@gitster.g>
Content-Language: en-US
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
In-Reply-To: <xmqqseuqerb1.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Mon, Aug 26, 2024 at 05:35:14PM -0700, Junio C Hamano wrote:
> Rubén Justo <rjusto@gmail.com> writes:
> 
> > Ensure strict matching of context lines when applying with
> > `--whitespace=fix` combined with `--no-ignore-whitespace`.
> >
> > Signed-off-by: Rubén Justo <rjusto@gmail.com>
> > ---
> >  apply.c                  |  3 ++-
> >  t/t4124-apply-ws-rule.sh | 27 +++++++++++++++++++++++++++
> >  2 files changed, 29 insertions(+), 1 deletion(-)
> >
> > diff --git a/apply.c b/apply.c
> > index 63e58086f1..0cb9d38e5a 100644
> > --- a/apply.c
> > +++ b/apply.c
> > @@ -2596,7 +2596,8 @@ static int match_fragment(struct apply_state *state,
> >  		goto out;
> >  	}
> >  
> > -	if (state->ws_error_action != correct_ws_error) {
> > +	if (state->ws_error_action != correct_ws_error ||
> > +	    state->ws_ignore_action == ignore_ws_none) {
> >  		ret = 0;
> >  		goto out;
> >  	}
> 
> Hmph, if we are correcting for whitespace violations, even if
> whitespace fuzz is not allowed externally, wouldn't the issue that
> c1beba5b (git-apply --whitespace=fix: fix whitespace fuzz introduced
> by previous run, 2008-01-30) corrected still apply?  IOW, isn't this
> change introducing a regression when an input touches a file with a
> change with broken whitespaces, and then touches the same file to
> replace the broken whitespace lines with something else?

Yes, that is the center of the blast this series is producing;
affecting to what `--whitespace=fix` does (just a reminder for other
readers):

  - stop fixing whitespace errors in context lines and

  - no longer warning about them.

Clearly, as you point out, the change poses a problem when applying
changes with whitespace errors in lines involved multiple times,
either during the same apply session or across multiple sessions
executed in sequence.

The new `ignore_ws_default` enum option is intended to mitigate the
blast.  It would be unexpected IMHO for someone who wants the behavior
described in c1beba5b to be indicating `--no-ignore-whitespace`.  And
with it we allow the possibility for someone who finds that behavior
undesirable to avoid it.

I'm not very happy with the new enum, but I haven't come up with a
better idea.  There are other alternatives:

  --whitespace=fix-strict

  --do-not-fix-ws-errors-in-context-lines

None of them are better, I think.
