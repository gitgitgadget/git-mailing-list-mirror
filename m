Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 453652609FD
	for <git@vger.kernel.org>; Fri,  7 Aug 2026 22:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786141622; cv=none; b=OthKQW36RRsd47Hcpql9+L3hhQm64wQl9//A9iOXTiamQebJFrVQeGZ7vaQARzLWAODIpVnp7+82IiJKbPDXpSuKq0ssMW8SjQK6ltAx8vThFhJ0/Lxhma0O5hBfE76Xr+FqM31Fc7jrv6T3ReZoz0Me4ttT4L+Gi3h5p/kfLK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786141622; c=relaxed/simple;
	bh=RR7pw3cbPhzvBK9Vt4lwJSFPh1PD3JYFY0deiIKYIiM=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=BZL3Q62+SISj8clPs9jfN/ZyfAX2V4UEA29GnHWmQ/JLr5dlXKBR/ZwpjmPHandYu2UbGtTOguZP3FO59Vtfi4kt25nCGeAb93NJvF8+yZW2QFur0C9gxztJzhRBX4OHLGUxK7MuO+DJZNOV/UVUBJima3WL38KDH+ukMIVOsDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iC0QLyVG; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iC0QLyVG"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2cfff5f88dbso1018975ad.3
        for <git@vger.kernel.org>; Fri, 07 Aug 2026 15:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786141620; x=1786746420; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=BmCsqCQkYHvTCIfzE/w+eG7Vyur5ov/iZynhX0Y5w/k=;
        b=iC0QLyVG1kWFi5XodIn3M69lmPF6eIQtrtmI+1lBq+tmdZq2lQcmNABGMUuZXUIggF
         sdS9Y6upi6Pje509MaxRiUjp/eaGbxL9K/MWJFWZwo+EWsncoz9AYHOSBZwe/gSn88Z+
         CrL17ku2GqTNiKqnyBXlTKXNgyku3W38ErVH+Yb/aFliDZRjZmjSw/yol9jabD8AfWbo
         ZP4BNHIPZxI7PJMCD2CD4HJkXPex2/AsqUueUp6uqkTokvZBcUdOYlvWvBl3H7o0WZOf
         WxSzeRPc2x84TTc7IlLdtuLwt4vTiwcGRyyk/AqXuOtWkUnkg/I9qJQvCO+MpaJygiCu
         kcEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786141620; x=1786746420;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BmCsqCQkYHvTCIfzE/w+eG7Vyur5ov/iZynhX0Y5w/k=;
        b=AR8rbg1vUW9JDlUmv6ySJHjmisNGVETFWa2TOJsos4pei3drxFqxulHV1yTbi2Vdwt
         fFjaakxYGN/5D2p4DINigToBH1p6BGii+DugxX8INhb0yd8cZkyAypJCQJ18e9miDFy9
         I1OxXVyPlYvLHxYHSDNBpWYkPzaIMtjU3ZPydhL+I2UeH2DoIMTx9L0HKbhli/E44u/d
         BO99T+C4sa5VUSMqsYNT+hqIOcCpxJp61P9bCNMGB0PE9bVHk9tuquUOiI9kTVTPZfWz
         5IVmlKfvIe5V+QmwFXq9zDZIZWa+kO0ZEH3OLwtRaXKFs3B66sgQtf80JAa+UnrRPZfs
         y5lA==
X-Forwarded-Encrypted: i=1; AHgh+RqsDcl/EvLCQJgTT8lQh1KGliShyRKh8X2k+xrIxDklTs355HYQ83XeiVUAxvt1nFCjjJc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyH+QUE+H0q+jDMSaZvsZX4FxrA6R7QApqvdsgjnDphBhAwcUdX
	nqpg6uoY7bXjbUFpLGdDI8CAX5NAHJL8kzth8GjvjpXQ3YbLds9zcwAS
