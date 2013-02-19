From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH] Documentation/githooks: Explain pre-rebase parameters
Date: Tue, 19 Feb 2013 14:17:43 +0100
Message-ID: <878v6ksars.fsf@pctrast.inf.ethz.ch>
References: <c19c03f51d71a58fa3795f665fe4a4c0461fa58f.1361271116.git.wking@tremily.us>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: "W. Trevor King" <wking@tremily.us>
X-From: git-owner@vger.kernel.org Tue Feb 19 14:18:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U7n5G-0003WY-VP
	for gcvg-git-2@plane.gmane.org; Tue, 19 Feb 2013 14:18:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757618Ab3BSNRr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Feb 2013 08:17:47 -0500
Received: from edge10.ethz.ch ([82.130.75.186]:56885 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756631Ab3BSNRq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Feb 2013 08:17:46 -0500
Received: from CAS20.d.ethz.ch (172.31.51.110) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.298.4; Tue, 19 Feb
 2013 14:17:40 +0100
Received: from pctrast.inf.ethz.ch.ethz.ch (129.132.153.233) by
 CAS20.d.ethz.ch (172.31.51.110) with Microsoft SMTP Server (TLS) id
 14.2.298.4; Tue, 19 Feb 2013 14:17:43 +0100
In-Reply-To: <c19c03f51d71a58fa3795f665fe4a4c0461fa58f.1361271116.git.wking@tremily.us>
	(W. Trevor King's message of "Tue, 19 Feb 2013 06:03:24 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216614>

"W. Trevor King" <wking@tremily.us> writes:

> I'm not 100% convinced about this, because the git-rebase.sh uses:
>
>   "$GIT_DIR/hooks/pre-rebase" ${1+"$@"}
>
> I haven't been able to find documentation for the ${1+"$@"} syntax.
> Is it in POSIX?  It's not in the Bash manual:
[...]
> In my local tests, it seems equivalent to "$@".

It's definitely in the bash manual and POSIX[1]: it's a special case of
the ${parameter+word} expansion.

   ${parameter:+word}
      Use Alternate Value.  If parameter is null or unset, nothing is
      substituted, otherwise the expansion of word is substituted.

plus

   ... bash tests for a parameter that is unset or null.  Omitting the
   colon results in a test only for a parameter that is unset.

IIRC this particular usage was designed to suppress warnings about unset
variables.


Footnotes: 
[1]  http://pubs.opengroup.org/onlinepubs/009695399/utilities/xcu_chap02.html

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
