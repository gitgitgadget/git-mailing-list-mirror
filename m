Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B9F391F87F
	for <e@80x24.org>; Mon, 19 Nov 2018 14:58:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729644AbeKTBWH (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Nov 2018 20:22:07 -0500
Received: from mta-01.yadro.com ([89.207.88.251]:42874 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729376AbeKTBWG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Nov 2018 20:22:06 -0500
X-Greylist: delayed 444 seconds by postgrey-1.27 at vger.kernel.org; Mon, 19 Nov 2018 20:22:05 EST
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id F055D41868
        for <git@vger.kernel.org>; Mon, 19 Nov 2018 14:50:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        content-type:content-type:mime-version:user-agent:date:date
        :message-id:subject:subject:from:from:received:received
        :received; s=mta-01; t=1542639050; x=1544453451; bh=V8YG0Rf8NeTO
        /Pj3aWFJqSfAvW+amxBdfegGA4sj7ac=; b=tBs+e80eDE5VI/S2d+vCKuTW+7wW
        xWNITl5/m8CrY0iktI/3TcCLQBfXDr6uo8XYqYIcJfe1mmKk6EXIRzu/kRbXSsIu
        13s47mxLFsI0Wrjna7e/ZLZaJ8qJLQLxT36pdKhh6Q1bli8y/XAr2bK31GZW0kY3
        gfrbJ63pQt1D+M0=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id o7T3EAz4J_c4 for <git@vger.kernel.org>;
        Mon, 19 Nov 2018 17:50:50 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com [172.17.10.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id 00D60404CB
        for <git@vger.kernel.org>; Mon, 19 Nov 2018 17:50:50 +0300 (MSK)
Received: from [172.17.14.197] (172.17.14.197) by T-EXCH-02.corp.yadro.com
 (172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Mon, 19
 Nov 2018 17:50:49 +0300
To:     <git@vger.kernel.org>
From:   Alexander Amelkin <a.amelkin@yadro.com>
Subject: Strange behavior of `git describe`
Openpgp: preference=signencrypt
Autocrypt: addr=a.amelkin@yadro.com; prefer-encrypt=mutual; keydata=
 xsFNBFj0jdkBEADhQF4vZuu9vFfzxchRQtU/ys62Z13HTaYK/VCQKzPnm2mf593Il61FP9WV
 0Srt4t4yumiXK7NhHeqktN/YZjYDYVr9l+vZpNydOHpDjk7xjPgb0KkoFCo7bcQ2/e4AtLTQ
 XGoWIKv983vWlphPCG1Jof5jH3RA7mccCNXtGlzVYF0RYR0/qKGgsoBymkldNKPwgPf/3SXb
 QY5V3sJ5SHwDjmhg3MYnblV29OULdi72DKI9MkhTTHQFlA++CfYstx/cZ1BZwWmoMgi0umpj
 Pf+5mAkmTtlPW7U54EUgFpvTMfxRRS7yH+iTlvngduYW6jryt0zm6r7M2LGR+uWGSTmWBB7Y
 t06D0Xrm0Zwl4alQ5WDrlUTkzZcXDb0QqY7UkQSkghLmUjItEj4Z+ay7ynIsfjQe0OYdTofh
 dY0IUxMxNm9jeckOkRpSdgsQrTcKIOAt/8jI62jlzN1EXA6blhASv5xtt7I1WXCpDU+mpfKf
 ccUVJfmd0Q2nlG64L4Bv8o+iBI0Xu5+EX2NzDKQF5vSQIK8mwniAPT16hi80mZG9EQf0fJ1C
 p7xJGvwA6IiwXWsAqhNRhYbmNDfiR2MMxw5DFdQSeqoK3ONeeIwrJAPNdme+Z1DoT2+ZuZP0
 nfUa8e2QaMHkXwCz9e0cI2NUmAwFJ9Qg4L0eyhdZP4rQ1KCg/QARAQABzSxBbGV4YW5kZXIg
 QW1lbGtpbiA8YWxleGFuZGVyQGFtZWxraW4ubXNrLnJ1PsLBgAQTAQgAKgIbAwULCQgHAgYV
 CAkKCwIEFgIDAQIeAQIXgAIZAQUCWmWolAUJcjFDNwAKCRDok1h7W3QXjXyOEACUv6oDO7Vn
 KnDTUypYhyTVi8C+fjlHTH+AIDP4qk6nXjMIJeh0P7rQCHAOIOCW9osy/urYQ5at90eUolDV
 udMe5+sSvKRHYksu74O+4XedE2TDFJnntnz0JIeyuaH4FVRDX5i2hlK6wx2D06wTJj4JONlW
 c1aLULPKfrCbMbpNlD9s/+48RkCj77kl30nJ+56ThEMkSgomMIL9XMesNnQAa83Y55mJhx1f
 n3Gz7kH6nxLPPgLWgKXebAgM6ltJAjaCIWxZYlJK5dQmQC5N7PR0kXdnHttSx89ldgPacpX7
 V39dBMoURY/+YtMU7VKUNVW/IXkwXT7m42QoxO3H+HNHRVfDtELy2l6fBCf0ShXs4b3AF654
 aRJrwQX1Za3mg6OXTmAVDEerqOBht5XZl2Y/FyxV1Tka2SarkYrNVjD3YXODnmF3GfAuP8Jk
 F8uYvQyXpLMpThnUPjs+Vl1NC1exh2mrM+7kxGXPKhrFWxX7tduAJpULpdCk4mefO9/U7I8/
 Edf5giE1o9yhECZ71lzmA7p7bLDv54Qfu4WAVndUgHLHCH7uUsKf3cds/gLtpuTrHB83nvvh
 LKZ6+kYnn5pK89hkia0EbpOrTrqBqphMyxFb7WFapXip7kRaqUdMOqdRO+JHG3rFAhz7sl/0
 DPWSea7WGLe0TNySCQ4GdytKLs7BTQRY9I3ZARAAygmVNgjvxkqud75kP5fwhmwMVu13sLh8
 QnZxjMsA9Zelt1Hu+BVmjET7YL4xBhdJDZ4y3UI/MV8ZzOfJHUWSNr6POwKIrsQfGzdlgB0e
 w2k6Rm651Jp+aAsygB4GR7BopptJd9d/q5oCnZxpPgDpZOBCpl4DQ3fJIGSc8iQVmA84lHLS
 +mqIJ94PZ7uza4F0ly6Au+Hbkhowh/1q+BUd6Rn553WAmPAG7g0lAG/Obq1m77ovlR86yY5i
 C503QKlPJELSNYtzczuLQZetjDtaFkugke4QMlhzHyc7DjSsjyccdhepPtXWEm84jPCx1/KU
 3m9jAWtPdARQ73su/fiitmXAifQXJBB2R9fmKuM2F3ClHcJxv/l0W1ruekD9vojOO75yvBEG
 7fGlLc9hUgIIGgBJvI+Yb1/KhqWC9r53TS6kcuCi+z9kf+4MTBge2sU97DtivZGzul6yhrcr
 3Ic5paWoaka2ClGqKBQo3A9o4F60q3rRq5FAcMdKQq7qJutCzcjkcCpVVik1im0u0+UGrK0s
 YQuAgTu45mJPOfINqz1xz+qwxSjYI/wjxJaYTZLO68CIdBiDj+zxIeo9o/mUJvS+DhnPzKhW
 KXToZl2D7VdjOlu8zZ0tIFYrULJYhuw2f/KwD1lwoehlKikEE0H0xkPygufjtiYo6jTb+BKa
 sG8AEQEAAcLBZQQYAQgADwIbDAUCWmWo6AUJcjFDNwAKCRDok1h7W3QXjc9vEADXse2POSaT
 M0uqR3KGTeF8XVKdyRqK9afWbMaxFzOWGp9pNtcmIvfmyE0M6LPLgUb33jek/Ngup/RN7CjZ
 NCjOc2HTID99uBkYyLEcOYb+bycAReswjrv3a49ZBmmGKJZ+aAm0t6Zo6ekTdUtvlIrVYvRs
 UWWj4HdCaD+BMvSqcDZgyQESLI9nfEGuWtVqdi2QlZZeQT7W+RH4lihHKTdzOsVC93o4h6og
 ZvgOJ/0g1SP3la88RWONejHxVbGzBOyNjkH71CFujnAfuVuuhkJaN8PY/CS56sKMREKJOy0L
 vouE7eSU4bp13GK1xsnbWcDQpyzTsCsP9taqQmeld8Hw1yuPamc6fdpKNyPHyN20vzh20f0C
 QUMAjh3Vym12aKhyRan08VNEaLOKiyya6+i9c3Z3LiWUEqTSzELCkesb68UQVtE6/CXPM2P/
 vs3EQuLFXBC/rD9lurT0kG99xElAbKjHLer5NSw2WA2vQXaFadGNDyHI32Yt2cAqWzZtVqmN
 ESE0npJ5eeAcVWPHjhCwL8phZCDtfxJMy2cqYS8QLIBGfQTIHMQAgqBbpq9FLXCn008tvaTr
 KijxDkPtWeXDLbMgH1kA46gTPJWxsm0c45w7c3aXhXl4hOgXp+iWDTOT83tJU0zoD9hYlpZf
 dTYsE5wSxM06T2l/MILupCNZ7A==
Message-ID: <7bb76527-dc12-19e5-65ea-7a11e0c398a6@yadro.com>
Date:   Mon, 19 Nov 2018 17:50:49 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature";
        boundary="JD2blRXwEqcIQmmdEZemL6fRQgsXEzVS4"
X-Originating-IP: [172.17.14.197]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-02.corp.yadro.com (172.17.10.102)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--JD2blRXwEqcIQmmdEZemL6fRQgsXEzVS4
Content-Type: multipart/mixed; boundary="Xk6TzA3fKyMh8oVqtsio337JekBAuwvTr";
 protected-headers="v1"
From: Alexander Amelkin <a.amelkin@yadro.com>
To: git@vger.kernel.org
Message-ID: <7bb76527-dc12-19e5-65ea-7a11e0c398a6@yadro.com>
Subject: Strange behavior of `git describe`

--Xk6TzA3fKyMh8oVqtsio337JekBAuwvTr
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64
Content-Language: en-US

SGkgYWxsIQoKV2UncmUgb2JzZXJ2aW5nIGEgc3RyYW5nZSBiZWhhdmlvciBvZiBnaXQgZGVz
Y3JpYmUuIFdlIGhhdmUgYSBsb2NhbCBmb3JrIG9mIGFuIG9wZW4tc291cmNlIGdpdGh1Yi5j
b20vb3BlbmJtYy9vcGVuYm1jIHJlcG9zaXRvcnkuIFRoZSBsb2NhbCBmb3JrIGhhcyBzb21l
IGV4dHJhIGNvbW1pdHMgYW5kIHdlIG1lcmdlIGZyb20gdXBzdHJlYW0gb24gYSByZWd1bGFy
IGJhc2lzLiBVbnRpbCB0b2RheSBpdCBhbGwgd29ya2VkIGZpbmUsIHRoZSBsYXN0IG1lcmdl
IHdhcyBmcm9tIHVwc3RyZWFtIGNvbW1pdCBiMWI4Zjc3IGFuZCBgZ2l0IGRlc2NyaWJlYCB3
YXMgc2hvd2luZyB0aGUgY29ycmVjdCBpbmZvIGJhc2VkIG9uIGB2Mi4zYCB0YWcgYWRkZWQg
d2l0aCBjb21taXQgYWQzNTIxOToKCmBgYAokIGdpdCBsb2cgLS1vbmVsaW5lIC0tZGVjb3Jh
dGU9c2hvcnQgLS1ncmFwaAoqwqDCoCBmMGYwMTMzNGYgKEhFQUQpIE1lcmdlIHJlbW90ZS10
cmFja2luZyBicmFuY2ggJ3Vwc3RyZWFtL21hc3RlcicKfFzCoAp8ICogYjFiOGY3NzA1IHBo
b3NwaG9yLWxvZ2dpbmc6IHNyY3JldiBidW1wIGY4ZDM4YmJlYmUuLjMwMDQ3YmY5NjQKfCAq
IDBhODQ4Zjg0ZCBlbnRpdHktbWFuYWdlcjogc3JjcmV2IGJ1bXAgOGNhNzA4Njg5Zi4uZDUz
NGY3NDMzZAp8ICogN2UxNjA5MGNkIGdvb2dsZS1pcG1pLXN5czogc3JjcmV2IGJ1bXAgM2Vi
ZjJkZDUyNC4uZmY0MGYyNzNhNwp8ICogOWI3ZGNjODA3IGdvb2dsZS1pcG1pLWkyYzogc3Jj
cmV2IGJ1bXAgMzhlOGM2ZTE3MC4uYWQwNTcwM2NlMAouLi4KfCAqIGFkMzUyMTljZCAodGFn
OiB2Mi4zKSBVcGRhdGUgYm1jd2ViIHRvIGxhdGVzdAouLi4KJAokIGdpdCBkZXNjcmliZSAt
LWRlYnVnCnNlYXJjaGluZyB0byBkZXNjcmliZSBIRUFECmZpbmlzaGVkIHNlYXJjaCBhdCBl
Yjg2NDQ3NDJiMjJhNzdmNDBlNmNmZTlmM2QzMjVlOTJhNjAyZGVmCsKgYW5ub3RhdGVkwqDC
oMKgwqDCoMKgIDE2MDEgdjIuMwrCoGFubm90YXRlZMKgwqDCoMKgwqDCoCAxOTY1IHYyLjIK
wqBhbm5vdGF0ZWTCoMKgwqDCoMKgwqAgMjQxNiB2Mi4xCsKgYW5ub3RhdGVkwqDCoMKgwqDC
oMKgIDI2MzcgdjIuMArCoGFubm90YXRlZMKgwqDCoMKgwqDCoCAyODk5IHYxLjk5LjEwCnRy
YXZlcnNlZCAyOTc0IGNvbW1pdHMKdjIuMy0xNjAxLWdmMGYwMTMzCiQKYGBgCgpTaW5jZSB0
aGF0IHBvaW50IHRoZXJlIGhhdmUgYmVlbiBzb21lIGNvbW1pdHMgYm90aCB0byB0aGUgdXBz
dHJlYW0gYW5kIHRvIG91ciBsb2NhbCBmb3JrLiBOb3cgYXMgd2UndmUgbWVyZ2VkIGFnYWlu
IGZyb20gdXBzdHJlYW0sIHdlJ3JlIHNlZWluZyBzb21ldGhpbmcgc3RyYW5nZS4gVGhlIGxh
dGVzdCAodGltZXN0YW1wLXdpc2UpIGNvbW1pdCBiZWZvcmUgdGhlIG1lcmdlIHdhcyB0byB0
aGUgdXBzdHJlYW0gYW5kIGl0IHdhcyB0YWdnZWQgYHYyLjRgIChhbm5vdGF0ZWQpOgoKYGBg
CiQgZ2l0IGxvZyAtLW9uZWxpbmUgLS1kZWNvcmF0ZT1zaG9ydCAtLWdyYXBoIHVwc3RyZWFt
L21hc3RlcgoqIGM3MWJjZGMwMSAodGFnOiB2Mi40LCB1cHN0cmVhbS9tYXN0ZXIsIHVwc3Ry
ZWFtL0hFQUQsIHVwc3RyZWFtKSBwaG9zcGhvci13ZWJ1aTogc3JjcmV2IGJ1bXAgMWNjNzAy
MWM5ZS4uYmM1Y2M3Zjc1YwoqIDNkYjc4MjBlNiBza2lib290OiBCdW1wIHRvIDYuMC4xMwoq
IDVhOTYzYjIzMSBsaW51eC1hc3BlZWQ6IE1vdmUgdG8gNC4xOC4xNgoqIDM2YTQ5ZTJkNyBB
ZGQgRW50aXR5IE1hbmFnZXIgdG8gRmFjZWJvb2sgVGlvZ2FwYXNzCmBgYAoKT3VyIGxvY2Fs
IGZvcmsgYWZ0ZXIgbWVyZ2luZyBsb29rcyBsaWtlIHRoaXM6CgpgYGAKJCBnaXQgbWVyZ2Ug
dXBzdHJlYW0vbWFzdGVyCk1lcmdlIG1hZGUgYnkgdGhlICdyZWN1cnNpdmUnIHN0cmF0ZWd5
LgrCoG1ldGEtYXNwZWVkL3JlY2lwZXMta2VybmVsL2xpbnV4L2xpbnV4LWFzcGVlZF9naXQu
YmLCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgfMKgIDQgKystLQrCoG1ldGEtZmFjZWJvb2svbWV0YS10aW9nYXBhc3MvY29uZi9tYWNo
aW5lL3Rpb2dhcGFzcy5jb25mwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCB8wqAgMSArCsKgbWV0YS1mYWNlYm9vay9tZXRhLXRpb2dhcGFzcy9yZWNp
cGVzLWZidHAvcGFja2FnZWdyb3Vwcy9wYWNrYWdlZ3JvdXAtZmItYXBwcy5iYiB8IDE4ICsr
KysrKysrKysrKysrKysrKwrCoG1ldGEtZ29vZ2xlL3JlY2lwZXMtZ29vZ2xlL2lwbWkvZ29v
Z2xlLWlwbWktc3lzX2dpdC5iYsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIHzCoCAyICstCsKgbWV0YS1vcGVucG93ZXIvcmVjaXBlcy1ic3Av
c2tpYm9vdC9za2lib290LmluY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqAgNiArKystLS0KwqBtZXRhLXBo
b3NwaG9yL3JlY2lwZXMtcGhvc3Bob3Ivc3RhdGUvcGhvc3Bob3Itc3RhdGUtbWFuYWdlcl9n
aXQuYmLCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqAgMiArLQrCoG1ldGEtcGhvc3Bo
b3IvcmVjaXBlcy1waG9zcGhvci93ZWJ1aS9waG9zcGhvci13ZWJ1aV9naXQuYmLCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgIDIgKy0KwqA3IGZpbGVz
IGNoYW5nZWQsIDI3IGluc2VydGlvbnMoKyksIDggZGVsZXRpb25zKC0pCsKgY3JlYXRlIG1v
ZGUgMTAwNjQ0IG1ldGEtZmFjZWJvb2svbWV0YS10aW9nYXBhc3MvcmVjaXBlcy1mYnRwL3Bh
Y2thZ2Vncm91cHMvcGFja2FnZWdyb3VwLWZiLWFwcHMuYmIKJAokIGdpdCBsb2cgLS1vbmVs
aW5lIC0tZGVjb3JhdGU9c2hvcnQgLS1ncmFwaAoqwqDCoCA0YWFhN2QxNTYgKEhFQUQgLT4g
bWFzdGVyKSBNZXJnZSByZW1vdGUtdHJhY2tpbmcgYnJhbmNoICd1cHN0cmVhbS9tYXN0ZXIn
CnxcwqAKfCAqIGM3MWJjZGMwMSAodGFnOiB2Mi40LCB1cHN0cmVhbS9tYXN0ZXIsIHVwc3Ry
ZWFtL0hFQUQsIHVwc3RyZWFtKSBwaG9zcGhvci13ZWJ1aTogc3JjcmV2IGJ1bXAgMWNjNzAy
MWM5ZS4uYmM1Y2M3Zjc1Ywp8ICogM2RiNzgyMGU2IHNraWJvb3Q6IEJ1bXAgdG8gNi4wLjEz
CnwgKiA1YTk2M2IyMzEgbGludXgtYXNwZWVkOiBNb3ZlIHRvIDQuMTguMTYKfCAqIDM2YTQ5
ZTJkNyBBZGQgRW50aXR5IE1hbmFnZXIgdG8gRmFjZWJvb2sgVGlvZ2FwYXMKLi4uCiQKYGBg
CgpUaGUgc3RyYW5nZSBwYXJ0IGlzIHRoaXM6CgpgYGAKJCBnaXQgZGVzY3JpYmUgLS1kZWJ1
ZwpzZWFyY2hpbmcgdG8gZGVzY3JpYmUgSEVBRApmaW5pc2hlZCBzZWFyY2ggYXQgZWI4NjQ0
NzQyYjIyYTc3ZjQwZTZjZmU5ZjNkMzI1ZTkyYTYwMmRlZgrCoGFubm90YXRlZMKgwqDCoMKg
wqDCoCAxNjEyIHYyLjMKwqBhbm5vdGF0ZWTCoMKgwqDCoMKgwqAgMTk3NiB2Mi4yCsKgYW5u
b3RhdGVkwqDCoMKgwqDCoMKgIDI0MjcgdjIuMQrCoGFubm90YXRlZMKgwqDCoMKgwqDCoCAy
NTI1IHYyLjQKwqBhbm5vdGF0ZWTCoMKgwqDCoMKgwqAgMjY0OCB2Mi4wCsKgYW5ub3RhdGVk
wqDCoMKgwqDCoMKgIDI5MTAgdjEuOTkuMTAKdHJhdmVyc2VkIDI5ODUgY29tbWl0cwp2Mi4z
LTE2MTItZzRhYWE3ZDEKYGBgCgpBcyB5b3UgY2FuIHNlZSwgdGhlIGB2Mi40YCB0YWcsIHRo
YXQgYWNjb3JkaW5nIHRvIHRoZSBncmFwaCBsb2cgaXMgdGhlIGltbWVkaWF0ZSBwYXJlbnQg
b2YgdGhlIGN1cnJlbnQgSEVBRCwgaXMgbm90IHRoZSBiZXN0IGNhbmRpZGF0ZSBzb21laG93
LCBhbmQgYHYyLjNgIGlzIGluc3RlYWQgcmVwb3J0ZWQuIEl0IGFsc28gc29tZWhvdyB0aGlu
a3MgdGhhdCB0aGVyZSBhcmUgMjUyNSBjb21taXRzIGJldHdlZW4gYHYyLjRgIHRhZyBhbmQg
dGhlIEhFQUQuCgpJcyB0aGlzIGEgYnVnIGluIGdpdCBvciBhcmUgd2UgZG9pbmcgYW55dGhp
bmcgd3Jvbmc/CgpUaGFua3MuCgpBbGV4YW5kZXIuCgpQLlMuIFRoaXMgaGFzIGJlZW4gdmVy
aWZpZWQgYm90aCB3aXRoIHN0b2NrIGdpdCB2ZXJzaW9uIDIuNy40IGFuZCB3aXRoIHZlcnNp
b24gMi4yMC4wLnJjMC4zNDkuZzE0OGJlZGEgZnJvbSBgbmV4dGAgdG9wLW9mLWJyYW5jaC4K
Cg==

--Xk6TzA3fKyMh8oVqtsio337JekBAuwvTr--

--JD2blRXwEqcIQmmdEZemL6fRQgsXEzVS4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJb8s3JAAoJEOiTWHtbdBeNCkAQAMGKMOQqCDYVdmfpfcAOR6XS
kAMhBck6i3UeDI5CZGJ+iCviZTL28V220nYpkvuEIL54k/K6EJ0mwALNU8xKzj4s
ayeduUiBaM/OIcwLHHt7P1/ZFZkq1tPY6ONr7YKDk89Sne/R8l9XM7ptYFkaDCAE
G+WoL8laZX7IQOk136FFiLb7WiNNqqpsbnAPgvytTafiGAGbG2s2gOKVuIAjrUVg
XKdGvpKDDP46xTqW4nwAiRd4hETJU4XiV2GOqIBhQViE6LOSXGFsMuSBRYc8VQoZ
c36lxikdTycksNmyGJssaEOoiT7osi7OmTArk4T+Byd7LOayv08BvokBxVqDzNit
p4TF8DGrLIICugqVmOnL+4pnWT+8+chWqWSPxHDfAXOqfrCBQjje72vkMTC5dv0w
//psSzd1nZGvDDSXNjV2lEp/0s2HvMnnXiPscKisqBtvNXzTQcHL0aos5hB637ob
TJzgtrX/aYB9u2IByX23RXL5dplM7WEaJ5zMk5DRLQA8w6FiCU53RAklmSFKJope
LPK83BkG4c3H0Tu4MLY9JXoFLMeC1M1tb7ZZKYFmc9Q72NGUBurQzMzj/9p6VnRF
UTOOjwM4dhgnRItaUawvrAfgL/lOZxwf6vmMieNdLbF+yQyVbqRPki85wOnnqNkN
65e1wUavIPNbtQayohYa
=/V/Z
-----END PGP SIGNATURE-----

--JD2blRXwEqcIQmmdEZemL6fRQgsXEzVS4--
