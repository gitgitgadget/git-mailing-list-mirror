From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] tests: remove xargs in favor of --stdin where possible
Date: Thu, 23 Apr 2009 01:36:58 -0700
Message-ID: <7vfxfzwytx.fsf@gitster.siamese.dyndns.org>
References: <1240468281-23815-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 23 10:38:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LwuSC-0005yu-3W
	for gcvg-git-2@gmane.org; Thu, 23 Apr 2009 10:38:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753197AbZDWIhG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 23 Apr 2009 04:37:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753338AbZDWIhF
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Apr 2009 04:37:05 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:63056 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751543AbZDWIhE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Apr 2009 04:37:04 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 2781111126;
	Thu, 23 Apr 2009 04:37:03 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 967C311124; Thu,
 23 Apr 2009 04:37:00 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: EB6B5D46-2FE1-11DE-8CB3-D766E3C8547C-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117311>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  Patch "Convert to use quiet option when available" reminds me I had =
a similar
>  patch to remove (mostly) xargs usage from tests.

The reason being...?

 (1) xargs is not universally available, or portable enough?

 (2) people may learn from tests, and we should demostrate our ability?

 (3) something else?

If the reason is (1) I would understand it, but if it is (2) then I am =
a
bit reluctant. =20

The tests may not break with your change because none of them may use
problematic characters (especially "\n" and '"'), but update-index --st=
din
without -z is not suitable for reading from output from "find" without =
-0
option (on the other hand, "update-index -z --stdin" is good for readin=
g
output from "find -0"; but for portability we avoid GNUism "find -0").
