Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E313F1D618E
	for <git@vger.kernel.org>; Sat, 16 Aug 2025 16:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755360773; cv=none; b=rcv/E2q5q6ET4Zdfl2UoFvucWGeUz7Qs9e3qYodzocbtADkX2qo3BqVwjk8p/rdPnb1eO6haIMsIWvSK8HU6QBwktbOwuuDt0YrwVAEds0mW+s6ALKP3ygB4VfQYoeFrsp9B+jKAhIMSuJZc4ybDBnDiR8wAYqvGbTnnmYQFPXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755360773; c=relaxed/simple;
	bh=bKZi42E100FGI+OGT8fWHhWGAyTxLQ/mnHuyL9GUYNA=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=n3uHnRGsjtgG2H8QXNyd3EvOC1r92LCDtIW4KA0jvvPTa5Vflx2LiP65MnJGxd+97BXHD3fAnQSuGopcfUkMqNYGBmpLUDfe987RB6o6vAQC9Bzb06hrID3+uErJX4qPWCnwXt6jN9D6B1lOHU72B8Di3yqgvYBtDGunxjHyXFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jzpw/RH4; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jzpw/RH4"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3b9d41cd38dso2115835f8f.0
        for <git@vger.kernel.org>; Sat, 16 Aug 2025 09:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755360770; x=1755965570; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:reply-to:subject:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zgTsqDgrbl05hgvt8YsCDBQIKJuoKTntmzgfmXKf+IU=;
        b=jzpw/RH427OVEFE0CpdL1yW/zrq07pA9FKUztvkJTQA4uyh+38Q41urwaaKN72Y0vv
         83kFYIRtejaF9ONeEHN7jz2kbYlcNYbrg5GUdJwmgej+bVX+2KpMs95/bOndOyUV0ZNr
         8U2A6xX7uWFDrAbFDsIAgLok9kFerMk7Ifpws0Hdfs3y9nnoek+0mBU/80zvMK5EcunD
         lUISiBkZNphxfG1uA6BQgLs9HD9gCW5z2I1CmcFiB06hYZ3ie5+nU/FQrzk16MPDCruT
         Em6SafXOtkwev41B3rgEeJWEoILWdhSfZagr/J/q9dnTMWVRxMjUxUzrc+4BEoKMb42a
         56DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755360770; x=1755965570;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:reply-to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zgTsqDgrbl05hgvt8YsCDBQIKJuoKTntmzgfmXKf+IU=;
        b=GAaWKJQXd+8bol9iy/kwsi4YabCvc+8CGLlc0P734pc6+kSaypEnfLRf+YQmhp8d2c
         qQXjo/Xqg6N4FCy0OthAj5tQLde05fk7+4dQvr6l3M+FaJTtNwMKaYbMAuVaKZFSF/II
         ED6vFKl4T1+GizIFFwRci3Tnjb8l2sh5bswedyx7RRuAciVLHxVjVHirlDV2GjFWhuWN
         k3hma84QzTa3mxT5jmKZQFepgm1TwQ2bPnmplhFCvYL8Nw1vquFKoeLlXGls7zs5QcT7
         1qYgAgPtKD2qBp2gvTd8Kg9NQs39Z6vQW2+9Dhk4z367dQ9VlFJA2SMXazA7x76yWUAJ
         UUpg==
X-Forwarded-Encrypted: i=1; AJvYcCXXqRwnTRf5aprfgZeQfQJlu/uhvMgZsDn6jx1LAza7IoICSEzfnIH4HxZH8amaMtDQiis=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyalm05U9W0WdYmWZBKKZqGcHCAjVGjYXKPUwySzeGOwCXs9GQh
	leIAEY84EuUma9vUJT2x2CqEtPfFT4ZR15mf8T3xH15kzIGY9l8b0cbG
X-Gm-Gg: ASbGncsWpdUNi6t2wCFhjBtdjQgrFRfsQnMNqRJLQHu3P52/bWL5M773gEK7ur/6UOm
	fTCgGJ6lB4DzhZMiYf8bTnTEsU+ZXpRe6FVG581eDh93y0MfqyN4AVFmhTs/KtBAHLpaqLGCJjk
	TnP1rE+aJFUIbEHFynGXgCMVmS5TwU17HuPEWo2ZeTCfpb2Genm7qSsNi7gdimjP0FR8+bXdEbf
	jBxnOmvj2pFp+u97ZAWSAFAmzIeBfZfO/rmn9DX3+5qEcBwMxDkB3ZWRt18W8Xi8rZFEqGDZX19
	99Nprl00azPWH3GFJo+dvRZrzZ653w1TtG2kJoADdo6aA2AJ2/Q6dNpJ0CEnuWCIxUY9DgaZPiK
	GgRFPZJl2D+7ZvcH+qhpD9f3RpSoY7WAuKes+M9fNDuxANSV6edb3saqX8cYH/UDbhdQlksvuDb
	h5Wxq/qac1ALj5qBze7g==
