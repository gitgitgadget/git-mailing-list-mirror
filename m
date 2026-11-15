Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794746853;
	b=L3dgPQOZBAnuvxzLWcuUHp7Hv8ZjFSsXeWYLXK1z32n7+f4L2x6WLkcKrIBcIz5jCWTz
	 gMgbgCMHqW7BSJYiG7edp9jBB46i3YRj/QqSCWRHuj8Pj6cUq0pgH5vlAX9CdCoW/fzGA
	 LRNI94BTR3GZeg6C6av5TmgUpKClBmVAUwkrAdhY/FAVr8KV0RvQ6UsA/SFGF6MUjt4Yx
	 5qRxjCrjrjppHLYQI9LRYt50FRTjK/HbYrFUtoEXhtNokb+Rc8PKopqLpRgDBx4IOOa5Q
	 bjdTBP+Bskhc9kHkQhRh+FNDA07Wl7h+szGSHspLm2V06rTtLgllWYlVwzodqwTJhCg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794746853;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=uFGi40dBQV8p84a/Ox3xS17gGo4c/+cQ1JcqpsBIItU=;
	b=4ZPl7rE4jkcMe443itRWl9JuSEr2R7Yf0KVKehTnKdOF+nFkdWto/JLrsVHAF1IS+YBQ
	 Ye2gyIDD09hk29FkIrit8p3sxv7XNRQgk8EO9VbkEKYN58E5kBttGVvmbMsGPjhUpTdNP
	 F+9u2kyG7m8bx9aN3DM6T2Lxsfx9TOqoPLlX6NPQdp5MYBN9SvvHrpmRLjw4pSln9JQHt
	 +HLA+LoSH/F2DNsl1J2ePYRsaxxFHD0DDE5uGrKxiOB7dAD7hVMO+DF+Z1U6bzwcBkZhK
	 1ziHb7xE8Y7BWEh/j6XvAIYUv+1l8IH3ZJWfgzmMsLe/0iQ8fo6WOVcbzHbsoYh746A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=shBt+4Z7;
	arc=none smtp.remote-ip=209.85.215.177
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5834606A31D
	for <git@vger.kernel.org>; Sun, 15 Nov 2026 12:47:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B5834606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=shBt+4Z7
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-cc4aa0246b7so935724a12.3
        for <git@vger.kernel.org>; Sun, 15 Nov 2026 04:47:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794746852; x=1795351652; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uFGi40dBQV8p84a/Ox3xS17gGo4c/+cQ1JcqpsBIItU=;
        b=shBt+4Z7J1rrBLv3JujKwdu4c+mBHCtTq0jL6R6nhg9PG2+ANwp+An3kGvOeH8ZMCz
         1nhc++mZ0h9I23bYmUJTD0tKeo9Voc/qrcsU5a3FtATTC213W63ZNLPjjNAIrcsivtFL
         qNuvklSZZCsmQ+XD4EtgYFumW6pT1oIk3eqO5tJRJbjhVP8rPAZ1AqwznB+VB9GCAVZd
         gU8wccwUngP2eTlbjxqJXElbDe2AO/qqT1s30k0W3tLK5KPKDzE3xxXj5memZdPyD5AT
         z2mjPSckQHx2DZI/10e2D6kUsQ6niVXjEG6MmTnNZLZorPHOUFIeglKUhvdaWO1t0s6d
         tm2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794746852; x=1795351652;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uFGi40dBQV8p84a/Ox3xS17gGo4c/+cQ1JcqpsBIItU=;
        b=psfPNqowRUgmgkdfgBz8QdtMKzs2rjN+ZQ0BzFP7NtHvHcNMvOH4Vgu6lYphHs4FvB
         fkSVZw035rEtoUPBRNICwWdf30eGIcjDPfSY3yfQ12Rdhj6MyFO8rDFWqDO+5Tc4q707
         xM2QBvdo32E4ALj29uIOVe9phYDQyCAFEIKPF0szoehsoo1piReu7k7S7eclYOQz0bhf
         7Em9T5mkXFwjzaB5I+1heJHwYdk2QdMVMqXoLGQXWofGJDVuFVCwGT8lGwQ0LsoejCAE
         s6X0Vkh/BcdJzIPZQgQTDIKRxtm7OPE44NzpC1YkaDFF/riDl5Eyt3/ql6eZkf2YcUWI
         xfVw==
