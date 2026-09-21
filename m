Received: from mail-yx2-f13.google.com (mail-yx2-f13.google.com [74.125.224.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A1A45D5D0
	for <git@vger.kernel.org>; Mon, 21 Sep 2026 18:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790017144; cv=pass; b=OqEE5mHNCB0qS745upSHQyr/Lh/ZiG1ICAyRGM6W5xO8vaOUaPi1pCSZn22yISx4H9eCNWeZL32XrEgDoOJmKzYxGtpA6w6YvCan87ZXmjhjZarr2uk0G36ta+IvOy0cGvUGPbstn23EJ39fGaqRAUn0SEZeDRUVIoO2O5sKj+M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790017144; c=relaxed/simple;
	bh=4avjPgOZXKLVe0Nugk0KdshshTbbdfu7Jsawe0Wrbnk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G5JEgPG7WU8CiO4ZvBtBiP71LwKKiHcLvd7hAhAW/xmo99xIiwuVwkZC1lsfZC2+yOs8ey7Q8cTizCDcGo0GkkD9MAZOVS9N/90iOL2rOSXodhKIbREOpym3T8mZwRyfnroJNafHDdxYMy3Gx6LBo27Wb6SKgJob5fQCDBpK/9A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com; spf=pass smtp.mailfrom=spotify.com; dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b=SbT7eFTM; arc=pass smtp.client-ip=74.125.224.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=spotify.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b="SbT7eFTM"
Received: by mail-yx2-f13.google.com with SMTP id 956f58d0204a3-66e4aae314aso2603673d50.3
        for <git@vger.kernel.org>; Mon, 21 Sep 2026 11:59:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790017141; cv=none;
        d=google.com; s=arc-20260327;
        b=mYUE6DjR+KopOtLDbPl67aNy3gFYmZf8EzwfWw1ST2rYngHhcuKpevDPAvllibWsEw
         PU5oct45j/EN12lhLRM6V5Ym47a0UsC5pSeXQUmiJZnvtd3oPc4A7fzR4tAyA60CRVWD
         gnkkwQUjokfrviLnXwx+wW5bBQ0k78n5ESqmH7b2fSmrV8Sye+LhvMpYunfTv8qtKN1I
         t1yFut/IaVJ8T9ftFxoFWKmqOx1ZaJS3rTLZafXBYAppDO2iXCSnVUUIAUKIlvW0svpq
         HridD38ZOoZaMGxwWaG4JELAPar0sE+IxeUdBGBDG5PeHjBDJTHMbHwLp6cdrXucXA4U
         yJjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=/ikv5J0jrtf9iZ0r1l09DF1/FsX5Zl072kRcRWn948M=;
        fh=jDgxVgW5HMmMklGHDEfDpyDB4KnfpemdthnluZs0mxQ=;
        b=O5hSC7cdj1kVOyoUUwgyLn3fIAiMZt5Z11wf5BcFQY8ezOQVndobOkv6I99yJK8XgR
         B2Vj/8HiaeCeM+28gRN6m1j9tPg0oMBix5T3gd3qZ+Rk5mdlW8bTzRlb4EDwOSU/A9FS
         viMzzlqXl5Yj6vENlwpeJZN99If1eltdj264BfmQnY0AlnvWNIoX2jpXIA0/fOF97IAv
         Q167GRuZRd5upEZAUTLlGQ0f02XnSDp2p9Q2k9BGw+Crysh10otOJmNz0MClWjo40q4V
         o4tTSksjJj5YGm2QFcHjRebARR/HFUmV8H5TBmT33SHnBgVu17uGbiO/rV9NXQdlOfeb
         Tzaw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spotify.com; s=google; t=1790017141; x=1790621941; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/ikv5J0jrtf9iZ0r1l09DF1/FsX5Zl072kRcRWn948M=;
        b=SbT7eFTMJqecCB4nW/6rgosYS8XU5KC3hi4sZfJFIXNPef0n/7tUcKS96lG5B9wwXD
         3o4Wl2BuEQqn2yZlq9W+k9Gg2HM6BNFFWdhn4fGHt0KYDifjlBkDdFtYcZhNiMB4rXZK
         G8ZDghQxmdBbFHdO+d8fSKd1c+MQ10CBRJsX4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790017141; x=1790621941;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=/ikv5J0jrtf9iZ0r1l09DF1/FsX5Zl072kRcRWn948M=;
        b=K95Hi9KwMpKmlVd4pOo9zpNcGQaZGiyFaeejpj8vHCOWcODergxxuyc8+BxZ9VgqW7
         hJ+EjJfFnJX1WNzMyXjBc01oW8hwj0C70vvjfIQo0jDOJirW1vCJ5qGbk9yLpzKyamGt
         dtBAxIoeUmu+lOCeoHdmvKPdoKw4MXeDSkD/8N9dvXOqVQ1viL19mJTQ3yotjVrfCUKC
         dmcY+PuTMwrbbZ/sWriatSGTLUzzUvnpASZzltlc0zira6E/hlNNo+iY2OZ/XhChmzi2
         POMbZ8MzJ+T/WNxOKQxGHrtdQmAAXWgshFzebNoYj3Xxzz0Cs1z6QaaBWnjUkwxgLmLI
         DmDQ==
X-Forwarded-Encrypted: i=1; AKwUvBx5HqZhmb3K9fya1io2Cu2tjZl1EFGr9rEk6hZWRL0tV5fBuOCCto+ZZclhD0iLgJcwJzU=@vger.kernel.org
X-Gm-Message-State: AFuF++loY6m1kqfXZDagVqvjT/u/qNapgqaxPONIuUtqTzPzDkpOwaX/
	dmYYV3ANRVu0FVbm7IoC0zdhCR/lF/0vBlVcgKIxWRrpBRemymwPCt7tjcwY8AAHCCPRUssJLSe
	BBG6StYzDyit+ybveMX2DtIUJihggdQR2GI0KL1OCQhq0kA1vZWNl3fSdbw==
X-Gm-Gg: AYBFou03bjqaJVqZFFjy3TltZ6iFGYdg+sskJxipyvOQZ4bPzf8Ic0or4AKGlqmf771
	j4y8PPrPgA3BY+Ax4TTwviv+qNz/juwlY5po3ZFPGDRT0Tb+7TR7TTJX2vNWWWWgWFj3Z/cX58v
	sH16EZsP6uf8t/HJLMBJoetgGzI+ZRiv411Mj/hsldhcDrcB2Rvovj7OvSUCRrPnTjUHrhiYVkc
	NpKluOp8T3a6tEhaQwPkPMpE7M3EfjNxbRoxgvigHaNf8JYtwDDEaThOXcuHnIGQyJ3gEAxy0lV
	fVGZhE7NCkesqKHIs00RV+YEnY9lqCNCOCgRMhGmC7obqoKDos8gl5U=
X-Received: by 2002:a05:690e:1449:b0:672:a2a3:c9db with SMTP id
 956f58d0204a3-672a2a3cb34mr2533183d50.40.1790017141385; Mon, 21 Sep 2026
 11:59:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2234.git.1789991377413.gitgitgadget@gmail.com> <xmqqse32mrzm.fsf@gitster.g>
In-Reply-To: <xmqqse32mrzm.fsf@gitster.g>
From: Kristofer Karlsson <krka@spotify.com>
Date: Mon, 21 Sep 2026 20:58:50 +0200
X-Gm-Features: AcwNN1WoIp8EzBePL0kfAxgYHO9jOtrHkxp_7wLf4xxD6VlO5XyFdq_I0TbRK7w
Message-ID: <CAL71e4OW7=WhkTtzifG2fBNp748HvipW5AJiTOPynwXyo-BFaQ@mail.gmail.com>
Subject: Re: [PATCH] line-range: skip trailing empty lines in funcname range
To: Junio C Hamano <gitster@pobox.com>
Cc: Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	=?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>, 
	Nikita Makarov <n.makarov@yadro.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 21 Sept 2026 at 19:30, Junio C Hamano <gitster@pobox.com> wrote:
>
> "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>
> > diff --git a/line-range.c b/line-range.c
> > index b99f0d9895..44b52d4e34 100644
> > --- a/line-range.c
> > +++ b/line-range.c
> > @@ -233,6 +233,11 @@ static const char *parse_range_funcname(
> >               (*end)++;
> >       }
> >
> > +     /* exclude trailing empty lines from the function range */
> > +     while (*end > *begin + 1 &&
> > +            nth_line_cb(cb_data, *end - 1)[0] == '\n')
> > +             (*end)--;
> > +
>
> While the new behaviour may mean well, the implementation falls a
> bit short of matching what "grep -W" did, doesn't it?  Over there we
> treat a line with only whitespace characters on it as an empty line
> that we want to ignore, but the above code does not allow anything
> before the LF.  I do not know offhand if the above misbehaves on
> CRLF text files, but if you treated a line with only whitespace
> characters on it as an empty line, concerns on CRLF files would also
> disappear ;-).
>

Ah yes, a blank line is not the same as an empty line, good point.

I also noticed the old behavior is still in the documentation
for man git grep:

    -W, --function-context
        Show the surrounding text from the previous line
        containing a function name up to the one before
        the next function name, effectively showing the whole
        function in which the match was found.

And for man git log (in the -L section):

    If :<funcname> is given in place of <start> and <end>,
    it is a regular expression that denotes the range from
    the first funcname line that matches <funcname>, up to
    the next funcname line.  :<funcname> searches from the
    end of the previous -L range, if any, otherwise from the
    start of file.

So neither of these functions should do any blank-line trimming
according to the docs (but the docs can be changed).

So I suppose the question is what behavior we actually want,
and if these two use cases should be analogous or not.

Thanks,
Kristofer