X-Google-Smtp-Source: AGHT+IGtVKFHAWLyz7iQDjxwlQQEwNXnFWx6RkezM5AjGdTi7Ucd7kxMs/6IRSKvS0eQFrX+1fpv0Q==
X-Received: by 2002:a05:600c:4586:b0:43d:563:6fef with SMTP id 5b1f17b1804b1-45a218399fdmr47931585e9.21.1755360770033;
        Sat, 16 Aug 2025 09:12:50 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:7a5:4701:9bd8:62f6:3085:6ee3? ([2a0a:ef40:7a5:4701:9bd8:62f6:3085:6ee3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a1c6cd044sm105396295e9.9.2025.08.16.09.12.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 Aug 2025 09:12:49 -0700 (PDT)
Message-ID: <60f38225-2bcb-4383-be40-36c7b02cf38c@gmail.com>
Date: Sat, 16 Aug 2025 17:12:47 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [FEATURE] Proposal: git stash --only-unstaged
Reply-To: phillip.wood@dunelm.org.uk
To: "J. Dettweiler" <git.vger.kernel.org@dettweb.de>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, "D. Ben Knoble" <ben.knoble@gmail.com>
References: <12fe17735317215aa0de58a20055193a@dettweb.de>
Content-Language: en-US
In-Reply-To: <12fe17735317215aa0de58a20055193a@dettweb.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 13/08/2025 09:51, J. Dettweiler wrote:
> 
> **Current limitations:**
> - `git stash --keep-index` still saves the index in the stash object.
> - When I later `git stash pop`, Git tries to restore those staged 
> changes, often causing merge conflicts if I’ve modified them during the 
> test.

As the index and the worktree are saved in the stash we can restore the
unstaged changes with a three-way merge between the stashed index, HEAD
and the stashed worktree. The (lightly tested) script below does that
and updates the worktree without changing the index unless there are
conflicts. There will only be conflicts when a staged line that is
adjacent to an unstaged line is changed. Changes to staged lines that
are not next to unstaged lines should not create conflicts as they are
only modified on one side of the merge.

To use it create your stash with "git stash push --keep-index" and then
use the script to pop the unstaged changes rather than using "git stash
pop". If the script proves to be useful then perhaps we could add an
"--unstaged" option to "git stash pop"

Thanks

Phillip

---- 8< ----
#!/bin/sh

USAGE="${0##*/} [<stash>]"
SUBDIRECTORY_OK=1
. "$(git --exec-path)/git-sh-setup"
cd_to_toplevel
require_clean_work_tree stash-pop-unstaged

LF='
'
stash="${1:-stash@{0}}"
if ! stash_oid="$(git rev-parse --verify --quiet "$stash")" ||
    ! oid1="$(git rev-parse --verify --quiet $stash_oid^1)" ||
    ! oid2="$(git rev-parse $stash_oid^2^@ 2>/dev/null)" ||
    test "$oid1" != "$oid2"
then
     die "error: '$stash' does not look like a stash commit"
fi
merge_output="$(git merge-tree --merge-base=$stash_oid^2: HEAD: $stash_oid:)"
status=$?
if test $status = 0
then
     tree=$merge_output
     conflict_info=
     messages=
elif test $status = 1
then
     merge_output="$merge_output$LF"
     tree="${merge_output%%$LF*}"
     conflict_info="${merge_output%%$LF$LF*}"
     conflict_info="${conflict_info#*$LF}"
     messages="${merge_output#*$LF$LF}"
else
     exit 128
fi
git read-tree --index-output="$GIT_DIR/stash-pop-index" -m -u HEAD $tree &&
rm "$GIT_DIR/stash-pop-index" &&
if test -n "$conflict_info"
then
     printf '%s' "$messages" >&2
     printf '%s\n' "$conflict_info" | git update-index --index-info
else
     git stash drop "$stash"
fi