X-Forwarded-Encrypted: i=1; AL+hErHA43E3m9S4jUu06WEey4cSSBjiGatz+rdlNsvEfvbFGCg4oegIS/n8n3R7J6ymOO+XGaY=@vger.kernel.org
X-Gm-Message-State: APuU4Z8c8RjKYzBQCWACr0ziTT8q9JlFRlfNkh1ebaO87orhxAQ+Vc0L
	0MfWJz0U0scmPEwe7d3ZkfLSEvgGdQK6AEt8hqgOp4wvjaP6RMkDFHo9
X-Gm-Gg: AYBFou3dF6MlComPRq+GSOlx5AvoQcP/GLx4RAASXneioR/1uaPVZO0ti0E0eLBDxcj
	QYPla+Y8yRIqn9lbA+iz+cmdVY0Tqzaz0U38E8VE2phBuLdixgfAdVL/K/SWLQhLBlnoGi8L1SY
	63VvZ/RhdOwiR+1H1rA8iwcc58E3+KlXzc/zkj8/VmJQBzpFBm7t8dFhu/JZQz/j9g7hC7bJGOf
	OooRGQo/Of7i3ChJ4oEcNr1hCn9+k+4ka/WpLsrOb2PPfdiizUn/t0ygQf0DVS/jfFiydzqXoin
	lXhBjIxphUU34FI/8i1YZmHjQ9EB2I/N7Bkxn8SL05FZvjl3En+5Atc/SScehWaGW4zUY8jZRx6
	TpK4C8yRGKwWZBje7RnoErYr/mgtpi0I3AIihGr8hQSKp1UG8zP3DrEiX+aLM7PY029woiDp+IE
	ccbn6kMTaQdSXoNCu9076BtxBl0YXoqQVc2q/93ns1gYxLv+PrlZCfxgX9aSqovRgZoVGWyRymW
	lWxf+UEpz1JyXQpg3BME0Ir7rZCK1wwn27Bgegs8FR3Na2q1XWlBhq4DVduS7+fS5SJWUYvFl84
	CCd+JQX9fxC894vFPp70mfqZ53Y2abILfMm84QnBQTVSY7uymY+jx61epTIox6TWY99S9QWpaoz
	pSPPpGoIcQX6gjEUyNbMGrSUX4DNTRFy49doxgt/6NQtdTrHAZO0dFygaDt4IQjynnJjM9cWnS/
	ZZgkCPeHnVaHNWdQyRZU5V505htMomJ9w7l8PBSb1R890gnFGXBI9m+kS0cm6o+ti6URbVqUYNh
	O1GbVRt1o3eMMc/ni7CYg==
X-Received: by 2002:a17:90b:3146:b0:3a4:b0a1:c7ed with SMTP id 98e67ed59e1d1-3b1b09fa56bmr7556736a91.13.1794746851941;
        Sun, 15 Nov 2026 04:47:31 -0800 (PST)
Received: from ?IPV6:2409:40e3:1f1:6974:cdf8:c7c2:79c3:a727? ([2409:40e3:1f1:6974:cdf8:c7c2:79c3:a727])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b197d35525sm17598845a91.16.2026.11.15.04.47.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Nov 2026 04:47:29 -0800 (PST)
Message-ID: <afddef38-8a8e-46bf-b31b-ddebaf39115b@gmail.com>
Date: Sun, 15 Nov 2026 18:17:24 +0530
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
Subject: Re: [Outreachy PATCH v2 2/2] apply: reject new and deleted files that
 have both names
To: Tanga Joris <tangajoris@gmail.com>, git@vger.kernel.org
Cc: phillip.wood@dunelm.org.uk, gitster@pobox.com,
 jackrawlings2011@gmail.com, christian.couder@gmail.com,
 kaartic.sivaraam@gmail.com, usmanakinyemi202@gmail.com
References: <20261107195429.96842-1-tangajoris@gmail.com>
 <20261114012055.127905-1-tangajoris@gmail.com>
 <20261114012055.127905-2-tangajoris@gmail.com>
