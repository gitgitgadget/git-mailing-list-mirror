Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 195B729A33E
	for <git@vger.kernel.org>; Tue, 16 Sep 2025 21:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758059510; cv=none; b=bJuZbiiebo+Z5i8rNUAKA4QcPFXpDTmHB2ZHQ2YRP6plk0+RxCaugpTaFpBgE7nQOo0A2E2xuZKLyeCRJbA8Q/GcTZTuJhQJShx8Ur1JZjbIzeRxe2gOjW8MRJvPwFyAm2bZuG/cFmiG8Fp7XY4j2WONjq4tcOadEOBz/Y06uOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758059510; c=relaxed/simple;
	bh=ToCByRltUkVhj3CDiKKrO9p4aMPxBgRsP1TPWcFnARU=;
	h=Message-ID:Date:MIME-Version:Subject:References:To:From:
	 In-Reply-To:Content-Type; b=WoUp3A8GH/ZKIHs5lZjvN5ulJYBH4D5cek5okmlOlYCZhSSnSFv3kHEPD1pd1QMs7naJVwf7mTyM4+CG2K2ms/dqf65yhAetWBcXmYbvrPsS0BPmmnYlhOnJ/YEQf+CKKI/T15rEmjm70UOT/Gk+kPJLVwKaNZMIPdHIwujFXcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=anselmschueler.com; spf=pass smtp.mailfrom=anselmschueler.com; arc=none smtp.client-ip=217.72.192.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=anselmschueler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=anselmschueler.com
Received: from [192.168.178.32] ([94.139.29.72]) by mrelayeu.kundenserver.de
 (mreue109 [213.165.67.113]) with ESMTPSA (Nemesis) id
 1MfHIb-1uRkPS3WDD-00pwg2 for <git@vger.kernel.org>; Tue, 16 Sep 2025 23:51:45
 +0200
Message-ID: <c28bff47-04ef-4568-8dc3-add99f52209a@anselmschueler.com>
Date: Tue, 16 Sep 2025 23:51:45 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Fwd: Why does git-status suggest different commands to unstage files
 depending on whether there is a commit yet or not?
Content-Language: en-US, de-DE
References: <8e1905c7-7744-444f-9a39-ca809edb6896@anselmschueler.com>
To: git@vger.kernel.org
From: =?UTF-8?Q?Anselm_Sch=C3=BCler?= <mail@anselmschueler.com>
Autocrypt: addr=mail@anselmschueler.com; keydata=
 xjMEZMK/6hYJKwYBBAHaRw8BAQdANvIiy7BrQ5bJ2txC1J4PpfkLnOrEhmG9DzItTcFrd2XN
 KUFuc2VsbSBTY2jDvGxlciA8bWFpbEBhbnNlbG1zY2h1ZWxlci5jb20+wo4EExYKADYWIQTN
 v+yoNv7jQBzrWP+6NO4aujoJVQUCZMK/6gIbAwQLCQgHBBUKCQgFFgIDAQACHgUCF4AACgkQ
 ujTuGro6CVWjHwEAugikc3PIHCDCaZPrdSiXqV3mSabICGPMje+Kp73oxkoBAJYeHUdoZcyw
 BkmGIh1mWY738FN+SPHwSWIS9jtJ2+4CzjgEZMK/6hIKKwYBBAGXVQEFAQEHQE6vKA4qvkMc
 6kslzFWzHQ+h9Qk89ggfrexKhse5F6NjAwEIB8J4BBgWCgAgFiEEzb/sqDb+40Ac61j/ujTu
 Gro6CVUFAmTCv+oCGwwACgkQujTuGro6CVUKawD/SDvfSz7vUSUkNiJJsK59U+D7rBkdRHoq
 sNsLc3EVYiEA/3kNw77KZvEG2Jb3ktvv5qoWKnW+xrEHh0FZLFzb50sM
