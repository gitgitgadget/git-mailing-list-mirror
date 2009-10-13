From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH/RFC] builtin-checkout: suggest creating local branch when
   appropriate to do so
Date: Tue, 13 Oct 2009 11:32:01 +0200
Message-ID: <4AD44911.6070902@viscovery.net>
References: <0016e68fd0123a175304754694b4@google.com> <200910122340.13366.trast@student.ethz.ch> <7vr5t89qiw.fsf@alter.siamese.dyndns.org> <200910130836.57011.trast@student.ethz.ch> <7vljjf226t.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Thomas Rast <trast@student.ethz.ch>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Euguess@gmail.com, Mikael Magnusson <mikachu@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Jeff King <peff@peff.net>, Jay Soffian <jaysoffian@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 13 11:33:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mxdkr-000297-F2
	for gcvg-git-2@lo.gmane.org; Tue, 13 Oct 2009 11:33:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757096AbZJMJcw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Oct 2009 05:32:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756565AbZJMJcw
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Oct 2009 05:32:52 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:11291 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755630AbZJMJcv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Oct 2009 05:32:51 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Mxdje-0002UK-4R; Tue, 13 Oct 2009 11:32:02 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by linz.eudaptics.com (Postfix) with ESMTP
	id D02759614; Tue, 13 Oct 2009 11:32:01 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <7vljjf226t.fsf@alter.siamese.dyndns.org>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130150>

Junio C Hamano schrieb:
> #1. These used to detach, but will create a local branch
> 
>  $ git checkout origin/next        ;# as if with -t
>  $ git checkout xyzzy/frotz        ;# as if with -t (origin is not special)

If I did 'git checkout origin/next' last week, I will already have a
branch next. What should happen if I do it again today?

I think that it should DWIM: If last week's next fast-fowards to this
week's origin/next (*and* next is the branch that tracks origin/next),
then the fast foward should happen. Otherwise 'git checkout origin/next'
should fail.

This way, if I built on last week's next, I will be notified; but if I
only want to browse history, then I won't be impeded by the existence of next.

-- Hannes
