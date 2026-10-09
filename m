Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 710CC4DA9D8
	for <git@vger.kernel.org>; Fri,  9 Oct 2026 13:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791552573; cv=none; b=aCLG/hBDDkQ+tr8MBuN1wa2dCLhY7KTKOZNepi0qKT3mt8JqWw+taNk5kohMtbLfJDEJi9Y+kvoV70A3xHZgQeAS2e7PoaZSgFAx3qSv7JRdMX9OxX7EQQcCBpdmQSjCgRZ4pT1WEv4Q8kpYuT2P17GK+7/8jK/D+qSu0MZ6W3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791552573; c=relaxed/simple;
	bh=LYakip4Du2cIJrUq5GtEF2Aee8wKjA1+tKl31BKOli4=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:References:Cc:
	 In-Reply-To:Content-Type; b=Lc/s4HNMZp8+j2ExgfuZc6TU6yZQzdrPVr2hGjA4PZeWlLgECYQyHiSY0mlJyiRn6yGv+wAOBIc9uvNaskosWWwCb8hI3XOWzhmZ3D5NIosHbfK6Npn2znCqgXcZyXisMbGlHylO93svC50Ui5/eQOTsvtemInkGlcMBCOsLm+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p6dHTAce; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p6dHTAce"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-48afe0081a6so2089760f8f.2
        for <git@vger.kernel.org>; Fri, 09 Oct 2026 06:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791552570; x=1792157370; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:cc
         :content-language:references:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=QkvkajTxbNXdwX9Q+ZA74Y02b/rtIbbSHBmd0YKjvDc=;
        b=p6dHTAcemTd29CoUCRaYEOZo6LOt4KD7PE8rEwt7gFrNp4di5BUKkN7s0WEU0Na9Z4
         3gnQ1QVIWyweUNmlXjBCahJRyyz/Th8HZ3pGFqVEY5AsjZIFe0mghFulTV/EG8mKvL1g
         91r+z+/Rven5U6Cvl9hDX7vE/VHd9hMjZNWgQZyxqwqC7JdmZXHA5nWVeGb81cMsyaUT
         dCNSBWtC3OzrRcEXIGZcq124JzIfDr4T7yFe1qf2/jxuBe/oqGdGWHEU5fqf2tuT1lzh
         6d4dZfjAeSNqv3Dm+nZh22C1L452cx+6Nx8O6N+8CmqF9dgy4X7Qpvx4hCdT4pVKb6Ij
         ZkCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791552570; x=1792157370;
        h=content-transfer-encoding:content-type:in-reply-to:cc
         :content-language:references:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=QkvkajTxbNXdwX9Q+ZA74Y02b/rtIbbSHBmd0YKjvDc=;
        b=uhLo7gSYFWUi9oTg1rYzgFeszTz+qILkAIxns/BEsYb0kdBrSjg7pQz1npG6Dcx4Yv
         bEWGNoTeRiRpztsCojTlOzCniO3Qw1VHZ+sCyR/OvSw/x0YVGPOL5XbqomEG9b3hVX95
         hehC8trvbPYZESxUbgw9jY2eVxWZHVE+Ue1b40R3zjZFWNqP++0sxyL1ZrB3n38BlSBc
         BiIUVh9Q/DQoU+6N5g63a8mpE2+2M+QbbzID86iL5cXLHnQjMK6t1chqnMyRR0Rk7iGD
         UfLfhVDJGpukd/+q6qZThmIAIdZNrOwbR+1TswnswzTSz+nFhGuzv+twGd9Dml5m81hX
         IcmQ==
X-Forwarded-Encrypted: i=1; AKwUvBzi6Vv5Y2upgOafvbMoxRpz6KTuNemFNAyHBso0MPzE7Ha6/Aoa9+XXXhyHNyFKoLL9XbU=@vger.kernel.org
X-Gm-Message-State: AFq9FYKW19+Y63VvvChXJIEpWiRODoH7lYjJuTsO/m7sKOUhK4V60Ls9
	t9NrFmWmoklsjZuFd6adRVo23dfSaiZACjQl6cCecZDqjnp6dYVgrrls