In-Reply-To: <8e1905c7-7744-444f-9a39-ca809edb6896@anselmschueler.com>
X-Forwarded-Message-Id: <8e1905c7-7744-444f-9a39-ca809edb6896@anselmschueler.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:dEhEQW70/BOaacX1rNZqCzOV5p2Ie5wx3VOcpzi92aJk29cm0BZ
 t3SnoBBGKTSsmVYGvIJpNlPYLUy5uT1kaXtExn3YxtMzMUWzrEu7RZCwQa6QOHLIbY7Pzh8
 QfuET0YBDZZ5Lo37C2P5VkTny+OW6zwZ7sfwDMY0QmBILQxDqN4BHINvrnqWkykuEJYImTf
 EMln3sc7hRfsPufwyveAQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:BVTPwF1EJxU=;QVkDm1W8KZ09ffZMzZBF6z+KbBD
 0MFUyatlK8itxjnZxxYKTClRd8syYbP4gB3ajqOu6SIWamUdK2owlK33o2ehUCBNIE1BBuyjv
 7XuFoTj9nFqd4QtTw6bBSYX1d0VEudpbsA++Os7SV12PJN9jZbViRVmPVEAv9EBk7vc/dW1HO
 D9KMLwuY1/KsM77QGfhTsPoF3q4bwqBY/7R9Sgp+9X7BglBJ8tsFQxaHvUMEGmk8ZhnDm90p7
 FxT8EpiAX3K9dXop2zdGlhvaipYB69OUHSyLBQtI3BGRxfbpWlv/Rbwpw+IXZhQBYVkG+33T1
 bDf4ZENaY2tfMUF5qCvVtoMLFAbv9mBtjJfunqZ4NJLj2cABgqQi3qXOQIDrjaW4CDNFigZus
 aFTa3BAsvl7gea4a1snMD4bM5CvE3mGwBF/qro0mnYFKbgKJh7NujfFGaGp2m8rh3p33pzATz
 PU4RvA9tG3HAkxAaYqqD+iq+FPmog3BGJiECLwo8SioBOLkjLpVAl6wmR08rVXbos4LYHhUDj
 oqh+AEaD/Pguob+y92SUP1F9GRZSJmddIfmGS66hQA19TheE0sLh07E9T13JdkDKTHtxvmFoh
 5Rzf291r7p2PzuY04zuyVPTb9KwfroQsvQUX4leJl6tjRsXM8g2tdXlsGocMq4guoNaCI4S/d
 X43Z2F6fAdI97N8VC8NhJhipo2HhBfM8vGNV/xPIMY8zqfxgSZgW1pFWwYR6oy2pEsVUXJbxY
 qM2v4ijtJtJb9ordga52dNAPkD1nuc468ZgBFQU4uFaG8L3mIGX+SYeuoIPs2EE2RjwOqk/Vw
 9OgE3zHqzPzl1s5XbFOGg6A/9Ouy00d3hsI+K6r8b+y6BryzvZWHBZnRF1Vm5sJ14n57N+8jF
 MqJTOuAtLZLKPIsejF5ywFLh5yutceNy238HZM9pZr+0yhpUMAyu9EP4RXc4ppe4UegQ8lBXp
 9YMsXK7jghRf/xzbhFVHmdmFRoKV3YSvdz7jcdtTFna/mNjqEeHrzWYv8Zle9EZj3iNc/mSvb
 QsqcuJorns1v5g0NKLRqb/nhytW3oEoJwS7J+WDPSSc4ocmQrekVAWOQhbWtfIqbVTKigmoCF
 69KK7k5tgV/G+d3babm7xqmRQALW4KqmUtVYb1vANBT4E0thxIJ9LbLxMbuU6QLMZ5cRELq/Z
 08f/br0spDD8Q8Wkr2vIjNmQDeQaOFGHx41hIkeStUludx4wvFxEc4oFfTplc+wn3EpO7Ee/K
 UJK3chD/YGXpSDY+E03s+cNRBXlbbbq2jW9D7mcSw7ZdlzD5u9t4CEtXVKZGoTNxoPz4Sn/yW
 W1Mga+iXMM/GQYJl2KpCagzq8DGq0Pc+kr74XIeIHtR6vyzsmtJ7ch+xk6+hkQW9c7NleYpfG
 w9O5HgrCH+OAhNx1zOI/qau8RWCtjBxx2mO7c7R4vuFf4iKj0g73nB4JIXqx16Myt7XOMX51M
 MVD8UJ/fXkyfM78ff2dnr8melQ2QIZbBe6SGWYNtvKMlhhl73++HUXbsXa37mzH5aFT8dVQjF
 Le0My4/VQ5jGK0Myb9ceBzQqYD46FkOfvr/F0ljYgcrSn/kmlIMXKOMQVpQ+yHJZm07Qdgo3v
 23PcnnXsXQ56pOqO0ElifH0q4qvvoFnynhSyPN/iryTD3ReTKvpZv8nwF2ZxurEsPdjPXMEvD
 VnP8efQuC1v9HzZls/tiClharNMtpU7/7OcOlikNbszatgclFZwEc2HRoQP+PWqgEsxA+kiYG
 OSIHZjqmhyKcC

forgot to Reply All 💀



-------- Forwarded Message --------
Subject: 	Re: Why does git-status suggest different commands to unstage 
files depending on whether there is a commit yet or not?
Date: 	Tue, 16 Sep 2025 22:56:52 +0200
From: 	Anselm Schüler <mail@anselmschueler.com>
To: 	Junio C Hamano <gitster@pobox.com>



That makes sense, thank you.

I suppose this isn’t that interesting, but I find this unintuitive. If 
it were not for the suggestion in git-status on an empty repository, I 
would’ve assumed git-rm simply removes the file and “writes” that 
removal to the staged changes. This seems to be what y’all are 
describing. But with that suggestion, I was confused, because I assumed 
git-rm there would be equivalent in some sense to git-restore in a 
repository with commits.

Could git-restore be made to work anyway, by “imagining” a 
pre-initial-commit commit that has absolutely nothing in it?

On 16/09/2025 22:48, Junio C Hamano wrote:
> Anselm Schüler <mail@anselmschueler.com> writes:
>
>> $ git status
>> [...]
>> No commits yet
>>
>> Changes to be committed:
>> (use "git rm --cached <file>..." to unstage)
>> [...]
> As this is a very initial commit, any file you are including would
> only exist in the index and in the working tree files. The index is
> where you prepare the contents of the commit you are going to
> create, and "git rm --cached <file>" is the way to remove <file>
> from there without losing or clobbering the <file> in the working
> tree. As you do not have a commit yet, you wouldn't have anywhere
> to "restore" from, would you?
>
>> After a commit has been made, git-status suggests using git-restore 
>> instead:
>>
>> $ git status
>> [...]
>> Changes to be committed:
>> (use "git restore --staged <file>..." to unstage)
>> [...]
> Compared to the previous situation, you do have a commit, so you can
> restore to the version in that commit. During the course of
> development that led you to this state, you may have added <file> in
> a commit way before the current commit, and you may have made
> changes to the <file> multiple times in different commits before the
> current commit. "git rm --cached <file>" would not be how you would
> go back to the version in the current commit in such a situation, as
> it would take you to the state _before_ you originally added that
> file. You would "restore" the contents in the index to that of the
> current commit (i.e. HEAD) to go back to the state.
>
> So, isn't a short answer to the "why" question, "because that is
> what you need to do", I guess?
