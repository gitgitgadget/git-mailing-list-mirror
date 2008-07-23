From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Rename ".dotest/" to ".git/rebase" and ".dotest-merge"
 to "rebase-merge"
Date: Wed, 23 Jul 2008 11:31:54 -0700
Message-ID: <7v1w1ke9k5.fsf@gitster.siamese.dyndns.org>
References: <73fd69b50807151408i6a916da6p7b89fe81e65fc717@mail.gmail.com>
 <20080715212211.GL6244@leksak.fem-net> <487D1B3D.70500@lsrfire.ath.cx>
 <alpine.DEB.1.00.0807160245440.2841@eeepc-johanness>
 <20080716012619.GM8185@mit.edu> <7viqv5r637.fsf@gitster.siamese.dyndns.org>
 <4882454D.2080500@free.fr> <7vd4l9zgmp.fsf@gitster.siamese.dyndns.org>
 <4884917A.1060005@free.fr> <7vk5fdiheh.fsf@gitster.siamese.dyndns.org>
 <488722F5.9030602@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Theodore Tso <tytso@mit.edu>,
	Nanako Shiraishi <nanako3@lavabit.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	=?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	Stephan Beyer <s-beyer@gmx.net>,
	Joe Fiorini <joe@faithfulgeek.org>, git@vger.kernel.org,
	Jari Aalto <jari.aalto@cante.net>
To: Olivier Marin <dkr+ml.git@free.fr>
X-From: git-owner@vger.kernel.org Wed Jul 23 20:33:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLj9D-0004NI-6D
	for gcvg-git-2@gmane.org; Wed, 23 Jul 2008 20:33:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753174AbYGWScL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 23 Jul 2008 14:32:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753083AbYGWScK
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jul 2008 14:32:10 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:62817 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751339AbYGWScJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Jul 2008 14:32:09 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id E367338D34;
	Wed, 23 Jul 2008 14:32:08 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 8809038D2D; Wed, 23 Jul 2008 14:31:57 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: A887B6CE-58E5-11DD-9CA1-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89732>

Olivier Marin <dkr+ml.git@free.fr> writes:

> Junio C Hamano a =C3=A9crit :
>>> diff --git a/git-am.sh b/git-am.sh
>> ...
>>> @@ -202,8 +202,15 @@ then
>> ...
>>> +	case "$skip,$abort" in
>>> +	t,)
>>> +		git rerere clear
>>> +		git read-tree --reset -u HEAD HEAD
>>> +		orig_head=3D$(cat "$GIT_DIR/ORIG_HEAD")
>>> +		git reset HEAD
>>> +		git update-ref ORIG_HEAD $orig_head
>>> +		;;
>> ...
> I add reset to unstage paths with no conflict that are left behind.

Does removing the last three lines (1) change the behaviour?  (2) break=
 any test?

If the answers are "Yes and No", we would need a few more tests in the
testsuite.

If the answers are "No and naturally no", then let's remove the last th=
ree
lines in the hunk.
