From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Commit 5841520b makes it impossible to connect to github from behind my company's firewall.
Date: Tue, 20 Oct 2015 13:46:16 +0200
Message-ID: <vpq37x54vav.fsf@grenoble-inp.fr>
References: <loom.20151020T131513-529@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Enrique Tobis <Enrique.Tobis@twosigma.com>
To: Johan Laenen <johan.laenen+cygwin@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 20 13:46:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZoVNC-0004D0-Ip
	for gcvg-git-2@plane.gmane.org; Tue, 20 Oct 2015 13:46:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751071AbbJTLqa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Oct 2015 07:46:30 -0400
Received: from mx2.imag.fr ([129.88.30.17]:51092 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750785AbbJTLq3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Oct 2015 07:46:29 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t9KBkFUK014161
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Tue, 20 Oct 2015 13:46:15 +0200
Received: from anie (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t9KBkGLC012850;
	Tue, 20 Oct 2015 13:46:16 +0200
In-Reply-To: <loom.20151020T131513-529@post.gmane.org> (Johan Laenen's message
	of "Tue, 20 Oct 2015 11:20:52 +0000 (UTC)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Tue, 20 Oct 2015 13:46:15 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t9KBkFUK014161
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1445946377.87614@EBWTBTcHw/0MhYGymXE3ZQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279906>

Hi,

I'm just Cc-ing Enrique, the author of 5841520b.

Johan Laenen <johan.laenen+cygwin@gmail.com> writes:

> Commit 5841520b makes it impossible to connect to github from behind my
> company's firewall.
>
> I'm running CYGWIN_NT-6.1 and the default git version 2.5.3 complains with a
> fatal error when trying to git pull:
>
> $ /bin/git --version
> git version 2.5.3
> $ /bin/git pull
> fatal: unable to access 'https://github.com/gargle/french/': Unknown SSL
> protocol error in connection to github.com:443
>
> Taking the sources of git 2.6.1. and compiling with commit 5841520b in
> http.c reverted gives me a working git.
>
> My http.c now looks like:
>
>  466     if (curl_http_proxy) {
>  467         curl_easy_setopt(result, CURLOPT_PROXY, curl_http_proxy);
>  468 #if LIBCURL_VERSION_NUM >= 0x070a07
>  469         curl_easy_setopt(result, CURLOPT_PROXYAUTH, CURLAUTH_ANY);
>  470 #endif
>  471     }
>
> And it works:
>
> $ git --version
> git version 2.6.1
> $ git pull
> Already up-to-date.
>
>
>
> Greetings,
>
> Johan

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
