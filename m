Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A41322FDE6
	for <git@vger.kernel.org>; Mon, 25 May 2026 16:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779724934; cv=none; b=MRWNakrDDMBvDIoJdWGaznn/vbpAdPi33eFdHuQugxfAW5uXLON4pPdhW8fBDwZN/35fgrqexDjbrbAeV+p34z8OTPRoiT8Y1mHsAj7nWwF9wMTxr3x5jMFV1fIJyFe4CQuebCGTf3gNZPSGa7D3uWzF9d8P+fekE2S5eP1ujTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779724934; c=relaxed/simple;
	bh=ogfmQlqu9gNTW6ZbILO1x+VtvYBVuQqADkdNAGvl0T0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K9nRBtgvSEjp3N4PujRcM4i/JArvVOICC28NHMRJToEdOEbIWUMU4SJKX+x0YcQ1lf27/qLcYXhyWGaEhTF7yX0PVnNBvlu6gE4qClBYMuMH6ziNdevYzM07Zd17L7AwTNs1SfBFx2BaW6M3XURJWJ1ClmHRcCAkVDw4f1uXG1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HpvZV/+E; arc=none smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HpvZV/+E"
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-95d439bd3a5so2314605241.3
        for <git@vger.kernel.org>; Mon, 25 May 2026 09:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779724932; x=1780329732; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+8vWaUDZavKtwUQNPAI5Cji3suytdcFt3v2Az9uSWI8=;
        b=HpvZV/+EzSDi00yTM+bfdfyIHMjTS0qd/6gB2SXJU2jd5W1wBkLLyLbtpsuiq1+U8A
         XX5wLaXUg+DchvQP7H37lfQZScr4EQYf4n6BnfUqkfV2KnjXQ7aj2Wva6X7am4sDk6fK
         4wz0gCAGtttSUaFEK+/a9evbxGbAg4e+hzNUUEd5ui4Bp2pr8OzgRpiuO5TY5ud3pmH6
         pcE/xU71MWP7KkJtsDlGNXoycKi6QPIarM/eVDkUqHZD/fUxBoXLA27WI9YI6P6/Vubx
         thxcUqeTp4EGO34kaWejGtowqgeyYkNHQXQPKUr4zmOH9erDCw7mYwaEXFZOkfLyvh28
         D/Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779724932; x=1780329732;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+8vWaUDZavKtwUQNPAI5Cji3suytdcFt3v2Az9uSWI8=;
        b=Q/W0DUkCVOVd7ScSRBxeQdgrfrbaS/xWKwKBvEWGhQwpTw2GXo78Rtfum64BSjyMY4
         fieihngPFBt16yYLJL93ur3QcJJImVwcFIyHtnj16b/vide/3pad35WSbLvgATpF8or4
         qhER/LDvXS3y/2qwXZ+hZ3rkPrQxKnhUvd4uBO+QcKARXs+7w4ToZevUc5e8HnFtIQET
         +jnxZFY+EyHpZcsaoRpieDt3OXzH1uak+pNvIb+j0OCxFrSbpyLNoGGTJ3qnxRKeNFv3
         dU+e5Suf70pyjSmfeJIzhSKJGpPgyrTVSFKpOd7BnNncA6ggj6ZiV+GJjxthRWVeqUhJ
         0sIQ==
X-Forwarded-Encrypted: i=1; AFNElJ9IHU6FYuxctyXORshQ3TTxd2DMFAX5UG6MP/mlSYhKxViazQFGG+PwMqnvF6tBKb7aE44=@vger.kernel.org
X-Gm-Message-State: AOJu0YyljCgf6bUg3eo2i2HM10PABbWRm7MGVpIhkZDZJj0D3Iz/mFrZ
	QVsNFK++0jXsQs6mKvHT/qFo1kUCVtmJfRDT5zAFvcW1FuEZEUCxpo7PvIc5bniT
