Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794221555;
	b=ph1NzoDOG8Qw69tYNGnLlS9hU4FoA56LAVK0+Ye1rnffTbzAqDVkcXDGlpcrOAZ38suD
	 UxYGnoXDJnYmZUiChs/KSPtDsugD8dPROXh4pxOCsPLpT3RBInnGP+lyACke4cVYaUcy4
	 gFth+nMq87QQzQ1VzDesimMxz2O1QsVovprQIK5Xvax4RLojhSF6QaHpr8+YovFsc77Y5
	 ov4LWZPTPVDM8Ose1JdEL+Wg+nmMDp4QUUUE1q82NlK7/IGVjQhZSMRx6QamTPtirNJyU
	 +9dbf/oqHNhKktCE+TqPM2DRyRAzfcwpJDePU0J8Gsjo3GV6QKSn75FDLb00wKWT3mQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794221555;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Reply-To:Subject:To:Cc:
	 References:From:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=+L5jMrs2WHbwzdkk1TGaQCG9aLpB7fOBxwFKPudGhIw=;
	b=xQNYiB7ueI4TVQCfLPJ/K7FeVaHK2E/YTqhuuKlpd5NAdaF/WsdBGzBE796f2WFTbDwG
	 0ym3WIEl2RTXhEeiBeMiPRcCa+1lGU1csrun+et3PmvpwkRw/t6yRM01sKk0R1thUHbxu
	 xHtA1A+b8Uuh2y+OThGDfnaaoLwAOInuHmgY/wAuIOOPTeB9y7I1E3Vrb/ZkDVL5A7jZI
	 +Xmh+1PKxolF+439MiIv52+8zaAUCRI61u6TMooiT2r0DbiyPmYcCNQXAyuRqtif4kOIU
	 FbqA+ynpltTw5go0btbCOOE6v+Sv3Z7s0+MtVAF7jfPwpMePlWqTwCWM1G8+iYIbJfA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cgpcrdb8;
	arc=none smtp.remote-ip=209.85.208.53
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37EE0606A31C
	for <git@vger.kernel.org>; Mon,  9 Nov 2026 10:52:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 37EE0606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cgpcrdb8
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6b71b012e3cso689060a12.1
        for <git@vger.kernel.org>; Mon, 09 Nov 2026 02:52:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794221554; x=1794826354; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=+L5jMrs2WHbwzdkk1TGaQCG9aLpB7fOBxwFKPudGhIw=;
        b=cgpcrdb80Rg2Bjs0jo8gdRO6gR1fdWwaYdPBR9PW+Uak04WSVGcxBOe9agqJsq5otA
         YkFtIQ+aoodX/T6WKgA0EoeR+bPYzCaCyNwG8ZBhIafPxSUZYnF5ncmJglhbvUMAhuAT
         x0zxMRU+tJJKcIiBYTj7yqmvzWyoys3CUTRkiODQW20fTM8ub2VvwjUWg5xS27xCn83f
         T7+RwyOQUvnX4cVdDMBlPYZ9u79O3xTKonrrBDMKL4Dhdfrz+SKDaQB4KJ3BJ1xl7mw1
         9RTGHuqybkLNlcalX2jEQPDe1yUIcMtPREo3eBXAkh348g4rqsAKbKnlHI9hczMvqCfy
         fsbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794221554; x=1794826354;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+L5jMrs2WHbwzdkk1TGaQCG9aLpB7fOBxwFKPudGhIw=;
        b=CnO0lZzVEGAAzugKx+rtnO7O1OCjYxeOVAJqyxrhNwtDf6tkeINNTOJt9Fq5GX3Xni
         tAJhXzn0F/1/VxHinT8vtBiMCyVPK1T7F2hogdngHzJwds4SXsq+aKLkhZ2ApS/AQUYW
         rNbvPjDqxLl6hSerxXvNoXTJuwBB1nL6Q0eBQM1A8DQX6kMpwq5J8eB4bR1zPyRrBRRY
         LQomTbk/qwsbHWGseZM1LDyw6FB7tvfJurundZbKfnq+gloeFSLC+eChqu/iVk4ahZC7
         lEoDouuV7Z5EQMrBnYvzoPHfTN5hVrhr5vgm5aVAky/QkWu2VtajHjwVTH0hNumDnxUZ
         TVUw==
X-Forwarded-Encrypted: i=1; AL+hErHbAQAuME4+MTBnBdj/IKf7JYMQeuQEQJx/0h4q33DXUg/GcK4DnbJsMd72WAMltJrZ4tI=@vger.kernel.org
X-Gm-Message-State: APuU4Z/P/QThqQYe4zLuY5xuW64ujVsySXA6pgrMux5DiKykZKfgsJOJ
	FACaPQAIwDAOKwXG1iSkr5IVDUTE9MU1ilAhyqYTt8eJ+uk/mRsDcKUj
