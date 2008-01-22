From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] [RFC] Design for pathname encoding gitattribute [RESEND]
Date: Tue, 22 Jan 2008 02:36:23 -0800
Message-ID: <7vprvuqh94.fsf@gitster.siamese.dyndns.org>
References: <20080122050215.DE198200A2@wilber.wgtn.cat-it.co.nz>
	<7vlk6iv0ik.fsf@gitster.siamese.dyndns.org>
	<7vr6gatidd.fsf@gitster.siamese.dyndns.org>
	<4795BE07.4040500@catalyst.net.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Peter Karlsson <peter@softwolves.pp.se>,
	Mark Junker <mjscod@web.de>,
	Pedro Melo <melo@simplicidade.org>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Dmitry Potapov <dpotapov@gmail.com>,
	Kevin Ballard <kevin@sb.org>
To: Sam Vilain <sam.vilain@catalyst.net.nz>
X-From: git-owner@vger.kernel.org Tue Jan 22 11:37:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JHGVB-0001qd-8V
	for gcvg-git-2@gmane.org; Tue, 22 Jan 2008 11:37:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755942AbYAVKgi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 22 Jan 2008 05:36:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755052AbYAVKgh
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Jan 2008 05:36:37 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:34058 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755276AbYAVKgg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 Jan 2008 05:36:36 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 431E459A1;
	Tue, 22 Jan 2008 05:36:35 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 6721A59A0;
	Tue, 22 Jan 2008 05:36:25 -0500 (EST)
In-Reply-To: <4795BE07.4040500@catalyst.net.nz> (Sam Vilain's message of "Tue,
	22 Jan 2008 22:57:27 +1300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71442>

Sam Vilain <sam.vilain@catalyst.net.nz> writes:

> On the chicken and egg thing, ...
> ...  I do agree with Dscho's point that mixing encodings in a
> repository is not necessarily a use case worth catering for.

Are you talking about "repository" as in "a specific clone", or
"a project that can be cloned by many people and checked out to
suit cloner's needs"?  I definitely agree that mixing encodings
in a project (i.e. "paths in tree objects") does not make any
sense _if_ clones of the projects _may_ want to check things out
in different pathname encodings from each other.  And if all
clones would want to check things out the same way, it does not
really matter what encoding the paths in tree objects are.

I am not absolutely sure if you are talking about mixing
encodings depending on parts of the tree in a specific clone (my
earlier "Documenta=C3=A7=C3=A3o/ja/ =E3=81=8A=E8=AA=AD=E3=81=BF=E4=B8=8B=
=E3=81=95=E3=81=84" example).  I would
certainly say it would be a very low priority for us to support
such usage, as I imagine that multi-language trees would most
likely be checked out in UTF-8 everywhere, but it _might_ be
something people may find real need for.
