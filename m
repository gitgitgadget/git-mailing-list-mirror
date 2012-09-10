From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Confirm my false error suspicions of Gitweb query injection
Date: Mon, 10 Sep 2012 19:15:27 +0200
Message-ID: <vpqvcflhk9c.fsf@bauges.imag.fr>
References: <CAMOg_eUjmnisevN+AaArz+6TMpWYJL660xwG0ptEaTO7stcL6A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Joseph Leong <josephcleong@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 10 19:15:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TB7aH-0002o6-LR
	for gcvg-git-2@plane.gmane.org; Mon, 10 Sep 2012 19:15:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754130Ab2IJRPd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Sep 2012 13:15:33 -0400
Received: from mx1.imag.fr ([129.88.30.5]:45599 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753442Ab2IJRPc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Sep 2012 13:15:32 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q8AHB6SI029103
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 10 Sep 2012 19:11:06 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1TB7a4-0002t2-Cq; Mon, 10 Sep 2012 19:15:28 +0200
In-Reply-To: <CAMOg_eUjmnisevN+AaArz+6TMpWYJL660xwG0ptEaTO7stcL6A@mail.gmail.com>
	(Joseph Leong's message of "Mon, 10 Sep 2012 09:45:08 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.1 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 10 Sep 2012 19:11:06 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q8AHB6SI029103
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1347901868.45097@BO/6qVYBaYXJvvWpML2leQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205150>

Joseph Leong <josephcleong@gmail.com> writes:

> [RESP]
> 500 - Internal Server Error
> Unmatched ( in regex; marked by &lt;-- HERE in m/( &lt;-- HERE select
> 1234,/ at /var/www/git/gitweb.cgi line 4845.

Gitweb is feeding your input as a perl regex, which is not really clean
but shouldn't really harm either.

I could reproduce with an old gitweb version, but newer gitwebs seem to
be more clever about regular expression (there's an explicit tickbox to
search for re, and the error message is clean when what you provide
isn't a valid regexp).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
