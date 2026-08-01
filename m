Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42AC923ABBF
	for <git@vger.kernel.org>; Sat,  1 Aug 2026 21:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785619847; cv=none; b=HN8a9Wp0QYI7BNotKMry+NJ+seX7m6CcQdyK+9am5swLKdCTKSpXGk+i/x7Bb63gfh6osvhhPhQJp3eLiWr94ng05p8ARbaK1vtm19/NTujskMdzs9m+zR5GYY0PfdNuPw2UZ+HuGwfk1w8MG0s22NT/+VR5VipwXF6yC8QfXpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785619847; c=relaxed/simple;
	bh=eY14lHdR66z2yNYMAIijMSUcXnSpjpHldBDL5qGWFBY=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=qdPkY99+hvgz+N/V04w1TsVFu3vXelKkcT+lOfDYFc2hDxlUAa1UwbuBsHHt9GBhufzIJfGd8Yd5BIl6/atWhj5QjfwCFeyuL/wasqhlx+20n/9XbMgOgJReXKSbhqyT5ShBjkViH5xNUKJBhPdtbVhK8DNrzkN+gHRfDsFO0ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=el7vWXK+; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="el7vWXK+"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4954a9e8490so9491095e9.1
        for <git@vger.kernel.org>; Sat, 01 Aug 2026 14:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785619844; x=1786224644; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=LwrAVIfESEHA9HX6loB5LJHaPjOGJsqqQ+MWVTNJzN4=;
        b=el7vWXK+nKhU8frdqnH+9KKerjBe+EXa6Q9uLk4pkDSHpA7ZaBGffT95uQTWxtM+C1
         Iud43GqOValTsjopWqVx8YzWGbRwDC9+0cCLX2QSdfojMua1YwBzjOtcpFhp03Z5itLP
         7w3V9wFgliGSQnUNQjXWYb98W4wwmwn3H3dJoQgXzLPwwjY58SzLs455s4O1Ckf6qsUX
         dMs8qBG8zfnOrU1PwckkhlqpAooFNd/mHhR/2gZStikXyDaHtuHkWWxrRGrO7fAR5jo2
         N5rUs5imOEJt+tlAS5grravEOTJWSwhYKLuajQTUV3qcsTt/08Mljaih/WUaC8Zos0la
         2EwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785619844; x=1786224644;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LwrAVIfESEHA9HX6loB5LJHaPjOGJsqqQ+MWVTNJzN4=;
        b=KARFOXXGp0bfBD97176kOfIIyYj6qMtOsKgV4hX2pep8e4MVblOPljl/Z83DIUfB1C
         TcfS9L0QCGZs5IqJz+9q32tM5fmjGTK2gDzf2BRAHQ2ok6lVCzRF9eJB+b55QuYu8wyx
         EK6z2XLB6fUpkxxEYZMvtD/6uYdJHM8mpCuOBDSs+PCwkuEtMSqQeAs/CdF6+yklq2T7
         JmOJFMiiDCIllqCpixb+Xp1QJDEPOc890MCvK/hF3ghLn7IQmyIUzjFrwkbycR2NBhOf
         YxcTgEcczoaK9Wjmf+jYPZ/PLQmJeOvrWwJpvk5/OqRtRu4Kp783WzXekmOTAfu3K3Gl
         bWeg==
X-Gm-Message-State: AOJu0YwJjGy8oODFo6YTxRDTKh4McjHr7vpWWs8OvCz3TTvHL94LwrTD
	bLyMcQIpah3X52xz0WWMpSVxSHyKkrhT0MxRS4Ips6cOzAL70RIdSKFW
X-Gm-Gg: AR+sD11jZC8+Iu8WIrv8GpzHU5ptwI2dQidI18ZzrblK3srXr76opGagzFIeBavU+2J
	Bftij5OaI36J8nOHW7/QQj5+5Yf/xKxdXjlaiBTtWKZrvKn/+I2jAMekogf5fEgLELP6zFgMBJw
	fkni5OusZwYlwbn6bbDxq/COWV4h/yKTL2LVLL7OrVCvrrRRoURvygt1mCPJv5Zpk+zreYOJMwG
	aXYC/+kImEhn1EaIV8JlzhM2Omm2bZAOXOMU4baJsXSto+IZ3waz4P0UfZCN80+IJT61hgLiC41
	tl+k2gSj4QIXhwiPeG5RHXcS58c/op2kF15bANYJ/KoJXpggHNQ+P1I5ukuA7jT3AFyibYQdDWT
	vs6ymx/KdG46WjF8+DeP1bcfwFo8IA/nxaqnRqK+tqpj1HyCL7Mq1HVCB+0GK4MiMsWIoPukCoC
	9/TpEN3bybVOj07ZljOrvQIz5I7OI29nI+R3GipsxCyUCoWIn6zvlv0P6/gPmV/EE533ljU8tMu
	35o38pUQZ/jcLF5ArJBu7w8J2yAEVxF1ubXNZuz9hYm3lgCZQHZBeKxlagBsAM6oo6vjGdW7zqH
	ULySSbO0FoNuqMvMM7TDWYOdw8fXtchlDOW5b/KW8cQGJEek2cRqT24oo1upWudCCmVAYfnS3ur
	NqSW8wyTbiQ==
