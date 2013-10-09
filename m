From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Fwd: [PATCH] git-subtree: Avoid using echo -n even indirectly
Date: Wed, 09 Oct 2013 13:26:19 +0200
Message-ID: <vpqy562y9b8.fsf@anie.imag.fr>
References: <1381291045-98372-1-git-send-email-p.giarrusso@gmail.com>
	<CALUzUxovH5MTP1_DMigRx1Hp+X6v3_YdLK2vSG4KwRLNSDHN-w@mail.gmail.com>
	<CAAcnjCT1bdR+9kDW=q_326OhiSMm3_j-yOh0-ayTkObK3bZ3bQ@mail.gmail.com>
	<CAAcnjCQ+c=8wYZkqS7VzZ_bDDDkSwdQ3qdz77osrSpKDS9ON7Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Tay Ray Chuan <rctay89@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Paolo Giarrusso <p.giarrusso@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 09 13:26:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VTruV-0004UB-CY
	for gcvg-git-2@plane.gmane.org; Wed, 09 Oct 2013 13:26:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752082Ab3JIL0a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Oct 2013 07:26:30 -0400
Received: from mx1.imag.fr ([129.88.30.5]:57287 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751676Ab3JIL03 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Oct 2013 07:26:29 -0400
Received: from globule.imag.fr (globule.imag.fr [129.88.34.238])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r99BQO3g016680
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 9 Oct 2013 13:26:24 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	(authenticated bits=0)
	by globule.imag.fr (8.13.8/8.13.8) with ESMTP id r99BQKkX031685
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Wed, 9 Oct 2013 13:26:25 +0200
In-Reply-To: <CAAcnjCQ+c=8wYZkqS7VzZ_bDDDkSwdQ3qdz77osrSpKDS9ON7Q@mail.gmail.com>
	(Paolo Giarrusso's message of "Wed, 9 Oct 2013 12:32:31 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 09 Oct 2013 13:26:24 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r99BQO3g016680
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1381922785.24241@VSvnzZ8StXFAsPmlgLZL8Q
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235807>

Paolo Giarrusso <p.giarrusso@gmail.com> writes:

> Otherwise, one could
> change say to use printf, but that's more invasive.

"invasive" in the sense that it impacts indirectly more callers, but are
there really cases where "echo" is needed when calling "say"? Aren't
there other potential bugs when arbitrary strings are passed to "say",
that would be fixed by using printf once and for all?

The patch would look like the one I did in 89b0230a20 (Wed Aug 7 2013,
die_with_status: use "printf '%s\n'", not "echo").

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
