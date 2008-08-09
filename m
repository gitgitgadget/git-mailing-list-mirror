From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] tests: use $TEST_DIRECTORY to refer to the t/ directory
Date: Sat, 09 Aug 2008 16:20:36 -0700
Message-ID: <7vljz54vy3.fsf@gitster.siamese.dyndns.org>
References: <alpine.DEB.1.00.0808080752210.9611@pacific.mpi-cbg.de.mpi-cbg.de>
 <alpine.DEB.1.00.0808080754230.9611@pacific.mpi-cbg.de.mpi-cbg.de>
 <489BF95F.1070000@lsrfire.ath.cx> <7vprojgbbu.fsf@gitster.siamese.dyndns.org>
 <7vod43etuw.fsf_-_@gitster.siamese.dyndns.org> <489E1FDB.5070700@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Olivier Marin <dkr+ml.git@free.fr>
X-From: git-owner@vger.kernel.org Sun Aug 10 01:21:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KRxkv-0005H9-Fs
	for gcvg-git-2@gmane.org; Sun, 10 Aug 2008 01:21:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752815AbYHIXUr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 9 Aug 2008 19:20:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752809AbYHIXUr
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Aug 2008 19:20:47 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:63771 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752594AbYHIXUq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 9 Aug 2008 19:20:46 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 628A952840;
	Sat,  9 Aug 2008 19:20:44 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 325AA5283F; Sat,  9 Aug 2008 19:20:38 -0400 (EDT)
In-Reply-To: <489E1FDB.5070700@free.fr> (Olivier Marin's message of "Sun, 10
 Aug 2008 00:53:15 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: CA5AEA82-6669-11DD-A6FC-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91792>

Olivier Marin <dkr+ml.git@free.fr> writes:

> Junio C Hamano a =C3=A9crit :
>>=20
>> all the tests still pass, but we would want extra sets of eyeballs o=
n this
>> type of change to really make sure.
>
> OK, I read the diff and found some trivial quoting issues that will b=
reak the
> following tests if $TEST_DIRECTORY contain a space:
>
>>  t/t4101-apply-nonl.sh                    |    2 +-
>>  t/t5100-mailinfo.sh                      |   18 +++++++++---------
>>  t/t7500-commit.sh                        |   16 ++++++++--------

Ah, GIT_EDITOR is dereferenced twice.  Sheesh.

We could probably use test_set_editor() function from test-lib.sh, hmm?
