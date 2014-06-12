From: "W. Trevor King" <wking@tremily.us>
Subject: Re: Re: Relative submodule URLs, and forks that haven't forked
 the submodule
Date: Thu, 12 Jun 2014 11:05:43 -0700
Message-ID: <20140612180543.GA28801@odin.tremily.us>
References: <E4E16320-06C4-40C5-B561-8DAD720F0946@lltech.fr>
 <20140612152556.GH4015@paksenarrion.iveqy.com>
 <DF027A78-FAC4-4120-9259-1A3D84635BDB@lltech.fr>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3MwIy2ne0vdjdPXF"
Cc: Fredrik Gustafsson <iveqy@iveqy.com>, git@vger.kernel.org
To: Charles Brossollet <chbrosso@lltech.fr>
X-From: git-owner@vger.kernel.org Thu Jun 12 20:05:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wv9Nn-0002DF-40
	for gcvg-git-2@plane.gmane.org; Thu, 12 Jun 2014 20:05:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751210AbaFLSFr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jun 2014 14:05:47 -0400
Received: from qmta04.westchester.pa.mail.comcast.net ([76.96.62.40]:49940
	"EHLO qmta04.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751183AbaFLSFq (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Jun 2014 14:05:46 -0400
Received: from omta06.westchester.pa.mail.comcast.net ([76.96.62.51])
	by qmta04.westchester.pa.mail.comcast.net with comcast
	id DVKN1o00216LCl054W5lvX; Thu, 12 Jun 2014 18:05:45 +0000
Received: from odin.tremily.us ([24.18.63.50])
	by omta06.westchester.pa.mail.comcast.net with comcast
	id DW5k1o001152l3L3SW5k8U; Thu, 12 Jun 2014 18:05:45 +0000
Received: by odin.tremily.us (Postfix, from userid 1000)
	id 8FEE512117C1; Thu, 12 Jun 2014 11:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1402596343; bh=tHHh/N0qcQ8DbM+v57MMEoBq4h1Fh4FCmirnMqNIb9I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ndbYEKJrcuMJXk7+vxcS935hDmCkbkTa4o4e5LZbX8tQtDyoK7aBM9zEXb/hHmrfY
	 oQHCLtt+Sh0FIIclVVimTudCZaIze1irjIjZ0VyYxwYryTDIw0br5pbTPrJcIUp+up
	 0P+1g28cPUckVF6NhRPhGcnmRYwyM0XDhe4WF9ZM=
Content-Disposition: inline
In-Reply-To: <DF027A78-FAC4-4120-9259-1A3D84635BDB@lltech.fr>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.23 (2014-03-12)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20140121; t=1402596345;
	bh=uaN/j4diJQse2Wc7SWgzF6Gz1/VC4yAPsnAxIRl/kjE=;
	h=Received:Received:Received:Date:From:To:Subject:Message-ID:
	 MIME-Version:Content-Type;
	b=GEnTnjvADGhULc1rT7nxR6Z+DoFGZzVgAy8pObSPYLkxxpFsi80Q6PrsTsSTkk/pO
	 qHjOEttm0zyvULLfifxRD41ItlqTodHX/mErgma3yYdR/AT/rKRBVIlq7nEQwRu2em
	 qrQmH6HVkHQzLr514rJQjMN4tG1/hvJMYKV7POU9oKdmGSsOWbedh4M1CqO5gnczxR
	 Rj3uc1LDeQbTIxLPkdYjAjeh7T9aMO5jaqdeaXqC3BFfeAEwuWeWwVKR4W1dyfA7VJ
	 wvKUiH7NJW+GkFW1Z19+7PQZ4Fxo12KzCTwhTTIsX4n08zQZQxz2vfdzLvVTQmhTbG
	 dQEQ0O75YGPzg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251468>


--3MwIy2ne0vdjdPXF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 12, 2014 at 06:05:10PM +0200, Charles Brossollet wrote:
> The two problems I'm pointing are:
>=20
> 1. After checkout of a branch that tracks /user/main repo, call git
>    init submodule motors. Git registers it in .git/config with URL
>    /user/sub, while it should be /central/sub according to
>    documentation because origin's URL is at /central.

The logic for this is in resolve_relative_url, defined in
git-submodule.sh.  The remote it uses is calculated using
get_default_remote, defined in git-parse-remote.sh:

  get_default_remote () {
    curr_branch=3D$(git symbolic-ref -q HEAD)
    curr_branch=3D"${curr_branch#refs/heads/}"
    origin=3D$(git config --get "branch.$curr_branch.remote")
    echo ${origin:-origin}
  }

> 2. For an obscure reason, changing the url in .git/config to
> /central/sub and call git submodule update still make git want to
> clone from /user/sub, and fails. There seems to be no way to tell
> git the right URL for this submodule, while it should be possible
> according to the submodule documentation.

This is very surprising to me.  With Git v1.9.1:

* Clone just the superproject, without it's sibling submodule projects:

  $ git clone git://github.com/wking/pygrader.git pg-1

* Clone the isolated superproject, so we'll have broken relative URLs:

  $ git clone pg-1 pg-2

* Initialize a submodule:

  $ git submodule init dep/src/pyassuan

* Fix the broken, expanded-from-relative URL to point back to the
  original:

  $ git config submodule.dep/src/pyassuan.url git://github.com/wking/pyassu=
an.git

* Initial, cloning update:

  $ git submodule update

That all works as expected for me.

Cheers,
Trevor

--=20
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy

--3MwIy2ne0vdjdPXF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTmev1AAoJEG8/JgBt8ol8Ml8QALPl2R73aXgzVP5voNed9SF3
ymwbW9EpNNYrDOBNjcagVFCGbrkAXi/bKFlja+hpfM06jWiDyjp0S67s13YMknKd
aCcBXZzHbPtB1e8nw9TWjAlmXPGcEBfjtnLzofG+atg2pFGMYaViWxYTnuYvaigL
P8o77LNpP/pQpRdY4Go9b2GBToqPNftXw2aT/FDbhQAW0co8GuXzLICv5oJJcpQj
Nx9QEabM3G4MdldboiCyfm0m6W4Jx0u782h+XoFnnNgY2su4eiWij4v7i949z+eJ
3cpwdsG9gKa5Qd8gjqyxwOSP67sHPogJ6l9xOcsZYDFFkzxWngDwSk35qyLd8IaY
ZNCtjTuFepcKW8kPKRGC23dm2tqCR9JD3/PeU5YyTDxEt7/BdpANHSbekVrVO1Il
6pgnSA8NcP+O9Wg19eEGi9ldqnmKt4OAZae6Z2gmGQGnxeQQm6pvyV5D6dYumKqZ
T0smLU+oViCQNRu/efrFVwEi5WuP9MmieGtpUM6SCW9cJlxwZjkvmnbSOnRAka36
n47TG2R7JRZ2itelU1sCqjMG5cFasjcSbwVKHbJ1k1aSKpdh61KiHNByofPlKmU/
GSLdVUCOLaZua5emjDChJ4Qi96/GcsVYSLzvbblBcRBafRRedcu4lUJyVDoy06TE
acNuPiAQfT2zymfDfIlI
=r/6z
-----END PGP SIGNATURE-----

--3MwIy2ne0vdjdPXF--
