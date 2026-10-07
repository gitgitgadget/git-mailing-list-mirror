Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 313F24A0933
	for <git@vger.kernel.org>; Wed,  7 Oct 2026 15:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791388674; cv=none; b=XF4FiuNDViXo+uYDJ++h55yUXzeT0iovr0fxYeapvWqnNxeJRBXImh5DuK7leA7MjbLVOeQMhn907jXoyt4LjKqyvj8RKrO8yLZ/crgEkAji86fb9GQmk901QS9tzZmHWCAOP3aeq9F/FJr05y/ZRIA0vx565aJzhFg0soGxfI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791388674; c=relaxed/simple;
	bh=7zGCOBVDOZ2QzhVqXAe081hz1GCGQUehOJUtQTV/52g=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=AtNM3iOVwPotOXotSWzK0ZneyeuL8Vn0pKheZ240eNNsAxHp0fv4gOBr2u5gN+TC6YubWgsjiH960mT/ZIfvEnY0UlVS7dkCAxWehi9MZ+dkMS3eYA8vMch5QCRm7XJcWDXf1udMouWVX2uqw1BW8wBPc0TzElYgSH6Sp5IwRp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=GhuZAz+/; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="GhuZAz+/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1791388670; x=1791993470; i=l.s.r@web.de;
	bh=/G/AjydFxEVEpu9jGI/4RWJkTrrYe8vgFYg8+vJ9/ps=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:From:Subject:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=GhuZAz+/D4tHMiGTRik9FOc287YjvBt99y0AV9lx+Iqt9VeBw27fThro1ve9On4U
	 D/0vLizr+P6PLXKuwOj/NQiT82d3YYsIAe7PBfKL3aSeW+GH79JFKtWernZPxx9zT
	 om6ZC7Jof+XyNT9+WmruOvdbyeT/JvYfaikWD4yN1qleKBZ5j6uOrxvxmz4Of612H
	 PWeJ1bcMgBMBidOI1d0k2jh3cr6lxpNrRTufg1hnHvD2gx+cBnUsMI0XnCmk2KcYv
	 iHII+u3bn+eQKjR4ZyzOJ6y+iM9zWHhhB09APMZYqQbcLuX6qsbglV1LeHz1dfpTi
	 nAt1CNRiixHGXyQqFA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N1u6d-1wZ01v0TMX-012rwC; Wed, 07
 Oct 2026 17:33:10 +0200
Message-ID: <6abe7f35-a1e4-4870-88d5-45ee40f5a061@web.de>
Date: Wed, 7 Oct 2026 17:33:09 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Subject: Re: [BUG] ZIP timestamp conversion and strict fast-import date
 validation
