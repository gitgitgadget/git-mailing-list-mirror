From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 5/4] run-command: implement abort_async for pthreads
Date: Fri, 1 Apr 2011 22:18:07 +0200
Message-ID: <201104012218.07872.j6t@kdbg.org>
References: <20110331184243.GA12027@sigill.intra.peff.net> <201104012142.22065.j6t@kdbg.org> <AANLkTimKPD6rw1B9gG3ZN0KEOY41nk=6jE0MVcdotpkp@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Fri Apr 01 22:18:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q5knX-0005fX-KW
	for gcvg-git-2@lo.gmane.org; Fri, 01 Apr 2011 22:18:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755368Ab1DAUSQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Apr 2011 16:18:16 -0400
Received: from bsmtp4.bon.at ([195.3.86.186]:1916 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755121Ab1DAUSQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Apr 2011 16:18:16 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 2D09613004A;
	Fri,  1 Apr 2011 22:18:08 +0200 (CEST)
Received: from localhost (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id EFFD419F5DA;
	Fri,  1 Apr 2011 22:18:07 +0200 (CEST)
User-Agent: KMail/1.9.10
In-Reply-To: <AANLkTimKPD6rw1B9gG3ZN0KEOY41nk=6jE0MVcdotpkp@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170617>

On Freitag, 1. April 2011, Erik Faye-Lund wrote:
> On Fri, Apr 1, 2011 at 9:42 PM, Johannes Sixt <j6t@kdbg.org> wrote:
> > But this does not help the case at hand in any way. How would you
> > interrupt a thread that is blocked in ReadFile()? The point of
> > pthread_cancel() is that it interrupts blocked system calls
>
> There is no mention of such a guarantee in POSIX (section 2.9.5 Thread
> Cancellation), so relying on that is undefined behavior.

In the paragraph before the bulleted list at the end of "Cancellation Points":

"...If a thread has cancelability enabled and a cancellation request is made 
with the thread as a target while the thread is suspended at a cancellation 
point, the thread shall be awakened and the cancellation request shall be 
acted upon..."

-- Hannes
