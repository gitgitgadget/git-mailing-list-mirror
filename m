From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH] Make the rebase edit mode really end up in an edit
 state
Date: Thu, 15 Jan 2009 14:09:08 -0800
Message-ID: <7vvdsgql17.fsf@gitster.siamese.dyndns.org>
References: <87ab9th0rh.fsf@cup.kalibalik.dk>
 <7vfxjlxuu5.fsf@gitster.siamese.dyndns.org> <20090115153529.GA13961@neumann>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Anders Melchiorsen <mail@cup.kalibalik.dk>, git@vger.kernel.org,
	Johannes.Schindelin@gmx.de
To: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Thu Jan 15 23:10:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNaQJ-0006eI-3m
	for gcvg-git-2@gmane.org; Thu, 15 Jan 2009 23:10:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934851AbZAOWJU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 15 Jan 2009 17:09:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934846AbZAOWJU
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Jan 2009 17:09:20 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:43283 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934839AbZAOWJS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 15 Jan 2009 17:09:18 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 8D7F41C9ED;
	Thu, 15 Jan 2009 17:09:17 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 76BDB1C9EC; Thu,
 15 Jan 2009 17:09:11 -0500 (EST)
In-Reply-To: <20090115153529.GA13961@neumann> (SZEDER =?utf-8?Q?G=C3=A1bor?=
 =?utf-8?Q?'s?= message of "Thu, 15 Jan 2009 16:35:29 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 26E9207A-E351-11DD-8CD4-2E3B113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105883>

SZEDER G=C3=A1bor <szeder@ira.uka.de> writes:

> I think we might want do differentiate editing a commit (modifying
> either the commit message or the patch or both) or splitting a commit=
=2E
>
> The first is served well with the current 'edit' rebase command IMHO.
> I don't really see the point of the additional 'git reset --soft
> HEAD^'.
>
>  * If you want to edit the commit message only, then you are
>    better off with 'git commit --amend', because it preserves the
>    previous commit message.  But with 'git reset --soft HEAD^' and
>    'git commit' the commit message is "lost"; you have to use 'git
>    commit -c ORIG_HEAD' instead, which is not that straightforward
>    (and we don't have completion support for it).

I agree that is a true disadvantage that shows "reset --soft HEAD^" is =
a
bad idea (you could still say commit -c @{1}, though).

> For the second we could introduce a new rebase command like 'split',
> which would do the same as 'edit' but would also perform that 'git
> reset HEAD^' mentioned in the documentation automatically.

Perhaps. =20
