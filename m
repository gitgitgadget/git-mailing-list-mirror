Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B0362F2913
	for <git@vger.kernel.org>; Wed, 13 Aug 2025 10:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755080088; cv=none; b=iQD5SJsKryKHsLBFJu/V0XDQT88/PTWr4/wzsyXlUPAwtPGjIMdcoyjZsfw13YY8iKJfmEMoYKaxXgHo8L/vfGob62geECeL8RNg9RjdG9uZgdZ2Q3lo9O8Ml1hv9gnZ1//atlIghZQ7sGS6fgDAXc2KLyqrVEEEtkKfljHsrPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755080088; c=relaxed/simple;
	bh=FHQIXoIso9VwkI/KEm/wVdObrwFI4iRov4qQizec/0E=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=j0l/fOHQoBrA0fnRMsJvbnfzYfEjBxSmSI7FiA5r734XHsTsjhR2Bo1wUCYm51rTkwG/lf/sfLDo/mtBRVeA2ACL6E+Q5+xeLtHIW9+eSLBGUHPVZipsAxBzg0f0BruE/idPm6ftVgvsSRKNVnpT+ZhkvUysnOaHa27vS8WIF18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cH5c0phl; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cH5c0phl"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-459ebb6bbdfso39899575e9.0
        for <git@vger.kernel.org>; Wed, 13 Aug 2025 03:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755080083; x=1755684883; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wgSc/6hKKTUnNIgC0rr0oaa+32jfTyqAMAgE0XhOdFg=;
        b=cH5c0phlzmzM6/MRr+BPFmovhc2L4b471kgiZBCc3YbQdbKHLT3VpfAVAxM1LoyItb
         q+Su5cdMNjAuRDZ9wfOwdn3NLt5zZrlzwpSRSVybAgux1KXn7WPROCRFqF7mo+Xdb7zG
         U4rkLUxmPEQSxCi7zn66GZz+Orar5yBx2JwrsShHz8UVtR19Ge0HgmYvPO54uO8T6xmu
         Cv0jShuYakhXxHAQm+Vh28ioKfE6lMEJic7s2RsTp00u/+F0vSWgSlNNynGtwibwbVLG
         //0OtegjZG4nHk+2wmnfWdWGxnkCQMoPqsgmbJ2hUkVJnyHD5Jh+grq7udP0gyvL669q
         0Xhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755080083; x=1755684883;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wgSc/6hKKTUnNIgC0rr0oaa+32jfTyqAMAgE0XhOdFg=;
        b=RhSRCslPfc9Bg2pHAvaX+XUCLAzMXHB4vt8QWqdEG9tmOENoP8IF5mZl+AoZZhCDqG
         m1ZMa/APsmvaCQeUxFNgMOQ06jHyHbbVmqH7X7PHT3pGMrZbbW1yxCwI02WxASbfhuzl
         rUSOgVMWLXyQtQ5HofNp4gy1Xb72Iw2pb5S2o5AvnAtenjAt63owOk8eq/PcTeHwlcef
         abfZcDlLXn8xtzH1jcZWa8GPtul63LiRQpw1BNV1OYFfa44DKufl7V5KMnCxr3FkZEn0
         flosu46xaDTW5Uf9S/iD8v9ZZg4aINasjeFiLUMGxFlnDp+jTCGvBMK4pj+C8VKTXnXz
         +nOQ==
X-Forwarded-Encrypted: i=1; AJvYcCUKGTVJfXElCLZCQNDbQ278jc4TODQvGWESlH2rKRsEEoNyqLFK27KFjv73oCIgXjlgYCs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8CUbCUPcE+K3DdUIdvWozcmGZsRdopaZtEk51Cix6JslFy41K
	kJWyqvX6vvLs6O1ziRB1nJ4LxPkXcF3LeM67i76wX7lguU+IUIy2s+hv
