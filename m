From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: 1.8.4 rebase regression?
Date: Mon, 16 Sep 2013 13:18:48 +0200
Message-ID: <vpqioy1815z.fsf@anie.imag.fr>
References: <20130915235739.GA712@quark>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Patrick Welche <prlw1@cam.ac.uk>
X-From: git-owner@vger.kernel.org Mon Sep 16 13:19:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VLWq0-0002SF-7t
	for gcvg-git-2@plane.gmane.org; Mon, 16 Sep 2013 13:19:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756919Ab3IPLTM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Sep 2013 07:19:12 -0400
Received: from mx1.imag.fr ([129.88.30.5]:44891 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753774Ab3IPLTM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Sep 2013 07:19:12 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r8GBIlqY022780
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 16 Sep 2013 13:18:47 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1VLWpM-0000mz-BJ; Mon, 16 Sep 2013 13:18:48 +0200
In-Reply-To: <20130915235739.GA712@quark> (Patrick Welche's message of "Mon,
	16 Sep 2013 00:57:39 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 16 Sep 2013 13:18:48 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r8GBIlqY022780
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1379935131.84778@9tft733/7HF3YWu2i2FkGw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234834>

Patrick Welche <prlw1@cam.ac.uk> writes:

> $ git diff
> ESC[1mdiff --cc glib/gmain.cESC[m
> ESC[1mindex 738e69c,5aaebd0..0000000ESC[m
> ESC[1m--- a/glib/gmain.cESC[m
> ESC[1m+++ b/glib/gmain.cESC[m
> ESC[36m@@@ -4953,32 -4921,32 +4953,48 @@@ESC[m ESC[mg_unix_signal_watch_dispatch (GSourcESC[m
>
>
> (same xterm, no change of TERM in both invocations above)
> git status in 1.8.4 does show red, so colour does work...
>
> Thoughts on how to help debug?

Can you try:

git -c color.ui=never diff
git -c color.ui=auto diff
git -c color.ui=always diff

?

If you have a bit of time, you can use "git bisect" on a clone of
git.git to find out the guilty commit.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
