Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F3B13BF699
	for <git@vger.kernel.org>; Mon, 15 Jun 2026 08:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781511558; cv=pass; b=uQvnk21/sp0L2nb5SC+a+afKO1gzT4uGzE7Xcc04BvzHg3S3/eVdSlo7TXIJOE6t4yKpb/8b3ZkhC39RvthbSa8oS65N1t5GNyP0/T3vrRL+yXy86Zf78HguZQzBh32fwmn92ygkEB9h0LrpvR1M8ijXl4N9XkTClAZ0eVNqaB4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781511558; c=relaxed/simple;
	bh=gM6vzBeHaEc19P9eW8kBEA4ElewFHrqBHKDmJ/nQ6ZM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SKX+QeYRTFIp0CFl+/9xH129EmJIA/FEZIML3F+N5euoZCa5GAQcbXRB9QQ/UkTxapI/tzsvKTTZUKbAnbHfdGccluQ+Ml5Q29umR+s+NlTkkiKBIw+9u5JJzxwVU67Xb637fky/QlI/CAjIn4lMVza5vVeOHpu3qdflzmEntSM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S0/ar5T7; arc=pass smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S0/ar5T7"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-68ced97b6eeso4785935a12.0
        for <git@vger.kernel.org>; Mon, 15 Jun 2026 01:19:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781511555; cv=none;
        d=google.com; s=arc-20240605;
        b=bmpOiV0V32kUjglhl3KsPHMebqAGiEKUMDTKAHiivfNXVAW9j6X/r1lWedvwJSdg5e
         3pLMoo+vppvd26as9qd2NFLGcSRGaGcCwhVa0EZH9jApZpeZ41m11UQYaPNkFbeu31b1
         yPqy7XvE/xNMjSTWJQnVrvKfaSMnx/+rMi1boy6tFGz8VJjO1hR5oa66EZmxVGVW5ULQ
         MyPrWXVVerFkFc3EFyPYm35oLXRgd2jXy1lhbnINKdUL9VvhnvTxKz9EHBFDinsdj2TX
         hfQFRTpHPGKlpgx7hhTasfMIH2oYF2dRbLasv8XbcoJGEsguIktb15Y/7CcLadakA6vq
         ML1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=asOlLYIMhqLFMiZYhnhBAX3j/IXsU9cRkextd0oMk/I=;
        fh=I0oEGHlCg/UTDT2MrqWlQaHPHFnTmRYgcvT/R9u+I0I=;
        b=hOQ0eQlb1tsbaV2OMWO1geRhzHTEkLrml8C3raKTILB1TAS8W0iZWxoXjIiHErBy55
         Tb9hDGFuoLtjFctQr2FlmwKp85ZmdzecZAZ/2DXh1wbFGE2VuktnWGyVsjVLX7cc8c9k
         viHRV+eMOnwwcH+7WRyfDM9T01j4bTz+dDee90UMgohKZJvfMLd1EMPUO2TkNfCLklMe
         COSzKVmNbQjPxLTv1nvLuBbzRizfOVl4GyfAQ+NbHjhQDuoOpS2ZcHG0BHhXjMmhMWn+
         F8+cX4NZvlzWcP1tOoLXUfDqUY+lOOydYHHaX5Q/R3KYlZmTuomSyA9Vr5FtbgyhrUGw
         8W1g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781511555; x=1782116355; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=asOlLYIMhqLFMiZYhnhBAX3j/IXsU9cRkextd0oMk/I=;
        b=S0/ar5T75SncxH40ueZTfC3/OeA5DzZ9Sy4gL3lNzUnR/GQpAj8yx4hpfnPY39x7TO
         3MUYbW70x7D6t07e+6rYgI+6YjXIRr+evwTJCoVpRH1Gpq9FLu4sWfXDlw7jql1ICVBZ
         pLdZKQVa+HGo7BB9FlZQz5DLlmSUARy+1PeGGsPo/1xoczS3VaGY8xRH0/zjRKHXd1W4
         XfuopX+LQ4LfrDfYpJ45durYYJeXTr9ZIAAawR6dgbS0/2jisLJr9FqBMusmcb3Jygsf
         /PLc3kS0iSeTlsIUeiDuMHy8bBObbObzLQ7HhkIwaSyHXw0nNscu4P4s4vTNJkVCfU4g
         LPTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781511555; x=1782116355;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=asOlLYIMhqLFMiZYhnhBAX3j/IXsU9cRkextd0oMk/I=;
        b=p3HRftTUMmitYAWPO2p37Z3Oh9TtRWsQuESYSZpCKWiLHuQ0R6jmOL1+SftnTQFDcq
         Hl+kE5oYkH8CjZLq9T2P52LQW+/4teOngM9foV50FROsG7qtY+y5rq67rqpX65zqxMkt
         S4XKWzir4dW5JOlr9oO51akNp1s/QrmhnSoNxtoUqxBD5xkzV0Ly3KZn0d1LaaIw8UMj
         YCC5qiJIUcmXnRo1rTkIL557fylB4XdyM9q1evqYCV0eXu32i27IrpHZn5K7g2A+8Gvr
         t7STkBvnDu/HKX/ERqXlFXStUWBsWo9VSHHww+PCmofxuiS2TpkmMUCk65aEsWeQUpz9
         UCWQ==
