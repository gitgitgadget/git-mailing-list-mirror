From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: git-latexdiff: Git and Latexdiff working together
Date: Wed, 15 Feb 2012 00:13:40 +0100
Message-ID: <vpq4nut6maj.fsf@bauges.imag.fr>
References: <vpq7gzph7mi.fsf@bauges.imag.fr>
	<20120214211629.GA23649@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Feb 15 00:14:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RxRZM-0002vQ-JP
	for gcvg-git-2@plane.gmane.org; Wed, 15 Feb 2012 00:13:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932650Ab2BNXNv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Feb 2012 18:13:51 -0500
Received: from mx1.imag.fr ([129.88.30.5]:56512 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932081Ab2BNXNv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Feb 2012 18:13:51 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q1ENAeON005613
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 15 Feb 2012 00:10:40 +0100
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1RxRZ7-0000Zv-M6; Wed, 15 Feb 2012 00:13:41 +0100
In-Reply-To: <20120214211629.GA23649@sigill.intra.peff.net> (Jeff King's
	message of "Tue, 14 Feb 2012 16:16:29 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 15 Feb 2012 00:10:40 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q1ENAeON005613
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1329865843.64072@7B5VlzqYrB9OuTHNSu/qAQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190793>

Jeff King <peff@peff.net> writes:

> My latex usage is all from a past life, so I didn't even try out your
> tool.  But I did wonder what your rationale was in making a separate
> command as opposed to providing a script that could be plugged in as an
> external diff.

My LaTeX documents are usually sets of .tex files including each other,
plus figures and possibly Makefiles. So, git-latexdiff does a full
checkout of the old and new tree, then runs latexdiff on the main file,
and then compiles the result.

A diff driver would work well for a standalone file, but I don't think
you can plug it in this kind of situation.

Also, git-latexdiff has a few hacks like detecting the main latex file
automatically by grepping all .tex files for "documentclass", detecting
the presence of a Makefile to compile the document, ... that would
hardly fit in a diff driver.

That said, that may be just me not knowing diff drivers or difftools
well enough.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
