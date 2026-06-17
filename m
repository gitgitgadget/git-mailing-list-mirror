Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5834E345750
	for <git@vger.kernel.org>; Wed, 17 Jun 2026 20:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781726627; cv=none; b=Vhd1BBf6QjwrPtvhX8wXJaOcdPTrUT6eQvHtxI1NDRKQoudmB2Dvo2e4NxpOgSxBKWAIiWQXX3EmLhr7sXTuKJXJ3+lkzS5YXqClqScrBoL1Rk06LdAYqLYRiSJCIs+8bbFAxuui7oBXZNbIboOmf7tn8jgOYwyARRWOUE8fGqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781726627; c=relaxed/simple;
	bh=2Se1fAsvdjGRhLUxLc90IP2TQ9y9ZeHxyCMCxiw6DNo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ycnq+gWcHIiOxtxApUCRh+zu42aswFN97/Ixt4tMXX06H6n4EYZynvbvLmRf4C0CmwHwSsvVc4KsABMj9MG5dxT+8YjvGfYRJBvydZTF8Ulua44dcARBm6VEE4nGARYfRJYCJqJR3o1CTQwVPlVYri7ZSA8D6dW+HpB0EskKTXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lzdc0hp0; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lzdc0hp0"
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-69e1eae4eb4so167767eaf.2
        for <git@vger.kernel.org>; Wed, 17 Jun 2026 13:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781726625; x=1782331425; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/7LiCIFq31Y1QIIUuK3lFrwzmMju6PcJu+clGLhw6gA=;
        b=Lzdc0hp0ZsRzXSoiW29FjdvdZRxyv9dWxSEVOfBmVxM/bHRkDXteFpuciXcpDDbQ4G
         ADX5WeP1i4RVYYEYcoNZiklhLS0Dg8SajK5g1HDDgft1nemnT+BGHBRfsTcJwpnNVSWG
         HW8DlX5b5/f/WujUdDFJLxHn5nbORweIKEu147rrkaaWXo8klMuLFdSM+MFvdDqGTs57
         JLo8brpdCFGeFsI8V9g2FWlkpddIw5BgKtp3DVCoFcN9nGM8x34qcvg6JxaWihrtXThB
         Ff+RU7Gv1f81ZN20dLsIgbNQ3xnWPddyvIObcERYhy2y/T+Dyjz4C3SywI5os5Ei6uZx
         FZEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781726625; x=1782331425;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/7LiCIFq31Y1QIIUuK3lFrwzmMju6PcJu+clGLhw6gA=;
        b=TIIRF6zAZVXpR+3RV/pU3qraVlQveVzXrWSrNSnqOgIRzoaXmvsnV11qpw+7alm5G/
         fwRRzhYLV7nvaMkKFW0Wsb0BspO0yI9G7a5u8s9Ue9PyPdyoY3lH9T9eyoHl728T85IX
         epnj8Do1on+5clQkCQ6RTOxAQ92PVb2EDBhlDVFhzuiWXSzMbZNOLKlrdD4SDItPTLMn
         rMwK3zIKX6ceOQzGQdcBIMT1Xn+JYK7Aftwf92kEIxzTWQAurYcHlbd+1GLsnR5TR+FX
         R3f2s73S5woHLHxNa5HcrM/FUXzdZEKg+Hpc6eRQmNpI3DdmrcxYmEZl8IwT33sf4Avq
         gORw==
X-Gm-Message-State: AOJu0YxyQUewi/52BxFjBNU6wbWQzIT3lKT75iO54clHEXmXIluiplha
	N05885RXIqXyM7KGwm54S6+8+6eLg3ocwMM+6fBZlj4NPJvOZmRgUN8YiYDGQQ==
