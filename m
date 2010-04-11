From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [BUG] - git rebase -i performs rebase when it shouldn't?
Date: Sun, 11 Apr 2010 19:54:37 +0200
Message-ID: <201004111954.38156.j6t@kdbg.org>
References: <z2q76c5b8581004091235ucd9b2a52i223b3191b288c42a@mail.gmail.com> <4BC0D87E.70001@kdbg.org> <20100411101526.GA20484@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Eugene Sajine <euguess@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Apr 11 19:57:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O11P5-0001b1-Vp
	for gcvg-git-2@lo.gmane.org; Sun, 11 Apr 2010 19:57:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752345Ab0DKR46 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Apr 2010 13:56:58 -0400
Received: from bsmtp4.bon.at ([195.3.86.186]:10074 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752032Ab0DKR45 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Apr 2010 13:56:57 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 65117A7EB4;
	Sun, 11 Apr 2010 19:56:51 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 6F8C419F5EB;
	Sun, 11 Apr 2010 19:54:38 +0200 (CEST)
User-Agent: KMail/1.9.10
In-Reply-To: <20100411101526.GA20484@coredump.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144670>

On Sonntag, 11. April 2010, Jeff King wrote:
> Good point. Originally, we did the rebase directly on the branch, though
> I'm not sure if we did "checkout $branch && reset $onto" or "branch -f
> $branch $onto && checkout $branch". These days we operate on a detached
> HEAD, and we seem to "checkout $onto^0", which should do the
> optimization you mention.

But before this "checkout $onto^0" happens, some (all?) variants still 
do "checkout topic && rev-list upstream..HEAD" instead of just "rev-list 
upstream..topic".

-- Hannes
