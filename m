Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91ED411CAD
	for <git@vger.kernel.org>; Fri, 23 Feb 2024 05:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708666133; cv=none; b=g4Z5Mrdt4QOaKgv1CL7OfRUVVDmWfmfm61gRyyu1GCERMNPHrhAgBA8q6DNrnbXhYuAm63gOSvQScnEMFKLmuM5pm5sNHskWDjG7hStBpAihuRu7bhA/91q02vYzp9a44lzj4xj1L95aN/CyNvvD9ERdq1YWgmUhs3YksSy7iL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708666133; c=relaxed/simple;
	bh=Y/u81HWaEW4eHiCUwUkAJCPRYfnIYLdNdyeiSNWoRi8=;
	h=MIME-Version:From:To:In-Reply-To:Cc:Subject:Message-ID:Date:
	 Content-Type; b=M7HzI8NqSXciu2Y8sXQVPpA5tMWA0w4jr4USMLtsOzWn3DUOyUuFQOCtLjHF8jN1PzuHqWIi78O8+mrOgFi+Emq9EJB1+S+6hegSE7t5BAWGoPhH/3wNIecOeUEHi4SnncoUPqYzgLMkbo8d2vSAYq9lQvB0eI+VN7qqGmgF1jQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PkTZfRBk; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PkTZfRBk"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-787accf57f9so32276685a.1
        for <git@vger.kernel.org>; Thu, 22 Feb 2024 21:28:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708666129; x=1709270929; darn=vger.kernel.org;
        h=content-transfer-encoding:date:message-id:subject:cc:in-reply-to:to
         :from:mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sZgfNwUsFC71JaESM+lJg4upYBtpu87Gd+1+tGkGvFw=;
        b=PkTZfRBk2k8eZgzA6plmo/lzYEIqe7og1pWopVcbHG4fvWy2nNSJYaNwaeL+S56SEi
         ninINVkCnZgsAyer+o21/r80jSObJ1OKRXN7BRPf4IFfRidEKPwJOWmyOhmnCD/Gev6v
         xwfmdIMiQlby1Lmt/X0N9lNDzcZxE5CN8YPc/zGZmhh1jBsrcbt8PHOyJqTPJokn8D16
         wZ6y7CPYUKG1H8Mp+FmBi5jHNBfbrwkHs2IA4c+0Tiq9DDjEw+1EvWNGLNcvs4l0R+J2
         NeTBj1yQvvcq1ITPm+9rSg1VCYHX9vBbbkVgxw3qVaj82jbn4SW7nk8hszKzZzEFItUH
         mHOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708666129; x=1709270929;
        h=content-transfer-encoding:date:message-id:subject:cc:in-reply-to:to
         :from:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sZgfNwUsFC71JaESM+lJg4upYBtpu87Gd+1+tGkGvFw=;
        b=d2vTYvxRyoyfl2NMfwkPRmMz+eRJsMZzRh5Gl720Ol52x7ti8y9EsjSz3rMpB644xH
         XbfHRDD50eLqIKk2DMhH+22ijpXgMq5dfQ6vj1deeVy7kLIAEKgryxT8REWEwJe7kEUi
         BnDMqWI59zFbYXfuujyspUatB5PbWA2RKICaiFSBnH4ckHA+ErvtON+iciqytvwbawKj
         jJ/8txtHXIe3h6sWUh4VmCKiqyDZkoULHmnR5z3Dsc4k7+lZiH333VNTENOpp/zshY6i
         iInsx2Q2IMzI/D0tMgIFWJ9UGA3c4ba1vcoBSXKmUrToTR8f6T7L6tRRiw2zxlRmlBeo
         p+jg==
X-Gm-Message-State: AOJu0YwOtbH7ek/+ATkuC91vUxLKzvNRF1Od9BE2V26tts/q28DfCRtw
	VdT3gHw6gmIEer14Q5B3WTLtnEo1poXWx8Vit2fuy3xokGOB7iVRR/ywuRU2