X-Gm-Gg: AYBFou1gabUHsVl+PmU3DBGvWDUjncQDKi2iANTDjRaa3Ac5qNsJFUtgOPU0d5qawkZ
	xHdeGncm7Q0ZtWd7fUExMvRTHJNK2xwUhFBpBGTuZai+Eud0i38OeZkQrGyAJcCAGK9ma29/TS6
	wqY+xLVTEc6W6zD3QJvK4uxN0b4CWR6NUpAKJxbFjoJILLumOPhfzMuCLRb8qi2O4K5kl641JhQ
	7rc9HNtlIksrpuyrfoHPG781SiCIQAyVKS5EWOS/NQl2DBY7b/rGY6uyo2BhZI0y+umaNu6Eb07
	sl1Ygd8thigh9Yno150Tg23p2LHlmaXdsSBn6KHf79sT4ANvpG9FAB29r7ZMXwbjNTY0EGm4l1+
	o5rYgk9k3MIOt4wOqvh7T3XikZce+bO2blXg31yOp2+1N9H4tSr49Zwgy09tsGMfU4sJqewnFYe
	aPJXkL6+0F00WAUV+H6aIHGs3g8zCHPKgNof5i5fPCALFxCN+5elcp7Cd3DMuexWPAXrJs0kvhb
	xKM0H21EDd3SD3cGCYqESPnJIDMtYI8qxg6G2jg6hWDCyH5z3jg+rTSWFHCJIo=
X-Received: by 2002:a5d:5e8e:0:b0:48b:1e7:aeb4 with SMTP id ffacd0b85a97d-48dbace16f8mr3398211f8f.41.1791552569137;
        Fri, 09 Oct 2026 06:29:29 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f? ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48db946323bsm4733302f8f.2.2026.10.09.06.29.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Oct 2026 06:29:28 -0700 (PDT)
Message-ID: <6e921d1d-b7d8-4f42-add3-67931e4ffba8@gmail.com>
Date: Fri, 9 Oct 2026 14:29:27 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: ssh signing: valid-before is checked at the signer's own date,
 and a missing revocationFile fails open
To: =?UTF-8?Q?Christian_No=C3=A9_Ramos_L=C3=B3pez?=
 <chris@nortesoftware.dev>, phillip.wood@dunelm.org.uk
References: <CAHGSfbZ_Q8Ujt3om0POapkjWZed1pZVUrB-mV-e+UjmPgCNvWQ@mail.gmail.com>
 <ec4de165-c7d1-43d9-979b-08c1cb67022d@gmail.com>
 <CAHGSfba9Td+Lg=Nf+nfwZY2r1_eq2Mcejn__6X=VPQkmcJttfQ@mail.gmail.com>
Content-Language: en-US
Cc: Patrick Steinhardt <ps@pks.im>, Git Mailing List <git@vger.kernel.org>
In-Reply-To: <CAHGSfba9Td+Lg=Nf+nfwZY2r1_eq2Mcejn__6X=VPQkmcJttfQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Chirstian

I've add back the the mailing list cc so others can comment as well.

On 08/10/2026 20:40, Christian Noé Ramos López wrote:
> 
>> Having waded through this here is a human readable summary:
> 
> Fair -- your summary is the shape I should have sent. Next time.
> 
> (1) You are right, and I did not test it. gpg takes the signature's own
> creation time, so a manipulated clock moves that too. What I measured is
> narrower: backdating the committer and author dates does not move it --
> ssh-backdated is accepted, gpg-backdated is refused. A difference in cost,
> not in kind.
> 
> So the wording should say two things: that the time compared against
> valid-before comes from the commit, and that a signature timestamp is not
> evidence of when the signing happened. That covers both backends. I will
> send that patch.

That sounds sensible - a valid signature doesn't tell us anything about 
when the commit was signed.

> (2) One thing before I write it. Failing closed changes behaviour for
> anyone whose configured path is already wrong, from a warning to a failed
> verification. I think that is the right trade, but it is a behaviour
> change and not only a fix. There is no test for gpg.ssh.revocationFile
> today, so the patch should add one either way.

A test would be very welcome. Patrick had a good suggestion for allowing 
the path to be optional if the user wanted.

Thanks

Phillip

