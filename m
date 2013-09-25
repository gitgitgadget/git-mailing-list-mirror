From: =?UTF-8?B?U3RlZmFuIE7DpHdl?= <stefan.naewe@atlas-elektronik.com>
Subject: Re: [Bug] git show crashes with deepened shallow clone
Date: Wed, 25 Sep 2013 17:10:08 +0200
Message-ID: <5242FCD0.8050900@atlas-elektronik.com>
References: <5242F78C.5060607@atlas-elektronik.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Sep 25 17:10:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VOqjL-0006bQ-1K
	for gcvg-git-2@plane.gmane.org; Wed, 25 Sep 2013 17:10:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755877Ab3IYPKN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 25 Sep 2013 11:10:13 -0400
Received: from mail96.atlas.de ([194.156.172.86]:21916 "EHLO mail96.atlas.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755427Ab3IYPKM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Sep 2013 11:10:12 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail96.atlas.de (Postfix) with ESMTP id 1C30E101D2
	for <git@vger.kernel.org>; Wed, 25 Sep 2013 17:10:11 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mail96.atlas.de
Received: from mail96.atlas.de ([127.0.0.1])
	by localhost (mail96.atlas.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5mUHg-cA18Hw for <git@vger.kernel.org>;
	Wed, 25 Sep 2013 17:10:10 +0200 (CEST)
Received: from mgsrv01.atlas.de (mail01.atlas.mailrelays.atlas.de [10.200.101.16])
	by mail96.atlas.de (Postfix) with ESMTP
	for <git@vger.kernel.org>; Wed, 25 Sep 2013 17:10:10 +0200 (CEST)
Received: from MSSRVS1.atlas.de (mssrvs1.atlas.de [10.200.101.71])
	by mgsrv01.atlas.de (Postfix) with ESMTP id 3709E2716A
	for <git@vger.kernel.org>; Wed, 25 Sep 2013 17:10:10 +0200 (CEST)
Received: from [10.200.54.97] (10.200.54.97) by MSSRVS1.atlas.de
 (10.200.101.71) with Microsoft SMTP Server (TLS) id 8.3.279.1; Wed, 25 Sep
 2013 17:10:10 +0200
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:24.0) Gecko/20100101 Thunderbird/24.0
In-Reply-To: <5242F78C.5060607@atlas-elektronik.com>
X-Enigmail-Version: 1.5.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235352>

Am 25.09.2013 16:47, schrieb Stefan N=C3=A4we:
> Just a quick report since I don't have time to bisect now (will do la=
ter
> if no other gitster is faster...)

Seems to be somewhere between v1.8.3.1 (OK) and v1.8.3.2 (not OK) !!


>=20
> When I execute the below script 'git show' crashes. 'git log --onelin=
e -2' gives
> for example:
>=20
>   3808bade5b76c4663ac4a3f751dc9f1ed0b08f2e three
>   error: Could not read 1e8777edeb2b7e757f74c789e679fc6c71073897
>   fatal: Failed to traverse parents of commit 0aa4ef86004f5bb29f67e97=
1d7963f5cf430c668
>=20
> gdb backtrace of one run is attached.
> It happens on 32-bit Debian (5.0.10), 64-bit openSUSE (12.2), and Win=
dows XP with git 1.8.4
> on all systems.
>=20
> The help of 'git fetch' says:
>=20
>   --depth=3D<depth>
>=20
>       Deepen or shorten the history of a shallow repository created b=
y git clone with
>       --depth=3D<depth> option (see git-clone(1)) to the specified nu=
mber of commits from
>       the tip of each remote branch history. Tags for the deepened co=
mmits are not fetched.
> ---------------------------------------------------------------------=
----------^^^^^^^^^
>=20
> But that's not true. The tag 'two' (from the script below) gets fetch=
ed when
> deepening the repository.

v1.8.3.1 fetches the tag also.


Stefan
--=20
----------------------------------------------------------------
/dev/random says: Pobody's Nerfect!
python -c "print '73746566616e2e6e616577654061746c61732d656c656b74726f6=
e696b2e636f6d'.decode('hex')"