To: "Matthew E. Luallen" <m@sph3r3.com>
Cc: git@vger.kernel.org
References: <CA+h9NxRT-9QzLGihdL_Bp-yyt1AdXJ79YYgpK-OaegUz8e+HcA@mail.gmail.com>
 <f8dc40a4-920d-4dc5-9f71-7686bfc6255b@web.de>
 <CA+h9NxQEJaKrbTXUeryEhNMfOfuU0EykiJRi3PaJE9dRFo5tWw@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CA+h9NxQEJaKrbTXUeryEhNMfOfuU0EykiJRi3PaJE9dRFo5tWw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:VcX50tdRwZUQuSvK+9kez5W0is6THa0PJeJeBpjqI/nRz6SfUQN
 vLiFTf6GWGySyxW0AqQY12+bIxq0K6MROycuOBWMXm2Q6DUg9Y4ew6aWtRol48qnchJ1dc1
 SfW6/VGIVcZsXgPVkUytZTZlfz2G+drAiZobXMEsYNcQaeu1WMcFXhcmqGSWsCMKMW/y+HO
 zC0fs0yFqTA5bl1CnvaXA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:JbeaJDjQR/w=;9ZRNV30J9QAbobsWKwp3qktVW4j
 e3V25Ni6A6SUDX+3ughoNoqIw6RfetQ0J1ijy+Hscr1eRh9HotJLyzTG3Tgc1+NtvOKUrlSO/
 OGWVVpgg1zxPVInbq2dez/CJ990gEvuwPzwwhsieYZKZKjbD/U37/YJd1Ay9HQ6lgf/tNgKJL
 /eqC8y7hMxN/eTWRPVOtwTNf0fJINzftS3yatgs64oZyD/9i7Kgv0/gFcPh/hWEFFG4QmVWPu
 bMy5MZ6jjH5pOZV8DaVT7NQ6HbBpthMJZunA663L2EXeZmkiDMFE5EgV53Z+hdDRQPA4ZMi9j
 odpv3wLgdpBd3owHPyPYTZlIhL1fmh1Ai9ujG4NAkRyMBZgylzbqGpPg0DuH4HHtd+VwAdkRO
 w0ud4CwTQTq1z1RiaBNNI1WGt/4auEwJLGd3iQV6u7dGBUrtM/dikzGgkB5guNdCidX/r5nfZ
 gLMfwF4q3xrZadmNxEgQc6WlSYmqtQ7lSSt4giV8arGwSuR5ZAm5LFG4wZFW3VS8pjFyKBddn
 Pd5HSJ78EQjtosUYqYbQranylH1EnyG8dfI7SUHLEzR5+dUn21YgnQLzJ40BRtpYAAdigcq7h
 WnSbYz357y1cS3b4i/auQWhdZoElS9T2STr7qmg8sa65R+WDjEDpFqqlhOdqYB7+EaPikzjtd
 Vlk7XC2ix/jgKoCJFMHrP0id+GcA2H5mvzpHypwXAWVA2xUYmbYnpz+kI1SijGQjcxPC8kaNA
 YJ23F2t0M62yyNDSIxGdOMVu8nLqrTYM7+XXo+5MDOrgZT7wjtiuF+tLbsmoNqHrIcEYDMY4T
 SXbCJDqDNVwpqUFagoDOPA6QqVZfiKPpXD8Z+mHoifpqT/w9wLNbZMaK9teBBs3UqHTNwofNM
 3sIwNjPXAluNGuCkomtmVyYVr/NVt6BAmtzVmKc9/jqRtuOCA4hRRyR+mSUQVN6hTh3YS3o44
 /KWu7vAB1lpZvpttqcEvkftZJnm8jthUHqVDg1uTfYV4DPx1jG5ubMmEZ1dHLGi0hU+VYHaGm
 FBsAq1s6NQLQeQe0mBFbubURLHzRVMDtunntmE596HRJ3NflpLJVC6paWHX1V5iKj+wqF4JQL
 WoRKuDnd7JBiIaeRPrPFIgRTgnQMBC9HVdrP03qRntJsxuOw3/AhJYmtYiwzQLEJLGEiD0XVG
 UIHkxQBNrz1YzdISI8C8Yb9LLtIB0tHd3GzI4IjQNIp8d9XomrFss0qJa7a+pyzzdWuZd/VUp
 id/twGf+HAHw/6N8D0isfFyvD5ivP4Q5bnIt0Ft9x/rxmzuIeLqBFQTOC+KdxTm1XtMTCgZEy
 ILAZ9SndFoJJMSfEKQ+a5lTtlD12IFmwY3W/j4fJTcGwWYLJtvkAhamLNpFQfCqpKSAv2hMmC
 hMVPfc1q/yIVL9pJlQDTWpYcM/OsnG8byt+WoxZZ/qkC8jwNWKmpUImxAZATlHHuVqmgMgWRX
 ZIEEYLE0YMIwdbLb0UsmNWhUiPjTTV8QH26qu+HGwnyiULS19P7+82ko0vjZzxF2nmRoeccX3
 FlbhVYiQaEhFXKH3hHwUgMXBG4rPggHqBttjZ/tWkpYXVW6dfWaWf/G6gJlx35excFTZ6QBvJ
 6uN7YrhYh7z+qSXZZ6ByYj4Pwn3pqjybaC129bqdWG58KQrbnxFASFafoACflJqCXVoWnnrfF
 dFXKvBQwwK4/CXqvHpkL0XOu2Ba1yusNUd3sRAKdm21osPWE9f3UBMHPPb4HxsgJ2y79MeYAP
 tMIrUuWKYfiYLPITDOOA3K22tsrk5spe1hW60XzoB5KgI/GJD8H8hQXvKWvGyVKwD1MTxyfDu
 +5VEBsoUT7rlMmv+lcDGpGHGAwnXe4l+HUaPX4yp13eSH47jtBCYoxkH5UFrBg5xKmN+OBviH
 IWLwCtUfYC0Wz8BVAd+L5idQ0O9wKwFxWb6BhfniS3DYp/xNikvgaYgda4ALOQ0bTEZ/wxF6A
 PAfCVEAq+w9DjhzYtRp3r77sw7cc9umk+TghMR5s6H7Lnh7KYu186RXSHMwY6+5p2kHBiOuQa
 And4puf99OtcH5TWaBcp0pVMUiCdBcyk64V061s+8JnwKIIliP0IIsd3H2YrxFySdO0Lf13Li
 /IiNTr6NugT4turn+crbqTLbyuNXyBUGa/KDtlovM767/BGrmpGV1eVhFepgTpfmfFANBqIfO
 pFWBnfrpG5bulzJaiHAL9rEUM1+dHdPBeF2qRMtHHmqSdJb5dIxSIgYGSxhVhsO/FxwIyTRzo
 XUa4Y/04WIqQUdGYyWj9cOMdRVn4IosOleCe3LsC9FQQ2LCLsXnZAnBoOpdq5nP+Dtlsga1uO
 1q/I9GSwMOxD/1LdP2O8JAvEieGuGi7KOSEtZU0OPRlMChtksfEWRjGLr3ARt/iA0nM31cNlF
 LDZibHxiXDuG5ZFui3f/ec7sf0xV+898CvGCzyBK54Qet52l5miSRYiChz1M1KOozhwVb6hp7
 PIn1iOcCx0Pv2D7/3w3mID6HTQ3FhjbfbZNVmOsec9D2FXuK2l08fVrNHasJA5rMapx1OL2O1
 zQUc6RKtJ6s69WvBgorjfJaPE0zBplx3Lq83Tq2Kckl046OpkFNYOSpUV/OxEPUeczPc1OC7Y
 Ac3HgIQpdjROJR6rbsIT9bMsRELcYraY1qzrzd4aLK82wJ4Rww/aQJhpCl50gN7bG3+cRkmL6
 jdevraep1TKKJW00BZ0PgFIVNJQjrApBwMATpYNG8MuwmuyOFUYy4ohNVn6MhJ4N/Qc7G1sCH
 wsIB4NJXq6DMfTxuG6DGJM0m2xIyOu9YUJAY0n0+Hpn2GqWNbvLTy6FpsXgWUiLQpUXomBn5o
 m3l8Io/8lf0aTNverqpdc1Mfxgq5o1/wRNiwb4psukjZfjgZNUisFo8W4HiI/T6qQYUJ5Zvpz
 f+5PSIEZ5MzekVY93cJL7KHwQi4CYV1VO2KsoCTiSCvPLA7UfrXmW4/G8DT8YrhHWKo58IStn
 I5NdluVDdUaP1EDiLBrZ8erpM3XY45XKooCBhxtuch20w2TCgkKz2GY8iixx5MCuX2SvFIn23
 lHygIgldDgSk3gAw8h2Vvdjb6G9b86Y191HIZ6cTxO6nw9lkWFhQNAkNeMayGWV9qlI+dkG8g
 RKHG9i0P7eJOqTsiXjLRUQAHsQWbMZg21B5CgpLLsX5d/B4sH0nSQZyhO+5aAu7W1G2synEdp
 1VEO8HZNQfyXMrkaXxDhmktrDTrlig+THABU0d6K6tetljHmVkslMTIVA3xEUFUGCSs7z6SZy
 Iy9oxrXemmyXGPbwXgkaj860ZV5yJE8xpUsgWbNbExWW+/J/dEONYvLZ7+AuyQNuN06ou9IDh
 Ik14j5sAuapzKu/CVXPlOpfhprD1ZQ06RAkyQBwH/g062fB57z+LhqG5Mn4P7Drb6PrqNnHVn
 6PuT1kFpI2D0//sTTv/jbFChaf8FR0qIxDtWP4ftD4Fa84kSaGUPladHH9q1STElhVy58VoZQ
 jXkMkikqYaxRI0E5KJiG9GOylVaWolKMcKHkn6Xw4GwnLApyv/pUCIRVBKL0OSjQyjj8QWdEJ
 DcHn4jmNLpcy4FpObLyhvRtJRpe163NGYbadLTZYCnjXskCkL5EC/Dmi6ILoCOEUU3cvWq4ov
 KP0Ft482zy40M3Jrol3gm3II0lYB9AgWV6y+XIrskwqf0mC6F3Wo3YCdtl2qFw8P+zYrzp3Kd
 Z1X2D8TQTz0Fs3wrnbZFOCi2gR4yzaJ0fsz0tRWTlEtY+lH4Y6KJzfvkscg3KywYDQtNqIFAR
 ByrLvFgxYtiQhbxMuf7a20fzMkPCFIwxrqLg8BoHJ2LetMWezJD5PraY2Pd5ygTmNag7sAuir
 5C1BIPRdevvl52psKtFgDfZnROQ9xGcCgyZPA59Ugyr20o4Oze87PVSownaprEdolghJX5SOv
 CvwM6wNvxx3fq5y1oXERHzxi8c9pUFAc9P3q68A5B7mCYXEvns73BHmlD6nn9rGvivNngbGFP
 vFED+p44W+prRtcR31GDrjV8yl93g8KKsLj5/SFp5s/cXMUTwV4dALHGFxWCZpN8CUgEQqlSq
 51fhZRRdB2H70PHqbOIhWf8xtq+FT7by1kY27ukbC4RVceHimeqbW4injyC0QdDuXRZYe1Ey6
 Kq7vTLq7WtOGMAk/yETmBbxQRdiok1c9oZO13vhTFnPePtskmYTTNntvAankCLYE20hHWDe2k
 ck2hnuOQAEsGScGSb+gGTPNcF/XLs95qcFMPWneyp7AMZloX8xnsK61Ry6Ff+hKMYVaLh02O2
 mNf8S6QFl3BYaznxKOOfXbaoaCsMfOPO41og3o7Oqe1Rn849sJF9SlwCp5eP0hok2mG0eCWCv
 f/mZcHeu4N5kHMmgX3cLCqEhiaQj3ZnwL2Oif6bSry/tlsHAyVPaWCK8xJH4crYg4DIcUEO/V
 O0P2Ly+XbOWtVMsy3zVdzOl8du0jCbBs5g9f4nUyVssxcU4TeRRsIX2BftJnwLseYaBoetpNE
 IYRtgeK7jpiz3fwxbQpVenmUyqrR/IKMYbM/0ZJQFTnHf8NXP/pm6H272LLH4lkfgj+EHjx9n
 7W3Ockc9cSLPkBP5xu7E1fNtD/CncV9cGWKs41ph94P81o+76ZnS6J4aZzAc+2b2x7TIE0kwn
 NO+zzkKQkimEw07vYsAXeojO2lry0d+VIhWF2FtNbBsRGhqXsfRSgQ5exuFDw7sO5emC90r1p
 7AmBEpyI76QD6S5lwxSMPOKOCWUPjlXEmIKesp9BzyJk76y8pdzJkmZMfI++Ba3TQT6gqciUN
 0O9fioW7cr8/YTv7gSOuIR1BbpD7MyfWI4gulHYyniJIKYu79cw3+iUyAqhdHCo32HsQgStR6
 RBHYrtIa8vX7EpZdwNeQ4u56D5Xkl/3xYRe4B1ku4kYfegZkjrCfFIa4tJe0Fb+wpGLwraqzI
 /M57T7KYN0BwiYEhQiccldcfOZNe9YaNmxJf/pXcLkQ5vmtN3PWu3D+KUOwEXivLVFmYffSq+
 JTQAsv8LojKBVNzlwCwEVUtmcGyDdm4xvrrLNxPEdsJyc0ACrm1P+Hkg9e1Vbz64I+uOBiFHP
 np152hil6R1019qo/ADLcI+QIGw8RKU/ukJR8H31lBKpuRxfGJr232JpKj1tAoJ5iokc9bMVR
 EB+hTQJGBCObtDRxQk0at+7gZoW0lY/0pgShor9GeO/SHf0DfS9gfIRHiNwwpcZM+YMJ465P5
 gVQoyQW04wLGxCt2WUU4nelzMQyeKnfA/+l4r55xqrgmx5feFcoa8zbTueip1Dssf6cicYQC+
 S0SsV8adGQtakmtpJ4sPGchC7DAxo4uSO1oAyJ0YNIEGs5BKP9DLMlGT8srHniLRVRsgFIbYw
 8yUIswnSAq6Ytt0yXxOZhFnAODBeMUb9W8JttY3SrIZ/3+fHd4P4o/R7H3artSF6MO45jrlfm
 yidB1EL9woAr8CfxWOmFIZ9VkilhknMfTa+zkEM8Ah5+eWw5te9Tnk45YtOCjf+buVyUvRuUc
 NSuzwJJEo4cQKvP5ABduHLMwt83OnRA+TGu/6FvD1H8p3WUVR5sDqK4c89Gyc4WA479IGHXLO
 acso23x8PV1OAxfl03nPhJDhm4FMBqFUvsvGaiWXkNa5e1T9VvTXnU4hWrozBetr1HCVFG3x1
 dAakWeM+kMAZpCxuymgHNKfEcSA4EIfoL01CHo5JoC2MxrHSZ9JbvFc8tk7wqjTTgrC4nKjcn
 50ARKLf+5PEuE/qjBoZmpkCu3Uaydokhm1LED6qcwz7Nu6MxUx5+jEqKkrKDhgsEPfzUjMMLp
 S6T2Sn7Nu2TV1OLz64uq9YGeltC9EomUHkf+58Bwy5mJejqWzHvsvawPeS/4Q+lgIvKZ8duLI
 OLpGfOrb222hNn/AoBnMLdU85OoOZi41TzNpu7lz6QZHpxhEV8dCF53TDvNK9ETiGVfCng1B2
 0dt/iY3LLj/QbIQst+7gkmCJny3mnsE9LG2Zju/+azOCwSVFVCZkapQ/D2V/58ihiCGakjBHo
 BZgqnlpFKLKdr7wQUHn20xL1S79rnY/TJ5iUS2wtrVDSevQKvyrCogimpqwtEcL3lK801G0aO
 HYKK30r34Dw+6fr0rvOAfANohEi/m4+RwporUGjA2JROkioB6Arlo7tF7Ar56hsbhaqn2L6lL
 8aQBv4hEhWdL2je14GTd6/2gFIY66vWxYiJARauPzcZuD4W/TcUOoABrZir/AoUHIV5Cz7ypu
 dBHptid0+3v9QvV2mfmRp0CpN05ixma9dAriM6Idsrrso38+7l57AjzgMonpA329DJmXMQtST
 hb6cpxRuwgBy03Oz6Pc9HNKr7JVe4ZX1/03NNqg/PSEWEDroKFftGKVDscnB1DszsqVw97c4n
 EtspsUG1xzjiqSXmZi5/xcq7jSma/NkYjCKpa1PzdbebWz86kS7HIVoIr4v2hE7yfFmpuBnIO
 T4xefaBlNW5ji4Q7rhyV81XuvA==

