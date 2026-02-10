Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A90F86323
	for <git@vger.kernel.org>; Tue, 10 Feb 2026 13:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770728534; cv=pass; b=kRbHG5njk3f4Ive8t/EVyJUuFVUbbdj1YLZd/ZbCXG0nsi4qkzWkcNol3ni7lSAYevhkxms8EIXJ5ECYraRYJ799N2PLL/twH5EYlKhf/XJoxTosf8VUZtW4oosTiP5VhHeOfrY4s1XJUziEWv/8mAR+4InH9JCxZ9AvRZmLQUs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770728534; c=relaxed/simple;
	bh=3IzYmjfFK4DTvgSnlSh9BGef4fVFbVmMszGShsH3p38=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iBEunWSr1z1bZch9ID0Pa2W885GlMlvUOPc0NCZpDWopcoVgqnfAlnlbwmfBF4TmUEjLbdCdW53vxLXCMOCB8XOcMJwcgZmmCoxKLto9Au7cvLnX7uu3mA0MKXm656pNvlGu2b27BpHGtJCymno0MZdEbrSlKf0VIZal3nX6nBE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EKRmgFB6; arc=pass smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EKRmgFB6"
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-56739adfa1aso644693e0c.0
        for <git@vger.kernel.org>; Tue, 10 Feb 2026 05:02:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770728532; cv=none;
        d=google.com; s=arc-20240605;
        b=UYgkIGZwUt/Nv67Qsc1Ebt8ItNFdYMLMAyc76Cb4DrBSXs0F50d0TF2bBCGayTfHQA
         GqF5bCl2vGzeQK4xPy71V4InYRb7ZWBZyj2rHLSyI37jIpHdBoaCpiMj92mToaFiQC13
         LDVooRrpE5pqd7lbDE6X6DUyN/XdGzT/qSFLMuN4VruXxfKKvRcaa0A9GjHOYce2vYT9
         ZA/fw7n/GF6hzV0l8/s/+F/US883CyZOBpwlmbKsV9SJX81brHU4QOC/8aEmQRADKBro
         5WRSno/EzTkz4WjdMqedVgNjwKDIjVMAxgtx8sC06rOOMLmFzOdvWXEaKLxz+nMSEK50
         jF+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=jHynIORT8c9945Ou7hvoJAuvQg0PlmMJXr3fXzRCHq8=;
        fh=ty73qu/mjp6olkAb0/G4VGZeH6SWOLNBs8YQa03/qaY=;
        b=Kqu33FFuMqDRWiaOP0yrEPVZc2mQGLrX8bc+VUe3IlnpvdkHHYWhYjovhZrz3mCTZP
         A70UZAxoMct2GRDu2/mRrBuBMRJAF7iaikcJIKZpRXlv6/yJzM1PQ6abHexbSlZqy913
         vYO85jdu9HBc6jXYU4WNGfR2mIYNnRcBFc6O13ktrBKupSyc3+xGun9FNebnbQvwSUKv
         qNDJ8Ia7Fej+LOD4EiiOxpQYhFPeUv9Mz8YKnUONumhyPFQTGMWpYYSWvQFojUuDTEo9
         fZkmg8mSWTtlb8xs7sRnGNVJadGL13hmzjrzS1njg0V+nIEAZpYpKaiZ8Qpv2/iWjoRL
         JeBQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770728532; x=1771333332; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=jHynIORT8c9945Ou7hvoJAuvQg0PlmMJXr3fXzRCHq8=;
        b=EKRmgFB6Vlmy7idN1rD7Civkh/aayQ1zCY3xGEOXLSBYXh6XVfMTLEo9XLUFhWh3dY
         Cq5BiVzxCwjkAUuuLg/1rWFVegzKpuwu9mVV/fw1itf6ox8OCgxBvxfL4TVq9aVn/5y4
         oifxFfwlktNvh+luSZFITTKL8hNP7dguaPV/tgDKIkbIfG9EwVTpmF5B4TjwJRToP0zT
         FdYApWUvggL9m/YylFxvoE8aCEzAY1HYNkEnSZE8tMQnC7e+muNGAMsLxhmR2e69WxH3
         gZ2Yfnbxg6iuLcwo0//DxM4XZjb/w3s7mITAF7SQCy90p/Ela7Sf2wklwTNzg2ddGE1S
         IRhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770728532; x=1771333332;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jHynIORT8c9945Ou7hvoJAuvQg0PlmMJXr3fXzRCHq8=;
        b=mlEekjHdVyxLkVBwXjv6vo8+YK9wEdiHauDq5BZdBC/fsuq7+DNhMlJg886U6GHhSN
         q5LCN7eLULj4SNhSvyznlI2MEMbOHN6jjJ1yKZAEPKirpICdOJXSELJhgvGNjeSl8goG
         gM90B0TLiCrc/HCJpl1YPMxClAVZkqh/ZGWnnpInRpnBfNbtGJuotcUDsNoPFxrwir5p
         0lpZWsg1bKLJctrOmt6R6cn5UD6Ne/Sm9CBUb/hmAVEqDG8tyIgZD1hvr6+G/Sj7l2K4
         LXruAl2m5aKvW8HEWeAAu2WhcOu5pZAzoMrRvHtpA7OCC0CSBtwMNxV/cDVvhd/KSe5I
         Od4Q==
