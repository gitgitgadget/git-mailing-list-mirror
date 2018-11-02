Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DFA031F453
	for <e@80x24.org>; Fri,  2 Nov 2018 02:25:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726328AbeKBLat (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Nov 2018 07:30:49 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36673 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726119AbeKBLat (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Nov 2018 07:30:49 -0400
Received: by mail-wr1-f65.google.com with SMTP id y16so447157wrw.3
        for <git@vger.kernel.org>; Thu, 01 Nov 2018 19:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=jbBESOE67ldnqm8D3SChdPbuAA6Wl2YTnXxvz7zSfU0=;
        b=sdhVIeKnRkRBkrFPjdk107xkk1DYj5jibV+Eevwyk8yaLGoL9SeHSH/Mo7wGEy7MLU
         nlDBsVTbYycI9HflAQ93j9cz6nBP6/Bu32s4qnXv0NDprvGY9+2SjiX9tOzbQ9zm/kQO
         WxSekEuoK9lX3BxzNl3B0Jv7+gnBVGemJo4slN32i2FyAbGTfGtRWw3f2jiucWG5SlZJ
         YGkmg/b6jkCPRcsjbCzrpMiieg1sRR+Vh98Fnxsur+1KeC+KksIhnA+dMyBPNASAS5sq
         cftHTX7Q9b5ytSg/xo00TntxDF9Id+eQUs5tV7ePT+fzbUwp6bT7yR0ewjrnWaLBHGi9
         rJRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=jbBESOE67ldnqm8D3SChdPbuAA6Wl2YTnXxvz7zSfU0=;
        b=hjYbhdeXgzk4eGGNs299+QxFGx0f0LxTYqr7+ol8dexHvyEpoLQkDUBdPYJtTu1cIW
         YrLuSA8a6py+eiKxD3xZxxzFejn3tl1Kbk2kwvbWvf7kVuYBkfn2ueQwHY/umx8Ft/ZT
         t2duO0tjZXtFhxem9peq1fjQ1CnQg4AKjx8+5xSAYZiCve3l+JvHH2HyTztahPDHDjrL
         orLrBEFhGrIb55Ay5I0AMRno4BQI4Qi9qrVVxoxeDTBcibIQmdIqeGUSCqjATk90+MDh
         Fq72l+gLmnuoIg6DjSlNmLnfwixBQFFIE2JFdco+Hs0QaXNPt5C6CYXicbmx0C6E4kVE
         29JQ==
X-Gm-Message-State: AGRZ1gISy1o0iugRw8yuVio3vhzPLEtQUnicNM++clZIL9VgULH+8/+8
        nL6iG1jU6KcrmE6Iz/s4BBM=
X-Google-Smtp-Source: AJdET5cDP9CUbv6LRiOoOomlzIlVQGt2SYKv1ukPP8z0EEldNllIYaCoc0wfcsL5eDg5rmu1mNTnmw==
X-Received: by 2002:a5d:69ce:: with SMTP id s14-v6mr8020297wrw.177.1541125519693;
        Thu, 01 Nov 2018 19:25:19 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id 195-v6sm31527668wmx.21.2018.11.01.19.25.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 01 Nov 2018 19:25:18 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Lars Schneider <larsxschneider@gmail.com>,
        Sebastian Staudt <koraktor@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] travis-ci: install packages in 'ci/install-dependencies.sh'
References: <20181026013949.GN30222@szeder.dev>
        <20181101114714.14710-1-szeder.dev@gmail.com>
Date:   Fri, 02 Nov 2018 11:25:17 +0900
In-Reply-To: <20181101114714.14710-1-szeder.dev@gmail.com> ("SZEDER
 =?utf-8?Q?G=C3=A1bor=22's?=
        message of "Thu, 1 Nov 2018 12:47:14 +0100")
Message-ID: <xmqqa7msrzaq.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER Gábor <szeder.dev@gmail.com> writes:

> Ever since we started using Travis CI, we specified the list of
> packages to install in '.travis.yml' via the APT addon.  While running
> our builds on Travis CI's container-based infrastructure we didn't
> have another choice, because that environment didn't support 'sudo',
> and thus we didn't have permission to install packages ourselves.  With
> the switch to the VM-based infrastructure in the previous patch we do
> get a working 'sudo', so we can install packages by running 'sudo
> apt-get -y install ...' as well.

OK, so far we learned that this is now _doable_; but not enough to
decide if this is a good thing to do or not.  Let's read on to find
out.

> Let's make use of this and install necessary packages in
> 'ci/install-dependencies.sh', so all the dependencies (i.e. both
> packages and "non-packages" (P4 and Git-LFS)) are handled in the same
> file.  

So we used to have two waysto prepare the test environment; non
packaged software were done via install-dependencies.sh, but
packaged ones weren't.  Unifying them so that the script installs
both would be a good change to simplify the procedure.  

Is that how this sentence argues for this change?

> Install gcc-8 only in the 'linux-gcc' build job; so far it has
> been unnecessarily installed in the 'linux-clang' build job as well.

Is this "unneeded gcc-8 was installed" something we can fix only
because we now stopped doing the installation via apt addon?  Or we
could have fixed it while we were on apt addon but we didn't bother,
and this patch fixes it "while at it"---primarily because the shell
script is far more flexible to work with than travis.yml matrix and
this kind of customization is far easier to do?

> Print the versions of P4 and Git-LFS conditionally, i.e. only when
> they have been installed; with this change even the static analysis
> and documentation build jobs start using 'ci/install-dependencies.sh'
> to install packages, and neither of these two build jobs depend on and
> thus install those.
>
> This change will presumably be beneficial for the upcoming Azure
> Pipelines integration [1]: preliminary versions of that patch series
> run a couple of 'apt-get' commands to install the necessary packages
> before running 'ci/install-dependencies.sh', but with this patch it
> will be sufficient to run only 'ci/install-dependencies.sh'.

So the main point of this change is to have less knowledge to
prepare the target configuration in the .travis.yml file and keep
them all in ci/install-dependencies.sh, which hopefully is more
reusable than .travis.yml in a non Travis environment?

If that is the case, it makes sense to me.

> This patch should go on top of 'ss/travis-ci-force-vm-mode'.
>
> I'm not sure about the last paragraph, because:
>
>   - It talks about presumed benefits for a currently still
>     work-in-progress patch series of an other contributor, and I'm not
>     really sure that that's a good thing.  Perhaps I should have
>     rather put it below the '---'.
>
>   - I'm confused about the name of this Azure thing.  The cover letter
>     mentions "Azure Pipelines", the file is called
>     'azure-pipelines.yml', but the relevant patch I link to talks
>     about "Azure DevOps" in the commit message.
>
> Anyway, keep that last paragraph or drop it as you see fit.

I hope we'll hear from Dscho in one or two revolutions of the Earth
;-)

> diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
> index 75a9fd2475..06c3546e1e 100755
> --- a/ci/install-dependencies.sh
> +++ b/ci/install-dependencies.sh
> @@ -10,6 +10,15 @@ LFSWHENCE=https://github.com/github/git-lfs/releases/download/v$LINUX_GIT_LFS_VE
>  
>  case "$jobname" in
>  linux-clang|linux-gcc)
> +	sudo apt-add-repository -y "ppa:ubuntu-toolchain-r/test"
> +	sudo apt-get -q update
> +	sudo apt-get -q -y install language-pack-is git-svn apache2
> +	case "$jobname" in
> +	linux-gcc)
> +		sudo apt-get -q -y install gcc-8
> +		;;
> +	esac
> +
>  	mkdir --parents "$P4_PATH"
>  	pushd "$P4_PATH"
>  		wget --quiet "$P4WHENCE/bin.linux26x86_64/p4d"
> @@ -32,11 +41,25 @@ osx-clang|osx-gcc)
>  	brew link --force gettext
>  	brew install caskroom/cask/perforce
>  	;;
> +StaticAnalysis)
> +	sudo apt-get -q update
> +	sudo apt-get -q -y install coccinelle
> +	;;
> +Documentation)
> +	sudo apt-get -q update
> +	sudo apt-get -q -y install asciidoc xmlto
> +	;;
>  esac
>  
> -echo "$(tput setaf 6)Perforce Server Version$(tput sgr0)"
> -p4d -V | grep Rev.
> -echo "$(tput setaf 6)Perforce Client Version$(tput sgr0)"
> -p4 -V | grep Rev.
> -echo "$(tput setaf 6)Git-LFS Version$(tput sgr0)"
> -git-lfs version
> +if type p4d >/dev/null && type p4 >/dev/null
> +then
> +	echo "$(tput setaf 6)Perforce Server Version$(tput sgr0)"
> +	p4d -V | grep Rev.
> +	echo "$(tput setaf 6)Perforce Client Version$(tput sgr0)"
> +	p4 -V | grep Rev.
> +fi
> +if type git-lfs >/dev/null
> +then
> +	echo "$(tput setaf 6)Git-LFS Version$(tput sgr0)"
> +	git-lfs version
> +fi
