From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] git-help: add -i|--info option to display info page.
Date: Sun, 02 Dec 2007 01:25:42 -0800
Message-ID: <7vodd9zbvt.fsf@gitster.siamese.dyndns.org>
References: <20071202060740.269e54ad.chriscool@tuxfamily.org>
	<475272CF.40602@obry.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Christian Couder <chriscool@tuxfamily.org>, git@vger.kernel.org,
	Theodore Tso <tytso@mit.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Alex Riesen <raa.lkml@gmail.com>, Andreas Ericsson <ae@op5.se>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Eric Wong <normalperson@yhbt.net>
To: Pascal Obry <pascal@obry.net>
X-From: git-owner@vger.kernel.org Sun Dec 02 10:26:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iyl5e-0003dF-U9
	for gcvg-git-2@gmane.org; Sun, 02 Dec 2007 10:26:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751070AbXLBJZ4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 2 Dec 2007 04:25:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750996AbXLBJZ4
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Dec 2007 04:25:56 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:49844 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750944AbXLBJZy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 2 Dec 2007 04:25:54 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 8B5962EF;
	Sun,  2 Dec 2007 04:26:15 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id E924E9B09C;
	Sun,  2 Dec 2007 04:26:05 -0500 (EST)
In-Reply-To: <475272CF.40602@obry.net> (Pascal Obry's message of "Sun, 02 Dec
	2007 09:54:39 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66770>

Pascal Obry <pascal@obry.net> writes:

> Christian Couder a =C3=A9crit :
>> "git help --info XXX" will now call "info git-XXX".
>
> If would be nice if this could be more generic. For example I'd like =
to
> use Emacs woman mode instead of info. Can't we have something like
>
>    $ git help --ext XXX
>
> "ext" standing for external and calling whatever command recorded int=
o
> .gitconfig for example ?

There is a bit of conflict here.  We could do that and make the
implementation of "ext" command responsible to transform "commit" in

	$ git help --ext commit

to the location of manual page (or formatted HTML page, or node in the
info documentation).  git itself does not need to know much about where
the help material is in such an implementation.

But Christian's series is about making such "ext" thing easier to write=
=2E
No matter what kind of web browser is used, it needs to be told where
the preformatted HTML page for git-commit command is (and it does not
care where git-commit.1 manpage is found or what the node is called in
git.info document).  It makes it a bit too limiting by defining -w (web=
)
and -i (info) upfront without offering -x (ext), but we need to start
somewhere.

Having said that, I think this is a post 1.5.4 material.  Please keep
the discussion going, so that we can have something people can agree on
early after 1.5.4.
