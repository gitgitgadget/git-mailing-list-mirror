Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8D152E3E5
	for <git@vger.kernel.org>; Sat, 18 May 2024 17:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716054616; cv=none; b=T16fOVQ+8bRwo+J8hx1CZIUC+Yzb9oc4ULEelEJkiSTqxYLi3Um2mcOs0TYSkwzD25te7/Vl35hEcDGGLFb0cJDesHZzqRrYzZMy4wdP9x+6uwtKXDd7d7MKkeVVKshi3aRKhsj5qKVZaQHJNTA70fv7f5kDiEJEgt5Gq/APWiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716054616; c=relaxed/simple;
	bh=INZSzUlmo6p+BVLLDScjKss/gxoUB5yKRaM+08B+gzk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DAyHB7XckGviziHPU/XmwXXc4Xr5cFH1PMe5jntnV+v6NH2FoILp7TyUZWZZcNTm1vvVoYtJA/aUj/6fY9G8UnihLMwPfA9AfMPGx9XjeYefUmuIcrhVezoEHdCfsHzzoxZlCHjL4KydTtRxRcUThqvVd+tOjs4INsH52aMGDdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WStOFsR4; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WStOFsR4"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1ec486198b6so35806585ad.1
        for <git@vger.kernel.org>; Sat, 18 May 2024 10:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716054614; x=1716659414; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3inXiG+F8lKGAkqr57653WVSWR3Kv9j/2GRqLIXRtx4=;
        b=WStOFsR4p0QnWgaqaUbdSCjX9iHg4IYDwgrXQlYDgufUU2SDgUV7G/5dZSwpuF4kqg
         1vK6llC+fSnQFB0kFQjEc319zmZofgE5CNe+YdHMsM++IOsuaJd22/edKSNu8XO/Pa5N
         ydfXpM8bW/JMqQ/5fjqJhihnguviztUibEQ6ScbQmXutYWRskTK/auKucxvLwBtQ/CuY
         14W8QZksgjbev3g+7TKqC+JXm6EQ5wGeGWdIynfqbBg5ZAClXJnA6uOVGjc/AWF6yVDU
         ynQuBG6Dc/u6SxvzUYYbQABZ5basSp3qru7eGibaMPxgQnW2EyQ9IKzSFRCO+k87H7py
         fUWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716054614; x=1716659414;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3inXiG+F8lKGAkqr57653WVSWR3Kv9j/2GRqLIXRtx4=;
        b=nWRZTk/rMCjG3b0QJRQGXsxxgjeyXw3B0ur9oQDbE5vchCnxDFL2h4WhFpzBvKOCJI
         Pxn0oM8M4fWl7u8vJ3KAxdf+PfUrXq6nEBx+1+MGgKFSZwGoo2mOnvA0mLCzhCVVDwAB
         8Z2nwbx2G6EvPn84kLmcOOuGZY6pmFoIMnP1STtDe03zWSn40SRuWxrqeLUuWQZNn7xe
         7ZH5DCiPpLkzsKh6JsefDBg8Rdy4IXFl59myDsGUISfVRFy61+qv/p++h5wHRmT4+eFn
         WlEOutoKuMaMj4i7zRyVDjsg05giRFNlc2cyhP/pNeltB5uk3ZytX4p1Yc87TQr02y+5
         Asew==
X-Forwarded-Encrypted: i=1; AJvYcCU1J0jRFPyT5m4J0f3+kXXnEykwHQadYbuAY4sDu3keYYuI2Dojw5wefO0fjje29jxteY9WGB7UAr/3bi1pIaCzx17/
X-Gm-Message-State: AOJu0YwDc6MzwedZT83GA5dSOHFMfNH4KqUWpl6qT0uz5uJzHGlj4bq7
	K+X2HHN+ojJrHJt/DiCvUKYmFDfAwv0/rx1lwf4XplXyCT/Z8MSzjPbvp8OLUXdsZabTtWuzwqA
	YP6ILX0nwJHFItAlifMWjm9FUuCs=
X-Google-Smtp-Source: AGHT+IEI93yt384nrNsKjZ+9UAZGPNpM0Yq7MofS0zVnmWJGmL+FxZfPBQLtsawavyWeR+OEFowJOsVKX1aaiGrnPsY=
X-Received: by 2002:a05:6a21:2d84:b0:1b0:1a80:413c with SMTP id
 adf61e73a8af0-1b01a805de0mr14101706637.18.1716054614150; Sat, 18 May 2024
 10:50:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ee35f3b2-bf20-6fcc-2c71-38499aa592fe@gmx.de> <CABPp-BHv7K3gQ4+ZgOTFHUyhNm7dVa4wtzy_gtNHKNcyFYqr_g@mail.gmail.com>
 <CANiSa6gyNpJ3cUNLD1hFnBYeDFm6aFYv8k41MGvX+C90G8oaaw@mail.gmail.com>
