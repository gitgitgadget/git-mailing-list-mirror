From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-commit.sh: Fix usage checks regarding paths given when they do not make sense
Date: Mon, 05 Nov 2007 13:39:44 -0800
Message-ID: <7vlk9cnzhb.fsf@gitster.siamese.dyndns.org>
References: <1194291393-1067-1-git-send-email-B.Steinbrink@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: paolo.bonzini@lu.unisi.ch, krh@redhat.com, git@vger.kernel.org
To: =?utf-8?Q?Bj=C3=B6rn?= Steinbrink <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Mon Nov 05 22:40:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ip9fz-0007lA-Nu
	for gcvg-git-2@gmane.org; Mon, 05 Nov 2007 22:40:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752045AbXKEVjx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 5 Nov 2007 16:39:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752082AbXKEVjx
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Nov 2007 16:39:53 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:41976 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751564AbXKEVjx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 5 Nov 2007 16:39:53 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id F06B52F9;
	Mon,  5 Nov 2007 16:40:13 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 793DE9256C;
	Mon,  5 Nov 2007 16:40:09 -0500 (EST)
In-Reply-To: <1194291393-1067-1-git-send-email-B.Steinbrink@gmx.de>
 (=?utf-8?Q?Bj=C3=B6rn?=
	Steinbrink's message of "Mon, 5 Nov 2007 20:36:33 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63561>

Bj=C3=B6rn Steinbrink <B.Steinbrink@gmx.de> writes:

> The checks that looked for paths given to git-commit in addition to
> --all or --interactive expected only 3 values, while the case stateme=
nt
> actually provides 4, so the check was never triggered.
>
> The bug was introduced in 6cbf07efc5702351897dee4742525c9b9f7828ac wh=
en
> the case statement was extended to handle --interactive.

Gaah, and thanks.

We really should have "negative" tests to catch this kind of
breakage in our testsuite.  People when inventing new features
are eager to write tests to show off the new stuff works, but
not many people are careful enough to add tests to demonstrate
the commands properly catch user errors such as borked command
line options.
