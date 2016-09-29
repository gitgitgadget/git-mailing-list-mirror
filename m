Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 538EE207EC
	for <e@80x24.org>; Thu, 29 Sep 2016 20:50:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933938AbcI2Uuw (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Sep 2016 16:50:52 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36759 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933484AbcI2Uuv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Sep 2016 16:50:51 -0400
Received: by mail-wm0-f68.google.com with SMTP id b184so551346wma.3
        for <git@vger.kernel.org>; Thu, 29 Sep 2016 13:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=bTaz3afTwMx/34tJirxo2prKTc0XTQMhg5hVZVth5Ro=;
        b=JR/v9VYM5plJ2uBaMlRkPFKKHHEBPhnYObtOJoec1oR1OEkPaeh5sQYPEwnPlqQv7f
         7oigtcy+PkWxeDhJs4zJGoCYvFDjMPWDL5AmOkI9B5Sc7MqLYHAIinxmljoSMomAG4w5
         ztJPALHc//WpK45SwlzqyXlrXGmVg1SITwY34KC7ooSCizTVmQAt7eXk3D5/EaIvXGpj
         oLHnZC+qqC4pjrW/bS6bbzIqmwSjdk5GVmiwlg4Q5EFzk7RGBLLlSpoiAYErt2cJ+7qc
         mw5r17GKYrSbZ69/tg/GyY5pXuS7ewRbw0J+sSK0B7qJgDQiBo+uihx9ozMTmNBh6YM0
         uw7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=bTaz3afTwMx/34tJirxo2prKTc0XTQMhg5hVZVth5Ro=;
        b=S59e3F8Vc7F5oBmClTXNPPLI3J4AswaQI2HI+Q/oDQa1rpjphws9+sdolgyM/qPHw+
         oIinK8eCY8umPhfJguQDs7bsySJEmKMgEBSZFcUUSKfDStJb+hKg2TWZxCYVzti7HlZy
         Y7x9Cjaudva2Failzp+js+uCpED9EFTG7rqnLJ43GYd+vuTGzVVpJqZzZMCYOg8bgTYk
         TR5HqFAtQEKmWkK5NwlOkwzQdTM2ojxXvcBCj9wt3n3TRl4IDpGEtUIUa37NBjGHFi7H
         5XvlzBCx6TpOOdhnWDV1U8KEYu6pSGMDpnyCkDIg7hcfuj/xJPxawPdEIfI9OcyfDHkV
         kCoQ==
X-Gm-Message-State: AA6/9RmsTC0CvFvhFEa4hOBf8pf9BDJmA8f1LWWeM2yAlC4Tk5s4Cms+aBbKa6nGmCNFkg==
X-Received: by 10.28.14.202 with SMTP id 193mr510983wmo.125.1475182250059;
        Thu, 29 Sep 2016 13:50:50 -0700 (PDT)
Received: from remjtf6f32.ads.autodesk.com (adsknateur.autodesk.com. [132.188.32.100])
        by smtp.gmail.com with ESMTPSA id p13sm599652wmd.1.2016.09.29.13.50.47
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 29 Sep 2016 13:50:49 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v8 00/11] Git filter protocol
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <xmqqk2duhcdm.fsf@gitster.mtv.corp.google.com>
Date:   Thu, 29 Sep 2016 22:50:46 +0200
Cc:     =?utf-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
        git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Stefan Beller <sbeller@google.com>,
        =?utf-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
        Martin-Louis Bright <mlbright@gmail.com>,
        ramsay@ramsayjones.plus.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <DADB0C80-1EDF-4498-8DAC-A1B09E596518@gmail.com>
References: <20160920190247.82189-1-larsxschneider@gmail.com> <xmqq8tubitjs.fsf@gitster.mtv.corp.google.com> <C2C9761E-986F-473D-BFB7-CBEF900D9FA3@gmail.com> <f7a4f828-bb1d-0ffa-e369-3b4fa476d9e5@web.de> <xmqqk2duhcdm.fsf@gitster.mtv.corp.google.com>
To:     Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 29 Sep 2016, at 18:57, Junio C Hamano <gitster@pobox.com> wrote:
>=20
> Torsten B=C3=B6gershausen <tboegi@web.de> writes:
>=20
>>> 1) Git exits
>>> 2) The filter process receives EOF and prints "STOP" to the log
>>> 3) t0021 checks the content of the log
>>>=20
>>> Sometimes 3 happened before 2 which makes the test fail.
>>> (Example: https://travis-ci.org/git/git/jobs/162660563 )
>>>=20
>>> I added a this to wait until the filter process terminates:
>>>=20
>>> +wait_for_filter_termination () {
>>> +	while ps | grep -v grep | grep -F "/t0021/rot13-filter.pl" =
>/dev/null 2>&1
>>> +	do
>>> +		echo "Waiting for /t0021/rot13-filter.pl to finish..."
>>> +		sleep 1
>>> +	done
>>> +}
>>>=20
>>> Does this look OK to you?
>> Do we need the ps at all ?
>> How about this:
>>=20
>> +wait_for_filter_termination () {
>> +	while ! grep "STOP"  LOGFILENAME >/dev/null
>> +	do
>> +		echo "Waiting for /t0021/rot13-filter.pl to finish..."
>> +		sleep 1
>> +	done
>> +}
>=20
> Running "ps" and grepping for a command is not suitable for script
> to reliably tell things, so it is out of question.  Compared to
> that, your version looks slightly better, but what if the machinery
> that being tested, i.e. the part that drives the filter process, is
> buggy or becomes buggy and causes the filter process that writes
> "STOP" to die before it actually writes that string?
>=20
> I have a feeling that the machinery being tested needs to be fixed
> so that the sequence is always be:
>=20
>    0) Git spawns the filter process, as it needs some contents to
>       be filtered.
>=20
>    1) Git did everything it needed to do and decides that is time
>       to go.
>=20
>    2) Filter process receives EOF and prints "STOP" to the log.
>=20
>    3) Git waits until the filter process finishes.
>=20
>    4) t0021, after Git finishes, checks the log.


A pragmatic approach:

I could drop the "STOP" message that the filter writes to the log
on exit and everything would work as is. We could argue that this=20
is OK because Git doesn't care anyways if the filter process has=20
stopped or not.

Would that be OK for everyone?

- Lars=
