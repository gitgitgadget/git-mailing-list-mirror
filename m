Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0F7123E330
	for <git@vger.kernel.org>; Sun, 15 Feb 2026 18:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771180972; cv=none; b=T5fXe7pbBR29C6uTROcc2xbJ4/bEdadbX7C2715h5qs019S5Ih+ODv5eooYaW2ig0sUCBzDZX8HiHM/hZalJbUc8zUi1Y0uMbIf6fyY6KA5m/UspBntd4A0XT6fqf71O59nbgiLtR/p+jqi9A4dL0Qwd7K8cn72USie7x8hD7GQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771180972; c=relaxed/simple;
	bh=D/hnW5sxuTV6BoEvjTJ2lSiLj+kKdRSRWZ5lrBjrlqU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sUCxVv/bk+6m01EU3g173cxy7xdUAFvkwLOQIlGs6s9fu7S0XAnW0lF8oDlS292M41hAHJqXnOEH80MOvJEy4JizKlvsvT1Iv4NFfrRydn7Hmv1jZ8xTAIlf5TF8lCPkSrndqxFX7XxMV6afSOHzd8A/ZSvflygPSU+fikc7Sn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=wo2s/vX9; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="wo2s/vX9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1771180962; x=1771785762; i=l.s.r@web.de;
	bh=idNsb6Twi25MMKLd2MG0qzI3LYDaWhf6/bjZnQU/k4s=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=wo2s/vX9pboUN5tRNAqwFHrTv5I+LTDe2kKeJ0b6kAcbHWK+vbQrF/LvxaCEbg+8
	 cP40MNW0gWX0G0hfCvoWadePTs0pZ2WvF+NScyzAZIM/zwL/+GiTHWY591tfmMYZj
	 fUxXMOlK97KjogdLrxKoNwX+BgvP33HC0IXCd3m/y7/Tw2uEAKl7XumfNhSSnfd4q
	 s74qE99jx+V3cQ4woAAhNlFI98F+Qal1NieZTNesTdiorMz7hDVhmqZA9+bOfy+yT
	 iFObFldpo4kNlUsIvksKmv2cwLJEdcutXHrmMhKUFL+nPTEaf/hGsA3EaERTZZjKR
	 X+rVl6Q8gBLEMklhEw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.2.31] ([79.203.22.157]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MRF3W-1w636c2wlQ-00X3Dv; Sun, 15
 Feb 2026 19:42:42 +0100
Message-ID: <97e0fa77-0946-4898-b721-5f1a5d1153bd@web.de>
Date: Sun, 15 Feb 2026 19:42:42 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] xdiff-interface: stop using the_repository
To: Elijah Newren <newren@gmail.com>
Cc: Git List <git@vger.kernel.org>
References: <f58fa33d-b015-4339-819a-9d91be60cd0c@web.de>
 <CABPp-BFuwvqiCTCCpoyT6em9_1-qrgPWHWhrufQ3UuZ+Kfkb6A@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <CABPp-BFuwvqiCTCCpoyT6em9_1-qrgPWHWhrufQ3UuZ+Kfkb6A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:eSQG+YDNLgHoHO/Vx5uzIvWRkj4GrhQfc4k2nzQmDlexn/pEF4a
 sIsHq21JCEIkXzKMXZE60V7Upg8SXS7SCBzA3w56/YZtyalnWtn1G8HggkSb6p2yaRI+3ri
 KcMmKvU00vi1Z8qdEAheEuRJsFKYiKRlvB+3kIMTRnFVsZC361P2+gDvTAWCPmgI8xpNHMe
 C5PAitira++yfFpHsvkKw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:MTA4ZNpci40=;QudRFD3wjtnfEuVPH2gbdwsovIY
 Kz35SOjlLL3d7ZMacjBdalMS/NrwjF4MckNF+KOko5BUb0X1ZxArpAYnYBjYagXActGJ7wyxi
 zaKCEtZwkBJ5/VOShZI9y8w3jlwt0f01iVTwcEmISqQfnWNdvsvtS148TPWLKAmxLxDO2m44P
 ihAKoBPFzA1Q9DRlSOMST7FXa30dV9kU+ngzVWrvI9Pp2juLUY2F5EGdDqpVDxKXaSa5TJDbP
 cWOdzi5Vn7qWKclneQ4zh3ExKDeYtbRGLcCqWqPT0NJLdIRHvubZLSkzwxYPoXjVGb/o1o99N
 VOd74XEyY62Pkp6WTfEZk0hiS2j2Rsw9+1d4EMie0DrHEITVEgSF1QMgvF4xVNJGTfRVjcGMf
 jLYv4azJOKIZVdf0Y4SfV3dlcUvg0nyl+1QG8rUjNeYF0ap1yGFCu0SrNd5spWyu2ccaQaeg5
 dTUsFNCB38n682KBGij/u2aKZCYF+ZcnjbWUEof6wbHNPyAfg7nSBkEB1VBKRFX2+SZUYFdBn
 6r8rkuDg+BH+V0WZ4u9emOSzKqX3tlKarXFhFsq2KkrNmaDs0IaEBRt5B71cjDgW0OPYfyCjK
 ooZWVkb9+fhEkvTbcaFNi0wPX8F2Zfi+S2wWwj2KN864xFXEfDuomvWbRbuFg4qpfZSSv+0uZ
 mZwtqBXBqmU/wtPvLzsnjBVLqbEF3mFCfbATTYaTWustqySml78YTf4QE4qLa4hBVjudXLIos
 8eYIerHIxPeRFWXhN4OL8zGVeGWMeQNQx1WoA98DC1o0FmZfTmi6IRfvmH1KNYtDJXNwMjOpw
 p8OcKGzqcZFTxBBv+7Adgk4lCHkpZmRT8aOq/k44KalXi1jJKHF9qoUeYLtURayhV4qf7C4pN
 FZL/qh4u9dDpKYSvlqFsew2iVa1WieJbDVDXchfnUyl8uXpSm+HibynzZG0nKgUmmRRRfIyPf
 Cgvw8/3ooDYC5sb0ekGxc+dkeRw1JZlMxd38wUd6/f53hKdNf97WEg16AwR/gbpiIciQJ8wyg
 yksVdLsqMrmDg2cX96Ba4YB9DalME8hhHLSD0EPgDaODfpIQGYSWGZY44lBMF5m7V8cZ7W4pL
 Bm0Qu4+T07WYuoAWqr5MQ6WKizEeovjLjVVvnFV2ok4j2JIyRcmCJXNnuohaQkZEwhflrc+8t
 Rqa+Y+XIwg3SY3+TpC9AVQJPopA8MRyv5YUSelodPN8KXAC9nzUVbWMMY7aI5B5iHNs/bGjok
 +xlGzIN/WtI2ez+IHZ6493Xy/dT/Icjggo7YDGlphXV/6xlfUOQpvU4YhFQwkwnWk7qgWzDkV
 iyzYWfEsLCjw7vWJQooqylMRrkdV1/x1CQzOkkrduwHFqSOld4P2Yocva6rj5bUTL7YjUevyl
 xuz0aWkm4miltZINUDpYcPOKVhdcGTMTW6SkMzupscbrBzGFWjN68v6xA4gCNVIN4QigOBmU3
 TaTE2m3CL547ValcS0z7FByd4xfBVU4RAz/MyvmvVt+2rulSB1HKsWoBUgc57pvkqCD120zVi
 glmyW7O81wpGSVICRh7sV5Nvy+dacs67TLlbi+/zYpj6unyPvdYiE8R/uXneWYcBSp0Q6C367
 g6YQgdB/Zd8d+QfFkGMGl0jwc67VeV1hQFFYIKLwW/TFrU+O2MMLJipt8fN//QeTEl9hg5CRZ
 nlCZR5Uc+KL78/9u0PIFANL/3wxY3WwPaopKbrEv3KbpwNCLoFOSfHlMG6IHDD3kJtSPXMHVl
 cAl5NylHTibLLvBjSI+76+7eIn7miBuei+z93dSZwLaMY9+jXrlJ+5aez6q7kcW/hivoxXATS
 8+K3mYzjw4nmcvrpClAYKeahfMY295b3dbyML2TtE3jpmNfnB6xugMR6M7p8ToELU++vIhKJw
 WBPVwO3/9Wa6aHEZriRu8CoUjVAcQc7ofgwfyBQittxR6qKfHhFoghIxM5IRlQojTFBYLGRWB
 6YnKMt/XeU8FcdoSrrK+w/KfR8FK/BrZXtIfrw/r+k7ornFbR054ul6eC0c8actgyhQMZB8wH
 MZiekQZkqKf0GpHSKb1T/bO47XFz8AeuCNUWOWCP0tWf3IvnFk8SU38AOHsr+Ru1pR+ZBWnf6
 8SA++LaOzIbcmjckUVpuE/w6TAY8z+mvEzh3Np+L+YF9Qtk2j5EgEzNH22WA4szRik9IHa1AY
 UCp6Pe/gKbp25RNUt0OEixqeNCxmUxPvW+tu1zBJ1uFwe0WrVk65oNerv9NkHOiLlhfFCCcKu
 /6aSUtT6GtuE5AwV69/TGTbt78lLo3tXDdWtgUg5tMgcWjwceYDuCn67qkoXr7uzPGTREldaT
 QfGrRWE8S2FSTkJoVfLeigL9I6QflDGD2NsiNEwQd6OiGNeiu/XKCYX+KMgLe4k+mD9xSjyMG
 iUsw/i503033VQkh0m6MK55cCfuhqKjnqwHVrEC1rDoNDPbxYkHGdY4oG/0GXRbxYk/5gUKb6
 JT8wF5j69WK04oZ5uCyunH2uQ+Jz+raAOgomYeFUQiTWpHW5aSNrXAskgzpbbOaLXT28FjmJD
 XMlfSIX4bm53eFMomb55mV9aGyLIQ6hvdJ00EcR7yxUDVpCPlC5zfQWLtB+CKUqZV4/rt9/o5
 QXqwJa16JZQ5uoBGAzGeZRninP8YgE8nynpPZAEg4+QMipJZrKwNsJ7tFuFroYUu2S/TGTrsF
 7bJrr5mhm0gT5O9AtD43Ckt5Z+uYaIy67F44SG/hjW3NhrwfKksWzWlqDja+EboGzulw21Ltg
 /q1VQDhrgk3M7GZ5u9ZPzPlj3czvT3Q7shfPVT0sUH4SUlMsnS0sO9fI3LAz0iMTh+2CxQVm7
 byH/pH2aR6hgQ/KyMlyvEz5IRkIUApKNf1/hoTFbuHgdDCORKdwOl420gH5XzFXAJF8zvWSNG
 j01MGFx5hEWHgOBmhtAxUy2CBOeo91B2hiXh8p9E8FklZDFHF9knP+0vuKjoTOWzlPg8KxXQl
 xLTzisxQpB3Q2K6hHrj0jcu1utM/gJ2eCDZts4z3eFfpFhjCD0mBd2ecKcUEWyM99XQ0tgmUJ
 171i5WhfvWDXVF3Vp5ew1otWOm506gWOkP454cm8Hni0hlLDGqvy6KotVX4p2xsni3KToi0Rg
 nHHlaK93tZ6Mc0g5m8w8CHyMRDjpYE0nfyuTD5u59kHoYQU1EKSKfjIfb/jpO6kUgZLBM5Zow
 LPtFo7IK09gtWO0WNaVw/v4cHz+CK+0c+S8a4yxsdvvLgxUh7cx3SEhnxeRloD4YBBcCGpBLW
 z62nzAsjGGn+7PRvAPRRwjxENLnkzPaymQhNK/o2HaCJw6qd+fbwUtR+UXjs3VyPBQepuRjhH
 fT2j3v89pxH95wZKvW9xZpJY0gAGQx8zsUzhkdcxRfG9h3d0yROjljPADK67OYF0k+oamdYay
 wkEZACPwPFOX1UDbZYH9HrJZfmELTjGLI+c1Xa4tNPNNtJ9wrDg2flca9GDljvha+K9UoXxUR
 RPihXbBmbDvPBTiSsIugtMzHbi3euTeEvwWgJ41W6219bsSp2h5CPhJIvQo37NE3gNrwlTZ1D
 YF9rOd5PNwiqRZDxuo/bZbXFGiUqykaSgmM4i2o8FYsFvsgSsE3fASJ9h3hQ3GmSZ1Medsezo
 W3Vv3tbhS9q3P0IZ0mXkg93t9FoflfW5IaH8ZEFRaQ179Re5xSBj4f1ffLoulJsNdbI1twm9T
 QecFlUyOe/tO56zCClX13g5ckUTR4WdMyZC8PdkAXePcvB78GPHtlSeCQHJvZL4i+7EV1PKV9
 gobyhXcEeXyf09KA1RtvM7WIKJoVjUX5mVS1wqkOs3+TJbcdAkvy23WbUEUW+bR/oV0MdfUhg
 mE/OnluC+0S5NvjCxympof0ds+HkfARi/Yyv8DMA/qtxHALqB/Y3I//ZhjIX5f81qveF7J44w
 3W7L+lW8x/RgkArAPusgKq6kfu7eeaXZ3Y0mG7qK6D1H0lIn0/PWvDJOf19inNLCBGGD5yWIy
 9tLTa8zs6VZU6AF+gkae/6pKz3TakVZbTmu0hlcAXlHJZYVm1llxEy7yyih1ui/ME12v7JHGD
 Gug40UPfxtezDHpNX5WD3Mm7sXsta/9t/cDoV3zXRM8CnQrIwvFRQ0o2ixDNPZB52wHtupQg8
 bRPr8RQEiJ9EuC3gcSKOoPqlcVLNniVSizjcKdk4STOHuVoLgEcEHW03uz+OdzFVIOA1eohlb
 dsrVr8o4cc5Bya4bcXIgRf+nKai8cfsWSqP/yAVgbJ2VdgZJp+JGyoBVHp5j+LH7lRz4Vcb9a
 PrNb+ozBw3xlXeMcyCTpUsVUVgqi9PX4qjtqSvKDZQZfKiaAF8ZVm7YCey2bZxFz1AHEn0Etk
 SO4YnF+MhNxbcp7xXPrNcY3KZbokwgiFmAcRebT0VBDtWQa7KN+3rubgXlcVOBCJHjuPASxWW
 32CrIawM7//gmGbZuBpCH+mrw0PtcKceeaoqNXlHsg+K2iniMKO5Vm4FEBxLEm0XvWwZjKec2
 jc36R/4+Nt743trAE21CMFEa0Ng803IaTGYLQgTuJpp+Zzgvn/00k4kQ6CPlCMz16XD/rCA07
 VhwgkMRaSdwbwyd5Z2NDkStEtK5XGNt1pft7OsDqZLayzNlYOX9u5rqvU+WyjWMLlKnlDvEdj
 sNUmup97OhOvwtuJOnArCno0q49DLGZBJt+RvzAqlx7KTBPKf8FHBFz8vXmd0IfZaa+OtqC23
 ceXrdq9tmTAZPXlTYC397YAUoOYh29wAj1fIhWI8I753TCv4wFoe02zpN3KIT1P9xo6YZEnB+
 h1jM/UW9kncI98SFfSS2jFC3R/gkHqNpwKn/WeUmaMa1uPKcp4VSycvtnva9CEU0K7qmdAWST
 NKb7LnJ7oEhcf+TPB/YYtNZGJjauB09GMu1BnSosLCXdp02JurEW1gCHxaS+DnG6MdDDz9GBt
 Y0YqFrxQIOTELxns74+eLfVr1UuvNAldeZFADyuTHek67BjclZxJJPRwf2HTkWgdaNExhUI2d
 dwMuqDjRGQtgP8tjNkz8HrvEuLHr0Q4WaVHfaD5lMzuGvSUpiDVpytsI4Wg1LCSbwM4H5kaGs
 3AS+xyINBcvncnWiUI1OtVJDTmU9Zr3biJTOHHcorHOPKh+FNxgdP8nYPcgjiAbAzhkGKPd52
 5At4dAPIe06fhTXnbVxkFyJ90jvL72GBojFK8KzJfZ3LE+M5Xi+PtSHEThcg85K6YxQaNc17D
 DRFweQCc=

