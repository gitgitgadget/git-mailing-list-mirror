From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: [PATCH] Make the 'lock file exists' error more informative
Date: Wed, 04 Mar 2009 16:54:49 +0100
Message-ID: <vpqvdqpb7w6.fsf@bauges.imag.fr>
References: <1236179277-12477-1-git-send-email-johnflux@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: John Tapsell <johnflux@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 04 17:01:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LetWv-0001SZ-RQ
	for gcvg-git-2@gmane.org; Wed, 04 Mar 2009 17:01:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752675AbZCDP7l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Mar 2009 10:59:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752360AbZCDP7k
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Mar 2009 10:59:40 -0500
Received: from imag.imag.fr ([129.88.30.1]:56757 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752149AbZCDP7k (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Mar 2009 10:59:40 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id n24Fsrh3027258
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 4 Mar 2009 16:54:53 +0100 (CET)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1LetQn-0007SC-Am; Wed, 04 Mar 2009 16:54:49 +0100
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1LetQn-00007v-8X; Wed, 04 Mar 2009 16:54:49 +0100
In-Reply-To: <1236179277-12477-1-git-send-email-johnflux@gmail.com> (John Tapsell's message of "Wed\,  4 Mar 2009 15\:07\:57 +0000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.90 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Wed, 04 Mar 2009 16:54:53 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112226>

John Tapsell <johnflux@gmail.com> writes:

> It looks like someone did 90% of the work, then forgot to actually use
> the function

someone = me ;-).

The message is a bit inacurrate: the function is already used in two
places, I just didn't notice this one.

> -	if (errno == EEXIST) {
> +	if (err == EEXIST) {

Oops, right.

> -			die("unable to create '%s.lock': %s", path, strerror(errno));
> +			unable_to_lock_index_die(path, errno);

Actually, _this_ instance is still to be fixed in next. You probably
looked at the other one that my original message fixes.

IOW:

Acked-by: Matthieu Moy <Matthieu.Moy@imag.fr>

-- 
Matthieu