On 10/5/26 10:32 PM, Matthew E. Luallen wrote:
>=20
> - Reader example: Python 3.14.7's ZipInfo.date_time reports 2100 for
>   the 1972 ZIP despite its correct Unix timestamp.

Makes sense.  Its source code,
https://github.com/python/cpython/blob/3.14/Lib/zipfile/__init__.py,
contains a decode function for two extra fields, Zip64 (0x0001) and
Info-ZIP Unicode Path (0x7075), but no support for UNIX (0x000d).
And why should it?

> - Separate consequence: the 2106-to-1970 wrap caused UnZip update mode
>   to retain different existing 2025 content. The 2038 control updated
>   correctly. No deployed security bypass has been demonstrated.

I'm not aware of a ZIP extension that allows storing arbitrary dates.
I see three options:

- Don't color outside the lines, only emit ZIP files with valid DOS
  and UNIX timestamps and refuse to write earlier or later ones,

- wrap consistently, which can be confusing, but allows users to
  recover the original timestamp when they supply the higher bits
  (like we can say twenties now to mean 202x and 30 years ago we
  meant 192x), or

- map all earlier timestamps to the epoch and later ones to the maximum
  value, effectively stopping time at the borders -- all mtimes will be
  0xffffffff forever after that point is crossed, making them useless,
  except as a marker that a yet to be invented extension needs to be
  consulted to get the real mtime value.

> - Fix direction: would you prefer clamping or rejecting ZIP timestamps
>   beyond the Unix field's range? Our candidate rejects them. Would
>   rejecting negative dates in strict raw import be a useful first step?

Rejecting non-representable timestamps when creating ZIP files seems
like the most honest option.  Perhaps it's annoying enough to motivate
people to find a proper solution?  Which could be "use the tar format".

It would be nice if there was an example to follow.  Info-ZIP zip(1)
clamping at the low end and rolling over at the high end seems odd,
though.

Rejecting negative timestamps on fast-import or at all seems bad for
people who want to import ancient records.  Git commit objects store
timestamps as decimal numeric strings, so they can support arbitrarily
high and low values.  Importing mainframe file versions from the
sixties or versions of legal documents from the last few hundred years
don't seem too outlandish.

timestamp_t, Git's in-memory representation, is unsigned for
historical reasons, but that is not necessarily fixed in stone.

Ren=C3=A9

