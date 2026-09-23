Received: from mail-dy2-f12.google.com (mail-dy2-f12.google.com [74.125.229.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C76993C1D75
	for <git@vger.kernel.org>; Wed, 23 Sep 2026 08:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.229.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790151036; cv=pass; b=XHkbpXdueoH4YRcJIlb/l4dVhumUZl2vLojgn2XWALEtoh4HT8J0YUGKkYw6t/oVf3M8CNUtlkNyaoEy+WcT4yYFld9AzZhlVcbY8oL71+YLNIsdJYPWjfQeGP8Sw7VPMgC4Rsahe3QJ75UCopmDCRW9IM06plO62N3LNNJmjaY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790151036; c=relaxed/simple;
	bh=397X/FMBp37g1ckrGf+AQH9rF7lZy2kYrwt7G+8GgfI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ygj/eZFpqoyeoS3HCulcWRW6p5ggKtFGoF6OzHsq/tSXXYT2gy3xfoMhwPK9zzSNksXlUVbXkImSeAcTRjuy1bj9sCyKFd2GwpAmKq1z+acU0Cg2g404V7kDkMuJC1iQB/TZHS8XwI59xtxOcqTLbMsHn+o0ARCmQYu4HBBEdts=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pqdbJxqB; arc=pass smtp.client-ip=74.125.229.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pqdbJxqB"
Received: by mail-dy2-f12.google.com with SMTP id 5a478bee46e88-328664e061cso667307eec.2
        for <git@vger.kernel.org>; Wed, 23 Sep 2026 01:10:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790151034; cv=none;
        d=google.com; s=arc-20260327;
        b=Bw4EU2TKtfkXR2FaXUjJk/x8MvDNuaurlf4TXJvOgt/hBalHEdigRTGyjwCLYx300d
         R3d685DppVesu6PwORm04gElbz2OR2L2QRMcVBJ0mDpCjdEY8FDXT5gtBAg1QNdXNCgI
         sRJh1hGAU3wTkIclc+6332xiJrejkvFHwGeF8cfMYtbXUORhbwZMTDiKX7Ha+xLvltu7
         S2aC8oTQOR10xNiawARAydEm9nCLDyNBb/dwmxp77lJZ19sm9kLMXr40zIr1TIzamY+a
         JEBRgDQtGbp8e+Itcb3a1JzDZPee3c57eEwZYlklXzZvNKj119Jd41v8wnwxMcG3Ul/f
         GcNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Ah/VgcjMCFY8nPhIPRwtAnHrQPeXOIk9jybMwg9I9vc=;
        fh=xgj+vSGq/gGUery/oIClRsu4cMrai2x0EL1nksSCsY4=;
        b=avqu9gKGAKbGLXUMS9L0Tms/lrGnli/7lP0IzbWfiuME1rl76jFBbUPiWvcliXPO7y
         16S/cTbLsjRUKSgLGPtSgjfxuKzJrlgc1I+g51o72HNhGZEWh2MyPHjCc4xtBDtbitEf
         aUiPBBHEzMl+MTZXpq7xNjV3DigTD6bSkgIcfKhXmB0w850jM7y0ljr5sk6rHo6+eEWI
         TVPCaq2gmIze0kBLYaXc3SA5BwUeRPJAT6VQzGvpe4ZTlSAPpuBypW9mzwlz2j8BOHmu
         DDjcjaqEF/9VAl1jIgKz4lZSeTeDQkUs2ywprST81gSAldCIV6RwtqF6d908BvjB/q57
         HIRQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790151034; x=1790755834; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Ah/VgcjMCFY8nPhIPRwtAnHrQPeXOIk9jybMwg9I9vc=;
        b=pqdbJxqB7ZrtQcOVE+wieP6zrTLZ4zr9GsENczRYpX5MUFL8UJdb1Fd1ODR1taVDLY
         uMnxIRZbifGV0OszyQMAMuoa73knDmIutRL1U9kzTeDbmuwUwsxi7e3pHnMZlLOAOR9G
         BSWaeJJDcG3P8rb7KidZlmuFWEH1xkmfw1U7qMENRw4m0/4TFMCOPYEYlKrQL2h7A7fA
         O1RK4DCgizHcVS/DI357yVedCCFBGUPT4BoFy1RJ3eMcqT7QntNnGqnq+2U0kqNbLRk6
         SbiijIf5pYP+XuzM9z+PPdw4kxsKB34lU50IlxPL6hZ9SwDE20Vy+RsWTTl3PUo8FPpC
         pd9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790151034; x=1790755834;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ah/VgcjMCFY8nPhIPRwtAnHrQPeXOIk9jybMwg9I9vc=;
        b=Sp0Vv4UhDLOgQ3MVeoflzcGlm5a98JU6uiL0UlN2AX1yhPwmIpiCgMt2sMLMbJSKie
         F3LFAPVkt3bYpr1lb9yJjZXsV5kL/RauDw/FIeqACNt4Y5ss/yCm+aP5F08LTKnxeVqV
         kWP+mB30XANyjcEYuqACF6Mjsqso56e250MJv/kLj0CRgEvFE6Tb6QyuYPFhZf/Af6IH
         9t08x+O8ukN1e8rYlE87KX2+Eh66RDqo00m3/5ZMhPIT+La/BS2o0yZwRbi1wKbxwktQ
         31nyDbm8GT6bPvzYAQxtt2WtnJ741kwQMhlwU+SBNr5ZAZ6qubWSKcPALoJm0Csl3OqA
         fD5w==
X-Gm-Message-State: AFuF++lmYqCvkQlqXR4YZPBeS5dEV2/AMIgfCulySb7kZ/5gN4WmmE3w
	47d6zObe5Dxv4UIvs1//wEHV1R3JbXJdlBXpOStffaDk21qO007/lwskTbWrjO0OrcodH960PBi
	NY2HbpE29sZbZJzxcAJVSyeUE3krJauVdCCkq1zI=
X-Gm-Gg: AYBFou08hadq0802dlX32Bz3ISraoy6gcWO1sChqIh1F6MiApBPDzKGGB/YYKOrxUE5
	5kon0fkhwb3JZ4Su1FtObsakd4bIamPqCx1RmX6JztgfhHKNkWKBLv7qmv1SKnTjCAZQcblU2h/
	aFpfZN9Eg+wvN2QJ3arTPOyS1s1x9ifRlmIHGJq4HUbANe1QFmREsq+v9a+BsqvKOBarXivpVVZ
	XML+E5s91tnw9tusxNOccTb8h3mg/68rgFosjejIzoaxFF426guD621oxXo8sP100Qkb0nXwNsM
	NmUr62OSg2vGS8PSBdUgs0rczUK9uiZKpIZcO8OMVGSS+J2xYs1pWJtM0dg1WX93THaauir45V1
	yuLEDl0Q3qa+9XsWqLcR/Li0jLwYo6LCc1lB1KPkyZ3woXhMHHZze6EDGMvGAbTfwQs9ZLdPvhi
	EMMh3S4JU6ROM9p/MRzxncVxcxAFXAJ1ZUVMF3C+U=
X-Received: by 2002:a05:701b:4654:b0:13d:974:a42d with SMTP id
 a92af1059eb24-144f92e39b8mr1960643c88.22.1790151033548; Wed, 23 Sep 2026
 01:10:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260902161047.476753-1-christian.couder@gmail.com> <xmqqpkyviizc.fsf@gitster.g>
In-Reply-To: <xmqqpkyviizc.fsf@gitster.g>
From: Christian Couder <christian.couder@gmail.com>
Date: Wed, 23 Sep 2026 10:10:22 +0200
X-Gm-Features: AclHuK-u5egBUQ_2VAgcOYxBaoqgXaJ9JT-VLuL8D61uZROMhXJzStz5cmTat2E
Message-ID: <CAP8UFD3qUpjUayhkMumZ41iMut=1=Pcmzx1YYcEV9NMG18OPsw@mail.gmail.com>
Subject: Re: [PATCH 0/6] Standardize early option scanning to fix argument
 parsing bugs
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>, Elijah Newren <newren@gmail.com>, 
	Jeff King <peff@peff.net>, "brian m . carlson" <sandals@crustytoothpaste.net>, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>, Justin Tobler <jltobler@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 2, 2026 at 8:52=E2=80=AFPM Junio C Hamano <gitster@pobox.com> w=
rote:
>
> Christian Couder <christian.couder@gmail.com> writes:

> > To allow these commands to safely skip option values during their
> > early scans, this series introduces a new "early-scan" sub-API into
> > the existing "parse-options" API.
>
> Yay.
>
> > This is deliberately implemented as a new simple and fast scan, which
> > has some limitations, instead of a full refactor and reuse of the
> > parse_options() code,
>
> Sigh.  In other words, we hate these ad-hoc prescan that are buggy
> badly enough to replace them all with yet another ad-hoc prescan
> that is know to behave differently from the real thing?

Yes, because the limitations of the new scan are not very significant
in practice while refactoring the real thing (so that it can perform
an early scan without side effects) would be much more complex.

> >  - `git bisect start --term-good -- <not-a-rev>` mistook the term name
> >    `--` for the revision/path separator, so <not-a-rev> was rejected
> >    as an invalid revision instead of being treated as a path.
>
> Sorry, I fail to see much practical value in this.
>
> >  - `git rev-parse --default -- <not-a-rev>` did the same, reporting
> >    "bad revision <notarev>" while any other default value gives the
> >    usual more helpful "ambiguous argument" error.
>
> Neither in this one.

I have removed those from the series in the v2 I just sent.

> >  - `git fast-import --depth 5 --allow-unsafe-features` silently
> >    ignored `--allow-unsafe-features`, refusing unsafe features from
> >    the stream.
>
> On the other hand, this may be a very good thing.
>
> Is the reason why the ad-hoc pre-scan failed to see it was because
> it did not realize 5 is a value to the --depth option?

Yes.

> > All of these commands call parse_options(), but for `git bisect` and
> > `git rev-parse`, the specific functions doing the early scan
> > (bisect_start() and cmd_rev_parse()'s main loop) parse their own
> > options by hand after the early scan and have no `struct option` array
> > for those options.
> >
> > If bisect_start() and cmd_rev_parse() were converted to use
> > `struct option`, they could use early_scan_options_from_options() and
> > would not be affected by limitations 1), 2) and 3) above, as both use
> > the early scan only to locate `--`.
>
> I imagine that in the long term we would rather see a properly
> refactored parse-options machinery perform the prescan (perhaps with
> some kind of "dry-run" option given to the machinery) than yet
> another ad-hoc parser like this topic introduces.  It would be very
> good if this interim solution at least took the same 'options[]'
> array so that when we have the real thing in the future we do not
> have to redo the conversion effort.

This is what is implemented in the v2 I just sent. So yeah, when a
refactored parse-options machinery will be able to perform the
prescan, we will be able to use it to replace the early-scan parser
without changing or converting the callers.

> By the way, how does this interact with your other topic that has
> been stalled for quite some time?  Would moving this one forward
> help the other, or do they not have much relevance to each other?  I
> would rather not see two topics of non-trivial size stalled on a
> single author at the same time, so ...

They are separate topics and I alternate between them. I was recently
busy with travelling to the Git Merge and was a bit sick before that,
but hopefully I should be able to spend more time on them in the next
weeks. Also it seems to me that both topics have advanced to a point
where not a lot of big changes are needed. So they should move forward
quite fast now.
