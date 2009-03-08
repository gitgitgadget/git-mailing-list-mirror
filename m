From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/4] archive: use parseopt for local-only options
Date: Sun, 08 Mar 2009 13:20:01 -0700
Message-ID: <7v3adnlqby.fsf@gitster.siamese.dyndns.org>
References: <7vfxhs2shk.fsf@gitster.siamese.dyndns.org>
 <49B2C784.90800@lsrfire.ath.cx> <49B40CC1.2090906@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, carlos.duclos@nokia.com,
	Pierre Habouzit <madcoder@madism.org>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Sun Mar 08 21:21:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LgPVG-0001BZ-Vk
	for gcvg-git-2@gmane.org; Sun, 08 Mar 2009 21:21:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753805AbZCHUUO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 Mar 2009 16:20:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753733AbZCHUUO
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Mar 2009 16:20:14 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:49753 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753703AbZCHUUN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 8 Mar 2009 16:20:13 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id ADFCB49C9;
	Sun,  8 Mar 2009 16:20:08 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 019A849C3; Sun, 
 8 Mar 2009 16:20:03 -0400 (EDT)
In-Reply-To: <49B40CC1.2090906@lsrfire.ath.cx> (=?utf-8?Q?Ren=C3=A9?=
 Scharfe's message of "Sun, 08 Mar 2009 19:21:53 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 84F7176C-0C1E-11DE-8D2A-CBE7E3B37BAC-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112637>

Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:

> The parseopt parser allows multiple occurrences of --remote and --exe=
c
> unlike the previous one; the one specified last wins.  This looseness
> is acceptable, I think.

I agree.

If we care about this very deeply, we can add "this option is supposed =
to
be singleton" option to the parse_options infrastructure.  Besides, the
"last one wins" rule is often more convenient than "there has to be at
most one" rule in real life.
