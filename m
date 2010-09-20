From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: git performance after directory copy
Date: Mon, 20 Sep 2010 15:57:26 +0200
Message-ID: <vpqeico8qm1.fsf@bauges.imag.fr>
References: <C5A8FDEFF7647F4C9CB927D7DEB307730F33B7C9@ahr075s.basler.corp>
	<vpq62y0hh63.fsf@bauges.imag.fr> <4C974A00.8030905@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Gaer\, A." <Andreas.Gaer@baslerweb.com>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon Sep 20 16:02:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oxgwh-0001ia-03
	for gcvg-git-2@lo.gmane.org; Mon, 20 Sep 2010 16:02:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755439Ab0ITOCF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Sep 2010 10:02:05 -0400
Received: from imag.imag.fr ([129.88.30.1]:52372 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754811Ab0ITOCE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Sep 2010 10:02:04 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id o8KDvRLU022449
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 20 Sep 2010 15:57:27 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1Oxgs3-0001vS-7Y; Mon, 20 Sep 2010 15:57:27 +0200
In-Reply-To: <4C974A00.8030905@viscovery.net> (Johannes Sixt's message of "Mon\, 20 Sep 2010 13\:48\:16 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Mon, 20 Sep 2010 15:57:27 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156624>

Johannes Sixt <j.sixt@viscovery.net> writes:

> Am 9/20/2010 11:56, schrieb Matthieu Moy:
>> But I'm surprised that the next "git status" are still slow. Other
>> people may get a better explanation, but this very much looks like a
>> bug.
>
> Most likely, Andreas works with 1.7.1. From the release notes of 1.7.1.1:
>
>  * "git status" stopped refreshing the index by mistake in 1.7.1.

Nice catch, and this explains why I couldn't reproduce with latest
Git.

More precisely, it was fixed here:

b2f6fd9 t7508: add a test for "git status" in a read-only repository
4bb6644 git status: refresh the index if possible
4c926b3 t7508: add test for "git status" refreshing the index

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
