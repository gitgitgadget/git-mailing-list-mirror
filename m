From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/4] parseopt: add PARSE_OPT_KEEP_UNKNOWN
Date: Sun, 08 Mar 2009 13:30:56 -0700
Message-ID: <7vmybvkb9b.fsf@gitster.siamese.dyndns.org>
References: <7vfxhs2shk.fsf@gitster.siamese.dyndns.org>
 <49B2C784.90800@lsrfire.ath.cx> <49B40A9F.7050408@lsrfire.ath.cx>
 <7vvdqjkbka.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, carlos.duclos@nokia.com,
	Pierre Habouzit <madcoder@madism.org>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Sun Mar 08 21:34:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LgPhb-0005Tu-9x
	for gcvg-git-2@gmane.org; Sun, 08 Mar 2009 21:34:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753980AbZCHUbK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 Mar 2009 16:31:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753683AbZCHUbI
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Mar 2009 16:31:08 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:52634 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753485AbZCHUbI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 8 Mar 2009 16:31:08 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 94F2BA096F;
	Sun,  8 Mar 2009 16:31:04 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 12BF6A096E; Sun,
  8 Mar 2009 16:30:58 -0400 (EDT)
In-Reply-To: <7vvdqjkbka.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sun, 08 Mar 2009 13:24:21 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 0BE6EC2E-0C20-11DE-9CC5-CFA5EBB1AA3C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112640>

Junio C Hamano <gitster@pobox.com> writes:

> Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:
>
>> Add a parseopt flag, PARSE_OPT_KEEP_UNKNOWN, that can be used to kee=
p
>> unknown options in argv, similar to the existing KEEP flags.
>
> Very nice.
>
> The only caveat I can think of is with PARSE_OPT_STOP_AT_NON_OPTION s=
et
> (which is not default), you can correctly handle:
>
> 	git cmd --known --unknown=3Dvalue arg0 arg1
>
> but cannot correctly handle:
>
> 	git cmd --known --unknown value arg0 arg1
>
> An update to Documentation/technical/api-parse-options.txt that
>
>  (1) describes this new option; and
>
>  (2) warns about this issue.

"is necessary" is necessary here to complete my sentence.  Sorry.

> It might even make sense to diagnose PARSE_OPT_STOP_AT_NON_OPTION use=
d
> together with PARSE_OPT_KEEP_UNKNOWN as a programming error.
