Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B211A46420
	for <git@vger.kernel.org>; Fri, 22 Mar 2024 13:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711113949; cv=none; b=uxCsX0IST2Yqg3cZTvBDRkWvqCx2zmSL3k+tVGgK+EitL1GV7R98ps+hM6oBXGYLh+rHExgW2sDyQ8zH3Oz2zoChBTs3qtfpy6REjvwF42B0J/eTi8JpRTX7zlBis46c7RZu6Hj7rL2bA5jUA3e7Fp0La0LvtnnjrFXoUES8uMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711113949; c=relaxed/simple;
	bh=DA7CoqJNXjHn6yl9Rtx/ozgV2Bw/AQ0lCwj24AoU4V4=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=iaz5A/z21MqSSpdtasKSusQVpQISTWsCrZOdgET3iWQTsS22HzE3f53ERa5e7aT75oet1pXu4qxgQuJqvF4sFTZ4VpXverMwdDC3AY1N9vZBhFFOy10MUrMDDzdGW6iLTCAzh+BuhiHnHNCPrCtFThFuoPQaRKIDWEV9oPKJ9x8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=Ow17WBdo; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="Ow17WBdo"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1711113943;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Drz3+AbVTqa77yeCH5GLF2JFBrWDZreuMpzrl/te8Xw=;
	b=Ow17WBdoXXVA4EybyFaH5GUyfwe4G3pqHxxkWXSvq5J4OPYIgKeuFc9YyHQXrNoeftopTi
	01AGxoMY/9ZrWNZcEc6+fPyS+ZdiplOzL44trlZTSRyKwFUgWXZ5KE0zgLuNOKjTPeOhuv
	pfKeWXhaNnrjl3pOKamc+9qJUxGh7Zpp4tHYbmotjmbj+2PGuONf0VTGn04lW2DBnMju3m
	Thn00Bksrqv/bQDyHkF9yx36NvPY8vxNBCqEJeXkNJ7soNGcQpFs9KTEdxlXHiEK121M9r
	quQdMK/jLo5cXcPtUX/5dg/JIM9qLBO5iHNfkDJZZ5YLkMd9Kwf2CJbERdtohQ==
Date: Fri, 22 Mar 2024 14:25:42 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Max Gautier <mg@max.gautier.name>
Cc: Brian Lyles <brianmlyles@gmail.com>, Junio C Hamano <gitster@pobox.com>,
 git@vger.kernel.org, phillip.wood123@gmail.com, =?UTF-8?Q?Jean-No?=
 =?UTF-8?Q?=C3=ABl_AVILA?= <jn.avila@free.fr>
Subject: Re: What's cooking in git.git (Mar 2024, #05; Tue, 19)
In-Reply-To: <Zf18DEHen_K_HWvo@framework>
References: <17bef643ca4eabab.70b1dd9aae081c6e.203dcd72f6563036@zivdesk>
 <c62a14c7de6ff487b1f66f149d685126@manjaro.org> <Zf18DEHen_K_HWvo@framework>
Message-ID: <6a9d06f622f4c2dc9d00e54e454adeda@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-03-22 13:39, Max Gautier wrote:
> On Fri, Mar 22, 2024 at 06:14:37AM +0100, Dragan Simic wrote:
>> On 2024-03-22 03:47, Brian Lyles wrote:
>> > I would agree that it would be hard to advertise without some change
>> > there. I think that documenting an optional opportunity for now before
>> > considering if it should be a requirement later makes sense.
>> 
>> IMHO, making it a strict requirement would only raise the bar for
>> contributors even higher, and increase the "do this, do that" kind
>> of traffic on the mailing list.  In other words, I think it's the
>> best to start slowly and see how many new patches will include the
>> additional summary.
>> 
>> > Would it be beneficial to request some specific heading, phrase, or
>> > other structured text such that this summary is obvious, or even easily
>> > extracted with some sort of script? Or is that perhaps overkill for now?
>> > I could see relying on any sort of automatic extraction being unreliable
>> > even with such a recommendation so perhaps it's not worth pursuing for
>> > that reason, but I could imagine it may be useful to have a standardized
>> > way to separate this release notes/what's cooking summary from the rest
>> > of the cover letter (which also acts as a summary of the series).
>> 
>> Of course, it would be nice to have a strict format in place, to
>> allow automated parsing and extraction, but I'm not sure how many
>> patches would actually adhere to that requirement.
> 
> While not every patch would use the format, proposing one might be a 
> good
> idea nevertheless, because "clearly marked as such" is not necessarily
> clear for everyone. At least that way if you don't have any idea you 
> can
> use the format.
> For instance (inspired from the k8s project):
> 
> ```RELNOTE
> Your release note here
> ```

Makes sense, providing some kind of example as part of this addition
to the documentation would be beneficial.
