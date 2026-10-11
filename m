Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D013F44C652
	for <git@vger.kernel.org>; Sun, 11 Oct 2026 14:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791728305; cv=pass; b=J1foFHjb9eIlAn5e9AR6KzYWBanexJyTn+XDKW8V/sZS935GwspMecKL5TtbUSvdXm/eiZWB+DEHT60bjOaBCAAu0mzeYXcsxNJV+MJJsdo+AxkUX0Ezc9/f1d4Hf6Gn2yTm1RGNtS80DIiq/qnz+9vuoW16uowGW5Knh6TL0oo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791728305; c=relaxed/simple;
	bh=svFKBbI1u76fBXPeMvXOfkTTSZEONUv+lyo+l/f04p8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R0Qx63eAaYGMPQSiKUWlfOtgarBngI3yvRAYdYWdOF44tpgoUH/msOhSTDnY5OnqGmi4wrsPq7BAjxrO2mDprqfOkYDKb5g0BFIFZfZMWjmhXTEQEL94ty7iwlMP4xkHoSaYZBhQsTzZtcWz8OspOH6Zxd0AMB5eGZVh2m0k6dw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=thomasbachem.com; spf=pass smtp.mailfrom=thomasbachem.com; dkim=pass (2048-bit key) header.d=thomasbachem.com header.i=@thomasbachem.com header.b=Sx9vw54X; arc=pass smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=thomasbachem.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thomasbachem.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thomasbachem.com header.i=@thomasbachem.com header.b="Sx9vw54X"
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-677b5148acaso841776d50.0
        for <git@vger.kernel.org>; Sun, 11 Oct 2026 07:18:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791728301; cv=none;
        d=google.com; s=arc-20260327;
        b=foxPcnxaSp68DH6bVHi1R+Hem+jEEgGSRqgyJtpYTHtJT++yWX75X81obyC0OcNHiI
         YgJLgUcTc10RKlg3qEXrPp4PKSAmBgOADf/0fAyrbEm3gzWV92sz6roezo9LU5Gf2T3o
         YCQ4kiDBpK9uhAhqCCtpciTKmOTfzJosC/BhevsSBozWt5ZL65iw7oEa8BT35ts4VleL
         dMnqzSn1XwAxnG48g42mpnPL9jrGQFlg927mrrbNgMu2iq5UAz9pxqQktIO9FlQKz7Hq
         ASvdo3E/a6c0DJgjlCch9olkCb4Eg+bLzfhgCEehiW4JL8oT32kI8MNB0v/yW2+BGu6S
         XsIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=yLktEYvr3nXz3AS4oVNU1mey8Gt3MN3KmfcsKsKVvJ0=;
        fh=Q46tNc3BJj4WIW7wxt2lub70mkt83WZLYGXmsTidru8=;
        b=dN50HmgrrdSUXqh1jRVwqQA8JsWoS0lTOZutwU1Wm59esfK9WGW8APZBB+dcSbAgsZ
         a3PbykW7lJpLUJ8HQCW/LiZTURouXmp6BLKNhbNHK1xkwel8C9KuYDFxofkke9YGHZRe
         n5T4uMVs2htw41QPRjXkyc3LceGbGNQ+YSG0gQJQHRwNwEWvv+0euvPOCA+YoLM8sF5h
         cyVasObDC73OrewQXnVtIUxnvvXof4oUW2xA3ksaUdkZ/PI49Mz6yw7koaziqhPQ7ILd
         XVReNsEgJBfrTCdhUGRqEbtDx6WW/naFv8euWvw3eyTD/KQN89OJYz/dTiFNHskCjs9X
         qR0A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thomasbachem.com; s=google; t=1791728301; x=1792333101; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yLktEYvr3nXz3AS4oVNU1mey8Gt3MN3KmfcsKsKVvJ0=;
        b=Sx9vw54XBg04Us6h9gFnGq+kZ5nj6G+LlHF27aO1RGtVMyC+5jUZCI6fv55FQP7+AU
         cTQ3PleTWmZPHCQo/EePBsaswgpPZYMtZAosa6T0xfAWJnWJsZiFyUki9GgViKQ3Kaf/
         nRmJ6SvH1i0fxh4PuBSNsF4tCyyuyjQfrI8XGRYV+B8PKxA8hje1k0XoDjqZxj6a/B7K
         TSX+UL84Nue3N00kC3w/WYfdOBiryxH14GguqyRytc2IU0zjxm5PjJqYsjBRlJq81inn
         9gQQHEXGhnSUzrZRhwCkaQ/tcToX4GgqETmbLQig7rypd4aATq/qtjt0xCyIp1JWPu+/
         y4uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791728301; x=1792333101;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=yLktEYvr3nXz3AS4oVNU1mey8Gt3MN3KmfcsKsKVvJ0=;
        b=grbI/UW21ZJyPdIyWZJCFaZFWuL338GldXyc1iJucv+4KgGHbQzeoHvphAX15Dcf1c
         DcHA0JDmY3YobSQPnPfSDN3/uO9ynWYYxOwm9gJ7Z1qt7JAYaNrqjpHLIrc8F3XkCThO
         wOfmPyEsVQZ6fnm1zDV60/8A6dq5lCOCNrnj5b5/tlCJYH0p4oIEVi3rV6sfBQ1etCf3
         BuERS9urllyF9s00wR/P9PllpKVkWA/rwedh+0HrA8/fBGiM0nBjLVcIKoIMED4CBW6J
         FeSr0Xcwj4+4DmjVs4dWsGGSwe3fS/ynjlrKFBWqhfeLWhRDcsjwnIgPubew5tfTm6Ii
         glCQ==
