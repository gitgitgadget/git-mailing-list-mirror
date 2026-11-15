Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794746376;
	b=2cwXxUV2GOmwNrYluRIXBlQd8M6lxHCM8eo3LJfKnaeYoWbjAijETsQlYp2rGrdL23sa
	 Vx2MFem1ZCZHB3KMPw4qVVbS/Ll0oH8vnDMQ4LO71fDWrfRiyjDC9evaDl9QkB6AFg57Z
	 bDeX7RtsC9ifIxpLl6mWC087+vhO8ujFEJ9Vwg81od/LSlOZ0kOUOQ1Ja7KXfLQo3gtqK
	 5iWAO+0u6+aCA+HRfPM2EWYHvy2nXubSobiDSr9htLNDjtvUixVayGCJqytCihmihIPDM
	 KlwMj3sTQTecTUFbAyOuMsGbYHjC2OHfByLGJLKqWGHpkL45lxc386+54O/hc2oyggQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794746376;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=5rZIOBYREhxYMVq91EVoSwcrMHnYUwUJgeKH/rjV7Y4=;
	b=msZvwFBPubyVMIYc5epCTxL6lL/aNEpyLREREc82wdm7up49ILg/JJ4iVQnv8BWHn34O
	 7Mq9Zu8k4hdLot2fmK/krorKHtuuwbD/teui5b+jiDql/qoHtPxOrc5fdmykOVDm2KO/H
	 2e6jeagnW0H3TSjcqDWTj/bVy9AX6UcI6vuuPpKsaYDQcVj/V/x1nVhizpT4W69T2mnzj
	 zLZ+/7nuaAf1zYhjmXt8RvGLHyHhobbp/dGa4B+y9dCFYsyrMTFpdGm9sZTRAuFubRbN9
	 LUKgjjcQD8StYjV3IUkiL9WmcElYzCl9M1+uvt3zl/DsHMcok4TwFq2XiaFXT0oh55Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EckzmJiA;
	arc=none smtp.remote-ip=209.85.216.46
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 835BB606A31D
	for <git@vger.kernel.org>; Sun, 15 Nov 2026 12:39:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 835BB606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EckzmJiA
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3b0ae87069dso1566140a91.2
        for <git@vger.kernel.org>; Sun, 15 Nov 2026 04:39:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794746376; x=1795351176; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5rZIOBYREhxYMVq91EVoSwcrMHnYUwUJgeKH/rjV7Y4=;
        b=EckzmJiAT+X+MHm7p4QHM5potuK1S8AUJKsFy2sLR2HXXUH3JSoGUD17XE3n81BxCs
         eqJLLhuTu+37DCtsJMocRrAC6vdfYNmX2rM32ybv2j0B+z4daCH4TTiVCJp2smQgVM5H
         W3w/6bxNZQNn0R/TrwwAaav7we8LM2VD0OBBqChEgKBu0PBc3HKgA52wP8IuhOcO0mEB
         jpVOCs8v9c6WIRWREjBdGcAylef7M45D3im6v/1FIe0HD2B7bKjH1hXGF58kE+vc2U5t
         YOUcdy07Y2MMygeV9guQ4fy7xVitb2a53PyOO/cm34Y9gpV1f9Ok5vdpEaa6Oj4en8vS
         dAsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794746376; x=1795351176;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5rZIOBYREhxYMVq91EVoSwcrMHnYUwUJgeKH/rjV7Y4=;
        b=iBFSy7JOLsElkQ/WYmpe6zKHuKp3TQcBHzETmlfHKqxl+1coJLzhlUzXJOn84QG+M5
         ieu8imkB5OgOl3g1K7l/wI/TwyoqKSnlhYHA7eCtzwiCFUJgyHzdHQr05CBe+zI78kwB
         tQ8Tv92KJ3SO6ODBVn4lqwtdPq7yrF/FZCtBQThHjFbiWF6O7UM49KdX2pGMlu1aoApx
         vOIri3wS5XrAQyM6PLkLllJ7nd61p2LQDN92k0fraIoY+4vxzJ0Rbh6qBFSeY6r+PTDg
         GESExvyNBVYw0yctVqutAQ6ScGNGRIx8bD1INZL9B+LEZvPptDZB05LkFPteG10vzw/O
         o/qg==
