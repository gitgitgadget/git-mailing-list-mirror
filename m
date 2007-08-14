From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] diff: squelch empty diffs even more
Date: Tue, 14 Aug 2007 14:29:03 -0700
Message-ID: <7v643hbyao.fsf@assigned-by-dhcp.cox.net>
References: <46C21A25.2040304@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Tue Aug 14 23:31:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IL3z7-00022T-0L
	for gcvg-git@gmane.org; Tue, 14 Aug 2007 23:31:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761705AbXHNV3J convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 14 Aug 2007 17:29:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754395AbXHNV3J
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Aug 2007 17:29:09 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:33152 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752847AbXHNV3G convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Aug 2007 17:29:06 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070814212905.OXLS24055.fed1rmmtao107.cox.net@fed1rmimpo01.cox.net>;
          Tue, 14 Aug 2007 17:29:05 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id bxV41X0011kojtg0000000; Tue, 14 Aug 2007 17:29:04 -0400
In-Reply-To: <46C21A25.2040304@lsrfire.ath.cx> (=?utf-8?Q?Ren=C3=A9?=
 Scharfe's message of
	"Tue, 14 Aug 2007 23:09:57 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55858>

Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:

> When we compare two non-tracked files or explicitly specify
> --no-index then the suggestion to run git-status is not helpful.

That observation is correct but how does skip_stat_unmatch count
up in such a case?  Shouldn't diffcore_skip_stat_unmatch()
function be taught about such a "fake" filepair that did not
come from git, and ignore the stat differences?
