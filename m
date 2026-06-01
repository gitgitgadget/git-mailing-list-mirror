Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14B9B18AE2
	for <git@vger.kernel.org>; Mon,  1 Jun 2026 16:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780331354; cv=none; b=m+F0xhz+cb/Mpoc+CIXjtMRvFj2SAbVh/YitI2RNEmazV/Zb3MKgZCwjVDoMGqwHcpmAPfJKSusN24nL6ql4cvs/w55vGwUxfeYnqOjk0UQgozitBSbOBOEocobsv1ltc5QYoLRg0vLVEbrFmnoSP7+nSRpzW1gig8Kd+WHhWxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780331354; c=relaxed/simple;
	bh=HCcdoCZ6b0527q54TbXhqcH/PmAyyKuWJ5t0AuICDh0=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=W5ttno72ZQtqxNZiS8LYujheT8owMgvE/xdo01d10k7KrVeFr3/gvhJ/88vjExajzEeK0rOK1GZX4vxar4KHZE3dzmQg4tQVBZB0EbBC4EWEyg+qGgpqhxvGaAnjzcaUFGmWL7Hmts6GbTuLf0xELfXczJNwxiu145r4rzPUTVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c3Vj+LQm; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c3Vj+LQm"
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-59aa414167eso1038604e0c.3
        for <git@vger.kernel.org>; Mon, 01 Jun 2026 09:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780331352; x=1780936152; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HCcdoCZ6b0527q54TbXhqcH/PmAyyKuWJ5t0AuICDh0=;
        b=c3Vj+LQmZg1SJjHKdToTo8M6a6Fjkw8SgA+CaTnVpaBOVAK2BAgRNJAcN50DQMyA+d
         BRC9xAltzO9W4Qj5XYR/f5QV0qGY1UcpjJmqSZyOtpP55xPe+xAodhXAo/beDTefCuts
         QPYQBFeGSYtX4nMYLkrt2qcUdXUkW0dUGU8IcEkheOA1pU9X2V8EvreUfDzM2JvH0jKF
         oeDAFDIN+d55i8c3fHVbE4MJ7sK3zop8tKUpzkIDTFRiKUJk7q/CPAbRNHXGC4fOAXPU
         gOZZsw5UqF5359CWY//hhHha2O/I65GMaYtUsP9zXK5SJBG3+eUBdGMshVdKcvx/Cjqo
         yo8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780331352; x=1780936152;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HCcdoCZ6b0527q54TbXhqcH/PmAyyKuWJ5t0AuICDh0=;
        b=oNyqDvvKlpX5hgl0fzMSU/KDMaVl+8Sm7zXWa9p8v6HQsdQVK0XoSYUQdPrYUWS6ZH
         3GjKeIFRLD5xCOyH48MPXr2iCxQVH8LJSY4PDUO/zHEVU58ugqL0q6oCRUI6UMMiNQD6
         tfIoM3nQTULGhxS7A/HSV60LDuNgQ3Xny1/RzLqKP3WgoYU8qJjfrYq2y7Zch90EmjOo
         VT9XtINWzJTD6vilytwj9vjX8iunt+XpHK5icNNy+qVtCivzxAb2S0Q+fGrLamv3NgKH
         E45sGhXkCVaXk+uLiQ0c6x/cgibsQRSP+MlxufhApjctViz7pMMtPTQaWtfn5a7MPlqC
         MvUQ==
X-Gm-Message-State: AOJu0Yz9Hqou98HDBDF2Qs2HvAuiNNifwgy0+mTA1trU3EZGYGj6lUUu
	jhnutBPegjtd9gyWKR+hT1detU2EtBQX2K8kZX7+NlLkO3uxD4KJmn37
X-Gm-Gg: Acq92OEYwQjUJ+2tqiG2I8sCT3KKgEuaXFMvYuRMye7BiRVGgSvKGnpwJjvPea6izTi
	1faqs9RVn+BGs8o48GZ2LsJoMlkqxleg4M/5jAXgg674xijzugKmq7WJHh/hz78oMohJ4rJ24nF
	wMCR+Ju4I38Wr9O85oX2TyLOnVkXC7+FU1BMRBJDyQ8iU5F67lJPqg64sYPKlLumlRPvq6zTqfi
	Z+srwvcNPxuEZdy1U2fErJhqm+5bqVNQCjQHa2EIPB/81Z51NzcnrbzKCfiqgX6pxVkSb5Cfh91
	e9Vtj6Qd+lKrINj/lQq0IZXLBRk/orDaE9R526Y4pYFuMOk/W63/5xGLdt4pWt3TxbBUQfcsp2c
	uNxYGxjATlMfTGiA5rLfxNRqBJ9AWYwed/hj8yjsrdBgNmibeZtXfJrk9jlgZt3omUz8+a04I8R
	0QYw4/oPvSoS3TQOfRWeO4PjC+ijfjN5kwZIqXfk2rE0DYG43qDQ3N5EEEZn9NGdA=
X-Received: by 2002:a05:6122:489a:b0:575:36c4:8900 with SMTP id 71dfb90a1353d-59bf56cc72dmr5427649e0c.14.1780331351980;
        Mon, 01 Jun 2026 09:29:11 -0700 (PDT)
Received: from smtpclient.apple ([189.62.148.96])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-599d4754259sm7508375e0c.7.2026.06.01.09.29.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Jun 2026 09:29:11 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.600.51.1.1\))
Subject: Re: [GSoC][PATCH 3/4] repo: add path.gitdir with absolute and
 relative suffix formatting
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
In-Reply-To: <20260601151950.30686-4-jayatheerthkulkarni2005@gmail.com>
Date: Mon, 1 Jun 2026 13:28:57 -0300
Cc: git@vger.kernel.org,
 jltobler@gmail.com,
 gitster@pobox.com,
 phillip.wood@dunelm.org.uk,
 sandals@crustytoothpaste.net,
 kumarayushjha123@gmail.com,
 a3205153416@gmail.com
Content-Transfer-Encoding: 7bit
Message-Id: <FE164E62-C086-4902-B21F-157CD2C4ED0E@gmail.com>
References: <20260601151950.30686-1-jayatheerthkulkarni2005@gmail.com>
 <20260601151950.30686-4-jayatheerthkulkarni2005@gmail.com>
To: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
X-Mailer: Apple Mail (2.3864.600.51.1.1)


> +test_repo_info_path () {
> + field_name=$1
> + expect_relative=$2
> +
> + test_expect_success "query individual key: path.$field_name.absolute" '
> + (
> + cd test-repo/sub &&
> + expect_absolute=$(cd .. && pwd)/.git &&

Note that this semi-hardcoded path won't work for other values (e.g.
top level dir, superproject working tree). This needs to be a parameter
just like `expect_relative`