X-Forwarded-Encrypted: i=1; AL+hErFTocfUu5AA3L1h4REw96Aa2qjszr6P99yBnOfDdBO3ZW6ZHcBx61oCCNvtCvBcsw3KUDk=@vger.kernel.org
X-Gm-Message-State: APuU4Z+3NnD+vlBas8QShezZimi1e5J1EYLfbHLxykVKbT+DKvp8tk0T
	PCUuDu9j2FQL7cRL9NagldRTdA7SXWNZmlKo5AcyDird+fhcn9SojCF8
X-Gm-Gg: AYBFou0X2mASBlYRJRHZG2xzwSyiqPYfIfiIR/3nexbkPu9OwB3tKms7RoI94mcGfUW
	LcT1nFzMkhDZ1F/7EeDi7gPXY1HDCm7iRNKk8GFAwiZXjF46+yRLHyoYy79KyBgZXZDt1mbEF2C
	aC7H32k0ejyk8S5cjI4AgpUvRGTvJvWZjcvmSJQj7XBsxwirb6U2WnlEQhqimYX4bvyyrP0fYy0
	a63vmaXUjTI2bOWmU1QC9IyxqPg5xdqpbPNX/y+GWwFByJ1VZu37jgXQnf9dZnJWHaauLT/ECeb
	DiOys4/halFuuZdaAeEG4zvb3/YbNb2TPgDgFzHTDDuFlo/9r1qgQffj9YgLL8oZctysGXWRRBJ
	E1JTBZae/xWtcUqqxiZ52/UfnVPLb1y0faqZ5P9jB8vvDYI2JHEK1YpbbZgXG0nlUMJDFeL3HI8
	17KV8Rofibf1reAfpnF2fPzE1HrzUC8XRwm3AduBzzbWn+OKMZT2Fy4Li4zL+nt+DtmdmgJgN6u
	qZrevTaFPpGLGBC+RiEa/cRYIlsbrlucmma5HJU/M9lu+Urs/swz2qJV1k1Qe1sFPSWaLTR7Op+
	swYMJ/fzYs/o9dfh/pVQxx2ts1h13CDa56p8tN/+PmHDcyA5Fh9mpagJat1giuIpb8PgFjGls0Z
	aPjtCsJmJo0bFTknt9SFHOYkZr8ihiajkCh9xf88TQWUmkJeHMUYxaUgzcGbVcdBtr/s1YV6RGP
	2Vf4YfUT5U7/+30REzdQrt2ntGtrvcNVrvtyU1Sg6/G8pmiJaIyi6qiajJWSAmma3oABbJAhCVF
	SXVWaS5bFiSnHmmdD7nGgtwpVE3bgz1jKxtVsah+dw=
X-Received: by 2002:a17:90b:4c12:b0:3ac:a1c7:20fd with SMTP id 98e67ed59e1d1-3b1b081b37fmr7887657a91.4.1794746375570;
        Sun, 15 Nov 2026 04:39:35 -0800 (PST)
Received: from ?IPV6:2409:40e3:1f1:6974:cdf8:c7c2:79c3:a727? ([2409:40e3:1f1:6974:cdf8:c7c2:79c3:a727])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b197b76ccesm17517932a91.0.2026.11.15.04.39.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Nov 2026 04:39:35 -0800 (PST)
Message-ID: <d4c22268-44e0-4e33-9ad4-2a9b3a5f5cae@gmail.com>
Date: Sun, 15 Nov 2026 18:09:29 +0530
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Outreachy PATCH v2 1/2] apply: reject a patch after an empty
 "diff --git" line
To: Tanga Joris <tangajoris@gmail.com>, git@vger.kernel.org
Cc: phillip.wood@dunelm.org.uk, gitster@pobox.com,
 jackrawlings2011@gmail.com, christian.couder@gmail.com,
 kaartic.sivaraam@gmail.com, usmanakinyemi202@gmail.com
References: <20261107195429.96842-1-tangajoris@gmail.com>
 <20261114012055.127905-1-tangajoris@gmail.com>
