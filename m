Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9895320966
	for <e@80x24.org>; Thu,  6 Apr 2017 01:16:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756500AbdDFBQQ (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Apr 2017 21:16:16 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:34374 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756416AbdDFBQO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Apr 2017 21:16:14 -0400
Received: by mail-qk0-f193.google.com with SMTP id p68so4030777qke.1
        for <git@vger.kernel.org>; Wed, 05 Apr 2017 18:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=espT7q9XosXrhA15eqpfu7+zUbVXqmi14Kmv2aVhkM4=;
        b=hDKPDkFVFgq+pAkz4f+qoSVJfLEKJmxNF0gLD5PLJ5V/x0djhCo0x6tlkoz4a7ZhYG
         hgBiMqut9b7JT49a4sXo0tvleu8ut/7P/cwMVs5IBfFzSnDZWTXEiNfREE5zc2qTFw+s
         clwcYcQX+UMXx80QQkknChA80/1QF+vyucUPEu6j0X/WcKA+KG9xj9iSdLFTQHd6g0nl
         m8v4MX0FczAuE6/z6XxwtYRhWQZGCGg685ULltUvAraKeYvZ8vBqGVIDmNn7NDyTpQNP
         1sELSTXmJEBxhUpnZeby2HDOORqU+TW3RmX1d9zhFgss1Pj4eZev8GrcdC9Z0YmBLoaP
         aOyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=espT7q9XosXrhA15eqpfu7+zUbVXqmi14Kmv2aVhkM4=;
        b=WsliJjLCitL+rwXD9hxn8fJdHM6D/KN5YUvZLnbc3ufEb2+aLc7WO2+lkovdM/CrTd
         fFkpDr6PkCF5xTeqSF0ckHCMi/nVG5BEKTlEDf4uZ1q+4GiVom9lsYSfEoIG3iCtvaZt
         5G1f4JlHT+Z5hb1qIGSBn+P6/7Yjo81bPSGChtc1EVFTu68dtJv8vyOwBP8qLxnvE/P7
         DfxdELst8k5xr1T8mr/0TBKxubIyYwAbB6qOvlhU0FEFoEbD16i2KEdgxcM9uS1o3+zd
         JH50fCCuPsRQ78ILHbZFNOfb7nPVPGCU/+GNxo9X19O/OIAla7y4vufOLr/xOapQzzkJ
         aLRw==
X-Gm-Message-State: AFeK/H29NMqHcoN3e1c7d0t2zXHgQNe5yyee3vQh2Y98vj6KoVS1CVf0zLMITwr2VtKV7A==
X-Received: by 10.55.151.199 with SMTP id z190mr33272080qkd.138.1491441373596;
        Wed, 05 Apr 2017 18:16:13 -0700 (PDT)
Received: from zaya.teonanacatl.net (pool-108-11-208-204.hrbgpa.fios.verizon.net. [108.11.208.204])
        by smtp.gmail.com with ESMTPSA id a26sm38886qtb.28.2017.04.05.18.16.12
        (version=TLS1_1 cipher=AES128-SHA bits=128/128);
        Wed, 05 Apr 2017 18:16:12 -0700 (PDT)
Date:   Wed, 5 Apr 2017 21:16:10 -0400
From:   Todd Zullinger <tmz@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        "Tom G. Christensen" <tgc@jupiterrise.com>,
        Jeff King <peff@peff.net>,
        Git Mailing List <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC] dropping support for ancient versions of curl
Message-ID: <20170406011610.GF25542@zaya.teonanacatl.net>
References: <20170404025438.bgxz5sfmrawqswcj@sigill.intra.peff.net>
 <d6ba17f0-3da9-8699-8d5c-5ebf1eaef00e@jupiterrise.com>
 <CACBZZX450tRRsy-Sj8igZthYov7UxFMRJ51M-b1cgYBLo782jQ@mail.gmail.com>
 <20170406005301.4vmjkiu6qkj3g276@genre.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="L2Brqb15TUChFOBK"
Content-Disposition: inline
In-Reply-To: <20170406005301.4vmjkiu6qkj3g276@genre.crustytoothpaste.net>
User-Agent: Mutt/1.7.2 (2016-11-26)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--L2Brqb15TUChFOBK
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

