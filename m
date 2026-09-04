Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03324423A66
	for <git@vger.kernel.org>; Fri,  4 Sep 2026 22:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788560890; cv=pass; b=Cw2LkbL1gvliLvh/BXTpV4j75zFZ1lWtyMbnJQ3x60uhb1GRyLBuBgHdKg5MNGclKdCnZ4uwgTCIL567Riud/ZN1/jCua0ksA1mcEDRxHCujN16SbVwBHpynOQkok/VTZMG7YtYtMJS+NBaMhy3B/8rVLzd4Lf6HtiXsdCLtehM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788560890; c=relaxed/simple;
	bh=z4gP4RuQJbvEvtRuApO+RfylnaiAeik1J2sPdKXuo2A=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GrF/4cO63lFY1E0yHfu4pqAV/3xp1zWcBARsPFlLNgua3cqSk+nYnxcUxXSEzhhvJzskgAcQQiTOc6I+j4iNw1knlv/DHncPrqYrsaiqGlGxBRlePbZw770fEV8uYelJ28dKwXcAAaW4RSsxpn6JwNrxGiMUUTJlg+KcjgIVQMU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fJe264DU; arc=pass smtp.client-ip=209.85.217.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fJe264DU"
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-782df51b4c1so1160204137.3
        for <git@vger.kernel.org>; Fri, 04 Sep 2026 15:28:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788560888; cv=none;
        d=google.com; s=arc-20260327;
        b=DzUQF+++tsS1yvJeexzEKG6LtY/HsQKh5rHEa3FX8yZIQ6eXABzn1eK0OdRpFqN0en
         /5WK243eqOCeCaDnx/Fa40REbglzEzUcKozTLFhfLjZIgrRBUj2OU+R1fG7ztt5c7mz/
         Yn3rAKgKBwmRXa2A6a0lpyWHGu36QxxtdUML6WSrRSCfzFVK9ek269xAFSUuG3bjiHP0
         KmYW302CRn2VvdZaRAfiU04xsj5rFAQBV6rkLB1V1hEptOqSjOzYjwQwwIlMiIAdw2YC
         DLArkTVWWmUxUMY0Nc3Mqt1TfnKCu7sCXRTOTkfIDeifhJGF/3KW8vS1doGsw187ZE+n
         GDiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=z4gP4RuQJbvEvtRuApO+RfylnaiAeik1J2sPdKXuo2A=;
        fh=9BsKQlvaannSBUTFslioMsfMlt3358bYk2KAh9y78Qs=;
        b=LSuoUCFHeZpZN3gs3oJYd/m515G62+Z/uIx82Gb1c1oEINVr5JBPKmlHM8cFQkYIEs
         2tmAWHwdMn9WW/XjXejMhf6y7YCpjiDbC8Hr8/Faynv8N/dsF0DEvHhVhA9t+6RS8fB5
         lX0S9clorMThzHHdomZF/0HLMU6eAHd0WXOmpFrIqtm2EzOXCWNRVigmr+0Vrrx4dQXm
         QMeX70At5zK8l3nwt9u1kIr07bBZw1zcGIQ4dXKGGgiWYjwmuNgc/NjodqCG94R9ETNs
         5vMMszbDg15No9ZByJShrlRFpuAvgzhTY4BWIDRvW2/cLGjYE334oFh08JyeIMycjXSz
         Ytcw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788560888; x=1789165688; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=z4gP4RuQJbvEvtRuApO+RfylnaiAeik1J2sPdKXuo2A=;
        b=fJe264DUPDhdR5d+n1XDNeV/0aV0PsyFsDqttRggpKgX9xm2fmTEu8mdahqtlyNlM6
         EUTBXAZhvuXm+cSlM5nl0yNFDzMW1pDhwb0TsgSvZ9AVlhcZ8eWU4oUlJFwS64ItyU9t
         FdOTGfu7zU7ZMt+TM2kKDhmBDuJ0N5aQm2R9qEdRugju/VizbHAHRS6lzKjLfxWRY2cJ
         lWzmgOH6AGhTjTL88X4U1+fTumgDSle5B5YPPf9vCl9wJqjDvcqy7ubDzFh1+EHN3e6C
         +J4lUtfesxmfhLRjZteaj/hIpxRcxalHFTWW0lJhKSVJBVKWWw30TqigFONEcN986MG4
         Hgeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788560888; x=1789165688;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=z4gP4RuQJbvEvtRuApO+RfylnaiAeik1J2sPdKXuo2A=;
        b=H9/09WrTt6saU8QkwdmbhyI4HJcZ/a1P+8fvWCHAChVMJUAZQQA41+JJoOlYh/Z4/p
         fvxGISNSEcEt66wl7ichoSv257epTmLImehux07+Qu1rBuyF5ftQpZNBPZ4H+RjprNgD
         Owfa+AZQ61G5O0OWmUj8BD2TzE2gKGbGbifZtBU+5pnh7MfuSSeRBz3XhUU+/RHIYunB
         Xb6xQNmf9h1a7s8k8l01ofxFHzjFLEyggIIN4lRFVjJ2U3hH/NLMab6/SIHkdhOFKHpx
         JmNSvx8L7D5I3Y5f9nAZAi0xcV4vfcnYSMVyKZ/jTISlfI5hJ++dOAWN1tSaq7/aIDDM
         73Fw==
X-Forwarded-Encrypted: i=1; AKwUvBya9TYc56YgSMidrylFa9KcXHG7ds33mu9AOiMESr2erAGxEm1UKCQ3+aQihPmMv/CBHP8=@vger.kernel.org
X-Gm-Message-State: AFuF++lDfYw37RSDdiPIAzZDl1qhJPLxSgMnKvnmQfYS6ySK17aA4JbD
	+/VR9QFnppm9DZ1agvPwbeEXcM028ibVB4Z6MDqG1g4kVkzMNbJNL5Y6IWiM70XZ33LhtbcfKC7
	vqQxDgt+lZC53cbFCUlhV+nAdQUP4axumlcxs
