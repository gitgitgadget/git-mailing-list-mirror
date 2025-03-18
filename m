Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6707F1DEFDA
	for <git@vger.kernel.org>; Tue, 18 Mar 2025 21:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742334579; cv=none; b=BY+QJTYcDnAh1jBCFylmWwowB8yYkdWDtwptwnT6tzucjXuWWcWLdNYVDMuYHDGM/nDpqWds2uI7+LIyPYI8/kv3xAqH/IjfqvhTTNPigNln388acM95eyIVM0aeWReztQ0SqSJOVaErJhpn5nb9q/Vnc00m2W4hKfkRr+dFrTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742334579; c=relaxed/simple;
	bh=Si+2D5PdQ1VOZCvxf+0oc4oYaxzkdsj6jdnolKnRIuk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gcZlvssYtlyseh9Tm5o3wtgMMrH2Ewnpg7UuR0iWTMNYDh9wZ1YSZ1g/sPz806RzSVe7ygk0buEIyHWbhNb1+ybdt0NJuS7gvWw9cDUTWl0+Z/RECYnhjIdPDY6cLNlMjTNGcHu0ehUvkLPCCGET1v7P3A7z6f/zvdgm85ujmJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7c5528c98bdso23521385a.1
        for <git@vger.kernel.org>; Tue, 18 Mar 2025 14:49:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742334576; x=1742939376;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+Ue0uQH7qR0x7Mb9Ds7fxyMnY8ZcAzhwC6ksSCLEBuU=;
        b=FHmVebZLPIo88yLMxbK1wG2/TSeJsFKa6qtpBRP6QYo3eDtdUS+N4zIh6MS1iFc40D
         HoTcO6ZNlCYVAE2JiwXsTIpQOsxhXt3ysDfx8t/zuKqXwL4mHAddYlEIAS/BdQnn2JaZ
         e1wnA5vWKjTnj9AXDqQkSnCAE09E2orUY67BF90kP/OVgAOY8DTw/4sCHUgy/4VJPNfO
         EOFfTU9xewQg1JuQnLnxpPxLMZKvYZH620lR10ETyy69PHnJeUPL7USv4CAsoJrbvOuF
         tPNcwzARBUu00Surruy3cYMSb4HUfawaAfBbfY1BQw0Yu/JQ0spp2AjIjp5wmXr6XS9g
         3Hrg==
X-Forwarded-Encrypted: i=1; AJvYcCWs2cJta1k/9c02ME5gCxDnovb+GAvYflmE0t+Ty1mxbQR13FC+MWJpWzuJm+pt8y7WdSI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHSqYJTiYrv93HOJttW9rC8vBieFMl0z7/FKH4ywTDzus7wiwk
	9D1ItqHW74jo8czA8ftNF5bxAAiYydxJCRn+QmSb5lHzjuh6VALgh2Qy3RbtmqbDXdLOOF/nH6A
	sTk9ZkMF30//tAizzHTklewSGkTY=
X-Gm-Gg: ASbGncvBuOo/yy/Ido7g3iNYn6Or3F3//dNRHX43MQexzb8nh6V0uQl3DdC+iyXYTCP
	FB2qsKxfuZs89NUVbfrT49v5w5lKOrpv+DPEEsEFBnf7H5zCR1HvGrcCkMNhsmVt03jaIPnT5HB
	5rhReMEnJ2Q/6q5J8xF88zd7puGFQnUpH37yNrcfQo63eJAceTYLqn0fbG2os=
X-Google-Smtp-Source: AGHT+IG4h7wkAg81cytsw1wWTkYp9/Pqko+2l4Y/o/vYhhIZ/SFkPPleqjC5aAQ3VJ2v5O2joZ5R+gx1wVR69KeUvl0=
X-Received: by 2002:a05:620a:24d6:b0:7c0:c42a:707d with SMTP id
 af79cd13be357-7c5a84e2336mr14821385a.15.1742334576121; Tue, 18 Mar 2025
 14:49:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1923.git.git.1742329571265.gitgitgadget@gmail.com> <xmqq5xk611o3.fsf@gitster.g>
