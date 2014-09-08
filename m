From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [RFC PATCH v2 1/2] Makefile: add check-headers target
Date: Mon, 08 Sep 2014 21:29:31 +0200
Message-ID: <vpqsik13o84.fsf@anie.imag.fr>
References: <1410049821-49861-1-git-send-email-davvid@gmail.com>
	<xmqqiokylz46.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: David Aguilar <davvid@gmail.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>,
	=?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 08 21:30:09 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XR4dc-0004K4-GZ
	for gcvg-git-2@plane.gmane.org; Mon, 08 Sep 2014 21:30:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754056AbaIHT3s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Sep 2014 15:29:48 -0400
Received: from mx2.imag.fr ([129.88.30.17]:37864 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753446AbaIHT3r (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Sep 2014 15:29:47 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id s88JTTwb024521
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 8 Sep 2014 21:29:29 +0200
Received: from anie.imag.fr (ensi-vpn-248.imag.fr [129.88.57.248])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s88JTV3C001413;
	Mon, 8 Sep 2014 21:29:31 +0200
In-Reply-To: <xmqqiokylz46.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Mon, 08 Sep 2014 11:56:57 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 08 Sep 2014 21:29:29 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s88JTTwb024521
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1410809371.19841@RfFkxVB+CoNUQ2pJXL45wQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256670>

Junio C Hamano <gitster@pobox.com> writes:

> David Aguilar <davvid@gmail.com> writes:
>
>> +IFS='
>> +'
>> +git ls-files *.h ewah/*.h vcs-svn/*.h xdiff/*.h |
>
> Hmm.  This is only for true developers (not one who merely compiles
> after expanding a tarball), so "git ls-files" may probably be OK.
>
> But "/bin/ls" would be equally fine for that, no?

Actually, since this is "| while read header", I have to wonder why this
is not written as

for header in .h ewah/*.h vcs-svn/*.h xdiff/*.h
do
	...
done

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