X-Gm-Gg: AYBFou3cFm9/yf/qND4bBChDh03aoyV3r9QOncM5T4uMJfLcEMvr7Rk8Mz4/ZDVNa0O
	0wdAZOP4nZD6UOBjwpNQAVQB9icEhlh3lW1Unu5YjBwnDOfcm5OZYxMqmWH/JxU+zfKcNl+TjgZ
	Lkquto12wUs0IhX+d6QJtz38Gr/QlEiCZqZl00rg7txgWbOPT0dnyGjw69WjzMlR9UO3XeQLxmG
	l8JIJSFrSBC5PkYOkI64nrNf+pnllmRiXUKh5AirgEIpRnbdHNdpx6I/IWAJK274Fg7D9H90jNd
	pLCGyygg/pAY+CCl/cmXs+fabsRDqAn1pfpSWy0kXGSCeJa3TGl1QBfGK2T3Ss37DolHWI7nxJi
	WSX0j00P7dKxoNw//OX5dp8StnkuiPmxijwU=
X-Received: by 2002:a05:6102:6447:b0:778:f972:32eb with SMTP id
 ada2fe7eead31-78a4aa9259cmr3805633137.12.1788560887785; Fri, 04 Sep 2026
 15:28:07 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 4 Sep 2026 15:28:07 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 4 Sep 2026 15:28:07 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20260902-pks-odb-registering-in-memory-sources-v2-2-c6ca12fdea4d@pks.im>
References: <20260902-pks-odb-registering-in-memory-sources-v2-0-c6ca12fdea4d@pks.im>
 <20260902-pks-odb-registering-in-memory-sources-v2-2-c6ca12fdea4d@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 4 Sep 2026 15:28:07 -0700
X-Gm-Features: AcwNN1VRQkXr-SLOTY2zIVEVz3DXtj0xB5dwox_qS1vP1p38BYeTferQSDCFFwI
Message-ID: <CAOLa=ZQ=oCDtjAQXNXe51DvKUCCk0CK1EuM+QKhJ3iH8YiS+mw@mail.gmail.com>
Subject: Re: [PATCH v2 02/13] cache-tree: remove dependency on `the_repository`
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
Content-Type: multipart/mixed; boundary="00000000000060656d065aafc863"

--00000000000060656d065aafc863
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> The "cache-tree" subsystem still depends on `the_repository`. Adapt it
> to instead use repositories provided via the context, either as a new
> parameter or the one passed in via `struct index_state`.
>
> Besides getting rid of `the_repository`, this also removes the last
> dependency on registering submodule sources with the main object
> database. When reading gitmodules from a submodule's index we implicitly
> read that object via `the_repository`'s object database, which is of
> course wrong. This works though because we would then register the
> submodule's object database with the main object database, but a later
> patch is going to get rid of that mechanism.
>
> You can verify that we indeed no longer depend on this mechanism by
> running tests with `GIT_TEST_FATAL_REGISTER_SUBMODULE_ODB=true`. Without
> this patch we fail in t1092, with this patch we never register submodule
> object databases anymore.
>

Interesting, to sum up if I understand correctly, somewhere in the call
chain of looking up the gitmodules from the submodules index, we end up
using 'the_repository' instead of the submodule's repo structure.

This is of course wrong, because we use the wrong repo, the consequence
is that the lookup fails, but we have a last ditch effort of adding all
submodules as alternates and retrying the object read, this succeeds.

So this patch fixes the repository being correctly passed down. Meaning
we no longer need to add the submodules as an alternate.

[snip]

The changes look good.

--00000000000060656d065aafc863
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 512a4c1e3859c397_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1xYlJmVVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNmRqREFDa1hQd1hEMzdHY1V3UnRtQzZEbkdwSHF6YwpPc2kzZEUydGM5
bHFyZWZ6aGRZNmRxVy93ditQajBiUnN5R0JMbGRIT0RxOUk3WVhBeEU4VWcwTVYzdDdPNjM4ClNx
QVl3bjNBVWlCQ3V5RlpyaFJxZm9uc1Z0N0dINVZJZkJnMElQV2EvL2p6Qk4rdXRmcEZreVFRT2Qr
MmhtbFIKWHZUWFdoMkxzYktoMG5vS0RHZ01vWU9FZHVrZXViSmJZRDZpZDJlVkRtaHVTYkdvaS8x
OEVVa21sb2FtRnc5SwoxZ1h0aFlQM2VhZnNITm9EQlhCdVdrZ0FwcDNTRXZMNm1qNGNER2ZhS285
bXl3OTlYNG4wbm1JT2pJUHpublYzClhZYUJ6bG5lVWxXdmhOMkt6M2RyNWhZL0tyRFZOR0Y3bjh1
aE1JQWlPOHpJMFBFaXgxVmlBaU93dGo1dWhNdUgKTWRWa09zY1NvSFArSmN6MGxHZlpQaEhGYjlP
cVlTN3c3N3JFTHVEbFVaREZ4b3Fhb2lScXYrV2JDaEloTDBWUApnYlBDWE8xdDNBV0hCRlZNUlR3
Z3RzVXRtQ3Z0czNOUEp1Sk03cGJRbCtxWDZIamc2Sm1JVTd3ZVVLUmJsV3BiCllUc04rZGRqelZX
YzhnMXdPd3VUUThSOWp4RUFYb1ZzR21iZWxFTT0KPXoxYXgKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000060656d065aafc863--
