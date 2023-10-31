Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 968C6208DD
	for <git@vger.kernel.org>; Tue, 31 Oct 2023 17:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b="KgLE8SOh"
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FC8F102
	for <git@vger.kernel.org>; Tue, 31 Oct 2023 10:47:46 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-6bf03b98b9bso43158b3a.1
        for <git@vger.kernel.org>; Tue, 31 Oct 2023 10:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google; t=1698774466; x=1699379266; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vAbEGWfRBDdDPKRjauWffiYy2b0mwB6v4SXOqMKMHMU=;
        b=KgLE8SOhKY8tWG2rSDQrQckhdeCsWpoIz5lDdVjP1pT3PV8pfcwD7ofA+Mt2pzu4FD
         apy8Glbuj4sDBDIX23kDQgmLIsL5DHJjypkC/O+v2JNydCMQqSo9FPB+o4NM3yf7mqGg
         zQ6+E+QnFy0tFGpF7nBATB8KcR9g1iJQ3ZY1hijqZmzZPnVZEmxtXZaS6nwiwZNdH1W1
         mHhOOI59L9Q6ZFiBZ3ZmmNAW4y130RxLPVKbl8n6Td/t9RY5aapBlM1W1GbQaKQMsbQl
         sa7NpCCSJ3ubcaXUR+R9zlY9Vv1kuimzc2KXOctMKjGtsiBnipJdjs8vvdBt8uc87ScL
         fwlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698774466; x=1699379266;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vAbEGWfRBDdDPKRjauWffiYy2b0mwB6v4SXOqMKMHMU=;
        b=WeDbx2OYdxYmFR1/DJl8kof3GRV2JNGE5WB15NfADZfarYRoNRNXJBhbn6b7t488BI
         dn7+EJ9s6pt51MihQaa2YJmFuEj7POu8P5nV75NQurLNKM4tQI0qKO5QhJ1dq/hkpiVt
         G0mWTnyQGBl7MkNxocs1zohz66fQs4Jd5UN4Hg1aifCKdqRU5Buv6egEqHAKm9Gx5vWy
         sckaM5AaxmhDSAiVLwGhdy97ixuTj2PzzDMGZywEnJHqvAo2G/qEinLNW0n9UFXSEDGz
         Kle0VfcYnPcpl4dJuJFTlCFzf0s4W69+pQ8+n0U7RSFhb1XrNa86El0JSE0XR7i7M0RG
         lDXw==
X-Gm-Message-State: AOJu0YzDrUpHEokGMkz4ibqN4pFQsXm5p1lypERkvpqHjkWorzQMTR53
	VajEdcZnPjR786NJuHzoDmlx
X-Google-Smtp-Source: AGHT+IEMX+6Mdx9cPeQIy6JNlu7WvUDmMk8RMS8vr0IWiSC5FwtHYiZ+RsAvaTdJTXSUSWLND6qYow==
X-Received: by 2002:a05:6a20:1450:b0:133:1d62:dcbd with SMTP id a16-20020a056a20145000b001331d62dcbdmr350929pzi.28.1698774466202;
        Tue, 31 Oct 2023 10:47:46 -0700 (PDT)
Received: from [192.168.50.41] (cpe-172-91-184-234.socal.res.rr.com. [172.91.184.234])
        by smtp.gmail.com with ESMTPSA id p9-20020a63ab09000000b0059ce3d1def5sm1323550pgf.45.2023.10.31.10.47.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Oct 2023 10:47:45 -0700 (PDT)
Message-ID: <4c8c2f19-1a7e-4524-81e7-c74091e88edf@github.com>
Date: Tue, 31 Oct 2023 10:47:44 -0700
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 8/8] ci: add support for GitLab CI
Content-Language: en-US
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
 Phillip Wood <phillip.wood123@gmail.com>,
 Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
References: <cover.1698305961.git.ps@pks.im> <cover.1698742590.git.ps@pks.im>
 <f3f2c98a0dc6042b7ed5eab9c10bee4f64858f02.1698742590.git.ps@pks.im>
