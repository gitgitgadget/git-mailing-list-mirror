Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9827C3115A5
	for <git@vger.kernel.org>; Wed,  1 Apr 2026 16:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775060516; cv=pass; b=msqy5tD/cvU84GSYgZRyx+aHnUxQGsNm6X24gwo4FM6sHzIx1CWjAoeODJzZ55Gz/o30SKiwn/5KVk3+mFbK+XNcqLVzf+kMk44E344iqy3zAd14NtQtS/KvMSPS0fcOr79wnA0GcQHCXqSUSxItLIGYbWrZ4dSYKm8jJyDewf8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775060516; c=relaxed/simple;
	bh=yaOQT5AqPu1pwk1KsEvZ8QLFdpqmqqXf/584wX2uk+U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B1uYcfAMmArt4D17kejKNFkKGY4B5aZTDUZjXrxYn8SaQumN1DPtQcozUdLZjrzxuYXH1qbcvSO2iRhGuAxm2nHppcExFZ9OfNDNgi9DWF3bDMG8S19BhdLuxCcWl0ydTHX3lyIP2AMHeQ0CTDJXIS5rmykjEvjo08EQ2n9Jxhc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=pass smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-12a77005d69so469530c88.1
        for <git@vger.kernel.org>; Wed, 01 Apr 2026 09:21:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775060514; cv=none;
        d=google.com; s=arc-20240605;
        b=ELJnGQ61Wvk8Q8Gnl06Nr7eeIJCbcC7b2r3D1tKYrGn5HDKThjYAfPXb31+S3Fxug2
         mkwc38TQ+K7rnwAEYVWD1mcGBO3n5bqEN9LfL7+JPIVItZdWNuXyyN68renVyDj0HoDR
         +G/WlVC4aO0Qc9FvyV010yldYOkLSKhat2jGURYRfmx+Y99PH0t2UaSaxHdlged02qon
         qhGiZnFQP3tGwmeV35/ExRs4uc9cdvv8XEb+EAql352d8hrVIZFFeHpfFcicfxiwsKAr
         W0BghWDyqw6VOPP+GScSDcvWX1EkE8QKTd3s46FlOW3XiqJAfB8k4OMCwZac3aVRMsh8
         zFwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=8BqGCqsJHlISA44I1PxlpJNmQKjs8xLeXiDEPraNyKo=;
        fh=LRGsUkiEcWbrp2eq5At8375m2wmzUemYgi65EITzWvk=;
        b=i2ZWCpWO6q+zhlbvVI1jogxysq13D2L7S5vj1kX/HKbfaBp+ODjDA7XavTf8bptDif
         IiSnpvxifUi+7ePJhqJhXb8yT7GXF9/sBuS0KththGNL96v3FQwkcLJsLwK/qJu+8PHz
         ZcwX7hoaOiOV4GtJ38z8gWPzIH6W1NVVus1Hfq+dWHCIO21/XTYpTo9LldwSszYz4KSX
         4HHiS/R8+ctM7kXWAfL3KdoZfUke+7AFkOSAg25zMuHtMQnqIx2jVKbcrabM7ikiSCBx
         dV8x6kVM3M3JgvVsECQAGe2TG1ugkXF698lTeRcLlpT1B0P+S5sNVOi7wQQnHnXMgQw/
         oz4A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775060514; x=1775665314;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8BqGCqsJHlISA44I1PxlpJNmQKjs8xLeXiDEPraNyKo=;
        b=afp01sUOwflzqVlzvg/rW1qpxf2awoF4rWF6eIgKmtdyqZ5MGowGI1Pt2XT3JX2yPu
         8ks7WEQ2yvDMDEoRWpwzHqK5MfgFpywI9mJJ67xUGl9XSOdJkb/SM+Ms3qQyQCw8uctW
         6Kpx7XD9vTJ0KegYpp46Qfv6CmjSGLkAGfqNZkjmVmjn63Z/yYZefA6PMHZrXT2cr+SG
         vu0yvK+tqwcrSIKjprtXmmoHdCEapxpJmMoLuVzIeWvUErFnGHtP7owCgJe/NHJpxRhn
         jp97OFr9sAWh0a2cUQkoRcgdOvG0k7RPeWtDdrjGDe6kYpXP4jceaxWj8LbTho+7rmuC
         eurA==
