Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B2BE61F404
	for <e@80x24.org>; Tue, 20 Mar 2018 18:34:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751522AbeCTSeu (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Mar 2018 14:34:50 -0400
Received: from esa2.arlut.utexas.edu ([66.162.93.36]:47795 "EHLO
        esa2.arlut.utexas.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751456AbeCTSet (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Mar 2018 14:34:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=arlut.utexas.edu; i=@arlut.utexas.edu; q=dns/txt;
  s=default; t=1521570890; x=1553106890;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to;
  bh=DcSXw9XXlYJFJto/qmxX08fTO++192iJzSGu4eQWDN0=;
  b=O1nBN1C/yOrHyD+TaqvJJJ5+3zk1XxxuLAdyUlw8o24IDf+mnNT0AOX8
   FnUICNiM+czCcqGq2qIltMBVYlgT0liWoGs9zubtK9jSQGaqydWnBrlqQ
   G0jrMyE09+3aLIf7qE3ukqVJ6lKenkLwaYf+0Yx4bMYccJuYAfrVAYdH3
   VRHAkyRKTGB0UVeuFohMISLSuEmHN4r+qFW+dojspir5TbeZ7oaXYns1V
   d9ykrGS/K3+ZjPLc/Gjwyqpo1olbm1QWIK582lzPmFvPuBM8fCBpHASdr
   Ipq+zAaBTuJ8IBsp3iBkKrKHGZIAchF1ZdkVGPYgAOYqmM8P584Bs3aE5
   Q==;
X-IronPort-AV: E=McAfee;i="5900,7806,8838"; a="3805302"
X-IronPort-AV: E=Sophos;i="5.48,336,1517896800"; 
   d="p7s'?scan'208";a="3805302"
Received: from intpfx2.arlut.utexas.edu ([10.14.8.123])
  by esa2.arlut.utexas.edu with ESMTP; 20 Mar 2018 13:34:49 -0500
Received: from intesa2.arlut.utexas.edu (intesa2.arlut.utexas.edu [10.14.8.33])
        by intpfx2.arlut.utexas.edu (Postfix) with ESMTP id C31FEA640A
        for <git@vger.kernel.org>; Tue, 20 Mar 2018 13:34:48 -0500 (CDT)
X-IronPort-AV: E=McAfee;i="5900,7806,8838"; a="1692210"
X-IronPort-AV: E=Sophos;i="5.48,336,1517896800"; 
   d="p7s'?scan'208";a="1692210"
Received: from footstool.arlut.utexas.edu (HELO [10.14.136.104]) ([10.14.136.104])
  by mail.arlut.utexas.edu with ESMTP; 20 Mar 2018 13:34:49 -0500
Subject: Re: Understanding Binary Deltas within Packfile
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
References: <f301d093-af93-016b-79b9-3102475260cf@arlut.utexas.edu>
 <CACsJy8ABgZy=eJ7niUysb2XZ3qUr3J+jmh_5YWZ1ZDiFCrb0tA@mail.gmail.com>
From:   Luke Robison <robison@arlut.utexas.edu>
Message-ID: <751c0493-435c-4a98-4d1c-e3d6677c62d8@arlut.utexas.edu>
Date:   Tue, 20 Mar 2018 13:34:48 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.0
MIME-Version: 1.0
In-Reply-To: <CACsJy8ABgZy=eJ7niUysb2XZ3qUr3J+jmh_5YWZ1ZDiFCrb0tA@mail.gmail.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; boundary="------------ms070202070906090708030306"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a cryptographically signed message in MIME format.

--------------ms070202070906090708030306
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US

On 3/20/2018 11:03 AM, Duy Nguyen wrote:
> On Tue, Mar 20, 2018 at 4:43 PM, Luke Robison <robison@arlut.utexas.edu=
> wrote:
>> Is there any documentation of the contents of the binary delta datain =
a
>> packfile, and how to interpret them?  I found
>> https://github.com/git/git/blob/master/Documentation/technical/pack-fo=
rmat.txt
>> documenting the packfile itself, but the "compressed delta data" seems=

>> largely undocumented.  The source code of
>> https://github.com/git/git/blob/master/diff-delta.c is pretty dense.
> The output is consumed by patch_delta()  in patch-delta.c if I'm not
> mistaken. This function is less than 100 lines, probably much easier
> to see the delta format.
Thank you, that was much easier to read, and I've got my prototype=20
working now.  I also found this site to be quite helpful:
http://stefan.saasen.me/articles/git-clone-in-haskell-from-the-bottom-up/=
#delta_encoding




--------------ms070202070906090708030306
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCC
DBIwggXYMIIEwKADAgECAhEA49LdX83bT9n/mBzOQI61QzANBgkqhkiG9w0BAQsFADCBsDEL
MAkGA1UEBhMCVVMxCzAJBgNVBAgTAlRYMQ8wDQYDVQQHEwZBdXN0aW4xKjAoBgNVBAoTIVRo
ZSBVbml2ZXJzaXR5IG9mIFRleGFzIGF0IEF1c3RpbjEkMCIGA1UECxMbSW5mb3JtYXRpb24g
U2VjdXJpdHkgT2ZmaWNlMTEwLwYDVQQDEyhUaGUgVW5pdmVyc2l0eSBvZiBUZXhhcyBhdCBB
dXN0aW4gUlNBIENBMB4XDTE1MDYyMzAwMDAwMFoXDTIwMDYyMjIzNTk1OVowgdoxDjAMBgNV
BBETBTc4NzEzMSIwIAYDVQQLExlBUEkgLSBTL01JTUUgUHJvdmlzaW9uaW5nMSowKAYDVQQK
EyFUaGUgVW5pdmVyc2l0eSBvZiBUZXhhcyBhdCBBdXN0aW4xDTALBgNVBAkTBE5vbmUxCzAJ
BgNVBAgTAlRYMQ8wDQYDVQQHEwZBdXN0aW4xCzAJBgNVBAYTAlVTMRUwEwYDVQQDEwxMdWtl
IFJvYmlzb24xJzAlBgkqhkiG9w0BCQEWGHJvYmlzb25AYXJsdXQudXRleGFzLmVkdTCCASIw
DQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAIKlD7DdPGn0V302TMj/ubEwuRzkJWyQ72Ib
Ilc/huZeg06QNf+wdMQN5iO3IUyIvChU8tMxXPBpSVznlXuztdHs0xaZq6aliXR9YKYzZj9P
q94brjYyS4SOp2joCNrJ7E1w0YP9bJjjWH853uT8aF71CRB2RKThsnN8X9y8QRxEvbrY7OaR
PUvE5jst8eIqv1k+Lqp+1LjvLQ4crCs8MGr+RnzjxtGm0vUyrICeazxGaCctbUV+XvAXttA3
ZTvZ0x9nXxb2Q0erHvLJuMu9TRPcxxTzor9OmgIfppdhaRNA2gyrYwyCPkAUeD+dPxfITEHv
5vET7IzLuB3CTctBhzcCAwEAAaOCAb8wggG7MB8GA1UdIwQYMBaAFCqrXi6ZyKt1wLy5rIhZ
eWQwKHWHMB0GA1UdDgQWBBQ48oC+d5HEdqF3sgLY25PIFRkf6TAOBgNVHQ8BAf8EBAMCBaAw
DAYDVR0TAQH/BAIwADAdBgNVHSUEFjAUBggrBgEFBQcDBAYIKwYBBQUHAwIwQgYDVR0gBDsw
OTA3BgwrBgEEAbIxAQICJAIwJzAlBggrBgEFBQcCARYZaHR0cHM6Ly9jcHMudXNlcnRydXN0
LmNvbTBPBgNVHR8ESDBGMESgQqBAhj5odHRwOi8vY3JsLnVzZXJ0cnVzdC5jb20vVGhlVW5p
dmVyc2l0eW9mVGV4YXNhdEF1c3RpblJTQUNBLmNybDCBgQYIKwYBBQUHAQEEdTBzMEoGCCsG
AQUFBzAChj5odHRwOi8vY3J0LnVzZXJ0cnVzdC5jb20vVGhlVW5pdmVyc2l0eW9mVGV4YXNh
dEF1c3RpblJTQUNBLmNydDAlBggrBgEFBQcwAYYZaHR0cDovL29jc3AudXNlcnRydXN0LmNv
bTAjBgNVHREEHDAagRhyb2Jpc29uQGFybHV0LnV0ZXhhcy5lZHUwDQYJKoZIhvcNAQELBQAD
ggEBAF9Sxw8h0rI8qwnL+un+5RsIXzwFb7auJ96Nuu5lgBx8FFCqk4u4l9gwwT7Dl9DA1Dgq
Il0nFwxbM6FycMrRzi6jnon9ACkh1gc2p7b7Qt7kU2VwxfS0NymMZoHDnL0747OwQcmQ2aPi
tNu7rSVO8vWT/CTzV9+5wfa1+9j6X3Xb6B7TKE9UQnkhU7YMT+qIrh4efpm4PYHcTEGJjl2s
Q7FKo/HIoSHXICp/xZQ/2q+y6DJzodA+p9YX6kkf/fKItei3h/yoUwejKBZPn7uE7Cs7Slde
4E3dYb2sAU9+Osw9qCcDMoul3GuD9s+2UtZt2gnEeoiixWWKiWCjW8xy+bIwggYyMIIEGqAD
AgECAhBzZHotj0biQbfb6Ecqqz5PMA0GCSqGSIb3DQEBDAUAMIGIMQswCQYDVQQGEwJVUzET
MBEGA1UECBMKTmV3IEplcnNleTEUMBIGA1UEBxMLSmVyc2V5IENpdHkxHjAcBgNVBAoTFVRo
ZSBVU0VSVFJVU1QgTmV0d29yazEuMCwGA1UEAxMlVVNFUlRydXN0IFJTQSBDZXJ0aWZpY2F0
aW9uIEF1dGhvcml0eTAeFw0xNTAyMjcwMDAwMDBaFw0yNTAyMjYyMzU5NTlaMIGwMQswCQYD
VQQGEwJVUzELMAkGA1UECBMCVFgxDzANBgNVBAcTBkF1c3RpbjEqMCgGA1UEChMhVGhlIFVu
aXZlcnNpdHkgb2YgVGV4YXMgYXQgQXVzdGluMSQwIgYDVQQLExtJbmZvcm1hdGlvbiBTZWN1
cml0eSBPZmZpY2UxMTAvBgNVBAMTKFRoZSBVbml2ZXJzaXR5IG9mIFRleGFzIGF0IEF1c3Rp
biBSU0EgQ0EwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCWZhYpkAz7tSIrPJUu
wsL/E/DijRXy3vOA1y0aPPdsfPihLOP83DLfrCcLmsyg8cChR0XqIeFzCSLIUlIeUt/ceD2u
JtyyO/R33S9eUo7VeOcuQlv7Kut2fvNlpj+vth9v96x4fqxoFJFMx+hX3eqSnFtA+BR9ltn3
A9jSz3Bwl88QlQ9z6rYoLsdTWHodN0jb5j7wnC0Ujo1jamh7vweYZPQZW9tHc4+igQ/mEbPU
VExZXtBvEI8jxvn+dE1bNapnO9pZjrgK1GqdG2LBYavUdmlTi6Ft+26UC9I4GumvQaq9VjLJ
lBz+/iqLJPtRiTB2AMGAK9jAJS6BD3vn5Rg/AgMBAAGjggFsMIIBaDAfBgNVHSMEGDAWgBRT
eb9aqitKz1SA4dibwJ3ysgNmyzAdBgNVHQ4EFgQUKqteLpnIq3XAvLmsiFl5ZDAodYcwDgYD
VR0PAQH/BAQDAgGGMBIGA1UdEwEB/wQIMAYBAf8CAQAwHQYDVR0lBBYwFAYIKwYBBQUHAwIG
CCsGAQUFBwMEMBkGA1UdIAQSMBAwDgYMKwYBBAGyMQECAiQCMFAGA1UdHwRJMEcwRaBDoEGG
P2h0dHA6Ly9jcmwudXNlcnRydXN0LmNvbS9VU0VSVHJ1c3RSU0FDZXJ0aWZpY2F0aW9uQXV0
aG9yaXR5LmNybDB2BggrBgEFBQcBAQRqMGgwPwYIKwYBBQUHMAKGM2h0dHA6Ly9jcnQudXNl
cnRydXN0LmNvbS9VU0VSVHJ1c3RSU0FBZGRUcnVzdENBLmNydDAlBggrBgEFBQcwAYYZaHR0
cDovL29jc3AudXNlcnRydXN0LmNvbTANBgkqhkiG9w0BAQwFAAOCAgEAMpNoN+kNosyjltiO
WSeEzifGzEjW6VMSLWhBStGGvVeW1obi9rn0Ts5jPzObF5ybl/8Uhh5VpSQzWtCzIsGtcljJ
hMu2sGVHpgyO756vf/0vKAOTJ0UVfzXTcMcaXWzeDo9aQUUBfDkySQ8G2qeQ3ZZd3j2ZU830
cRemxrZGFtziaNCOjxA5jkLD0LngFs7J7IMbkoBteDkt3MH5Wg61U7XtJ+MIcyUcmK4uAvpE
+SgQDOhJSsMvb3VCUHz6x2SWP9eT460ofWVGoQXDg63hv5juO2gkwfI4myBX1cObgyHma72a
/EaQF52OucdafprSdy84q8Zcd+MeEYjcTDddqM8U2+VAmQojgeXieQc0nCF7naAO40/OnPIj
mZU76+NgyZO3VNCiXrq7Y0Qa9yGFK9YZDHLbr8LOGakRhr2hS6PonDIlUVxleumxLmJHiu21
kGQj0y8TT/O96DroGhfoBY0WZNSx1dbEzkRrk3xohw6HlUUwtC3GChpApCR7Q3/mPj34hjTk
fYgPY2uLKvRjoD//FZvmxR2xKFn2LbgSziadGhl+MaEsjR+lqHcSfEsJeCJl5WtiF8OjIoTp
0kFyLhiA2KKsS0GId+HPclL94uqln35aIwT87ISY7D6J4BBLmwoWz463YjcHLlJOJEFa0teb
RwWyC4GrZEIVGBIzRtAxggSDMIIEfwIBATCBxjCBsDELMAkGA1UEBhMCVVMxCzAJBgNVBAgT
AlRYMQ8wDQYDVQQHEwZBdXN0aW4xKjAoBgNVBAoTIVRoZSBVbml2ZXJzaXR5IG9mIFRleGFz
IGF0IEF1c3RpbjEkMCIGA1UECxMbSW5mb3JtYXRpb24gU2VjdXJpdHkgT2ZmaWNlMTEwLwYD
VQQDEyhUaGUgVW5pdmVyc2l0eSBvZiBUZXhhcyBhdCBBdXN0aW4gUlNBIENBAhEA49LdX83b
T9n/mBzOQI61QzANBglghkgBZQMEAgEFAKCCAo0wGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEH
ATAcBgkqhkiG9w0BCQUxDxcNMTgwMzIwMTgzNDQ4WjAvBgkqhkiG9w0BCQQxIgQgJX8r5Fnf
wWhqenRTplzqPtlHyn3JrVoJB60lZRmKh7swbAYJKoZIhvcNAQkPMV8wXTALBglghkgBZQME
ASowCwYJYIZIAWUDBAECMAoGCCqGSIb3DQMHMA4GCCqGSIb3DQMCAgIAgDANBggqhkiG9w0D
AgIBQDAHBgUrDgMCBzANBggqhkiG9w0DAgIBKDCB1wYJKwYBBAGCNxAEMYHJMIHGMIGwMQsw
CQYDVQQGEwJVUzELMAkGA1UECBMCVFgxDzANBgNVBAcTBkF1c3RpbjEqMCgGA1UEChMhVGhl
IFVuaXZlcnNpdHkgb2YgVGV4YXMgYXQgQXVzdGluMSQwIgYDVQQLExtJbmZvcm1hdGlvbiBT
ZWN1cml0eSBPZmZpY2UxMTAvBgNVBAMTKFRoZSBVbml2ZXJzaXR5IG9mIFRleGFzIGF0IEF1
c3RpbiBSU0EgQ0ECEQDj0t1fzdtP2f+YHM5AjrVDMIHZBgsqhkiG9w0BCRACCzGByaCBxjCB
sDELMAkGA1UEBhMCVVMxCzAJBgNVBAgTAlRYMQ8wDQYDVQQHEwZBdXN0aW4xKjAoBgNVBAoT
IVRoZSBVbml2ZXJzaXR5IG9mIFRleGFzIGF0IEF1c3RpbjEkMCIGA1UECxMbSW5mb3JtYXRp
b24gU2VjdXJpdHkgT2ZmaWNlMTEwLwYDVQQDEyhUaGUgVW5pdmVyc2l0eSBvZiBUZXhhcyBh
dCBBdXN0aW4gUlNBIENBAhEA49LdX83bT9n/mBzOQI61QzANBgkqhkiG9w0BAQEFAASCAQA1
9wBLKzzHr0243IVbQrEtqG8q5keSnzYb58CAJvdL7WxHjhLT+N9/ZejOkBSoOJ4weoPrmFvq
uC5gIGOigm5LfLdgx4o5uaUkg1WlAsNgWSwuI+N/LFEidTtlZka3EWWSg2R2Zwrua5KD2K74
W9y/bA2+bLljhvYTM0mmw95Cw5dk4FtA0a+2Vc6JoZOiv82VapIUPEukftS2Ikxif3cNIiMo
Xf7fxe8D66mMlw1J6c+Gmo6znPhshaY6cdmG2nuYbP/cixe7CCyC/ZGQtFdtYz4z8D21cjk6
FIb3WF+kPqGtncWlC7DUeyHaHZ33F6l4U8qXhMZzXuzMTBFr7LOLAAAAAAAA
--------------ms070202070906090708030306--
