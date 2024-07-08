Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39038149C40
	for <git@vger.kernel.org>; Mon,  8 Jul 2024 17:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720461553; cv=none; b=BSMSUZlm/ag+JqzqS9eaYl9kiiGY6Osysf1sIQq9M72IL1JPvlpcEUo0E3MlKqhUoKgfds/fzNdjEQvpNem0jOhM90BiuDaaGgxPGiL4OujFbV23zjM5TBopY9j4pS1EYihMPyu/aVM3x6VfW/MxKQjzoGkSm6v5D9yqZk31HSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720461553; c=relaxed/simple;
	bh=GkVGkQDIj04eDh7PKo5fEeOXrS8FiE8/fPH/vW4DICs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ENvBDCIPasrt3Q49ZUhvNAgkrTRbec9ThMN9TmO3oFah31/rq/n1xY1U76Err7zH0VfFP2SChQhRyGqfR2DtV+5i8AqGDYOL64Lub7hdctjLvIA/IgCRGg+yth5Zo3a+2vXptM2VRFOunoJDaxK75GA0QY8//5HkKLW8DH9x4dM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OLhOATzE; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OLhOATzE"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7035d9edcd9so1661114a34.1
        for <git@vger.kernel.org>; Mon, 08 Jul 2024 10:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720461551; x=1721066351; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=H4U7OJdVJehuwgzU30ul0qCLy0MBSE3PH2E5XrN7K68=;
        b=OLhOATzEEtHASDlpL29e4MXsCE/ntpUx9mLTvbNw7nw451Ad9SyYyMTOZtlXYLk/vJ
         YjfkhuhzcXOFW+BxfgBLbIJyOaqW/sgqszDmq8CrT6lwKGvQKGAr7LqCOZgqUQ3ic2Gv
         4qhj6MGYlLWp0Xd3PUpSOudVVOcNvDwmMLb49ZsgonJxj+UVTyl8JhJdar9ZP9EtiQFf
         3kw7xV3Xt0WOMWNrDMtVS/I9ZhkM+jJo6metgLGhuInxk42uV8CvHnbZC5oh1N3O7dtL
         ULKe227MBD24Np92sYeIZij7/Dh9+qo5lQFkM8eMIVEm5sHwhgQGnQ9NolFwnzWLIJ26
         rPQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720461551; x=1721066351;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H4U7OJdVJehuwgzU30ul0qCLy0MBSE3PH2E5XrN7K68=;
        b=Xn6YpM0TnrCGvaadlPMuFVSrdEftWiyDQfOg5wKyyaBt3OLxSo68bqRRKycdFl4FrB
         +bCGIzYhQxB4DXu2Uc3D90mHO0XW3LoqsOGWaQA3wVHrgr9m2/dynRIA8sLtXQRsaahK
         1vx29Da5ZXrbvOK+qla2w2z44LMqFVhtbI8NJk4GHj0gQhpK29O6Q4l2RcbC9bIpHgrx
         LyR7+sY/TjVMAgRBVDqIm/9ACc8gfGe21ObUORLHM3zrx6C468ywhNqP8FXWWrUpfaWd
         Zi22AVHlPO2hDp7FjdDPWdrj7iIEHRp/3Hh5BxDZ23CcCaWBkF03kgvDe6c7TOj0pAqa
         eSPQ==
X-Gm-Message-State: AOJu0Yx12A1B9x68/EuDkXmYilSnCN6F22UHkhdnrcNyO8bP0+5hiuRy
	G1p1dkSCoW5Bal6B+b7ngRWk6CJ4YIj9Zad3gNkvGXkpGZsGEJ1E1j6n7Q==
X-Google-Smtp-Source: AGHT+IEfzQa1Z33OJYP69RRdtxA2l4sLmjHCYCUpTOfY+/fd5a/ueME+KDPK+8xBiLbNEA4VbchWbA==
X-Received: by 2002:a05:6830:1244:b0:702:222d:e57e with SMTP id 46e09a7af769-70375a0550cmr229813a34.1.1720461551193;
        Mon, 08 Jul 2024 10:59:11 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-70374fcbd04sm81556a34.69.2024.07.08.10.59.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 10:59:10 -0700 (PDT)
Date: Mon, 8 Jul 2024 12:58:42 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, chriscool@tuxfamily.org
Subject: Re: [PATCH 8/8] check-whitespace: detect if no base_commit is
 provided
Message-ID: <tl66b35ytbri4dep3cnppdexebblep6avyuhj4moc4mnsolnp2@xpqqwyl4oo2y>
References: <20240708092317.267915-1-karthik.188@gmail.com>
 <20240708092317.267915-9-karthik.188@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240708092317.267915-9-karthik.188@gmail.com>

