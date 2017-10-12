Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0592220437
	for <e@80x24.org>; Thu, 12 Oct 2017 09:19:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752697AbdJLJT4 (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Oct 2017 05:19:56 -0400
Received: from resqmta-po-08v.sys.comcast.net ([96.114.154.167]:47720 "EHLO
        resqmta-po-08v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752615AbdJLJTz (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 12 Oct 2017 05:19:55 -0400
Received: from resomta-po-03v.sys.comcast.net ([96.114.154.227])
        by resqmta-po-08v.sys.comcast.net with ESMTP
        id 2ZelejfKsZFxg2Zeleg39s; Thu, 12 Oct 2017 09:19:55 +0000
Received: from mail.tremily.us ([67.168.186.5])
        by resomta-po-03v.sys.comcast.net with SMTP
        id 2Zcne5NxCuXCz2Zcoerfvf; Thu, 12 Oct 2017 09:17:55 +0000
Received: by mail.tremily.us (Postfix, from userid 1000)
        id 49D3DFED620; Thu, 12 Oct 2017 02:18:22 -0700 (PDT)
Date:   Thu, 12 Oct 2017 02:18:22 -0700
From:   "W. Trevor King" <wking@tremily.us>
To:     Git <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?utf-8?Q?=C5=81ukasz?= Gryglicki <lukaszgryglicki@o2.pl>
Subject: Re: [PATCH v2] pull: pass --signoff/--no-signoff to "git merge"
Message-ID: <20171012091822.GA27403@valgrind.us>
References: <18953f46ffb5e3dbc4da8fbda7fe3ab4298d7cbd.1507752482.git.wking@tremily.us>
 <51d67d6d707182d4973d9961ab29358f26c4988a.1507796638.git.wking@tremily.us>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="mP3DRpeJDSE+ciuQ"
Content-Disposition: inline
In-Reply-To: <51d67d6d707182d4973d9961ab29358f26c4988a.1507796638.git.wking@tremily.us>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.7.2 (2016-11-26)
X-CMAE-Envelope: MS4wfI4Fd9lXBboMyjBFJN/3uATHr1AMorA1YKBj9avc1gY5ThlsldPUcUwb2F1a92EA/k6IeUbNK/qmfZRHWVfRh/zOjMpJUPhjk1d3dwAh0p6zxWXICgus
 QfM8Y2foQJvPRMQulaGoOl88ipXXCEPHnD+rZpGOLkNYtMhe5Og8+vmXDJqm9Gwk0XlS0/4K65KgJMOcS1XQoMUc2YRDmRM14S0ZE5E1vkoiOWzp756gUtqE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--mP3DRpeJDSE+ciuQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 12, 2017 at 01:46:39AM -0700, W. Trevor King wrote:
> The order of options in merge-options.txt isn't clear to me, but
> I've put --signoff between --log and --stat as somewhat alphabetized
> and having an "add to the commit message" function like --log.

The order of options in merge-options.txt was intended to be by
"alphabetical groups", at least back in 7c85d274
(Documentation/merge-options.txt: order options in alphabetical
groups, 2009-10-22).  I'm not quite clear on what that means.  After
7c85d274 landed there were already long-option irregularities:

  $ git grep -h ^-- 7c85d27 -- Documentation/merge-options.txt
  --commit::
  --no-commit::
  --ff::
  --no-ff::
  --log::
  --no-log::
  --stat::
  --no-stat::
  --squash::
  --no-squash::
  --strategy=3D<strategy>::
  --summary::
  --no-summary::
  --quiet::
  --verbose::

If the order was purely alphabetical, --stat/--no-stat should have
after --squash/--no-squash, and --quiet should have been much earlier.
And putting --signoff after --log is still alphabetical in v2.15.0-rc1
(ignoring a few outliers).  So I don't think it's a reason to change
where I'd put the option, but in v3 of this patch I'll update the
commit message to cite 7c85d274 when motivating the location.

Cheers,
Trevor

--=20
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy

--mP3DRpeJDSE+ciuQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEpgNNa8H/zemHkt2gprXBz9Wld7YFAlnfM0sACgkQprXBz9Wl
d7Z3Ww/8Du4yjFatXTCi84oL/YcMP1FIBOW+hGmJZqgWXm79S5Uol46U+IWrYV4d
iT8OgIsTjJV+xVj2OWdRj0Y2zUrRrnBbtFRfQJuTiTzN4Zyxh9lWYeHRkZAsOabW
ne05awhpeQAx5jPktiFT3IQhCOphwK4zYT2R+AZWsSYaZd0h1a2DuasqyNgzusC5
c9DjW6fXFjqsoXC/dIwENTPK0gSYQH2ihRv4ybpdQrpX6OpIt9mAHROXulpIv9xC
c5lUdWIZDOHddt7T4T3s9GTT6/aGIvFtpWvvtC5+R3ZUGjDMgVj1bmggcnpn1wpG
j9KGbiAvmZzLCvJHD7R1BOcP3naVlGibJGeH35za+ozO0UY+TUUSEXnZE1yd2DAY
b7brEIqNJeRUL9NWhJnRpTO0/bYW33uHP/DIr2GXGXDCqtSP+hp7WzdwaJ0p+3Vi
EAmvTODMKWFwK2/jVDPwALzO8POXU8WIfyxrDLzLh1xyGuJXTtBisquACrkpjqt6
bHnKR29uBNuxAiNh5nSm0mHi48DYI48XKwm02MyvhAL/gS1CdIUB2CevmCDXBGmJ
TxfhVePA8WtKpEZLhbT0pKPf+ENGEgx3jNDcJZuF5qGUh9FCqVdUlMWP3NezsKfG
JbIa3tWgsI9eRs4G5WUgtdbqnszHPN3hyS5c3UEoOL0X1aHxYt0=
=AUP5
-----END PGP SIGNATURE-----

--mP3DRpeJDSE+ciuQ--
