From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 5/5] merge-recursive: test more consistent interface
Date: Sun, 21 Feb 2016 15:32:58 -0500
Message-ID: <CAPig+cRgBCH7-EqEQ8q=kJwSf0nNNWUGRL6PA4Lp0KSE2agLSA@mail.gmail.com>
References: <1456067358-19781-1-git-send-email-felipegassis@gmail.com>
	<1456067358-19781-6-git-send-email-felipegassis@gmail.com>
	<CAPig+cSAWjqD7weNLyk4MrAU1Q7+R6z16GndKkByHo2Uc4yWqg@mail.gmail.com>
	<CALMa68qBtw+MdhDsOFofEDoySuTU5BJ2tQvEKrynQxcXKWkhGw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?Q?Felipe_Gon=C3=A7alves_Assis?= <felipegassis@gmail.com>
To: =?UTF-8?Q?Felipe_Gon=C3=A7alves_Assis?= <felipeg.assis@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 21 21:33:07 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aXagi-0002fi-BF
	for gcvg-git-2@plane.gmane.org; Sun, 21 Feb 2016 21:33:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751409AbcBUUdA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 21 Feb 2016 15:33:00 -0500
Received: from mail-vk0-f43.google.com ([209.85.213.43]:36601 "EHLO
	mail-vk0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751116AbcBUUc7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 21 Feb 2016 15:32:59 -0500
Received: by mail-vk0-f43.google.com with SMTP id c3so113761705vkb.3
        for <git@vger.kernel.org>; Sun, 21 Feb 2016 12:32:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=bM1BWJ1kzyLliWBN+bquzProjd7Ef5wIGVzRfrZ7M4A=;
        b=wvWvlPu3xRiXGaNRm5mggKgtABRUxXYtn+an4D9Oc+gf4d9BRDFxB8rlLA2yBX4b7g
         fV68IqjuttiqXUQkbM3jQ9xRnYGKEZMWcEABR5SiGuUtKSmP+FBZJdw+M1pDNmd6nxPI
         F6+8On3Vg0+qRStCBhhkim5FymHkY84fslxq2KzVQJD1jtiyX6YDF1ZNgWtFYELupvxA
         TJeHNu8ToxFfbHTzFrVUx49HR2Rwxjs73Z+R95MmfTmf1LCHbx9coUxqMEGQdkgiLPjs
         NKCcOZLZygSkZCvDI7JiJ9wlgvSmKXfll2tmo2hhxqyQUXbNPiLLkLdeNfHfVoaL+n75
         FPQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=bM1BWJ1kzyLliWBN+bquzProjd7Ef5wIGVzRfrZ7M4A=;
        b=Kv9AYkteB9sVr1gBTh2K2548QF47i1DUqqplnlL3GjhL4A4IrCYUbX09ix9pjAlT2c
         YhAxoA/yWNKS2xaEbAMMQHaLl54K/tSRtUCFtDVAImz2W/aAuh8pPa3+XjuG1oH2Olnb
         x0WfNqkQZa3JL1rENxCLekUA5o/D5RS7Gd+UviS6sCVPsSpW5hzNeCDxbVlKOYnNkZKW
         EceSVr7MIAc0g1nopwowXcabXx7SGpZhVWA4Pc6ZxX9pFQRvlralZLbUXKXoWxnnpw2Z
         ov+g1KPd+xSVCowlMj+1cIh8rMcJeKFw+3TyfgL6XDtMAWSGArBDSL/WUXRIzqq9o8PW
         NkTw==
X-Gm-Message-State: AG10YOQ0ThtFjM1xSHDEapQHLoRrwE3WTTHpv58JLpN7dbk7F2LIXuW7Tw22T+Pcel71WU+cuT3RdFqbTatPMQ==
X-Received: by 10.31.150.76 with SMTP id y73mr20147989vkd.84.1456086778242;
 Sun, 21 Feb 2016 12:32:58 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Sun, 21 Feb 2016 12:32:58 -0800 (PST)
In-Reply-To: <CALMa68qBtw+MdhDsOFofEDoySuTU5BJ2tQvEKrynQxcXKWkhGw@mail.gmail.com>
X-Google-Sender-Auth: rm4QdtadmWKtZEm6sLf9wuJlfDI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286828>

On Sun, Feb 21, 2016 at 2:55 PM, Felipe Gon=C3=A7alves Assis
<felipeg.assis@gmail.com> wrote:
> On 21 February 2016 at 15:40, Eric Sunshine <sunshine@sunshineco.com>=
 wrote:
>> Taking the above and review comments from earlier patches into
>> account, it might make sense to re-order the series as follows:
>>
>> 1/5: add --find-renames & --find-renames=3D tests (including "last w=
ins")
>> 2/5: add --find-renames=3D / --rename-threshold=3D aliases tests
>> 3/5: add --no-renames tests (including "last wins")
>> 4/5: fix --find-renames to reset threshold to default (including tes=
t)
>> 5/5: fix merge-strategies.txt typo
>>
>> The position of the typo fix patch isn't significant; I just
>> arbitrarily plopped it at the end. Also, the order of patches 2 & 3 =
is
>> arbitrary.
>
> Fair enough. [...]
>
> I am currently working on the following order, which follows your con=
straints.
> 1/5: fix typo (I don't like typos)
> 2/5: tests involving --find-renames

Presumably 2/5 also tests --find-renames=3D...

> 3/5: tests involving --no-renames
> 4/5: tests involving --rename-threshold (this represents what would b=
e
> reverted if the feature was discontinued)
> 5/5: fix --find-renames + test

Sounds reasonable.

>>> +test_expect_success 'last wins in --no-renames --find-renames' '
>>> +       git read-tree --reset -u HEAD &&
>>> +       test_must_fail git merge-recursive --no-renames --find-rena=
mes HEAD^ -- HEAD master &&
>>> +       check_find_renames_50
>>> +'
>>> +
>>> +test_expect_success 'last wins in --find-renames --no-renames' '
>>> +       git read-tree --reset -u HEAD &&
>>> +       git merge-recursive --find-renames --no-renames HEAD^ -- HE=
AD master &&
>>> +       check_no_renames
>>> +'
>>> +
>>> +test_expect_success 'rename-threshold=3D<n> is a synonym for find-=
renames=3D<n>' '
>>> +       git read-tree --reset -u HEAD &&
>>> +       test_must_fail git merge-recursive --rename-threshold=3D25 =
HEAD^ -- HEAD master &&
>>> +       check_find_renames_25
>>> +'
>>
>> I rather expected to see this test come first, as all the others are
>> rather subordinate to it.
>
> But it already is the first test involving "rename-threshold". The
> preceding tests verify the rename detection functionality with the
> recommended interface. Then we have tests for the deprecated option.
> This tail is exactly what we would remove if it was discontinued.
> What did you mean?

It's probably just a minor viewpoint issue, as I interpreted the patch
as primarily testing that --find-renames=3D and --rename-threshold=3D a=
re
aliases, in which case checking that condition would be done first.
However, that's effectively moot given the proposed revised patch
ordering since this test would be in patch 4/5, and the two above it
would belong in 3/5.