X-Forwarded-Encrypted: i=1; AKwUvBykzB7oyWHS5AL0qgcDwKBEXiP15pY7JOqYoZYga+yjBSPi+zNVNELu75omH+Fv9Nc129U=@vger.kernel.org
X-Gm-Message-State: AFq9FYK3uldgL+75cjts5QM5wOpPg/sOZwrunaPv3XQWT1bz9n7wGDCR
	TlxuXQe1N19WTlSBLJb/1cp/QxXC8lvyziIqaS8Ornq90NgQBwrw7XUH9WTSHoHbN5947dUPMFT
	BujgoUP+1oTx7aKeccUBkZX3dyIyXoQtySDOx/ib7eaftD8lbzJ03zp8gfQ==
X-Gm-Gg: AYBFou3UmXMa7e96TTL0oNRU639qdP/UYGjGpTQj149+3dpNEKb4gpS7oAKr8xBF6dK
	gn2OKCniOCLJvXCh+qtp/ruZq/WmUCOO9l/44SekvzPKaA7CxrO2BVa2606S7rSnBgYJz/PP+28
	XxFyOXuK399dCms+sm8N/kmdOwC/LN3q0jCTUMr/3/lwRth6gJfatELH2v3SX/LItJEXt3OFbc1
	YQ/VEBi88+bBxPG//igyiiaBpRAaxsmnekftUPUO/lxppS+7an+GAzxoTS61rfNRxeU6ZeM7OJg
	OCzrVnKfENVar1mdoON1PhJmBbAHnNnWKOe++MU39FbrkCa1SJ05R1dgTzT/4UGCMiROWpnBtH+
	suw3fq2+T/0IawQNB0S8EfPH3v22FTmOSiiaEizpSKh6oOQ==
X-Received: by 2002:a05:690e:1c1c:b0:676:85ca:71a0 with SMTP id
 956f58d0204a3-67936297c42mr2413496d50.112.1791728301474; Sun, 11 Oct 2026
 07:18:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2214.git.1788337897490.gitgitgadget@gmail.com>
 <pull.2214.v7.git.1791627204.gitgitgadget@gmail.com> <3dc3d02f12a3118ac9e270c19960815f6b8170cb.1791627204.git.gitgitgadget@gmail.com>
 <xmqqqzhxf4uo.fsf@gitster.g>
In-Reply-To: <xmqqqzhxf4uo.fsf@gitster.g>
From: Thomas Bachem <mail@thomasbachem.com>
Date: Sun, 11 Oct 2026 16:18:09 +0200
X-Gm-Features: AclHuK-0yKX3vuXK0F0hqIIhwW-StP9KtxKDdNHPUkDMnOau7Y9Wvlt1MAMFmL4
Message-ID: <CAA0xjtpuQE1UiQEPjfmsp9BZPROucfXCOpok5ADjMRB-rTZRiw@mail.gmail.com>
Subject: Re: [PATCH v7 1/2] rerere: wait for MERGE_RR.lock before giving up
To: Junio C Hamano <gitster@pobox.com>
Cc: Thomas Bachem via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Patrick Steinhardt <ps@pks.im>, Phillip Wood <phillip.wood@dunelm.org.uk>, 
	Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Hi Junio,

Thanks for the careful review.

On 11/10/2026 02:39, Junio C Hamano wrote:
>> +     When the time is up, the command fails as it does
>> +     for any other lock it cannot take.
>
> Is it necessary to say this?

No, I'll drop it.

> The backgrounded unlocker sleeps for a second.  Is the idea that,
> even in a heavily loaded CI environment, the backgrounded unlocker
> will have a sufficient chance to sleep for a second and unlock while
> the 5000-millisecond timeout waits for it?

Yes, the unlocker can be up to four seconds late. t0610 and t1300 use
the same numbers.

> Is the idea behind this 'wait' that the 'rerere.locktimeout'
> implementation might break in the future and we could reach this
> point before the background unlocker has finished sleeping for a
> full second?  And we want to ensure it has exited before proceeding
> by waiting for it ourselves.  If that is the case, perhaps a comment
> is warranted after '&&', such as:
>
>         wait && # just in case the background unlocker is still active

It is. Instead of the comment, I'll move the wait into
test_when_finished, as pack-refs-tests.sh does, so it runs however
the test ends.

> Or make the string a bit more specific, such as:
>
>         test_grep ! "Unable to create.*MERGE_RR\.lock" err &&

I'll use your pattern there and in the other tests.

> Should we ensure that there is no leftover pid file by removing it
> before creating .git/MERGE_RR.lock, by the way?

I don't think we need to. Git only writes MERGE_RR~pid.lock with
core.lockfilePid set, and t4200 never sets it. Even a stale one would
only change the text after the "Unable to create" line, not whether
git gets the lock.

> I'll stop here, but you can grasp the principles used in reviewing
> this test and apply them to the remaining tests to ensure they are
> clearly written.

Will do.

Thanks,
Thomas