X-Gm-Gg: Acq92OH9x5xoHVsGFRVr85oEkDjooWwalkmeo0wsOhq70bRjAWul0nBNmfcejdvBPGe
	f2zumOLeBev5QmSUhPF0ruwyb4PfdkQNXYv7yCF+gYZSRHV35OGjnpKIEYClOC+V3D49xNANfem
	bvvfHXcTzjl25Uz7MQPYdWJpBCEOm0FeYhQ8S0xrvf5gIvalEIDWm/4kKsttsg/zBOGtZbPEyvs
	jjejQdZRpD5MQqBKYlnBHpbrmEOMYho3PA4+PPr/2/j1MAx7RQWxln7iiRINntNZAssv2WLYosb
	JM2e8uFGxFR58I+whTObuIZXyf7OhP9VCuzvwt/AHdMwSjDiSiI2khHnkYKy22zj1K0b9HFwLd7
	WcVenMTWCt20r82KmUh211MBOHy4qAOCB+PrBe2eeFqaW35jmTrwsp/nzm5BAI7P6cTwBKT83Jd
	gOTZM3XjLK7m8QEUZA
X-Received: by 2002:a05:6820:806:b0:69e:3e2a:a838 with SMTP id 006d021491bc7-6a0b61e091dmr3931299eaf.52.1781726625162;
        Wed, 17 Jun 2026 13:03:45 -0700 (PDT)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-44308fd68d9sm5315984fac.14.2026.06.17.13.03.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 13:03:44 -0700 (PDT)
Date: Wed, 17 Jun 2026 15:03:39 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] gitlab-ci: migrate Windows builds away from Chocolatey
Message-ID: <ajL1677NQShTO6tD@denethor>
References: <20260615-b4-pks-gitlab-ci-drop-chocolatey-v1-1-51a6e7d5e388@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260615-b4-pks-gitlab-ci-drop-chocolatey-v1-1-51a6e7d5e388@pks.im>

On 26/06/15 02:21PM, Patrick Steinhardt wrote:
> The Windows builds in GitLab CI use Chocolatey to install dependencies.
> Unfortunately, Chocolatey seems to be very unreliable, which causes the
> jobs to fail very regularly. This is a limitation that seems to be
> somewhat known [1]:
> 
>   As an organization, you want 100% reliability (or at least that
>   potential), and you may want full trust and control as well. This is
>   something you can get with internally hosted packages, and you are
>   unlikely to achieve from use of the Community Package Repository.
> 
> So using the Community Package Repository is kind of discouraged in case
> one wants reliability. We _do_ want reliability though, and we cannot
> easily switch to an enterprise license to fix this issue.

Make sense.

> Introduce a new script that downloads and installs dependencies
> directly. This has a couple of benefits:
> 
>   - We can drop our dependency on Chocolatey completely, thus improving
>     reliability.
> 
>   - We can easily cache the installers.
> 
>   - We get direct control over the exact versions we install.

Naive question: Do we expect to have to update the pinned versions
often?

>   - Installing dependencies is sped up from roundabout 3 minutes to 1
>     minute.

Is fetching the dependencides directly just plain faster? Or is this due
to the caching?

> [1]: https://docs.chocolatey.org/en-us/community-repository/community-packages-disclaimer/#summary
> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
> Hi
> 
> I've been quite annoyed recently because our Windows builds in GitLab CI
> are extremely flakey. All of those flakes come from Chocolatey, which is
> why this patch moves away from it.
> 
> Thanks!
> 
> Patrick
> ---
>  .gitlab-ci.yml              | 11 ++++++---
>  ci/install-dependencies.ps1 | 55 +++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 63 insertions(+), 3 deletions(-)
> 
> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> index e0b9a0d82b..87a5343a94 100644
> --- a/.gitlab-ci.yml
> +++ b/.gitlab-ci.yml
> @@ -161,11 +161,16 @@ test:mingw64:
>      TEST_OUTPUT_DIRECTORY: "C:/Git-Test"
>    tags:
>      - saas-windows-medium-amd64
> +  cache:
> +    key:
> +      files:
> +        - ci/install-dependencies.ps1
> +    paths:
> +      - .dependencies

Nice that we can cache the installers now.