brian m. carlson wrote:
> On Wed, Apr 05, 2017 at 12:51:38PM +0200, =C6var Arnfj=F6r=F0 Bjarmason w=
rote:
>> On Wed, Apr 5, 2017 at 11:33 AM, Tom G. Christensen <tgc@jupiterrise.com=
> wrote:
>> Whoah. So my assumption in=20
>> <CACBZZX78oKU5HuBEqb9qLy7--wcwhC_mW6x7Q+tB4suxohSCsQ@mail.gmail.com>
>> that nobody was compiling this & thus not reporting failures was=20
>> false. Rather there's an entire community & distribution mechanism=20
>> around patching git for older EL versions, but the patches aren't=20
>> making it upstream.
>>
>> $ grep -h -e ^Subject -e ^Date *patch=20
>> Date: Tue, 13 Oct 2009 11:34:11 +0200=20
>> Subject: [PATCH 1/7] Make NO_PERL_MAKEMAKER behave more like=20
>> Date: Fri, 13 Jun 2014 11:02:02 +0200=20
>> Subject: [PATCH 2/7] Install man pages when NO_PERL_MAKEMAKER is used=20
>> Date: Mon, 22 Sep 2014 13:42:50 +0200=20
>> Subject: [PATCH 3/7] Allow svnrdump_sim.py to be used with Python 2.2=20
>> Date: Tue, 8 Mar 2016 09:31:56 +0100=20
>> Subject: [PATCH 4/7] Handle missing HTTP_CONNECTCODE in curl < 7.10.7=20
>> Date: Tue, 23 Aug 2016 10:32:51 +0200=20
>> Subject: [PATCH 5/7] Add support for gnupg < 1.4=20
>> Date: Tue, 23 Aug 2016 18:15:13 +0200=20
>> Subject: [PATCH 6/7] Handle missing CURLINFO_SSL_DATA_{IN,OUT}=20
>> Date: Tue, 23 Aug 2016 18:26:54 +0200=20
>> Subject: [PATCH 7/7] Do not use curl_easy_strerror with curl < 7.12.0=20
>> Date: Wed, 2 Feb 2011 21:24:44 -0500=20
>> Subject: [PATCH] Restore vc-git.el for basic compatibility on EL-5=20
>> Date: Mon, 23 Mar 2009 00:03:36 -0400=20
>> Subject: [PATCH] git-cvsimport: Ignore cvsps-2.2b1 Branches: output
>>
>>> Patches can be found in the src.rpm, though I can also post them here a=
s=20
>>> patch series, they cover more than just curl.
>>>
>>> I don't use the el3 and el4 versions much any more and el5 use will als=
o=20
>>> drop of now as I'm busy converting machines from el5 to el7.
>>
>> It would be great to have them on-list, as far as I can tell they were=
=20
>> never submitted? Is there some time/administrative reason for why=20
>> you're not submitting them? Some of these are many years old, it would=
=20
>> be great to have them on-list for wider review & included so vanilla=20
>> git works on these platforms.

The vc-git.el patch which I think came from the Fedora/EPEL package=20
for EL-5 was only intended to restore functionality to support the=20
older emacs on EL-5.  Now that EL-5 is EOL, it can (thankfully, IMO)=20
die off.

The git-csvimport patch looks to be in the same category (assuming it=20
was similar to what we included in the EPEL packages for EL-5=20
support).  It was only needed (and applied) to support older systems=20
and wasn't something worth carrying upstream.

> I'm very opposed to accepting patches for operating systems that are no=
=20
> longer security supported.  Having insecure systems directly or=20
> indirectly connected to the Internet is a very bad thing, and we=20
> shouldn't make it easier for people who want to do that.

I concur.  I (or we, the Fedora/EPEL package maintainers for git) have=20
tried to ensure that the packages for the latest Fedora release build=20
cleanly for all supported Fedora and EL releases.  I think that is=20
useful for those who use CentOS/RHEL and still want to have a recent=20
git build.

I don't see any benefit in making it easier for folks to run systems=20
that are no longer receiving updates for critical security issues.   =20
It's surely hard enough to support EL-6 as it ages. ;)

> CentOS 6 and 7 are still in use and security supported, and I think=20
> we should support them.  CentOS 5 is EOL, although RHEL 5 is still=20
> supported in some cases.  RHEL 4 and earlier are definitely out of=20
> support and we shouldn't support or consider them further.

I know RHEL 5 has some extended support from Red Hat, but EPEL-5 is=20
dead.  So from my perspective, supporting EL-5 isn't worth the effort.

--=20
Todd
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Statistics are like a lamp-post to a drunken man - more for leaning on
than illumination.


--L2Brqb15TUChFOBK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.14 (GNU/Linux)

iQFDBAEBCAAtBQJY5ZbaJhhodHRwOi8vd3d3LnBvYm94LmNvbS9+dG16L3BncC90
bXouYXNjAAoJEEMlk4u+rwzj4sEIAJdBmcYuVfqmN9MKIksauK0bbnGisfgaewPJ
LD5oWpBKaQVS4eOmIS6t1S1Z060jnlVoFj34IYcUolH7o+EU2JHxiYLuuVRvJjTX
UPb3pFTgD2A1DmYZ2N1GdzRniloqicy5Q64AyyiHXqQ2jv9Gowi3rwmu8NN+0vNA
/nvsxduWMPXeJZxrkdjPOBI9YRkEakBKrBQAlND+SGfHoah7tcp0kusYWoprfsG3
Tl+8CVvZUw4fwQigUxFxaVTeIWdthtDH+z9H8YqTnNKTEe7+Jzt+GcZujpNtbv7/
1HAOoSsN8Ptk9EVgrDEFOeacazIKK600DTcIr+C2GPMQBxTO2vA=
=cda+
-----END PGP SIGNATURE-----

--L2Brqb15TUChFOBK--