> Christian Ramos
> Norte Software
> chris@nortesoftware.dev
> 
> 
> El jue, 8 oct 2026 a la(s) 7:42 a.m., Phillip Wood
> (phillip.wood123@gmail.com) escribió:
>>
>> Hi Christian
>>
>> Having waded through this here is a human readable summary:
>>
>> (1) Our documentation implies that we check the expiry date of the key
>> (which is recorded in the allowed signers file) against the date the
>> commit was signed, but we actually use the committer date which can
>> easily be faked.
>>
>> (2) If the revocation file does not exist we print a warning rather than
>> failing the operation like the gpg backend does.
>>
>> For (1) I'd be happy to see a patch that tightens the wording, but we
>> should also note that the timestamp in the gpg signature can also be faked.
>>
>> For (2) I agree failing seems like the safer option.
>>
>> Thanks
>>
>> Phillip
>>
>> On 08/10/2026 07:56, Christian Noé Ramos López wrote:
>>> Two things that, together, mean an SSH signing key cannot be reliably
>>> stopped from being trusted. git 2.47.3, OpenSSH 10.0p2, Debian 13;
>>> source read at v2.47.3 and at master (c46c1e37724f).
>>>
>>> 1. valid-before is checked at a date the signer writes.
>>>
>>> SSH signatures carry no time of their own, so git passes -Overify-time
>>> from the committer or tagger line (gpg-interface.c,
>>> parse_payload_metadata). alice's key is in the allowed signers file
>>> with valid-before="20260101":
>>>
>>>       ssh-old        %G?=G 2025-06-01 12:00:00 +0000 verify-commit=0 merge=0
>>>       ssh-backdated  %G?=G 2025-06-01 12:00:00 +0000 verify-commit=0 merge=0
>>>       ssh-honest     %G?=U 2026-10-08 02:15:15 -0400 verify-commit=1 merge=128
>>>
>>> ssh-backdated was signed today, with only the committer and author
>>> dates set to 2025-06-01. Nothing distinguishes it from ssh-old except
>>> when it was made, which only its author knows. ssh-honest, signed and
>>> dated today, is refused: "key has expired: verify time ... >
>>> valid-before 2026-01-01T00:00:00".
>>>
>>> The GPG backend refuses both:
>>>
>>>       gpg-old        %G?=Y verify-commit=1 merge=128
>>>       gpg-backdated  %G?=Y verify-commit=1 merge=128
>>>
>>> The documentation for gpg.ssh.allowedSignersFile says "Git will mark
>>> signatures as valid if the signing key was valid at the time of the
>>> signature's creation", which is the intent, but does not say the time
>>> comes from the commit. So valid-before rotates a key; it does not
>>> retire one.
>>>
>>> 2. A configured revocation file that does not exist fails open.
>>>
>>> gpg-interface.c:568-574 at v2.47.3 (579-586 at master): if the
>>> revocation file exists, pass -r; otherwise warn and verify without it.
>>> The same file, present and listing alice's key, refuses:
>>>
>>>       S2-revoked       %G?=B verify-commit=1 merged=no
>>>       S3-revfile-gone  %G?=G verify-commit=0 merged=yes
>>>                        warning: ssh signing revocation file configured
>>> but not found
>>>
>>> S3 merged under `git merge --ff-only --verify-signatures`. An
>>> unreadable file and a directory both fail closed:
>>>
>>>       S4-revfile-0000  %G?=B verify-commit=1 merged=no
>>>       S6-revfile-dir   %G?=B verify-commit=1 merged=no
>>>
>>> ssh-keygen, given the same missing path, refuses: exit 255, "Could not
>>> verify signature". git avoids that by not passing -r. OpenSSH's
>>> RevokedKeys says, in sshd_config(5), "Note that if this file is not
>>> readable, then public key authentication will be refused for all
>>> users."
>>>
>>> No test in git exercises gpg.ssh.revocationFile; it appears only in
>>> Documentation/config/gpg.adoc and gpg-interface.c.
>>>
>>> Controls for both runs, fixed beforehand: a good signature gives G and
>>> merges; an unsigned commit gives N and is refused; the revocation file
>>> present and listing the key gives B and is refused; a commit with its
>>> message changed and the signature kept gives B and is refused.
>>>
>>> Together: the two ways to stop trusting an SSH signing key are
>>> valid-before, which the signer can date around, and revocationFile,
>>> which does nothing if its path is wrong. Either would be enough on its
>>> own if it held.
>>>
>>> What I would ask for: refuse when the revocation file is configured and
>>> missing, as ssh-keygen and sshd do, or say in the documentation that it
>>> is ignored; and say, under valid-before, where the time compared
>>> against it comes from.
>>>
>>> On prior art: the ssh signing series (Fabian Stelzer, 2021) carried the
>>> warning from before v4, and the review raised the config name's case,
>>> not what a missing file should do. The key-lifetime series (RFC
>>> 2021-10-15 to v6 2021-12-09) passes the commit date to the check, and
>>> the replies are about style. The N for an unconfigured allowed signers
>>> file is already on the list (Grayson Tinker, 2026-06-25) and is not
>>> part of this.
>>>
>>> Christian Ramos
>>> Norte Software
>>> chris@nortesoftware.dev
>>
> 
> 

