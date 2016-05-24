From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: t7800 test failure
Date: Tue, 24 May 2016 18:48:57 +0200
Message-ID: <vpqk2ijs8p2.fsf@anie.imag.fr>
References: <CALR6jEiJwx14zAyond9ggz29Q64Fz84URtjr8zaddjnrdY7TjA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git List <git@vger.kernel.org>
To: Armin Kunaschik <megabreit@googlemail.com>
X-From: git-owner@vger.kernel.org Tue May 24 18:49:34 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b5FWQ-0008PG-20
	for gcvg-git-2@plane.gmane.org; Tue, 24 May 2016 18:49:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755595AbcEXQta (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 May 2016 12:49:30 -0400
Received: from mx1.imag.fr ([129.88.30.5]:38825 "EHLO mx1.imag.fr"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753891AbcEXQta (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 May 2016 12:49:30 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by mx1.imag.fr (8.13.8/8.13.8) with ESMTP id u4OGmtuT014801
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Tue, 24 May 2016 18:48:56 +0200
Received: from anie (anie.imag.fr [129.88.42.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u4OGmvBB027772;
	Tue, 24 May 2016 18:48:57 +0200
In-Reply-To: <CALR6jEiJwx14zAyond9ggz29Q64Fz84URtjr8zaddjnrdY7TjA@mail.gmail.com>
	(Armin Kunaschik's message of "Tue, 24 May 2016 17:53:25 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (mx1.imag.fr [129.88.30.5]); Tue, 24 May 2016 18:48:56 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u4OGmtuT014801
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1464713336.58835@gNv1PpI4CLdNKb2FeYHc8w
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295503>

Armin Kunaschik <megabreit@googlemail.com> writes:

> t7800 fails on systems where readlink (GNUism?) is not available.

I don't think it's POSIX, but it is present on all POSIX-like systems I
know. On which system did you get the issue?

> +readlink() { ls -ld "$1" | sed 's/.* -> //'; }

This is much less robust than the actual readlink. For example, if ->
appears in the link name, it breaks.

It would be acceptable as a fall-back if readlink is not present, but
shouldn't activate the "ls" hack by default.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
