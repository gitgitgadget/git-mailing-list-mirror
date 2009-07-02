From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/6] grep: move context hunk mark handling into show_line()
Date: Wed, 01 Jul 2009 22:24:03 -0700
Message-ID: <7v3a9fejyk.fsf@alter.siamese.dyndns.org>
References: <4A4BDC65.80504@lsrfire.ath.cx> <4A4BDCFE.3050808@lsrfire.ath.cx>
	<7vzlbodne0.fsf@alter.siamese.dyndns.org>
	<4A4C2655.9000000@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Thu Jul 02 07:24:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MMEmM-0000Ax-6i
	for gcvg-git-2@gmane.org; Thu, 02 Jul 2009 07:24:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751141AbZGBFYB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 2 Jul 2009 01:24:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751098AbZGBFYB
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Jul 2009 01:24:01 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:38864 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750933AbZGBFYA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jul 2009 01:24:00 -0400
Received: from fed1rmimpo03.cox.net ([70.169.32.75])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090702052404.SFGL17670.fed1rmmtao101.cox.net@fed1rmimpo03.cox.net>;
          Thu, 2 Jul 2009 01:24:04 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo03.cox.net with bizsmtp
	id AtQ31c00A4aMwMQ04tQ3kc; Thu, 02 Jul 2009 01:24:03 -0400
X-VR-Score: -100.00
X-Authority-Analysis: v=1.0 c=1 a=OgmuE65XyGQA:10 a=ofAdej1VY_0aQYJAhJ4A:9
 a=DClgXlJX2sHtuEqoQU0VzdASD8MA:4
X-CM-Score: 0.00
In-Reply-To: <4A4C2655.9000000@lsrfire.ath.cx> (=?utf-8?Q?=22Ren=C3=A9?=
 Scharfe"'s message of "Thu\, 02 Jul 2009 05\:15\:33 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122619>

Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:

> Hmm, I didn't read it to refer to the hunk_mark, but rather to the li=
ne
> (from bol to eol).  And it's still true that show_line needs to be
> called because we're not more than post_context lines away from the
> previous hit, i.e. this line is a post context line.

You are right; it was my thinko.
