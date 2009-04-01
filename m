From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Allow curl to rewind the read buffers
Date: Wed, 01 Apr 2009 09:19:57 -0700
Message-ID: <7vbprg1h3m.fsf@gitster.siamese.dyndns.org>
References: <Pine.LNX.4.64.0904011809080.5901@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Martin =?utf-8?Q?Storsj=C3=B6?= <martin@martin.st>
X-From: git-owner@vger.kernel.org Wed Apr 01 18:21:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lp3C5-0006ok-Cf
	for gcvg-git-2@gmane.org; Wed, 01 Apr 2009 18:21:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757779AbZDAQUG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 1 Apr 2009 12:20:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756724AbZDAQUF
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Apr 2009 12:20:05 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:55618 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756520AbZDAQUE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Apr 2009 12:20:04 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 86E56A62C7;
	Wed,  1 Apr 2009 12:20:02 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 725DCA62C3; Wed,
  1 Apr 2009 12:19:59 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: F4211206-1ED8-11DE-A5C4-32B0EBB1AA3C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115400>

Martin Storsj=C3=B6 <martin@martin.st> writes:

> Rewinding of the read buffers may be needed when doing HTTP PUT or PO=
ST
> (or PROPFIND) with multi-pass authentication methods.

It may be obvious to people proficient in cURL, but I had to guess that
you perhaps meant to say "when using multi-pass authentication methods,
cURL library may need to rewind the read buffers (depending on what is =
fed
by the server), and in order to allow the library to do so, we need to
tell it how by providing the way to manipulate the buffers we supply wi=
th
these IOCTL callbacks."

Do I understand you correctly?

My point is that the your two-line statement of fact (with a bit more
explanation of the fact that follows) was clear but it was unclear to m=
e
how that fact translates to the need of what the patch does.  We would
want the commit log message to be helpful to people who look at the cod=
e 6
months down the line and wonder why these lines were added.

Please do not make me guess.  I won't claim that other people would be
even less clueful than I am, but I am reasonably sure that more than ha=
lf
of the people who read this patch would share my uneasiness of not clea=
rly
reading how your statement of fact leads to your conclusion.

Thanks.
