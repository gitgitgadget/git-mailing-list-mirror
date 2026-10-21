Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792595600;
	b=zmibR+k2BXStIJgeukCRKHJCK1BLSIXQsTDcYjfR7qcpWvCc9dFdtxiBVy9aeM9M4dLI
	 hoJCrmvOXJIYuIkCz7RHXahrh/a6gtlTJbd546DtEXRv8wrIzG5lEQAEfE4hvGHHh3eSr
	 s6qb6tuxM5PTWZIf+l5zRqOm/B5otdELH+HZ2ItlygAcFIxnKaDxbfxdsCAPnnXvb+F2B
	 CH1rM7L63K9NFxnEhmNqBzsfUJYgwhtkVqjBUpTDPTMtimjpULiUv3bW0D06z2jshwhFL
	 YmDHdlzlYfe+FS16Zw7ztW1YHKde5v3a/MPEBH40eiaLS/Ak03wceSpvHuGjm10Zz2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792595600;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Reply-To:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=8QX3pGX4wtBrrmajgq6lWYpcuJJpdctGJKs7QlvtA6Y=;
	b=IZuMgZittxN1wPN8RJeaOwvswhkvTtRAKoQSCkavW23CWfegqFJndH/jCgcxHFIQZCF2
	 55YYKLAjmYTghF3nNAPRZOTyvkFIegbCMCnogMutYPhVG8EhwlzuXp29+ZuR+nPtQa55m
	 DS+SF4aw+03cGz+qA027HEVDB+K3zn8Lyuts6fVEpuQUN9qzwVqg/Uv7N7LFMBKbwqnkT
	 xOBEx3Q5K93g/5E2Ke8AW53Gpdaxd4tSpdBiQArpdTC4bAUbXoP1zsQXwxqbLEwphVSPx
	 R0AYdq+IThon5DIFn5ck3ObuhmmF8H3v/Uj41DJx5J2hcH4B+hhOf7HZi5v+6GcjEeQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="X7vAeno/";
	arc=none smtp.remote-ip=209.85.128.44
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F6AE606A319
	for <git@vger.kernel.org>; Wed, 21 Oct 2026 15:13:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1F6AE606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=X7vAeno/
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-49d0da752ffso7160855e9.3
        for <git@vger.kernel.org>; Wed, 21 Oct 2026 08:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792595598; x=1793200398; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=8QX3pGX4wtBrrmajgq6lWYpcuJJpdctGJKs7QlvtA6Y=;
        b=X7vAeno/acTEF7hUScQA71csc/uILpj9zuoNQlIaSDz9KMajX1niQJUjnqnxLbXmZO
         HAnmInVtZWI0rhWyDhHyQT2K4rmdF0K7UFITwfJGmNUuAUM8z1fTWQKlwRUIyXq7hbBW
         KdxkMUHdmqXsPzjP2cqvgW4SZuYtRphunzsFTG9QGUlG0maNZE2wtOOLu27XwDRqk9/3
         NNeEoSlmJWGz86GQduJ7saGwQbG2izgzZuouKpuYdxzXS9b2kPG1VzNf4IrWnSkeixuU
         GFEJJQpkZmIgYOpnM38ujPM7oMp3rT3ZSAhZdiIxTbJSIYtxR5Owr/mFzg0f5jcTKHXx
         958A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792595598; x=1793200398;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=8QX3pGX4wtBrrmajgq6lWYpcuJJpdctGJKs7QlvtA6Y=;
        b=vRpTteL14aW87jJBhXI9QZ3akWNxPRbX/835XDoBddKq3U7ngcDdDDVA4qclfvm9ON
         3JsGRxKJK/bYeAKU8Oje3jqNo6BTRb4LcTrat/ZVdV2QYTjioAdcBVsNBpVgBT3Ub3is
         NQgESqVX43sXMm2acw2nzyvm1kLBsYlGoEZBmY6dyOAS4IcMkVrc1BsyXP6i6NjR4fSn
         wb7eV1g3ULUR0C7PhZadr9klZ2xGrAe/fD22JmtjMLdS3IiArYrLUBkz4cvA/S8zMKcN
         JBYjlViFlGTMjFPaB+JMOclkTuF0ejZwhektNoKReJD9d91Q5a/PFl+Ac6j/j9I3AkjM
         Agrw==
