Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CAE91DA2C
	for <git@vger.kernel.org>; Tue, 16 Jan 2024 22:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.126.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705442403; cv=none; b=bulj4rKzpMEuN7++SWJmdMKR9dWT/T+blJvTpEBGXqTjGB1UuEZznPwwiZtB2LeiWhQvyNyvZyNpJ4vD+9QB/Jjt18iLcVelvv+ebKr05h5VB7rAy/4Joo08zSP70G1jRZ6lTrT/NwFb3Bq2za47mD6jNXz6SpRPCkBrGp4OLYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705442403; c=relaxed/simple;
	bh=9KFDNor4XMhxb5fnhV/C7SD3keNezponoWvL2LN/7kk=;
	h=Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 Content-Language:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Provags-ID:X-Spam-Flag:
	 UI-OutboundReport; b=TZVjFsRiXQMU4rbKvYDdaPJT8Wq4/2s5uJeOAJUcGJNCyLJPKW0/XygqCw+/h2MiRfXwfadqDZA0gTRK17ScVCoRnAbTiXyiHEcF3IkKMVsUMFWywzZTF2YGV4I8sEgTT2l8/0qd7P6sC2q9awtUlnvur1cHs0W7dJk1O5B7IRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=delpeuch.eu; spf=pass smtp.mailfrom=delpeuch.eu; arc=none smtp.client-ip=212.227.126.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=delpeuch.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=delpeuch.eu
Received: from [192.168.100.48] ([84.184.16.59]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MhWx1-1qudaK1NgJ-00egfU; Tue, 16 Jan 2024 22:59:55 +0100
Message-ID: <4e6dddd1-2149-403b-82ed-b822c4b0c31e@delpeuch.eu>
Date: Tue, 16 Jan 2024 22:59:53 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Custom merge drivers: accessing the pathnames and revisions of
 the files being merged
Content-Language: en-US
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
References: <8bb5e41e-4db9-4527-8492-3aca6a0f40bf@delpeuch.eu>
 <xmqqedeh1816.fsf@gitster.g>
From: Antonin Delpeuch <antonin@delpeuch.eu>
In-Reply-To: <xmqqedeh1816.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:5majegYvKMAVaXeBerE+S/MNVUPNSHs2ftnYT/SwKLLZBKljQdB
 YLAgWGXUw4H23GJsluaT2GReqmpFKSQBs/h/yK25sHAIy2nXF00nydrLNT4RKke8N8eLhfi
 y+JT2nnjFzDaZzjEHuFZOVp1I5EHp241eJ73lxtgZBap4hyz4sH2iMbZKwkD3RnQGwq/xW6
 froqnTaCDs2dxELL+ON3g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:VN/qSk+pqWw=;VjK3tgt1uP6fRjbD0wyaDgwgqKi
 0lAtI1q2cxHOaMrZV6GyB7vyoIXy12Sse0s9cffdorgH4JCsG0vq7sAwHEiJgomhXEjoOlB3E
 xeZ5/b+27JquJ3mR1ax5FDDo8rVdyh8VS3sLzJHJcsocjTf/IimPCpcIPqMND39I43nkNk/0X
 7Uur2r9vUzgXQL10XXbV4PH+ccZ2S7UqSz+CyYt4xs1223pEV+4rGkQYN53jfFFCMvwsIvRDA
 uXY24p+bzrdDxEmkpmqSFXrM1mZzn5EW8Y8OE0fUIOuc2tCFJXPmRAl1SHS/nbpCW7dmI53GL
 gaz0ITuoQGgJNzWEAAzJHoz18ZjBiPPAOVlxgkZRfHgcHUTC2VJC7YD+G6lGbK7Q+1prppKQ4
 ufJOj8ISAkSjq+PXgmg/TCkODMVZat24ky5EYvlSriUbTS6tXIL1Vyv+66PSWi13iBYlRFPcu
 nVcz28QSQVGOlPxcCD7TvAAAJqYjf6ESn6RoG3NiuE/UjSGhsRNLQlxtZhBI11B4Uu9jMKM2Q
 tmYQzDzB1AU/ehUMMDEGHLolsyp1WyJDzUsMWL0wxx2jltNOlFu0fAreH2GlVPsLkxVVoLNvW
 KTuoe7QwYKwX9pNHlzn66Y8zhTilZu2/QTwTtpH1BYfCY/tJQm/UOtPD/dDpn3/rYSa6jQHhf
 gTTW1mE59hL8xNNCXBlmlBkwpO4XOUq6yXzIB5xDTDMlMHzgBmglcgwEqALzgEVgS87gvd8uF
 nRyI2KEgMH831vArZCpW0gyaEJ6kA/sLTlAQy+L18AFqvoSyIz1C0zHbOqHDsbxwya33cCVUl
 P2kmxK79NfuFtWi+pDx9ZzCCXj6tI9xaChbcu6YVOBgyLeuYyXBRmtQBYj4tTQzYZXkVSBhFF
 oHEEvaCpx5mevVQ==

Thanks a lot for your insights! Yes I also very much appreciate that the 
extension point is built in such a way that introducing new parameters 
is non-breaking.

On 16/01/2024 18:51, Junio C Hamano wrote:
>   * Whatever letters we choose, they must have mnemonic value that
>     signals two of them are the both sides of the merge that are
>     equal participants, and the other one is the old-file, their
>     common ancestor that plays quite a different from these two in
>     the merge.  I cannot tell which one of the XYZ would be the more
>     special than other two, which is the primary reason why I do not
>     know if XYZ is a good idea.

That makes perfect sense. How about:

- %S for the "source" pathname (corresponding to the %O file)

- %X for the first side of the merge (corresponding to the %A file)

- %Y for the second side of the merge (corresponding to the %B file)

Anyway, I'll try to work on a patch: it should be easy to adapt the 
letters to any other choice.

Best,

Antonin