X-Gm-Message-State: AOJu0Yx5+j/BBIksRFTObqVB6TX+MGFjTlzCXELOJuwvsKYsZn3ac0Eb
	0XhOrRtG8bfQqBPN0F05kA+W3aezMaIJTwntZTdhy6WpYGQQMfExWOw/P7Fe7dUSplilIARw8mi
	kjCOaeMCcbhXTvfl2d0KIPlRNb1+Fzf8=
X-Gm-Gg: AZuq6aLYPm5dgRbXhIcW4tc1PpuyVMVkpSZkN/B9yye56RVMfhilLEKKs499xnJ2O1k
	XrWT7K0EbO7B0bRDVJ6XrGkIPdk67Fji06nNsf+YXy6PoUICURbzLpzzZo2xE3sdWgp3nFkPNiu
	aF/OxJ2nb2SO7f0mVzw1uOmgaFiKu3XYPcjM/4f4QZorG8Q7EegXqJo5UTcXTmeeSWJaJ3Tx65i
	QyqdXPNRSmjg3WoKLqHpBK5fwzb2pawKhieIdKbbZb0jByy4o0/cBZOKEpoggoLDOP9K0Gd6K0J
	kxqXVvm+BCxAVVLmsG3DO47xXC2PLghkTj4Ygss+gQ==
X-Received: by 2002:a05:6122:3b09:b0:559:79d8:27a5 with SMTP id
 71dfb90a1353d-5673d7c13a1mr421505e0c.0.1770728532118; Tue, 10 Feb 2026
 05:02:12 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 10 Feb 2026 05:02:10 -0800
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 10 Feb 2026 05:02:10 -0800
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <aYoMk5HmpSyN1azt@pks.im>
References: <20260209-kn-alternate-ref-dir-v5-0-740899834ceb@gmail.com>
 <20260209-kn-alternate-ref-dir-v5-3-740899834ceb@gmail.com> <aYoMk5HmpSyN1azt@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 10 Feb 2026 05:02:10 -0800
X-Gm-Features: AZwV_Qg2t4O8oXFZu1jO1cWq9axA2qLC1NFP3piojpTpvC83ii-Rk4V4_ux6Oug
Message-ID: <CAOLa=ZRU5Bv6oAUmRkBY-sar2UskPfmJNehUjyMtKJOS4s9S9g@mail.gmail.com>
Subject: Re: [PATCH v5 3/4] refs: allow reference location in refstorage config
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, =?UTF-8?Q?Jean=2DNo=C3=ABl_Avila?= <jn.avila@free.fr>, 
	gitster@pobox.com
Content-Type: multipart/mixed; boundary="00000000000026b267064a77dd76"

--00000000000026b267064a77dd76
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> On Mon, Feb 09, 2026 at 04:58:20PM +0100, Karthik Nayak wrote:
>> The 'extensions.refStorage' config is used to specify the reference
>> backend for a given repository. Both the 'files' and 'reftable' backends
>> utilize the $GIT_DIR as the reference folder by default in
>> `get_main_ref_store()`.
>>
>> Since the reference backends are pluggable, this means that they could
>> work with out-of-tree reference directories too. Extend the 'refStorage'
>> config to also support taking an URI input, where users can specify the
>> reference backend and the location.
>>
>> Add the required changes to obtain and propagate this value to the
>> individual backends also add the necessary documentation and tests.
>
> This reads as if this should have been two sentences.

Yeah, let me split it up.

