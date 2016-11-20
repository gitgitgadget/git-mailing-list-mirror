Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E15E1FE4E
	for <e@80x24.org>; Sun, 20 Nov 2016 07:32:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753081AbcKTHb5 (ORCPT <rfc822;e@80x24.org>);
        Sun, 20 Nov 2016 02:31:57 -0500
Received: from mail-yb0-f195.google.com ([209.85.213.195]:36732 "EHLO
        mail-yb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752592AbcKTHb5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Nov 2016 02:31:57 -0500
Received: by mail-yb0-f195.google.com with SMTP id d128so10528478ybh.3
        for <git@vger.kernel.org>; Sat, 19 Nov 2016 23:31:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ZjTFfRxZrztICxZlK6a4Zs4yyoMqOsaIhIc7UcCXe20=;
        b=ye1KSUeFcX55ydkKLHt2zSYT515TW8VxI8gCsSuN95KbUqLRhR7v4hOMfssqw4lbJ1
         9phJBRS/ZfJlhyMq2mOK9/+t6UQEvVsTZOCTWCEChwRuPs8WL3cIViSL76oLzfaBiN1Y
         IR4u0h+jNNsVbPDQ8CrJc+jJcD0TMcgPlLR4EWj0UUj90OLcB8lmItuezaVDmpYWShBG
         OUOswHxN+AfjoNzyGHMNkCA27GLoOaV5+YNE8AZ5KdlMSxbgBNll7RoHzWIZEFCKhVWM
         OpZlAlFKYoQ7nqTltO53TLIt2ZehR6oLrf77CuckW8SlJ4/Q9Hwf+mxLPnlE9XV7MjdK
         P/SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ZjTFfRxZrztICxZlK6a4Zs4yyoMqOsaIhIc7UcCXe20=;
        b=ifC5rdYMErkIA1Y6HwF5odQHX1gLST+IIk2W4ldSAPK9KyuqK8flozI4i4gNoOmUIH
         IXIW+t+mJCHWMnZR2xYNOLINbdGZ/6C1aLcyhgxGpujU8R5hG+jthrXYqowywT6TGmtf
         5VWG+RWMayM66rB8h1FM/ElguCTo8gZrKuMTWWSHgpbIqQ69A6ctTMNEGjYE/gcxWBth
         8NbbXQpyVHZDBq4RYT0CRlOxVuZpsiFDyg0I5QB93HIvnDIX5nrzYzwUYPHjnE0t47ZO
         4kJ6qiLAtny5QEwNjQqHlhU0bGomArA8FDsaBE8O1KdTaiekaxhXxVvsRGmwmBZSX8VJ
         rmHw==
X-Gm-Message-State: AKaTC01MPMdnABXvQaWoYz3zJdcVibBZoCBxRZA2UJ1cWX/YUU97aowNmjm4gAivJWP7c2JoTQgxS7sYWonw9A==
X-Received: by 10.37.172.230 with SMTP id x38mr2772032ybd.96.1479627116245;
 Sat, 19 Nov 2016 23:31:56 -0800 (PST)
MIME-Version: 1.0
Received: by 10.13.207.69 with HTTP; Sat, 19 Nov 2016 23:31:25 -0800 (PST)
In-Reply-To: <ce2862d5-874b-f244-f9b3-f74e18f7ad42@gmail.com>
References: <20161108201211.25213-1-Karthik.188@gmail.com> <20161108201211.25213-10-Karthik.188@gmail.com>
 <ce2862d5-874b-f244-f9b3-f74e18f7ad42@gmail.com>
From:   Karthik Nayak <karthik.188@gmail.com>
Date:   Sun, 20 Nov 2016 13:01:25 +0530
Message-ID: <CAOLa=ZQJ+NQuGvxtaA5euspQtNZOZjU_cHRgyYv3z1AcV5d8-w@mail.gmail.com>
Subject: Re: [PATCH v7 09/17] ref-filter: make "%(symref)" atom work with the
 ':short' modifier
To:     =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Jacob Keller <jacob.keller@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Nov 19, 2016 at 3:04 AM, Jakub Nar=C4=99bski <jnareb@gmail.com> wro=
te:
> W dniu 08.11.2016 o 21:12, Karthik Nayak pisze:
>>
>> Helped-by: Junio C Hamano <gitster@pobox.com>
>> Signed-off-by: Karthik Nayak <Karthik.188@gmail.com>
>> ---
> [...]
>
>> +test_expect_success 'Add symbolic ref for the following tests' '
>> +     git symbolic-ref refs/heads/sym refs/heads/master
>> +'
>> +
>> +cat >expected <<EOF
>> +refs/heads/master
>> +EOF
>
> This should be inside the relevant test, not outside.  In other
> patches in this series you are putting setup together with the
> rest of test, by using "cat >expected <<-\EOF".
>

Ah! That's because I was just trying to keep it consistent. These tests
are added to t6300, where the `expected` block is usually outside the tests
themselves.

The other tests in the series are added to t6302, where we keep the `expect=
ed`
block within the tests themselves.

>> +
>> +test_expect_success 'Verify usage of %(symref) atom' '
>> +     git for-each-ref --format=3D"%(symref)" refs/heads/sym > actual &&
>
> This should be spelled " >actual", rather than " > actual"; there
> should be no space between redirection and file name.
>
>> +     test_cmp expected actual
>> +'
>> +
>> +cat >expected <<EOF
>> +heads/master
>> +EOF
>> +
>> +test_expect_success 'Verify usage of %(symref:short) atom' '
>> +     git for-each-ref --format=3D"%(symref:short)" refs/heads/sym > act=
ual &&
>> +     test_cmp expected actual
>> +'
>
> Same here.
>

Will remove the space between '>' and 'actual', Thanks.

--=20
Regards,
Karthik Nayak
