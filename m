Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B3243CE79
	for <git@vger.kernel.org>; Fri, 11 Sep 2026 12:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789129524; cv=none; b=ImBoAG7Bz7prG9fgpjDKp7zrfnd0bKFoyY7qild6lIk27ug228ZJqcJ9hhCfCZH7V7qUhyztTijAeQ1zDMBTzcFJDRF3KKZvi/pIE7gQe1B6Ao/4ognyx/+1000ZGMPWYon+IfMcfdtEnhpYWwyHGb/mDbUL5iv18GqP5LAMkp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789129524; c=relaxed/simple;
	bh=RfeOXuI9T0/ebLaWLFu4f5L5uuFlQednZOOnRuxwJZU=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=t1DBCWa4nVUn5/DVRwEdCHMw6OTBgxACo1LQh7+9T0Sy7J/uiYUONqU+JFdfIfIqM9Ob/suOB1Bjt8VGoOba5sADNxWBo55pnHwTKXk545NlJBlfoLItLxKLAP4kpcMS6do79jhyZa5VAqEBpdKilEuMFwMKP0oYoJr9jXcuE4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=UZB/kr3f; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="UZB/kr3f"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1789129509; x=1789734309;
	i=johannes.schindelin@gmx.de;
	bh=OmZMbog4yVm8w8gsBnDjR4AvaALY2JryU7a8rkiFFog=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=UZB/kr3f++h1DFLojfSIyTxfgXHAAMWPfqmCzR7n7cRjFlVE9h4tAQfxnHAd+Hy+
	 hJQeGs67/O1zcTshIpm2N9AEGRKz63R0F8FJPAY/ULO1arqNZdliX2reEaQC5KYki
	 cWX3UVMKn/EO3f/X5f5iqzf3bSi1HxbLpoThmcwwtvOrxuMVI1aep2N9iEQuOY7Dp
	 iSZd0MThRqKpa9vsz7e5tpkmbocS5DDYq1T1MTAz79UZOp1STzdeEGLLTn/IjBMSG
	 dZoRypq3JxnC6WtyvczRrwJv0tcwJ6mWVhSDRh8odB/xJyFeZ4dgNktNjKhtkbS8I
	 Twv/mr5paRgkkCjYqg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N33ET-1whP0y1ImD-00ru6Y; Fri, 11
 Sep 2026 14:25:09 +0200
Date: Fri, 11 Sep 2026 14:25:07 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>, 
    git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH 1/2] rust: pick a GCC-compatible Cargo target under
 MSYS2/MinGW
