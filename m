From: Greg Troxel <gdt@ir.bbn.com>
Subject: Re: [PATCH] contrib: Replaced /bin/sh with /bin/bash to make scripts with Bash syntax work on Solaris.
Date: Tue, 10 Aug 2010 08:33:28 -0400
Message-ID: <rmiy6cezlyf.fsf@fnord.ir.bbn.com>
References: <1281099365-11978-1-git-send-email-asgeir@twingine.no>
	<7veiebafzn.fsf@alter.siamese.dyndns.org>
	<AANLkTi=niNfKy0JgOG4hqNtXYQPfbkd10NRDDKM1rhfB@mail.gmail.com>
	<7vmxsv7n3d.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Cc: Asgeir Storesund Nilsen <asgeir@twingine.no>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 10 14:33:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oio1X-0005Ux-I5
	for gcvg-git-2@lo.gmane.org; Tue, 10 Aug 2010 14:33:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757576Ab0HJMdg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Aug 2010 08:33:36 -0400
Received: from fnord.ir.bbn.com ([192.1.100.210]:61819 "EHLO fnord.ir.bbn.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757541Ab0HJMdf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Aug 2010 08:33:35 -0400
Received: by fnord.ir.bbn.com (Postfix, from userid 10853)
	id CD006528E; Tue, 10 Aug 2010 08:33:34 -0400 (EDT)
X-Hashcash: 1:20:100810:git@vger.kernel.org::GB6gjByqPXdU2qgZ:0000000000000000000000000000000000000000002NpD
X-Hashcash: 1:20:100810:gitster@pobox.com::6ZUz7y+rHt0cQ47r:000000000000000000000000000000000000000000003kYe
X-Hashcash: 1:20:100810:asgeir@twingine.no::vtYVke/SNNtesoAY:00000000000000000000000000000000000000000004fnH
In-Reply-To: <7vmxsv7n3d.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Mon, 09 Aug 2010 09:44:06 -0700")
User-Agent: Gnus/5.110011 (No Gnus v0.11) Emacs/23.2 (berkeley-unix)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153098>

--=-=-=


Junio C Hamano <gitster@pobox.com> writes:

> Asgeir Storesund Nilsen <asgeir@twingine.no> writes:
>
>> I absolutely agree on the idea of using pure POSIX, but in reality I guess
>> most of both developer and user base are using (GNU/)Linux and thus an
>> environment where /bin/sh is in fact Bash?

The various BSDs have shells that are not bash, but which are believed
to be fully POSIX-compliant.  Putting #!/bin/bash in scripts is
nonportable and just creates work for packagers to undo this.

> For example, dash is a much lighter alternative than bash, and groks POSIX
> fine.

I believe that some GNU/Linux distributions have a /bin/sh that is not
bash.  Plus there is the /bin/sh on BSD, which is vastly smaller even if
one counts libedit:

   text    data     bss     dec     hex filename
 109602    1192    5836  116630   1c796 /bin/sh
   text    data     bss     dec     hex filename
  96523    4248    7488  108259   1a6e3 /lib/libedit.so.2.11

   text    data     bss     dec     hex filename
 716381   18328   11880  746589   b645d /usr/pkg/bin/bash


> I think a safer assumption is that /bin/sh is POSIX, and we make sure that
> the builder can countermand it with SHELL_PATH; as platforms whose /bin/sh
> is _not_ POSIX does not have to have bash as /bin/bash but somewhere else
> (e.g. /usr/local/bin/bash).

Agreed.  The current sources work well on NetBSD w.r.t. sh usage.

--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (NetBSD)

iEYEARECAAYFAkxhRxgACgkQ+vesoDJhHiUY5wCfatQMSRAETYsvYg5LbUM56MTT
5NgAnRp5l+vYmPXWoBykTaFp6tTHs9t/
=dJQt
-----END PGP SIGNATURE-----
--=-=-=--
