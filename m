Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9CF93CF024
	for <git@vger.kernel.org>; Thu, 12 Mar 2026 16:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773332511; cv=none; b=clyEyc/dbD59oc3Rc/YrXgsxegHxT2bXKm0a3lkaO4jkMeJ2l/pWpHlnSvjJwcYcm60+0H5raTwxZee2tueG98+MeVqo8ZTpSK9MgG2ZaLn2gsln7FvKgpX+1RrRyQwXL4UFJrc7dXDD2r8a/H5evwfOb5H/Xti85DUN37U28k0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773332511; c=relaxed/simple;
	bh=y4MjVarNiTt5iIAn7HnNpVQ+39I1IvrFKmO5al8uGxw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AsyyMOBPfVL5tLkShZmwwgEk5I2c0p7YkUW5VnuktPQthTC17D6eCT2kev/lWP00D66F382oNE08+TLXMzXZ/SQxqnCUFE6AjthkKkZ7sJvY+GD2RaCgJncQuEXsAZU0nIbuN4KPdmmNK3/9+yyMFF3/EWBkZS7gNdXFNLCmJZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev; spf=pass smtp.mailfrom=malon.dev; dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b=WZJ8UlQ2; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=GlYusDeb; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=malon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b="WZJ8UlQ2";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="GlYusDeb"
DKIM-Signature: a=rsa-sha256; b=WZJ8UlQ2Hz5+K+VW8da/kPq9IDeOm5z91xirNOFjhIQ8mPM4RIlVoag9HG8T0bQp3Ru0CWrkikl5he47SfClTLqMioogg7eJHSE5XypG2+EhZ8FkgJQKqOOBgJ8QSQzpNCv/rfnev/6uU4oeO1EI6KLpqcBHGUa/fOifSgNXuP6Nhhbl2vlfgYOlUNiskheM1Q6xLqZA7SranbnX/V6LfOpvCd7keBm5p0+ttZMa2Nfd8++nQR4+a4DF2YCiWDTHI+JBORipx+FVfPe9XU9XQJfaqZXOFOTC9FnCg6knL1zOv0ocC5Jls+PG/ym2ZZjCX7UuqdALbAFxNiTWxb3XZw==; s=purelymail2; d=malon.dev; v=1; bh=y4MjVarNiTt5iIAn7HnNpVQ+39I1IvrFKmO5al8uGxw=; h=Received:Date:Subject:To:From;
DKIM-Signature: a=rsa-sha256; b=GlYusDebTH1+w0fNofi3PRbhw1ARgkZqYs5yMlB5MFht2oiwVHoUA+4trzC/u8BveKX02vyWAnJZoscwp2uSpoUEjwPXVfSMQk5yUIA6uuv0sQe9DdR46I3Ecd/YNn8NmxPseoEo9J2PuGyH3Ts20dmMMj+gzH14j/PhbfG/HJiOX7PIjqrKTge6D0gvn5WoaqdtbV6DppZs44rXECP6J+hYGjYhp6KZOJzypIZEfYzrhsM9wc5v3kMgscZh5lT/h7ewNg/wuyidA+VrU8fWqUjS9YO7FOjbtLfDJap0RC/G2LSgBIjTQhK+aHlt4OtD87N1HXI8EKdAmDLBQzVBKQ==; s=purelymail2; d=purelymail.com; v=1; bh=y4MjVarNiTt5iIAn7HnNpVQ+39I1IvrFKmO5al8uGxw=; h=Feedback-ID:Received:Date:Subject:To:From;
Feedback-ID: 599969:32685:null:purelymail
X-Pm-Original-To: git@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -1993667700;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Thu, 12 Mar 2026 16:21:45 +0000 (UTC)
Message-ID: <af2c4ae3-c273-40ba-bbca-cbbf687b1b91@malon.dev>
Date: Fri, 13 Mar 2026 00:21:41 +0800
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] builtin/mktree: remove USE_THE_REPOSITORY_VARIABLE
Content-Language: en-US
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, gitster@pobox.com, karthik.188@gmail.com,
 phillip.wood@dunelm.org.uk, jltobler@gmail.com
References: <20260311181704.958509-1-cat@malon.dev> <abJjYNq_sxeH8yLQ@pks.im>
From: Tian Yuchen <cat@malon.dev>
In-Reply-To: <abJjYNq_sxeH8yLQ@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail

Hi Patrick,

Thanks for the review!

On 3/12/26 14:55, Patrick Steinhardt wrote:

> I guess s/the/to/? Also, it's `mktree_line()`, not `mktree-line()`.

Thank you for pointing that out. I'll correct it right away.


> One thing that commit messages should also explain is why a certain
> refactoring is safe to do.

I'll add it.

> That is, can `repo` ever be `NULL`? For that
> you have to look at "git.c" and figure out whether or not the command
> requires a repository to exist.
I checked git.c and found that there is:

{ "mktree", cmd_mktree, RUN_SETUP }

in commands[]. If my understanding is correct, before cmd_mktree is=20
called, setup_git_directory() must have been fully executed. In that=20
case, if the current directory isn't a valid repository (NULL), it=20
should have already exited at an earlier stage, right?


> `oid_to_hex()` falls back to using `the_hash_algo` in case the object ID
> you have doesn't have a proper hash specified. So this depends on how
> exactly you construct the object IDs: if you parse them with a proper
> hash algorithm, then you're fine.

I see. That's pretty much what I had in mind.

> It's typically fine to just send to the mailing list, so you wouldn't
> even Cc Junio. Sometimes it's just a matter of capacity, and it's fine
> to eventually send a ping after a week or two have passed without any
> feedback.

Oh, I see. I thought =E2=80=9Crepeatedly bringing up a patch no one cares a=
bout=E2=80=9D=20
would be considered kinda *impolite*. Now I understand. Thank you.

Regards,

Yuchen