X-Received: by 2002:a05:600c:3150:b0:495:3c6f:7c18 with SMTP id 5b1f17b1804b1-4980eb8c4c9mr60697475e9.3.1785619844371;
        Sat, 01 Aug 2026 14:30:44 -0700 (PDT)
Received: from localhost ([47.58.8.78])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49807b8d04fsm111800185e9.3.2026.08.01.14.30.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Aug 2026 14:30:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 01 Aug 2026 23:30:43 +0200
Message-Id: <DKDXENJ2KWS8.1ZFRML59BECCW@gmail.com>
From: "Pablo Sabater" <pabloosabaterr@gmail.com>
To: "Chandra Pratap" <chandrapratap3519@gmail.com>, "Pablo Sabater"
 <pabloosabaterr@gmail.com>
Cc: <git@vger.kernel.org>, <karthik.188@gmail.com>, <gitster@pobox.com>
Subject: Re: [PATCH GSoC v2 5/6] serve: advertise type capability
X-Mailer: aerc 0.21.0
References: <20260731-objecttype-support-v2-0-af577461ed57@gmail.com>
 <20260731-objecttype-support-v2-5-af577461ed57@gmail.com>
 <CA+J6zkQQsuB3LA=Zg_oEaX7Z-AMhyJf2=ZJYZER=XMPiqaea-w@mail.gmail.com>
In-Reply-To: <CA+J6zkQQsuB3LA=Zg_oEaX7Z-AMhyJf2=ZJYZER=XMPiqaea-w@mail.gmail.com>

On Sat Aug 1, 2026 at 2:12 PM CEST, Chandra Pratap wrote:
> [snip]
>> -# This tests depends on %(objecttype) not being supported yet, once sup=
ported
>> -# it needs to be updated.
>> -test_expect_success 'unsupported placeholder on remote returns empty st=
ring' '
>> +test_expect_success 'objecttype is supported by remote-object-info' '
>>         (
>>                 set_transport_variables "$daemon_parent" &&
>>                 cd "$daemon_parent/daemon_client_empty" &&
>>
>> -               echo "" >expect &&
>> +               echo $hello_type >expect &&
>
> Shouldn't this be echo "$hello_type" instead?

Because hello_type is "blob" (no SPs) it works but you are right, it
should have quotes.

Will fix it.

>
>>                 git cat-file --batch-command=3D"%(objecttype)" >actual <=
<-EOF &&
>>                 remote-object-info "$GIT_DAEMON_URL/parent" $hello_oid
>>                 EOF
>> @@ -271,6 +273,22 @@ test_expect_success 'unsupported placeholder on rem=
ote returns empty string' '
>>         )
>>  '
>>
>> +test_expect_success 'unsupported placeholders on remote return empty st=
ring' '
>> +       (
>> +               set_transport_variables "$daemon_parent" &&
>> +               cd "$daemon_parent/daemon_client_empty" &&
>> +
>> +               fmt=3D"%(objectmode) %(objectsize:disk) %(rest) %(deltab=
ase)" &&
>> +
>> +               # The hardcoded SPs between the atoms are respected.
>> +               echo "   " >expect &&
>> +               git cat-file --batch-command=3D"$fmt" >actual <<-EOF &&
>> +               remote-object-info "$GIT_DAEMON_URL/parent" $hello_oid
>> +               EOF
>> +               test_cmp expect actual
>> +       )
>> +'
>> +
>>  test_expect_success 'requesting only objectname echoes back' '
>>         (
>>                 set_transport_variables "$daemon_parent" &&
>>
>> --
>> 2.54.0
>>

Thanks,
Pablo
