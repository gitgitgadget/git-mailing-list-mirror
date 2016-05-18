From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 2/5] t1500: test_rev_parse: facilitate future test enhancements
Date: Wed, 18 May 2016 13:43:29 -0400
Message-ID: <CAPig+cQtt1TcHdRgZcB_fJ7_SEbZLjbKP04Eq=eRCCkU6PnQ1Q@mail.gmail.com>
References: <20160517193630.10379-1-sunshine@sunshineco.com>
	<20160517193630.10379-3-sunshine@sunshineco.com>
	<20160518183827.Horde.e7PY7wuh3iXKFZgoQ0oLR3D@webmail.informatik.kit.edu>
	<CAPig+cTv8UNg+0taNF4B2wytn0d-jGboCntxBy8TPgY+1qW85w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Michael Rappazzo <rappazzo@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>
To: =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Wed May 18 19:43:37 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b35VP-0002UM-Oe
	for gcvg-git-2@plane.gmane.org; Wed, 18 May 2016 19:43:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753119AbcERRnc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 18 May 2016 13:43:32 -0400
Received: from mail-ig0-f195.google.com ([209.85.213.195]:34195 "EHLO
	mail-ig0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751967AbcERRnb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 May 2016 13:43:31 -0400
Received: by mail-ig0-f195.google.com with SMTP id kj7so5306975igb.1
        for <git@vger.kernel.org>; Wed, 18 May 2016 10:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-transfer-encoding;
        bh=deZ4xQmkoZD/pV2k9CbMXOJqp+lAKJ+Eum6namAsAck=;
        b=a8pUMwXxb9aGoZx+SdM0pbsb48H+b8zPBu2eLyB/5c8OAAS0s/NzdD8AB2DN1CYkcq
         JUVCArUPDmSMussGjua6aGDfkNb848P9V4NN4qAPkSE+kOG2/S9JdQ2hCvcbDIDJRfqO
         fArYtZmSor3P44FZeARLGh//tY2n+MANedWtsHDaPC1DK6jvbj8sHcOjd5LUoQhnH6xo
         M/xgypeGnoQiG3f3d3jGaXWMtmP5jSPl7yctIPhPao5v+61cYrX7ewHOUwO4EX0oMDD5
         9sYKJZIu+WotPna4S9QYfavMfwlbb3H9HtUdeSURDnqAMcttDJNOpy8B4KFtYZmzbqYy
         KtDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-transfer-encoding;
        bh=deZ4xQmkoZD/pV2k9CbMXOJqp+lAKJ+Eum6namAsAck=;
        b=UU8vMz8WyNKDVFJN/NVtljA6GnZbg+lioK/LTir/eA7YCD27XZ2HuQEldgInyLHpAI
         GdJkH+8sMvkeFUB0B865Olohr+3bz+7QGPst9D1kOtOtWtym1oat0s09amQj1QpXyyfv
         Q4bzTJ+qy1Ibgey2L6fQd0zvOTDrgr4HjQot8o6T0Lw8u4IkcgakOIq1qen9bjabqzbU
         bTlb7kYFpwuRVbftpVwhGiw2dEbh00Yr9k3y5AZ88Pnq5LHU4aHcF8NHh5LgkTKv4fd6
         6cPtKydOrrzQH4ic782EAKRk2zGDWiHhcdp//V/enx5Q4OhmDnQdgoiJxLOdyEKpCZAJ
         4myQ==
X-Gm-Message-State: AOPr4FU6a3D9PhfBFTVSzr3aj7lUvDbpEopYChnJlxUvjEhXuwJSJ0SwTRqXRPof+lobn3ZE7mDDu80ABI78vQ==
X-Received: by 10.50.6.15 with SMTP id w15mr6701987igw.91.1463593409694; Wed,
 18 May 2016 10:43:29 -0700 (PDT)
Received: by 10.79.139.135 with HTTP; Wed, 18 May 2016 10:43:29 -0700 (PDT)
In-Reply-To: <CAPig+cTv8UNg+0taNF4B2wytn0d-jGboCntxBy8TPgY+1qW85w@mail.gmail.com>
X-Google-Sender-Auth: u_MJXTwyw47enddyDk_Igr1Gpgc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294981>

On Wed, May 18, 2016 at 1:32 PM, Eric Sunshine <sunshine@sunshineco.com=
> wrote:
> On Wed, May 18, 2016 at 12:38 PM, SZEDER G=C3=A1bor <szeder@ira.uka.d=
e> wrote:
>> Quoting Eric Sunshine <sunshine@sunshineco.com>:
>>> +       for o in is-bare-repository \
>>> +                is-inside-git-dir \
>>> +                is-inside-work-tree \
>>> +                show-prefix \
>>> +                git-dir
>>> +       do
>>> +               test $# -eq 0 && break
>>> +               expect=3D"$1"
>>> +               test_expect_success "$name: $o" '
>>> +                       echo "$expect" >expect &&
>>> +                       git rev-parse --$o >actual &&
>>
>> I think that "--$o" looks really weird, but that's subjective, of co=
urse.
>>
>> However, the idea popped up in an other thread[1] that we might want
>> something like 'git rev-parse --absolute-path --git-dir', which woul=
dn't
>> really work with '--$o'.
>>
>> Even if we don't go that route, perhaps it would be better to list t=
he
>> options to be tested including their doubledash prefix.
>
> As this series is only about modernizing t1500, I'd prefer to keep th=
e
> conversion faithful to the original which titles each test "$name:
> is-bare-repository", "$name: is-inside-git-dir", etc., and the curren=
t
> approach does so without additional complexity.
>
> I have no objection to upgrading the for-loop items to include the
> leading dashes or updating the logic to support --absolute-path, but
> such changes are outside the scope of this series and can easily be
> built atop it. Also, due to severe time constraints, I'd rather not
> re-roll only for a superficial and subjective change such as adding
> leading dashes to for-loop items.

On reflection, I agree with your points and will include the change in
the re-roll. Thanks.
