From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t1301-shared-repo.sh: fix 'stat' portability issue
Date: Fri, 17 Aug 2007 16:37:56 -0700
Message-ID: <7v4pixg2az.fsf@gitster.siamese.dyndns.org>
References: <1187277663740-git-send-email-arjen@yaph.org>
	<7v3ayjjnz7.fsf@gitster.siamese.dyndns.org>
	<20070816220217.GH25161@regex.yaph.org>
	<20070817124828.GB11107@informatik.uni-freiburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Arjen Laarhoven <arjen@yaph.org>,
	Git Mailing List <git@vger.kernel.org>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
	<ukleinek@informatik.uni-freiburg.de>
X-From: git-owner@vger.kernel.org Sat Aug 18 01:38:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IMBOK-0001HO-Pq
	for gcvg-git@gmane.org; Sat, 18 Aug 2007 01:38:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751966AbXHQXiF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 17 Aug 2007 19:38:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752005AbXHQXiF
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Aug 2007 19:38:05 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:36879 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751401AbXHQXiD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 17 Aug 2007 19:38:03 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070817233803.IGTG16518.fed1rmmtao106.cox.net@fed1rmimpo01.cox.net>;
          Fri, 17 Aug 2007 19:38:03 -0400
Received: from localhost ([68.225.240.77])
	by fed1rmimpo01.cox.net with bizsmtp
	id dBe11X00F1gtr5g0000000; Fri, 17 Aug 2007 19:38:01 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56097>

Uwe Kleine-K=C3=B6nig <ukleinek@informatik.uni-freiburg.de> writes:

> Don't know if this matters here, but a while ago I learnd that if I
> really need to parse output of ls -l, then I should set LANG=3DC and
> LC_ALL=3DC.  I didn't see any breakage when LS_COLORS is set, but may=
be
> you want to reset that, too?

Yeah, I usually try to be defensive and I know LANG/LC_ALL
matters if you want to parse "ls -l" for dates, but it should
not matter for perm bits.  If LS_COLORS is honoured when it is
outputting to non-terminal (as in var=3D`ls`), it's severely
broken, so...
