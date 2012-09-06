From: Enrico Weigelt <enrico.weigelt@vnc.biz>
Subject: Re: Encrypted repositories
Date: Thu, 06 Sep 2012 15:56:29 +0200 (CEST)
Message-ID: <e1f18eed-1096-4121-879a-4dd78627a4ba@zcs>
References: <7vvcfr4sq3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 06 15:56:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T9cZT-00065T-B5
	for gcvg-git-2@plane.gmane.org; Thu, 06 Sep 2012 15:56:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754925Ab2IFN4c convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 6 Sep 2012 09:56:32 -0400
Received: from zcs.vnc.biz ([83.144.240.118]:13866 "EHLO zcs.vnc.biz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754260Ab2IFN4b convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 Sep 2012 09:56:31 -0400
Received: from localhost (localhost [127.0.0.1])
	by zcs.vnc.biz (Postfix) with ESMTP id AA51C62225B;
	Thu,  6 Sep 2012 15:56:29 +0200 (CEST)
X-Virus-Scanned: amavisd-new at vnc.biz
Received: from zcs.vnc.biz ([127.0.0.1])
	by localhost (zcs.vnc.biz [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2U5LEBPo-Edz; Thu,  6 Sep 2012 15:56:29 +0200 (CEST)
Received: from zcs.vnc.biz (zcs.vnc.biz [172.17.1.118])
	by zcs.vnc.biz (Postfix) with ESMTP id 4170762203A;
	Thu,  6 Sep 2012 15:56:29 +0200 (CEST)
In-Reply-To: <7vvcfr4sq3.fsf@alter.siamese.dyndns.org>
X-Originating-IP: [92.206.119.117]
X-Mailer: Zimbra 7.1.3_GA_3346 (ZimbraWebClient - GC18 (Linux)/7.1.3_GA_3346)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204882>

Hi,

> Enrico Weigelt <enrico.weigelt@vnc.biz> writes:
>=20
> > * blobs are encrypted with their (original) content hash as
> >   encryption keys
>=20
> What does this even mean?
>=20
> Is it expected that anybody who has access to the repository can
> learn names of objects (e.g. by running "ls .git/objects/??/")? If
> so, from whom are you protecting your repository?

Well, everybody can access the objects, but they're encrypted,
so you need the repo key (which, of course isn't contained in
the repo itself ;-p) to decrypt them.

The whole tree will still be consistent even without encryption
support (so, gc etc shouldn't break), but to actually _use_ the
repo (eg. checkout or adding new commits), you'll need the
encryption support and the repo key (well, committing should
theoretically even work with diffrent repo key, even this doesn't
make much sense ;-)).

> How does this encryption interact with delta compression employed
> in pack generation?

Probably not at all ;-o
=46or the usecases I have in mind (backups, filesharing, etc) this
wouldn't hurt so much, if the objects are compressed before encryption.


cu
--=20
Mit freundlichen Gr=C3=BC=C3=9Fen / Kind regards=20

Enrico Weigelt=20
VNC - Virtual Network Consult GmbH=20
Head Of Development=20

Pariser Platz 4a, D-10117 Berlin
Tel.: +49 (30) 3464615-20
=46ax: +49 (30) 3464615-59

enrico.weigelt@vnc.biz; www.vnc.de=20
