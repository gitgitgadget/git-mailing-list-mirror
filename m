From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-am with an initial checkin doesn't work
Date: Tue, 14 Jul 2009 11:24:10 -0700
Message-ID: <7vocrngm2d.fsf@alter.siamese.dyndns.org>
References: <4A5C9C66.1050100@dirk.my1.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Dirk =?utf-8?Q?S=C3=BCsserott?= <newsletter@dirk.my1.cc>
X-From: git-owner@vger.kernel.org Tue Jul 14 20:24:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MQmfv-0001mT-46
	for gcvg-git-2@gmane.org; Tue, 14 Jul 2009 20:24:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753331AbZGNSYQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 14 Jul 2009 14:24:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752759AbZGNSYQ
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Jul 2009 14:24:16 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:38843 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751522AbZGNSYP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Jul 2009 14:24:15 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 05A082C3F;
	Tue, 14 Jul 2009 14:24:15 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 5B1352C3E; Tue,
 14 Jul 2009 14:24:12 -0400 (EDT)
In-Reply-To: <4A5C9C66.1050100@dirk.my1.cc> ("Dirk =?utf-8?Q?S=C3=BCsserot?=
 =?utf-8?Q?t=22's?= message of "Tue\, 14 Jul 2009 16\:55\:34 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 891BB674-70A3-11DE-9EDA-B6A11443B67B-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123265>

Dirk S=C3=BCsserott <newsletter@dirk.my1.cc> writes:

> # Try to "import" the patch:
> git am 0001-initial-checkin.patch
>
> The latter yields to
> fatal: HEAD: not a valid SHA1
> fatal: bad revision 'HEAD'
>
> It works, when I
> git apply 0001-initial-checkin.patch
> instead of am'ing it, but then the thing isn't committed and I've to
> manually git-commit it.
>
> Is this a bug, intentional behavior, or am I missing some magic optio=
n
> to git-am?

The original mode of operation of the e-mail patchflow commands was to
support project members who contribute changes to _existing_ projects, =
and
maintainers to accept such changes.  The reason behind the behaviour yo=
u
are observing is merely a historical accident that nobody bothered abou=
t
use cases outside of that original purpose.  For exactly the same reaso=
n,
the original implementation of format-patch did not bother with the roo=
t
commit.

IOW, this was not an intentional behaviour, neither it was a bug.  It w=
as
simply use outside of spec, and nobody bothered until f79d4c8 (git-am:
teach git-am to apply a patch to an unborn branch, 2009-04-10), which i=
s
v1.6.3-rc1~11^2, added a support for it.

What version of git are you running?
