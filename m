Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C0D330FB0
	for <git@vger.kernel.org>; Thu, 19 Oct 2023 15:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eZD+nT/1"
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6EFC19E
	for <git@vger.kernel.org>; Thu, 19 Oct 2023 08:43:11 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id 5614622812f47-3ae0df6494bso893523b6e.1
        for <git@vger.kernel.org>; Thu, 19 Oct 2023 08:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697730191; x=1698334991; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jQMAikEwAYuqsyVaNLy8I7nooYfL14rB/Tdd0s5+NDs=;
        b=eZD+nT/1wY4N8By0ne8ooApQTw/0ba/TAY1CN1xiZXwzNB1xQvQgnrrvbK0CGZXsbu
         RlvgppbY5Sjnr7HPpBj2xKyCoimLwLN00WJkKgdOwmL8DhK4u2XlGS5XI6QtP1kKYyFt
         5MBbn0Sm+h8gmhD0Ajl2yzna9vrxz/5KjpY6WwabRB9WNGO+B30j3IH2ILdV7hdHUQf2
         HCvWFPaLeWEhLVz02prRYxZMkG61Sj+RuJ2MuEwb/GMDEMk8VAphQOQ1AdO7AL/l2NVG
         Het1lRqxA+z51s0HVJdKth5zh7gIrI/qC10G8XlkquRzyLL843UtmTHN9RKpMoyz88uN
         cDcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697730191; x=1698334991;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jQMAikEwAYuqsyVaNLy8I7nooYfL14rB/Tdd0s5+NDs=;
        b=WLALzrEqB/yLgzrUsZ07cr8BTzM15GGE0AvFEQG7WNjg20Ej0juK/Oy/vsLSjDtjYm
         TIEX7yz2ZJQuCBtn1mDiZFF9UpkOwLh27+CDK6yJBm0DhdVliMv4j4lHwdC3uFDCkCMz
         7JbwN5Xv/XHfLY79wEBsrReUHD9vq/sm14f1ieED8FF/dx5oF8wTw2u1m3JBFjLNIvsY
         NaRY+A5cE2oSHVp8oT03vtf0sVeARtFcYJ/B9Cy+/FXpA9Eh4EHo4LyXylFm5p856wZv
         XhEr3K86zeQdajDp/HgK3s3+UGSS0/eis8ek6lMMOgV88bP/cnQnfgzOeU0DASA5jEvz
         dfdA==
X-Gm-Message-State: AOJu0YyBJJUWXp+gnkDlLssttghfz18mIwMVPY48SdoCtB+GiV3ESqjd
	9+vKA2BRqzDXIMYLgsm8z2Hx+XUxV4Y=
X-Google-Smtp-Source: AGHT+IG1cxaxoaSpsiQdLisoLOpOlA+E25K0OjBPmPBKj5JeJn2PphYWmX/9pd/gdHui9wXP5G4ZZA==
X-Received: by 2002:a05:6808:2001:b0:3b2:db33:e301 with SMTP id q1-20020a056808200100b003b2db33e301mr2758580oiw.0.1697730190812;
        Thu, 19 Oct 2023 08:43:10 -0700 (PDT)
Received: from [192.168.200.38] (pool-100-1-44-175.nwrknj.fios.verizon.net. [100.1.44.175])
        by smtp.gmail.com with ESMTPSA id h1-20020a05620a400100b0076f058f5834sm827353qko.61.2023.10.19.08.43.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Oct 2023 08:43:10 -0700 (PDT)
From: John Cai <johncai86@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: John Cai via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org,
 Jeff King <peff@peff.net>, Jonathan Tan <jonathantanmy@google.com>,
 Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v5 0/2] attr: add attr.tree config
Date: Thu, 19 Oct 2023 11:43:09 -0400
X-Mailer: MailMate (1.14r5852)
Message-ID: <C8977B9C-6875-40D1-BEFA-6468379F4028@gmail.com>
In-Reply-To: <xmqqzg0mxnaj.fsf@gitster.g>
References: <pull.1577.v4.git.git.1697044422.gitgitgadget@gmail.com>
 <pull.1577.v5.git.git.1697218770.gitgitgadget@gmail.com>
 <xmqqmswmz76w.fsf@gitster.g> <xmqqa5smz2lk.fsf@gitster.g>
 <xmqqzg0mxnaj.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi Junio,

On 13 Oct 2023, at 16:47, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> So in a sense, for !!ignore_bad_attr_tree case, the code ends up
>> doing the right thing.  But if !ignore_bad_attr_tree is true, i.e.,
>> a blob object name is given via --attr-source or GIT_ATTR_SOURCE,
>> then the bug will be uncovered.
>
> Having said all that, I suspect that this problem is not new and
> certainly not caused by this topic.  We should have unconditionally
> died when GIT_ATTR_SOURCE gave a blob object name, but pretended as
> if an empty tree was given.  There may even be existing users who
> now assume that is working as intended and depend on this bug.
>
> So, let's leave it as a "possible bug" that we might want to fix in
> the future, outside the scope of this series.
>
> Thanks.

That sounds good--let's fix in a separate series. Thanks for the careful =
review!

thanks
John

>
>
>>  t/t0003-attributes.sh | 12 ++++++++++++
>>  1 file changed, 12 insertions(+)
>>
>> diff --git c/t/t0003-attributes.sh w/t/t0003-attributes.sh
>> index ecf43ab545..0f02f22171 100755
>> --- c/t/t0003-attributes.sh
>> +++ w/t/t0003-attributes.sh
>> @@ -394,6 +394,18 @@ test_expect_success 'bare repo defaults to readin=
g .gitattributes from HEAD' '
>>  	test_cmp expect actual
>>  '
>>
>> +test_expect_success '--attr-source that points at a non-treeish' '
>> +	test_when_finished rm -rf empty &&
>> +	git init empty &&
>> +	(
>> +		cd empty &&
>> +		echo "$bad_attr_source_err" >expect_err &&
>> +		H=3D$(git hash-object -t blob --stdin -w </dev/null) &&
>> +		test_must_fail git --attr-source=3D$H check-attr test -- f/path 2>e=
rr &&
>> +		test_cmp expect_err err
>> +	)
>> +'
>> +
>>  test_expect_success 'precedence of --attr-source, GIT_ATTR_SOURCE, th=
en attr.tree' '
>>  	test_when_finished rm -rf empty &&
>>  	git init empty &&
