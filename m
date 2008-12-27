From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] grep: grep cache entries if they are "assume
 unchanged"
Date: Sat, 27 Dec 2008 14:39:59 -0800
Message-ID: <7vy6y1b5ts.fsf@gitster.siamese.dyndns.org>
References: <1230366064-1306-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Daniel Barkalow <barkalow@iabervon.org>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Dec 27 23:43:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LGhrz-0002kS-Cg
	for gcvg-git-2@gmane.org; Sat, 27 Dec 2008 23:42:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753681AbYL0WkL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 27 Dec 2008 17:40:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752979AbYL0WkL
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Dec 2008 17:40:11 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:35558 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751588AbYL0WkJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 27 Dec 2008 17:40:09 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 5D7A81B30E;
	Sat, 27 Dec 2008 17:40:07 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 000091B30A; Sat,
 27 Dec 2008 17:40:02 -0500 (EST)
In-Reply-To: <1230366064-1306-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Tmd1eeG7hW4gVGjDoWkJTmfhu41j?= Duy's message of "Sat, 27 Dec 2008
 15:21:03 +0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 4FA1BDB8-D467-11DD-81B7-F83E113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104028>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> ... External grep case has not been fixed yet. But given that
> on the platform that CE_VALID bit may be used like Windows, external
> grep is not available anyway, I would wait for people to raise their
> hands before touching it.

My gut feeling is that it would suffice to always use the internal grep=
 if
there is any index entry with CE_VALID set.  Having the bit is an unusu=
al
case.

Also I am guessing that your above statement that users on Windows woul=
d
be the ones who want CE_VALID implies that CE_VALID is for platforms wh=
ere
file operations are slow.  If that is really the case, the internal gre=
p
might even have performance advantage over external grep.

No, I haven't benched the internal grep recently.
