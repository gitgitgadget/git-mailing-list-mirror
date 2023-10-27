Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B75B7179B2
	for <git@vger.kernel.org>; Fri, 27 Oct 2023 13:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WCgBHAu4"
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC59810E
	for <git@vger.kernel.org>; Fri, 27 Oct 2023 06:06:37 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-32dcd3e5f3fso1391995f8f.1
        for <git@vger.kernel.org>; Fri, 27 Oct 2023 06:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698411996; x=1699016796; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=LwHI521JekqgU7jghVFrmkSt1GmvP5umfx30la2OXDg=;
        b=WCgBHAu46okN/ocmKzvHw4ivd9NW2p3dU0Xirxgmymgq+SsmTQkpUGNRudI6mBIb0u
         gvnXA5yi2A8FD6s84rgfc/dJjfixuDrGD3aTMJ7hCkSAYMPKMO8Dsz53mLKod4hucC/Q
         LERdqpjIcg3xM+jV/zvtD37KCqoTV8sjPNp0hf+yBzcL9AQgE6XRmEIbjfWkOW4+YvYl
         hpyR3kbqANhzGZ1hICS7VE2YcGGdI2aq4cIW7rnqFkOTFWlNO1PQVltpO1SAoWYlAf7x
         mL2veMgZqy+uaM36U55QPBlGI7iQzaBLXi5lxDJuNNFERWfFrbLyLrozd9+oiUd0eGHx
         ZP3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698411996; x=1699016796;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LwHI521JekqgU7jghVFrmkSt1GmvP5umfx30la2OXDg=;
        b=AE1O2/0ZRZKQjKFmSxf3P/7Kxs8T1XGNdu2VgL4WVywjuZg4DW5Tv5buI+2qFg3PIn
         0xumQB9KES9S7+/w3DLIbGbWjDcUu8xFxVxxW8s3sYUnnX/tbiiB+Bh/rYJwCelcWE/j
         hygwROZUpeFyI7Cv694kPlsIeHXC/i1xN5q4TYSdifzOKIOiCz8etTVGwX9imLKMdzwV
         KMYPJ3Ir+hx0Z19kKBMjrHKipqSSbzVaEqQ7ojUsuc8v+FmbLjuB9y/NY0A7S85m/Sy1
         RZ5SxjJBhYvPL4PJP9k5oqGsb5VTT3eo8EqLlXJp33UR+/R3m9ElBYhNUZO4YxPZPmFT
         7t9Q==
X-Gm-Message-State: AOJu0YxWjVmxZ7OstW3PK5nVBN8E7hStuUg1Hg6wzRKefT3gV5HMDlyG
	It6ch7+NFwUep0Q8+9LK250=
X-Google-Smtp-Source: AGHT+IGHCv+e6sa16NwT298HhKOgI/1UFwiTSPrjCmf+VwPQbCc/CBL5anTuJtJjMrMsP4U5Hz4Ltg==
X-Received: by 2002:adf:ee0a:0:b0:32d:b2e0:ed76 with SMTP id y10-20020adfee0a000000b0032db2e0ed76mr2095024wrn.49.1698411995361;
        Fri, 27 Oct 2023 06:06:35 -0700 (PDT)
Received: from [192.168.1.212] ([90.242.223.1])
        by smtp.gmail.com with ESMTPSA id s4-20020a5d69c4000000b0032d829e10c0sm1744999wrw.28.2023.10.27.06.06.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Oct 2023 06:06:35 -0700 (PDT)
Message-ID: <dc2b850b-8b58-414b-ad99-4c2e0cb1d63a@gmail.com>
Date: Fri, 27 Oct 2023 14:06:34 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 00/12] show-ref: introduce mode to check for ref existence
Content-Language: en-US
To: Patrick Steinhardt <ps@pks.im>, phillip.wood@dunelm.org.uk
Cc: Han-Wen Nienhuys <hanwen@google.com>, Junio C Hamano <gitster@pobox.com>,
 git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
References: <cover.1698152926.git.ps@pks.im> <xmqqttqf3k5a.fsf@gitster.g>
 <CAFQ2z_PqNsz+zycSxz=q2cUVOpJS-AEjwHxEM-fiafxd3dxc9g@mail.gmail.com>
 <f87c95d6-b1e5-45c7-b380-bdc8b8143ab9@gmail.com> <ZTo2Aq2wAxx_6Laz@tanuki>
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <ZTo2Aq2wAxx_6Laz@tanuki>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Patrick

On 26/10/2023 10:48, Patrick Steinhardt wrote:
> On Wed, Oct 25, 2023 at 03:44:33PM +0100, Phillip Wood wrote:
>> On 25/10/2023 15:26, Han-Wen Nienhuys wrote:
>>> On Tue, Oct 24, 2023 at 9:17 PM Junio C Hamano <gitster@pobox.com> wrote:
>>>>
>>>> Patrick Steinhardt <ps@pks.im> writes:
>>>>
>>>>> this patch series introduces a new `--exists` mode to git-show-ref(1) to
>>>>> explicitly check for the existence of a reference, only.
>>>>
>>>> I agree that show-ref would be the best place for this feature (not
>>>> rev-parse, which is already a kitchen sink).  After all, the command
>>>> was designed for validating refs in 358ddb62 (Add "git show-ref"
>>>> builtin command, 2006-09-15).
>>>>
>>>> Thanks.  Hopefully I can take a look before I go offline.
>>>
>>> The series description doesn't say why users would care about this.
>>>
>>> If this is just to ease testing, I suggest adding functionality to a
>>> suitable test helper. Anything you add to git-show-ref is a publicly
>>> visible API that needs documentation and comes with a stability
>>> guarantee that is more expensive to maintain than test helper
>>> functionality.
>>
>> Does the new functionality provide a way for scripts to see if a branch is
>> unborn (i.e. has not commits yet)? I don't think we have a way to
>> distinguish between a ref that points to a missing object and an unborn
>> branch at the moment.
> 
> You could do it with two commands:
> 
> ```
> target=$(git symbolic-ref HEAD)
> git show-ref --exists "$target"
> case "$?" in
> 2)
>      echo "unborn branch";;
> 0)
>      echo "branch exists";;
> *)
>      echo "could be anything, dunno";;
> esac
> ```
> 
> While you could use git-rev-parse(1) instead of git-show-ref(1), you
> wouldn't be able to easily distinguish the case of a missing target
> reference and any other kind of error.

Thanks, it is helpful to have an example use outside of the test suite.

Best Wishes

Phillip
