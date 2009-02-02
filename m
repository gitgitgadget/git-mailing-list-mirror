From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: Newbie question regarding 3way merge order.
Date: Mon, 02 Feb 2009 17:10:02 +0100
Message-ID: <49871ADA.4080905@viscovery.net>
References: <871vulda2r.fsf@gigli.quasi.internal>	<slrngo6eat.s1d.sitaramc@sitaramc.homelinux.net>	<7vskmyt127.fsf@gitster.siamese.dyndns.org> <871vugc2c8.fsf@gigli.quasi.internal>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: "Raimund Berger" <raimund.berger@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 02 17:11:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LU1Oc-0003BC-NK
	for gcvg-git-2@gmane.org; Mon, 02 Feb 2009 17:11:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752846AbZBBQKL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Feb 2009 11:10:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752822AbZBBQKL
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Feb 2009 11:10:11 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:56025 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752818AbZBBQKK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Feb 2009 11:10:10 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1LU1N5-0000JS-HF; Mon, 02 Feb 2009 17:10:04 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 49FB14FB; Mon,  2 Feb 2009 17:10:03 +0100 (CET)
User-Agent: Thunderbird 2.0.0.18 (Windows/20081105)
In-Reply-To: <871vugc2c8.fsf@gigli.quasi.internal>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108098>

Please don't set Mail-Followup-To: here, and keep the Cc: list.

Raimund Berger schrieb:
> do the following conditions hold
> 
> (i)  A+B == B+A for all commits A,B
> (ii) (A+B)+C == A+(B+C) for all A,B,C
> 
> where "+" designates the standard git 3way merge?

I don't think that (ii) does holds in general.

[ In the examples consider each letter/symbol on a line by itself; this
saves vertical space. ]

Start with this (the merge base):

	f(a)

and there are three topic branches growing from here:
A makes this (rename f->g):

	g(a)

B makes this (add another f):

	f(a)f(b)

C makes this (renames a->c):

	f(c)

Then A+B is

	g(a)f(b)

A+C is

	g(c)

B+C is

	f(c)f(b)

(A+B)+C is

	g(c)f(b)

but A+(B+C) is ambiguous:

	g(c)f(b)
or
	f(c)g(b)

-- Hannes
