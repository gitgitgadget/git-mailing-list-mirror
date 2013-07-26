From: =?utf-8?B?T25kxZllaiBCw61sa2E=?= <neleai@seznam.cz>
Subject: Re: [RFC] Faster git grep.
Date: Fri, 26 Jul 2013 07:45:50 +0200
Message-ID: <20130726054550.GA23320@domone.kolej.mff.cuni.cz>
References: <20130725182905.GA7664@domone.kolej.mff.cuni.cz>
 <7vli4u4bkm.fsf@alter.siamese.dyndns.org>
 <20130725213100.GA28551@domone.kolej.mff.cuni.cz>
 <7vhafi3y99.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 26 07:46:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V2aqm-0005EW-1U
	for gcvg-git-2@plane.gmane.org; Fri, 26 Jul 2013 07:46:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751483Ab3GZFp4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 26 Jul 2013 01:45:56 -0400
Received: from popelka.ms.mff.cuni.cz ([195.113.20.131]:36958 "EHLO
	popelka.ms.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751116Ab3GZFpz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jul 2013 01:45:55 -0400
Received: from domone.kolej.mff.cuni.cz (popelka.ms.mff.cuni.cz [195.113.20.131])
	by popelka.ms.mff.cuni.cz (Postfix) with ESMTPS id BB043682AE;
	Fri, 26 Jul 2013 07:45:50 +0200 (CEST)
Received: by domone.kolej.mff.cuni.cz (Postfix, from userid 1000)
	id 8DC795FB95; Fri, 26 Jul 2013 07:45:50 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vhafi3y99.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Virus-Scanned: clamav-milter 0.97.6 at popelka.ms.mff.cuni.cz
X-Virus-Status: Clean
X-Spam-Status: No, score=-1.8 required=5.0 tests=AWL,BAYES_00,FREEMAIL_FROM,
	UNPARSEABLE_RELAY autolearn=ham version=3.3.1
X-Spam-Checker-Version: SpamAssassin 3.3.1 (2010-03-16) on
	popelka.ms.mff.cuni.cz
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231164>

On Thu, Jul 25, 2013 at 06:28:50PM -0700, Junio C Hamano wrote:
> Ond=C5=99ej B=C3=ADlka <neleai@seznam.cz> writes:
>=20
> > If grepping random commit in history is important use case then kee=
ping
> > db information in history makes sense. Otherwise just having databa=
se
> > for current version and updating it on the fly as version changes i=
s
> > enough.
>=20
> Will you reindex every time I do "git checkout next; git checkout
> master"?

This is separate issue as you would need to change index anyway, number
of changes would be proportionate to size of diff so you would not gain
much. Possible problem here is that you would end changing many files.=20
A possible solution is do rebuilding in background.

=46or switching often to different branches that are vastly different a
best solution for me seems to keep separate index for each branch.

Also data structure is trigraph: list of files with counts.