Content-Language: en-GB
From: Siddharth Asthana <siddharthasthana31@gmail.com>
In-Reply-To: <20261114012055.127905-1-tangajoris@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 14/11/26 06:50, Tanga Joris wrote:
> When a "diff --git" line is followed by a line that is not a git
> header line, such as a blank line or an indented "new file mode"
> line, parse_git_diff_header() stops right after the "diff --git"
> line. find_header() then treats it as an empty git header and keeps
> looking, as it has done since 206de27efa (git-apply: ignore empty git
> headers, 2005-06-12). It finds the "--- /dev/null" and "+++ b/<path>"
> lines and reads the rest as a traditional patch.
> 
> But parse_git_diff_header() has already set old_name and new_name
> from the "diff --git" line. These names stay in the patch.
> parse_traditional_patch() sets is_new for "--- /dev/null", but it
> does not clear old_name. So "git apply --check" dies on the assertion
> that 5c47f4c6e7 (builtin-apply: accept patch to an empty file,
> 2008-05-17) added to check_preimage():
> 
>    check_preimage: Assertion `patch->is_new <= 0' failed.
> 
> The stale new_name causes the same crash when a deletion with such a
> header is applied with "git apply -R". When such a patch modifies a
> file, it applies. But its "old mode" and "new mode" lines are
> ignored.
> 
> These are corrupt patches. "git diff" does not produce them. So
> report the empty header as an error, instead of reading the patch
> that follows it. This also rejects a "diff --git" line that is
> followed by other text and then a non-git patch, which used to apply.
> A "diff --git" line followed by another "diff --git" line is handled
> as before, because 206de27efa ignores empty headers on purpose. Only
> a patch that is read under an empty header is a problem.
> 
> Reported-by: Gingrspacecadet <jackrawlings2011@gmail.com>
> Helped-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> Signed-off-by: Tanga Joris <tangajoris@gmail.com>
> ---
> Changes since v1:
>   - 1/2 no longer reads the patch that follows an empty "diff --git"
>     line. It reports the empty header as an error instead, as Phillip
>     and Junio suggested:
> 
>       error: corrupt patch: empty "diff --git" header at <file>:<line>
> 
>   - A blank line after "diff --git" in a patch that modifies a file is
>     now rejected too, as Phillip suggested. v1 and master apply it
>     without its "old mode" and "new mode" lines.
>   - One case that works on master is now rejected: a "diff --git" line
>     followed by other text and then a non-git patch.
>   - Dropped the test for an empty "diff --git" section followed by
>     another section. That case behaves as on master, but the test fails
>     under SANITIZE=leak, because of a leak in git_header_name() that is
>     already on master. Also dropped the subdirectory test, which only
>     made sense while the patch was applied.


The leak is actually in parse_git_diff_header(), we overwrite 
patch->def_name without freeing the old value, so it leaks when the 
function runs again for the next "diff --git". A free() before the 
assignment fixes it, and both callers zero the patch first so it's safe. 
Can't we do that in a prep patch and keep the test?

Nit: the notes under "---" describe both patches, so a cover letter with 
"--cover-letter --range-diff=<v2>" would be nicer for v3.

Thanks,
Siddharth


>   - 2/2: the code is unchanged. Its commit message now says why patches
>     made by Git are not affected.
> 
>   apply.c                    | 13 +++++-
>   t/t4133-apply-filenames.sh | 86 ++++++++++++++++++++++++++++++++++++++
>   2 files changed, 98 insertions(+), 1 deletion(-)
> 
> diff --git a/apply.c b/apply.c
> index f00b7ba4d3..c5d4fe7887 100644
> --- a/apply.c
> +++ b/apply.c
> @@ -1604,6 +1604,7 @@ static int find_header(struct apply_state *state,
>   		       struct patch *patch)
>   {
>   	unsigned long offset, len;
> +	int empty_git_hdr_linenr = 0;
>   
>   	patch->is_toplevel_relative = 0;
>   	patch->is_rename = patch->is_copy = 0;
> @@ -1644,6 +1645,7 @@ static int find_header(struct apply_state *state,
>   		 * or mode change, so we handle that specially
>   		 */
>   		if (!memcmp("diff --git ", line, 11)) {
> +			int linenr = state->linenr;
>   			int git_hdr_len = parse_git_diff_header(&state->root,
>   								state->patch_input_file,
>   								&state->linenr,
> @@ -1651,8 +1653,10 @@ static int find_header(struct apply_state *state,
>   								size, patch);
>   			if (git_hdr_len < 0)
>   				return -128;
> -			if (git_hdr_len <= len)
> +			if (git_hdr_len <= len) {
> +				empty_git_hdr_linenr = linenr;
>   				continue;
> +			}
>   			*hdrsize = git_hdr_len;
>   			return offset;
>   		}
> @@ -1670,6 +1674,13 @@ static int find_header(struct apply_state *state,
>   		if (size < nextlen + 14 || memcmp("@@ -", line + len + nextlen, 4))
>   			continue;
>   
> +		/* Git does not write a patch under an empty git header */
> +		if (empty_git_hdr_linenr) {
> +			error(_("corrupt patch: empty \"diff --git\" header at %s:%d"),
> +			      state->patch_input_file, empty_git_hdr_linenr);
> +			return -128;
> +		}
> +
>   		/* Ok, we'll consider it a patch */
>   		if (parse_traditional_patch(state, line, line+len, patch))
>   			return -128;
> diff --git a/t/t4133-apply-filenames.sh b/t/t4133-apply-filenames.sh
> index 3cab1038cf..751a01f92f 100755
> --- a/t/t4133-apply-filenames.sh
> +++ b/t/t4133-apply-filenames.sh
> @@ -60,4 +60,90 @@ test_expect_success 'apply diff with old filename missing from headers' '
>   	test_grep "lacks filename information" err
>   '
>   
> +reject_empty_git_header () {
> +	file=$1 &&
> +	line=$2 &&
> +	shift 2 &&
> +	test_must_fail git apply --check "$@" "$file" 2>err &&
> +	test_grep "corrupt patch: empty \"diff --git\" header at $file:$line" err
> +}
> +
> +test_expect_success 'reject a new file with a blank line after "diff --git"' '
> +	cat >blank_line.diff <<-\EOF &&
> +	diff --git a/f b/f
> +
> +	new file mode 100644
> +	index 0000000..d00491f
> +	--- /dev/null
> +	+++ b/f
> +	@@ -0,0 +1 @@
> +	+1
> +	EOF
> +	reject_empty_git_header blank_line.diff 1 &&
> +	test_must_fail git apply blank_line.diff &&
> +	test_path_is_missing f
> +'
> +
> +test_expect_success 'reject an indented "new file mode" line' '
> +	cat >indented_mode.diff <<-\EOF &&
> +	diff --git a/f b/f
> +	 new file mode 100644
> +	index 0000000..d00491f
> +	--- /dev/null
> +	+++ b/f
> +	@@ -0,0 +1 @@
> +	+1
> +	EOF
> +	reject_empty_git_header indented_mode.diff 1
> +'
> +
> +test_expect_success 'reject a deletion with a blank line after "diff --git"' '
> +	cat >blank_line_delete.diff <<-\EOF &&
> +	diff --git a/f b/f
> +
> +	deleted file mode 100644
> +	index d00491f..0000000
> +	--- a/f
> +	+++ /dev/null
> +	@@ -1 +0,0 @@
> +	-1
> +	EOF
> +	reject_empty_git_header blank_line_delete.diff 1 &&
> +	reject_empty_git_header blank_line_delete.diff 1 -R
> +'
> +
> +test_expect_success 'reject a modification with a blank line after "diff --git"' '
> +	test_when_finished "rm -f g" &&
> +	echo 1 >g &&
> +	cat >blank_line_modify.diff <<-\EOF &&
> +	diff --git a/g b/g
> +
> +	old mode 100644
> +	new mode 100755
> +	index d00491f..0cfbf08
> +	--- a/g
> +	+++ b/g
> +	@@ -1 +1 @@
> +	-1
> +	+2
> +	EOF
> +	reject_empty_git_header blank_line_modify.diff 1 &&
> +	echo 1 >expect &&
> +	test_cmp expect g
> +'
> +
> +test_expect_success 'name the empty "diff --git" line in the error' '
> +	cat >later_line.diff <<-\EOF &&
> +	some text before the patch
> +
> +	diff --git a/f b/f
> +	some text after it
> +	--- /dev/null
> +	+++ b/f
> +	@@ -0,0 +1 @@
> +	+1
> +	EOF
> +	reject_empty_git_header later_line.diff 3
> +'
> +
>   test_done
> 
> base-commit: a018953688f1b10bddf91bff8747068f5f4746a4

