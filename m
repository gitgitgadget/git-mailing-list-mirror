Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B9285BACB
	for <git@vger.kernel.org>; Mon, 25 Mar 2024 20:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711400063; cv=none; b=lA+dAeZLBQTKScBMRMiYihePYMG2oIezpeVn1vAQhTIaqmY2xNbU1/M/ZzUbpANYJhHBvWvobcVEVWSepoku/8Eb8u7zs9gnXDWCAvMu6WsmymThon6/i4lxo/jeQF4PtTD8+VMdtLO+5K7mFo5GPRbhWvToFFhTosD6TMh18NQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711400063; c=relaxed/simple;
	bh=esuadwcIpMvWJwb1Ermode6nTVPZ9v5EF+FmwZ9nRuw=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=B1RgP5mkepYdH+61PkFBrPJcRwIBV/9aYWeZXWqe7/AYqxAqlrmg/PKLYFzi4CbxA/4pjyW5f4LoGB1B2AAj3H/cbA5wHBhVuNtgJiRclCm5BlehItm1FIi3Nm7USK5OIqyVH/W4ca6631rU+7Sd5enJsI2SQIZSj3Sjxuu/rNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=gIidLW00; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="gIidLW00"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1711400058;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1KrIlaTdX5tp+emz/wdJqMwI2uwxu3zEboSZxO5OljU=;
	b=gIidLW0011va9W2+c80tI3jiPE5CyyJ3PVeQP29Y/jtObeOafU7hcXy1AatAjkiqU0JpiQ
	t8wP2aTxBS4lqYNT0VYMyyniyVxrplDURTK11SeuQ9/pbH2O6bipkrmC5mKQkz898FzUR5
	+fGGNThiDVFBJp+WWSb2rzMLqf7ZRJoXF15fqnqO5XiGztjnCi0oQ8+qmelH2PZRnldZDV
	qrXvayzCvs4zTUGGuIS/tfg9Xx5GaQqUOvcyAoo3A1PQLto85C3uYST8oMJthsQV/WQqrS
	qpS9VRfHDV387ClpLTtud+FLmtgX3PuiouZdIK0VeNuKu67C4IhgFQbc1ivEog==
Date: Mon, 25 Mar 2024 21:54:18 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: git@vger.kernel.org, gitster@pobox.com, jn.avila@free.fr
Subject: Re: [PATCH v3 0/3] Assorted improvements salvaged from an earlier
 series
In-Reply-To: <CAPig+cRECapN-9_u0JoESaS7KTi-==ri7Oy+sjff-VHL7p+vHQ@mail.gmail.com>
References: <cover.1711398665.git.dsimic@manjaro.org>
 <CAPig+cTia_gXkpNw6jo8VHg=ODqX71Nvff4Qfq0oMWqShv5TWg@mail.gmail.com>
 <92cb6c057591c7192fd7eb7097336f66@manjaro.org>
 <CAPig+cRECapN-9_u0JoESaS7KTi-==ri7Oy+sjff-VHL7p+vHQ@mail.gmail.com>
Message-ID: <a3bc4829036f5803da513fee52267c2c@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-03-25 21:49, Eric Sunshine wrote:
> On Mon, Mar 25, 2024 at 4:41 PM Dragan Simic <dsimic@manjaro.org> 
> wrote:
>> On 2024-03-25 21:39, Eric Sunshine wrote:
>> > Prose description of the changes between versions is very much welcome
>> > by reviewers, but please also include a range-diff[1] or interdiff[2]
>> > when preparing a reroll.
>> 
>> Ah, sorry, I didn't forget about that, but I just intended to start
>> providing range-diffs for future patches.  These were more like new
>> versions of old patches.
> 
> The range-diff is particularly valuable exactly for this case (new
> versions of old patches) since it is a "diff" between the old patches
> and the new patches. Thus, it provides reviewers with a precise
> summary of what changed between, say, v2 and v3 of a series, and
> manifests as a concrete representation of what your prose explanation
> describes.

I see, and I do understand the purpose of range-diffs:  they make
reviewing new patch versions significantly easier, by relieving the
reviewers from the need to track down what has been changed in the
current patch version.
