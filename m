Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93F74156F4B
	for <git@vger.kernel.org>; Mon, 15 Apr 2024 21:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713216823; cv=none; b=KcUv4WJl05A3gCIQwhPos1lZIGTWv/WqNsTMtvN1UjZzjByGBtYW/uzip6LIFgPieLdi0r4SoYw/ziKCJRiraRRR+KiWdvbu7GwjaYkgln8JUR4SdNMvuWIsp0rqYqlQwJDv0lzaIPgbg0fwNuw9zk6x/yiiJ/6oMAfp8iXsmdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713216823; c=relaxed/simple;
	bh=jpKEr22L/ZkhtQV+DfoiBMGiB+v+mNzkSS6Jr5BNlZU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lE4M/mh1YxqeyRLEUkwyDlZmtwXNdl9XrPhGQfTLkrIqulIpfQTNQJRvy7A6jwnXlqZT2WsvrPdCSJsMJ03zCvDyT9cGLDPXdMi/pCxWSJSkdn/ohfz5wzzapKShEZD99Pv3TABGu7yaCpRDlTDyKXC51atDWUK/Ih1gedZ5naY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-69b2f6d31c1so8805806d6.0
        for <git@vger.kernel.org>; Mon, 15 Apr 2024 14:33:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713216820; x=1713821620;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jpKEr22L/ZkhtQV+DfoiBMGiB+v+mNzkSS6Jr5BNlZU=;
        b=cXK6cv3uZnkuAuQ0y2XzQwADbvmOMde4/mH7kvY2pd6yObBynV9ec7gJvEacpIEbyz
         NtVqvQkEjqMkUr9oqyUAmI6ir1g5XI7PiFVhayC7LiCNJbvzI+EDverGaNno75aHLFXh
         EGxDhyWaPgsGwRrb4gtpsik4548oWZvT0+A/fGfneNlqHwyrajevxpvee3riEbLd6lPM
         xY/7C3CXSOpZgVC4qKscFoPO4spgafkwEGi9VTdktnBE0YceqdaeyiugsWavxfwCPI2E
         6ZoMH2VPulwNrUAc2uPQwxCqAY3/RMLdqbtOThHHtXMc7qw+l/0gxzLFgXqjA2kULBGz
         QDTQ==
X-Forwarded-Encrypted: i=1; AJvYcCXASQxjdPJSnoxvAbHXM9nXonMsChgxXcbkx+/Q34cDAn5nKaBKD1npBwEwfKSQsNjFI2HPrvEfmAeg2Sh+2RheCala
X-Gm-Message-State: AOJu0YyjPXafWJXxUpu1+IvPGWkUM+mm0Ht3BeJXMYCEMERcuDkEQqEj
	DWnwbPtfz4qnC74L+DewRxZaYWiF7np9AjMHDnGi94Jh9YlDFF7+/dYj/RkxViFb1yCz8x+Ku1S
	xJT9xb3kCxTCBNQLhaegmX+C+rkA=
X-Google-Smtp-Source: AGHT+IFTK90cjMXPVtcLevVMw/1YT9ALmp7tm86ETCQW/Aa1jGByvoBg6CM23L+gw1qeCy687I0gXxHDteOpjQ4depg=
X-Received: by 2002:ad4:4d90:0:b0:69b:24f2:c2eb with SMTP id
 cv16-20020ad44d90000000b0069b24f2c2ebmr9533585qvb.59.1713216820569; Mon, 15
 Apr 2024 14:33:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <965ae345-fd58-c46c-5a7a-de181e901f21@softwolves.pp.se>
 <CAPig+cQu15HzZkeT3+oG3U7iFax5_GYUB=uqwuJxshw-PD=VHQ@mail.gmail.com> <xmqq7cgyl3pr.fsf@gitster.g>
In-Reply-To: <xmqq7cgyl3pr.fsf@gitster.g>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Mon, 15 Apr 2024 17:33:29 -0400
Message-ID: <CAPig+cSY3vp6V=4SWmxyCi+7QY74eGnzPM6bu5LU5j00n8-j5g@mail.gmail.com>
Subject: Re: [PATCH v3] bisect: report the found commit with "show"
To: Junio C Hamano <gitster@pobox.com>
Cc: Peter Krefting <peter@softwolves.pp.se>, git@vger.kernel.org, Jeff King <peff@peff.net>, 
	Christian Couder <christian.couder@gmail.com>, Michael Osipov <michael.osipov@innomotics.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 15, 2024 at 5:24=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
> >> Pass some hard-coded options to "git show" to make the output similar
> >> to the one we are replacing, such as showing a patch summary only.
> >>
> >> Signed-off-By: Peter Krefting <peter@softwolves.pp.se>
> >> ---
>
> Curious how you trimmed the trailers from the submitted patch ;-)
>
> Although we do not use Cc: in this project, we do recommend use of
> the "Reported-by" trailer in Documentation/SubmittingPatches.

Sorry if that caused any confusion. I wasn't trying to make some sort
of implicit suggestion to the patch author (such as "don't use Cc:
trailers"). Rather, to ease the reading burden for others, I
habitually trim off chunks of the email which aren't relevant to the
portions about which I'm commenting. So, although I always leave the
Signed-off-by: intact, I often trim off other trailers, sometimes even
parts of the commit message (replacing with "[...]"), and, of course,
entire chunks of the patch body.
