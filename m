From: Wincent Colaiuta <win@wincent.com>
Subject: Re: [PATCH 2/2] "diff --check" should affect exit status
Date: Wed, 12 Dec 2007 10:56:34 +0100
Message-ID: <71D6ABDB-568E-4D5F-B901-D57C15314FF7@wincent.com>
References: <1197447122-93416-1-git-send-email-win@wincent.com> <1197447122-93416-2-git-send-email-win@wincent.com> <1197447122-93416-3-git-send-email-win@wincent.com> <7vmysg8e8r.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 12 10:59:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2OMn-0002XB-J6
	for gcvg-git-2@gmane.org; Wed, 12 Dec 2007 10:59:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756322AbXLLJ6i convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 12 Dec 2007 04:58:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756265AbXLLJ6i
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Dec 2007 04:58:38 -0500
Received: from wincent.com ([72.3.236.74]:43856 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753884AbXLLJ6h convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 12 Dec 2007 04:58:37 -0500
Received: from cuzco.lan (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id lBC9uZJ8017546;
	Wed, 12 Dec 2007 03:56:36 -0600
In-Reply-To: <7vmysg8e8r.fsf@gitster.siamese.dyndns.org>
X-Mailer: Apple Mail (2.915)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68026>

El 12/12/2007, a las 10:16, Junio C Hamano escribi=F3:

> Wincent Colaiuta <win@wincent.com> writes:
>
>> "git diff" has a --check option that can be used to check for =20
>> whitespace
>> problems but it only reported by printing warnings to the
>> console.
>
> The primary use of this option used to be to see where the breakages =
=20
> are
> in order to fix them up (IOW, the option was not about seeing if
> breakage exists or not), but that is much easier with --color output
> these days.
>
> It is probably a good idea to do this, although I do not care much =20
> about
> it either way.  It probably could replace the sample pre-commit hook
> currently implemented in Perl.

Actually, that's exactly why I prepared this patch; I was looking at =20
the pre-commit hook and though, surely there must be a simpler way =20
than this... And was surprised when I saw that "git diff --check" =20
didn't alter the exit code...

> As I happen to be fairly familiar with
> the area, I'll take a look at the patch if/when I find time.

Thanks. I'm about to resend this patch with more tests, and one fix =20
discovered while adding the tests ("git diff-tree" was only setting =20
the exit status with --stdin set), as well as a new version of the pre-=
=20
commit hook.

One nice thing about this change is that when "diff --check" learns =20
about the new core.whitespace stuff, the hook will automatically =20
inherit the new behaviour.

Cheers,
Wincent
