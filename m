Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EFD691F4B5
	for <e@80x24.org>; Tue, 19 Nov 2019 19:15:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727148AbfKSTPE (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Nov 2019 14:15:04 -0500
Received: from mout.web.de ([212.227.17.11]:53259 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726711AbfKSTPD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Nov 2019 14:15:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1574190902;
        bh=xcpKI8AbrIiAWYHZyDKygdM/a8m3LkEXb+9eG7Fcd4A=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=lrsV7ddxvhehyhrH+go1X9d7km6co71b/voYefjOoAnmZwgcT0fOXHOo9+4UWYqEn
         H6lOf+eRY7TpncsGrMf163YgLYGXo6PNvbCBKzyGfNCpxltX/cDQab+tiAWLlwWtsl
         204rwe3TdBzSwM8dzXpTtjHcmg89wDK6zu7qnFWY=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([91.47.146.29]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0Lk8t4-1i0p5Q1BYg-00c7xM; Tue, 19
 Nov 2019 20:15:02 +0100
Subject: Re: coccinelle: adjustments for array.cocci?
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     git@vger.kernel.org
References: <50c77cdc-2b2d-16c8-b413-5eb6a2bae749@web.de>
 <5189f847-1af1-f050-6c72-576a977f6f12@web.de>
 <05ab1110-2115-7886-f890-9983caabc52c@web.de>
 <fd15e721-de74-1a4f-be88-7700d583e2f9@web.de>
 <50b265f0-bcab-d0ec-a714-07e94ceaa508@web.de>
 <f28f5fb8-2814-9df5-faf2-7146ed1a1f4d@web.de>
 <ac67f805-fbff-68e9-214e-3f353a1c038f@web.de>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <9146ab06-944e-307b-b4af-9b0ffbb323f3@web.de>
Date:   Tue, 19 Nov 2019 20:15:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <ac67f805-fbff-68e9-214e-3f353a1c038f@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:mhRlaJcWJ5f/mLAFZWbj6PTniQZwC+296CsR5LOSGpFSMPzhyRA
 lErP2Bhc3gaLJEBenM/Lq1zf4JU/xAzLrvEiEl/kzyCYvBZ/Q6Otd6grOcr4joQSkU+RVYK
 tcVyRb2p6sMYyIm0h+Cz7XZXqLrWA9TJUveCWE42fWL5YMDX6qiH9hsGTkZ5ZMLzNp4wFex
 mrfRw2zV4sCmy12ooYLTw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:0PF45UH8KXM=:dWiF37Y3qUxOFnJZG/fw7N
 i++7wlpEu7/HoQwZx5r7Vrks0aut/A7UY2OJDiWNcEHkdEeaVImQzYvdH1IdzWnOrgYQNogsN
 iPJLyeLLShA2Azb0uPyU6gSAE7vekrp/EQxmWXRJfK8aU0yFMr/MyUUkvYyJZgqImVKoVOHt2
 /ckxBD9owwSEtIJKlzDyNox1pKwxZ7cmXRncgb2BIhg9lLxjiVDeVvrcOioK1MM8Rpms0O1kb
 NhrcNxqp+CY1KQ33g77r6uXq/wvHFTRJwuu+k1ML/VQD1pof9jwifFdfc31/jn+L+OPwhmf4u
 mb4qBCBjDBQpX2883CyAWv2APnJyLx7I2SnhBQiubmBDJiVvPmnOuu8xD6byFCxSTALmHlBtz
 +KDWPgDIUZZBfupsTXGaBwF1fDwnqDewQVEBRMxTqSIIUxXrMeqUUpS/+Q8sH81QZjOHAfG1E
 Tw4IkF6D08itQMN5uSfLttJqQpyEUhZZFpVuJ5uX6ySuSWEv7cQJ27ub0t8NZDQDC7y47Pcvm
 +wmPc4VNY4h+b//gK21Ot1h1kn2c6mHuIGMnykF1Ja5fkTiZUrLJdaRlvnPk1+3KQhv23Vg4s
 KEzOGkLdZbchZhwMGxSgYMkJB4wXRsnaqYzkJJvwWN3cZvSLIAss/qrpAUcOqjMr1NoPRQlD7
 nfekeR2cqI3mCXTSV/MT5xgHhdn4EYnQMRnXr2oK8jk+s6ZusGPO1TxgGQS2W6dN8VWxRoBxP
 8irGD5vVB3Bxn4eeysghEGJjqqkIKTaKoCFvY8AWj641bVx4iEL/utV1VS5wCYYvwrszh4KMT
 emxqLcQ0cnF/s+Q42WBN9Rp9rKD5dZxITNVpC6gc058tJnTwyrN5xiRILKnfFTLS4yuhvITrG
 /E13+CPtMb/jlvvTM1jSSbvIQEJy9cUxTPtBCQflueZfpoNhGSW0rJHtGMhzKCXmcCtR+T+yt
 sS9Koh5kiHQuKHdwKEYNM1MeFpqnkjhPb5zDT0XEP9EFuilVWonR2KXs0uWl67YOJZKGdtAIj
 fNMnXrduWDyHXwndxC+uqykH4GjTvI5trsAJ2HYok+ne8oKRfXFfbRA+7s0oqoKX240wlMCKp
 69J3hkCQEf2JzxaJQHLDLF8Pm6XbQSYhr5Llt6sI0XlPhd+GrqBkDkLxFZx0Qml+i4VDMMsah
 v+7dDz0iHrY3RmpC4+BO1SXPkDHA1e1o5vfQGJeNQk6Uid7XUTF9Iti4mcGwyB5xX9xbW2zUa
 eQgIdi3ql5ABvueoSCTRPghLgXtMGMrnBxu4Uew==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 17.11.19 um 19:36 schrieb Markus Elfring:
>>> It was chosen to transform source code fragments (pointer expressions)
>>> by two SmPL rules so that the search pattern =E2=80=9Csizeof(T)=E2=80=
=9D would work
>>> in the third rule.
>>
>> Ah, right, it would be nice to get rid of those normalization rules,
>> especially the second one.
>
> Thanks for such positive feedback.
>
>
>> I don't see how,
>
> Where is your view too limited at the moment?

I don't know.  Or perhaps it's rather too wide and I worry about
irrelevant details?

>> though, without either causing a combinatorial explosion
>
> Growing combinations can become more interesting, can't they?

Perhaps, but not if they blow up the size of the semantic patch or
the runtime of Coccinelle.

Ren=C3=A9
