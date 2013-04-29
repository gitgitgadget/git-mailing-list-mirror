From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] clean: Introduce -z for machine readable output
Date: Mon, 29 Apr 2013 16:45:04 +0200
Message-ID: <vpqy5c1xuof.fsf@grenoble-inp.fr>
References: <vpqwqrl931e.fsf@grenoble-inp.fr>
	<6733a9080da07ace27c3252de2399be339b4e349.1367245712.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@inf.ethz.ch>,
	Jiang Xin <worldhello.net@gmail.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon Apr 29 16:47:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UWpMj-0004Z0-AO
	for gcvg-git-2@plane.gmane.org; Mon, 29 Apr 2013 16:47:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754605Ab3D2Orh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Apr 2013 10:47:37 -0400
Received: from mx2.imag.fr ([129.88.30.17]:36419 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753661Ab3D2Org (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Apr 2013 10:47:36 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r3TEj2Rc020696
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 29 Apr 2013 16:45:04 +0200
Received: from anie.imag.fr ([129.88.7.32] helo=anie)
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1UWpKC-0003i5-C4; Mon, 29 Apr 2013 16:45:04 +0200
In-Reply-To: <6733a9080da07ace27c3252de2399be339b4e349.1367245712.git.git@drmicha.warpmail.net>
	(Michael J. Gruber's message of "Mon, 29 Apr 2013 16:30:57 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 29 Apr 2013 16:45:05 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r3TEj2Rc020696
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1367851505.74848@7ejJyR9Dan+UC26fN65BEw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222798>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> -z makes clean output only the names of paths which are or would be
> deleted, and separates them with \0.

My first reaction was: Is it not a job for "git ls-files"?

Actually, you already almost have it:

git clean -d  => git ls-files --exclude-standard --directory -o
git clean -dx => git ls-files -z --exclude-standard --directory -io

OTOH, the "git clean" without -d are not exposed directly AFAICT, and
the set of options of "git clean" may make more sense.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
