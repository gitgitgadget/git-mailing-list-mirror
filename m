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
	by dcvr.yhbt.net (Postfix) with ESMTP id EF99D1F4B5
	for <e@80x24.org>; Sat, 16 Nov 2019 06:57:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726511AbfKPG5p (ORCPT <rfc822;e@80x24.org>);
        Sat, 16 Nov 2019 01:57:45 -0500
Received: from mout.web.de ([212.227.17.11]:47545 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725971AbfKPG5o (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Nov 2019 01:57:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1573887454;
        bh=KV2y7lQmczegNmolR7TPvBQzIHlCgNwTe7wlClRI8iw=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=JCsrTu0lJ5JUC0pVfz8GGob4Ab+aY3Qs+0xHmExp9XmoCap+Bd5+mFDrnZgGl4DCa
         SsSfD6G9+GVpgydPSjR382ficj+T+voB+oUnmgGnYPvoKBpDfcC/mfCTTjuLejp8B6
         LHX8Uxr/Z5nSMA1vL4uF3JhjuF+zSOegkKc7LboY=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([2.243.152.34]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MXpZD-1iPd0r2WX9-00WpNt; Sat, 16
 Nov 2019 07:57:34 +0100
Subject: Re: [Cocci] git-coccinelle: adjustments for array.cocci?
To:     Julia Lawall <julia.lawall@lip6.fr>
Cc:     Coccinelle <cocci@systeme.lip6.fr>, git@vger.kernel.org,
        =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        Junio C Hamano <gitster@pobox.com>
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
 <94301b9c-a397-ae04-c617-92679f4bb018@web.de>
 <alpine.DEB.2.21.1911152000170.8961@hadrien>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <4ee4604e-0eb1-d4a6-24bb-52abe0db3f53@web.de>
Date:   Sat, 16 Nov 2019 07:57:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1911152000170.8961@hadrien>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:r7KU41s1og7jBKHqcTTJ+wWqbzKphPCpPMpdogNT3BIbclyk6KS
 +On3kC3vwo2sxxtZl3e9TFeNJzSmCCSBDltAwjvI50TmQerh0PTgen8sQYaGRLoaZpPDJSS
 fdh8wCSuSuvOJAcAGm5YmUz+1yBROY7V4g3cOStbQlj/wZu+8iK1WRDtWzdKnVX3bjXvmVc
 1Z4RmqobpYv0g1/VQo6+g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:xn/xx9/PIJ0=:xvgayptfIPYY5rZ6AaaMgY
 O0w+X+tFDX/dIq9051QMezguUKIClFglCZmtHQsXMDnJw4BjQBlr3Ial9C2E40iB44FlP/BvA
 Vfet84PRNw0JjFgWvcBN//cSJA18NXWn/dZ80xdqQbzfjNa1aEAS22IudiN0CNwQTp3FLkkD6
 In0vvGdzkGDS0T7dAvxHMJNOBBTmWJHk2Dl6o3Wyq5CDDSQa2GSy448rRreL0JSaiGnNSckIS
 S0ANWoqN8eaFfW+xi1p1dOSEDOPe7tz9uYcOfHN1nUaPjSUH8usC358fraZ5l6EyZVKEcvK6S
 DM/VPse3MwuLck0LhNs0EMCYJhNf4ucBPkXVqnb7xyDrZpUThAxv80wSWTevsB4SMz7QUxZh4
 iBpOXjIOqkrLJ7sSOE/2QtLEhV4ngsVa1Veilq2Uj9aVS8Y+F0jIoHZvtc6nOjMLqnb+Cz79x
 79TCaKOGB/TsIID9b3Dq9vStU4E6HwepzDOqrqFeK1tIISJxzXrmBalFZUBS0v4I2SNrzJ/s+
 d4QfoE2GDB/u5Ozhmovectjk/WsoBYcBBvW+Nl3g0oTBDpsdFLEeuq5SFaJuZpX1kXP89Xb/Z
 5S8nBg81B7k2koVpWNS26MYd75CAYbyye+k32fyWHckISBqUuuw/yc7iH1EW683ZyJCwLiYSn
 rM6UIUxCFTMEGchqvABkx9e3QRCRa2aQUXbO3XgYTZIauWt3NoEKoV2+ikt9Aq6JMj9MYHvD0
 foiRT2JF+b8/FniWYApAehpFDrc2a/S6g/8xtyhr0xqYIvBjYD66Qb/fgu8NRkEJ65WWOX5BS
 Xxfmb7zkCDOOThonlu/zM5gsdd6WV28V0nOqoDC3RZqm15yPY+wVRivIiGZhFoyMj8lRK2LLg
 yRw1RDwglcdxTT5JtYkW8YYNi5qDd+jMwdHu1H++9sqDALi+3lrLvE15bccfpWs0y5zJxJrJy
 hGjX4LN4mJ0IZEsG5eTEnT61NnOBU8yntQu+FQiGqIexzAOeSIwChTKKmnYvPjf9JtuSiB0hv
 d8g+OiZ6m+XxctQeP6EO7lneSI3++zoP99S7ezq96ovFvhQO365jIQLb/ULLlRdf31HkXlfR4
 wOZitpX9qKBS0xWQPS77egSnWIVUy/Imp11WaLYIoEoesugWDrRPINNbkLrpjwFQ8hq5gYY8a
 uwUHiZmuEOM7dNhjg3BfmmVf+3K6Lqy6szjDYOQjFKSu6oCFjmTdPAViNPOpY0O82AqtmsOtQ
 na5DSvs6lGIoH1jszJq2+hhzUO05di0yfbY8hzz5cfNyQJZanhuBuCcikTEQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>> https://github.com/git/git/blob/3edfcc65fdfc708c1c8f1d314885eecf9beb9b6=
7/fast-import.c#L640
>>
>> I got the impression that the Coccinelle software is occasionally able
>> to determine from the search specification =E2=80=9Csizeof(T)=E2=80=9D =
the corresponding
>> data type for code like =E2=80=9C*(t->entries)=E2=80=9D.
>
> It can determine the type of t->entries if it has access to the definiti=
on
> of the type of t.

Should this type determination always work here because the data structure
=E2=80=9Ctree_content=E2=80=9D for the parameter =E2=80=9Ct=E2=80=9D of th=
e function =E2=80=9Cgrow_tree_content=E2=80=9D
is defined in the same source file?
https://github.com/git/git/blob/3edfcc65fdfc708c1c8f1d314885eecf9beb9b67/f=
ast-import.c#L85


>                    This type may be in a header file.  If you want
> Coccinelle to be able to find this information you can use the option
> --all-includes or --recursive-includes.  It will be more efficient with
> the option --include-headers-for-types.

Such information can be more helpful in other situations than the mentione=
d
test case.


>> But it seems that there are circumstances to consider where the desired
>> data type was not automatically determined.

Would you like to take the presented differences from the discussed
before/after comparison better into account?

Regards,
Markus
