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
	by dcvr.yhbt.net (Postfix) with ESMTP id 34B2F1F5A2
	for <e@80x24.org>; Tue, 12 Nov 2019 14:40:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726912AbfKLOkO (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Nov 2019 09:40:14 -0500
Received: from mout.web.de ([217.72.192.78]:40929 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726008AbfKLOkO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Nov 2019 09:40:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1573569607;
        bh=jY41blWHh1RKxgjBzOEM3f4+THflhjT2Go1sJyx2vgE=;
        h=X-UI-Sender-Class:To:From:Subject:Cc:Date;
        b=YnSB9rDZ+PpzuZJKMZ6XIKV9fB8hpW+Kb7weKgsFK5BBbepkH5oL5fZoajiQqG8io
         54wed6RsvzBvxlwVsZApvvYq6eJ/rzUNxVZO7DMG0UU8+zxw/RkjGHCrJskaNk2NaE
         7+q0pDOVGGag07eiY8FdLgOkBFPbvgm/+1PxyBto=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([78.49.102.255]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M6V1T-1hfUK42MAd-00yRKT; Tue, 12
 Nov 2019 15:40:07 +0100
To:     git@vger.kernel.org
From:   Markus Elfring <Markus.Elfring@web.de>
Subject: coccinelle: simplify hashmap.cocci?
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Cc:     Eric Wong <e@80x24.org>, Derrick Stolee <stolee@gmail.com>
Message-ID: <4790d483-bcb8-57f0-5c69-912a814ddade@web.de>
Date:   Tue, 12 Nov 2019 15:40:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:loyCPxsfzWoqf+qeFk90w0Ww11wyTtaiFo+ZfOGHL7QKqfU4I6w
 07hso5u36Ry9eHbooG7WVtdaO1nRzamWqCPrkGPk/44a1rXXzT7oxY/X30E6+0LmsMls2VE
 GLFUPA+Cx9XLnXMgleZmMznrAFTgatL3xMtnHf8RUsiI4Eyve/dQJ4c1fNmfMNslmMsVbUP
 a8TuYRdQ/LePDcOZr0d0Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:MJdDjYabPdk=:yYCkwhxQcDGRLNgxOHKwcZ
 NR4AwHt7/2QBRSQBrp8AGEzbkDrKacqRYqqp7ImM7Hs41a/QnGwahKhF+EFW4uFIgjbQfYAPJ
 jJHHas/omGtRSWmUFa9a4qhPWxCcoO1ujxaa6sr8UpbDUUeM2sMPhLz7Wc7cTJWwGzsEZiX5D
 ULvlZdjLBVc2jaqgSzNVyN4btgyECWnG0VkjmjVlYkkxVcDdx7MO94ySGaB1hvJ4zmBmwZQwo
 u2ryr64/G/YUMudbcEqdgWLbiklc4OxLXk0WOyaEF9u1ikxRIZlnRnZZfoGd3hnbLsYNm5kBx
 5CxC/nQjtlDKLawaoSD80XiMGJGWBJStDOqIDablmvKoH9T8h5IAMvdBGoc+EYDyh5YOXJeMH
 RruC6LpreDEWf9fx25W0q2IWk+DXwTkyBScIRWLBSnrNqHWWAgdpSO8tivJE6SSIjrKn1ESem
 r0wZ1KKOaCDVY5XJJTsLQfB0iyzv/kaoCNcTnc1P1tPIb6qebpp+HplxwfFaJQFBrcJToZy2E
 nPszPlmxKDwCupXOWFQhFtzs+5hsvByP6W6loG6Kj97KYeOJ7hGyFu1pWkdos7Mb15LoGemx1
 hB1UIcIJVq9XSBNribd3gzXADrOzeihbN1G6ii9zcnpjx538Vs58XzGt2R7QiESve+IPbsflP
 SUP+AuBV+6cRAn/e/8IEmfQ9s9chRaYkSbJFndBbWMDpN0dCulCrUxh7KxNRBhdUVwB6fhpkz
 xomONu8Y49AtjNlkM9rIr7wHbNvrQIc7RGdKgM6GPAZn/4KkpxUmr/QirpWJMeLukLKlVdqkq
 uIOEbjEWajRePy+fVTKE1chaWVmKIkKfr1vmdLQimTnQUyZmrYlkOo9ae7cUP7o1D7fIYfgEI
 7hfKzrW0p2r8g8LthwiMwBDfY1ynUwbXpSf80Ts0ONEMa7yGeNpdm+QE0dnJ8eaWB4Y1D9x86
 W25DWgaxafS5j90/2pebra1R3SDRLaL4cCzH642wn6Dp30kevq+P+Yn7w8dmUZH6zLx9f1HCG
 BT/JJ55wuEuYiAqU/fNLQp/5KCnRJ89aawuvormSFFUgDx9YvaxTuxoVl0RWIf+QnuEjPRcQR
 vE/2Wl5cKCu7UlXNNzCWlC87ZywTP/BDiSege+I2ZN/y3htaAKVYshJf4FiLjc1LlYL807vqV
 kKKkl3XvOgZjJopwZlzFPP63CRGorTS0Isu8OPRKkGMXcmWh5KXnMW/p3jWZT2015I15BPn10
 9/v7cLfq4//5OOfF48TuUpZX1q5BKBzM4jwa8IZzkPb3XEWxDez72LGbAivM=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

I would like to comment implementation details from
the commit 12878c83516e3b82f31a20f1b5431b7ff607a8db ("coccicheck: detect h=
ashmap_entry.hash assignment").


1. Would you occasionally like to try a change specification out
   like the following?

-HME.hash =3D
+hashmap_entry_init(&HME,
 E
+)
 ;


2. How do you think about to use a code variant (for the semantic patch la=
nguage)
   which can work without a regular expression for the exclusion of a sing=
le item?

identifier f !=3D hashmap_entry_init;


Regards,
Markus
