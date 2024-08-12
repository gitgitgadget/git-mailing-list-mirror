Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E45921EA8D
	for <git@vger.kernel.org>; Mon, 12 Aug 2024 16:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723478666; cv=none; b=sZJBLr4s5PWWnHNS3rpefGc086wegKtt9rxm9CsRTNzbw7ARtL49OSrXXfFXQ5QDFJxT9q4STpRz58qHwRPE4OyzQhlqVEC9ydzysxn8ZxqqosL9yVpBuXhOqYKQ4MK0rIsup20Kdc/66Tl5oZTaBPk6EALcnF42izbeJXtQ7V4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723478666; c=relaxed/simple;
	bh=smM2yuQqguGRAJGdtkAbwN5+LgFm01QTSiDFazM9iOk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k6fTjeAbKrOZzk4edHHqpX+AztPdXe5+rt6v61dagCBUxMZThzMua5Ifcm8jAicBgUqXGuS+iui9KsL8frg60mHTdSZ8eubdwx9H711Ca8bHT9MmHW4t2yfNm6S4qKMoyP9sD7R6gWFUBsweXxCD3XA+RRudwk7koANj0IfgGRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vl2ZrCxK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vl2ZrCxK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A8FAC32782;
	Mon, 12 Aug 2024 16:04:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723478665;
	bh=smM2yuQqguGRAJGdtkAbwN5+LgFm01QTSiDFazM9iOk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vl2ZrCxKtlJoMX0nA1hwVvM0Sn1p2K1jQq14qQ+I3PzsPEAvdnB1SvWqxwFu8zkzl
	 +KoZvy1z5rj7+2vuWviB2PwR69X8s4sRQSF1HXUQMJ70bdQ/jUj3CIrnwFclv9myEK
	 VXf0tdNEtpMigggsTcGftj+Tqm3K9tKyrTmvasoQ=
Date: Mon, 12 Aug 2024 12:04:24 -0400
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: Mike Castle <dalgoda@gmail.com>
Cc: git <git@vger.kernel.org>
Subject: Re: Heads up: GMail regularly marking list messages as spam
Message-ID: <20240812-devout-mindful-dogfish-81cefa@lemur>
References: <CA+t9iMyT8fAR_fvQXOer=ivLnNKDnH8g_M8iQiq7gdrnfG7aCg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+t9iMyT8fAR_fvQXOer=ivLnNKDnH8g_M8iQiq7gdrnfG7aCg@mail.gmail.com>

On Mon, Aug 12, 2024 at 08:10:23AM GMT, Mike Castle wrote:
> If you read the list via GMail, you may want to regularly check your
> Spam label for messages from the git list.
> 
> I'm not sure what's up with that.  A handful of real spam had made it
> through vger, but GMail seems to be hitting a fair number of false
> positives lately.

Gmail is using internal spam training on all mail that it receives.
Unfortunately, mailing list traffic like that on the git list falls
way outside what is "normal," and this tends to trigger false-positives.

> Sometimes it is just one message in a patch set.  Others, it is whole
> sets of patches.  I didn't check to see if there was anything in
> common across the messages.  Maybe if anyone has a large batch, they
> can check?

Most of the time it's super unhelpful:

    Why is this message in spam?

    It is similar to messages that were identified as spam in the past.

Sometimes it's something specific:

    Why is this message in spam?

    Lots of messages from xxxxx.msg.chrl.nc.charter.net were identified as
    spam in the past.

This isn't really anything to do with vger.kernel.org -- we are complying with
all Gmail "bulk mail sender" requirements and we try our best to deny spammers
early. Unfortunately, my general recommendation is not to use Gmail for this
kind of work.

-K
