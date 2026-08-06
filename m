Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 172054B0480
	for <git@vger.kernel.org>; Thu,  6 Aug 2026 23:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786060415; cv=none; b=uhw6MxYcSu0ggeBt3u51O4UR4ya9WX1Dn3/VnRAbxReuODDGcecJ862V9dIzIS48fu1y8zmVivSNIRkDFPaPTF11v8AEwB1tUP9XT5BrdB0dvJUW+YgzEL9k7/0psEaZnnAIWQAva0eOmMfO6hfYNpewgCRA4Voie/MPe/DHWr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786060415; c=relaxed/simple;
	bh=pmXWxG1AmiyUEjE/WlpeiAsWUTQ0/h7an8tnqy7avVQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=bVzjBBTzKvKXUnZiPI3ox9I+EJb7Ep/wEYpRr1pE5a8GpNStlArUAvsjuVnjyG096kSFpLoJnGlEl8LnT0nN6Fvpn/6vI99kcHjs1vcFI4ShfD6p3XbIY1hmZ/e/4nB84RgIYyn5nsUopSajUV+fawxW2X3Mi+JIhpvEEciXiDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jmYblnB9; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jmYblnB9"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-47ddf7b09e5so2539690f8f.1
        for <git@vger.kernel.org>; Thu, 06 Aug 2026 16:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786060412; x=1786665212; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=d1x0HO+fysfRAFCfdbYtPNkHd2e0woTeRF0TN0RHYx0=;
        b=jmYblnB9zFcscyD7yYGZC+vx+fFxRRW1MxryftLO1oFE4N52AkIP/Yuf1mtLS6Y9ju
         EZdyoYFRgfaYNbmcYWIPtiyas0v2TiVzy9coNK2x3XfZsUa8ky6BKADbc0WP6rZ54AHk
         Fn78g6XGb8JzqCOrEd4lD6rJE0QCf94s0AdsP2rC1EI+c/YcIELyOcvtFWV5DrfL/wHr
         8LmL8Wm1QfpTTMg10njhRXYT7jzvOAUA92TqAIuCePhgaCX/j1iI+8jxxJLp+Rxf4UB8
         02orueT3Dai9PFQhJaQqtXyx3WW9ffP3a6WECz4A9Acqr9MZ1gUbVkK6+EobK/r3f84G
         2M4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786060412; x=1786665212;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=d1x0HO+fysfRAFCfdbYtPNkHd2e0woTeRF0TN0RHYx0=;
        b=rpmwpYxmCxqNmUTvWO+xvS5Wso74OLeDSOPWV5wN5oPpD6iWIxzHApFLMuGJ/R70/s
         h8tI3JHyspErvYhLRH52Tp+kWXyiibpv7R8D8k8wCy4eJRMlZ7t1oZVtekQXrJzwMfw6
         KR91jvJiW/MfRf8o13cHZGx8VD2hSHbtjQis7Y12ukh4JZb9LyJVqjJHi/VEcYC9y18T
         vOpO0AZfe57RewIHZhKF5OEpcmK7p66Bj8vyBWIT9jPEPyWzh3auyaLpYZKhlMTUANg7
         kwAqeogCeJHT90nabeN3lnyzlECyD8DkOikpAOUaPVsE6cisboP8MPRdSEJ2koWSBmS/
         kwhg==
X-Gm-Message-State: AOJu0YxziUlXi54M0/W4126BkpOYR9V6+VuZaUJaYEBIsBi3Yu/c3DUo
	EbSjSoJQjWM8hrE8i5wFzInuhskaqQCpL5OYfgrEKgxyMlgb/nyJU9duNe3xZmjf
X-Gm-Gg: AR+sD12yk8q6wWmz4rcUjccR9KhM1IR8STa9fqj5XQY8yqMQdTLUKpOFQ879Ig9QLXs
	s2X+HHWZ0cD0FAVoP+KRs8oFNKy2xhMzoZSuk1ocxAQewpLHgQjGfTMxczgvok7i5+R8lfqwyE4
	HIIgv4DG6swDPhpWCzVAxG8TX2/0oStEXMPR1369MPXEOheKQb6BF9Jxi8MfKqczSit3ZC1fFAl
	HqiNYRErsQhwliYkbxeaOA5ZBa+lREDDgsymDaY3ELNFE+qcho6VY2GL8D8qpOU817mtHcZlGSz
	3oga1PazN9oZ1EH8QuhiRet3lLXH883vv/sH8AY8RMUaR7qpylXJhqq+Qy2XcFXlDHphS7oYb/y
	10OR0jucqTuUEow0qUQys612c8L26rmSSftmugM+9VrKKxqtIqK5BBT57vpv+h+dnfInOrkxQiE
	TXZDPTi+IERK45R3yIPy7LoIlDhKxx9b1uF8JwKKmkETIj4fVfmcktbki1IUyoMKyd8y8WIJCDW
	qVLtSl7J8E0YMDzVwyfw8oSErntBQCXvHCstJWNQCOzqarV6V+Yy33djrLB//2phQHkehe2r32Q
	wNqeFWdpjiZgDFOZxm9vXJR55mjJwOKmKJhAPFWQeox24CczuEoRb76qywlN5dN5I4VNub8GZUo
	=
