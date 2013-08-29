From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [RFC/PATCH v2 2/3] submodule: introduce --[no-]display-comment-char
Date: Thu, 29 Aug 2013 09:04:39 +0200
Message-ID: <vpq7gf53rlk.fsf@anie.imag.fr>
References: <vpqhaeaasuf.fsf@anie.imag.fr>
	<1377694024-24173-1-git-send-email-Matthieu.Moy@imag.fr>
	<1377694024-24173-2-git-send-email-Matthieu.Moy@imag.fr>
	<521E6674.1010201@web.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, j.sixt@viscovery.net,
	Junio C Hamano <gitster@pobox.com>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Thu Aug 29 09:05:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VEwHt-0007um-3E
	for gcvg-git-2@plane.gmane.org; Thu, 29 Aug 2013 09:05:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753583Ab3H2HEz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Aug 2013 03:04:55 -0400
Received: from mx1.imag.fr ([129.88.30.5]:36576 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752768Ab3H2HEy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Aug 2013 03:04:54 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r7T74dr5031467
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 29 Aug 2013 09:04:39 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1VEwHX-0004Ij-WA; Thu, 29 Aug 2013 09:04:40 +0200
In-Reply-To: <521E6674.1010201@web.de> (Jens Lehmann's message of "Wed, 28 Aug
	2013 23:07:00 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 29 Aug 2013 09:04:40 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r7T74dr5031467
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1378364683.55805@DBiMYZQHc/noscncqapj1g
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233240>

Jens Lehmann <Jens.Lehmann@web.de> writes:

> But I'm not terribly happy about having the --for-status option in the
> submodule script in the first place, as I believe it should rather be
> handled by wt-status.c itself (reading the output of submodule summary
> using the start_command()/finish_command() combo instead of the simple
> run_command() currently used and prepending the comment char by using
> status_printf() & friends for each line).

I went the --for-status way because it's easier to do this in shell than
in C. But I'm close to be convinced that implementing this on the
wt-status.c side is better. I'll try a re-roll doing this when I get
time.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