On 2/9/26 7:57 PM, Elijah Newren wrote:
> On Sun, Feb 8, 2026 at 5:47=E2=80=AFAM Ren=C3=A9 Scharfe <l.s.r@web.de> =
wrote:
>>
> ...
>> diff --git a/merge-ort.c b/merge-ort.c
>> index e80e4f735a..a4103d56ed 100644
>> --- a/merge-ort.c
>> +++ b/merge-ort.c
>> @@ -2136,9 +2136,9 @@ static int merge_3way(struct merge_options *opt,
>>                 name2 =3D mkpathdup("%s:%s", opt->branch2,  pathnames[2=
]);
>>         }
>>
>> -       read_mmblob(&orig, o);
>> -       read_mmblob(&src1, a);
>> -       read_mmblob(&src2, b);
>> +       read_mmblob(&orig, the_repository->objects, o);
>> +       read_mmblob(&src1, the_repository->objects, a);
>> +       read_mmblob(&src2, the_repository->objects, b);
>>
>>         merge_status =3D ll_merge(result_buf, path, &orig, base,
>>                                 &src1, name1, &src2, name2,
>=20
> A minor point, but could we use opt->repo instead of the_repository in
> merge-ort?
>=20
> I've cleaned out all the_repository references before, except one in
> prefetch_for_content_merges(), and would prefer folks not add more.

I can imagine that this whack-a-mole game is annoying.  The patch above
at least didn't actually add them, it just made them explicit.  Indirect
references may look better on the surface, but the functions that
contain them still can only be used with the_repository.

The only way I can see to avoid that pain would be to convert leaf
functions, only, i.e. those that reference the_repository and friends,
but don't call any other functions or macros that do.  This way a
transition to the_repository-free would be meaningful and permanent for
each function.

Converting on all levels of the call chain in parallel requires less
coordination and is probably more realistic in our distributed
development model, though.

Do you (anyone) know nice tools for listing the full call chain graph
of C functions?  cscope can probably be made to do that with some
scripting, but seems inefficient for that purpose.  Such a tool could
be used to check for indirect references and tell us if functions are
safe for use with other repositories.

Ren=C3=A9

