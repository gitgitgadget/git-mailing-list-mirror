Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 18B2720989
	for <e@80x24.org>; Mon, 10 Oct 2016 16:37:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752301AbcJJQhr (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Oct 2016 12:37:47 -0400
Received: from mail-out7.apple.com ([17.151.62.29]:54737 "EHLO
        mail-in7.apple.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752113AbcJJQhq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Oct 2016 12:37:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; d=apple.com; s=mailout2048s; c=relaxed/simple;
        q=dns/txt; i=@apple.com; t=1476117465;
        h=From:Sender:Reply-To:Subject:Date:Message-id:To:Cc:MIME-version:Content-type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-reply-to:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=MwVKRxa4q1K5Onq4PTnjR1BJ2erWXNbVJSlD3FR+HmA=;
        b=P1PCI2dg54veNb9nvG3i3+2pxgM30L9d76OD3Dh4Al4TnW8r6PtGv8oU84gcPSA0
        P+5DLmAFKD4A+m5cgOGZLJ8mh2dolR0t+/P19/vm6XSNW5KeWavIxLfvo/cuK07H
        yFa1TUNua0fnwlNWv+OSEEwTp7aid5s0Hd6kxKLHXQEpn0iOPWCKBNdxqrvh4lgV
        HcgYYedQLN/gCub5QwTAZ5WGM2W5nzKfJB+SihCZZIo7D5Feaj1AfQEhlMSnEceR
        s9T0zjLmX0m5VaNoHtp3vAxD+gbUcRgiOYmsz2t+dllV0qq4h3WDqlj/yKziF7Lb
        KRV+4SI+LU9EweOm1aAXOg==;
Received: from relay8.apple.com (relay8.apple.com [17.128.113.102])
        by mail-in7.apple.com (Apple Secure Mail Relay) with SMTP id 66.3D.07050.9D3CBF75; Mon, 10 Oct 2016 09:37:45 -0700 (PDT)
X-AuditID: 11973e16-e7d8d9a000001b8a-6c-57fbc3d9644c
Received: from kencur (kencur.apple.com [17.151.62.38])
        by relay8.apple.com (Apple SCV relay) with SMTP id F3.35.29380.9D3CBF75; Mon, 10 Oct 2016 09:37:45 -0700 (PDT)
MIME-version: 1.0
Received: from [10.0.30.3] (tc.outersquare.org [75.144.255.93])
 by kencur.apple.com
 (Oracle Communications Messaging Server 8.0.1.2.0 64bit (built Sep 28 2016))
 with ESMTPSA id <0OEU00C6MBIWOJ00@kencur.apple.com>; Mon,
 10 Oct 2016 09:37:45 -0700 (PDT)
From:   Jeremy Huddleston Sequoia <jeremyhu@apple.com>
Message-id: <9A250ABE-1B54-4AD4-8DB5-026CC4725AB9@apple.com>
Content-type: multipart/signed;
 boundary="Apple-Mail=_D910D439-05B7-412D-98DE-266A477C8F95";
 protocol="application/pkcs7-signature"; micalg=sha1
Subject: Re: [PATCH] t4014-format-patch: Adjust git_version regex to better
 handle distro changes to DEF_VER
Date:   Mon, 10 Oct 2016 09:37:44 -0700
In-reply-to: <20161010131041.lpdh4a7nol24hsz2@sigill.intra.peff.net>
Cc:     git@vger.kernel.org, Josh Triplett <josh@joshtriplett.org>,
        Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
References: <20161010025323.9415-1-jeremyhu@apple.com>
 <20161010131041.lpdh4a7nol24hsz2@sigill.intra.peff.net>
X-Mailer: Apple Mail (2.3249)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrELMWRmVeSWpSXmKPExsUi2FCYpnvz8O9wg+mTNS26rnQzWTT0XmG2
        +L8g3+JHSw+zA4vHrde2Hs969zB6XLyk7PF5k1wASxSXTUpqTmZZapG+XQJXxuXbfxgL1lhX
        nPp5kqmBcZ5FFyMnh4SAicT5y32sXYxcHEIC+xglmg9eZYRJbPi5ng0isYJRomPSUyaQBK+A
        oMSPyfdYIBLNTBI3zj9gBkkIC0hJrH7zD8xmA+q+9ec0C0SDjcT5p9fBJjELTGGUONCyjQmi
        IU/i/rUTYA0sAqoSrye+YQOxOQVcJL4vXwhWwyyQIjGrbR3YIBEBWYnvhzeCnSckUCDR9mkv
        1KmyEnvmngD7QULgNpvEpr03mSYwCs1Ccu0sZMtngQ3Wlli28DXzLEYOIFtHYvJCRoiwqcST
        t9vZIGxriZ9zHkHFFSWmdD9kX8DIvopRKDcxM0c3M89cL7GgICdVLzk/dxMjKJKm24ntYHy4
        yuoQowAHoxIP74TFv8OFWBPLiitzDzFKc7AoifOe3/ErXEggPbEkNTs1tSC1KL6oNCe1+BAj
        EwenVAMji9qJA2sn/4laVBF/snMe41VTZg9vi2NhKupcB5fIKc0vFrshLnG7X03Y/O8j3k/u
        okxxS4szL2//pnVzutmMvv2bXqgzzFP99lEt8dkuhxVXjGy2VU758/ho/Ost5/IFzN/xlfEL
        CS3aOPOz1CW/ZOVT2ku7tDSTli1fI/gk3/5HqZLkbsGfSizFGYmGWsxFxYkAzFnfvYUCAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrLLMWRmVeSWpSXmKPExsUiON1OTffm4d/hBvPPKll0XelmsmjovcJs
        8X9BvsWPlh5mBxaPW69tPZ717mH0uHhJ2ePzJrkAligum5TUnMyy1CJ9uwSujMu3/zAWrLGu
        OPXzJFMD4zyLLkZODgkBE4kNP9ezQdhiEhfugdhcHEICKxglOiY9ZQJJ8AoISvyYfI8FItHM
        JHHj/ANmkISwgJTE6jf/wGw2oEm3/pxmgWiwkTj/9DrYJGaBKYwSB1q2MUE05Encv3YCrIFF
        QFXi9cQ3YKs5BVwkvi9fCFbDLJAiMattHdggEQFZie+HNzKC2EICBRJtn/YyQpwqK7Fn7gnW
        CYwCs5AcOAvZvllgs7Qlli18zTyLkQPI1pGYvJARImwq8eTtdjYI21ri55xHUHFFiSndD9kX
        MLKvYhQoSs1JrLTQSywoyEnVS87P3cQIioiGwrQdjE3LrQ4xCnAwKvHwvlj6O1yINbGsuDL3
        EKMK0IhHG1ZfYJRiycvPS1US4WU5CJTmTUmsrEotyo8vKs1JLT7EKM3BoiTO667xI1xIID2x
        JDU7NbUgtQgmy8TBKdXAaGNwdn/uNMmZZdFTRKZX+7cueb/zvszmg8enrD6XYCLOp5S1cM6k
        lLhkxh7VL9mFapOcjpl63PQ1OGd1isFIKoal7q9jacYHq7tPXO45FJ1ekWB5IKK4m2mH4fFY
        nt1OMt8O7Vc/uKplD3vOxp4t3FMcNRcECMk928fp0jP3oaHplpJXDU3iSizFGYmGWsxFxYkA
        ro//iJACAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--Apple-Mail=_D910D439-05B7-412D-98DE-266A477C8F95
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii


> On Oct 10, 2016, at 06:10, Jeff King <peff@peff.net> wrote:
>=20
> On Sun, Oct 09, 2016 at 07:53:23PM -0700, Jeremy Huddleston Sequoia =
wrote:
>=20
>> Subject: Re: [PATCH] t4014-format-patch: Adjust git_version regex to =
better
>> handle distro changes to DEF_VER
>>=20
>> Regressed-in: 480871e09ed2e5275b4ba16b278681e5a8c122ae
>> Signed-off-by: Jeremy Huddleston Sequoia <jeremyhu@apple.com>
>=20
> I see there was a discussion elsewhere on the list about exactly what
> you are putting into DEF_VAR that causes the problem. Perhaps the =
commit
> message here would be a good place to mention that, why the current
> regex breaks it, and why your new version fixes not only it, but other
> possible values of DEF_VAR.

Thanks, I've added this blurb:

For example, git distributed with Apple's Xcode reports a version like:
    git version 2.9.3 (Apple Git-75)

Apple started doing this to help customers distinguish between different
versions of their packaged git which have the same base version (eg: =
with
different patches applied).


--Apple-Mail=_D910D439-05B7-412D-98DE-266A477C8F95
Content-Disposition: attachment;
	filename=smime.p7s
Content-Type: application/pkcs7-signature;
	name=smime.p7s
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIM5TCCBeIw
ggPKoAMCAQICEFy2SG5HDJjGf/aA22RK4o0wDQYJKoZIhvcNAQELBQAwfTELMAkGA1UEBhMCSUwx
FjAUBgNVBAoTDVN0YXJ0Q29tIEx0ZC4xKzApBgNVBAsTIlNlY3VyZSBEaWdpdGFsIENlcnRpZmlj
YXRlIFNpZ25pbmcxKTAnBgNVBAMTIFN0YXJ0Q29tIENlcnRpZmljYXRpb24gQXV0aG9yaXR5MB4X
DTE1MTIxNjAxMDAwNVoXDTMwMTIxNjAxMDAwNVowdTELMAkGA1UEBhMCSUwxFjAUBgNVBAoTDVN0
YXJ0Q29tIEx0ZC4xKTAnBgNVBAsTIFN0YXJ0Q29tIENlcnRpZmljYXRpb24gQXV0aG9yaXR5MSMw
IQYDVQQDExpTdGFydENvbSBDbGFzcyAyIENsaWVudCBDQTCCASIwDQYJKoZIhvcNAQEBBQADggEP
ADCCAQoCggEBAO4PUIyVCSOErPVQao/WN6JOIf0yCWVHPq84+tUb94TQf8nhBAtX894vxFPjFzjh
sTOygm7QiHCcRyFv5PET+rDzzDuHE4O7Dc3wVrGLHprWOnzf5Fa9kdl/vz477cZgGl6Rl9M570D8
WhNdtyDBl8tMxCh2f5yQ2dffUz/UzZ/b/tUDtAGW+KGie3IdA6UiWvJBecYjRQwIPbWiikq1bjxy
S/TBRWDyKsEoYx4PrmBM438WzD9kFsGpp2gPWO3zkUgzWqXbhZQEQHA7V3TKQIo4huByp6zd9tyN
Cmu5Q0wFsi7UwwhEyrCPH8zsi9IpxLtVhFaXT8rZvLNa8EAeH/UCAwEAAaOCAWQwggFgMA4GA1Ud
DwEB/wQEAwIBBjAdBgNVHSUEFjAUBggrBgEFBQcDAgYIKwYBBQUHAwQwEgYDVR0TAQH/BAgwBgEB
/wIBADAyBgNVHR8EKzApMCegJaAjhiFodHRwOi8vY3JsLnN0YXJ0c3NsLmNvbS9zZnNjYS5jcmww
ZgYIKwYBBQUHAQEEWjBYMCQGCCsGAQUFBzABhhhodHRwOi8vb2NzcC5zdGFydHNzbC5jb20wMAYI
KwYBBQUHMAKGJGh0dHA6Ly9haWEuc3RhcnRzc2wuY29tL2NlcnRzL2NhLmNydDAdBgNVHQ4EFgQU
mZerGDU6i1lFQ5iycnHI9PsJzxYwHwYDVR0jBBgwFoAUTgvvGqRAW6UXaYcwyjRoQ9BBrvIwPwYD
VR0gBDgwNjA0BgRVHSAAMCwwKgYIKwYBBQUHAgEWHmh0dHA6Ly93d3cuc3RhcnRzc2wuY29tL3Bv
bGljeTANBgkqhkiG9w0BAQsFAAOCAgEAmUFBBM72JPVOMDR4Q7tX/UBsG8wB+JuMCCh/GYnTWMGY
cqDSltONYidNNijFvcsGDPeZ+O+9LU+Och9vb0zJWbQb89IeOCrsTCzV0Qkw8L1dO7E9/Zz4xYuT
KcGWi1bnjYmmtb6JNZ9lp/JS3MgpbWGTRgBInzNJKPwP773JH7RSGRu+UQImR2LX563QRojschfp
xyPWt9wUV+VZf989Prh2f2OmD2zSe4m6DhaxWQQrbfpad1mgwetmaAXsIjJndPSa6pjCQBIMNxG3
0DbWj8xz4PxDoZWYpEYHeAQq862yKgdkSom/oJ0CbdrqCWijmlfdEvV4LNzwvN+zhPQhJmOvzE0x
tMaWy4doUf6y0N7Aqx+emjg3rg60AavOZV8UWwwhEQ1EexWVIR7/otWkGmOfTT7tuoQ3ep6pLEg6
tpgnXaYnTwbhic/ZTV9p0chpLnQ7lleoCK+gGX2mL/oIE1znAgyWRczIVnSwuwj70SsUO704mFfu
JYKjr1fTJ2XNePTz7YrU8rKv6Dr+9M8e6vrcmi02uHKhYQnJYSMEsDhCYld8akHm75sLA1+wWlxg
CWSIW3VGza96aBIHLergMcNs8q+vVgiZk1FIc/5Nf00/3glGSapzIP+po3u7YlXWlECXAbSenKuf
plAzVAdX6IVvBDhWosxaT/9BWj+tnLUwggb7MIIF46ADAgECAhAX8MOmbUCDPWU+X4TKPzSUMA0G
CSqGSIb3DQEBCwUAMHUxCzAJBgNVBAYTAklMMRYwFAYDVQQKEw1TdGFydENvbSBMdGQuMSkwJwYD
VQQLEyBTdGFydENvbSBDZXJ0aWZpY2F0aW9uIEF1dGhvcml0eTEjMCEGA1UEAxMaU3RhcnRDb20g
Q2xhc3MgMiBDbGllbnQgQ0EwHhcNMTYwMTI4MDUzNDA3WhcNMTgwMTI4MDUzNDA3WjBzMQswCQYD
VQQGEwJVUzETMBEGA1UECAwKQ2FsaWZvcm5pYTERMA8GA1UEBwwIV29vZHNpZGUxGTAXBgNVBAMM
EEplcmVtaWFoIFNlcXVvaWExITAfBgkqhkiG9w0BCQEWEmplcmVteWh1QGdtYWlsLmNvbTCCAiIw
DQYJKoZIhvcNAQEBBQADggIPADCCAgoCggIBANJQpjXCVgn9Bf+x34nMseNlpLX3qKn9mGqv2uh2
gBPf++z3kXVI2c92FN/lEicsvvAnuo3q0RwJvh/Z++8dW+RRuAm58adZmXEJWwf90vLzH3hFDC4W
V6slcg3e5KvtcJ+u6BzT/WFRdDGEPqsYENI0OpEJK2NcfmRzkZ+CTitMp379Z7vV3ly3l72Y/I4E
UZgYSluez4qqwlljdOVgL7aTmrJuw2ZI5CoDpj2xiwvFxFm9vyfgyyh34p2sFhSR/AWZR5rsfyoM
fw0uJ7s7a5EgdOf/dS0eeqpohBAXvfHQ0AFq4Gx++bAxWCaogskAhTxGBoc9fn85CCyiwlrfNcZZ
6+L5rY+n7JoUHRYZjwYIBieI5YQ247GkN8R+fBjIrMCDl/+7uI/1Vg/hxstsrvUyLouuOl9k3WWu
PSiSHjKZGuNnZS4z1LXDBnOtUCsyjHs79L617AyFK3Mt+W5qdUK5ChPzNYL5IcNLkkLduy6WGsZH
39n9Lruemd6qr+T9Syd1x+Zz7+4xog6DFyML89nJT7mQ1MDUVEpyX2N1GvDCgnVJ7iOQB1mL7fKg
qEdLYkihyWy3SkJrmw/Ga+GOjr0DkmrUUWIYkAOF8mWKGoigayR3RMZhWDyRxpXyFF7jtphX9Fob
Td96tP4RWs9GrfD5BGVtdhVW97SW0A3D8UkxAgMBAAGjggKHMIICgzALBgNVHQ8EBAMCBLAwHQYD
VR0lBBYwFAYIKwYBBQUHAwIGCCsGAQUFBwMEMAkGA1UdEwQCMAAwHQYDVR0OBBYEFMXHiWE0gVse
XU627q/t4qVnbDu6MB8GA1UdIwQYMBaAFJmXqxg1OotZRUOYsnJxyPT7Cc8WMG8GCCsGAQUFBwEB
BGMwYTAkBggrBgEFBQcwAYYYaHR0cDovL29jc3Auc3RhcnRzc2wuY29tMDkGCCsGAQUFBzAChi1o
dHRwOi8vYWlhLnN0YXJ0c3NsLmNvbS9jZXJ0cy9zY2EuY2xpZW50Mi5jcnQwOAYDVR0fBDEwLzAt
oCugKYYnaHR0cDovL2NybC5zdGFydHNzbC5jb20vc2NhLWNsaWVudDIuY3JsMIHjBgNVHREEgdsw
gdiBEmplcmVteWh1QGdtYWlsLmNvbYESamVyZW15aHVAYXBwbGUuY29tgRFqZXJlbXlodWRAbWFj
LmNvbYEVamVyZW15aHVAbWFjcG9ydHMub3JngRhqZXJlbXlodUBmcmVlZGVza3RvcC5vcmeBEGpl
cmVteWh1ZEBtZS5jb22BFGplcmVteWh1ZEBpY2xvdWQuY29tgRRqZXJlbXlAamVyZW15aHUuaW5m
b4EUamVyZW15QGh1ZHNjYWJpbi5jb22BFmplcmVteUBvdXRlcnNxdWFyZS5vcmcwIwYDVR0SBBww
GoYYaHR0cDovL3d3dy5zdGFydHNzbC5jb20vMFQGA1UdIARNMEswDAYKKwYBBAGBtTcGATA7Bgsr
BgEEAYG1NwECBDAsMCoGCCsGAQUFBwIBFh5odHRwOi8vd3d3LnN0YXJ0c3NsLmNvbS9wb2xpY3kw
DQYJKoZIhvcNAQELBQADggEBANa+oip18OvH6LflykKaMt8qN07CwhNKYvWcCeTCR2IDJsDUbVXB
9H8RqqAgEs7pEjRY+gdJSzf8wqPzJ5n6zpyeJH7p1Rsvdx9UEknqgJlmKjzOJ15GFWMjhWjlg05n
SKJsGmJrpIHVjxSeq+q5RVizyxYh1OyRisKmSrJdrmqHeBcKjlfQjFtdEt/LZrJ/qzH4WaRohdoN
C5vXwIxdczlEnZc1+ZfM5j39unU1GAskIgQCHrUJcublS53ysYKo6JhidGUytVB5O0k6J1J73dCZ
DOhlN/np0KmCWDYx8UgdJHhEyhyAKSWWltf2U4bPpEI4BbOKwegeRJJqK1oRW9cxggROMIIESgIB
ATCBiTB1MQswCQYDVQQGEwJJTDEWMBQGA1UEChMNU3RhcnRDb20gTHRkLjEpMCcGA1UECxMgU3Rh
cnRDb20gQ2VydGlmaWNhdGlvbiBBdXRob3JpdHkxIzAhBgNVBAMTGlN0YXJ0Q29tIENsYXNzIDIg
Q2xpZW50IENBAhAX8MOmbUCDPWU+X4TKPzSUMAkGBSsOAwIaBQCgggGZMBgGCSqGSIb3DQEJAzEL
BgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTE2MTAxMDE2Mzc0NFowIwYJKoZIhvcNAQkEMRYE
FBdr17mghkJL8RDodS8FQVFrtuTdMIGaBgkrBgEEAYI3EAQxgYwwgYkwdTELMAkGA1UEBhMCSUwx
FjAUBgNVBAoTDVN0YXJ0Q29tIEx0ZC4xKTAnBgNVBAsTIFN0YXJ0Q29tIENlcnRpZmljYXRpb24g
QXV0aG9yaXR5MSMwIQYDVQQDExpTdGFydENvbSBDbGFzcyAyIENsaWVudCBDQQIQF/DDpm1Agz1l
Pl+Eyj80lDCBnAYLKoZIhvcNAQkQAgsxgYyggYkwdTELMAkGA1UEBhMCSUwxFjAUBgNVBAoTDVN0
YXJ0Q29tIEx0ZC4xKTAnBgNVBAsTIFN0YXJ0Q29tIENlcnRpZmljYXRpb24gQXV0aG9yaXR5MSMw
IQYDVQQDExpTdGFydENvbSBDbGFzcyAyIENsaWVudCBDQQIQF/DDpm1Agz1lPl+Eyj80lDANBgkq
hkiG9w0BAQEFAASCAgCAeaarwz7R3o0F6pLU2o9BhhVcz6KXx8jE3REscKLQpizGYvwiw4dvUdJA
lmrhTvqKwO/aselJMeiQurusuWfA/OUgBrYPJ+NRUxwQeIxsIHPtqoxVfjkq+AXN6BQYfENZsjh5
MYR0A0COOOaNtdtR78ypSkMQvXLF7JQ/r79H46YyPXaXsIlGyWZk9cUZM4mcIfydxZvz1b6JmGL6
5VKEDh8O23LzFaMshDzuZV2Ol7vx9+BOqyYjvu0S9yZdAEWCCKJ7joIy8LDzXvn7EEsfAkYcycld
Bj608GiE5DNpdJud7o1lua2fKbX/zioyPVysk7j9GkEBqzc9co7Jag3LmRvQYvbS//bjPEJ2iKxu
m9wO1igThm0GUClEguKeCpKJ7It42Eltx82f0N29rz6SBtvITVNe3zus1WJ3jFwg3MxPnKp2xc9/
Kc7rBleutayk+UQJjAwH4+lRRawQYk5szdmww8EVmyGxWA4yMPOrOsi3HPiaNzE85+JHfJvv/DC9
dLN1KJWrs/kRdPxcr46kHkZAg9ycg5FxquHObQxhkxjnAkeCdT4YrIP88pB8E77Gu4U1UkZJfCE1
WmzvPiDJs3k8luJ5nFmBKK8Js80ALzUnTilcp5m6Bdjc4aMbPML4I5jGr2MGTaYNogR7bec91ePf
/1UKNGF6l0z3LXKNjQAAAAAAAA==
--Apple-Mail=_D910D439-05B7-412D-98DE-266A477C8F95--