X-Gm-Gg: AR+sD10qDmGhInF0B/CE+DplDgMZZbgWDCJrH4xMQukxVVtIcWA35HStnR3zuYW/gG6
	RBR4IcdZlCiBxJnmTtV+VvKBEsM0UVoMIbMHg6StUZgwhhCeTzWAhMZJ4yueUG59/Y6pyjKV6Cb
	wigwesT/7FuUyyFV1fprBXf0WA9ZIMPjRjaj+O5HuPqHNC7dfLDUkTZaztM8TALUfB6LBL2yjRo
	hykBuOH8aCd3lXTZymEI9oE63xIrNQZP+W9ytxoBzNstYw7gPfqwhIPfL/cyXo6HPpyxva+ISuP
	2W8BJPL+ewqKz22TI/L4KibVzB6RQJK/dVj33Y3kmUVS4sSII/nBQt+ZTf6gni1yxzScwV70aPx
	S3P0SiOd37bYY8ySXqxrKMwG4bQ7e29DRP7dlMASnTPt/jZQrbuN1O+dWl6IsreP3cT8IFgn1F5
	Kk+K9zHJ/KOJdgmeeG5a6TG+xlUJXp/bK8iSj6a7x09YcWi73o5oiCV++LWJGgU6msxx+I
X-Received: by 2002:a17:902:e84b:b0:2c9:b396:1a55 with SMTP id d9443c01a7336-2d0ca76a3bamr287031675ad.12.1786141620535;
        Fri, 07 Aug 2026 15:27:00 -0700 (PDT)
Received: from localhost ([2600:1010:b0e6:697b:e126:8129:8b75:2bca])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-315bec2ec20sm13113683eec.28.2026.08.07.15.26.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Aug 2026 15:26:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 07 Aug 2026 15:26:57 -0700
Message-Id: <DKJ2CZKJC6P0.VHLMCUDH6Z44@gmail.com>
Cc: "Phillip Wood" <phillip.wood123@gmail.com>, <git@vger.kernel.org>,
 "Phillip Wood" <phillip.wood@dunelm.org.uk>, "Elijah Newren"
 <newren@gmail.com>, "Patrick Steinhardt" <ps@pks.im>
Subject: Re: [PATCH v3] sequencer: honor --empty when a fixup!/squash!
 empties its target
From: "Farid Zakaria" <farid.m.zakaria@gmail.com>
To: "Junio C Hamano" <gitster@pobox.com>, "Farid Zakaria"
 <farid.m.zakaria@gmail.com>
X-Mailer: aerc 0.21.0
References: <20260711-fz-autosquash-empty-v3-1-d227b63eb511@gmail.com>
 <xmqqh5m494yh.fsf@gitster.g>
 <7a1e5111-185e-4390-afa1-c19908c9bd86@gmail.com>
 <DJXL4KSUEAD4.1EE4ERHJZ00TR@gmail.com> <xmqq8q6jhtws.fsf@gitster.g>
In-Reply-To: <xmqq8q6jhtws.fsf@gitster.g>

On Thu Aug 6, 2026 at 1:32 PM PDT, Junio C Hamano wrote:
> "Farid Zakaria" <farid.m.zakaria@gmail.com> writes:
>
>> Let me know if you have any more comments. I suspect not much will
>> changes logic-wise once I rebase it onto 'next'.
>>
>> For clarity, is the f85a7e6620 commit the 'next' branch ? I would have
>> thought to just rebase ontop of 'next' and I'm a bit confused with this
>> commit hash.
>>
>> If there is anything else I should be aware of, I would appreciate a CC
>> if you can remember :)
>
> It has been quite a while since you received a reply from Phillip to
> the quoted message above.  Has there been any progress to share?
>
> Thanks.

Hi Junio,

Sorry I let this slip. I was waiting for the work to be accepted to
avoid rebasing on top of a moving target -- I am still a little new to
mailing list workflow & I have been using b4 (recommended from Linux).

I will pick this up again soon.