X-Gm-Gg: AYBFou0PRUVP0QuPNJ9PZJPaXfx3eG3m9HUtoM/YWjXqsgCwBvszA2iIyNHxAYEruLl
	MuJM8C38gvd6T0+L3uiqMMIzG9cnqdv1NK+6i5lUEiSnndI4+F/ffBw7D4Xq6j/puYRhPSzJhEh
	wUn7yAZAoDLix25fslxFKCxGKl3frXuaH+xiwtGSvY9r4T1DEVQh5pXmM8/7fYx9O3Thbjksui1
	5t0HJZ+cqqcUJqae+vycKZ/sECcGpZR+nnxw0G8eP7fbyffQGJve2LjbhRg5/03SyvjReV659PA
	y7XPVYBkVjTZT97RXX6iIdOoCSTruVGDTN5CMWw5pP55bvYB+QK5CW5gU+CAAXaIBkkw9WpzoxI
	pONOEt9S6/Y9rBv/iaGO0xVrFJKNCZsyUfD9jJ3k6/ZJNIJ2Qwv9bhCXNteWf0OF4rPsS4cyRh8
	GDfQlt04bqMsVP92oZNv3n3QsgEVQUjyBJBnHPjfaTjA9XHkPV1ulw4H5TlH3V6BGEjox+XRgG8
	D7HR4ESKCem+2WSAJ9CNHWTd7C2dWYXJev27O03sSnHOMT4oqsfQ0YrDhhwJx6wgcQ1/slMj8UP
	WUOkz2tN4XD+cYugOrSIsmxMU/Ca7yRQfIKh2RX6TEnKf1hVPhUvpyIOtgO61dJ1yR9+wu5+laH
	HKsdNZA==
X-Received: by 2002:a05:6402:1f12:b0:6b5:90b9:e1f4 with SMTP id 4fb4d7f45d1cf-6b7223fef05mr2327040a12.15.1794221553515;
        Mon, 09 Nov 2026 02:52:33 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f? ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b721eedd40sm1394293a12.32.2026.11.09.02.52.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Nov 2026 02:52:33 -0800 (PST)
Message-ID: <7bd3360a-fb96-4631-8670-dde0d281532c@gmail.com>
Date: Mon, 9 Nov 2026 10:52:28 +0000
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
Subject: Re: [Outreachy PATCH 1/2] apply: do not keep names from an unused
 "diff --git" line
To: Tanga Joris <tangajoris@gmail.com>, git@vger.kernel.org
Cc: gitster@pobox.com, jackrawlings2011@gmail.com,
 christian.couder@gmail.com, siddharthasthana31@gmail.com,
 kaartic.sivaraam@gmail.com, usmanakinyemi202@gmail.com
References: <CALdwsC1cMKZgRPZA+pBaJe4PPs9q9W0K9CQLmM2bgUCyysTB-w@mail.gmail.com>
 <20261107195429.96842-1-tangajoris@gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <20261107195429.96842-1-tangajoris@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Tanga

On 07/11/2026 19:54, Tanga Joris wrote:
> When a "diff --git" line is followed by a line that is not a git
> header line, such as a blank line or an indented "new file mode"
> line,

These sound like corrupt patches which we should be rejecting with a 
better error message, rather than applying.

> +test_expect_success 'apply new file with a blank line after "diff --git"' '
> +	test_when_finished "rm -f f" &&
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

To me this looks like a corrupt patch because we have a blank line after 
the "diff --git" header followed by valid extended diff headers. Now 
that we accept this do we respect the file mode?

> +test_expect_success 'apply new file with an indented "new file mode" line' '
> +	test_when_finished "rm -f f" &&
> +	cat >indented_mode.diff <<-\EOF &&
> +	diff --git a/f b/f
> +	 new file mode 100644

This looks like a corrupt patch as well where a space has been 
accidentally introduced at the start of the line.

> +test_expect_success 'ignore an empty "diff --git" section' '
> +	test_when_finished "rm -f g" &&
> +	echo 1 >g &&
> +	cat >empty_section.diff <<-\EOF &&
> +	diff --git a/f b/f
> +	diff --git a/g b/g
> +	index d00491f..0cfbf08 100644
> +	--- a/g
> +	+++ b/g
> +	@@ -1 +1 @@
> +	-1
> +	+2
> +	EOF

This is the only one that I think it is reasonable to accept - we have 
an empty patch for "f" followed by a valid patch for "g"

Thanks

Phillip