>
>> diff --git a/builtin/worktree.c b/builtin/worktree.c
>> index fbdaf2eb2e..94480be5c4 100644
>> --- a/builtin/worktree.c
>> +++ b/builtin/worktree.c
>> @@ -425,6 +425,39 @@ static int make_worktree_orphan(const char * ref, const struct add_opts *opts,
>>  	return run_command(&cp);
>>  }
>>
>> +/*
>> + * References for worktress are generally stored in '$GIT_DIR/worktrees/<wt_id>'.
>
> s/worktress/worktrees/
>

Oops.


>> +for to_format in $ref_formats
>> +do
>> +	if test "$from_format" = "$to_format"
>> +	then
>> +		continue
>> +	fi
>> +
>> +
>> +	for dir in "$(pwd)/repo/.git" "./"
>
> As "./" is a relative directory I expect it to be resolved relative to
> "$GIT_DIR", right?

Yup the './' is relative to the '$GIT_DIR'. It can be changed to '.', so
I'll do that and add a comment. So we do both

  BACKEND_PATH='/home/karthik/code/git/build/test-output/trash
directory.t1423-ref-backend/repo/.git/ref_migration.ZnKNpg'

and

  BACKEND_PATH=./ref_migration.BFyK5k

> Also, I don't see any tests that create the ref
> directory outside of the repository. Should we maybe add one?

Yeah, let me add that test.

>> +	do
>> +
>> +		test_expect_success "$read from $to_format backend, $dir dir" '
>> +			test_when_finished "rm -rf repo" &&
>> +			git init --ref-format=$from_format repo &&
>> +			(
>> +				cd repo &&
>> +				test_commit 1 &&
>> +				test_commit 2 &&
>> +				test_commit 3 &&
>> +
>> +				git refs migrate --dry-run --ref-format=$to_format >out &&
>
> Okay, we do the migration, but with "--dry-run". This should result in a
> temporary staging directory, which is in fact somewhat interesting given
> that "to_format" can now contain a payload. I assume it wouldn't have an
> impact if such a payload was set here?
>

It cannot, the 'git refs migrate' command parses the argument provided
to '--ref-format' as a reference-backend.

>> +				BACKEND_PATH="$dir/$(sed "s/.* ${SQ}.git\/\(.*\)${SQ}/\1/" out)" &&
>
> Hm. I have no idea what this is doing :)
>

It extracts out the name of the dry-run folder created by 'git refs
migrate'. We append the $dir to it, which could be the absolute path or
the relative path.

>> +				test_refs_backend . $from_format "$to_format://$BACKEND_PATH" "$method"
>> +			)
>> +		'
>
> In general I think it would be sensible to also have a couple tests here
> that exercise specific formats directly. Like:
>
>   - Are the files created in the right spots for the files and reftable
>     backend with a specific backend?
>
>   - Does `git refs migrate` know to write the files into the correct
>     location in case "--dry-run" wasn't passed?
>

Will add tests for the following too.

>   - Does git-init(1) and git-clone(1) initialize the refstore in a
>     different location as expected?
>

Well so this only works when there is a reference store already
existing. I thought I had explicitly called this out, but doesn't seem
to be the case. I think it would actually make sense that it also works
with creation. So let me look into that.

>   - Does creating a worktree work?
>

This is currently already tested.

> Patrick

--00000000000026b267064a77dd76
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: cd669f1e76fbd89b_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1tTExGQVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mdzFOQy85WGJRdGpVdnBUZEJaZExjZ0NZeXUxR2IwQgpZd25RRVJLYStp
clJXSWNHaTU0ZUlMUktod1RDZjRaYVNWeTRqckk5a1I2bllpb3hPaE8wazE4VGhvbFkyeGxKCnBX
NmxHZ29MVkZXbmZBSGxkSnNpYWhRZjExdHNOaGVpTUcyYXRITEJCdnoxUmlUYXJ6eklqZk9NOWVr
N0tJQkwKZlJRRTlqWElLUHlWR2JRc0NFamVzTzg2SU5MbXNiaCtqUXRJY1FMVGl1eE5HNi8zRmhm
b1hhQllhcTF6NkJZagpTRkVVTytaV0ZmUGd5c2k2bG5BazVqUUkvYnYrNnB6cy9BeFQ0dGRkeCtp
dkF1VW8wT04yL1RiQUJrRmVjaFZMCjZCd3loZFVRSUxxVHJVUmd1SW9IbS9hM3pHT2NLdDZXaCtS
R21nMUlsNE5DZlAyaWVSWk5ZSjZUV0RNbGdYQloKN3RwakljRjJjcEdlY20ycG8xU3U3T0lCcTN2
Vy9IZ1RUMFNSVGlnQTVkOFkxL3lrbGtBWm1ubU8xWDJISEFOcApRU1VlWUVkMW43SmVvcVNJUjN4
c0hidXJ6eWNFblpYMHVsM3pSZnhzTWExNjRHWHBmcEJiVSt0RHN6VDYwczdZCjUwcW40b3d4MHcw
T1diRHppNWxWYXQrZ1BPY3JmTDRLZm9TNWI3cz0KPWh3aFkKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000026b267064a77dd76--
