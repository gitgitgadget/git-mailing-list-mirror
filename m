Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20FA510FD
	for <git@vger.kernel.org>; Tue, 31 Oct 2023 06:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="K+rpDeL6"
Received: from mout.web.de (mout.web.de [212.227.17.11])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AD8B127
	for <git@vger.kernel.org>; Mon, 30 Oct 2023 23:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1698732985; x=1699337785; i=l.s.r@web.de;
	bh=XDj6DGHAfWK8jkx1HkanFiykKvSRtbCD3VhhdqbucWY=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=K+rpDeL6EG75COwdLLrzJircP71lbRroQxPVj0XaLLreiQHO4M7J2A46Ag5pkBc9
	 q8gW/crLeJFxUGFylfG9emanPsRykthG0QbXQu1FL47J01ZnioUNAJA00nJDHcO5e
	 yCMLgRHckCfh/ahZIg8c8asjKPZeYZw5OvbN2EwkPn3EdV2GtUur9UxOVX+UcliVe
	 8QeviLGknOGfg5px3DWKFqpFmlL4AI4IzbD3+3UBBA4Qp0DlVFNCvPlYJTMugxoln
	 b3cYIbzfrPJTOv0JBrli5rvE0W70bUmQvlgBuedpFDGS/Z6SdhptKZDHg04YHBrLY
	 Co2uzmlc8po7idJe8Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.159.209]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M7ux6-1r2dj91qok-0056I6; Tue, 31
 Oct 2023 07:16:25 +0100
Message-ID: <59ea250d-364e-4a41-9511-4e2ff1a7cfb4@web.de>
Date: Tue, 31 Oct 2023 07:16:24 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] reflog: fix expire --single-worktree
Content-Language: en-US
To: Junio C Hamano <gitster@pobox.com>
Cc: Git List <git@vger.kernel.org>, John Cai <johncai86@gmail.com>
References: <63eade0e-bf2c-4906-8b4c-689797cff737@web.de>
 <xmqqa5s1hxhh.fsf@gitster.g> <82b832cb-da0b-47cf-9b5d-e8011a222151@web.de>
 <xmqqlebjbt9y.fsf@gitster.g>
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <xmqqlebjbt9y.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:HjsPcLbfp4CjF8pNUBz9Aa2VOHiNqBL1YKsv1TIhyyTZSQMqr05
 GQUjo/o3Tj0+vokKgeE7+52cR5TtdzgEQ1XlWGdSRhtZHLPDp8/nTqDUpDXGQfeEQDlJ3op
 Uh+ExApOCRsEN569kWWYJR2uFqca3lGaEru33aRizQlNoqAJZ1Q/POX0xadbwm7SwSsZQnO
 XnAqg6voIV2EViPsNDWaw==
