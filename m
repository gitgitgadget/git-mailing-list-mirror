Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA5B32ED30
	for <git@vger.kernel.org>; Mon,  9 Feb 2026 18:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770662034; cv=none; b=h12i4TQUutta9R6s6uyTJOkD+i17wnBOvksZtsvcB7UVB8d4bIy5wfwTp6NpstkpMotR3Flr5uYI9O3Z+VB3FKnQ9M7PfuFw+7oX3LqWXahHK2/rJ3JNEcR6G1IXsNly43o38UE7R4HkFp+s6qrVbKAssVhXvBhoNt3MbcnFMKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770662034; c=relaxed/simple;
	bh=dy6h8WHtJv7HuIscC5OJfpQihxwn71i0aFMukdIhQqc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DML8QV+/V0bShTusIWRpja1y0JCPhE18aHmVVSWSfeqPSvDIMyNy77K86oMOhbve709+g7aU5or6kvGNya9+a4uRRQjP29fgnZKSpGGlwONAqq+RWY3lqt2FRD4j3rCGWXqVN/AC16WSAnq5ze2lGxXVdBgosNcUMMMPflFT2Fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O56LeUMv; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O56LeUMv"
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-45effa36240so3239224b6e.1
        for <git@vger.kernel.org>; Mon, 09 Feb 2026 10:33:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770662033; x=1771266833; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XDb1LR7w3qjyBwgvTbbckQFgWxnSEnxLSOca29yCMvc=;
        b=O56LeUMve6pEDWmhSnQ5p4QAa4BOJC8f1Q5oCEe/PrY8hhAS6hIzYrAfVKEtgVxvy1
         okAftziz3rkTjv0Zp7Yl0JuU9S0O49W2dwR+cN2ToXsbLVUtEfSQ1IXnoRAucWMY5LAk
         7S86igjP3dQ6qyVb3fUR4UCeYFhprgErK8uZwVHAp9OwsqraL/lSCpodizTx9CPQjzzy
         sZAmB9YXnGMLb98dk8JHuYHTfp/xmirqF4yepauwWUt35S/IODkgUFndwRuVyq/F1dxW
         JXumG9cO0fPrE6M6X/5sPk3dldximr3JeEf5Y8tmmUkvHTewfWo++jax9lpCW+QQh+Ix
         sSzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770662033; x=1771266833;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XDb1LR7w3qjyBwgvTbbckQFgWxnSEnxLSOca29yCMvc=;
        b=fwI3+4AOH+k2Ah6ZYgdfw103z2ot9jGWVRfdDVbg8sCo5C0hOA0NjGm/pmkjlerP95
         laY9KK0xJoCXxgS7Z/MXAOKacvOYGSXmALM4NDUtcgv8jRdzPd7DkcfT01TjplXzb2Jj
         3gfcBTFoyTpwjcpK03wYtFpbQqaVBkrL744vhfQ6+CO/qas+A1dALhCx7Ub1EbvbNp2G
         y5V3i4HSMhBlvy2EUZOqam613H7LczUz6a+dFQnJVQMDuKz/9u2k2meJ16mWNab6mf80
         m6637yD06kM8peBC4Fcy8IX5yxMz+RZXIEpiDOra7c/c3oeorqCfOYSNRT4SsBK9W1zv
         Kk/Q==
X-Gm-Message-State: AOJu0YzdAlkTw7qXbTL+yUYnYrnNK+0BZYbDw7R8DR+J88ZjTByhYuVO
	bBwzmhMmQFDl0YWmIC1lxvryxeeDnVkLR0a4PWsmfMgZt6TveMUKWhzc