X-Received: by 2002:a05:6000:2981:20b0:476:7036:f854 with SMTP id ffacd0b85a97d-47ffd93cfadmr6846129f8f.21.1786060412116;
        Thu, 06 Aug 2026 16:53:32 -0700 (PDT)
Received: from localhost ([47.58.8.78])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-480021e8c5asm250561f8f.18.2026.08.06.16.53.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Aug 2026 16:53:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 07 Aug 2026 01:53:30 +0200
Message-Id: <DKI9KP6ADN6W.1HR0XBJT9EFMW@gmail.com>
Cc: <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (Aug 2026, #02)
From: "Pablo Sabater" <pabloosabaterr@gmail.com>
To: "Junio C Hamano" <gitster@pobox.com>, "Pablo Sabater"
 <pabloosabaterr@gmail.com>
X-Mailer: aerc 0.21.0
References: <xmqq8q6knpyv.fsf@gitster.g>
 <DKHZ3ZMG23JK.369PS06XOZPU6@gmail.com> <xmqqh5l7kwhb.fsf@gitster.g>
In-Reply-To: <xmqqh5l7kwhb.fsf@gitster.g>

On Thu Aug 6, 2026 at 7:08 PM CEST, Junio C Hamano wrote:
> "Pablo Sabater" <pabloosabaterr@gmail.com> writes:
>
>> On Thu Aug 6, 2026 at 12:48 AM CEST, Junio C Hamano wrote:
>>>
>>> * ps/cat-file-remote-object-info-type (2026-08-04) 10 commits
>>>  - cat-file: unify default format
>>>  - serve: advertise type capability
>>>  - fetch-object-info: parse type from server response
>>>  - protocol-caps: add type support to object-info
>>>  - fetch-object-info: die() on the remaining error path
>>>  - fetch-object-info: use dedicated struct for the results
>>>  - fetch-object-info: pass arguments directly instead of a struct
>>>  - fetch-object-info: detect malformed server responses
>>>  - t5701: use test_file_size() to get the size of a file
>>>  - Merge branch 'ps/cat-file-remote-object-info' into ps/cat-file-remot=
e-object-info-type
>>>
>>>  The 'remote-object-info' command for 'git cat-file --batch-command'
>>>  has been extended to support the '%(objecttype)' placeholder.
>>>
>>>  Needs review.
>>>  cf. <xmqqpkzxtyac.fsf@gitster.g>
>>>  cf. <xmqqldalty3i.fsf@gitster.g>
>>>  source: <20260804-objecttype-support-v4-0-31511b0231be@gmail.com>
>>>
>>
>> Hi,
>>
>> The topic ps/cat-file-remote-object-info graduated to 'master' last
>> What's cooking [1], so ps/cat-file-remote-object-info-type can go on top
>> of 'master' as is and the merge requirement can be dropped.
>
> Sorry, but what do you mean by a 'merge requirement'?
>
> I generally keep the same base as before when there is no reason to
> rebase.  It makes easier to view the differences between iterations.
> 'git diff @{1} @{0}' would work just fine, for example.  If you
> rebase, you would need to guess from the output of the 'range-diff'
> command, which, while much better than nothing, is still not easy to
> read.
>
> The above is kept on the same synthetic base, as I did not (and do
> not) see any need to rebase, but perhaps you have reasons I missed?

Nothing you missed, sorry, I thought that because this series started
with a based-on trailer due to ps/cat-file-remote-object-info not
in 'master' yet, the:

  - Merge branch 'ps/cat-file-remote-object-info' into ps/cat-file-remote-o=
bject-info-type

was because of that, and since last reroll I sent I dropped that based-on
I thought that it wasn't needed anymore.

So, my mistake there.

>
> By the way, I just noticed that the commit count includes the number
> of synthetic bases, which may be a bit confusing, if not wrong.  The
> tooling to maintain the 'What's cooking' report may rely on the
> count exactly matching the number of lines below the headline, which
> is the number of commits in the 'git log --first-parent master..'
> chain.  I might look into changing it to show the number of
> contributor patches in the series, but it may take some time before
> I get to it.

Thanks,
Pablo

