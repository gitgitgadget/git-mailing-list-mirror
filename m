From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 3/3] completion: match ctags symbol names in grep patterns
Date: Tue, 18 Oct 2011 09:41:10 +0200
Message-ID: <vpqpqhug31l.fsf@bauges.imag.fr>
References: <20111018044955.GA8976@sigill.intra.peff.net>
	<20111018050105.GC9008@sigill.intra.peff.net>
	<7vd3duixdg.fsf@alter.siamese.dyndns.org>
	<20111018072655.GA22309@elie.hsd1.il.comcast.net>
	<7v8voiiwfo.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 18 09:41:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RG4J8-0004zL-MG
	for gcvg-git-2@lo.gmane.org; Tue, 18 Oct 2011 09:41:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757349Ab1JRHlu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Oct 2011 03:41:50 -0400
Received: from mx1.imag.fr ([129.88.30.5]:35306 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753473Ab1JRHlt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Oct 2011 03:41:49 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id p9I7c8Gq016411
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 18 Oct 2011 09:38:08 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1RG4IR-0006Qi-6L; Tue, 18 Oct 2011 09:41:11 +0200
In-Reply-To: <7v8voiiwfo.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Tue, 18 Oct 2011 00:35:39 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Tue, 18 Oct 2011 09:38:09 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: p9I7c8Gq016411
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1319528292.54765@cL6Pmy/+QGu+iqtECutNww
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183869>

Junio C Hamano <gitster@pobox.com> writes:

>>> +git_check = $(shell git ls-files >/dev/null 2>&1; echo $$?)
>>> +ifeq ($(git_check),0)

> Hmm, how would this punish anybody exactly (I just took the structure
> from the way how the auto-depend is done)?

The "shell git ls-files" is ran unconditionnally, hence a small
performance penality even if you don't run ctags.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
