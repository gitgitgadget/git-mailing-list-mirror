Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DE7FC43217
	for <git@archiver.kernel.org>; Thu,  1 Dec 2022 07:52:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbiLAHw4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Dec 2022 02:52:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbiLAHwx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Dec 2022 02:52:53 -0500
Received: from mout.web.de (mout.web.de [212.227.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9352F1CFDE
        for <git@vger.kernel.org>; Wed, 30 Nov 2022 23:52:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1669881158; bh=+wziKD/7hn8lDNntweFZ7NBiXdlD7+qTGUsRwijVMWE=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=I2eHCPpRA8wbiR4I8vlb4RZ8553OJg5wN//kXQLF19xL8Vc4sK61qMRS6uNBf/wQg
         ytUoOlLh7QLFcWGoF0BDb1BYHfTPKT3IPFyHuPnsQnwZvPDaqPXmv3w1TtepcuzD/l
         Fk4embH6ylw+PfkhfxoRf11phfcR51lUccdXkbM1nainUJf1teewZ0P6jjnQAoB7la
         NryTLTwy1sbmPEBr2nlivEF+dd3b1NpG3DeJ3n5Elbv6aQUnW60imOq13kfUaRi7Eo
         rmQde490Y6dUJO3uwNd2Yz8AW85bFQgok7+8BY1R9BrGFXn0+Pkpqw8sF4/K24HFE7
         +0eX1sy3eo4+Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.154.159]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N7QQB-1ovUvz10Or-017gnc; Thu, 01
 Dec 2022 08:52:38 +0100
Message-ID: <20b5d6d1-ec09-e09f-4f92-5925fb9c96f8@web.de>
Date:   Thu, 1 Dec 2022 08:52:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.0
Subject: Re: [PATCH 3/3] diff: remove parseopts member of struct diff_options
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFy?= =?UTF-8?Q?mason?= 
        <avarab@gmail.com>, Jeff King <peff@peff.net>
References: <0620b4a6-b80a-d8a0-5a35-857b9fe0c986@web.de>
 <d226d3bc-fb15-58a4-f516-bda51a912228@web.de> <xmqqcz93ud8o.fsf@gitster.g>
Content-Language: en-US
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <xmqqcz93ud8o.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:nWfBk+mVb0RkV+VbqIA6zZ6ij485MQ92nuWfDCUdAnNwIiAnqYz
 nUODQ1KejX82jNk/ZrsJlcHfKIJDERSVRJtCMYv+BA6NqbubjJ/IkuV1YZw01gSbNzVYCPG
 /iXdB4FNjmgifgV5MmFdRrw6Z2QKWYPxRr/VGwvKR+YhBeQ4phQ7v6JY9lDSfFCIOTaDvUi
 9hIAC2v1ZLGcSC3Br9sjg==
UI-OutboundReport: notjunk:1;M01:P0:Z2k88xye4Ek=;6Q4t3c6EGG0qmlkRkt356Mm9cZQ
 4Wg6g4ffyXyL1nTUIc1bCCOcA9usnERY3dG8RJHQac6G9NZ46sHYkPIACOQtj1qofG4ueSaQV
 ZroSuoUuVgVEIvwun0xNmB7E7LkfZpN0QEVa0sF2HrNuw8nXYLFTJwSn025MSuKeGmmaDNJts
 8rJojHpG4CcEo1Q7322cc643v5i6jvkN43EYGI0J0ouBzeYw/2LgQTOf7GMIveWhJbg8DlBps
 n+w8NrR8eozotH/KeJOn7Shqa3MxbOQaLmo3SpGD9AbRkemhTvw2A2xfNNWLR1kSmvGedkugC
 RTK/MrMrgeODxi2MDTQ5KfuxEaaAlb5e70EjbE5Mvoms4G5ZvbeO/cw2LAzuOostYheGuox2p
 LN2RiEwnhxC/zXvTV/2Psi2Oiu3pScDZrB7hRdrq2k+EMEwNESN7Nc41JJ3weZJfoxuw5jld2
 ObLmQXzTMMYDo9Yz18kn2bgLW7S7aCPw4adexBeWYHRfjGh/LxtLr2TqZ3xC6Wg4OT684mtxw
 pg07q3N33L8JMJj7TaXht/4KF4rG0AZS2L/PXewrFn1/7Rk7p7x4S/w4n7LMxTlsF3QvYYJLr
 SOcVEd0u7Y9DaOueMOZhySUC/VYn5Ea3YrJAE23yD1bRuWKlB8N+wueI3zjeSEAIVVMyIey1R
 0OmMcUO8dgtkfwKWhqEMo+HrtVvtcChcArJ0NPYu9YnLnZJWUeTNqmGKjp9oyfTHRuTzFYV8d
 RMpI/ubbIDb8q2eBCHyl5tSxPlg5Y+MEuHBZ4pxLJgb52eK7Buw6OAezPg3WPzWmtjDRktwOP
 SpX6Fo5+aLI25cmpW7TQGj7CJQ47Z5Le91YsfInEw/FMNfFIzwBJdkzqhrdP0zICRbz90Jzad
 zT2s0szMT9ejQ3cPIAsGCrIfxSeAc0Vmst81A5SlQELnWD4bcRNXnsrjCbJLAJ0sWCCPw+xqh
 9smUPC/65MCxFJdYgkP6XjP3cyM=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 01.12.22 um 02:25 schrieb Junio C Hamano:
> Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
>
>> repo_diff_setup() builds the struct option array with git diff's comman=
d
>> line options and stores a pointer to it in the parseopts member of
>> struct diff_options.  The array is freed by diff_setup_done(), but not
>> by release_revisions().  repo_init_revisions() calls repo_diff_setup(),
>> thus calling repo_init_revisions() then release_revisions() leaks it.
>>
>> We could free the array in release_revisions() as well to plug that
>> leak, but there is a better way: Only build it when needed.  Move the
>> get_diff_parseopts() calls to the two places that use the array, free i=
t
>> after use and get rid of the parseopts member.
>>
>> Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
>> ---
>>  diff.c | 17 ++++++++---------
>>  1 file changed, 8 insertions(+), 9 deletions(-)
>
> I think this hunk is missing?

Yes. O_o

>
>  diff.h | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git c/diff.h w/diff.h
> index 5229f20486..6840499844 100644
> --- c/diff.h
> +++ w/diff.h
> @@ -394,7 +394,6 @@ struct diff_options {
>  	unsigned color_moved_ws_handling;
>
>  	struct repository *repo;
> -	struct option *parseopts;
>  	struct strmap *additional_path_headers;
>
>  	int no_free;