In-Reply-To: <xmqqy0dkjhjn.fsf@gitster.g>
Message-ID: <040027f8-983b-9c12-5498-330129cd8600@gmx.de>
References: <pull.2213.git.1788272509.gitgitgadget@gmail.com> <2b7f58a037592325c2cb9b52bf8f1ef434bd6202.1788272509.git.gitgitgadget@gmail.com> <xmqqy0dkjhjn.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Provags-ID: V03:K1:Ip4iSWhiG9dYMM7ZB1X4g0Fv9eKzSlnw9qmUIG02bIRx7emQAIC
 8U/zjiMwD6N6zgQaKvND6qEpN26rD59nTW+fYYkiLoljK6is6SwzNr8452v7LQh8ejLs5LI
 56oRo+XNdpjRzTJ0pBlo2arIdFllM9vpNscVRIMG64CLBgDJlLfT3LUJnRTGJeKvNvyBVtY
 /JTA7jg5zvGcIp04tjqjQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ZIKF7jdTz94=;+Qymp4c1FRonq5hO9Sqzd+dqfdN
 EKUZLnOJ2X4c1lKCtlszr6Wtoq2uAVnDaVcr0CtryH34sGZwjhDKfuvz2AXyQmYARN2bpeP2O
 9DR/g2hjwfnvh2y5/kvcHl+hDb7YdxQ/h4sjJFMRQXGXdvIjY66Yg33UsQy8Lo2Wyoo2XjarC
 1VkM4xFuqF+P5CvkIEXz9c1tGal8gCCVdFszzxcyY2SfvhGbPK6pi3AFG/b+Ltxpe9TlzL5Uw
 NpuaQC+2z2LD8fXaMQT/73oaG80gL7pg039KIigB6feOuBSTqS1uqksm375p5SEhJu/v3EMUS
 0QLfwosTPWYCa3yI2UGw52zdD95PhMw0tmEH7Bf3evZzriHcexv4lmVwImvPtwXUNVOW7r+Um
 mwj7yp0FHpcNXV20pZ+yI6pnzJ5S2Ud+RRqckH5iRA/h33RfEFH83bAePhlkcamRb5b3kEBXp
 gDWQGUt6UHrC+G6n+YHjTDaRr5sQoGPlyRjAocVrrFRckTQ5pT4273Ygwya6+V3diFyvjhvQF
 DoG28Co3nQxXMe7dIlknncbog0GeNTCOHdkZ98WtsOt9nwPG9yYHxpWzUruhb91/nU6AgqSN8
 2HuS8bpwUPNCtyDgWN9CR++329uQq9LKcrMdGkWXh1gdMG/R8dq2Dq4P3YzOb6jAEEnlF707W
 zKbWK1TbWFOSYA8m8lVxqU3ZodSlhpoCxtSDyuemQd9WtxGZwJWxKmSQI6ZcwX2DLciLu9rTr
 AlFqcaQ/7lDAAoPKRiEbkoQ0WNfICKtuIL1R1d99RWJwSluphPcT/VelHVQDUk+NTbIl45NJz
 7sm8lGd01Y00JJNpkZeinRnN8moi9z8owompVy9tOwudYA7D6q7jebjGuC0GPQ6Wxg4sE2/WV
 D21SdTSQeekTz0g4t7CZYsGSVnVe+sO56rzu9kIxVDByUj6IFHyCNEtvtuwJynw3vCvMTIpcY
 MlKaofW4wNq/gkaCLJpYoWToYx+lDFIlFpw3WBAyF1K36dA76Oas2lqGOMGaaqSHToEmFZQVE
 m8qNukQo1Tewlo731/dQJxl+k1fnYEI3gpHhHnOgh0nQRb7MWdBSg93/fjVZWLx3Dhc34u3x5
 wyX23/SByMFeRovaJssHgP9Al5X8KswR9hKJz2/7JTesXeYbdCyiigIkRYYBf9BINJT1ZViVV
 eeWjzwuMboioCWK7cFzrC0KIOXBttg13q7GHC7UFU5/I7EfKoWraIW8Z0aezOazqc1RfuiUqf
 MjTvH/1/IUBi8LIQT4TVyrPSPa3hld5OCFhEZGrRs/U6uJUj10rt0K/FuPFmELLKZSOMufAhb
 4MUem1WSzRaVgV+07uF25iTRXLmx2Hkq3Fk/iy25XmrwtvyQD9Z+QPoaDQvbO03zxeurTyk9V
 MYsW9vtHw1xjyloQeiXIB71ij5hD0ieAZUVvN8K3Rux4zQAaT21VwlSNpvcQZTkxwy6FnLf6+
 14Q3IZYQjZNEsUNQV/UVp+R6jdcUYpeLSsDd3HyODzFPH5GMzetsioRrm1LpZbu04trVtW8en
 DZqb3kBlW3CIC1wi+JM/f/RnTEAB0z9AT9JbBodQzncf707hsJv2AtKc2j5xlSsbIYREdOtwF
 iojk0vULO5KR1JEDIAC5sZPvJQXzGhYPyWXDP1T9lyFJsoltcpa0NHB2Wn4CyIK0Ky6t/Y8AI
 iGNJ8JPVPs6KJSmgiAr/BWLe6JrwI5EIjElv4yde9aH0FFTooxJM/KKhSqSNOMfYvcTuoxYII
 /XtPau+KI1tm4L7AYF7eQlm9TNlJ/OnWk+XhJx/nb8Ko/DQpc2cvolJckwpG19oRrBAwEteSd
 l5r6xsKPgFHqSqqRGpL2ZWpogqtblltAD22XJky5JN6MC192HadVIyCosj3eztU8SIQtAm5XL
 bojWQ7NIIdlVwh9UbGQi78uvCHjRdK+zEvUcRlYViapX8U8rfvWpqEeMgfSLRjelxT87qXgGe
 e5wlTmKIhf2Mw0Wdu5cXXOBeAfwZPofdA/ph8mlvg+Zk5aMCVdJQsShwcMJt6nRJy4Raa3BOO
 CAK9XN/Qp26OiEEPpGYQB2VI4TQGe6PpI2D04C+NgfKNrFjw+zXHTn6GuYFgxBNuHJ5Xr6C17
 hR4xq6+sY36QNi5MvTAG/Ar61PjSQZyegFac3uzb/VNit4oQ0rWKn/hd8qWEAZeeIoT/8hN1F
 fAzjYA/mcvhH1vLkaB2pMM4SAb9C39RiGn6XVYXX8egPiothcAUX7ECafK6TqqqbqsRDhkqky
 oyAIO2YPDm0HYe7g8JAN3ud7DY8hAjCIj49FmgwxFuRtU2wLQxkbR6qbaSu5L5Ot5fyTLx7G5
 v1rrSDAFWRd/OvLVGD7tNvgXm2k54vtGBGQXGTzWDh836PP0MBPTySt8KIBWEAC6P8FnYYVsA
 aEPBCIwJg2CSRfBzZCURtqaj5QQYG9yJkSeZAdxVgS5fhRGp9f/rQlUN42w5gDW0WgvIet0y8
 lEu5TXCLbvlwcTL1YDT9+VPfTP6f4/2vTPmhx/sp1/CVr3/6ym0+sDVwARR/EeyGoybSNm88W
 S7JAH17g+vgbRKD7KuWRCLFJLj5F1MWEiS7GMxCC5E2V3a2ICFNxdPL5QGRCSJbxUzQuJKV3D
 0hdrorcraf5GGmXxyBFarXy6mjh/xSVOjWW1b0CemzGRmYOg+gKK7s81JHltr5p0jLye260K4
 RXG9CPOrKZ9TUOV+nUHshxrZFUiIPTgy1ZhdoAmglULQMHtuBHxih0HBzA+zFQLGbHzItHANg
 6NB3jG0BKWIgSNEhzaIZ45FZ7mT4pPqI93rT4Xm2vW4gXvYAHJBsehCOeejOnR3zdP8yS0M4J
 ER+gpz78SjnRqLWocOUg9edIr0lwRy34rZtvV0YwStrtvZ92SuqSprWnipR3N8qFGEZ4QtwR4
 pc1uO2IJuXix2EyXEIDe2CNErzkhQ41W6G9p+ZrexZgv6+vKOaT4BqB5XNYFFivCMBq0ipJXT
 R2jfcHGwPaZwhSXqmdb34Pv5mx0zA5Du7kuC+rIpjbS0NzXqD0LIsdeDPAGDdIq61C5+PELaY
 356T63L5Bbjqo8eL+NO16PrMlRkI6tT33fxQMt78nuQUfN7GcyjilXH3oQB7ZIyCUPauBnY9M
 GcmZ1N0btx9FBWfzqIy1uhIs9AF8YBEsHvtFP8rDnUIqpXu51H1Y1XLKt3TWe2tIhJFyqWdAb
 ozKRycXW6Ny96FkCDLlX7WoRHpSwRhi5mKoOPt/G29AjpqbZBwgLXR+GRiu0DharJttY8rTs0
 4zWecbzyetHF3i7jGi6Im+mRErFFjX05gjJoo4tFxeiAYbZ1/ZC1LQgCio2BeOnndPFNB/I9m
 a8FZC1EYuxgd+9iDUMDwoUJOtl0RHZPIpqlTFyigNNE/3tq8KL//TeiHxyD4Cn3sutMrOGrwy
 vjk8PGbL5h+H5h/+pJgywvzKQ0QGgzX9b9a5m7QOxAP+DmhBtB18UmmWjoBz3QbguMPBVPibR
 kZ1x4gEYBxUEkyYUVdUGlqvalilQmCaG5Ae4HFmoxqbViQ6Xb+aJi3ytk0wOKgUbF2Gr+ekmR
 MZrMcG+09bxDTLJkiGIxg2O/cR0vmwHhlOlPkLXxjMjrZemtXqRd/abc1XpauYG09ZrKhjowD
 iD2RjHLHrCW53F2g3bzVCDb90MazoJqO/r/Tu7zqLG48ssgvTPyHpRf9CC1BwUAAs1H2rHGJl
 tRWm3OEpmL1wpAtkwVdZcjV7jihwpMPdxjzSWtlQgNe32rDk098+GJ1groP5s7tI2TNx2QKV3
 kofDJ0rB/NbIPRQWrkAelPzQAoj75PH6pBROrXqXN86FaxuJi8EblBcX0nANqRxz4EY57io14
 V2Y0Ah6lvBX3/SRGzGMDszmWctDDOM/9TbOTk8w9950jChNEn1sGOBuZjJXwxOcIY67qwDCf2
 yTij02XUuce1fnsGX9gI3VoR1TLm4mQRDUIDkUnDr96fmsWb6cyYLg7pAAapSxCCqQ0VIlbHr
 HE7KvvebHwWvMpwzYR0gXJelI9L69LYlWO8gBlePDjkFUUXVTANUjvOewAAzPVEvxyY+J9NNu
 /pdoT4+FBoMXNSerawcJ3mHVtEQOqViuOBQXY7xXtCLPl3JqP3OxRtEQbI9EQLaIiIm8fhmT7
 uRf+h2ivGUeK1hTFw+ZRZOcNRVcHe7Uo1sLlqpwpTAPPrsiGkV6SAxNRdJpg+II1Sbpt8cmWn
 AcDev8v9Jc/opsyuyyyR1hHXNA0WzMjeuq9Df+0JO3Y9DbJbkU+KNw6uihouiqv5xM8Xq5vT7
 oxZ+98cyP0AC+AEyAJK5UnssPlI8VD63HNG5pt8LwsWWVLxOvfYSxB/LKyz96+Icy6gIwU7Vs
 EnJs5VLL6EceCS867C96pWkWJ/UOhp0i43ebP7xGzJPf5dNTjgfUYUuLrG/+wMWzcCKY339+z
 5B34xakWLp2tUGuh+/nb3FzVbT7kdu4r2t7yq86AJMhtqz7OeUqzu8I8ulH3dlMTLecXzcodo
 gRUzETxiBVgIQSCDDQcKZ77VJWeAKU8FgwtZHpkkXJ8qWtBJBxJmI5yqoNksw/9pxD9R1NLhi
 YTOua8/EoGyQyHp3OtV7+R9ZwbQNmn5ZH0M+J9ntldlsrpufQr5zjT2AGIJSLkcBIvmf/vnO1
 lB2Gqk05LK6t7fLwHAgL5Wnx/U71HBoI5ZnpSPnZNFt9rLOl7GgvVaTDvOJWKAjkSNEwnsfmk
 6bY/GVo5Os3wvUUjxxH4URsjwH/jurU2FHlDdu50rrTA5Q6ekFCIemYDdrsvTfIFLzOqExVVy
 APs6phrMXaFXlBugA9FuI1mth9khA5ia8AmKqinv6qkZvDVIDZejmXMt8k8K6O5kBHuKIPXuu
 3Q/F2iiAZdRumziJf2TIIOq9pAW6ZEoZSeJMdmQjhFGZ3Ik2D7Rwr0cRD7U5VSS4mZD42NCE4
 f9DT2TXCLY55p2R6TNAwUMvZt2MP68yeJH9/aSpUOxgUsMF+o+UxFKNvD2aXFtT+qA4EqLkiZ
 W7PNswY6wu8xiGa2PaHPdA007r8RKHwl8mwVfVwq2A82KZd1CNiAg9ydIpBurO6nUge4PiUbr
 eThSsXg1LJTixse9oEWjT7yA7F+TBFaj0As4ZjQpjRNfslbGKJwY2yMS2eFJdCd5qxcrQhf/7
 sKEROxLLjXj0BVSLmJM3k6oVNHX6kH9lsv0vnUPFMD8fP/1TU6v7goGc4B05kgjuX+hSAT8Co
 7+Oe9RvpC5p6jtICTSjN3mnM+0AqzKjU4jF5LSlgz6C5OplNFJ0ButSxXPEDoLG0Q4Fwldva/
 oLm2XmBmmR4ucSCIDjouyPbQtfc4kjQfoLu7MLSJBjGNZJ9M1moAZIxX+fsYJryy6rMjjQ0oQ
 cjtmiOAwV7yVxqbIU0wflCTPSigwA9iY1tqahPeal9l51HoSl7lcE/gIeHmSfJtXo+ZZouHcq
 DYAL9x85KnePR07rnjzAmKphMBSq/BoLoAJOhfQ6k6AZvYfZkn2tshXV84CVBH/tIJx7oB5Y7
 Rbe6lG33hSDVIztvwjAaG+szs7qUp1TGkfbF6JXKYXTowVwwrbJ/g7MDbuNN9Kc/PBTcCDFSJ
 V+98MLg65fYrw/coWUmd1dKh53cYsWrFi4tFYochAfJoBjh3LOfwfqry+9OUX2E9uSYvuEhAJ
 fEKUCvnrXyAcpiRH9SLFxiQO864RTOIfZ7bWul3egtgHFxVY809lSWJ9/G6NLCg6eZdWsgcnv
 Jlo6ppES+0DVFpympMGano7lu6ogxnMWWKeVSKgS3IU2aaB7kosf0JBPYHBfhEYVL6OZdakVr
 KiRJHtepmo9Wjt9j8kZWNbVpj6dTUT7blFgAhJ7yq/DqhbdweSklBGnJT1R0Yop+wfe63yWLm
 eBdjzQvF5UKMNOcmTQI0rVB9eb+60N+pAj1svHlv8zE18rLwVNi9G6fkM6qe2OyUxsrVe4dO2
 G8SQ2d8Tezg1zxDO55mPlHLg5FMGHPjnYkjG+XyLv035o5ufVlalXMj8CG7CYlaweg9u8kaeb
 lXgyQWErPZtZrOQJjafqPM0wnxc7QfURMI4lC/kBhPkx5Dw7uBPSORex0d7yNHW+1Kt15UeQW
 4PRJezMQT+XrbCC7aVJNiwzGcyVcN6x5VXWcriyrg3NaczulKTCnNWXdvCg0XSazeIChXyGTU
 bniFWu+9KNZEYHroKIsN/c50Y2Ks6eNi+jFiDBGM0ARe4juSY4Cea70pMTqgfOiXEKb6+yIWE
 dOl8C8dtHeLIE6ZPEUO8X83mmXZD/vKkApQso7rcurHeMMfNerqiQkbwlnlU5mOon1h4Iz/mN
 nr75iBzYOMJvN2g9wFs2hY09bAHKK3BAraBphvpXi28RE5sCKuW1s+0BBXJDen988R9mfpGb9
 S5/5q4+2dj/vKcdFQpXaG16a0QIobMPkpCw==
