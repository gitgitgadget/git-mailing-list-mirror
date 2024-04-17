Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F157A6A339
	for <git@vger.kernel.org>; Wed, 17 Apr 2024 07:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713338763; cv=none; b=aoVmTaUta2mdHTw62jp5VbGSnTHem77UkPv61a71azqmk4TxiqmK99CSKp+Sg5UMXEE73oulcejSnIK1TjWpQ5BCEkbhLG/nSTgfi3VnogQvNQxxlvBGvjT7EyYomkdC+inc5S0NYBER5c5vKigXJyjwHPebkXohD9GVWl3fuEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713338763; c=relaxed/simple;
	bh=GNvHJ17vsBs7mRp+zwVX3bh89Bx0lvy77DB0OuDjWvA=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=ASlhsHbTyhj5xe33QAYrzUFnjm/zqlDDb6T22JLqopFwpXju6pZSCIgwzOfbcioMSheR7xdAFmJR0/QbCyOk7xkpJ2Nro1mToaUvwAaq6lwcJI7mRUpdo5lzAsbmtqhnahCHrD5u9rk/HWyPjX7jznR9y096uzsyhQnvL4A67ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=hXTPtij+; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="hXTPtij+"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1713338759;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3kgL3zI+ezuGXjnkllk8uJ4rMU8qrA4JEdKQKt645J0=;
	b=hXTPtij+wdB2wcXPfOedlW1r9+DCVmb2V1z+sG1PmtamJ+yoDeLZN1pVgUCgmu6BY7g0ab
	KzDeYabUSTWWjZaSIrI66xjXcuhwFcfwIcDWH7lUxKqAFomIXgr8fDgSQHmO9v5H1JpGGv
	DVCjaFPOO6HjpwvUa72B7dLsnX91Fwo4Sc7wyz/oDWiq1e+gu20rpeD1UQuGexsFaDUbLI
	t7eGLvBn1JS1Jn1qlBRJL6fx+UWReziccMWAXSJqKg52qHWK7qRXULC5zZ4J6+QKrL6bMC
	A8QQm2qi3bPn+KqgxFCGdUxop+0b7g5eLyJuaV62fnCUtEG1uSRcCfUYuPV0RA==
Date: Wed, 17 Apr 2024 09:25:59 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 3/4] format-patch: new --resend option for adding "RESEND"
 to patch subjects
In-Reply-To: <CAPig+cRPUQW5ux7oKwDO5Nu46fRHrs6LrUoxnFvX9D9oNjqteg@mail.gmail.com>
References: <cover.1713324598.git.dsimic@manjaro.org>
 <1d9c6ce3df714211889453c245485d46b43edff6.1713324598.git.dsimic@manjaro.org>
 <CAPig+cRzOHROK0VpkLR9fk7Gr0NRH9VKcH4dGXOuoaO5Ky2c2A@mail.gmail.com>
 <a0b93341380c2157f6b87e19129abb49@manjaro.org>
 <CAPig+cRPUQW5ux7oKwDO5Nu46fRHrs6LrUoxnFvX9D9oNjqteg@mail.gmail.com>
Message-ID: <a797d1443c01cca634040206a42bc5f2@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-04-17 09:17, Eric Sunshine wrote:
> On Wed, Apr 17, 2024 at 3:05 AM Dragan Simic <dsimic@manjaro.org> 
> wrote:
>> On 2024-04-17 08:35, Eric Sunshine wrote:
>> > On Tue, Apr 16, 2024 at 11:33 PM Dragan Simic <dsimic@manjaro.org>
>> > wrote:
>> >> -               die(_("options '%s' and '%s' cannot be used
>> >> together"), "--subject-prefix/--rfc", "-k");
>> >> +               die(_("options '%s' and '%s' cannot be used
>> >> together"), "--subject-prefix/--rfc/--resend", "-k");
>> >
>> > You probably want to be using die_for_incompatible_opt4() from
>> > parse-options.h here.
>> 
>> Thanks for the suggestion.  Frankly, I haven't researched the
>> available options, assuming that the current code uses the right
>> option.  Of course, I'll have a detailed look into it.
>> 
>> > (And you may want a preparatory patch which fixes the preimage to use
>> > die_for_incompatible_opt3() for --subject-prefix, --rfc, and -k
>> > exclusivity, though that may be overkill.)
>> 
>> I'm not really sure what to do.  Maybe the other reviewers would
>> prefer an orthogonal approach instead?  Maybe that would be better
>> for bisecting later, if need arises for that?
> 
> The comment about using die_for_incompatible_opt4() in this patch is
> the meaningful one.
> 
> You are very welcome to ignore the parenthesized comment about a
> preparatory patch. There is probably very little value in such a patch
> to fix the preimage to use die_for_incompatible_opt3(), only to then
> apply this patch which updates it to use die_for_incompatible_opt4().
> That would just be busy-work for you and for reviewers. I mentioned it
> only because I noticed that the preimage was doing it wrong (not using
> die_for_incompatible_opt3()), which presumably misled you into
> continuing that mistake.

Ah, makes sense, thanks for the clarification! :)