On 24/07/08 11:23AM, Karthik Nayak wrote:
> The 'check-whitespace' CI script exists gracefully if no base commit is
> provided or if an invalid revision is provided. This is not good because
> if a particular CI provides an incorrect base_commit, it would fail
> successfully.

s/exists/exits

If no base commit is provided, we already fail. Here is an example
GitLab CI job demonstrating this:
https://gitlab.com/gitlab-org/git/-/jobs/7289543498#L2370

If the base commit does not exist though, it currently prints that error occured
but still exits with 0. Makes sense to update and fail the job accordingly.

> 
> This is exactly the case with the GitLab CI. The CI is using the
> "$CI_MERGE_REQUEST_TARGET_BRANCH_SHA" variable to get the base commit
> SHA, but variable is only defined for _merged_ pipelines. So it is empty
> for regular pipelines [1]. This should've failed the check-whitespace
> job.

The CI for this project is configured to use merged pipelines. So 
$CI_MERGE_REQUEST_TARGET_BRANCH_SHA is defined. The downside with using 
$CI_MERGE_REQUEST_DIFF_BASE_SHA is that it will include other commits in
the check that are not part of the MR, but are included in the merge for
merge pipelines. With this change, the job can now fail due to unrelated
changes.

If we feel inclined to also support regular pipelines, one option would
be to simply fallback to $CI_MERGE_REQUEST_DIFF_BASE_SHA if a merge
pipeline is not in use.

GitLab CI pipeline showing $CI_MERGE_REQUEST_TARGET_BRANCH_SHA defined:
https://gitlab.com/gitlab-org/git/-/jobs/7289331488#L2371

> 
> Let's fix the variable used in the GitLab CI. Let's also add a check for
> incorrect base_commit in the 'check-whitespace.sh' script. While here,
> fix a small typo too.
> 
> [1]: https://docs.gitlab.com/ee/ci/variables/predefined_variables.html#predefined-variables-for-merge-request-pipelines
> 
> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> ---
>  .gitlab-ci.yml         |  2 +-
>  ci/check-whitespace.sh | 13 ++++++++++---
>  2 files changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> index 65fd261e5e..36199893d8 100644
> --- a/.gitlab-ci.yml
> +++ b/.gitlab-ci.yml
> @@ -119,7 +119,7 @@ check-whitespace:
>    before_script:
>      - ./ci/install-dependencies.sh
>    script:
> -    - ./ci/check-whitespace.sh "$CI_MERGE_REQUEST_TARGET_BRANCH_SHA"
> +    - ./ci/check-whitespace.sh "$CI_MERGE_REQUEST_DIFF_BASE_SHA"
>    rules:
>      - if: $CI_PIPELINE_SOURCE == 'merge_request_event'
>  
> diff --git a/ci/check-whitespace.sh b/ci/check-whitespace.sh
> index db399097a5..ab023f9519 100755
> --- a/ci/check-whitespace.sh
> +++ b/ci/check-whitespace.sh
> @@ -9,12 +9,19 @@ baseCommit=$1
>  outputFile=$2
>  url=$3
>  
> -if test "$#" -ne 1 && test "$#" -ne 3
> +if { test "$#" -ne 1 && test "$#" -ne 3; } || test -z "$1"

I might be misunderstanding, but this additional check seems redundant to me.

>  then
>  	echo "USAGE: $0 <BASE_COMMIT> [<OUTPUT_FILE> <URL>]"
>  	exit 1
>  fi
>  
> +gitLogOutput=$(git log --check --pretty=format:"---% h% s" "${baseCommit}"..)
> +if test $? -ne 0
> +then
> +	echo -n $gitLogOutput
> +	exit 1
> +fi
> +
>  problems=()
>  commit=
>  commitText=
> @@ -58,7 +65,7 @@ do
>  		echo "${dash} ${sha} ${etc}"
>  		;;
>  	esac
> -done <<< "$(git log --check --pretty=format:"---% h% s" "${baseCommit}"..)"
> +done <<< "$gitLogOutput"
>  
>  if test ${#problems[*]} -gt 0
>  then
> @@ -67,7 +74,7 @@ then
>  		goodParent=${baseCommit: 0:7}
>  	fi
>  
> -	echo "A whitespace issue was found in onen of more of the commits."
> +	echo "A whitespace issue was found in one of more of the commits."
There is another preexisting typo:

s/one of/one or/

>  	echo "Run the following command to resolve whitespace issues:"
>  	echo "git rebase --whitespace=fix ${goodParent}"
>  
> -- 
> 2.45.1
> 
