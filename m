Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E82B1607A4
	for <git@vger.kernel.org>; Fri, 15 Aug 2025 16:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755273655; cv=none; b=KF72/UxjMvFnGuIhfx8ikTjLxOgPlGCcbmIEnb4Qw+rMW947Nk8pataO6v5AD4fs/woqZ5ak0EUrljIPrOi1BaNDMsMyIhkHatdMzJKeIG0WB6950vooMhZoCGSG3HNmKkuKmxNJfNJ6Kp/oYv+8oau0Fwu7O/px4/TtI0q4ai0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755273655; c=relaxed/simple;
	bh=XL8boV32a+WGLo06a/eMDhqj7LhAa3tiuRP262hzY58=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=pMvuz+yL67m0lbW/WE70BEqswLus16L1WH26ZyaxzoQ2IQkIK302erOmDvgnK6hBEhWlPzE+QAsK5hydb2+Usfj85EFNqjRKRsDHHPziRsNWXcucvmVBiKhIaJEoBGEn0axVoDST1hjB41D1ZL0t6Hk0/2tlIs52i3FDKC3krsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AVeLlZy/; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AVeLlZy/"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-45a1b0990b2so12317805e9.2
        for <git@vger.kernel.org>; Fri, 15 Aug 2025 09:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755273652; x=1755878452; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q8wRtOwEJ/OUqSlwnNO1lmPW2kCOlSLU/LblFbbQmUo=;
        b=AVeLlZy/T6vbFejw+2NIzGpWXW4EwUbGmnqmdI/r4u1Zygf7fH03DfqY/lv3UdgDfi
         hvKzItOC3bCWx4Rdz/+JoZPiah5KObhiO2nJEEbsfAalrOSev7+JjkK9gU1mD6fMclFU
         mV1mi+ixdM9TIFaxHSHy4XzSWlBXAsADoWQsMJ4epA3OKCP+BWR8GhLKbrtlKqhotENN
         NVwP7NhmvCb8YC7isIb7aL6c6XZxbEOSq3V6vzksyBOo1q07pZudMF5S+m1f/LbskGHq
         XqQC6uFyRE9RoncYIKDB46HU6mxhUxEfVMJrv9CV5ET2bK9uulPWVae41sBtIFEtcuHC
         /XzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755273652; x=1755878452;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q8wRtOwEJ/OUqSlwnNO1lmPW2kCOlSLU/LblFbbQmUo=;
        b=SBcVXRJmp+YuYDDkAYvWNpkj7waemhWCIPeOrUjNFksZ/TMX7kNy+h7/SVePce21RL
         AHCOrTk2EtICmR6XDOQDF3AylR0tH5rV40lY/gKy7p+57Io/Ys6y2xIYnalVYZbt9EC1
         3Kik5YVm0ipW5TsQnPHOhGhi/QMEhgaqmFEaiHty0mMoheD5HFqWB3Te6YsC42NWdqpi
         vcWjPgExku9xV79KiCFWeYW39xRHkbDwlJhlCX56qSSh4hJ8gUWhRGQutgPYjJjtCKj7
         T8W+YcIolZPiycWwhywNEfR5GADezoyJli8mT5PquCINQD6IjDHZoNTOYqp7XBRWded2
         BGCw==
X-Forwarded-Encrypted: i=1; AJvYcCWDNAY/YxgcGW6ivgTiOenHUYSfwhqR/x4RxZFmyocbwFeoaKHwEJpT1bH9OEXCMaOi4cA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxq6AlKET6wJrgKsNifY5ioQRRpbTvb9/SKzn5yMYflYMoE066D
	m9E744GfZSUmtV2Q5e98dxYX01LMTOqQGgl7/Lhcy5qb07QY3uVC+zjRm3Omgg==