In-Reply-To: <xmqq5xk611o3.fsf@gitster.g>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Tue, 18 Mar 2025 17:49:24 -0400
X-Gm-Features: AQ5f1JrZjhatNDLnvBt9xE_aAPct8VMWpODPXxHQUFllcUY90cKl9Rl9TWicvuo
Message-ID: <CAPig+cSXiKOBq_+9+uDTFOLf5F8+KPocwXVX2VzPQAxJHQL99w@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_=5BPATCH=5D_=5BGSoC_Patch=5D_Modernize_Test_Path_Checkin?=
	=?UTF-8?Q?g_in_Git=E2=80=99s_Test_Suite?=
To: Junio C Hamano <gitster@pobox.com>
Cc: Sampriyo Guin via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	"Patrick Steinhardt [ ]" <ps@pks.im>, "Karthik Nayak [ ]" <karthik.188@gmail.com>, 
	"Jialuo She [ ]" <shejialuo@gmail.com>, "Christian Couder [ ]" <christian.couder@gmail.com>, 
	"Ghanshyam Thakkar [ ]" <shyamthakkar001@gmail.com>, Sampriyo Guin <sampriyoguin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 18, 2025 at 5:14=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
> "Sampriyo Guin via GitGitGadget" <gitgitgadget@gmail.com> writes:
> >  test_expect_success MINGW 'GIT_SHELL_PATH points to a suitable shell' =
'
> >       shellpath=3D$(git var GIT_SHELL_PATH) &&
> >       case "$shellpath" in
> > -     [A-Z]:/*/sh.exe) test -f "$shellpath";;
> > +     [A-Z]:/*/sh.exe) test_path_is_file "$shellpath";;
> >       *) return 1;;
> >       esac
> >  '
>
> ... this one is iffy.  How well does it mesh with the "return 1"
> case in the same case/esac?  I do not use Windows, but if
> GIT_SHELL_PATH set by that system is not in a form that the platform
> expects (i.e. a drive letter and then path to a file "sh.exe"), it
> is just as grave a problem worth reporting as the path given is not
> a regular file, yet "return 1" case does not give any specific error
> message (instead it just lets the test fail), so it feels a bit
> uneven to make the "test -f" failure alone louder than it currently
> is.

Thanks for stating what I was thinking upon seeing this change.

> >  test_expect_success 'see if git pack-refs --prune remove ref files' '
> >       git branch f &&
> >       git pack-refs --all --prune &&
> > -     ! test -f .git/refs/heads/f
> > +     ! test_path_is_file .git/refs/heads/f
> >  '
>
> This conversion is wrong.  [...]
>
>     test_path_is_file () {
>             test "$#" -ne 1 && BUG "1 param"
>             if ! test -f "$1"
>             then
>                     echo "File $1 doesn't exist"
>                     false
>             fi
>     }
>
> The test wants to make sure that 'f' is not a file.  So you want to
> see a loud complaint when 'f' exists as a file.  Does it do so when
> you say
>
>         ! test_path_is_file .git/refs/heads/f
>
> in this test?  No, it will not enter the "then" block and silently
> succeed, and that return status is negated by that "!", so the test
> will notice that the expectation is not met, but you didn't achieve
> your goal of making it louder when it fail.  Worse, if the file is
> not there, as the test expects when Git is working correctly, your
>
>         ! test_path_is_file .git/refs/heads/f
>
> will enter the "then" block, complain that the file does not exist,
> returns a failure, and your "!" will turn it into a success.  The
> test passes, but the user is given an error message when the test is
> run with "-v" option.

And, again, you've said everything I was going to say, thus saving me
the effort of doing so.

Referring to the other thread at [*], perhaps this (avoiding `!` in
front of test_path_*) is yet another clarification which ought to be
added to the microproject description in order to lead candidates in a
more profitable direction.

[*]: https://lore.kernel.org/git/CAPig+cRm+sc+Rk-4SuQ5CrPeZLG2Nzz9B7+6OZxCq=
7tV5mzmBA@mail.gmail.com/

> I'll stop here.  I think all "! test_path_foo" changes in this patch
> are wrong.
>
> Unlike "test_grep" that lets you write "test_grep ! foo bar" to make
> sure that file 'bar' has no 'foo' in it (and complains loudly if
> 'foo' appears in 'bar'), test_path_foo family of helper functions do
> not let you write "test_path_exists ! no-such-file" unfortunately.
> So my recommendation for a microproject sample is to just drop these
> negations from the changes and stop there.

One other recommendation I would make is to restrict the microproject
submission to just a single test script (rather than updating twelve
of them) in order to avoid exhausting the pool for other potential
candidates.
