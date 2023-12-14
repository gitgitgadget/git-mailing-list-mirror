Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="tUM6iONU"
Received: from mout.web.de (mout.web.de [217.72.192.78])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20E53113
	for <git@vger.kernel.org>; Thu, 14 Dec 2023 05:08:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1702559311; x=1703164111; i=l.s.r@web.de;
	bh=IwDwYAZ+nzWB24V/BH624zVUlC+NZT7y1EgD1+dnbOo=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=tUM6iONUy1SVN4UEYlrCOlyQNyljmZplnvNfpe1RfeQ4EO1gByXy4d2/3J6jsKac
	 N8oDP2oIjiwdrPZIu4DhJXSR3TbDn3/W8VBiw+eN6ipORfY9LW9T+h0lC/5S/Fli+
	 muqcYl61TwxMQof+RQKuAJTtGjAUjjw49l/AUBuPLqZ6Ept1Ace2Urqoj7NgMALF7
	 e7iPWxIyAYEt3SJoBr0c7EkQWMmuDZj15t0kMJ/b3bgm4Ui+LMpn81iVqVndC4C0d
	 hIXl55F3kxXhoHuRxHYUyrOLjskcP/2I6MJcHVwkEdwxyCQVL8sWSSKCSQ3p49cQl
	 eoEUomVo8SfdJympXQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.23.9]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MsJOq-1rSOeb3QZ0-00taLJ; Thu, 14
 Dec 2023 14:08:31 +0100
Message-ID: <4d0b2a5f-305b-4350-b164-44923cb250d8@web.de>
Date: Thu, 14 Dec 2023 14:08:31 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Use ^=1 to toggle between 0 and 1
Content-Language: en-US
To: Jeff King <peff@peff.net>
Cc: AtariDreams via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org, Seija Kijin <doremylover123@gmail.com>
References: <pull.1620.git.git.1702401468082.gitgitgadget@gmail.com>
 <20231212200920.GC1127366@coredump.intra.peff.net>
 <8bea38fe-38a3-412a-b189-541a6596d623@web.de>
 <20231213080143.GA1684525@coredump.intra.peff.net>
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <20231213080143.GA1684525@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:5GXYPFl8PhDM5jC4JYiFboVd+klz7oDfRupI6B0lmHW9IH+C2m4
 YA11aEwEuzqJrEpw8WCbf7nDyZcNBKwufn8UjcCwfReXuD3rKa5HLWPf2zQgtU5FjKXKqTa
 6AHt0+K6My7V1Dhn+azAd2tFIES+XLwIVEiH2LIz+9XQwIMAKpdNzuuPwgNYFXNf+YnRq6x
 ZVZnnMwGwWnRpZYOvc1Ew==
UI-OutboundReport: notjunk:1;M01:P0:l/50tTy2A8w=;nK+0p4Xe08EQsXRRoXLKpz7wLh/
 thBlfi7VmYb6H+i/De+C7kAp1TQm1U2NKb/ThxHyhqHnmALDULvM7kIfzstWNs5OIRxgSIOxN
 WIXIYyG7GSNlK7icHm0jEzANRk21BFMvUw4drsZ+el2RH7f0cjWINMZ1sxUZDtg0K16RCrpsw
 jQ8CvrHQkfCuZCuFVIyEWBol/AM5pULvkX1DPHRxX2kZDQQRn+4VoLlevi8n6Yuc7fAzKNy3u
 52+0FK23kGu1tObCuw2U9UdCt0yqcphhef5o6zh4wOYjptJfsX3YPkIA2N69HzOql7ZOOqtgi
 PKPAun9MMdFB7gOYXuARDS3EzOt1Z2/tyJoQ7MpYy0aw6eTVrA9qF1lMSV2yqrZE0pz2fEE1m
 ocNqfeGewe7uYd7qVrMyQCF3QNucfUr4LJQ+UWLaU6sf7N8svLTiGH0oShJoGtyDcB31tf1p7
 Rkm1Vq5SSxTxy3EUMoti1U4o6HeUj1KAfBYgTx73Dt+aBQZfcTCt/bfBgcqw/kfBXjbiFvBb2
 fDTI6JrgiMwj0W2Ka1fJIYeQfhf9IkDGBFmLmzAULeVDElcd/WGPwzJ0FTe8G3ZDmZhDx8YEX
 9LQOFTnVtAlyNf97Yr5DFLqqDdVIVq6kGCAheZiaGu8+INmWxGl7LoBoNbD7NnbDNtFtgsWdc
 F8fJVuOtONhZ51x2oHacDwKBdpGX6IYTSWyJhHP7QGho+BpcIPf5593o0T8+xEkkUl9xU1AUZ
 hz76LKc6bzBkKXtoEYh1cZFN9WRV6NkkQvuGc5CDjZvdrTdo6YzQYX+yx91xPmlL/2OpLBoEe
 /CqfisMLOEj9qJyeXLiyNin9f50BSKRMrhTuWmC0Te8uUgzVle1jHZfzVXEKTyvIcdalnM5xN
 NYc5janTVxDkjqMYcd7ucl+20H9MBDYOU89EwK7vUJ69ytjIwoTyoJwBFlwvlmeTuLSJ6wTaX
 kuynnuY0badYalVB6d9tT5PBm0o=

Am 13.12.23 um 09:01 schrieb Jeff King:
> On Tue, Dec 12, 2023 at 11:30:03PM +0100, Ren=C3=A9 Scharfe wrote:
>
>> I wonder if
>> it's time to use the C99 type _Bool in our code.  It would allow
>> documenting that only two possible values exist in cases like the one
>> above.  That would be even more useful for function returns, I assume.

> I don't even know that we'd need much of a weather-balloon patch. I
> think it would be valid to do:
>
>   #ifndef bool
>   #define bool int
>
> to handle pre-C99 compilers (if there even are any these days). Of
> course we probably need some conditional magic to try to "#include
> <stdbool.h>" for the actual C99. I guess we could assume C99 by default
> and then add NO_STDBOOL as an escape hatch if anybody complains.

The semantics are slightly different in edge cases, so that fallback
would not be fully watertight.  E.g. consider:

   bool b(bool cond) {return cond =3D=3D true;}
   bool b2(void) {return b(2);}

b() returns false if you give it false and true for anything else. b2()
returns true.

With int as the fallback this becomes:

   int b(int cond) {return cond =3D=3D 1;}
   int b2(void) {return b(2);}

Now only 1 is recognized as true, b2() returns 0 (false).

A coding rule to not compare bools could mitigate that.  Or a rule to
only use the values true and false in bool context and to only use
logical operators on them.

Ren=C3=A9