X-Forwarded-Encrypted: i=1; AKwUvBy1ym9fkG67nPHTKcMpaQ9EsYU00yt320SEP7fNmrE7L9NOypxfRxyzMMElgaFyrud6WjI=@vger.kernel.org
X-Gm-Message-State: AFq9FYKfjx81SWGsUSg//oFL8fA1g+asfyZsizcUeUmxbPxqcF0Riqc3
	dKII7THi1x9wp5azQEcPXZvVseFcxqirTd39SvWITlT/Ffmx/Ja70inF6h8pDw==
X-Gm-Gg: AYBFou0FoIjb1IvT3KurbKQ4LPbiswNOMHPFHs2oTB9VnEpHIFaaIyP2JOde93DVOxE
	wPaNInABBpKEdgR4EOp4zmMLtEOFFrT8UCy08nlig+nqo5qcP4w+kVSuKKmLiBK4IXD4QMneDAx
	ldikKQySWy90QddxwGEtflqThCFREQ/B+/RE0cJPUSOERNY7wg5Z2qniY9rDnGDhf8ffM4dUgit
	Wp3bqTJl6DQuX+uirQeoEdW/Qw4T+Z2p9UwE8+xA3fPon1i+LHIpYwuwM/auA/H7LTYk3lKeMjz
	ijReP+QU+WqKKe4juoRgj2bQwuMbABfBZP/rm/xQbh8hia3xIVAcDlxGUk0Hi8lxOAupFFZwX2R
	3SEtrpLxgoi6lmL3xaD30ianDR15Jl49qWs98POunhGBSXUIJOiUwQfrlGImQqq7afjC43q+5Bc
	XnO25CltJWGrgeCn4cAKhoUtXDtKLyViOxEt7+7ZpHETPI59zMzKlkMB3+gL12wuUYvAlqDRnaz
	YPkRxlyNnWlIaIsb/rUR5Hnb/EbAP6GDJ74d95jz5tv/LfHVkbBIrkf8RCQwukDVtT3S3hyuUhK
	//nOzy/65O+WSirLVmi2vysqQNK3BHbhRg==
X-Received: by 2002:a05:600c:4ecb:b0:4a1:a475:d885 with SMTP id 5b1f17b1804b1-4a1fdd24cf6mr50025105e9.34.1792595598248;
        Wed, 21 Oct 2026 08:13:18 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f? ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1fab85fc8sm99969985e9.14.2026.10.21.08.13.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Oct 2026 08:13:17 -0700 (PDT)
Message-ID: <ba174a25-f7bc-4a5d-918c-87229b2fb5f6@gmail.com>
Date: Wed, 21 Oct 2026 16:13:16 +0100
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
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 0/2] commit: allow -m/-F/-c/-C for all --fixup
 variations
To: erik@cervined.in, git@vger.kernel.org
Cc: gitster@pobox.com
References: <cover.1779792311.git.erik@cervined.in>
 <cover.1790082176.git.erik@cervined.in>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <cover.1790082176.git.erik@cervined.in>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Erik

Sorry it has taken me so long to get round to commenting on these 
patches. I think that supporting -m and -F with --fixup is useful and I 
cannot see a reason not to support -C as well. I've left a couple of 
comments, but the only thing I'm really worried about is calling 
test_set_editor() outside of a subshell in the second patch.

Thanks

Phillip