X-Google-Smtp-Source: AGHT+IFk45JVugvk7ITEfxHDwtGPeXMD0YHl0abp0xgKjz+OYlpL5tqdgpbW8JbEnUqYrMhXWviskw==
X-Received: by 2002:a05:620a:2048:b0:785:c9d1:8636 with SMTP id d8-20020a05620a204800b00785c9d18636mr971104qka.59.1708666129313;
        Thu, 22 Feb 2024 21:28:49 -0800 (PST)
Received: from zivdesk (047-034-027-162.res.spectrum.com. [47.34.27.162])
        by smtp.gmail.com with ESMTPSA id o14-20020a05620a22ce00b0078734f18e3esm6076368qki.80.2024.02.22.21.28.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 21:28:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Brian Lyles" <brianmlyles@gmail.com>
To: <phillip.wood@dunelm.org.uk>
In-Reply-To: <08073d69-18f4-40c9-90a5-23db914c163e@gmail.com>
Cc: <git@vger.kernel.org>, <newren@gmail.com>, 
	<me@ttaylorr.com>, <gitster@pobox.com>
Subject: Re: [PATCH v2 4/8] sequencer: treat error reading HEAD as unborn branch
Message-ID: <17b666ca6c4b7561.70b1dd9aae081c6e.203dcd72f6563036@zivdesk>
Date: Fri, 23 Feb 2024 05:28:48 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 22, 2024 at 10:34=E2=80=AFAM <phillip.wood123@gmail.com> wrote:

>>   static int is_index_unchanged(struct repository *r)
>>   {
>> -	struct object_id head_oid, *cache_tree_oid;
>> +	struct object_id head_oid, *cache_tree_oid, head_tree_oid;
>=20
> I think we can make `head_tree_oid` a pointer like cache_tree_oid and=20
> avoid de-referencing `the_hash_algo->empty_tree` and the return value of=
=20
> `get_commit_tree_oid()`. I think the only reason to copy it would be if=20
> the underlying object had a shorter lifetime than `head_tree_oid` but I=20
> don't think that's the case.

Makes sense -- I'll update this in v3.

>> +test_expect_success 'cherry-pick on unborn branch with --allow-empty' '
>> +	git checkout main &&
>=20
> I'm a bit confused by this - are we already on the branch "unborn" and=20
> so need to move away from it to delete it?

Yes, the previous test leaves us on that branch. In v3, I will update
this to instead just use `git checkout --detach`, as that does seem a
little less confusing than switching to some other branch that is only
relevant because it's not `unborn`. If there is a cleaner way to do
this, I'd be happy to switch to it.

>> +	git branch -D unborn &&
>> +	git checkout --orphan unborn &&
>> +	git rm --cached -r . &&
>> +	rm -rf * &&
>=20
> "git switch --orphan" leaves us with an empty index and working copy=20
> without having to remove the files ourselves.

Thanks for pointing this out. Using git-switch(1) here instead of
git-checkout(1) allows us to drop the `rm -rf *` call form both the
existing 'cherry-pick on unborn branch' test as well as my new test. It
appears that the `git rm --cached -r .` call is still necessary in the
existing test.

>> +	git cherry-pick initial --allow-empty &&
>> +	git diff --quiet initial &&
>
> I'd drop "--quiet" here as it makes debugging easier if we can see the=20
> diff if the test fails.

This makes sense. In v3, I will update this new test as well as the
existing test to not use `--quiet`.

Combining the above suggestions, here's the version of the existing and
new tests that I intend to use in v3. Let me know if this isn't what you
had in mind!

    test_expect_success 'cherry-pick on unborn branch' '
    	git switch --orphan unborn &&
    	git rm --cached -r . &&
    	git cherry-pick initial &&
    	git diff initial &&
    	test_cmp_rev ! initial HEAD
    '
   =20
    test_expect_success 'cherry-pick on unborn branch with --allow-empty' '
    	git checkout --detach &&
    	git branch -D unborn &&
    	git switch --orphan unborn &&
    	git cherry-pick initial --allow-empty &&
    	git diff initial &&
    	test_cmp_rev ! initial HEAD
    '

--=20
Thank you,
Brian Lyles