X-Gm-Gg: AZuq6aIfp42/rgBZH8qaByprhdUAvx6+blpEOuFYZZsHdNUnjxeYLVdMMxy63PGKr6P
	9Sbb6fivChOZeQp6JrDqOLn1QRuARg2yynSf7YFSrU/lsADAvtHORaCtrV78qnLuzAkj89mYTbf
	f+2eFg9bCpmxVfC0xUNDlke8jzBW4rTJIQFOVsElzgwu7sKx1f7LayvlKN97Yzoi65ETwxHY41z
	wo6aOgPMmhyurqA14You+yaYPA/CeYu5e5yZagd4BmdPaUdUf4oXD7H91C+7eDoGNW/lP53eQvt
	4OsT6Aq4NbNyPPFbGCOw2SRsy6ViPikya3B9riGMHDkX7Fv6oKKekNJ9kx6Pl3Dkb385htFI3dw
	svA8cDPc5ByMe71RwcQPCTsjPcobpXoFwi60ei2Qa+5DNaPlFZS0yk3hDivFR1GWwaIFoTbMMak
	O17Mu1
X-Received: by 2002:a05:6808:3c44:b0:45f:434:9c1c with SMTP id 5614622812f47-462fca2114bmr5979681b6e.12.1770662033501;
        Mon, 09 Feb 2026 10:33:53 -0800 (PST)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-462feb0d71bsm6785981b6e.10.2026.02.09.10.33.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Feb 2026 10:33:52 -0800 (PST)
Date: Mon, 9 Feb 2026 12:33:50 -0600
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 5/5] gitlab-ci: handle failed tests on MSVC+Meson job
Message-ID: <aYolvOd4erKFhSUE@denethor>
References: <20260209-b4-pks-ci-meson-improvements-v1-0-38444dec4874@pks.im>
 <20260209-b4-pks-ci-meson-improvements-v1-5-38444dec4874@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260209-b4-pks-ci-meson-improvements-v1-5-38444dec4874@pks.im>

On 26/02/09 05:56PM, Patrick Steinhardt wrote:
> The MSVC+Meson job does not currently have any logic to print failing
> tests, nor does it upload the failed test artifacts. Backfill this logic
> to make help debugging efforts in case any of its jobs has failed.
> 
> GitHub already knows to do this, so we don't need an equivalent change
> over there.
> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  .gitlab-ci.yml | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> index 04857b479d..71b8a6e642 100644
> --- a/.gitlab-ci.yml
> +++ b/.gitlab-ci.yml
> @@ -157,6 +157,8 @@ test:mingw64:
>    parallel: 10
>  
>  .msvc-meson:
> +  variables:
> +    TEST_OUTPUT_DIRECTORY: "C:/Git-Test"
>    tags:
>      - saas-windows-medium-amd64
>    before_script:
> @@ -164,12 +166,13 @@ test:mingw64:
>      - choco install -y git meson ninja rust-ms
>      - Import-Module $env:ChocolateyInstall\helpers\chocolateyProfile.psm1
>      - refreshenv
> +    - New-Item -Path $env:TEST_OUTPUT_DIRECTORY -ItemType Directory

Before the script starts we create the test output directory.

>  build:msvc-meson:
>    extends: .msvc-meson
>    stage: build
>    script:
> -    - meson setup build --vsenv -Dperl=disabled -Dbackend_max_links=1 -Dcredential_helpers=wincred
> +    - meson setup build --vsenv -Dperl=disabled -Dbackend_max_links=1 -Dcredential_helpers=wincred -Dtest_output_directory="$TEST_OUTPUT_DIRECTORY"

Now we set the test output directory build option accordingly.

>      - meson compile -C build
>    artifacts:
>      paths:
> @@ -185,10 +188,19 @@ test:msvc-meson:
>    script:
>      - |
>        & "C:/Program Files/Git/usr/bin/bash.exe" -l -c 'ci/run-test-slice-meson.sh build $CI_NODE_INDEX $CI_NODE_TOTAL'
> +  after_script:
> +    - |
> +      if ($env:CI_JOB_STATUS -ne "success") {
> +        & "C:/Program Files/Git/usr/bin/bash.exe" -l -c 'ci/print-test-failures.sh'
> +        Move-Item -Path "$env:TEST_OUTPUT_DIRECTORY/failed-test-artifacts" -Destination t/
> +      }

Here we print any failures and move them so they are stored as a CI
artifact.

>    parallel: 10
>    artifacts:
> +    paths:
> +      - t/failed-test-artifacts
>      reports:
>        junit: build/meson-logs/testlog.junit.xml
> +    when: on_failure

This patch also looks good.

-Justin