X-Gm-Gg: Acq92OHA3Jse0BtOZ74hMrtvdUrTpNY40bBnriP35q6E1Xf5l9ORsyOeDwW0I4SX1yR
	2AkivSyApfctZVMSJryKu0/sOSzgKaAvR7A4MslHnN5aN7arADmKzLaFBIgF/ZG2cIvz+c1081b
	D93u+uczB4zPoOQ77GdoFnD58kahizCJQz5uOZwpdR5wYb6I4JHBC2fblEOJ8tdb1XsUpTaGGqM
	0TfdxDtl/CiIvA1yTLs60CSzAwDx9MeZjod3s/Vm110KY402HsIRGal1iEUEJIdPDea3i9nM4eb
	uyD8+4Q/qm7228wb6mGKgLD1gkclfsB0/PRIC5nKYm493aBbYJRWP3NNcF/cXB8IgtvbhfTEi9u
	lv37PvDb53AR4ppErR5FLRuCuS5Bgqv1XPHPju5trr4mgA8KL2p6vAUB51OL+rYCK2dKf9+O4eB
	gSXQY9eEicdIF8YlNFtkJOrsr6btAnSth2QSYsCibmXF+Hc+tBDrH3hT5L90pTgHnWczVkePs=
X-Received: by 2002:a05:6102:3f8e:b0:607:97b7:c283 with SMTP id ada2fe7eead31-67c7fff0701mr6581573137.14.1779724931527;
        Mon, 25 May 2026 09:02:11 -0700 (PDT)
Received: from ?IPV6:2600:4040:264b:4100:d17e:f99:a560:8cad? ([2600:4040:264b:4100:d17e:f99:a560:8cad])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-914bb8cd286sm1057673785a.3.2026.05.25.09.02.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 May 2026 09:02:10 -0700 (PDT)
Message-ID: <3cb066ca-0d1f-4197-ae96-050e94db2453@gmail.com>
Date: Mon, 25 May 2026 12:02:10 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/11] Improve git gui operation without a worktree
To: Johannes Sixt <j6t@kdbg.org>
Cc: egg_mushroomcow@foxmail.com, bootaina702@gmail.com, git@vger.kernel.org
References: <20260514143322.865587-1-mlevedahl@gmail.com>
 <20260520202411.108764-1-mlevedahl@gmail.com>
 <43f070e4-e624-4a33-8c24-294520fb503a@kdbg.org>
Content-Language: en-US
From: Mark Levedahl <mlevedahl@gmail.com>
In-Reply-To: <43f070e4-e624-4a33-8c24-294520fb503a@kdbg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/24/26 3:16 AM, Johannes Sixt wrote:
> Am 20.05.26 um 22:23 schrieb Mark Levedahl:
> I've completed my review of this iteration.
>
> Repository and working tree discovery is already converging fast.
> However, I have issues with the proposed argument parsing of the browser
> and blame modes, in particular, I don't think that we need to
> accommodate the uncanny file-before-rev argument order and that it
> disregards the worktree completely. Maybe we should postpone any changes
> in this area, if possible?
I'm not willing to give up on browser/blame yet: making these work without a worktree was
my motivator to start this series. Ignoring implementation details, etc., the issues I see
here are:

The undocumented feature to accept rev / path or path / rev, as does git blame. The latter
at least has a comment on what is expected in the code, but no mention of this exists in
blames man-page, nor that of any other git command I've examined. I'd prefer to just
remove it, I'll take your comment above as agreement in principal.

browser and blame are both fundamentally about git history. Considering browser.tcl and
blame.tcl, which produce the displays:

browser shows only content from a tree in a commit. It never uses any information from a
worktree. Given a non-existent path (or a non-existent rev),
browser displays an empty window, not an error message.

blame can take content from a file in a commit, or from the worktree as long as the file
is in a commit. A modified file in the worktree has changed / added lines annotated as
uncommitted work. But, given a file not in rev, blame displays the file with no
annotations at all, not as uncommitted work, and no error message.

So. both blame and browser require that $path is contained in $rev, even if $rev defaults
to HEAD.
The parser never checks this, though.

These commands, that *should* work fine without a worktree do not. and display confusing
information (e.g., a blank browser window, or unannotated file) when a simple error
message from the parser would convey more information.

>
> Throughout, we use a strange indentation style of 'if {[catch ...' that
> is violated in new code, but I left uncommented. It should indent the
> catch body one additional level like so:
>
> 	if {catch {
> 			commands that can fail
> 		} err]} {
> 		error handling here
> 	}
Yes, just count the number of { - number of }. Vim's indent mode for tcl gets this very
wrong. All fixed, I hope.
>
> Thank you very much for working on this topic.
and thank you for the very thorough review.
>
> -- Hannes
>

