From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] t4202 (log): add failing test for log with subtree
Date: Mon, 22 Apr 2013 14:11:48 +0200
Message-ID: <vpqa9oqpxx7.fsf@grenoble-inp.fr>
References: <1366632487-28153-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git List <git@vger.kernel.org>,
	Avery Pennarun <apenwarr@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 22 14:12:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UUFbP-0006gO-1C
	for gcvg-git-2@plane.gmane.org; Mon, 22 Apr 2013 14:12:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753064Ab3DVMMG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Apr 2013 08:12:06 -0400
Received: from mx1.imag.fr ([129.88.30.5]:47175 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753027Ab3DVMME (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Apr 2013 08:12:04 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r3MCBlmB022355
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 22 Apr 2013 14:11:47 +0200
Received: from anie.imag.fr ([129.88.7.32] helo=anie)
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1UUFb2-0002KE-Ga; Mon, 22 Apr 2013 14:11:48 +0200
In-Reply-To: <1366632487-28153-1-git-send-email-artagnon@gmail.com> (Ramkumar
	Ramachandra's message of "Mon, 22 Apr 2013 17:38:07 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 22 Apr 2013 14:11:47 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r3MCBlmB022355
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1367237508.85499@QB3yAzcVw6HvJHNRK2Mf5A
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222007>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

>  was checking it out: a 'git log <pathspec>', when referring to a file
>  inside the subtree, doesn't work as expected: it only displays the
>  HEAD commit.

This is somehow expected: the subtree merge changed the filename during
merge (it is subtree/file.txt after the merge, and just file.txt
before), so "git log" without --follow just considers the file appeared.

OTOH, I think this is a known limitation of "git log --follow" that it
does not follow renames done by subtree merges.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
