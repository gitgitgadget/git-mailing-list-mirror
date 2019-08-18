Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B74161F461
	for <e@80x24.org>; Sun, 18 Aug 2019 20:46:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727040AbfHRUqb (ORCPT <rfc822;e@80x24.org>);
        Sun, 18 Aug 2019 16:46:31 -0400
Received: from mail-wm1-f48.google.com ([209.85.128.48]:35184 "EHLO
        mail-wm1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726747AbfHRUqb (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Aug 2019 16:46:31 -0400
Received: by mail-wm1-f48.google.com with SMTP id l2so1251365wmg.0
        for <git@vger.kernel.org>; Sun, 18 Aug 2019 13:46:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mat.ucm.es; s=google;
        h=from:to:cc:subject:references:reply-to:date:message-id:user-agent
         :mime-version;
        bh=RnKm46qDeFxQ1JtcpXzbJ1wpiLz+NchDUMeCANjyFlE=;
        b=E5kIf6Fedq8qd+OoAOVKElpJCKFVuhXdRMSK4G5amK/YAAnTrD3J8QpyUvI3dWuMgw
         5Y77rF/8YFE6eAYkIzMVbre0gUKlUzLF1K48hVCVgWdkPlDY58wYl57b1m+Ecgxjwpb5
         DNpwa0hTXxxVIsgxGgF1I/vl2WzP0gTLasaVU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:reply-to:date
         :message-id:user-agent:mime-version;
        bh=RnKm46qDeFxQ1JtcpXzbJ1wpiLz+NchDUMeCANjyFlE=;
        b=Mc1KhY3p4HDEOfoQZ9YNSSIREbYQxe5Dl+0I0JrNwfCNk+3UV6qivSIsGJhhB/lGJJ
         ohxVVkhxci5/iOCu/1OSOwq6c9xNu1PPhfoFF0fe95ogn84Tq1VmndvxOLQU2lqpWSWr
         tNZUpvX5a33ETjUob2KDIGAd17JddIbcNlxGIZzCPspmDWLymiQrnUvSdxrJ3AUV3eIN
         M/baD7Gx1l8Uk2MSESv25SGAz7sfXus+MVqDKuledhYfMOjMSrhGkRQjaoK7e2dKmcY2
         hGVOFJ2aO/W7NQNgOL5HT6A3jsaYHhsIVikyO9/HcKZ9qI7PwcqNU6Ty9EVjcqKUjxei
         rQJA==
X-Gm-Message-State: APjAAAVcTPtdN0Ak7T9hmP1YKYOWw86JbQSHT4TNJx84K01lOPvYebke
        IFJyn7NuMzrlyKJ9nozaTGdpSQ==
X-Google-Smtp-Source: APXvYqxcZZvsZN6LuehCaMYO/sB9qhhZCo1Cy0YcntLxy2RcPmgjnTpX467HjnP16f6tPUfs6fsUiQ==
X-Received: by 2002:a1c:610a:: with SMTP id v10mr16927415wmb.151.1566161186958;
        Sun, 18 Aug 2019 13:46:26 -0700 (PDT)
Received: from Utnapischtim (p2003000611CFBC551D8B09B695741519.dip0.t-ipconnect.de. [2003:6:11cf:bc55:1d8b:9b6:9574:1519])
        by smtp.gmail.com with ESMTPSA id e14sm8808209wme.35.2019.08.18.13.46.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 18 Aug 2019 13:46:24 -0700 (PDT)
X-Mailer: emacs 27.0.50 (via feedmail 11-beta-1 I)
From:   Uwe Brauer <oub@mat.ucm.es>
To:     Rafael =?utf-8?Q?Ascens=C3=A3o?= <rafa.almas@gmail.com>
Cc:     Uwe Brauer <oub@mat.ucm.es>, git@vger.kernel.org,
        Alban Gruin <alban.gruin@gmail.com>
Subject: Re: git log --graph with a sort of local revision number
References: <87blwq7rn5.fsf@mat.ucm.es> <20190818190032.GA11185@rigel>
Reply-To: Uwe Brauer <oub@mat.ucm.es>
X-Hashcash: 1:20:190818:alban.gruin@gmail.com::F+R/UUeFEh5hcEeX:00000000000000000000000000000000000000002Ike
X-Hashcash: 1:20:190818:git@vger.kernel.org::H0UCKEFd/+ABvCFC:0000000000000000000000000000000000000000003/LE
X-Hashcash: 1:20:190818:rafa.almas@gmail.com::i0Z+p01hDzUc9jiz:000000000000000000000000000000000000000006lJP
X-Hashcash: 1:20:190818:oub@mat.ucm.es::ncwezghIA5EOWvhW:0008saT
Date:   Sun, 18 Aug 2019 22:46:18 +0200
Message-ID: <87blwmmcbp.fsf@mat.ucm.es>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=sha256; protocol="application/pkcs7-signature"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

>>> "RA" =3D=3D Rafael Ascens=C3=A3o <rafa.almas@gmail.com> writes:

   > You can achieve something close (on small repos, more on that later) w=
ith:
   > $ git log --graph --color \
   >   --format=3D'%C(auto)changeset: %h:%H%nuser:      %an%ndate:      %ad=
%nsummary:   %s%n' \
   >   | git name-rev --refs=3D$(git rev-parse --abbrev-ref HEAD) --name-on=
ly --stdin

Ok I see this is bash syntaxes.

In that case it works, but I see

* changeset: f40c01e:f40c01e41afbb87c7321147242354d46ddaee231
| user:      Uwe Brauer
| date:      Thu Aug 15 15:13:00 2019 +0200
| summary:   This is a test.
|
* changeset: 4dcf721:4dcf721042cd8f73d78876caf8f4796153c07023
| user:      Uwe Brauer
| date:      Wed Aug 14 14:33:29 2019 +0200
| summary:   Third
|
* changeset: 93083c8:93083c8b65141047c8346765fb663d5962076246
| user:      Uwe Brauer
| date:      Wed Aug 14 14:33:29 2019 +0200
| summary:   Second
|
* changeset: f59470f:f59470feb19d325accaad634025c229d6977df65
  user:      Uwe Brauer
  date:      Wed Aug 14 14:33:29 2019 +0200
  summary:   First commit

But on the GNU emacs repository which is reasonable old (has about 130
000 commits) and is around 700 MB, your command gives:


* changeset: ee1c638:master
| user:      Lars Ingebrigtsen
| date:      Sat Aug 17 17:30:42 2019 -0700
| summary:   Make `browse-url-of-buffer' work from zip files
|
* changeset: 3d1c9a7:master~1
| user:      Paul Eggert
| date:      Sat Aug 17 17:19:13 2019 -0700
| summary:   Fix org-timer-show-remaining-time > 1 hour
|
* changeset: f38a16e:master~2
| user:      Lars Ingebrigtsen
| date:      Sat Aug 17 16:56:13 2019 -0700
| summary:   Make `describe-function' say that disabled functions are disab=
led
|
* changeset: 3efe59a:master~3
| user:      Lars Ingebrigtsen
| date:      Sat Aug 17 16:47:16 2019 -0700
| summary:   Make newline-and-indent take a numeric prefix

Which is precisely what you said.


What did I do wrong in my test repo?

Which I generated via the following script


git init
echo "First" > test.org
git add test.org
git add create.sh
git commit -a -m "First commit"
echo "Second" >> test.org
git commit -a -m "Second"
echo "Third" >> test.org
git commit -a -m "Third"
echo "Forth" >> test.org
git commit  -a -m "Fourth"
echo "Fifth" >> test.org
git commit  -a -m "Fifth"
echo "Six" >> test.org
git commit  -a -m "Six"


   >     * changeset: 5fa0f52:master
   >     | user:      Junio C Hamano
   >     | date:      Fri Aug 16 10:28:23 2019 -0700
   >     | summary:   Git 2.23
   >     |
   >     *   changeset: 8e0fa0e:master~1
   >     |\  user:      Junio C Hamano
   >     | | date:      Fri Aug 16 10:22:51 2019 -0700
   >     | | summary:   Merge tag 'l10n-2.23.0-rnd2' of git://github.com/gi=
t-l10n/git-po
   >     | |=20
   >     | * changeset: a6cd2cc:master~1^2
   >     | | user:      Jiang Xin
   >     | | date:      Tue Jul 30 10:02:22 2019 +0800
   >     | | summary:   l10n: zh_CN: for git v2.23.0 l10n round 1~2

   > And in this case, since we are using HEAD to describe the commits by
   > using --refs=3D$(git rev-parse --abbrev-ref HEAD), you can refer to
   > a6cd2cc either as master~1^2 or HEAD~1^2.

   > Now, git-name-rev has some memory/performance problems in repos with a
   > high number of references. Alban Gruin was working on this issue[1], b=
ut
   > I don't know what's the status of it.

   > [1]:https://github.com/agrn/git/tree/ag/fix-name-rev-leak

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
hvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0xOTA4MTgyMDQ2MThaMCgGCSqGSIb3DQEJDzEbMBkwCwYJ
YIZIAWUDBAECMAoGCCqGSIb3DQMHMC8GCSqGSIb3DQEJBDEiBCCMGVGqOtUGyxfzeVqXviJtE3+o
iL4XA32D4lRED4hgIjANBgkqhkiG9w0BAQEFAASCAQB9v7RuBcjS2AVPaCLvmIxj1GEkF2c1IRGJ
WvR/16AxTAK8VO4Xf5DUZYxxuFhaGiwCPW7n6F/ri8pFn+iHke9uSy7DDI+OJNYKZ5On80wTHopJ
TFLH4vVRuyWhUGrTbZDU0AU/gOeI6Jm26GIvkyZaXZbqBprgVi6xFD5C3RHH/Y/FvTkyOA8/7WOp
jBzzOIPzSWM+E0nfXJ7vK6HtDGEsr+IsZD8gh+lD2Gmj9ZQ0iztkChrSDvL2jb9K34b/O5cG4eWZ
JFjTQXgNymGhHiXvvMdRmP2abWlL9sTJJEG4Fz0KlWUL2IKUuLp7teW3GH0CsAv7ASGEULpDzGiQ
P1WJAAAAAAAA
--=-=-=--