UI-OutboundReport: notjunk:1;M01:P0:5WEviSXdpxk=;QJEKKlCwQ8/wYZrcvYf0SYTaky0
 gO7cSZaq/neB+KLtkD9GaN+/YGDKAOVFPZ5UWiT4X3PIOBRgT/L7C8vw011VdLLuDCiy5BEFO
 3DWG1fK3bUZ9PNIgAgsH34+UIJozOQtyfEVyRMA1OGEuEJgI9bCb9mJ8+apE7bIjZmIWGOgei
 heJVSd2sdMJttRvDe2VUTtv8Mlm2LQOHEN5VTvNvw/voEjm6LXBHXmDYmFIneyt0HiwBLIo4U
 /5Z0y6SUMSVxVNMvs+gVkWjulCt7zPZ6WR14umyut92sZM4BstWBzHmX2P6Ykf8gcRzbuuqDs
 Et6x6mfLOZRxcPXcDA9GQzwtdjKHjxv9TKQlVA5+Q4JEKfmo3hvOnvITq5gafiYZ46YTx8Qm8
 nZEtNJHMKfikmRZEvvFcQ1+kyUhHLD5QZSm01wNejUTTFcxCc6AIq+3L86c2rb+7XuCPsDtrj
 t5ZltQbcM0RHx5/OL4Lk1IiFZ0X0cE47A0568qOdGxp4tzCY6MfdTvqdEpuA7Vxg7GHDT9J7m
 Ra1cx/b7f1rymxBztfQefdsUF4886T+AibJ6CS1xlG3NMKPBWzmTVuBv/z1WaYFt0IRXnUPke
 5z4Hh08TFG8hFkowfCEMWWzvImOBsLJ0WiDYMTuVaEdwn3MgizqaeEg/8OlZEypYEDOcPC2TW
 NLKzjIZJbleM0Ul4t0Wg5vH1MVYQuXNqIet5uUXgNd5GdQ8v7axv0ql1FqpLrsCS7f5XFnrTO
 XZRCDjlt0fp1uLzvpvdlQSZPl1m6nz1grbhzDhPVQ6P/khRxcpgyd6sfBnI1rftdZMq4VphyU
 If3AJQvFyfoOEPk1O3pmuPZu0UpnzdArbYo3pVRImVzHqnw+daCxzunLuNMCC/pz/yXpin+te
 ySl/5qIDqZqAdp0ENZlKP8iwbVkBJfjjwxsjpdVMXSw/+nHVUx5AqrkHe1MxT8E49Mz2EWdv5
 ip+lnA==

Am 31.10.23 um 00:11 schrieb Junio C Hamano:
> Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
>
>> Am 29.10.23 um 23:31 schrieb Junio C Hamano:
>>> Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
>>>
>>> diff --git i/parse-options.c w/parse-options.c
>>> index 093eaf2db8..be8bedba29 100644
>>> --- i/parse-options.c
>>> +++ w/parse-options.c
>>> @@ -469,7 +469,8 @@ static void parse_options_check(const struct optio=
n *opts)
>>>  			optbug(opts, "uses incompatible flags "
>>>  			       "LASTARG_DEFAULT and OPTARG");
>>>  		if (opts->short_name) {
>>> -			if (0x7F <=3D opts->short_name)
>>> +			if (opts->short_name &&
>>> +			    (opts->short_name < 0x21 || 0x7F <=3D opts->short_name))
>>
>> Good idea.  This is equivalent to !isprint(opts->short_name), which I
>> find to be more readable here.
>
> Thanks---I didn't think of using !isprint() but you are right.  It
> is much shorter.
>
> I am not absolutely certain if it is easier to read, though.  I get
> always confused when asking myself if SP, HT, and LF are printables.
> (in other words, I cannot immediately answer "does 'printable' mean
> 'can be sent to a teletype and have it do what is expected to be
> done?"---the question I should be asking myself is "is 'printable'
> synonym to 'when printed, some ink is consumed'?").

isprint() accepts SP, but not HT or LF.  Go figure.  And thus I made an
off-by-one error by suggesting this macro, because your version rejects
SP (0x20).  Am I unintentionally making a point here for using the
is-macros because I can't read numeric comparisons? O_o

isalnum() and ispunct() could be used instead.

>> Seeing why "char short_opts[128];" a
>> few lines up is big enough would become a bit harder, though.
>
> Sorry, but I do not quite follow.  We used to allow anything below
> 0x7e; now we clip that range further to reject anything below 0x21.
> If [128] was big enough, it still is big enough, no?
>
> Because the type of .short_name member is "int", we could have had
> negative number in there and access to short_opts[] on the next line
> would have been out of bounds.  By clipping the lower bound, we get
> rid of that risk, no?

Yes, but if the allowed range is hidden behind macro invocations then
the boundaries are no longer as obvious as in your version.

>>>  				optbug(opts, "invalid short name");
>>>  			else if (short_opts[opts->short_name]++)
>>>  				optbug(opts, "short name already used");
