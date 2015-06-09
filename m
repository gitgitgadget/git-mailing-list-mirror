From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: On undoing a forced push
Date: Tue, 09 Jun 2015 15:17:10 +0200
Message-ID: <vpqtwuh6my1.fsf@anie.imag.fr>
References: <20150609121221.GA14126@lanh>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 09 15:17:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z2JPE-0000Qs-Pn
	for gcvg-git-2@plane.gmane.org; Tue, 09 Jun 2015 15:17:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753375AbbFINR0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Jun 2015 09:17:26 -0400
Received: from mx1.imag.fr ([129.88.30.5]:37314 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753046AbbFINRO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jun 2015 09:17:14 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t59DH9MO007141
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 9 Jun 2015 15:17:09 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t59DHAWx029965;
	Tue, 9 Jun 2015 15:17:10 +0200
In-Reply-To: <20150609121221.GA14126@lanh> (Duy Nguyen's message of "Tue, 9
	Jun 2015 19:12:21 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Tue, 09 Jun 2015 15:17:09 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t59DH9MO007141
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1434460630.25498@9xhtG1PyXwgMyZaLWlUOqQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271177>

Duy Nguyen <pclouds@gmail.com> writes:

> From a thread on Hacker News. It seems that if a user does not have
> access to the remote's reflog and accidentally forces a push to a ref,
> how does he recover it? In order to force push again to revert it
> back, he would need to know the remote's old SHA-1. Local reflog does
> not help because remote refs are not updated during a push.

More precisely, the remote-tracking ref is updated, and so is its
reflog, but the reflog entry usually does not help, because it documents
the old and new sha1 of the remote-tracking ref, not of the remote ref
itself. Typically, if a coworker pushed some code that I did not pull,
and I force-push to the same branch, my reflog won't have the sha1 of my
coworker's code.

> This patch prints the latest SHA-1 before the forced push in full.

Sounds like a good idea to me.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
