Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 871951F461
	for <e@80x24.org>; Tue,  9 Jul 2019 23:36:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727004AbfGIXg2 (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Jul 2019 19:36:28 -0400
Received: from ip1.ga.com ([141.248.4.40]:37199 "EHLO ip1.ga.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726218AbfGIXg2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Jul 2019 19:36:28 -0400
X-Greylist: delayed 570 seconds by postgrey-1.27 at vger.kernel.org; Tue, 09 Jul 2019 19:36:28 EDT
X-IronPort-AV: E=Sophos;i="5.63,472,1557212400"; 
   d="p7s'?scan'208";a="490069457"
Received: from asgexcpwp03.ga.com ([10.120.209.200])
  by ip1.ga.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Jul 2019 16:26:57 -0700
Received: from ASGEXCPWP07.ga.com (10.120.209.129) by ASGEXCPWP03.ga.com
 (10.120.209.200) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 9 Jul
 2019 16:26:57 -0700
Received: from ASGEXCPWP07.ga.com ([fe80::e84b:2c6c:f4ac:66a8]) by
 ASGEXCPWP07.ga.com ([fe80::e84b:2c6c:f4ac:66a8%21]) with mapi id
 15.00.1473.005; Tue, 9 Jul 2019 16:26:57 -0700
From:   "McRoberts, John" <John.McRoberts@ga.com>
To:     Elijah Newren <newren@gmail.com>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RE: -EXT-Re: Problem with git diff
Thread-Topic: -EXT-Re: Problem with git diff
Thread-Index: AdU2nm0YpTBCTJWRR/KuTBWxd6guBgASBkkAAA5xEUA=
Date:   Tue, 9 Jul 2019 23:26:57 +0000
Message-ID: <67b7d1d35bf14f56865b91410b6fc0ec@ASGEXCPWP07.ga.com>
References: <1288734232ea45e0be655668ac60d98f@ASGEXCPWP07.ga.com>
 <CABPp-BE1fQs99ipi9Y8gfQO3QHkxzQhn1uriEbj6YjdYH839eQ@mail.gmail.com>
In-Reply-To: <CABPp-BE1fQs99ipi9Y8gfQO3QHkxzQhn1uriEbj6YjdYH839eQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.120.209.12]
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature";
        micalg=SHA1; boundary="----=_NextPart_000_0D70_01D53673.1D4863C0"
MIME-Version: 1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

------=_NextPart_000_0D70_01D53673.1D4863C0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 7bit

Actually, I was actually using git log (not git diff... sorry for the mistake) 
because I also mine other information I(dates, author, summary, etc)

'git log  -m --first-parent --pretty=fuller --decorate=short  --name-only 
REL1..REL2'

That being said, I can work with the git diff output to filter out the 
irrelevant info.  I would still be curious about whether this is a valid use 
of git log.

Thanks,

Jack McRoberts
Configuration Management Software Specialist
General Atomics EMS Group
Work Phone: 858-522-8342
16969 Mesamint St, Room 86-1023G,
San Diego, CA  92127


************************************************************************
CONFIDENTIALITY NOTICE: This communication is intended to be confidential to 
the
person(s) to whom it is addressed. If you are not the intended recipient or 
the agent of the
intended recipient or if you are unable to deliver this communication to the 
intended
 recipient, you must not read, use or disseminate this information. If you 
have received this
communication in error, please advise the sender immediately by telephone and 
delete
this message and any attachments without retaining a copy.
**************************************************************************


-----Original Message-----
From: Elijah Newren <newren@gmail.com>
Sent: Tuesday, July 9, 2019 4:13 PM
To: McRoberts, John <John.McRoberts@ga.com>
Cc: git@vger.kernel.org
Subject: -EXT-Re: Problem with git diff

WARNING:  This message is from an external source.  Evaluate the message 
carefully BEFORE clicking on links or opening attachments.

Hi John,

On Tue, Jul 9, 2019 at 3:57 PM McRoberts, John <John.McRoberts@ga.com> wrote:
>
> I am responsible for generating a list of all files changed between
> two successive releases of software. I was using 'git diff' but have
> run into a problem.
>
> Consider the following situation: A development branch comes off of
> commit A and files are changed three times.  A tag (REL1) is placed on
> the third commit.  Then the branch is merged back to master.  At this
> point, master's HEAD is at C (and it remains there).  Two development
> branches are created off of master, the first of which is not
> important here.  In the second one, there are files changed and a tag (REL2) 
> applied.
>
>
> ---------------------[I]
>
> /      {dev branch}
>
> /
>
> /
>              {master branch}
> /
>  [A]
> ---------------------------------[B]------------------------------->[C
> ]
> master <HEAD>
>    \                               filelist 6                           /  \
>     \                                                                  /
> \
>      \                                                                /
> \
>       \                                                              /
> \
>        \                {development branch}                        /
> \
>         \------->[D]----------------------->[E]-------------------[F]
> \------[G]--------[H]
>                                                                  REL1
> REL2
>                 fileset 1               fileset 2           fileset 3
> fileset 4    fileset 5
>
> At this point, I run
>     'git diff  -m --first-parent --pretty=fuller --decorate=short
> --name-only REL2..REL2'

Wow, we really, really need to throw errors and warnings when people use crazy 
range operators with diff.[1][2]  What version of git are you using that 
accepts --decorate=short as an argument to `git diff`?
And why in the world does git diff accept --first-parent or --pretty=fuller?!? 
That's insane for git-diff to swallow that.
(#leftoverbits?)  Also, I think you meant `REL1` one of the two times you 
wrote `REL2`, which makes me suspect you may have done some copy-edit-paste 
and didn't try this actual command.

> I expect to see only filesets 4 and 5 listed.  I also see filesets 1,
> 2 and
> 3 showing up.  This means that the git diff command is showing files
> that,in fact, did not change between the two tags.  By the way, I
> verified with a file by file comparison that under REL2 and REL1, the
> files represented by filesets 1, 2 and 3 had identical contents.

From your description, I assume you actually ran something like
  git diff --name-only REL1..REL2

which compares REL2 to the merge base of REL1 and REL2 (yes, this is totally 
counter-intuitive to a large percentage of the git userbase, but it is well 
documented and hard to change).  Also from your description, what you seem to 
want is
  git diff --name-only REL1 REL2

since you want to compare the two endpoints.  Does that help get what you 
want?

Hope that helps,
Elijah

[1] 
https://public-inbox.org/git/CABPp-BECj___HneAYviE3SB=wU6OTcBi3S=+Un1sP6L4WJ7agA@mail.gmail.com/
[2] 
https://public-inbox.org/git/CABPp-BGg_iSx3QMc-J4Fov97v9NnAtfxZGMrm3WfrGugOThjmA@mail.gmail.com/

------=_NextPart_000_0D70_01D53673.1D4863C0
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"

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
KVwwNgYDVR0fBC8wLTAroCmgJ4YlaHR0cDovL3BraS5nYS5jb20vY3JsL0dBUEtJSVBDQTAxLmNy
bDBnBggrBgEFBQcBAQRbMFkwIgYIKwYBBQUHMAGGFmh0dHA6Ly9wa2kuZ2EuY29tL29jc3AwMwYI
KwYBBQUHMAKGJ2h0dHA6Ly9wa2kuZ2EuY29tL2NlcnRzL0dBUEtJSVBDQTAxLnA3YzANBgkqhkiG
9w0BAQsFAAOCAQEAGXokWphnJ0AxcC4fCqpmGEL+kgeFy/dgD7H/Fj1slVVB4muVv/X9V5QOTDCL
C/gDiLRFKT2uP1b0Mv+hF2jlCxS9S7HTSptK89X2U//LHcyVdA1KdOlK6lJkPhqjEMLLONZMxSd9
sjArRIi2S1FPG1gawtdEOuUKpIb//rc57gK6povTYZZq0wW1f+V/vyn20W/8yEf9DB50zd8cfVxt
xv924Jbb1HlU6Nt0lAUDUIwcC6honYSlQFFwz901Q2N7s0oUEzmFGlVJRJX1U55olcCZFIQ+R9mn
lkkOP1S260KxVsbGCBOI6oZDvVtvA2OgSJ8U3/ub/3AGSKtPBZ8wgjCCBWUwggRNoAMCAQICChZW
00cAAAAAaI0wDQYJKoZIhvcNAQELBQAwYjELMAkGA1UEBhMCVVMxGDAWBgNVBAoTD0dlbmVyYWwg
QXRvbWljczEiMCAGA1UECxMZQ2VydGlmaWNhdGlvbiBBdXRob3JpdGllczEVMBMGA1UEAxMMR0FQ
S0lJVUlDQTAyMB4XDTE4MDExNzIyMjYzMVoXDTIxMDExNjIyMjYzMVowezETMBEGCgmSJomT8ixk
ARkWA2NvbTEXMBUGCgmSJomT8ixkARkWB0dBQ0VSVFMxFDASBgNVBAsTC0dBVXNlckNhcmRzMQ8w
DQYDVQQDEwZtY3Jvam8xJDAiBgkqhkiG9w0BCQEWFUpvaG4uTWNSb2JlcnRzQGdhLmNvbTCCASIw
DQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAMA0JrQsOvxHk/3gT2ekZGiiCrGk2wwIrV+hYTKw
uIoBhZ/OpREa9bwmKqEau7vfh9nexKpCcxBdsXZPiVy3WQgU/41d46enMdwEHlB90YxCSVi3rO5F
Y2qpzNIoi/juvE1WNdiphZHDHb2kFJ1+p3P6Ilz/4ECnvpW07DokdHS+Sfr+t4tSQRlC5SGQt61N
LB4dkh4Pi3ZuCD5fDJ0Qy1WgvPF2sRXYQDi1j1O6xZ5rXX1RuTRIk8/kdtNESZ/IgZdaCtrqIHpn
RAMiYAI03KApgG3xog0C7QGEGLsY8pdKEVCOwaqTnbgntBIMAm2S9wfPTCZYjscGGhaINl4j2jkC
AwEAAaOCAgIwggH+MB0GA1UdJQQWMBQGCCsGAQUFBwMEBggrBgEFBQcDAjA/BgNVHREEODA2oB0G
CisGAQQBgjcUAgOgDwwNbWNyb2pvQGdhLmNvbYEVSm9obi5NY1JvYmVydHNAZ2EuY29tMB0GA1Ud
DgQWBBTSPdq2iuJNe1ccnY/cpgmM7+d4+jAfBgNVHSMEGDAWgBQEyX/BrYjF5YBalO87Mquo78dZ
EDA3BgNVHR8EMDAuMCygKqAohiZodHRwOi8vcGtpLmdhLmNvbS9jcmwvR0FQS0lJVUlDQTAyLmNy
bDBoBggrBgEFBQcBAQRcMFowIgYIKwYBBQUHMAGGFmh0dHA6Ly9wa2kuZ2EuY29tL29jc3AwNAYI
KwYBBQUHMAKGKGh0dHA6Ly9wa2kuZ2EuY29tL2NlcnRzL0dBUEtJSVVJQ0EwMi5wN2MwDgYDVR0P
AQH/BAQDAgbAMDsGCSsGAQQBgjcVBwQuMCwGJCsGAQQBgjcVCIGR/Q/L70eRixODi6MCgaXKV3GC
qvxDh83gQAIBZAIBBTBDBgNVHSAEPDA6MDgGDCsGAQQBgZFuAQEBBTAoMCYGCCsGAQUFBwIBFhpo
dHRwOi8vcGtpLmdhLmNvbS9wb2xpY2llczAnBgkrBgEEAYI3FQoEGjAYMAoGCCsGAQUFBwMEMAoG
CCsGAQUFBwMCMA0GCSqGSIb3DQEBCwUAA4IBAQBiwV8QlXpDZaE8LtT1dXN4b0VPvCT68NfqoPGA
4kJihDwlh8c7NLp3Z/AmYTVFxH3WCqUND6zgOcPTI7n998a96/6i+hvSx6aNTlmorOOln4+J/IAI
Qv2P0uOLux7dRWSDXiNc1mFcDltAfoZusICwAiXULDFmeBcN/gqzqaOlCSvzBXno1dfG7mrflUyb
ANFjfjwdIqYZFRS5iVLGjONn7IuvDyk4U2WjFEcKbY5OcXMDAYT220/0xYig1UTvp3Mdr0sVER7t
C5Ha8+agukGLf5hgegFULaA+lzxBqYUw6OLqUbcCZMb/ZO5rqdzmIOI47SqG7OR5xV//HdXE4JSj
MIIFbzCCBFegAwIBAgIKFlbSfAAAAABojDANBgkqhkiG9w0BAQsFADBiMQswCQYDVQQGEwJVUzEY
MBYGA1UEChMPR2VuZXJhbCBBdG9taWNzMSIwIAYDVQQLExlDZXJ0aWZpY2F0aW9uIEF1dGhvcml0
aWVzMRUwEwYDVQQDEwxHQVBLSUlVSUNBMDIwHhcNMTgwMTE3MjIyNjMwWhcNMjEwMTE2MjIyNjMw
WjBVMRMwEQYKCZImiZPyLGQBGRYDY29tMRcwFQYKCZImiZPyLGQBGRYHR0FDRVJUUzEUMBIGA1UE
CxMLR0FVc2VyQ2FyZHMxDzANBgNVBAMTBm1jcm9qbzCCASIwDQYJKoZIhvcNAQEBBQADggEPADCC
AQoCggEBAJT9BDf13/gc1cihPguBPi3KHx+SEm4ky3wkUxUcWExArTwodk2xzU/2xnASYudhUTeK
j4O/Hor1T7ysVJLPlGsyiXtVYlmxo/DiqPllYhZSiLkUK84I5mYshH/pQGf+Lmj2A77lnOJOfTRe
ionJd6/oD+u8QCCTtonnCgJSXxXlxUm8lVnQDhjvpka46NV7jWIFoUHuBlNLzzWfAt1sfalpNv60
99tNZvwwp/bsb0gOqyrIrhPp53WZp5EaPbTB6NzOrBiRidm9/W3knNKN5oU2tbtGO+72SBlrOvuO
ER5FMmkbMt53HHnr0KT53U4Via+VSeUl9IqAjoqQSsQYHtkCAwEAAaOCAjIwggIuMBMGA1UdJQQM
MAoGCCsGAQUFBwMEMD8GA1UdEQQ4MDagHQYKKwYBBAGCNxQCA6APDA1tY3Jvam9AZ2EuY29tgRVK
b2huLk1jUm9iZXJ0c0BnYS5jb20wHQYDVR0OBBYEFFaR8A/fERrdaKxppNsCb2TVigAqMB8GA1Ud
IwQYMBaAFATJf8GtiMXlgFqU7zsyq6jvx1kQMDcGA1UdHwQwMC4wLKAqoCiGJmh0dHA6Ly9wa2ku
Z2EuY29tL2NybC9HQVBLSUlVSUNBMDIuY3JsMGgGCCsGAQUFBwEBBFwwWjAiBggrBgEFBQcwAYYW
aHR0cDovL3BraS5nYS5jb20vb2NzcDA0BggrBgEFBQcwAoYoaHR0cDovL3BraS5nYS5jb20vY2Vy
dHMvR0FQS0lJVUlDQTAyLnA3YzAOBgNVHQ8BAf8EBAMCBSAwOwYJKwYBBAGCNxUHBC4wLAYkKwYB
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
7uM0+Cpn+pQEQgHeD7gphNyqTISt47o+4P2eUpEclnKULQ+BigPPf5SsKWfv58fZYaapu/goSJfk
a8K7Kc7iwh4+3zp7QS4R1jgn1QHzGqg35bUNrAi2/g0e+1PoSdGvy7A2RBEU1sIT/bq5OTs7ulWB
TfXJDi4xggMjMIIDHwIBATBwMGIxCzAJBgNVBAYTAlVTMRgwFgYDVQQKEw9HZW5lcmFsIEF0b21p
Y3MxIjAgBgNVBAsTGUNlcnRpZmljYXRpb24gQXV0aG9yaXRpZXMxFTATBgNVBAMTDEdBUEtJSVVJ
Q0EwMgIKFlbTRwAAAABojTAJBgUrDgMCGgUAoIIBiDAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0xOTA3MDkyMzI2NTFaMCMGCSqGSIb3DQEJBDEWBBTaUmcn6shuUDjZ
b0oFcRPquu3WhTAkBgkqhkiG9w0BCQ8xFzAVMAoGCCqGSIb3DQMHMAcGBSsOAwIaMH8GCSsGAQQB
gjcQBDFyMHAwYjELMAkGA1UEBhMCVVMxGDAWBgNVBAoTD0dlbmVyYWwgQXRvbWljczEiMCAGA1UE
CxMZQ2VydGlmaWNhdGlvbiBBdXRob3JpdGllczEVMBMGA1UEAxMMR0FQS0lJVUlDQTAyAgoWVtJ8
AAAAAGiMMIGBBgsqhkiG9w0BCRACCzFyoHAwYjELMAkGA1UEBhMCVVMxGDAWBgNVBAoTD0dlbmVy
YWwgQXRvbWljczEiMCAGA1UECxMZQ2VydGlmaWNhdGlvbiBBdXRob3JpdGllczEVMBMGA1UEAxMM
R0FQS0lJVUlDQTAyAgoWVtJ8AAAAAGiMMA0GCSqGSIb3DQEBAQUABIIBAF5l82MKTeS81E5vwREz
VM1GObrTSAfNn9C0V7emPyyxeUuDzfZegPgSJclKEuwRNdQqb1rM7rX3HNYUMKIrnjyZKwyNKGw2
iZuf8L/1pr5FVSKjOqNRBpmv4Mu0qZUazWCpyl8FF3cFmP5jq99b7zMsPt2tVWwrbgGEGQ+Dmylt
FHDzMFLLU76U9NkxYi4mNV0MDjNfaf5Q6bdzKkkxQGDseoUpvRLcSIxcROM0e1tNKEvpzhpAP9V1
IJH45vh1r7LVrdHl6PXIvyPwH8CsMXkv0dB4IdXUg1Rr9K9hHPkMJLHd5H4mMbXVPey3IfFtfeou
0KwpE1JJMe58TENkwqgAAAAAAAA=

------=_NextPart_000_0D70_01D53673.1D4863C0--