In-Reply-To: <CANiSa6gyNpJ3cUNLD1hFnBYeDFm6aFYv8k41MGvX+C90G8oaaw@mail.gmail.com>
From: Martin von Zweigbergk <martinvonz@gmail.com>
Date: Sat, 18 May 2024 10:50:02 -0700
Message-ID: <CANiSa6hU6r-7K_GAyNtO4-_VUHBDfByd6ws3VdZEj4KKrSmryg@mail.gmail.com>
Subject: Re: Replaying merges
To: Elijah Newren <newren@gmail.com>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Now HTML-free

On Sat, May 18, 2024 at 9:33=E2=80=AFAM Martin von Zweigbergk
<martinvonz@gmail.com> wrote:
>
>
>
> On Fri, May 17, 2024, 18:45 Elijah Newren <newren@gmail.com> wrote:
>>
>> Hi Johannes!
>>
>> On Fri, May 17, 2024 at 5:35=E2=80=AFPM Johannes Schindelin
>> <Johannes.Schindelin@gmx.de> wrote:
>> >
>> > Hi Elijah,
>> >
>> > I took the suggestion to heart that you explained a couple of times to=
 me:
>> > To replay merge commits (including their merge conflict resolutions) b=
y
>> > using the _remerged_ commit as merge base, the original merge commit a=
s
>> > merge head, and the newly-created merge (with conflicts and all) as HE=
AD.
>> >
>> > I noodled on this idea a bit until I got it into a usable shape that I
>> > applied to great effect when working on the recent embargoed releases.
>> >
>> > Here it is, the script [*1*] that I used (basically replacing all the
>> > `merge -C` instances in the rebase script with `replay-merge.sh`):
>> >
>> <snip>
>> > For the most part, this worked beautifully.
>>
>> Cool to see someone try it out.
>>
>> > However. The devil lies in the detail.
>>
>> Yup, but details rather than detail.  ;-)
>>
>> <snip>
>> > The biggest complication being the scenario... when a merge
>> > conflict had been addressed in the original merge commit, but in the
>> > replayed merge there is no conflict. In such a scenario, this script _=
will
>> > create not one, but two merge conflicts, nested ones_!
>>
>> Only if merge.conflictStyle=3D"diff3"; if merge.conflictStyle=3D"merge",
>> then there will be no nested conflict (since the nested conflict comes
>> from the fact that the base version had a conflict itself).
>>
>> This is one of the issues I noted in my write up a couple years ago:
>> https://github.com/newren/git/blob/replay/replay-design-notes.txt#L315-L=
316
>>
>> Further, it can get worse, since in the current code the inner
>> conflict from the base merge could be an already arbitrarily nested
>> merge conflict with N levels (due to recursive merging allowing
>> arbitrary nested of merge conflicts), giving us an overall nesting of
>> N+1 merge conflicts rather than just the 2 you assumed.  That's ugly
>> enough, but we also need to worry about ensuring the conflict markers
>> from different merges get different conflict marker lengths, which
>> presents an extra challenge since the outer merge here is not part of
>> the original recursive merge.
>>
>> In addition to these challenges, there's some other ones:
>>   * What about when the remerged commit and the newly-created merge
>> have the "same" conflict.  Does it actually look the "same" to the
>> diff machinery so that it can resolve the conflict away to how the
>> original merge resolved?  (Answer: not with a naive merge of these
>> three commits; we need to do some extra tweaking.  I'm actually
>> suprised you said this basic idea worked given this particular
>> problem.)
>>   * What about conflicts with binary files?  Or non-textual conflicts
>> of other types like modify/delete or rename/rename?
>>
>> > I still do think that your idea has merit, but I fear that it won't ev=
er
>> > be as easy as performing multiple three-way merges in succession.
>>
>> I totally agree we need to do more than the simple merge of those
>> three "commits"; I have ideas for this that address some of the
>> challenges over at
>> https://github.com/newren/git/blob/replay/replay-design-notes.txt#L264-L=
341
>
>
> Another approach is to not eagerly evaluate the auto-merged parent tree a=
nd instead do some algebra on the trees. For example, if the parents of the=
 merge commit is calculated by merging tree B and tree C with tree A as bas=
e, then you can consider the result as tree B+C-A. If the merge commit itse=
lf has tree D and you're rebasing it onto tree E, then the result is E+(D-(=
B+C-A)). You can then evaluate that by recursively merging the trees as usu=
al. This is effectively what jj does and it works very well.
>
> I don't think Git has support for merging more than 3 trees (or tree entr=
ies, etc.) at once yet, but that's not very hard. Here's how jj does it: ht=
tps://github.com/martinvonz/jj/blob/main/lib%2Fsrc%2Fmerge.rs. I think the =
tests at the end there are quite easy to read and they explain well how it =
works.
>
>
>
>
