From: Scott Schmit <i.grok@comcast.net>
Subject: Re: [PATCH v4] rev-list: refuse --first-parent combined with --bisect
Date: Fri, 20 Mar 2015 09:02:35 -0400
Message-ID: <20150320130235.GA18772@odin.ulthar.us>
References: <1425827005-9602-1-git-send-email-me@ikke.info>
 <1425934575-19581-1-git-send-email-me@ikke.info>
 <xmqqa8zkzeq5.fsf@gitster.dls.corp.google.com>
 <20150310225509.GA5442@vps892.directvps.nl>
 <xmqqoao0xx9p.fsf@gitster.dls.corp.google.com>
 <20150311184512.GB5442@vps892.directvps.nl>
 <xmqqsidb5m2r.fsf@gitster.dls.corp.google.com>
 <20150316163306.GB11832@vps892.directvps.nl>
 <xmqqbnjsrcyz.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature";
	micalg=sha1; boundary="ikeVEW9yuYc//A+q"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 20 14:02:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YYwZZ-00063L-Fy
	for gcvg-git-2@plane.gmane.org; Fri, 20 Mar 2015 14:02:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751492AbbCTNCl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Mar 2015 09:02:41 -0400
Received: from resqmta-ch2-12v.sys.comcast.net ([69.252.207.44]:42360 "EHLO
	resqmta-ch2-12v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751034AbbCTNCk (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Mar 2015 09:02:40 -0400
Received: from resomta-ch2-03v.sys.comcast.net ([69.252.207.99])
	by resqmta-ch2-12v.sys.comcast.net with comcast
	id 5p2d1q00229Cfhx01p2fTh; Fri, 20 Mar 2015 13:02:39 +0000
Received: from odin.ulthar.us ([IPv6:2001:470:8c86:0:225:64ff:fe8b:c2f2])
	by resomta-ch2-03v.sys.comcast.net with comcast
	id 5p2d1q00J2Ekl4801p2f7e; Fri, 20 Mar 2015 13:02:39 +0000
Received: from odin.ulthar.us (localhost [127.0.0.1])
	by odin.ulthar.us (8.14.8/8.14.5) with ESMTP id t2KD2aH2024284
	for <git@vger.kernel.org>; Fri, 20 Mar 2015 09:02:36 -0400
Received: (from draco@localhost)
	by odin.ulthar.us (8.14.8/8.14.8/Submit) id t2KD2ZBN024283
	for git@vger.kernel.org; Fri, 20 Mar 2015 09:02:35 -0400
Content-Disposition: inline
In-Reply-To: <xmqqbnjsrcyz.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20140121; t=1426856559;
	bh=kgmwmztvM52Zk+dDJXoyBFqO8rYG3CWOdVUCbTS7nI0=;
	h=Received:Received:Received:Received:Date:From:To:Subject:
	 Message-ID:MIME-Version:Content-Type;
	b=fd3IhgV4ulGkc9q1rlv4uoERKPaUasuM5DdHIGCTnoGZDUSXzzAaLatCfWR2075HL
	 BTD5MbRTZFrJMWdezxxVR3sQH9LpBoLI8JkXPfhB522RPvKHhXlgueWMztzCpedE3C
	 WSKZrQMfM2axG6X2Lh2v+T/O2Zz3v3VY7TK7MHH7r3AIJfk0LDrgZ2TrxG6m5A2hKS
	 QApcU1PPYdOqqUkb+0CdtCWCzgqDSJw6ANW/ThBPTi3A4SecVQJIK9Bkfru5pq5ZvZ
	 VI8xDAE71yslb5EoZB/o2ErSKxo1n4Zk2035P0Z997VE8MCtyOH5YQOO/yzgOD2vGT
	 7LdExtNAYUJ/A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265903>


--ikeVEW9yuYc//A+q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 16, 2015 at 11:53:08AM -0700, Junio C Hamano wrote:
> Because the history is not linear in Git, bisection works by
> shrinking a subgraph of the history DAG that contains "yet to be
> tested, suspected to have introduced a badness" commits.  The
> subgraph is defined as anything reachable from _the_ "bad" commit
> (initially, the one you give to the command when you start) that are
> not reachable from any of the "good" commits.
>=20
> Suppose you started from this graph.  Time flows left to right as
> usual.
>=20
>   ---0---2---4---6---8---9
>       \             /
>        1---3---5---7
>=20
> Then mark the initial good and bad commits as G and B.
>=20
>   ---G---2---4---6---8---B
>       \             /
>        1---3---5---7
>=20
> And imagine that you are asked to check 4, which turns out to be
> good.  We do not _move_ G to 4; we mark 4 as good, while keeping
> 0 also as good.
>=20
>   ---G---2---G---6---8---B
>       \             /
>        1---3---5---7
>=20
> And if you are next asked to check 5, and mark it as good, the graph
> will become like this:
>=20
>   ---G---2---G---6---8---B
>       \             /
>        1---3---G---7
>=20
> Of course, at this point, the subgraph of suspects are 6, 7, 8 and
> 9, and the subgraph no longer is affected by the fact that 0 is
> good.  But it is crucial to keep 0 marked as good in the step before
> this one, before you tested 5, as that is what allows us not having
> to test any ancestors of 0 at all.
>=20
> Now, one may wonder why we need multiple "good" commits but we do
> not need multiple "bad" commits.  This comes from the nature of
> "bisection", which is a tool to find a _single_ breakage [*1*], and
> a fundamental assumption is that a breakage does not fix itself.
>=20
> Hence, if you have a history that looks like this:
>=20
>=20
>    G...1---2---3---4---6---8---B
>                     \
>                      5---7---B
>=20
> it follows that 4 must also be "bad".  It used to be good long time
> ago somewhere before 1, and somewhere along way on the history,
> there was a single breakage event that we are hunting for.  That
> single event cannot be 5, 6, 7 or 8 because breakage at say 5 would
> not explain why the tip of the upper branch is broken---its breakage
> has no way to propagate there.  The breakage must have happened at 4
> or before that commit.

But what if 7 & 8 are the same patch, cherry-picked?  Or nearly the same
patch, but with some conflict resolution?

Couldn't that lead to the case that 4, 5, and 6 are good, while 7 & 8
are bad?  Or does that violate the "single breakage" rule in a way that
might be too subtle for some users?

--=20
Scott Schmit

--ikeVEW9yuYc//A+q
Content-Type: application/x-pkcs7-signature
Content-Disposition: attachment; filename="smime.p7s"
Content-Transfer-Encoding: base64

MIIPLwYJKoZIhvcNAQcCoIIPIDCCDxwCAQExCzAJBgUrDgMCGgUAMAsGCSqGSIb3DQEHAaCC
DGAwggY0MIIEHKADAgECAgEeMA0GCSqGSIb3DQEBBQUAMH0xCzAJBgNVBAYTAklMMRYwFAYD
VQQKEw1TdGFydENvbSBMdGQuMSswKQYDVQQLEyJTZWN1cmUgRGlnaXRhbCBDZXJ0aWZpY2F0
ZSBTaWduaW5nMSkwJwYDVQQDEyBTdGFydENvbSBDZXJ0aWZpY2F0aW9uIEF1dGhvcml0eTAe
Fw0wNzEwMjQyMTAxNTVaFw0xNzEwMjQyMTAxNTVaMIGMMQswCQYDVQQGEwJJTDEWMBQGA1UE
ChMNU3RhcnRDb20gTHRkLjErMCkGA1UECxMiU2VjdXJlIERpZ2l0YWwgQ2VydGlmaWNhdGUg
U2lnbmluZzE4MDYGA1UEAxMvU3RhcnRDb20gQ2xhc3MgMSBQcmltYXJ5IEludGVybWVkaWF0
ZSBDbGllbnQgQ0EwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDHCYPMzi3YGrEp
pC4Tq5a+ijKDjKaIQZZVR63UbxIP6uq/I0fhCu+cQhoUfE6ERKKnu8zPf1Jwuk0tsvVCk6U9
b+0UjM0dLep3ZdE1gblK/1FwYT5Pipsu2yOMluLqwvsuz9/9f1+1PKHG/FaR/wpbfuIqu54q
zHDYeqiUfsYzoVflR80DAC7hmJ+SmZnNTWyUGHJbBpA8Q89lGxahNvuryGaC/o2/ceD2uYDX
9U8Eg5DpIpGQdcbQeGarV04WgAUjjXX5r/2dabmtxWMZwhZna//jdiSyrrSMTGKkDiXm6/3/
4ebfeZuCYKzN2P8O2F/Xe2AC/Y7zeEsnR7FOp+uXAgMBAAGjggGtMIIBqTAPBgNVHRMBAf8E
BTADAQH/MA4GA1UdDwEB/wQEAwIBBjAdBgNVHQ4EFgQUU3Ltkpzg2ssBXHx+ljVO8tS4UYIw
HwYDVR0jBBgwFoAUTgvvGqRAW6UXaYcwyjRoQ9BBrvIwZgYIKwYBBQUHAQEEWjBYMCcGCCsG
AQUFBzABhhtodHRwOi8vb2NzcC5zdGFydHNzbC5jb20vY2EwLQYIKwYBBQUHMAKGIWh0dHA6
Ly93d3cuc3RhcnRzc2wuY29tL3Nmc2NhLmNydDBbBgNVHR8EVDBSMCegJaAjhiFodHRwOi8v
d3d3LnN0YXJ0c3NsLmNvbS9zZnNjYS5jcmwwJ6AloCOGIWh0dHA6Ly9jcmwuc3RhcnRzc2wu
Y29tL3Nmc2NhLmNybDCBgAYDVR0gBHkwdzB1BgsrBgEEAYG1NwECATBmMC4GCCsGAQUFBwIB
FiJodHRwOi8vd3d3LnN0YXJ0c3NsLmNvbS9wb2xpY3kucGRmMDQGCCsGAQUFBwIBFihodHRw
Oi8vd3d3LnN0YXJ0c3NsLmNvbS9pbnRlcm1lZGlhdGUucGRmMA0GCSqGSIb3DQEBBQUAA4IC
AQAKgwh9eKssBly4Y4xerhy5I3dNoXHYfYa8PlVLL/qtXnkFgdtY1o95CfegFJTwqBBmf8py
TUnFsukDFUI22zF5bVHzuJ+GxhnSqN2sD1qetbYwBYK2iyYA5Pg7Er1A+hKMIzEzcduRkIMm
CeUTyMyikfbUFvIBivtvkR8ZFAk22BZy+pJfAoedO61HTz4qSfQoCRcLN5A0t4DkuVhTMXIz
uQ8CnykhExD6x4e6ebIbrjZLb7L+ocR0y4YjCl/Pd4MXU91y0vTipgr/O75CDUHDRHCCKBVm
z/Rzkc/b970MEeHt5LC3NiWTgBSvrLEuVzBKM586YoRD9Dy3OHQgWI270g+5MYA8GfgI/EPT
5G7xPbCDz+zjdH89PeR3U4So4lSXur6H6vp+m9TQXPF3a0LwZrp8MQ+Z77U1uL7TelWO5lAp
sbAonrqASfTpaprFVkL4nyGH+NHST2ZJPWIBk81i6Vw0ny0qZW2Niy/QvVNKbb43A43ny076
khXO7cNbBIRdJ/6qQNq9Bqb5C0Q5nEsFcj75oxQRqlKf6TcvGbjxkJh8BYtv9ePsXklAxtm8
J7GCUBthHSQgepbkOexhJ0wP8imUkyiPHQ0GvEnd83129fZjoEhdGwXV27ioRKbj/cIq7JRX
un0NbeY+UdMYu9jGfIpDLtUUGSgsg2zMGs5R4jCCBiQwggUMoAMCAQICAwo/3zANBgkqhkiG
9w0BAQsFADCBjDELMAkGA1UEBhMCSUwxFjAUBgNVBAoTDVN0YXJ0Q29tIEx0ZC4xKzApBgNV
BAsTIlNlY3VyZSBEaWdpdGFsIENlcnRpZmljYXRlIFNpZ25pbmcxODA2BgNVBAMTL1N0YXJ0
Q29tIENsYXNzIDEgUHJpbWFyeSBJbnRlcm1lZGlhdGUgQ2xpZW50IENBMB4XDTE0MDYxNjAw
NDQ1NVoXDTE1MDYxNjE3MzYyNFowQDEbMBkGA1UEAwwSaS5ncm9rQGNvbWNhc3QubmV0MSEw
HwYJKoZIhvcNAQkBFhJpLmdyb2tAY29tY2FzdC5uZXQwggEiMA0GCSqGSIb3DQEBAQUAA4IB
DwAwggEKAoIBAQC3HoziY3IySZbVkCfbjfgjTKO5CISA2+1GKzBNbzycTCXBWLnHvzrlFPlI
17z3noLux8ebSYz+TFiCUuVdwKkFOpN0WWxGzD6K/Hb0AJtKZp62YKtyRkCV51n5NrEepo28
hFkRhjgSkZA9t/4vtaWt0Ds8pIpUoQ1sNaUDWzjJ3UALl7m6b3XZmIouND+jq1AQv0ivMLuk
QNXO2a0KcuRVHDhAEdBvTi9LSePi8+Q8UWWBOeWmGhiKwL5X98Ne03GKxxQnLXDJbrX+cNcC
uaZIPdrmhbZCo+zegLfrApLRu9/6ox6/dnRsvmMpGcjNKLCgKoEh4cwyb+mhyzPXWlpXAgMB
AAGjggLYMIIC1DAJBgNVHRMEAjAAMAsGA1UdDwQEAwIEsDAdBgNVHSUEFjAUBggrBgEFBQcD
AgYIKwYBBQUHAwQwHQYDVR0OBBYEFKtASVM24m5BiMPABLNlKft1oxbCMB8GA1UdIwQYMBaA
FFNy7ZKc4NrLAVx8fpY1TvLUuFGCMB0GA1UdEQQWMBSBEmkuZ3Jva0Bjb21jYXN0Lm5ldDCC
AUwGA1UdIASCAUMwggE/MIIBOwYLKwYBBAGBtTcBAgMwggEqMC4GCCsGAQUFBwIBFiJodHRw
Oi8vd3d3LnN0YXJ0c3NsLmNvbS9wb2xpY3kucGRmMIH3BggrBgEFBQcCAjCB6jAnFiBTdGFy
dENvbSBDZXJ0aWZpY2F0aW9uIEF1dGhvcml0eTADAgEBGoG+VGhpcyBjZXJ0aWZpY2F0ZSB3
YXMgaXNzdWVkIGFjY29yZGluZyB0byB0aGUgQ2xhc3MgMSBWYWxpZGF0aW9uIHJlcXVpcmVt
ZW50cyBvZiB0aGUgU3RhcnRDb20gQ0EgcG9saWN5LCByZWxpYW5jZSBvbmx5IGZvciB0aGUg
aW50ZW5kZWQgcHVycG9zZSBpbiBjb21wbGlhbmNlIG9mIHRoZSByZWx5aW5nIHBhcnR5IG9i
bGlnYXRpb25zLjA2BgNVHR8ELzAtMCugKaAnhiVodHRwOi8vY3JsLnN0YXJ0c3NsLmNvbS9j
cnR1MS1jcmwuY3JsMIGOBggrBgEFBQcBAQSBgTB/MDkGCCsGAQUFBzABhi1odHRwOi8vb2Nz
cC5zdGFydHNzbC5jb20vc3ViL2NsYXNzMS9jbGllbnQvY2EwQgYIKwYBBQUHMAKGNmh0dHA6
Ly9haWEuc3RhcnRzc2wuY29tL2NlcnRzL3N1Yi5jbGFzczEuY2xpZW50LmNhLmNydDAjBgNV
HRIEHDAahhhodHRwOi8vd3d3LnN0YXJ0c3NsLmNvbS8wDQYJKoZIhvcNAQELBQADggEBALTg
t4rndUh0up2qJuskCTx4iRQd59+R0kOm7vJa94t+fSa8Wip4WeVOJZaHs1XIp17yoLTzcXN9
+L5lTC7HaHrBGOdB8su0muQyS///XwbDgn3/9+D0stPJZYLMrfRSm/FzQEk5j5McmODTCq8a
tQrlQilnBDcY00CYKBTKGAleOPjQ8yg/QVb/uqNuKE88+mfEdc6AKykYg7VXqxdL54ylqR3o
P8+PsP1YgCE2wqWWfGUp6hxIKa2XGtqVdHqL1yc5equX97TiUiIQ51j+nmU8tXTuR7OPRA1B
cHA+jx6rchpnZMEJn9DYPFOvkkC86mxOCax9r5HOtdidcw8uZSoxggKXMIICkwIBATCBlDCB
jDELMAkGA1UEBhMCSUwxFjAUBgNVBAoTDVN0YXJ0Q29tIEx0ZC4xKzApBgNVBAsTIlNlY3Vy
ZSBEaWdpdGFsIENlcnRpZmljYXRlIFNpZ25pbmcxODA2BgNVBAMTL1N0YXJ0Q29tIENsYXNz
IDEgUHJpbWFyeSBJbnRlcm1lZGlhdGUgQ2xpZW50IENBAgMKP98wCQYFKw4DAhoFAKCB2DAY
BgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0xNTAzMjAxMzAyMzVa
MCMGCSqGSIb3DQEJBDEWBBQKiNfp+qj9AhtR2SG1NGevn1v82zB5BgkqhkiG9w0BCQ8xbDBq
MAsGCWCGSAFlAwQBKjALBglghkgBZQMEARYwCwYJYIZIAWUDBAECMAoGCCqGSIb3DQMHMA4G
CCqGSIb3DQMCAgIAgDANBggqhkiG9w0DAgIBQDAHBgUrDgMCBzANBggqhkiG9w0DAgIBKDAN
BgkqhkiG9w0BAQEFAASCAQCGId3TnAgypfbh0mZtxv2U1lrAQTqj8Zn/RNT9QnSvDTYFjhR2
WQwwnj2hsrSOTefsSE4PxbKt2JsxSJJjK/8MepCYV19p6HbUfjzk4YzqSY+/Q2bUo0vJG+w+
vge3NRyVczulreaXlxKt2GsF/cmYge/zvvr7tPMptQum+qKxEnu+hKAYVWYJIJzMvjQYRpkw
FGwe8pQn0qMCEOjpA9wPhwInfjt0jDIZln1L2ylwMDZRpxZRvcKge5LPR4sAX1yHp7kam5l6
+csjPMB4bmL+3WLCWvPMoWK7Ufl3MkaJVAZNi8R4Ks0/i67C0ynAGr9YpGAh1QD9DrQUq7pV
09t+

--ikeVEW9yuYc//A+q--
