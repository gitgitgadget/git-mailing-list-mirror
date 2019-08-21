Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 51FE11F461
	for <e@80x24.org>; Wed, 21 Aug 2019 07:52:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726935AbfHUHwn (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Aug 2019 03:52:43 -0400
Received: from mail-wr1-f50.google.com ([209.85.221.50]:42831 "EHLO
        mail-wr1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726409AbfHUHwm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Aug 2019 03:52:42 -0400
Received: by mail-wr1-f50.google.com with SMTP id b16so1045029wrq.9
        for <git@vger.kernel.org>; Wed, 21 Aug 2019 00:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mat.ucm.es; s=google;
        h=from:to:cc:subject:references:reply-to:date:message-id:user-agent
         :mime-version;
        bh=CBpZob2DbMrnzrZYj0ogr2F4GHdVMxC7N/XNzwQYkEo=;
        b=ZO9N7ctzNZHLazpTNwHtURRzTF1/fJpCPh65Sim+TXGTDbACdMwzf68NgOrn7grjvK
         0kLmBBsb0YjpCcDgn83+78RfhhqgBeohAL0cElj3Jz278ptx7H33jZWNflPbUxSuZtGn
         /rLLmTTnYTud1odDzLyk+wdfAKquNWkojRsl4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:reply-to:date
         :message-id:user-agent:mime-version;
        bh=CBpZob2DbMrnzrZYj0ogr2F4GHdVMxC7N/XNzwQYkEo=;
        b=NXYEyC8wSDci2Nqb4aPSuQycb8SltSO5Hgw3bvCpFZocRL0xYWoCFrJ6wpzBrr22bf
         ucvFBkjXcY4hB2DSS93y3u/lsIug5j/A1SkbqO1zns43YM7JB2JmZJXO8sDpNbnFt9Cf
         klNVs4ErZM8p97vst3aGJY3NW+mKU8RqjF86IaLHVO2dMkjLEdigUjmMVR77Kh8Ml9qV
         M5b9KteoJycL5Ej5vXpU4QWKsSNXlTlzjCZc7jBPpjJHhufpfUKCxZfLqXN1k0GEI5Bc
         exkm3kZjUsKalD7O3epkaa92zS3QdwUQKV02vEiX8LWpKC+2Y9Iaf3mjch/FbrYzeGdA
         H0/A==
X-Gm-Message-State: APjAAAUREKIIHbTsQVdVTG7cEY+3wXrFJyXIKgwQgoSMeI49nL3CgNIG
        ZQ3cvVdHPgFroqhnSNsyteLNuA==
X-Google-Smtp-Source: APXvYqyMQkh2T21oIMhrvOPoDUYdAiUU9+iXgJLEVr9oJuBIT1uQ3QoSGaLLrp6F1ZyL7tor9yEslg==
X-Received: by 2002:a5d:6981:: with SMTP id g1mr11893868wru.193.1566373959673;
        Wed, 21 Aug 2019 00:52:39 -0700 (PDT)
Received: from Utnapischtim (p57864EA7.dip0.t-ipconnect.de. [87.134.78.167])
        by smtp.gmail.com with ESMTPSA id b136sm6880684wme.18.2019.08.21.00.52.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Aug 2019 00:52:38 -0700 (PDT)
X-Mailer: emacs 27.0.50 (via feedmail 11-beta-1 I)
From:   Uwe Brauer <oub@mat.ucm.es>
To:     Phil Hord <phil.hord@gmail.com>
Cc:     Uwe Brauer <oub@mat.ucm.es>, Junio C Hamano <gitster@pobox.com>,
        Rafael =?utf-8?Q?Ascens=C3=A3o?= <rafa.almas@gmail.com>,
        Git <git@vger.kernel.org>, Alban Gruin <alban.gruin@gmail.com>
Subject: Re: [problem with name-rev]
References: <87blwq7rn5.fsf@mat.ucm.es> <20190818190032.GA11185@rigel>
        <87pnkzkivn.fsf_-_@mat.ucm.es>
        <xmqqh86bvgsz.fsf@gitster-ct.c.googlers.com>
        <87k1b7k4w1.fsf@mat.ucm.es>
        <CABURp0qHnzpwr8dPtPZpA+1C=tEsoybh2V00iHpyrJ2AM8XHzQ@mail.gmail.com>
Reply-To: Uwe Brauer <oub@mat.ucm.es>
X-Hashcash: 1:20:190821:rafa.almas@gmail.com::8JlkgCVMkpA/ATbi:000000000000000000000000000000000000000000BYW
X-Hashcash: 1:20:190821:oub@mat.ucm.es::aY5ErKcd3sEW3beE:0003f22
X-Hashcash: 1:20:190821:git@vger.kernel.org::Jved5DAe74qZ+Npk:0000000000000000000000000000000000000000003YND
X-Hashcash: 1:20:190821:alban.gruin@gmail.com::fuqYgcG4K5GlF2xh:00000000000000000000000000000000000000005ndA
X-Hashcash: 1:20:190821:phil.hord@gmail.com::ijtwcWFJkfQaaqKp:0000000000000000000000000000000000000000008SuB
X-Hashcash: 1:20:190821:gitster@pobox.com::/hE3UiGIDT72rqCP:00000000000000000000000000000000000000000000EnS2
Date:   Wed, 21 Aug 2019 09:50:25 +0200
Message-ID: <87pnkz2bzy.fsf@mat.ucm.es>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=sha256; protocol="application/pkcs7-signature"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


   > On Tue, Aug 20, 2019 at 12:35 PM Uwe Brauer <oub@mat.ucm.es> wrote:

   > Try adding '--all' to include all refs, not just the current HEAD, to
   > begin logging from. Here is what I see after running your setup
   > script.

   > $  git log --graph --decorate --all
   > * commit 3262040f2d8d5f31b4918bda9987e6b5f788531f (foo)
   > | Author: Phil Hord <phord@purestorage.com>
   > | Date:   Tue Aug 20 12:44:32 2019
   > |
   > |     1.2.1
   > |
   > * commit fc66c4311bf954d455f468581f2913dffa0f9c2b
   > | Author: Phil Hord <phord@purestorage.com>
   > | Date:   Tue Aug 20 12:44:32 2019
   > |
   > |     1.2
   > |
   > | * commit 109e5d4baef4e99cf636189ba1499af817ab0bb1 (HEAD -> master)
   > |/  Author: Phil Hord <phord@purestorage.com>
   > |   Date:   Tue Aug 20 12:44:32 2019
   > |
   > |       1.1
   > |
   > * commit 5c1e93ed7c5b3b241d5adfadb365a6bca5d60d3a
   >   Author: Phil Hord <phord@purestorage.com>
   >   Date:   Tue Aug 20 12:44:32 2019

   >       1

That's it, thanks. Interestingly enough the=20

 git graph looks differently from the mercurial one.

The mercurial one looks purely linear (with two branches) while the git one=
 is not,
but maybe it is not clear to me who to translate the git command=20

git checkout -b foo master~1

To mercurial?

Anyhow the original question was about having a sort of local revision
number and I see that this is somehow possible, which was not clear to
me before.=20

Thanks

--=-=-=
Content-Type: application/pkcs7-signature; name=smime.p7s
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename=smime.p7s

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
EwdTYWxmb3JkMRowGAYDVQQKExFDT01PRE8gQ0EgTGltaXRlZDE9MDsGA1UEAxM0Q09NT0RPIFJT
QSBDbGllbnQgQXV0aGVudGljYXRpb24gYW5kIFNlY3VyZSBFbWFpbCBDQTCCASIwDQYJKoZIhvcN
AQEBBQADggEPADCCAQoCggEBAL6znlesKHZ1QBbHOAOY08YYdiFQ8yV5C0y1oNF9Olg+nKcxLqf2
NHbZhGra0D00SOTq9bus3/mxgUsg/Wh/eXQ0pnp8tZ8XZWAnlyKMpjL+qUByRjXCA6RQyDMqVaVU
kbIr5SU0RDX/kSsKwer3H1pT/HUrBN0X8sKtPTdGX8XAWt/VdMLBrZBlgvnkCos+KQWWCo63OTTq
Rvaq8aWccm+KOMjTcE6s2mj6RkalweyDI7X+7U5lNo6jzC8RTXtVV4/Vwdax720YpMPJQaDaElmO
upyTf1Qib+cpukNJnQmwygjD8m046DQkLnpXNCAGjuJy1F5NATksUsbfJAr7FLUCAwEAAaOCATww
ggE4MB8GA1UdIwQYMBaAFLuvfgI9+qbxPISOre44mOzZMjLUMB0GA1UdDgQWBBSCr2yM+MX+lmF8
6B89K3FIXsSLwDAOBgNVHQ8BAf8EBAMCAYYwEgYDVR0TAQH/BAgwBgEB/wIBADARBgNVHSAECjAI
MAYGBFUdIAAwTAYDVR0fBEUwQzBBoD+gPYY7aHR0cDovL2NybC5jb21vZG9jYS5jb20vQ09NT0RP
UlNBQ2VydGlmaWNhdGlvbkF1dGhvcml0eS5jcmwwcQYIKwYBBQUHAQEEZTBjMDsGCCsGAQUFBzAC
hi9odHRwOi8vY3J0LmNvbW9kb2NhLmNvbS9DT01PRE9SU0FBZGRUcnVzdENBLmNydDAkBggrBgEF
BQcwAYYYaHR0cDovL29jc3AuY29tb2RvY2EuY29tMA0GCSqGSIb3DQEBDAUAA4ICAQB4XLKBKDRP
PO5fVs6fl1bsj6JrF/bz9kkIBtTYLzXN30D+03Hj6OxCDBEaIeNmsBhrJmuubvyE7HtoSmR809Ag
cYboW+rcTNZ/8u/Hv+GTrNI/AhqX2/kiQNxmgUPt/eJPs92Qclj0HnVyy9TnSvGkSDU7I5Px+TbO
+88G4zipA2psZaWeEykgzClZlPz1FjTCkk77ZXp5cQYYexE6zeeN4/0OqqoAloFrjAF4o50YJafX
8mnahjp3I2Y2mkjhk0xQfhNqbzlLWPoT3m7j7U26u7zg6swjOq8hITYc3/np5tM5aVyu6t99p17b
TbY7+1RTWBviN9YJzK8HxzObXYWBf/L+VGOYNsQDTxAk0Hbvb1j6KjUhg7fO294F29QIhhmiNOr8
4JHoy+fNLpfvYc/Q9EtFOI5ISYgOxLk3nD/whbUe9rmEQXLp8MB933Ij474gwwCPUpwv9mj2PMnX
oc7mbrS22XUSeTwxCTP9bcmUdp4jmIoWfhQm7X9w/Zgddg+JZ/YnIHOwsGsaTUgj7fIvxqith7Do
JC91WJ8Lce3CVJqb1XWeKIJ84F7YLXZN0oa7TktYgDdmQVxYkZo1c5noaDKH9Oq9cbm/vOYRUM1c
Wcef20Wkyk5S/GFyyPJwG0fR1nRas3DqAf4cXxMiEKcff7PNa4M3RGTqH0pWR8p6EjCCBScwggQP
oAMCAQICECLAY/HTlgg2ZPbDon99FPswDQYJKoZIhvcNAQELBQAwgZcxCzAJBgNVBAYTAkdCMRsw
GQYDVQQIExJHcmVhdGVyIE1hbmNoZXN0ZXIxEDAOBgNVBAcTB1NhbGZvcmQxGjAYBgNVBAoTEUNP
TU9ETyBDQSBMaW1pdGVkMT0wOwYDVQQDEzRDT01PRE8gUlNBIENsaWVudCBBdXRoZW50aWNhdGlv
biBhbmQgU2VjdXJlIEVtYWlsIENBMB4XDTE5MDEwNjAwMDAwMFoXDTIwMDEwNjIzNTk1OVowHzEd
MBsGCSqGSIb3DQEJARYOb3ViQG1hdC51Y20uZXMwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEK
AoIBAQDAJBqZzDcWLNdUqJsWmomjQHH1BbPl6gKkKT+uLY5hIKZ1+K5kFXrEs0lk+myiS9/wR5Gu
bpwKnr6xNcvtO0XP0dHMLLbu/1sTNg0t1/HOGJSgwUvZUHvUcUVhs/NACD69rh3V5F1w9oIAnXZj
g526lvwWeBv8G6RGBM4+AVFXxaLdNO7G6V8GX9E8goBKGMKIDBAK6f31D1YbPRCEF3voj2UtpVjy
PQXfQhHMZngUjyKChB7vWnHuRF+BIaxd0kWJ3qCPrOHNLHaEjr7bnjp9oZrS4DnnwbNifJBcdZjn
ZYxEDBIoeols9qg4pjT2HsdEi3H6Y/CBKzB1yiMmHBZ1AgMBAAGjggHkMIIB4DAfBgNVHSMEGDAW
gBSCr2yM+MX+lmF86B89K3FIXsSLwDAdBgNVHQ4EFgQUXbdUbNg/WjkhObIK9sKXkRnE4QswDgYD
VR0PAQH/BAQDAgWgMAwGA1UdEwEB/wQCMAAwIAYDVR0lBBkwFwYIKwYBBQUHAwQGCysGAQQBsjEB
AwUCMBEGCWCGSAGG+EIBAQQEAwIFIDBGBgNVHSAEPzA9MDsGDCsGAQQBsjEBAgEBATArMCkGCCsG
AQUFBwIBFh1odHRwczovL3NlY3VyZS5jb21vZG8ubmV0L0NQUzBaBgNVHR8EUzBRME+gTaBLhklo
dHRwOi8vY3JsLmNvbW9kb2NhLmNvbS9DT01PRE9SU0FDbGllbnRBdXRoZW50aWNhdGlvbmFuZFNl
Y3VyZUVtYWlsQ0EuY3JsMIGLBggrBgEFBQcBAQR/MH0wVQYIKwYBBQUHMAKGSWh0dHA6Ly9jcnQu
Y29tb2RvY2EuY29tL0NPTU9ET1JTQUNsaWVudEF1dGhlbnRpY2F0aW9uYW5kU2VjdXJlRW1haWxD
QS5jcnQwJAYIKwYBBQUHMAGGGGh0dHA6Ly9vY3NwLmNvbW9kb2NhLmNvbTAZBgNVHREEEjAQgQ5v
dWJAbWF0LnVjbS5lczANBgkqhkiG9w0BAQsFAAOCAQEAtVRJu+IU+1WkBfCbsxbMisE9J3ObD7sN
OCv7cHOT6oJ9xL7ff8qP3+Lu3fkRCPiB7/LuzPT7xyFso0LjJ84mycemvehuOTpwLX5wt2D+mVuw
D/0wUHxpkKLLKIkTuBd4QNXU22UUn9iC4aqB3jgYPppfTKnam66X6PB7pL/7iycuOY06ymZeFGYL
o8CKlrAWvOsik7RfFfamTv1bdNOHuJG0IiH0iDd3GJUxG4N/C3arjWxBcJIwEeKcRA16maLqFt+y
9XyKpccfADI1WACfqn31+r2BvE2thbDDfUiGXVmzVsvPyQZup8uvjBscl6/yRu8bPKH508mPCLU3
+jOlazGCAm4wggJqAgEBMIGsMIGXMQswCQYDVQQGEwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5j
aGVzdGVyMRAwDgYDVQQHEwdTYWxmb3JkMRowGAYDVQQKExFDT01PRE8gQ0EgTGltaXRlZDE9MDsG
A1UEAxM0Q09NT0RPIFJTQSBDbGllbnQgQXV0aGVudGljYXRpb24gYW5kIFNlY3VyZSBFbWFpbCBD
QQIQIsBj8dOWCDZk9sOif30U+zANBglghkgBZQMEAgEFAKCBkzAYBgkqhkiG9w0BCQMxCwYJKoZI
hvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0xOTA4MjEwNzUwMjVaMCgGCSqGSIb3DQEJDzEbMBkwCwYJ
YIZIAWUDBAECMAoGCCqGSIb3DQMHMC8GCSqGSIb3DQEJBDEiBCBr78aH3dOrHNyrbZoT3lAUQzKa
4qxaYA3qHXOwju7RHzANBgkqhkiG9w0BAQEFAASCAQB8jQak6Y8hDtsHrgdBYIhZgzKe5OuYxlQo
IIFb1EP2BrJ21IJjSpZ36t6zy9olkCOUxFV0iHyixi703Ak9BCsp7vsQW2P8tF//YafoCOycPKpK
MIjOUeRjy30tUgsuy8jPxt8S6T1Y8Kzt3DdGt11UXmbXncwQBirDuzb4Bt8FRl0VneMI4PmQOX5r
uoZ9IZPgUKE3mBxxcL/574eOZha30NI0PjF6IrqIEfr+JWM4EnoAycDYedvvZaZkn0KITK0fJhOg
zbnrO7G7GyOB2n9CpJjH9KALLVbaFbMEOYz8RouE4AjCtv1TvaBRhdg/1IA+goAo6tVu2TThz2E5
TmVXAAAAAAAA
--=-=-=--
