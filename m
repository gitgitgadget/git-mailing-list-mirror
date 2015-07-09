From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v8 01/11] t6302: for-each-ref tests for ref-filter APIs
Date: Thu, 9 Jul 2015 11:22:52 +0530
Message-ID: <CAOLa=ZS3Sb=OjGFZWykLKctdvoZNy0WCoOfQct--+5W4ck6FYQ@mail.gmail.com>
References: <CAOLa=ZTP+=aQL_JW4+O7jUh5jTD1bWpk7xbguYUsW1DkotAafA@mail.gmail.com>
 <1436285177-12279-1-git-send-email-karthik.188@gmail.com> <559CDAC1.8030600@web.de>
 <vpqwpybf25f.fsf@anie.imag.fr> <CAOLa=ZQ=Mjx-L8Xn9kA86b7nv_bF24Mje1rU-Rmcq4kMqp8qMg@mail.gmail.com>
 <vpq615ud53i.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
	Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Jul 09 07:53:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZD4m4-0003wp-FQ
	for gcvg-git-2@plane.gmane.org; Thu, 09 Jul 2015 07:53:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752642AbbGIFxX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 9 Jul 2015 01:53:23 -0400
Received: from mail-oi0-f45.google.com ([209.85.218.45]:36285 "EHLO
	mail-oi0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750721AbbGIFxW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Jul 2015 01:53:22 -0400
Received: by oibp128 with SMTP id p128so20999405oib.3
        for <git@vger.kernel.org>; Wed, 08 Jul 2015 22:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=+HqcujPYofuj7lBLTGRvoAgGxFnudRdSkUcuFUlzoWM=;
        b=tP1IB7fXGzIN/0Py9SPbyYOq/TEfxjxn0C12hgFFbJzs4/+xTm6VXexAj8eLEr4Tfm
         2BDwL9NI1vRwOl2a39YuRwFDlCNt4PCje4kIhAeBlmfuwbFpfNDkCVS4vMq1JridCeWD
         k5d8EFD0QtcdSNHrlyvdQfKQ9JOzYWbt8NIQpyoTcvm+rO2ZciWHgTPFe9agwltdCrTR
         xz86vEDYqU5deyJJrccSirDMun7yDLqkD7aI9VA2Psyjt8D8JpvnsPZuWwLUSK6Gekgj
         9+pflzonplJvkSLQ9MYgNu75p3hfR9+MHnw7vmCsqR03xV5vxgGuo3CEiup7Tmx/RZbD
         KkZQ==
X-Received: by 10.202.200.151 with SMTP id y145mr1660000oif.111.1436421201666;
 Wed, 08 Jul 2015 22:53:21 -0700 (PDT)
Received: by 10.182.26.73 with HTTP; Wed, 8 Jul 2015 22:52:52 -0700 (PDT)
In-Reply-To: <vpq615ud53i.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273724>

On Wed, Jul 8, 2015 at 9:16 PM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> On Wed, Jul 8, 2015 at 2:37 PM, Matthieu Moy
>> <Matthieu.Moy@grenoble-inp.fr> wrote:
>>> Torsten B=C3=B6gershausen <tboegi@web.de> writes:
>>>
>>>> Could we have a tweak for people without gpg?
>>>
>>> I guess we need stg like
>>>
>>> if ! test_have_prereq GPG; then
>>>         skip_all=3D'skipping for-each-ref tests, gpg not available'
>>>         test_done
>>> fi
>>>
>>> since we need GPG in the setup test and almost all other tests will=
 rely
>>> on it.
>>>
>>
>> Does this need to be there? I see a lot of test files which need GPG=
, and since
>> this test file contains tests which rely on it, without it, it would
>> be kinda useless
>> anyways?
>
> In many cases, the tests look like
>
> . lib-gpg.sh
>
> test_expect_success 'test that does not use GPG' '
>         ...
> '
>
> test_expect_success GPG 'test that does use GPG' '
>         ...
> '
>
> so you can't decide in lib-gpg.sh that you'll skip all tests, because
> you would skip some tests that could be ran without gpg.
>

Ah! Thanks. Will reply here with your fix included :)

--=20
Regards,
Karthik Nayak