Content-Language: en-GB
From: Siddharth Asthana <siddharthasthana31@gmail.com>
In-Reply-To: <20261114012055.127905-2-tangajoris@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 14/11/26 06:50, Tanga Joris wrote:
> Git writes "new file mode" or "deleted file mode" before the "---"
> and "+++" lines. The "new file mode" line sets is_new. Then
> gitdiff_oldname() leaves old_name empty for "--- /dev/null".
> 
> When the "---" line comes first, is_new is still 0. So
> gitdiff_verify_name() takes the name on that line as old_name. For
> "--- /dev/null" this gives "dev/null", because one leading directory
> is stripped. The "new file mode" line then sets is_new. The result is
> a new file that also has an old name. "git apply --check" dies on it,
> on the same assertion in check_preimage(). In the same way,
> "+++ /dev/null" before "deleted file mode" gives a deleted file with
> a new name. "git apply -R" dies on that one.
> 
> d70e9c5c8c (apply: check git diffs for mutually exclusive header
> lines, 2017-06-27) made apply report other conflicting header lines,
> instead of leaving them to an assertion. Do the same here. After the
> header is read, reject a new file that has an old name. Reject a
> deleted file that has a new name too.
> 
> Git always writes the mode line first, so patches made by Git are not
> affected. A patch with
> "+++ /dev/null" before "deleted file mode" used to apply without -R.
> It is now rejected too.
> 
> Signed-off-by: Tanga Joris <tangajoris@gmail.com>
> ---
>   apply.c                    | 20 ++++++++++++++++++++
>   t/t4133-apply-filenames.sh | 31 +++++++++++++++++++++++++++++++
>   2 files changed, 51 insertions(+)
> 
> diff --git a/apply.c b/apply.c
> index c5d4fe7887..0fa6a15a65 100644
> --- a/apply.c
> +++ b/apply.c
> @@ -1466,6 +1466,26 @@ int parse_git_diff_header(struct strbuf *root,
>   			      *linenr);
>   		return -128;
>   	}
> +	if (patch->is_new > 0 && patch->old_name) {
> +		if (patch_input_file)
> +			error(_("git diff header for new file %s names an old file %s at %s:%d"),
> +			      patch->new_name, patch->old_name,


Nit: for "--- /dev/null" this prints "names an old file dev/null", but 
the users never write "dev/null", that's what's left after one leading 
component is stripped. And "--- a/f" gives "names an old file f". The 
only way to reach here is a "---" before "new file mode", so can't we 
name that instead of printing the old name? Same for the deleted case 
with "+++" before "deleted file mode".

Thanks,
Siddharth


> +			      patch_input_file, *linenr);
> +		else
> +			error(_("git diff header for new file %s names an old file %s (line %d)"),
> +			      patch->new_name, patch->old_name, *linenr);
> +		return -128;
> +	}
> +	if (patch->is_delete > 0 && patch->new_name) {
> +		if (patch_input_file)
> +			error(_("git diff header for deleted file %s names a new file %s at %s:%d"),
> +			      patch->old_name, patch->new_name,
> +			      patch_input_file, *linenr);
> +		else
> +			error(_("git diff header for deleted file %s names a new file %s (line %d)"),
> +			      patch->old_name, patch->new_name, *linenr);
> +		return -128;
> +	}
>   	patch->is_toplevel_relative = 1;
>   	return offset;
>   }
> diff --git a/t/t4133-apply-filenames.sh b/t/t4133-apply-filenames.sh
> index 751a01f92f..ff48e68da0 100755
> --- a/t/t4133-apply-filenames.sh
> +++ b/t/t4133-apply-filenames.sh
> @@ -146,4 +146,35 @@ test_expect_success 'name the empty "diff --git" line in the error' '
>   	reject_empty_git_header later_line.diff 3
>   '
>   
> +for old in /dev/null a/f
> +do
> +	test_expect_success "reject \"--- $old\" before \"new file mode\"" '
> +		cat >old_before_new.diff <<-EOF &&
> +		diff --git a/f b/f
> +		--- $old
> +		+++ b/f
> +		new file mode 100644
> +		@@ -0,0 +1 @@
> +		+1
> +		EOF
> +		test_must_fail git apply --check old_before_new.diff 2>err &&
> +		test_grep "header for new file f names an old file" err
> +	'
> +done
> +
> +test_expect_success 'reject "+++ /dev/null" before "deleted file mode"' '
> +	cat >new_before_delete.diff <<-\EOF &&
> +	diff --git a/f b/f
> +	--- a/f
> +	+++ /dev/null
> +	deleted file mode 100644
> +	@@ -1 +0,0 @@
> +	-1
> +	EOF
> +	test_must_fail git apply --check new_before_delete.diff 2>err &&
> +	test_grep "header for deleted file f names a new file" err &&
> +	test_must_fail git apply --check -R new_before_delete.diff 2>err &&
> +	test_grep "header for deleted file f names a new file" err
> +'
> +
>   test_done

