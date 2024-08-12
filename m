Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A463A17E8E5
	for <git@vger.kernel.org>; Mon, 12 Aug 2024 15:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723476180; cv=none; b=Ig6mETbNp7sJv4akyLhZ8GWbKEN2aK+jbkGyELxDOMjQrJ6RUAyztKsLIbSwNRE11zZXkHIWA+l1f3cpKUV4qEZIUx3ovt4IqBjXPnrHdaOKGRVhZTipMG6IAD6/ERt5e90VS5ngxqe1kvQr7rGbagNL5SSAKqw+QXmJdMM6ayM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723476180; c=relaxed/simple;
	bh=q6WX9Cy9ipcFHksej2EQJz9K279ddqGk43o2JnUC5Ac=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=f0vEGRowis5P++xByIfsYYZou4L5xI1Ve5I9fAOJ5QY88NI07rOGzHhMYzItE75WdwY+S1Qqgs7qaaIIU7Al7IjaZm+H4JsAwRsXdY1uk4mODvvdmySADa/fUVKH5+aaUXRyGeVR8M/YdEbza4Gd3z3TKYbidKUNVCCjvhNX0Rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=AUViFUF6; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="AUViFUF6"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id B33322B057;
	Mon, 12 Aug 2024 11:22:52 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=q6WX9Cy9ipcFHksej2EQJz9K279ddqGk43o2Jn
	UC5Ac=; b=AUViFUF6Yk8tThk5k8GVyZjLhiejQsvDAstqM1861UeLb3EpsWGko0
	JndEEGUsVr5hnkCLNg/rO7By0guO0OKJFmP3e5bbu3ppCEhrVu5RM9ujcSsou2Ps
	6LI9C4G4VIAzbKDRN9tKi/QlmZ8zWt03cUJ1eEXO/PmHZVMVKFfqA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id A9D452B056;
	Mon, 12 Aug 2024 11:22:52 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 207122B055;
	Mon, 12 Aug 2024 11:22:49 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j6t@kdbg.org>
Cc: =?utf-8?Q?Jean-No=C3=ABl?= AVILA <jn.avila@free.fr>,  =?utf-8?Q?Jean-N?=
 =?utf-8?Q?o=C3=ABl?= Avila via GitGitGadget
 <gitgitgadget@gmail.com>,  git@vger.kernel.org
Subject: Re: [RFC] formatting macro
In-Reply-To: <f44c253d-9b37-451d-902d-486adb8e3d72@kdbg.org> (Johannes Sixt's
	message of "Mon, 12 Aug 2024 08:35:39 +0200")
References: <pull.1769.git.1722801936.gitgitgadget@gmail.com>
	<5ef4a7bd-3b9f-4e71-9a22-e22012f815ce@kdbg.org>
	<xmqqcymn3qc8.fsf@gitster.g> <4617471.LvFx2qVVIh@cayenne>
	<f44c253d-9b37-451d-902d-486adb8e3d72@kdbg.org>
Date: Mon, 12 Aug 2024 08:22:47 -0700
Message-ID: <xmqqwmkl7ol4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 BBE9F048-58BE-11EF-AC4B-BF444491E1BC-77302942!pb-smtp20.pobox.com

Johannes Sixt <j6t@kdbg.org> writes:

>> Square brackets are possible inside the double-quotes:
>> s:["--ignore-submodules[=<when>]"]
>> 
>> Is this something that wouldn't repel you?
>
> You argued elsewhere in this thread:
>
>>  * The fact that the source of the pages should be "perfectly readable" is a 
>> moot argument. Fair enough, it is not the objective to make it impossible to 
>> understand, but in the end, this is not what is consumed: these pages are 
>> compiled into other formats where the markup has been translated into styling. 
>
> I buy this argument, in particular, since not even I read the plain text
> files, but use the rendered version.

FWIW, I do read the plain text files, and rarely if ever use the
HTML version, except when checking the effect of changes to the
mark-up.

> I would like tone down my harsh opposition to mild opposition. IMO, it
> should still be easy to *write* the documentation. It should not be
> necessary that authors remember to use macros all over the place.

Yeah, s:[...] does repel me, but also I do not think it is sensible
to claim that we confortably edit the "source" form that we find it
hard to read.

> And I still think that we should not introduce macros just to please all
> renderers. Let's just pick the one renderer that can do the job best. If
> it means that some distribution cannot render the documentation
> perfectly themselves (Debian? I don't know), they can always use the
> pre-rendered version that Junio kindly produces.

What Junio uses "Debian? I don't know" that cannot render the
documentation ;-)?