X-Gm-Message-State: AOJu0YwmJtUH0zPhrFUd3iR/Ifg1V+5YAjZp+GgyL8ScG+3E+HWSvJY8
	mEeZiPJCFrYq4NrBjQAEfe3cLAjhHH4aQMcNAFmYA6qcCQSsUXSD5XaSCfgSY7wjEayiSP5zJPT
	KcmqJKgyVyEQavet7vf+vXCHZYsf/bMR9Ww==
X-Gm-Gg: ATEYQzxuKOB2mIL9SuT69Lz7a3il0JNZq2obVZG+3AGaGsK6IAK6SUmAJEbwQ41f6Y/
	aDEQLw1vqDhrFoVMhPbu7Lkd1oGSPWBBTm0OsA6GeU7km035FXjDGvOvC3xAEtMhMlDGfxp4gG7
	lXwEUb3bOudUksteFTqAuSGvP2buTXifoRvyot7JBwGs60s8T7wwvTqco2KZpA36gMr5sUuM4fm
	YAihJT4L9T7btpCunwcsLgUl2iywuyKEY9d6MTs184j0djOcJEOPHhuytrjZv3CEJXRNgeMw1Mc
	MPwDDK388MPIZhclbnQyGDY67V1vmfrrBev4C8OZRw==
X-Received: by 2002:a05:7300:3aa8:b0:2c9:ee15:a0d2 with SMTP id
 5a478bee46e88-2c9ee15e5femr332697eec.6.1775060513547; Wed, 01 Apr 2026
 09:21:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260401-pks-tests-with-dash-v1-0-d70b5040aa5d@pks.im> <20260401-pks-tests-with-dash-v1-1-d70b5040aa5d@pks.im>
In-Reply-To: <20260401-pks-tests-with-dash-v1-1-d70b5040aa5d@pks.im>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Wed, 1 Apr 2026 12:21:41 -0400
X-Gm-Features: AQROBzD9DxBO1iuwr-b6g81dqDFmhqm-JFityp2uqdNeF45z7dAUACn6bA7hvNQ
Message-ID: <CAPig+cQHUk5abmc+CeJ0tPWs5z7XMq9AxHKZRdvEgULF4zTg0g@mail.gmail.com>
Subject: Re: [PATCH 1/2] t: work around multibyte bug in quoted heredocs with
 Dash v0.5.13
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 1, 2026 at 6:59=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrote=
:
> When executing our test suite with Dash v0.5.13.2 one can observe
> several test failures that all have the same symptoms: we have a quoted
> heredoc that contains multibyte characters, but the final data does not
> match what we actually wanted to write. One such example is in t0300,
> where we see the diffs like the following:
> [...]
> For now, work around the bug by using unquoted heredocs instead.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
> diff --git a/t/t0300-credentials.sh b/t/t0300-credentials.sh
> @@ -675,7 +675,7 @@ test_expect_success 'match percent-encoded values' '
>  test_expect_success 'match percent-encoded UTF-8 values in path' '
>         test_config credential.https://example.com.useHttpPath true &&
>         test_config credential.https://example.com/per=C3=BA.git.helper "=
$HELPER" &&
> -       check fill <<-\EOF
> +       check fill <<-EOF
>         url=3Dhttps://example.com/per%C3%BA.git

Oof, this is the sort of change which cries out for an in-code
comment, since we can't expect that future reviewers will remember
this specific workaround in this specific script, and we can't expect
that people working on this code will think to check the history to
learn why the heredoc is unquoted. Without such a comment, someone
working on this file for some purpose or another (or even a GSoC
applicant looking for a microproject) will come along and "modernize"
this script by adding back the heredoc quoting which this patch
removes.

To prevent someone from "breaking" your "fix", at minimum, please add
an explanatory comment somewhere near the top of the script which
pretty much duplicates the information from the commit message:

    # *DONTQUOTE*: ...explanation of dash bug ...

and reference that comment at each location you "fix":

    # NOTE: Don't quote heredoc; see *DONTQUOTE* above.
    check fill <<-EOF
    ...
