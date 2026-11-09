Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794210244;
	b=JG9r3lQ/Em7Pd3/eGbu833xQ4du4lNkrfnXeu2z9Fw6xoxI4rA8pMsfXSso3b1SRM87R
	 uz68CVUdZY3soUf0nDI3Nq6p4p7zR1/B0FbrWt8+r+jD2PI71mWtHUVftOqnqpBx15m8p
	 nAHDBRghPA3zOMLp1s+XtfJQClXAemkQa2/ovxt0Ti03e5uwNEz6QFlngAETF3CNer1SX
	 D5lND4mmMmUd00hrCYHiazsrsJ51Wk1nhMBfmRaYpD/JYAalKaRGA5lhHIXUZDYZICF0d
	 nyu/PHwCdSEiirsJp0mA2cD7UhVOK1VeNZmdgv5AwuzzzpwtycqGNAlP/gP7zl3j//Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794210244;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=v/dZ4WCHOPZwVhwaqakE0J9NIPodXOg4lBCFy0ePPM8=;
	b=h3jOttjSnatX0drpSRVIpx6Tu1IiQZn/Se3cI28DpOB8/m93hC5YYIQJozQ/BAq8Iyvv
	 1EBQx4GmdUkZNA1Uhaf+4JbeSuq/QL0NeqLLMzKQwppyAvcd+QdbsCckfp2HVNLVyI4v4
	 PM1CYDUHiFZXQYjlgLAGJOcvAIme8yTD51i7equR1PGindlnpY9MH8yJwhPZ0jjYhust/
	 f8ZOlyXt333ldVoBDwUylsMjM/78KehSphwIbhn2455l49yw58FzoDiHDtTtv2MIBIxe0
	 qotAKgnzLiFr+CyGq8Q/oOPBCmlC6rdWTQHjfWTPFEYNuQ6cLYyLvtLFbWNMjSvHHTw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=urBJM79Y;
	arc=none smtp.remote-ip=74.125.82.170
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85084606A31C
	for <git@vger.kernel.org>; Mon,  9 Nov 2026 07:44:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 85084606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=urBJM79Y
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-36fc0a3fe93so1197856eec.0
        for <git@vger.kernel.org>; Sun, 08 Nov 2026 23:44:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794210244; x=1794815044; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=v/dZ4WCHOPZwVhwaqakE0J9NIPodXOg4lBCFy0ePPM8=;
        b=urBJM79YRDDgLqCYEAsjslmN35Ldnz7br/ZPNiI/DHbZ8kP3+5J3luynnFWXYPCc30
         CQBWpuy+fs5Jn83ajgg9RlymjbViW2mfY4D2a8kZlKbvuEiNNJ4VhWgI4ffGivfXB57J
         qh4x71kfKeK0jYIZ/k5OawTIqDeThVwVoqIEI2osaL3uiC9IXdsXkORURfLwmTQyu3z6
         FYsbYh6uE25wpa+M6kc7sc6LoUNwhppfCHJkFXRDkHnhczky7Umm/BhqbLb5shABZBI5
         IXVSbmM/Jh5oT27O2q3jUUZLXUfUkC4537eSz0+ozaO/0LqqWb2QQm1NiEFZL7o3n26r
         xccw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794210244; x=1794815044;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=v/dZ4WCHOPZwVhwaqakE0J9NIPodXOg4lBCFy0ePPM8=;
        b=OyODcrXK7Z00qc6DAle3V/hddRlUUgYy33WwSmcqN2jExmlsVFc3d3GU4oN0qRa959
         mSAPXpg15XzDP+1aPpylWyTlL4s/y0S9u4qQo5SQtAwEBTZn63K+0NBTlHG4kfuAHtvZ
         uLc/4ol7uQVtc631Fr2bCp6LeXahMzrHJvv8DvK462sInkuA548IAgD8P2T1c32LRrot
         81grRNgD/oF78dLkyinmeTSLg1yaPLQOBtthndPqx+LxU4ySWw/7rtArBjKE0qX0cGzS
         dm+le4YQLkLMeuiDF8wcnIK3uPML97AzRy641z6/ApiEtLhIsFpIqdygrmdB0b1jlx9t
         ETPQ==
X-Gm-Message-State: APuU4Z8ooIqZ7WutR0ooGLLsyYmKqH5GvBnHTL7eNH01hqZlLJvg95c8
	/KLNeAgdEVnF4uAhF0/+iyT65UCs1uxj6f4fCZxWRr0n1gwGZZyDORyN8HcTRA==