X-Gm-Gg: ASbGncvidOU8KzR4p0ExX4bxPngbWtXqNeCU1vbkgnoizDLdSZXzvgDxCVC0M9YlR2r
	MBTpnssYaSrGGUqeOxHONKA0n/3SOXrGjkLl/jWIldKHyeKu6LZtIGkbRULUrnKkM7SD1rGn3/p
	j15vGrxIpYAIDpV1y2hEOyGJH/UQo4S+avfibySGItCajUYP6sS3tPdxe62CP+NK5wAu6lm2MkL
	JIzSpZW1EjcjYuRppwllRf0loNSNgjHOycVMPLOpwDAdbnYm+IGOn1uPbChco9djeYtDidd39x/
	NhhxI9Q9MomURwKTSzmDZ3WyP2bU7p9aS1vfrGBihX6jjZ4Pu160+Bm9/YNCLpEnKJRNbWYsnjF
	ZABkbvb/vKq9x2GxaltRN3nJhhBBnalmGynLXIj+9tnniPUQdzoH4lBuYR2H8hy4sP1ETWQoAZg
	nX861/gDejWqc=
X-Google-Smtp-Source: AGHT+IGCI8uQB5c27bkwWUpdb4l56azjVAzeahmWgtx2RXH45Kq9uHOsPkh66hlbp73oUt3HF313LQ==
X-Received: by 2002:a05:600c:1390:b0:459:dfa8:b854 with SMTP id 5b1f17b1804b1-45a1659ffe6mr21030785e9.5.1755080083465;
        Wed, 13 Aug 2025 03:14:43 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:7a5:4701:8cee:45ed:2bd5:e17c? ([2a0a:ef40:7a5:4701:8cee:45ed:2bd5:e17c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a16dcbd60sm24834315e9.5.2025.08.13.03.14.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Aug 2025 03:14:42 -0700 (PDT)
Message-ID: <2250a8fd-62b8-4218-9858-23032d9c807d@gmail.com>
Date: Wed, 13 Aug 2025 11:14:40 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v4 0/3] clean up some code around editors
To: "D. Ben Knoble" <ben.knoble+github@gmail.com>, git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>,
 Eric Sunshine <sunshine@sunshineco.com>
References: <20250811221706.67168-1-ben.knoble+github@gmail.com>
 <20250812170256.71751-1-ben.knoble+github@gmail.com>
Content-Language: en-US
In-Reply-To: <20250812170256.71751-1-ben.knoble+github@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Ben

On 12/08/2025 18:02, D. Ben Knoble wrote:
> Changes from v3:
> - drop 4/4
> - use test_env (including a case our lint does not catch when the value
>    has spaces)

It's not worth a re-roll but for future reference

	test_env FOO=bar git commit --amend

uses an extra process compared to

	FOO=bar git commit --amend

which slows the test suite down for no real gain. We should only need to 
use test_env to set environment variables when calling a shell function. 
In the special case of test_must_fail it supports

	test_must_fail env FOO=bar git commit --amend

which is widely used in our test suite

$ git grep  'test_must_fail env ' origin/master t/t\*.sh | wc -l
152
$ git grep  'test_env .* test_must_fail ' origin/master t/t\*.sh | wc -l
1

Thanks for cleaning up this test file, it's looking much nicer now.

Phillip

> Changes from v2:
> - shuffle setup code and use more helpers in 1/4
> - insert 2/4 to stop abusing --exec-path
> - improve environment-cleansing idioms in {2 => 3}/4
> 
> Thanks especially to Phillip's encyclopaedic knowledge of test helpers ;)
> 
> Changes from v1:
> - add a prep patch with style fixes to t7005
> - rework the environment munging to use subshells, per Phillip Wood's
>    suggestion
> 
> This reroll of the previous exec-path series is simplified to contain
> only the first 2 cleanup patches, which were largely acked by the list.
> Drop the controversial and broken PATH munging.
> 
> Also, this version is (still) based on a later master 112648dd6b (Merge
> branch 'master' of https://github.com/j6t/git-gui, 2025-08-04) than the
> original from May.
> 
> These patches clean up some old code in the editor tests and subsystem
> that does not use our modern idioms.
> 
> v1: https://lore.kernel.org/git/20250520193506.95199-1-ben.knoble+github@gmail.com/
> v2: https://lore.kernel.org/git/20250810160323.49372-1-ben.knoble+github@gmail.com/
> v3: https://lore.kernel.org/git/20250811221706.67168-1-ben.knoble+github@gmail.com/
> Published-as: https://github.com/benknoble/tree/editor-cleanup
> 
> D. Ben Knoble (3):
>    t7005: use modern test style
>    t7005: stop abusing --exec-path
>    t7005: sanitize test environment for subsequent tests
> 
>   t/t7005-editor.sh | 149 +++++++++++++++++++---------------------------
>   1 file changed, 60 insertions(+), 89 deletions(-)
> 
> Diff-intervalle contre v3 :
> 1:  8ad2904a18 = 1:  8ad2904a18 t7005: use modern test style
> 2:  9451e4f0f6 ! 2:  44a6fd8eb3 t7005: stop abusing --exec-path
>      @@ t/t7005-editor.sh
>        	esac
>        	test_expect_success "Using $i" '
>       -		git --exec-path=. commit --amend &&
>      -+		PATH="$PWD:$PATH" git commit --amend &&
>      ++		test_env PATH="$PWD:$PATH" git commit --amend &&
>        		test_commit_message HEAD expect
>        	'
>        done
>      @@ t/t7005-editor.sh
>        	esac
>        	test_expect_success "Using $i (override)" '
>       -		git --exec-path=. commit --amend &&
>      -+		PATH="$PWD:$PATH" git commit --amend &&
>      ++		test_env PATH="$PWD:$PATH" git commit --amend &&
>        		test_commit_message HEAD expect
>        	'
>        done
> 3:  61cb116780 ! 3:  135d4368d6 t7005: sanitize test environment for subsequent tests
>      @@ t/t7005-editor.sh
>       -export TERM
>        test_expect_success 'dumb should error out when falling back on vi' '
>       -	test_must_fail git commit --amend
>      -+	TERM=dumb test_must_fail git commit --amend
>      ++	test_env TERM=dumb test_must_fail git commit --amend
>        '
>        
>        test_expect_success 'dumb should prefer EDITOR to VISUAL' '
>      @@ t/t7005-editor.sh
>       -	VISUAL=./e-VISUAL.sh &&
>       -	export EDITOR VISUAL &&
>       -	git commit --amend &&
>      -+	TERM=dumb EDITOR=./e-EDITOR.sh VISUAL=./e-VISUAL.sh \
>      ++	test_env TERM=dumb EDITOR=./e-EDITOR.sh VISUAL=./e-VISUAL.sh \
>       +		git commit --amend &&
>        	test_commit_message HEAD -m "Edited by EDITOR"
>        '
>      @@ t/t7005-editor.sh
>       -		;;
>       -	esac
>        	test_expect_success "Using $i" '
>      --		PATH="$PWD:$PATH" git commit --amend &&
>      +-		test_env PATH="$PWD:$PATH" git commit --amend &&
>       -		test_commit_message HEAD expect
>       +		if test "$i" = core_editor
>       +		then
>      @@ t/t7005-editor.sh
>       +				export $i
>       +				;;
>       +			esac &&
>      -+			PATH="$PWD:$PATH" TERM=vt100 git commit --amend
>      ++			test_env PATH="$PWD:$PATH" TERM=vt100 git commit --amend
>       +		) &&
>       +		test_commit_message HEAD -m "Edited by $i"
>        	'
>      @@ t/t7005-editor.sh
>       -		;;
>       -	esac
>       -	test_expect_success "Using $i (override)" '
>      --		PATH="$PWD:$PATH" git commit --amend &&
>      +-		test_env PATH="$PWD:$PATH" git commit --amend &&
>       -		test_commit_message HEAD expect
>       -	'
>       -done
>      @@ t/t7005-editor.sh
>       +				export $i
>       +				;;
>       +			esac &&
>      -+			PATH="$PWD:$PATH" git commit --amend &&
>      ++			test_env PATH="$PWD:$PATH" git commit --amend &&
>       +			test_commit_message HEAD expect || exit 1
>       +		done
>       +	)
>      @@ t/t7005-editor.sh
>        
>        test_expect_success 'editor with a space' '
>        	echo "echo space >\"\$1\"" >"e space.sh" &&
>      -@@
>      + 	chmod a+x "e space.sh" &&
>      +-	GIT_EDITOR="./e\ space.sh" git commit --amend &&
>      ++	test_env GIT_EDITOR="./e\ space.sh" git commit --amend &&
>        	test_commit_message HEAD -m space
>        '
>        
> 4:  ea269f2442 < -:  ---------- editor: use standard strvec API to receive environment for external editors
> 
> base-commit: 112648dd6bdd8e4f485cd0ae11636807959d48be

