Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A5EC126F3B
	for <git@vger.kernel.org>; Wed, 11 Mar 2026 04:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773203621; cv=none; b=gglYJwqzilQehlaaa2lQrJg12w7MFxTMp8KpwwW7Fehc+3/6LQLraq6qLXIZH2tyHJRJ4R4ATYxItbYrDa1OhmeqxpLwmVXppiHq4gQNE3/uhIDDXRNlY/IfcwoB2iXEN7+VKdsBB+gyrTeSAPcrvEnY2rGMhS1/QS6KN/tjvFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773203621; c=relaxed/simple;
	bh=guUkrxgIZHmnZCDJUy42IsUKzxW3P4hA1wDcR1+H1Ng=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R7w15ICM1nk43dw5jnkBcACW6Qq72CQ8r8vGMjWKlGSA1bBSa/9E7wOOyUz59GgO+1QDXHNJaDGjoHs62hZHT4YrVGAaKWSkuo/Dv0TI1JjDAwHQF5lRF0FTQiu/ahAj8HKKzTz6rAwLbZ14C8gMXGps0DAJTo7tBG3JJozyc4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev; spf=pass smtp.mailfrom=malon.dev; dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b=RAkYDuic; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=mlzDr43v; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=malon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b="RAkYDuic";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="mlzDr43v"
DKIM-Signature: a=rsa-sha256; b=RAkYDuicvOVgdmcmtKQ+uil88Z6n3d85frwqQkjJ5m7tH5sm/PAPQysZY00JQ+s0w4z0swBZVzYaa53ClmVUcJO9/r+cdBfi0FRRCp1/mJYGiQWxre1kGwPPJpuLL7xGicc7R7rWecB096RpGD66Up6/C+rxpk9q/3lqWtW9ZHqaWeGMrWlIBZXItVRhG8Qa+kHT9Tq4CU/EYgNAB3MSTPtYqbu1DuCuXwei5sIOpwuEt0bPrlIot0GLNB46g0YJFrJbfX8oHgeNJi98VzxtFGbNBYH67trZz7AqbcUPGAXUxHPDQZEXTTgxmTL1PgOZEgOpbIpOdEZF+AsMfLN4cQ==; s=purelymail1; d=malon.dev; v=1; bh=guUkrxgIZHmnZCDJUy42IsUKzxW3P4hA1wDcR1+H1Ng=; h=Received:Date:Subject:To:From;
DKIM-Signature: a=rsa-sha256; b=mlzDr43v9AduMFApk1T1AzAbXK+tAOPSeNPzdrAVCGJdI13tvpJNdMssmzhihYB9aJ/CryF1kNNGZv/7zZkP4dCGhNVKKW8VYTLUfTTIwqzGSSvPxSMxeE/YWkqiVipDMmWfDGT31jcLLR/08wlXtZK+v4fnd9/wRxgQOjq7L299lhBsErPyoHVEUYUMYBEUvGIoY2Zj21v6eSazfd1AyoekN9wRGtqs97RIQGK+OXfW529ixbpcGvVrS0M74chq0yJYSsXXvJzG4yXnSRhRBDC8rkesABWAY4WbD27DmqEB/VdttrChWY2CRXAIHT3gRcZFkMUnVVNlqg1D6G2//Q==; s=purelymail1; d=purelymail.com; v=1; bh=guUkrxgIZHmnZCDJUy42IsUKzxW3P4hA1wDcR1+H1Ng=; h=Feedback-ID:Received:Date:Subject:To:From;
Feedback-ID: 599969:32685:null:purelymail
X-Pm-Original-To: git@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -734116687;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Wed, 11 Mar 2026 04:33:36 +0000 (UTC)
Message-ID: <9fc9fb8b-5f91-4670-a674-76774c31d228@malon.dev>
Date: Wed, 11 Mar 2026 12:33:31 +0800
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] diff: document -U without <n> as using default context
Content-Language: en-US
To: =?UTF-8?Q?Jean-No=C3=ABl_AVILA?= <avila.jn@gmail.com>, git@vger.kernel.org
Cc: gitster@pobox.com
References: <xmqqh5qswo45.fsf@gitster.g>
 <20260309172719.125419-1-cat@malon.dev> <5973423.DvuYhMxLoT@piment-oiseau>
From: Tian Yuchen <cat@malon.dev>
In-Reply-To: <5973423.DvuYhMxLoT@piment-oiseau>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail

On 3/11/26 01:31, Jean-No=C3=ABl AVILA wrote:

> In this case, isn't the long option also changed to optional number, such=
 as:
>=20
> `--unified[=3D<n>]`
>=20
> ?

Indeed. Your statement aligns with what Junio said earlier.

>> The documentation for '-U<n>' implies that the numeric value '<n>' is
>> mandatory. However, the command line parser has historically accepted
>> '-U' without a number.
>>
>> Strictly requiring a number for '-U' would break existing tests
>> (e.g., in 't4013') and likely disrupt user scripts relying on this
>> undocumented behavior.
>>
>> Since we are retaining this fallback behavior for backward compatibility=
,
>> update the documentation to explicitly state that '<n>' can be omitted
>> for the short option '-U'.
>>
>> Signed-off-by: Tian Yuchen <cat@malon.dev>
>> ---
>>  Documentation/diff-context-options.adoc | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> I am moderately nagative.
>=20
> It is not like we are _encouraging_ users to omit <n> from -U<n>,
> but it is not errored out only due to a bug.  Who would the new text
> help?  Users would wonder why <n> is not optional in --unified=3D<n>,
> the other way to spell the same thing.
>=20
> If we want to be explicit, we should probably do this instead:
>=20
>     `-U<n>`::
>     `--unified=3D<n>`::
>             Generate diffs with _<n>_ lines of context. Defaults to `diff=
.context`
>             or 3 if the config option is unset (`-U` without '<n>' is acc=
epted
>             as a silent synonym for `-p` due to a historical accident).
>=20
> which would tell readers what happens when '<n>' is omitted and why
> we allow such an inconsistency.

I have already fixed this in the v3 patch.

Thank you,

Yuchen