From: Victoria Dye <vdye@github.com>
In-Reply-To: <f3f2c98a0dc6042b7ed5eab9c10bee4f64858f02.1698742590.git.ps@pks.im>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Patrick Steinhardt wrote:> diff --git a/ci/install-docker-dependencies.sh b/ci/install-docker-dependencies.sh
> index 6e845283680..48cb2e735b5 100755
> --- a/ci/install-docker-dependencies.sh
> +++ b/ci/install-docker-dependencies.sh
> @@ -7,6 +7,9 @@
>  
>  begin_group "Install dependencies"
>  
> +# Required so that apt doesn't wait for user input on certain packages.
> +export DEBIAN_FRONTEND=noninteractive
> +
>  case "$jobname" in
>  linux32)
>  	linux32 --32bit i386 sh -c '
> @@ -16,11 +19,19 @@ linux32)
>  	'
>  	;;
>  linux-musl)
> -	apk add --update build-base curl-dev openssl-dev expat-dev gettext \
> +	apk add --update shadow sudo build-base curl-dev openssl-dev expat-dev gettext \
>  		pcre2-dev python3 musl-libintl perl-utils ncurses \
>  		apache2 apache2-http2 apache2-proxy apache2-ssl apache2-webdav apr-util-dbd_sqlite3 \
>  		bash cvs gnupg perl-cgi perl-dbd-sqlite >/dev/null
>  	;;
> +linux-*)
> +	apt update -q &&
> +	apt install -q -y sudo git make language-pack-is libsvn-perl apache2 libssl-dev \
> +		libcurl4-openssl-dev libexpat-dev tcl tk gettext zlib1g-dev \
> +		perl-modules liberror-perl libauthen-sasl-perl libemail-valid-perl \
> +		libdbd-sqlite3-perl libio-socket-ssl-perl libnet-smtp-ssl-perl ${CC_PACKAGE:-${CC:-gcc}} \
> +		apache2 cvs cvsps gnupg libcgi-pm-perl subversion
> +	;;
>  pedantic)
>  	dnf -yq update >/dev/null &&
>  	dnf -yq install make gcc findutils diffutils perl python3 gettext zlib-devel expat-devel openssl-devel curl-devel pcre2-devel >/dev/null

...

> diff --git a/ci/lib.sh b/ci/lib.sh
> index e14b1029fad..6e3d64004ec 100755
> --- a/ci/lib.sh
> +++ b/ci/lib.sh
> @@ -208,6 +224,7 @@ then
>  	cache_dir="$HOME/test-cache/$SYSTEM_PHASENAME"
>  
>  	GIT_TEST_OPTS="--write-junit-xml"
> +	JOBS=10
>  elif test true = "$GITHUB_ACTIONS"
>  then
>  	CI_TYPE=github-actions

...

> -MAKEFLAGS="$MAKEFLAGS --jobs=10"
> -GIT_PROVE_OPTS="--timer --jobs 10 --state=failed,slow,save"
> +MAKEFLAGS="$MAKEFLAGS --jobs=${JOBS}"
> +GIT_PROVE_OPTS="--timer --jobs ${JOBS} --state=failed,slow,save"
>  

Organizationally, this commit seems to be doing two things at once:

- Adding GitLab-specific CI setup (either in the new .gitlab-ci.yml or in
  conditions gated on "gitlab-ci").
- Updating the common CI scripts with things that are needed for GitLab CI,
  but aren't conditioned on it (i.e. the patch excerpts I've included
  above). 

I'd prefer these being separated into two patches, mainly to isolate "things
that affect all CI" from "things that affect only GitLab CI". This is
ultimately a pretty minor nit, though; if you're not planning on re-rolling
(or just disagree with what I'm suggesting :) ), I'm okay with leaving it
as-is.

Otherwise, I can't comment on the correctness of the GitLab CI definition (I
assume you've tested it anyway), but AFAICT the changes above shouldn't break
GitHub CI.

