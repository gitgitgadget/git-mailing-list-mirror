From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] BUG: git push on an empty clone segfaults.
Date: Mon, 20 Apr 2009 04:13:35 -0700
Message-ID: <7vhc0jh928.fsf@gitster.siamese.dyndns.org>
References: <1240220930-24679-1-git-send-email-Matthieu.Moy@imag.fr>
 <7vfxg3ipib.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0904201252120.6955@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: pasky@suse.cz, Matthieu Moy <Matthieu.Moy@imag.fr>,
	=?utf-8?B?Tmd1?= =?utf-8?B?eeG7hW4gVGjDoWkgTmfhu41j?= Duy 
	<pclouds@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Apr 20 13:15:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LvrTL-0005eM-9n
	for gcvg-git-2@gmane.org; Mon, 20 Apr 2009 13:15:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755020AbZDTLNs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 20 Apr 2009 07:13:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754621AbZDTLNr
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Apr 2009 07:13:47 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:64289 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754507AbZDTLNq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 20 Apr 2009 07:13:46 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 4DD81AB020;
	Mon, 20 Apr 2009 07:13:45 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 428A6AB01F; Mon,
 20 Apr 2009 07:13:37 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.00.0904201252120.6955@intel-tinevez-2-302>
 (Johannes Schindelin's message of "Mon, 20 Apr 2009 12:55:10 +0200 (CEST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 504B2A4A-2D9C-11DE-84B2-C121C5FC92D5-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116973>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Mon, 20 Apr 2009, Junio C Hamano wrote:
>
>> Matthieu Moy <Matthieu.Moy@imag.fr> writes:
>>=20
>> > Ideally, "git push" from an empty repository to another empty one
>> > should be a no-op, or perhaps should error out cleanly. Currently,=
 it
>> > just segfaults.
>>=20
>> Didn't we see this fixed by Nguy=E1=BB=85n with 55f0566 (get_local_h=
eads(): do not
>> return random pointer if there is no head, 2009-04-17)?
>
> I fetched from repo.or.cz and tested with 'master', and it was broken=
=2E =20
> Apparently git://repo.or.cz/git.git is lagging behind by 5 days.  Pas=
ky?

Unfortunately, that repository is outside of my direct control.

I push into the following four repositories:

	k.org's master repository
	git://repo.or.cz/alt-git.git/
        git://git.sourceforge.jp/gitroot/git-core/git.git
	git://git-core.git.sourceforge.net/gitroot/git-core

The k.org's master repository is mirrored (with small lag) to:

	git://git.kernel.org/pub/scm/git/git.git

I suspect that Pasky mirrors that mirror (with some lag) to:

        git://repo.or.cz/git.git

There may be some other mirrors of mirrors I do not know about.

I'd guess that people in the US are better off going to git.kernel.org,
Europeans to git://repo.or.cz/alt-git.git, and East Asians to
git.sourceforge.jp/.

I've already written about this elsewhere [*1*], but the sourceforge on=
es
are partial; they only have maint and master (and tags).


[Footnote]

*1* http://gitster.livejournal.com/31668.html
