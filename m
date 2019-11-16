Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3509B1F4B5
	for <e@80x24.org>; Sat, 16 Nov 2019 18:29:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727693AbfKPS3i (ORCPT <rfc822;e@80x24.org>);
        Sat, 16 Nov 2019 13:29:38 -0500
Received: from mout.web.de ([212.227.17.12]:42321 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726632AbfKPS3h (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Nov 2019 13:29:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1573928970;
        bh=nX1scGit50bhUMatVwb2CTFyg+wGChbojEacdjAzOL4=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=M8xF4zikpsPvxCsMKHTu8PzDmvPsqIaA8dXf5nXG6sCKuZN/fl6i/f7qZS4Wv5o5O
         rXToFlx8K/c3bUMQWLaEp27I9/UHErPZb6RMkjwwJHjIbxODhsnzzV8jfeGdYZ87A0
         3LJHYM6nsfV6VcN+sgW1+0HKMV2EaWbfo77BnxZE=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([2.243.152.34]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MUWBb-1iO2Uz20xf-00RLz0; Sat, 16
 Nov 2019 19:29:30 +0100
Subject: Re: [Cocci] git-coccinelle: adjustments for array.cocci?
To:     Julia Lawall <julia.lawall@lip6.fr>
Cc:     Coccinelle <cocci@systeme.lip6.fr>,
        =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <50c77cdc-2b2d-16c8-b413-5eb6a2bae749@web.de>
 <5189f847-1af1-f050-6c72-576a977f6f12@web.de>
 <xmqqa790cyp1.fsf@gitster-ct.c.googlers.com>
 <fe9b8c08-6fd4-d378-f3ff-8170381b10e0@web.de>
 <xmqqr22b9ptk.fsf@gitster-ct.c.googlers.com>
 <ba5d609a-16ea-d7e9-66e6-19aab94b2acd@web.de>
 <53346d52-e096-c651-f70a-ce6ca4d82ff9@web.de>
 <6c4ef61f-5fef-ffc8-82d6-ee42006756b4@web.de>
 <aed296a6-bae0-6fcc-515e-ef96fed24ca6@web.de>
 <6fffd13a-738b-e750-9f5a-f0bfb252855b@web.de>
 <alpine.DEB.2.21.1911161855400.3558@hadrien>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <d232b052-430c-5d44-96d5-b8bff261314d@web.de>
Date:   Sat, 16 Nov 2019 19:29:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1911161855400.3558@hadrien>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:q4tKmDEWr4OgdsfS+Gh0dJw5vKE1TfWyByZ4uOs8VuPmnDz+ClX
 CJQUe5DTDQBuKqa53Hpfi1WKexuKGlS3ebEBA5Wxn4xlRsksaRmoTj8Vdh719lJC6tE1c/l
 LMVOrsrMjegjdWam3ZnIn+SxgqMxl66Pak5NMdg7ugJNNO1pPyNHOmPCOOZFbDDq/qmtM76
 8LizeegnqYY0HXypvpBhQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:39BWwZL4RgA=:CosSa8e9Vqk9ZWYZ6oQrnM
 CmLCb3N9UHbLbwCpMj7aJDXiiFjC2rvSPEQZf2gGc+hkE0YCWkGaTpbf0SZMLLRNFlfeCdKaS
 8eCn5Y8VIXY4IovCDSH1gSAZniWaVNb/AkB6KdT4mVbVxrkL9Rimuf/gqkKWdavRNhf3j8E6G
 LpbCczWizRrakB+ORrzCaPIQjaKh1gH7+NTrWiyM0M/Xou6WEHizjarJZjHCN5xElhNAC2vL+
 pAsrjO0kH0sLjzk6qYvG8gxKPSzPq9XH0xysfPHVwPWzvLoWPVcPpCQPpGVs8a2S2CEfVEcMa
 4+KnMQyoq76wX78pLc+qCp0wNUUzNDrfHDd2VJuS9+hIDkqibRByMn5Jyba0WgH/AtmZebS2F
 0Bt9ZpigdMRzir5Gs51u2CapJOaxnR/MOETmyMTFCi4CoQhsChf3Hc2pc854GhQXpNJB+CCfy
 The1+sOMOVJQTjsgCSaKI7TjePIcxN7e9d2daYGRrN9WbpU4Ra56sDvaa3YFT/xpG9JNiFaOx
 V6iQkRJlRcRwPEAMyY4g10gjDrDyvRwG3xKph8oCgy6+QOfk+IKqoE83oqyWefDQ1ZggAvHrm
 2mpH/py0TgAiYN/p1dBoeeUvrOmNMtVwEHMVK+PXwPX+u8HXi7XwkmDwSsdR7oSQlNQV+FJBs
 LH6C8HkXYqKtyficSEFXEjuv9d+dJYTPSK6aT1oBtnvm7l70TpuEJiOhKTFE5l70e2T1jipER
 sw+IQRFRjIqR0s93I/ZagfSuXB0IP+JDmG7nBtdAnayS6BqPao6Stjn1h0Hb10aQUbyBKDKxk
 kNJjSFcL/b6V2oIz7Icd5jjInV89gE74kPHT9y38mIBoL7+PHwE3iXQ+/MfdcJ65GyYlWg9j2
 udINy5+tYfQvRGh5uMoU15TUAj2EqMHRzgg+ESEZ/IJF3LugP7Z98Msc7umlgVPNEf+NyHjgg
 YR56qfqjII7Groc14jQL8+Igz1Xkwg9HWvIG1djcb3pg40AiCci0X+qBCO6xMFCoIgg89y4+c
 ubCY0figpIIH8cabVNtsvDyKu9BX0xuoDBJ6UJQJ+ZIPrlFSN0VT/XHTXW8YgBAsM0lLeha7f
 6+bUUYL8weKG1zqtZIgTwNvPG0V4ZheIJcm82giAc1f7cRN9qu3ZW4Ksg3elCrEH5jNEJcWIx
 GDRRe9vkbTk0UvdqT1z8KBbFt5btezyZCxb05L1uqVJa5Omdd73qtygqXYKxzlCV9kO24fkn3
 nxg+7jACOA6a6c7vpxOgUEwSAoosuhEY4fv26aaKNrPm8smPLcwhJ2MJE36k=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>> + memcpy(
>> +(       ptr, E, n *
>> +-       sizeof(*(ptr))
>> ++       sizeof(T)
>> +|       arr, E, n *
>> +-       sizeof(*(arr))
>> ++       sizeof(T)
>> +|       E, ptr, n *
>> +-       sizeof(*(ptr))
>> ++       sizeof(T)
>> +|       E, arr, n *
>> +-       sizeof(*(arr))
>> ++       sizeof(T)
>>  )
>> +       )
>
> This seems quite unreadable, in contrast to the original code.

The code formatting can vary for improved applications of SmPL disjunction=
s.

See also related update suggestions:
* https://public-inbox.org/git/05ab1110-2115-7886-f890-9983caabc52c@web.de=
/
* https://public-inbox.org/git/75b9417b-14a7-c9c6-25eb-f6e05f340376@web.de=
/


>> 5. I stored another generated patch based on the adjusted SmPL script.
>
> No idea what it means to store a patch.

I put the output from the program =E2=80=9Cspatch=E2=80=9D into a text fil=
e like =E2=80=9Carray-reduced1.diff=E2=80=9D
in a selected directory.


>> 6. I performed a corresponding file comparison.
>>
>> --- array-released.diff	2019-11-14 21:29:11.020576916 +0100
>> +++ array-reduced1.diff	2019-11-14 21:45:58.931956527 +0100
>> @@ -6,24 +6,10 @@
>>   	r->entry_count =3D t->entry_count;
>>   	r->delta_depth =3D t->delta_depth;
>>  -	memcpy(r->entries,t->entries,t->entry_count*sizeof(t->entries[0]));
>> -+	COPY_ARRAY(r->entries, t->entries, t->entry_count);
>> ++	memcpy(r->entries,t->entries,t->entry_count*sizeof(*(t->entries)));
>>   	release_tree_content(t);
>>   	return r;
>>   }
>
> I have no idea what is being compared here.

I suggest to take another look at the described steps then.


> The COPY_ARRAY thing looks nice, but doesn't seem to have anything to do
> with your semantic patch.

I find your interpretation of the presented software situation questionabl=
e.

* I got the impression in the meantime that my suggestion for a refactorin=
g
  of a specific SmPL disjunction influenced transformation results for
  a subsequent SmPL rule in unexpected ways.

* Other software adjustments and solution variants can trigger further
  development considerations, can't they?

Regards,
Markus
