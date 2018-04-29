Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 89D641F428
	for <e@80x24.org>; Sun, 29 Apr 2018 16:12:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753706AbeD2QM2 (ORCPT <rfc822;e@80x24.org>);
        Sun, 29 Apr 2018 12:12:28 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:33354 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753685AbeD2QM1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Apr 2018 12:12:27 -0400
Received: by mail-oi0-f68.google.com with SMTP id 126-v6so5609238oig.0
        for <git@vger.kernel.org>; Sun, 29 Apr 2018 09:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=bx0FAIplOev8ufPO/O00qCcbWDxWzCtLsxc9G0I9a50=;
        b=fiF1tAb2kgsBs2fDo/FHMUMSpiL9/d+3rCFLXFqeYqpMfnFrlrDNiht1N1oyJqQyv+
         X+eujJj6ENqkAd6LRSBJww1E48zzl1iXCY0QxiEzwZx3YVjzewFB7HHvoSnAEFxC0uPT
         H65rV5sVeeJmDgNIXCb/b6jdSFmfFZZLxGjNuHNs3uUfuoYgQDPHjbSIOw4YZHKk3gYW
         7kjo05r87p4yXlrCbeL+nyHMQGspwBDPO0RwoX97P8LY4IonFP0DaZcdIV8LtU8GuwlF
         N/sV+Ei7LNQvHLHLlTAs+TwVo8JPxHPZL5OGkzEkej90OZ/bhrcfSCrkXQ+ivfFp8yID
         2RMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=bx0FAIplOev8ufPO/O00qCcbWDxWzCtLsxc9G0I9a50=;
        b=p0cAevidWlzejNnwh7q0gIvfjqzEQqmBvfP7r8ui3wnTyvsvSEtWJSVzCEQB3q6kdn
         hMjRv1yhMWQVpq6RjgdkBcK82cLVo8JTM2jkChiarofRc3ccEj3HqWy3i+zZCkVLueoi
         AtT0nDrcoeLH/1VJOpaVrxSTioaMtzqhr9NR3YlSGPSjqVIRn+qA4jmg2GAEfXnKAn3Y
         3ASQAq1fJ9+sMWz3flsXedKN3DmqJBNz75XE6N3iWokpLTh5OA1DV2YiukDyfewRHJ0S
         mKM88dXq+XeLXeHbmZcwCsAiCDjEZGDMl+EM/xlRx4y/2M4/q+X5N2t6lKYNm2uzpB6E
         bBUw==
X-Gm-Message-State: ALQs6tBRo4il/cHsVZDXsCw5KpRet51zkTy3vHm1Jb2Y8KunIhaZxHWt
        T2VxoTwF/pJ7RKfxzYYRh6Alw1XqyswTaviTItw=
X-Google-Smtp-Source: AB8JxZqQPYO4jlhGFr0irFYw3f/8BI4XFfrPmB9RjHq1plRvPtyrH6AfmRWngithD5IdCaJTEywFzObffoqXAhAQFEA=
X-Received: by 2002:aca:ce42:: with SMTP id e63-v6mr5930750oig.34.1525018347355;
 Sun, 29 Apr 2018 09:12:27 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.198.152 with HTTP; Sun, 29 Apr 2018 09:11:56 -0700 (PDT)
In-Reply-To: <CAPig+cQ-ZfvHD6B-mK6tOBMdKiVzwz15M4rsOdBMBcgu0OmuxA@mail.gmail.com>
References: <20180421165414.30051-1-pclouds@gmail.com> <20180425163107.10399-1-pclouds@gmail.com>
 <20180425163107.10399-3-pclouds@gmail.com> <CAPig+cQ-ZfvHD6B-mK6tOBMdKiVzwz15M4rsOdBMBcgu0OmuxA@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sun, 29 Apr 2018 18:11:56 +0200
Message-ID: <CACsJy8AzAFVhQw-K_juFg2iF0tVHo0_fF-CRYwMR=xPcTUC-8Q@mail.gmail.com>
Subject: Re: [PATCH v4/wip 02/12] generate-cmds.sh: export all commands to command-list.h
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 25, 2018 at 8:07 PM, Eric Sunshine <sunshine@sunshineco.com> wr=
ote:
> On Wed, Apr 25, 2018 at 12:30 PM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc D=
uy
> <pclouds@gmail.com> wrote:
>> The current generate-cmds.sh generates just enough to print "git help"
>> output. That is, it only extracts help text for common commands.
>>
>> The script is now updated to extract help text for all commands and
>> keep command classification a new file, command-list.h. This will be
>> useful later:
>> [...]
>> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.=
com>
>> ---
>> diff --git a/generate-cmdlist.sh b/generate-cmdlist.sh
>> @@ -12,14 +34,51 @@ get_synopsis () {
>> +define_categories() {
>> +       echo
>> +       echo "/* Command categories */"
>> +       bit=3D0
>> +       category_list "$1" |
>> +       while read cat
>> +       do
>> +               echo "#define CAT_$cat (1UL << $bit)"
>> +               bit=3D$(($bit+1))
>> +       done
>> +       test "$bit" -gt 32 && die "Urgh.. too many categories?"
>
> Should this be '-ge' rather than '-gt'?

After we print "1UL << 31" we increment it to 32 and exit the loop,
then it's still within limits, -ge would incorrectly complain
--=20
Duy
