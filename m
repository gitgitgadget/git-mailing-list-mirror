Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B9B9604D3
	for <git@vger.kernel.org>; Wed, 17 Apr 2024 07:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713338210; cv=none; b=WVbswQdCA85ZwDFujnOHJ5fo2NEiWDE+wjXTYv65X/ckTwPy+7Lgjs73UUPLopA7okN/agZ7SuSCUOrCuqB+D+GaVGDy6xYIw24v5l97p0TvZo1lZ2gHrkiaqcFqkjkkX5WH/zdEVRC9Y5i7PVw0FHnnWdBQK1irKSImyFMMIWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713338210; c=relaxed/simple;
	bh=ch634JoVeoQrGRArvY6aipfhxf+SovnuqgGmP3bfVjk=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=gXEND4eDYd8Ua8uFqTrAw2Cm9dPbnJyUJrZAsVPy2KOZhIXJXIFHiMNuOdkFJr9vtwo9n9Ta/phXYo6BlDITmtbwQ3TUzRl57+Vpg8tzPqAPxsMWdtz8qZZGj5eUWjGfoDsp6l/uNUHMh6eBxAaBYVh2Jqbn6izPgQI/YVhT2io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=PGVXrJd7; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="PGVXrJd7"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1713338206;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qXonRNRmlwCMBiIQT0J2XzWWx+QDWEojwTnRDYx5+SY=;
	b=PGVXrJd7j8iN/RD0AOI5EvCuzqaFsrL2Iuw4HnksKZoc+R9LG3xdm1SLEJcv3Thc2ydvR6
	6osEsD5naPFgvTQ8XlwRhASyJ0UUalG9xnfxg9uEsUPb+8Bl2A1Od49hm+l7Wyvnd1PxxF
	P7gaD+5Hvrl5vFqgOHkgHWby23dRN99O6Jkv9A1foHXyF7j/HkJZUa7bVtmEroe8xAtMX0
	VidYk9+VtZzpYSBRsm1DqByr59iR6E6opG1LkqK+MlU6ogsYrrHH6slGvI3kMHf/wjkpy6
	EnRgOOQ5E2nCi2Fagfp0/RfPAmIuLdAzjpoTa5OoKqY3K+kUsnC+9hf97GbWZQ==
Date: Wed, 17 Apr 2024 09:16:46 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Kristoffer Haugsbakk <code@khaugsbakk.name>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 3/4] format-patch: new --resend option for adding "RESEND"
 to patch subjects
In-Reply-To: <f054eb17-2eea-40f5-b201-92432aa0ad9c@app.fastmail.com>
References: <cover.1713324598.git.dsimic@manjaro.org>
 <1d9c6ce3df714211889453c245485d46b43edff6.1713324598.git.dsimic@manjaro.org>
 <556d4baa-14f9-485a-8db3-0c9a966351a7@app.fastmail.com>
 <4aa0754ee62d78ca9300eb709df561b3@manjaro.org>
 <f054eb17-2eea-40f5-b201-92432aa0ad9c@app.fastmail.com>
Message-ID: <60927cebd6128ee490c826d010e52da2@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-04-17 08:43, Kristoffer Haugsbakk wrote:
> On Wed, Apr 17, 2024, at 08:36, Dragan Simic wrote:
>> It also doesn't use imperative mood.
> 
> The sentence describes what the option does (usage). It doesn’t explain
> what the commit message does. In context:
> 
>     Teach format-patch about --resend
> 
>     --resend adds "RESEND" to the subject prefix (producing "PATCH
>     RESEND" by default).

Frankly, I don't like the "teach abc xyz" wording very much.  It isn't
some intelligent being to be taught something new. :)  That's just my
personal preference, of course.

Furthermore, starting a sentence with "--resend" isn't very good.  
Please
note that you're still using parenthesis, for which I already explained
why they should be avoided.