On 22/09/2026 14:04, erik@cervined.in wrote:
> From: Erik Cervin-Edin <erik@cervined.in>
> 
> Changes since v2:
> 
>    * 2/2: Junio noted [1] that after dropping --fixup from the
>      -C/-c/--fixup incompatibility check, what remained (-C, -c, -F)
>      was already rejected by the neighbouring die_for_incompatible_opt4()
>      that groups those options with -m.  The check is now removed
>      entirely instead of being narrowed.
> 
>    * 2/2: reworded the log message to lead with why -c/-C are the odd
>      ones out once 1/2 is in place, rather than with the check that
>      happened to block them.
> 
>    * Rebased onto current master.  1/2 is unchanged apart from that.
> 
> Background
> ----------
> 
> Today only -m works with plain --fixup, and neither -m nor -F works
> with --fixup=amend: or --fixup=reword:, which makes those modes
> awkward to drive non-interactively.  1/2 threads -m and -F through
> prepare_to_commit() for all --fixup variations.  2/2 does the same for
> -c/-C, which were blocked by the same incompatibility check that
> caught -F, so that all four message sources behave consistently across
> the plain, amend, and reword forms.
> 
> 2/2 lives in its own patch and I won't object if reviewers would
> rather drop it or take it separately.
> 
> A note on one design decision in 2/2.  -c/-C go through
> prepare_amend_commit(), so if the source commit is itself an "amend!"
> commit, its subject line is dropped and only the body is copied.  This
> is what a no-source --fixup=amend:<commit> already does.
> 
> I kept that on purpose.  Under --fixup the subject is always generated
> by git, so whatever -C supplies ends up in the body, and the body of an
> amend! commit is the message destined for its target.  Copying the
> "amend! X" line along with it would leave that line in the final
> message after autosquash.  It also means
> 
>      git commit --fixup=amend:foo -C foo
> 
> and
> 
>      GIT_EDITOR=: git commit --fixup=amend:foo
> 
> produce the same commit.
> 
> The helper only knows about "amend!" and not "fixup!" or "squash!".
> That is pre-existing and I have left it alone here.
> 
> The v1 -> v2 changes (refactoring prepare_to_commit() instead of the
> special-cased file slurp in cmd_commit(), extending scope to -c/-C,
> and the smaller review fixes) are described in the v2 cover letter [2].
> 
> [1] https://lore.kernel.org/git/xmqq1pbkefh0.fsf@gitster.g/
> [2] https://lore.kernel.org/git/cover.1779792311.git.erik@cervined.in/
> 
> Erik Cervin-Edin (2):
>    commit: allow -m/-F for all kinds of --fixup
>    commit: allow -c/-C for all kinds of --fixup
> 
>   Documentation/git-commit.adoc             |  22 +++--
>   builtin/commit.c                          |  40 ++++----
>   t/t7500-commit-template-squash-signoff.sh | 114 +++++++++++++++++++---
>   3 files changed, 131 insertions(+), 45 deletions(-)
> 
> Range-diff against v2:
> 1:  e9f07d49ee = 1:  4581f97cb7 commit: allow -m/-F for all kinds of --fixup
> 2:  b3fc743abf ! 2:  39e408e147 commit: allow -c/-C for all kinds of --fixup
>      @@ Metadata
>        ## Commit message ##
>           commit: allow -c/-C for all kinds of --fixup
>       
>      -    The previous commit allowed -m and -F for all --fixup variations.  The
>      -    -c/-C flags were blocked by the same higher-layer incompatibility check
>      -    that previously caught -F, namely die_for_incompatible_opt4() grouping
>      -    them with --fixup.
>      +    The fixup code path in prepare_to_commit() only knows how to take a
>      +    message body from -m or -F.  Now that the previous commit allows -m and
>      +    -F for all --fixup variations, -c/-C are the odd ones out.
>       
>      -    Drop --fixup from that check and route the resolved commit through
>      -    prepare_amend_commit() in the fixup path, mirroring the no-message-source
>      -    behaviour of --fixup=amend.  With this in place, -m/-F/-c/-C all behave
>      -    consistently across the plain, amend, and reword --fixup forms.
>      +    Teach the fixup path to look up the ref given to -c/-C and seed its
>      +    message when preparing to amend the commit, mirroring what --fixup=amend
>      +    does when no message source is given.  With this in place, -m/-F/-c/-C
>      +    all behave consistently across the plain, amend, and reword --fixup
>      +    forms.
>       
>      +    The incompatibility check grouping -C, -c, and --fixup can go away
>      +    entirely, as -C and -c are already rejected together by the check that
>      +    groups them with -m and -F.
>      +
>      +    Helped-by: Junio C Hamano <gitster@pobox.com>
>           Signed-off-by: Erik Cervin-Edin <erik@cervined.in>
>       
>        ## Documentation/git-commit.adoc ##
>      @@ builtin/commit.c: static int prepare_to_commit(const char *index_file, const cha
>        			prepare_amend_commit(commit, &sb, &ctx);
>        		}
>       @@ builtin/commit.c: static int parse_and_validate_options(int argc, const char *argv[],
>      + 	}
>      + 	if (fixup_message && squash_message)
>        		die(_("options '%s' and '%s' cannot be used together"), "--squash", "--fixup");
>      - 	die_for_incompatible_opt3(!!use_message, "-C",
>      - 				  !!edit_message, "-c",
>      +-	die_for_incompatible_opt3(!!use_message, "-C",
>      +-				  !!edit_message, "-c",
>       -				  !!fixup_message, "--fixup");
>      -+				  !!logfile, "-F");
>        	die_for_incompatible_opt4(have_option_m, "-m",
>        				  !!edit_message, "-c",
>        				  !!use_message, "-C",
> 
> base-commit: d38352cd43ab9745686d697872408bc3249a153f

