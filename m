Received: from aib29agh123.zrh1.oracleemaildelivery.com (aib29agh123.zrh1.oracleemaildelivery.com [192.29.178.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A2A134BD
	for <git@vger.kernel.org>; Thu, 28 Nov 2024 05:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.29.178.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732773024; cv=none; b=KvuaCP2r/7fRKlJwz2HYJKAkDE6z3d7/Wo16dsd/IEOh1tO+2Mb5ew5HXBU96Uv20b7zmdvnZTfyLKUIxBBW7Me9vmr8yAjASGS8g69urFWcVut9v4xdU4nDv8SiN2a2R2jImJbcZB0NH/l4qMG92THN1AQf0QXHRL/RxTWcEes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732773024; c=relaxed/simple;
	bh=Blfde7QKLjrzN8HfZ8nOwndaS2a/a/hKPSnhUPFW8Yc=;
	h=MIME-version:Content-type:Date:Message-id:Subject:Cc:To:From:
	 References:In-reply-to; b=d8YvAtheLv40dJfnG3egRA2hc4sw2gkTwohvNPOCkdQcJl12JTP7FC2JrElojdbWB2NxTF/dH0KBvYO4Ej8YK5VIo41Q7wDHzGbelGZL5pc9a9nxC0P73raa9eFfnlimorA49cKmilFOK1lo0qJAiV+Id67ObK5IE2lg9iiJI0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com; dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b=UB5PLckU; arc=none smtp.client-ip=192.29.178.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b="UB5PLckU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-zrh-20200406;
 d=zrh1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=MGqiQ6oqRGzpPMJEqF8jU4A4ftVIBruQlxkth0dPj88=;
 b=UB5PLckUqHI3CkYvpbeuKyPeUSC/6iRiqI3HNRVB5S0JBZxIMEtKATUy93gNPNMwEPXA9F5ZKBRg
   EGgrsAM/YXe5M1TI2em6T+EV88bobQVOH0+d9mawcShRQwR0bcH0YWfVKfGEWiD63xeEduLcJ+7K
   qMtX1Wyij+vOx6+RoQZxFjKXLnnpHDiSMQpnpj06x+WCG8pVOQyD9xJxkUcRF7KM04riCOsezAJ7
   HoMLzG6xJR1F1Q7PILNWLh1fd1YCy5bVkKvQ7WT2c3Sk/hXZ3qvq3nAdRlNQdvpMP6GdtxU/Yhqb
   G1B6P3CMUTjEmD3+pCW71OhLf/K1kx4ocMU4lw==
Received: by omta-ad1-fd1-402-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20241107 64bit (built Nov  7
 2024))
 with ESMTPS id <0SNN00EAYC7Q6N30@omta-ad1-fd1-402-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com> for
 git@vger.kernel.org; Thu, 28 Nov 2024 05:50:14 +0000 (GMT)
List-Unsubscribe-Post: List-Unsubscribe=One-Click
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-transfer-encoding: quoted-printable
Content-type: text/plain; charset=UTF-8
Date: Thu, 28 Nov 2024 06:49:09 +0100
Message-id: <D5XKQVYAZE2H.2SRB9JJ8GLWA3@ferdinandy.com>
Subject: Re: [PATCH v1] fetch: add configuration for set_head behaviour
Cc: <git@vger.kernel.org>, <phillip.wood@dunelm.org.uk>,
 =?utf-8?q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
 "Johannes Schindelin" <Johannes.Schindelin@gmx.de>, <karthik.188@gmail.com>,
 "Taylor Blau" <me@ttaylorr.com>, "Patrick Steinhardt" <ps@pks.im>
To: "Junio C Hamano" <gitster@pobox.com>
From: "Bence Ferdinandy" <bence@ferdinandy.com>
References: <20241122123138.66960-1-bence@ferdinandy.com>
 <20241127091718.345541-1-bence@ferdinandy.com> <xmqqa5dku6w6.fsf@gitster.g>
 <D5X7DHD1BRYO.22CU1OL6KLN49@ferdinandy.com> <xmqqplmgqkrr.fsf@gitster.g>
In-reply-to: <xmqqplmgqkrr.fsf@gitster.g>
Reporting-Meta:
 AAGXZam+I655EfGXWM6AXvSiMyPZxR98gi/ohCXMuCIz/NVV9CoNd/X0pplDvmMZ
 I/uyQRx4oqPlQtmual7h4QB2/GOFJlogh33Wgzysqz//sg3gyiVizyTCvhDvtPin
 DhQ1/JDQnv7SRiK/54mKBKdqA+nKL8//mBO61HXYUB16J8UfNcw3TqNSUKuRgy7/
 GFXwmchM4afgGjydNNoEkh47zgnQ+aD8PhQbAfb1FjCE9MHKkrD6RLsdhylPkOqY
 CK/dr3w70w9UC7wmRPNVbTCYneKu1aUcmxlDo/Dig32k1y/JPGmBXt0RB7BQ88Ju
 OAMGbfnSvp8ueBXoe3EncHaZnF1zYuLsqmsb6clHF6V39Fg6EgjZB+O0WT45GDCX
 brmF0sp0t1tZQRhsi4/Y27Yan+Ja2GSNi6IbB+0rJ9f39JtLzhK+NfU9xf4eALc/
 bMMMtTgODLho2Ax4XbOS/cP2t6kYpgCd+4hjDjPKZ7BWZoZ9Wxtcphs7Uw==


On Thu Nov 28, 2024 at 01:12, Junio C Hamano <gitster@pobox.com> wrote:
> "Bence Ferdinandy" <bence@ferdinandy.com> writes:
>
>> Just to clarify, an example: the remote's HEAD is set to "master", and y=
ou have
>> - git remote set-head origin next
>> - git config set remote.origin.followRemoteHead "manual"
>> - git config set remote.origin.followRemoteHeadManual "master"
>>
>> you manually set these explicitly. As long as the remote's HEAD is still
>> "master" you do not get a warning when running fetch, but if it changes =
to
>> something else (even "next"), you _do_ get a warning, that is not silenc=
ed
>> until you set followRemoteHeadManual to "next".
>
> Yup.
>
>> Would you expect `git remote set-head origin next` to set followRemoteHe=
ad to
>> "manual" and to set the correct value for the followRemoteHeadManual to
>> "master" if it actually changed the current refs/remote/origin/HEAD from=
 master
>> to next?
>
> What I found missing is:
>
>     "I know this is the value I expect them to have, because it was
>     the value I last observed there. Please let me know when they
>     changed their mind; I want to reconsider my position when it
>     happens, and your warning me would help me to do so."
>
> My running "remote set-head" to manually change which of their
> branches I am interested in does not tell Git anything about what
> branch I expect them to be pointing at with HEAD.  It may be the
> action after such "reconsideration" of my position, but there is 0
> bit of information on what I expect their HEAD to be pointing at.

Hmm. After a bit more thought: running `remote set-head` doesn't make much
sense if you have "always" and makes a bit of sense if you have "warn". So
maybe one thing set-head could do is _if_ you have always it could drop you=
 to
"warn" and "warn" could also include a line not just about following with
"remote set-head" but something like "You can either follow with set-head, =
or
you can turn this off but still get a warning if origin changes by setting
...".

>
>> Or is having this completely manual fine?
>
> If it can be automated, that would be nicer, but I do not think a
> manual "remote set-head origin next" gives any information to help
> automating it.
>
>> I toyed with the thought of rolling the two settings together (an unreco=
gnized
>> string would mean the reference for which we must be silent), but then y=
ou
>> couldn't have a remote/HEAD called "create" for example, so I think we n=
eed to
>> store that separately. I'm also not quite happy with "followRemoteHeadMa=
nual"
>> ...
>
> Yeah, I was thinking a value like "warn-if-not-pointing-at-$branch"
> where $branch part would be a token like 'bc/set-head-symref',
> 'master', etc.

Good idea. Probably shorter though like "warn-if-not-$branch".

>
> I do not think any of the above should block this topic.  It can be
> added later without disrupting all other modes implemented there.

Ack, I'll send a respin with just enum fixed for now.

Thanks,
Bence
