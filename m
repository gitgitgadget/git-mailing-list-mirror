From: Dennis Putnam <dap1@bellsouth.net>
Subject: merge vs. rebase question
Date: Thu, 17 Jan 2013 09:14:23 -0500
Message-ID: <50F8073F.90304@bellsouth.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="----enig2QBAENWSDAGGXRNPVCHRC"
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jan 17 15:14:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TvqEv-00076f-4c
	for gcvg-git-2@plane.gmane.org; Thu, 17 Jan 2013 15:14:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755607Ab3AQOOY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jan 2013 09:14:24 -0500
Received: from nm5.access.bullet.mail.mud.yahoo.com ([66.94.237.206]:39154
	"EHLO nm5.access.bullet.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754584Ab3AQOOY (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Jan 2013 09:14:24 -0500
Received: from [66.94.237.126] by nm5.access.bullet.mail.mud.yahoo.com with NNFMP; 17 Jan 2013 14:14:22 -0000
Received: from [98.139.221.51] by tm1.access.bullet.mail.mud.yahoo.com with NNFMP; 17 Jan 2013 14:14:22 -0000
Received: from [127.0.0.1] by smtp104.sbc.mail.bf1.yahoo.com with NNFMP; 17 Jan 2013 14:14:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bellsouth.net; s=s1024; t=1358432062; bh=K5p5lR1BjXO4EdIXKmrf2yUG4gs6xq+GV0DFJr+E7QY=; h=X-Yahoo-Newman-Id:X-Yahoo-Newman-Property:X-YMail-OSG:X-Yahoo-SMTP:Received:Message-ID:Date:From:User-Agent:MIME-Version:To:Subject:X-Enigmail-Version:Content-Type; b=kMT9RggqqyvKulp4Dir859QQvWNPx9QVQx2TU5v7+oYHA1xQjTxOf5QUuSY0GP5DgfvJDBWQr58Kit0oiV9NKAOOBR3JW8vSfAntbr5UhrVqNPmbS9LT+Wkx5SE7IePv3W3zpZq6qaBcR8qRg8SqjTvkH1RLIXgxe5MGlQTMgMI=
X-Yahoo-Newman-Id: 666774.82110.bm@smtp104.sbc.mail.bf1.yahoo.com
X-Yahoo-Newman-Property: ymail-3
X-YMail-OSG: TFhU19sVM1mn7AKem9h1ICMoIUS0PJCVNTU0FC25KwYs2VS
 mAvDCvTLCHASkLmJzlsZJSHopkG4ryjIytlpr__alZPv37AU7.ysLjj6GAj2
 y.BmxyAM8OPazpcbU.Gx4wuAAz0hyC6sg8.MMbynSPTQJd_U7ZWAKKCttAXv
 duaL.Lbe1vRDofQwf.AIlfId.r4okbx_ABNJMsBo4a5eESZXw30iLgi_zFpq
 VeTAIYbRcVGwP1SA.lBdstFb_Ily6jr2qeoqI_TL0ijPBqdOEGz0Yb5XoFQy
 xxAQ68Ixgh5_yhr6xpdzK6nCUGsl.treghgLAJk.N0QIXSaA7nbk8LcOY2s4
 F7NyVcgvkOBTC4Qpw8gqvWh_lP3hArufHrE9.fi9XgAwCV0fUNM5dZFXYyQN
 39mXkraPbEUZR3tV5MDCt27pfIqxVDkMZS6l.alonqk8iF7aIoEKzT68-
X-Yahoo-SMTP: vUK3UKuswBCE01YQVYEZ1wHCa.HPSVCYhektzgdifA--
Received: from [192.168.0.100] (dap1@74.176.153.107 with plain)
        by smtp104.sbc.mail.bf1.yahoo.com with SMTP; 17 Jan 2013 06:14:22 -0800 PST
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:17.0) Gecko/20130107 Thunderbird/17.0.2
X-Enigmail-Version: 1.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213852>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
------enig2QBAENWSDAGGXRNPVCHRC
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

As a git noob I am having trouble understanding when to use which
commands. I have a repository (bare) on my Linux server. I also created
a build directory as a local repository. In my build script I do a 'git
pull' to make sure the build directory is up to date. No changes are
made to my source so this repository never does an 'add' or 'commit'.
When I run my script with 'pull', the output indicates that changes were
found and seems to have pulled them into the local directory. However,
when I look at the resulting source, none of the expected changes show
up. I then tried a 'fetch' and 'rebase'. That worked but I don't
understand why. I thought 'pull' did a 'fetch' and a 'merge' so I don't
understand why a 'fetch' and 'rebase' worked but 'fetch' and 'merge' did
not. Unless my understanding of what 'pull' does is wrong. In my case,
what should I be using in my script to assure that the build directory
is current?

Thanks.


------enig2QBAENWSDAGGXRNPVCHRC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (MingW32)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlD4Bz8ACgkQ/fiWYqZ2tVRLvACg8NOhoFFCBWcFolLGWbPqxXRK
SlUAnjvsADqSKUEzButhH+lcbYLbM+Rz
=4HFx
-----END PGP SIGNATURE-----

------enig2QBAENWSDAGGXRNPVCHRC--