X-Gm-Gg: ASbGncvicnW7m2tWkghuhVXp8HHkYAc0YxahYZlrJ5juX3yssrT5+FAx2/dPWdtwYlG
	wRMhLTKf24n3D4C2FW8a5uIRCVUVnU2FbnJoB7zEmdLmM+wv7cXM/oVdGpVTGvgLeLZUhBDCxZf
	PJDu3/zvjnYO/D+dXq/v3wHNgKrHcLTxPDJdvQITn7FKnMKMxnXv9oaxJoVt7nwroJ3CTOnxBGP
	x+NR8toshPULseJuTNDM0DsYBMycwlcTZlf8WE092h36sIJnLowc1LfHJgCkr/OY/IIItXrvl8+
	eO1lcX/UpI6G1Bso8z8Qlp73823eN5SFnnoW7rybKV+ui84FQGMOw07J1Xu3UDhft0YMeuR1Lg7
	WybaLig3kK0AUHF6QsDT+f0jeyaXqRBuHT6abF+SKyyVhgm5Nc1XfKUt68v7Zf+f9W247QIIZgY
	6euHFWs39XUCw=
X-Google-Smtp-Source: AGHT+IHSNjPzHtXd1PBadhdUj+7q6s6Jq7lQIPEs3+oEJeXuy8ttppIVNv4GEyRPDDJzBKZCQBoX3w==
X-Received: by 2002:a05:600c:8518:b0:458:bf9c:274f with SMTP id 5b1f17b1804b1-45a2185e6e1mr23849805e9.29.1755273651606;
        Fri, 15 Aug 2025 09:00:51 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:7a5:4701:8cee:45ed:2bd5:e17c? ([2a0a:ef40:7a5:4701:8cee:45ed:2bd5:e17c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3bb676c9a8asm2398294f8f.39.2025.08.15.09.00.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Aug 2025 09:00:51 -0700 (PDT)
Message-ID: <6279f266-3312-4923-8d05-c74e7f759063@gmail.com>
Date: Fri, 15 Aug 2025 17:00:49 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v5 0/3] clean up some code around editors
To: "D. Ben Knoble" <ben.knoble+github@gmail.com>, git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>,
 Eric Sunshine <sunshine@sunshineco.com>
References: <20250812170256.71751-1-ben.knoble+github@gmail.com>
 <20250813175112.88435-1-ben.knoble+github@gmail.com>
Content-Language: en-US
In-Reply-To: <20250813175112.88435-1-ben.knoble+github@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Ben

On 13/08/2025 18:50, D. Ben Knoble wrote:
> Changes from v4:
> - revert use of test_env: fix the one instance that needs adjusted for
>    VAR=val cmd syntax by using test_must_fail env VAR=val cmd.

Thanks for re-rolling, the range-diff below looks good

Phillip

> 
> Changes from v3:
> - drop 4/4
> - use test_env (including a case our lint does not catch when the value
>    has spaces)
> 
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
> These patches clean up some old code in the editor tests that does not use our
> modern idioms.
> 
> Also, this version is (still) based on a later master 112648dd6b (Merge
> branch 'master' of https://github.com/j6t/git-gui, 2025-08-04) than the
> original from May.
> 
> v1: https://lore.kernel.org/git/20250520193506.95199-1-ben.knoble+github@gmail.com/
> v2: https://lore.kernel.org/git/20250810160323.49372-1-ben.knoble+github@gmail.com/
> v3: https://lore.kernel.org/git/20250811221706.67168-1-ben.knoble+github@gmail.com/
> v4: https://lore.kernel.org/git/20250812170256.71751-1-ben.knoble+github@gmail.com/
> Published-as: https://github.com/benknoble/tree/editor-cleanup
> 
> D. Ben Knoble (3):
>    t7005: use modern test style
>    t7005: stop abusing --exec-path
>    t7005: sanitize test environment for subsequent tests
> 
>   t/t7005-editor.sh | 147 +++++++++++++++++++---------------------------
>   1 file changed, 59 insertions(+), 88 deletions(-)
> 
> Diff-intervalle contre v4 :
> 1:  8ad2904a18 = 1:  8ad2904a18 t7005: use modern test style
> 2:  44a6fd8eb3 ! 2:  5a35889571 t7005: stop abusing --exec-path
>      @@ t/t7005-editor.sh
>        	esac
>        	test_expect_success "Using $i" '
>       -		git --exec-path=. commit --amend &&
>      -+		test_env PATH="$PWD:$PATH" git commit --amend &&
>      ++		PATH="$PWD:$PATH" git commit --amend &&
>        		test_commit_message HEAD expect
>        	'
>        done
>      @@ t/t7005-editor.sh
>        	esac
>        	test_expect_success "Using $i (override)" '
>       -		git --exec-path=. commit --amend &&
>      -+		test_env PATH="$PWD:$PATH" git commit --amend &&
>      ++		PATH="$PWD:$PATH" git commit --amend &&
>        		test_commit_message HEAD expect
>        	'
>        done
> 3:  135d4368d6 ! 3:  e6e31ab98c t7005: sanitize test environment for subsequent tests
>      @@ t/t7005-editor.sh
>       -export TERM
>        test_expect_success 'dumb should error out when falling back on vi' '
>       -	test_must_fail git commit --amend
>      -+	test_env TERM=dumb test_must_fail git commit --amend
>      ++	test_must_fail env TERM=dumb git commit --amend
>        '
>        
>        test_expect_success 'dumb should prefer EDITOR to VISUAL' '
>      @@ t/t7005-editor.sh
>       -	VISUAL=./e-VISUAL.sh &&
>       -	export EDITOR VISUAL &&
>       -	git commit --amend &&
>      -+	test_env TERM=dumb EDITOR=./e-EDITOR.sh VISUAL=./e-VISUAL.sh \
>      ++	TERM=dumb EDITOR=./e-EDITOR.sh VISUAL=./e-VISUAL.sh \
>       +		git commit --amend &&
>        	test_commit_message HEAD -m "Edited by EDITOR"
>        '
>      @@ t/t7005-editor.sh
>       -		;;
>       -	esac
>        	test_expect_success "Using $i" '
>      --		test_env PATH="$PWD:$PATH" git commit --amend &&
>      +-		PATH="$PWD:$PATH" git commit --amend &&
>       -		test_commit_message HEAD expect
>       +		if test "$i" = core_editor
>       +		then
>      @@ t/t7005-editor.sh
>       +				export $i
>       +				;;
>       +			esac &&
>      -+			test_env PATH="$PWD:$PATH" TERM=vt100 git commit --amend
>      ++			PATH="$PWD:$PATH" TERM=vt100 git commit --amend
>       +		) &&
>       +		test_commit_message HEAD -m "Edited by $i"
>        	'
>      @@ t/t7005-editor.sh
>       -		;;
>       -	esac
>       -	test_expect_success "Using $i (override)" '
>      --		test_env PATH="$PWD:$PATH" git commit --amend &&
>      +-		PATH="$PWD:$PATH" git commit --amend &&
>       -		test_commit_message HEAD expect
>       -	'
>       -done
>      @@ t/t7005-editor.sh
>       +				export $i
>       +				;;
>       +			esac &&
>      -+			test_env PATH="$PWD:$PATH" git commit --amend &&
>      ++			PATH="$PWD:$PATH" git commit --amend &&
>       +			test_commit_message HEAD expect || exit 1
>       +		done
>       +	)
>      @@ t/t7005-editor.sh
>        
>        test_expect_success 'editor with a space' '
>        	echo "echo space >\"\$1\"" >"e space.sh" &&
>      - 	chmod a+x "e space.sh" &&
>      --	GIT_EDITOR="./e\ space.sh" git commit --amend &&
>      -+	test_env GIT_EDITOR="./e\ space.sh" git commit --amend &&
>      +@@
>        	test_commit_message HEAD -m space
>        '
>        
> 
> base-commit: 112648dd6bdd8e4f485cd0ae11636807959d48be

