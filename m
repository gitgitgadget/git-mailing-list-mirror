From: =?iso-8859-1?Q?Zo=EB_Blade?= <zoe@bytenoise.co.uk>
Subject: Re: [PATCH] userdiff: add support for Fountain documents
Date: Tue, 21 Jul 2015 14:23:04 +0100
Message-ID: <F67D2953-FCA5-43F8-A370-13C77B14553B@bytenoise.co.uk>
References: <1437309082-19060-1-git-send-email-zoe@bytenoise.co.uk> <xmqqegk2y1dm.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 21 15:23:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZHXVs-0008Az-U3
	for gcvg-git-2@plane.gmane.org; Tue, 21 Jul 2015 15:23:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754471AbbGUNXL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 21 Jul 2015 09:23:11 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:55791 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752045AbbGUNXK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 21 Jul 2015 09:23:10 -0400
Received: from [192.168.0.26] ([82.69.105.163]) by mrelayeu.kundenserver.de
 (mreue003) with ESMTPSA (Nemesis) id 0MT3vW-1ZOeGC3xdW-00S8ie; Tue, 21 Jul
 2015 15:23:07 +0200
In-Reply-To: <xmqqegk2y1dm.fsf@gitster.dls.corp.google.com>
X-Mailer: Apple Mail (2.1878.6)
X-Provags-ID: V03:K0:UwGEbmzyD6ENe+z+NuRViw3JvZ5XVz5mXF8RGaDPkd0zwnF4Slf
 ziKClWOfrh6+YsRIqbozAH1bKE0/zHD19rGe7U2vDV4SRt8EvJKvKu/7DAyLW5kkCZBibkl
 Ags5/7TAICBr7xF6rA9wTTJjkSWNtSKa+tuqc4ZjB8pnagoTqfjJAF28a9HaqLeWZLfavoV
 8G7xug0Pafvxpv8af+AXg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:9ePAjXviAXg=:MNk9nZADBLS31DLADWY5vB
 XEZoO0PThka5TxywxgtzipcdRsdDjBYT0tUyAb3+UFecW8zZmFjQSf8z408mp++RiksLAHut6
 Yu/Xm+3AtBg6pNtgFWOPIC5ZRJQ1iQyob9Z12cuf0SIBV8NdgJuGiIO++iSHpz1OjT1zvx7CH
 QfVPWGc6/cj/IDYKaepw5PHMCxfSYBhI36h2yHoC8vgAXIvHcBEYPFijlMms/ptFA+LuEKLPS
 SHRKz4Vf7e3X/DP01vTz9qHspy6yd8W8oh+g2P6BGO287m2fMRLs5AdAgz+hN77eZxkbT1AsV
 qIA70BVyItxb6OiP6psTZpa2furEaIFpwbqyPw/B2tRaa1DtzRRTZ2FHp8F2xJQihsoItCM2Y
 yfK2zKj54rq+u/HwyIju3c0v7hwTo+plsnsKjwCRiao0hiMRjs1TgMEWpfi0z6yiXbfVRlZ5b
 VqTXFnhSIxDFyTk63rzOr54cg47vmRnYHJwr1LKDPLk9iwmmfvBSWn4JltI+QFqUa1MuBkyXf
 0F7n5ebXCRbkoyUSnD+aZAclsLM6TjmHK/U37QSO3q0kZCI4boORIUaehwGuxt6O+iDydheNp
 vUfy4HaePovr0hyQHgtUqeEP1ghMQQmvnbX+8qD5bnZQMAY8ekwRor4AVJ+SuEUZkVruLTlsv
 RhBCri8Dkj9u7E6Pt4KivciriSURTWEEGWOXT8v7zjM4Nbg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274376>

On 20 Jul 2015, at 22:17, Junio C Hamano <gitster@pobox.com> wrote:

>> +PATTERNS("fountain", "^((\\.|(([Ii][Nn][Tt]|[Ee][Ss][Tt]|[Ee][Xx][T=
t])?\\.?|[Ii]([Nn][Tt])?\\.?/[Ee]([Xx][Tt])?\\.?) ).+)$",
>> +	 "[^ \t-]+"),
>=20
> Wouldn't IPATTERN() be a better choice here?

Good point, thank you!  Much better:

IPATTERN("fountain", "^((\\.|((int|est|ext)?\\.?|i(nt)?\\.?/e(xt)?\\.?)=
 ).+)$", "[^ \t-]+"),

It looks like some of the others might benefit from being case insensit=
ive too, but I'm not sure, and at any rate it would warrant a separate =
patch.

I'll send another revision next... :)

Thanks,
Zo=EB.