>    before_script:
>      - *windows_before_script
> -    - choco install -y git meson ninja rust-ms
> -    - Import-Module $env:ChocolateyInstall\helpers\chocolateyProfile.psm1
> -    - refreshenv
> +    - ./ci/install-dependencies.ps1
> +    - $env:Path = "C:\Meson;C:\Rust\bin;$env:Path"

I assume Git is already discoverable on the path?

>      - New-Item -Path $env:TEST_OUTPUT_DIRECTORY -ItemType Directory
>  
>  build:msvc-meson:
> diff --git a/ci/install-dependencies.ps1 b/ci/install-dependencies.ps1
> new file mode 100755
> index 0000000000..e3b367fa54
> --- /dev/null
> +++ b/ci/install-dependencies.ps1
> @@ -0,0 +1,55 @@
> +param(
> +    [string]$DownloadDirectory = '.dependencies'
> +)
> +
> +$ErrorActionPreference = 'Stop'
> +$ProgressPreference = 'SilentlyContinue'
> +
> +$GitVersion = '2.54.0.windows.1'
> +$MesonVersion = '1.11.0'
> +$RustVersion = '1.96.0'
> +
> +New-Item -Path $DownloadDirectory -ItemType Directory -Force | Out-Null
> +New-Item -Path .git/info -ItemType Directory -Force | Out-Null
> +New-Item -Path .git/info/exclude -ItemType File -Force | Out-Null
> +Add-Content -Path .git/info/exclude -Value "/$DownloadDirectory"

Here we create the ".dependencies" directory and add it to
".git/info/exclude" to be ignored.

> +function Get-Installer {
> +    param(
> +        [Parameter(Mandatory = $true)][string]$Name,
> +        [Parameter(Mandatory = $true)][string]$Url
> +    )
> +
> +    $path = Join-Path $DownloadDirectory $Name
> +    if (-not (Test-Path $path)) {
> +        Write-Host "Downloading $Url"
> +        Invoke-WebRequest $Url -OutFile $path -TimeoutSec 300

We only download the installer if it is not already cached. Makes sense.

> +    }
> +    return $path
> +}
> +
> +function Invoke-Installer {
> +    param(
> +        [Parameter(Mandatory = $true)][string]$FilePath,
> +        [Parameter(Mandatory = $true)][string[]]$ArgumentList
> +    )
> +
> +    Write-Host "Running $FilePath $($ArgumentList -join ' ')"
> +    $process = Start-Process -Wait -PassThru -FilePath $FilePath -ArgumentList $ArgumentList
> +    if ($process.ExitCode -ne 0) {
> +        throw "$FilePath failed with exit code $($process.ExitCode)"
> +    }
> +}
> +
> +$gitAssetVersion = $GitVersion -replace '\.windows\.\d+$', ''
> +$gitInstaller = Get-Installer "Git-Installer.exe" `
> +    "https://github.com/git-for-windows/git/releases/download/v$GitVersion/PortableGit-$gitAssetVersion-64-bit.7z.exe"
> +Invoke-Installer $gitInstaller @('-y', '-o"C:\Program Files\Git"')
> +
> +$mesonMsi = Get-Installer "meson.msi" `
> +    "https://github.com/mesonbuild/meson/releases/download/$MesonVersion/meson-$MesonVersion-64.msi"
> +Invoke-Installer msiexec.exe @('/i', $mesonMsi, 'INSTALLDIR=C:\Meson', '/quiet', '/norestart')
> +
> +$rustMsi = Get-Installer "rust.msi" `
> +    "https://static.rust-lang.org/dist/rust-$RustVersion-x86_64-pc-windows-msvc.msi"
> +Invoke-Installer msiexec.exe @('/i', $rustMsi, 'INSTALLDIR=C:\Rust', 'ADDLOCAL=Rustc,Cargo,Std', '/quiet', '/norestart')

Here is actually invoke the helpers to fetch and install the
dependencies. Looks good. I also validated that this job is working on
GitLab CI.

-Justin