X-Forwarded-Encrypted: i=1; AFNElJ8Tj7Nvb48FQmlNljXp04p0KX/1NAUhhZ5mHFQxjmyYrgEWKxKHVdbbO5uG7LqJG5QH/aQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YznOR1en8kW4EQjsQptFzgA3gmUdY3sARD6KUK6HSyCYyP/JbEc
	siC58dSPzOr5pCshHM9VEUW9GCq4IH0MfBofPpq1zEj3w1hp7JnVwKUmQVODp8dUet2CdEdEVE6
	NuBzbMSNtyG1cdc5XqsIb8mKOsc1gBiJjb+MkWN4=
X-Gm-Gg: Acq92OGLcT7KUIIMBss6SdulnZVna6WZVl7aaxsd9Q8ywfwx13J4glJ/IV4OiGehPcc
	9UkltPrmPl78Oa4cJU+Xjq+ro0OdW54QtNn9V7CdIw6AIZDaRSpr32iEe17MbcPuve7RzF+7SaM
	BUMkgC6OC9e9vzLvG7PjoHlH27QMMfLECNvroIxG95UitJma1K+gKiikzVh/pbrfSuYt5bgyqQI
	bJJkikEl2G0S5MWeadilv9qK98+7svaA/n/oxVctm3k4Df14VsWMPRlcJovL5WI5mPkX6YzsFHI
	JItfabY=
X-Received: by 2002:a05:6402:1585:b0:683:e394:cc0c with SMTP id
 4fb4d7f45d1cf-693784ebd19mr5469251a12.4.1781511555071; Mon, 15 Jun 2026
 01:19:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2337.git.git.1781465141.gitgitgadget@gmail.com> <xmqqqzm8d0j7.fsf@gitster.g>
In-Reply-To: <xmqqqzm8d0j7.fsf@gitster.g>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Mon, 15 Jun 2026 10:18:38 +0200
X-Gm-Features: AVVi8CdN6HS0384QE25u4cDFuEgrQybnp8iKYbap9P6N_9rnGS3ITxK_Y9KfYak
Message-ID: <CAHwyqnWa55xbTpzq-Nf6cMyvgR1yYgg8fhvgMFkquSEGPUwDmg@mail.gmail.com>
Subject: Re: [PATCH 0/2] rebase: add --fixup to fold a range into its oldest commit
To: Junio C Hamano <gitster@pobox.com>
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> > Adds git rebase --autosquash --fixup [<upstream>] to fold a range of commits
> > into its oldest one, reusing that commit's message.
>
> [2/2] seems to add "--fixup-all" but I agree with the "related idea"
> that naming it and modelling it after "merge --squash" would be
> easier to understand.

Sounds reasonable.

> I also wonder if we can do something like this without adding any
> new option or command.  E.g., if you have four patch series, where
> the initial implementation HEAD~3 is followed by "oops it was still
> wrong" fix-up HEAD~2, HEAD~1 and HEAD, then
>
>     git reset --soft HEAD~3 && git commit --amend --no-edit
>
> is what the user wants to do, no?

I don't think it's enough. First of all the user has to know the N for
HEAD~N, and then 'git reset --soft HEAD~N && git commit --amend
--no-edit' is still quite ugly.


Harald
