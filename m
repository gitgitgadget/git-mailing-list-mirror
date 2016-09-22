Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E442207EC
	for <e@80x24.org>; Thu, 22 Sep 2016 09:03:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756547AbcIVJDu (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Sep 2016 05:03:50 -0400
Received: from mail-wm0-f47.google.com ([74.125.82.47]:36240 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752647AbcIVJDt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Sep 2016 05:03:49 -0400
Received: by mail-wm0-f47.google.com with SMTP id w84so240123351wmg.1
        for <git@vger.kernel.org>; Thu, 22 Sep 2016 02:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=jXCf+cnPKNu8vEbBHGLQv+aARU6/lGNRjDE8EOfULXc=;
        b=LIXsK+7SX3v1QIfO64vNEx4+Q4OUng9wx+TQni2zmZ2GhrkKELs9oAeT8jfeniT9tH
         EArqZS1JRBGJc0mUtt5VHwrCAwApmGmJjZLZhJ6PAyt67Hy+OtalHjaL+hLjs/FUiXKb
         EeoiN4pkDYaPtRA+B8eAGF5gY+NsHCIDJ4uvsnhRKCaYC56UapH++SN1YdCVnrnAMIdA
         3SkqImP6djym4Rbr02YYjhRu6OiPS/cgtgPaBO3/Re+fM/Xhy0zfJzg2woOvnDRC1nbl
         OAKGKIhy4QKrPuMxErdU0l7tutG19kc36EtVOjMKKGst9j0zOSElWzD09IU0LzgD3yP7
         sMmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=jXCf+cnPKNu8vEbBHGLQv+aARU6/lGNRjDE8EOfULXc=;
        b=FRG0bxxJIFaBzsTrPLftU5X+/qHlZtIMO2rFa68iS9+has1Pv5o9sLpcPRMUw6vYJS
         iZsa1fCqrTET2wYCMV3uC6mfGDy4hzt6fdlWwf7iHh3MMYyifzF0e8X9ggJHGJWXZ2Qg
         +rkyZLPMF/qP7N0m777QSI2qwTfPNBSyCvYOU8bdeBeQLCSmWDMDOi3ydT+ANOOGM7/P
         SQ/LlqMZhuJMZq19TmrMzIKQnusLafdtf59j0A4GCwt3XM/zOQyI7FkJZ4DN6GGfTV/t
         gfu4+3RGAZloUpPVEZu5/JHZnqwM0TLWSxEPKf5My/0vixFFHEtXKZ1lnHSZPBr82dPS
         kf2Q==
X-Gm-Message-State: AE9vXwPJNvG5ySSFuciyUes38sMeJoBU+4eUnVQWp/ymALW8nPZM/mTEEe5gM9TicfcwLg==
X-Received: by 10.194.84.234 with SMTP id c10mr997270wjz.34.1474535028045;
        Thu, 22 Sep 2016 02:03:48 -0700 (PDT)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id f8sm960792wjh.45.2016.09.22.02.03.47
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 22 Sep 2016 02:03:47 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v1] travis-ci: ask homebrew for the its path instead of hardcoding it
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <xmqqzin19pbj.fsf@gitster.mtv.corp.google.com>
Date:   Thu, 22 Sep 2016 11:03:45 +0200
Cc:     stefan.naewe@atlas-elektronik.com, git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <A1C0644E-095A-4903-AE86-72EAEFEB385B@gmail.com>
References: <20160921084518.13091-1-larsxschneider@gmail.com> <83e3049c-34ea-4440-7b4d-061cb98ba2dd@atlas-elektronik.com> <14C21417-491B-4C8E-90FE-47154EEDD9FE@gmail.com> <xmqqzin19pbj.fsf@gitster.mtv.corp.google.com>
To:     Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 21 Sep 2016, at 18:42, Junio C Hamano <gitster@pobox.com> wrote:
>=20
> Lars Schneider <larsxschneider@gmail.com> writes:
>=20
>>> On 21 Sep 2016, at 11:31, stefan.naewe@atlas-elektronik.com wrote:
>>>=20
>>> In the Subject: s/the //
>>>=20
>>> Am 21.09.2016 um 10:45 schrieb larsxschneider@gmail.com:
>>>> From: Lars Schneider <larsxschneider@gmail.com>
>>>>=20
>>>> The TravisCI macOS build is broken because homebrew (a macOS =
depedency
>>>=20
>>> s/depedency/dependency/
>>=20
>> Thanks for spotting both errors!
>>=20
>> @Junio: Should I make a v2?
>=20
> No.  osx before_install stuff was in there since the very beginning,
> i.e. 522354d7 ("Add Travis CI support", 2015-11-27), so I guess this
> needs to go to maint-2.7 and upwards, but I guess we should discourage
> people to stay on an older maintenance track forever, so let's do
> this only for 'maint' and upwards.

Sound good to me.

Thank you,
Lars


Minor nit:=20
If still possible and no trouble for you please do
`s/the //` on the subject line of =
72fa5cd29f2a9249462215109dbf41b4a6c0c768 (in PU)