X-Gm-Gg: AYBFou1Vw4/9elt8wxBZ7WD1hIu5zvZ74zlGu1qHdMWukOVw71dVXuB8fhA2jQ38pzo
	80YtSSwtDSePplANbA34j0DmrgZcWguHszq5FKlIPk1PuW1YGH508hsCknE1Ka0Rv202uXCVkOQ
	f7sS3WzBrzB8yQ2zCNPqx+THyI13gYWIqzQKO4by+Z3cD0r8otQ9VmuBA1/fp37qK5h5zTHn1c2
	sAf/dJIKE45YSOPLxZ2VepkHgP8DeS3mEsFk8WW/oXLXJQf7HBO8k2hWzXMaxROYKMM7ECnvpC+
	zQOvY3Q5bS2AcenwIrP2KSCrWINfNGFD+GhbR76PIpyYY31VXXkcpGQ46KFZ/pm7u+/meaGKzRg
	idI/Z08R88/NVUU0kFkft6tLkpb9DoTP2XW870aH73pDV1hRSzYGTsDdRxsSHVBp5OgsKnUkrbT
	ZOn3GGH3k30kNGbFxxFfe9hH5k0Mo+C3xzsNQKGicGSGXcsS3zu/3ElU6qSC1fgIHj47FsGjbw/
	rjQzlnqTg53Cy5Nni1siOe/kQYEPaeZEhp9Crt7AnU+Qx1sQz1Bi62zjEKSgXrFtM/IwoOMMvU7
	LJ5drRjNEwByxZGiAxRf2iRKo2swLtSvt1P56ryB3FI3fj3stesx9zjJwz6d4D6kw33l35vQGw=
	=
X-Received: by 2002:a05:7301:6492:b0:36c:a44c:1763 with SMTP id 5a478bee46e88-372575c63f1mr6247355eec.32.1794210243521;
        Sun, 08 Nov 2026 23:44:03 -0800 (PST)
Received: from Anonymous.localdomain ([152.58.29.17])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-372667d60absm11763451eec.26.2026.11.08.23.44.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 23:44:03 -0800 (PST)
From: Hussain Sitamouwala <husainsitamuwala21@gmail.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] check-ref-format: use parse-options API
Date: Mon,  9 Nov 2026 07:43:52 +0000
Message-ID: <20261109074352.163019-1-husainsitamuwala21@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <CAOLa=ZS3ULcNVjV1DMO-iB+LcC2Gnw+9oU2_7VXKoLvgiVRnbg@mail.gmail.com>
References: <CAOLa=ZS3ULcNVjV1DMO-iB+LcC2Gnw+9oU2_7VXKoLvgiVRnbg@mail.gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Karthik Nayak <karthik.188@gmail.com> writes:

> Seems like Junio's review went unanswered. Which makes it hard for me
> to consider dedicating time to do another review of the newer version.

Hi Karthik, Junio,

Sorry about that. I sent v2 before replying to Junio's review of v1,
and I should have discussed it first. I have now re-read
Documentation/SubmittingPatches and MyFirstContribution, and I will
wait for feedback before sending any further version.

> What is this change about?  More importantly, is it sensible to have
> this and ... another variable with very similar and confusing name

You are right, keeping two usage variables in sync made no sense. v2
has a single builtin_check_ref_format_usage[] array, and
usage_with_options() is used for the error path, so the old string
is gone.

> As can be seen in the usage string ... we still accept "--print" as
> a deprecated synonym but we do not advertise it.

In v2, --print is marked PARSE_OPT_HIDDEN and its help text says it
is a deprecated synonym for --normalize.

> Do we want to barf when the user says
>
>     $ git check-ref-format --no-print --no-normalize
>       --no-refspec-pattern ...

No. v2 adds PARSE_OPT_NONEG to --normalize, --print and
--refspec-pattern. Only --no-allow-onelevel is still accepted, as
before, so the set of accepted options is unchanged.

> The call to show_usage_if_asked() is still here, which means
> "git check-ref-format -h" is intercepted ...

v2 drops that call, so "-h" now goes through parse_options() and the
option list is generated from the table.

I also used PARSE_OPT_STOP_AT_NON_OPTION so that options placed after
<refname> are still rejected, as they were before.

Two behavior differences come with parse_options(), both mentioned in
the commit message: unambiguous abbreviations such as --norm are now
accepted, and "--" may now precede <refname>. If either is unwanted,
I am happy to change it. I ran t1402-check-ref-format.sh and it passes.

I will wait for further comments before preparing v3.

Thanks,
Hussain Sitamouwala
