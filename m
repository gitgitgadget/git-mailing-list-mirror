Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C261A1CCB31
	for <git@vger.kernel.org>; Fri, 11 Oct 2024 19:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728674589; cv=none; b=dh1ccB4lIBGGCc7GiECw3dlM94h/0faCmDdaIEqI4TDld294jIhP80glVbgtot6Dj4SVIRMLeeKLUp2WK58vGJ+RwMxhxewk77TXixiS9KXUpa+tCBeY/S/w67ng5JmqLiiwHEl339G8bRkCcSRpKDrRpEHeJFsMYZ38RJHv90A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728674589; c=relaxed/simple;
	bh=1Xqa/TfWER4hIvjPJElz2+JPmDqSd2nhMNB0ORQjLMI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V4NDQTI1m1sASbdkVIr2Xay22GeXg8ZFYkKpCoCBBJi3n3rj6fbbLdvp0TYrYV+SF+f6gViKtwkBvDcL2ghl3a5PPNnVSef8kky7QgzzrXVW4yaJBPRVF/NBPujxiwQ8/aM4paWsk3MqhBEpUAUMB8lGaFL7yf2qb1PRoPiygt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6cbf8cee5aaso565376d6.3
        for <git@vger.kernel.org>; Fri, 11 Oct 2024 12:23:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728674587; x=1729279387;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WA6QyP1S7nfDJxs4Oyd2ViYRVReeAK0UnblAuwpbprY=;
        b=G4ADEz16yY1lr6eYdZ1NwPPlOPRErJfwdszs/O7nkmsm21+BX/q4Y/K4AAi8zU8InP
         XeEb4yyExKuTIK3sd3pvK8Q5clxY6V4eHPjGWt0dQt7O8dv6ZARkvw7EKuapLZ3wjyAZ
         +of7IsjjNIb0iaxwD9GtDUPo4xu+rDHCtcXOLv1QbonCa/J0v2iV/jgFnwZ4vhFHw05f
         ifPPOjFbxNn04MVm0JPn+Z6VTUFqDcqTnVSNKyDW4qg8ZZ4CSSqJhJOgQrhHOVWEPIc7
         WzQH4xN7YLPbbgILiYN7MiUejZCmqCYcOtuFXooaU8ClG+W1dzNvsbaosj/qvmYvp9B3
         M1ow==
X-Forwarded-Encrypted: i=1; AJvYcCWeqw3m9BtFfnrqH8POKg0CxV6/pzB3+jM6zp2akb9Qe/CGVmie/MZCL9Bskg4KEj+hNhM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVOGQYMchStZzZPsnLFAqwhiettjrOZnuJjsa3cALIoLpwiBXW
	3XWtpSIZBZh7YSCoDarxUAY3hWEnAIteUioKJrvGcll/XapJ/7a400YLQPoGOQa4fSe3Lquoxzl
	EGVIhldvTxQZcExV1gccbFg2zYf4=
X-Google-Smtp-Source: AGHT+IFMyVDWMc3tVOAhIgOWH4+dHnVW0riUGMs6evO3pM11CpgBVw+twmgFzpUqO6gZvB6TdtwIplGHaZIjc/7NjFU=
X-Received: by 2002:a05:6214:5291:b0:6c3:69f9:fb5b with SMTP id
 6a1803df08f44-6cbefe46ec0mr24790616d6.0.1728674586815; Fri, 11 Oct 2024
 12:23:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241010235621.738239-1-sandals@crustytoothpaste.net>
 <20241011074022.GC18010@coredump.intra.peff.net> <CAPig+cRmyZhq1qtomTFP7p7XMqrCP8-u7ah8D2+yUtrL880y7g@mail.gmail.com>
 <xmqqttdicws8.fsf@gitster.g>
In-Reply-To: <xmqqttdicws8.fsf@gitster.g>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Fri, 11 Oct 2024 15:22:55 -0400
Message-ID: <CAPig+cRo3ptvgxctL-pjupzHsPeXCb3KfaBTwdzawGNezML6VA@mail.gmail.com>
Subject: Re: [PATCH 00/13] Update versions of libcurl and Perl
To: Junio C Hamano <gitster@pobox.com>
Cc: Jeff King <peff@peff.net>, "brian m. carlson" <sandals@crustytoothpaste.net>, git@vger.kernel.org, 
	=?UTF-8?Q?Alejandro_R=2E_Sede=C3=B1o?= <asedeno@mit.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 11, 2024 at 2:35=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
> > I may be in the minority here, but I'm fairly negative on this entire
> > patch series. As you say, supporting these old versions is effectively
> > zero-cost, so how does this project benefit from these changes which
> > potentially "break" Git for users on older platforms? I see no upside
> > here. The cover letter provides no strong justification for
> > (potentially) inconveniencing people; the argument about being able to
> > utilize more modern Perl features is weak[1] at best and is not
> > convincing.
>
> Having said all that, I did find it was surprising that we raised to
> a merely 6-year old cutoff point.  If it were discarding versions of
> libraries that are older than 12 years (instead of 6 years), would
> you be having the same reaction?

I almost certainly would have had the same reaction had it been 12
years instead of 6. As one who "lives" with these old platforms both
professionally and personally, I'm sensitive to the issue because I
have been burned too many times by projects arbitrarily dropping
support for older platforms (or, more generally, not taking their user
population into consideration when making arbitrary changes).

I would be much more tolerant and understanding of changes with
substantial and provable value, such as ridding the project of a
high-cost maintenance burden, or eliminating some maldesign which
impedes implementation of some new important feature (or even which
impedes fixing some serious flaw). But the patch series under
discussion does not fall into those categories; it (potentially)
penalizes an arbitrary chunk of the Git user base without any obvious
benefit to the project itself.
