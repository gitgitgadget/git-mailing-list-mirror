Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="qMzYj3Nc"
Received: from mout.web.de (mout.web.de [212.227.15.4])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FDF39C
	for <git@vger.kernel.org>; Tue, 12 Dec 2023 14:30:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1702420204; x=1703025004; i=l.s.r@web.de;
	bh=XsB2pyZoN53cAG/YEYu1ouJ7oOQ1Q3kQn3w9EEIABKs=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=qMzYj3Ncb17BZVYW8McQuZXGWdCpq1yRJ0VIqDxXM/KUACht63Dx/SIP2jeiNUWp
	 GnMn8YjXQNi/FddW4kc0dEV1tW07QU9fCc1IZrsl2GPaaZyiLE+Xtq4KAXtAgsUgj
	 mU5aM2bc0aogOxxNDQUmSVCm89A2xjsivYs0AbdAiQkl8bW7kzQBruhy19avry08I
	 rpSf+dWbdS6Wn714fd4RuJACS3DSK0wDQZmitDZPsONivNDJy5ocmsqC/Jpd4s35g
	 r4Zc5hYajPC/fyNRrRt45/uIfo9bCDm5DvelWyPiQ+3aZbvhrIQuCbE24nuExWmEV
	 puoAcLdkDGdLkC/Oyg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.29.38]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mvbik-1rWDRy2p8Q-00sj8d; Tue, 12
 Dec 2023 23:30:04 +0100
Message-ID: <8bea38fe-38a3-412a-b189-541a6596d623@web.de>
Date: Tue, 12 Dec 2023 23:30:03 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Use ^=1 to toggle between 0 and 1
Content-Language: en-US
To: Jeff King <peff@peff.net>,
 AtariDreams via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,
 AtariDreams <83477269+AtariDreams@users.noreply.github.com>,
 Seija Kijin <doremylover123@gmail.com>
References: <pull.1620.git.git.1702401468082.gitgitgadget@gmail.com>
 <20231212200920.GC1127366@coredump.intra.peff.net>
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <20231212200920.GC1127366@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:lVWx6OQCUj+SG+2ThWmhnoTJkHV5WsVAVEqDE1/mlo5nNXlfo2q
 RtsUoJRQNZ+2bZH6IFc2Dj8HFpBMQNg1njM2eowqRVV/urM4edevnTNvNZAqFgEGcRW9mUA
 cTtu4L1zJz6WZzW8+sxkh79+xqxqqYyRyIAoZlzxzz7Ol+2xc+hVQrsYyUNZOEJYV7z2WY9
 yQ1mbItn6QUR6cwIIf6Yw==
UI-OutboundReport: notjunk:1;M01:P0:sR09TUhWbLo=;8Wjchiz6Dks7YKHJfCH+bqeR22V
 B35m/0kPE4YjxrgDLi8lD0GNy+hFDwtoMYKCmD1Pr3A9kh+dv0en5ybxrNnB70dww9OVzau6H
 yH2Jl730VD1tdzAsp0BwGZ3pdQk3J1yUP43B61GDJ/sxHnk30w95iiERc/HRGllejwfw+epg6
 7oxh9QdwZ2to1SflGYPdjbJ1MwmjtdQQ2Dyecsgxc5AS7Qy8dbN5RV8TXoGkAB5AoeZF2Lxpd
 h96APRYwmu8vOuQNzRyQN24qs5FU+kwqv70Jmj4UwDhOvCnP6nVEylyhx7JOj2krh2uzIfaHf
 FAkReU/ymQEEZuYeKHxmw72/+QwNf6Uk7Ra+R3AL4ktKHkoL5HauSfbm/Boyp54C+xysMPpHJ
 A/NhrwdBCv3Wyng/bfPN75RDLv8xXP3As5nKDSWla3VSqgkbiar2Y1In4Al9VJNJvroAaMOG5
 XHlbeyLqJOAnn7Mud0sRtORHBFbq03RPn8g6pyCe/dmnEZiitSKfPGwTEro19PLl3com56pet
 547qLNs+4qssfIAyBTu4Z+vIANBShZRy6XBuds+8f1foj5k4lQXiRgPBn222a46zRidn7sWkv
 I4IjDWTpUrjtmmks65Ax/MeOg2o1nU19KL9Y5FWC7nYOzRLr6w5G6tXVzD16XoLqWB1tp6N4r
 EKBZW5SPpZRVpcQsaxp6gptXAoJHfkHi0piI4mUpzn9mUkjUsYX19z1Lwu8CiT74OBCFfG9PG
 0IHMNL03jsQVY95PwYsCiIHi8kxbVLVU1J27FfCCYqgNCNowVbdc1SBbewncD1akPSTw5goVc
 hq6WEhxWLWNJlANjgGvHApd0vPvdJ52FMnC56utVEA+Bhaoa45atvF5RVwAoikbPwxQuFl7ub
 fAeEgoX7+iZ89HtDCeYxc/clhuKybf1DMEUxaC7mrjjrviBU55UQyhWYNultD5JZH+u8x4D7c
 OPOeHZRiM2SryIfHP3SEtBR7Qzg=

Am 12.12.23 um 21:09 schrieb Jeff King:
> On Tue, Dec 12, 2023 at 05:17:47PM +0000, AtariDreams via GitGitGadget w=
rote:
>
>> diff --git a/diff.c b/diff.c
>> index 2c602df10a3..91842b54753 100644
>> --- a/diff.c
>> +++ b/diff.c
>> @@ -1191,7 +1191,7 @@ static void mark_color_as_moved(struct diff_optio=
ns *o,
>>  							    &pmb_nr);
>>
>>  			if (contiguous && pmb_nr && moved_symbol =3D=3D l->s)
>> -				flipped_block =3D (flipped_block + 1) % 2;
>> +				flipped_block ^=3D 1;
>>  			else
>>  				flipped_block =3D 0;
>
> This one I do not see any problem with changing, though I think it is a
> matter of opinion on which is more readable (I actually tend to think of
> "x =3D 0 - x" as idiomatic for flipping).

Did you mean "x =3D 1 - x"?

    x 0 - x 1 - x
   -- ----- -----
   -1    +1    +2
    0     0    +1
   +1    -1     0

I don't particular like this; it repeats x and seems error-prone. ;-)

I agree with your assessment of the other three cases in the patch.

Can we salvage something from this bikeshedding exercise?  I wonder if
it's time to use the C99 type _Bool in our code.  It would allow
documenting that only two possible values exist in cases like the one
above.  That would be even more useful for function returns, I assume.

Ren=C3=A9