Content-Transfer-Encoding: quoted-printable

Hi Junio,

On Tue, 1 Sep 2026, Junio C Hamano wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>=20
> > +                ifneq (,$(filter %ARM64, $(MSYSTEM)))
> > +			HOST_CPU =3D aarch64
> > +                else ifneq (,$(filter %32, $(MSYSTEM)))
> > +			HOST_CPU =3D i686
> > +                else
> > +			HOST_CPU =3D x86_64
> > +                endif
> > +                ifneq (,$(filter CLANG%, $(MSYSTEM)))
> > +			CARGO_TARGET =3D $(HOST_CPU)-pc-windows-gnullvm
> > +                else
> > +			CARGO_TARGET =3D $(HOST_CPU)-pc-windows-gnu
> > +                endif
>=20
> Assuming HOST_CPU is x86_64 in the above, as UCRT64, unlike
> CLANG{ARM64,64,32}, does not match CLANG%, I presume that the above
> gives "x86_64-pc-windows-gnu" to builds with MSYSTEM set to UCRT64.

Correct.

> There is this "we only need MINGW64 but the switch to UCRT64 is
> imminent, and others are for documentation" part we see in the
> [PATCH 2/2]
>=20
> +        case "$MSYSTEM" in
> +        CLANGARM64) target=3Daarch64-pc-windows-gnullvm ;;
> +        CLANG64)    target=3Dx86_64-pc-windows-gnullvm  ;;
> +        CLANG32)    target=3Di686-pc-windows-gnullvm    ;;
> +        UCRT64)     target=3Dx86_64-pc-windows-gnullvm  ;;
> +        MINGW64)    target=3Dx86_64-pc-windows-gnu      ;;
> +        MINGW32)    target=3Di686-pc-windows-gnu        ;;
> +        *) echo "::error::Unsupported MSYSTEM: $MSYSTEM"; exit 1 ;;
> +        esac &&
> +        rustup target add "$target" &&
>=20
> that maps UCRT64 to "x86_64-pc-windows-gnullvm"
>=20
> I do not know if it is intended.  If so, please ignore.

Since UCRT64 is still using GCC, it should be `-gnu`. Thanks for catching.

Ciao,
Johannes
