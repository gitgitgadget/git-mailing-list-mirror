From: Alexander Shishkin <ash@koowaldah.org>
Subject: Re: [PATCH/RFC] pretty.c: add %O format specifier to
 format_commit_one()
Date: Sat, 1 May 2010 20:56:01 +0300
Message-ID: <20100501175601.GB27062@shisha.kicks-ass.net>
References: <1272711401-29005-1-git-send-email-ash@koowaldah.org>
 <7vsk6b5yms.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alexander Shishkin <ash@koowaldah.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 01 20:01:01 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O8Gzs-00005i-1J
	for gcvg-git-2@lo.gmane.org; Sat, 01 May 2010 20:01:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756872Ab0EAR5T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 May 2010 13:57:19 -0400
Received: from filtteri6.pp.htv.fi ([213.243.153.189]:37926 "EHLO
	filtteri6.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752746Ab0EAR5S (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 May 2010 13:57:18 -0400
Received: from localhost (localhost [127.0.0.1])
	by filtteri6.pp.htv.fi (Postfix) with ESMTP id BCE7056E1A4;
	Sat,  1 May 2010 20:57:16 +0300 (EEST)
X-Virus-Scanned: Debian amavisd-new at pp.htv.fi
Received: from smtp5.welho.com ([213.243.153.39])
	by localhost (filtteri6.pp.htv.fi [213.243.153.189]) (amavisd-new, port 10024)
	with ESMTP id cGcn095kgbAp; Sat,  1 May 2010 20:57:14 +0300 (EEST)
Received: from ukko (cs27003010.pp.htv.fi [89.27.3.10])
	by smtp5.welho.com (Postfix) with ESMTP id 78E135BC005;
	Sat,  1 May 2010 20:57:14 +0300 (EEST)
Received: from ash by ukko with local (Exim 4.69)
	(envelope-from <ash@shisha.kicks-ass.net>)
	id 1O8Gv3-0000M7-Bp; Sat, 01 May 2010 20:56:01 +0300
Content-Disposition: inline
In-Reply-To: <7vsk6b5yms.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146104>

On Sat, May 01, 2010 at 10:18:35 -0700, Junio C Hamano wrote:
> Alexander Shishkin <ash@koowaldah.org> writes:
> 
> > This specifier represents the number of each commit in the output
> > stream.
> 
> I don't like this.  What does such a number _mean_ in a non-linear
> history?

My idea is to have something like

$ git log --pretty=oneline | nl | less -R

This is generally useful when my local topic branch contains more than 5
(or so) commits and I can't immediately see which one's which if I want
to do a

$ git show HEAD~$n

to see what's inside, which is useful when reordering and/or squashing
commits by an interactive rebase. So this %O gives me this $n quicker
than counting.

> Also the next person who sees this will inevitably ask for %TOTAL to so
> that the output can say [N/M], but that would mean the list has to be
> limited and we cannot stream the output anymore.

Well, for me this kind of numbering only makes sense on a short part of
the topmost history.

Regards,
--
Alex
