Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CC0DFBF0
	for <git@vger.kernel.org>; Sat,  6 Apr 2024 00:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712364741; cv=none; b=m4uLknNc6orLTKBJNia20EwQ9a8VERaUqtnRi413MPPoefL7irgmTnvsAzR//LBKdSrNvuiRsZQCeuLgMedwKelsvzK/2EToZlnOcgS3kpq8Dbc2NghQSAI/wLrsiLkjELyqjc9dq9iB7E542WOW5aJW1mBEmAnWmff7VFqThi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712364741; c=relaxed/simple;
	bh=EmOoSQzcY3Aea1g6Ws8jwtt9mx9Hd4TkfMT3c7VouH4=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=sXpBxO1HAVXnfdYtNv7zinNMjIHLAoUjMbcAGmmPbS9aWLpHShQqt15J0tkSclABf6WDFF8JtXKzbbAJ4uuKxtGvL4gy3P5Km2bSRZ4n39APsgK/HZKR8HION4C2HaC/PmekkT1fSlLbIzunDVzj7tlvYvDWhLsB38My4Sq4GXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=bSowvIVu; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="bSowvIVu"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1712364736;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W0eo8zcNv16JMuoXRZaElwZlS4cwrHOGinm0IuZfy6Q=;
	b=bSowvIVuaHjn87N0k7b3VXn9hQlvWovnXlQIB0W4elq5H+UAAn2QHtYqL6+jF0YaWkdobg
	/ZHfQnTPXRcdiZQapyYmj9ihB6rFMzINEYWj+yeVbIu3QGqZ868M01/q3Oum6D6UyDSK1G
	+3GCwjKARBQ7YWAegu99lB6r1ffiRbaSmCglzL9hLx16Cc123mv3vEtzlg6hbQtv96zOF9
	O0AZicn0tc9fOmxnLz+Tt4Rqk/bj8Hy/yCJHdZvNBpg1Nyo84siWiq6d8I3Aq4pYfE/03j
	QB9YSsuohdNcTQgIGzphwM+2W1MbRM2Ibm8jjxGcz+WLLYFZjk5UWnQuAQ88+Q==
Date: Sat, 06 Apr 2024 02:52:16 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: git@vger.kernel.org, gitster@pobox.com, jn.avila@free.fr
Subject: Re: [PATCH v3 0/3] Assorted improvements salvaged from an earlier
 series
In-Reply-To: <a3bc4829036f5803da513fee52267c2c@manjaro.org>
References: <cover.1711398665.git.dsimic@manjaro.org>
 <CAPig+cTia_gXkpNw6jo8VHg=ODqX71Nvff4Qfq0oMWqShv5TWg@mail.gmail.com>
 <92cb6c057591c7192fd7eb7097336f66@manjaro.org>
 <CAPig+cRECapN-9_u0JoESaS7KTi-==ri7Oy+sjff-VHL7p+vHQ@mail.gmail.com>
 <a3bc4829036f5803da513fee52267c2c@manjaro.org>
Message-ID: <f5c2c3af9813d56adf85393f0e8fde0e@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Eric,

On 2024-03-25 21:54, Dragan Simic wrote:
> On 2024-03-25 21:49, Eric Sunshine wrote:
>> On Mon, Mar 25, 2024 at 4:41 PM Dragan Simic <dsimic@manjaro.org> 
>> wrote:
>>> On 2024-03-25 21:39, Eric Sunshine wrote:
>>> > Prose description of the changes between versions is very much welcome
>>> > by reviewers, but please also include a range-diff[1] or interdiff[2]
>>> > when preparing a reroll.
>>> 
>>> Ah, sorry, I didn't forget about that, but I just intended to start
>>> providing range-diffs for future patches.  These were more like new
>>> versions of old patches.
>> 
>> The range-diff is particularly valuable exactly for this case (new
>> versions of old patches) since it is a "diff" between the old patches
>> and the new patches. Thus, it provides reviewers with a precise
>> summary of what changed between, say, v2 and v3 of a series, and
>> manifests as a concrete representation of what your prose explanation
>> describes.
> 
> I see, and I do understand the purpose of range-diffs:  they make
> reviewing new patch versions significantly easier, by relieving the
> reviewers from the need to track down what has been changed in the
> current patch version.

As a note, I kept my promise :) and have started providing range-diffs
in patch submissions. [1]

[1] 
https://lore.kernel.org/git/e3212c0a4ad331685c68c13afcdbced20982ab32.1712364420.git.dsimic@manjaro.org/T/#u
