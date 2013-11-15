From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Fwd: Possible bug report: `git commit -ammend`
Date: Fri, 15 Nov 2013 16:54:56 +0100
Message-ID: <vpqsiux1wz3.fsf@anie.imag.fr>
References: <CAMyx446B1U30RL9X7vOrY-u7fQ_cEqRJxn_M8Wn8PuOJhdO-1Q@mail.gmail.com>
	<CAMyx444wJeQUpxZmXmYx-mKE0kniO=ELo5HgzQ1unV4O15oxWw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: rhys evans <rhys.evans@ft.com>
X-From: git-owner@vger.kernel.org Fri Nov 15 16:55:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VhLjf-0004Dl-Cb
	for gcvg-git-2@plane.gmane.org; Fri, 15 Nov 2013 16:55:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751422Ab3KOPzE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Nov 2013 10:55:04 -0500
Received: from mx2.imag.fr ([129.88.30.17]:35270 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751085Ab3KOPzB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Nov 2013 10:55:01 -0500
Received: from globule.imag.fr (globule.imag.fr [129.88.34.238])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id rAFFstBe028310
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 15 Nov 2013 16:54:55 +0100
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	(authenticated bits=0)
	by globule.imag.fr (8.13.8/8.13.8) with ESMTP id rAFFsuIU015390
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Fri, 15 Nov 2013 16:54:56 +0100
In-Reply-To: <CAMyx444wJeQUpxZmXmYx-mKE0kniO=ELo5HgzQ1unV4O15oxWw@mail.gmail.com>
	(rhys evans's message of "Fri, 15 Nov 2013 15:44:18 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Fri, 15 Nov 2013 16:54:55 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: rAFFstBe028310
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1385135696.67707@pNXlo9RSwD2jrbbUc2pvTQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237911>

rhys evans <rhys.evans@ft.com> writes:

> I ran `git commit -ammend` on a repo where 1 out of 3 files changed
> were staged for commit.
>
> I would've expected an error to be thrown due to the double typo but
> instead it committed all 3 files with the message 'mend'.
>
> So it looks like it interpreted it as `git commit -a -m 'mend'`.

Yes. This is a rather widespread convention (e.g. rm -fr == rm -r -f).
Git does a special-case for -amend to avoid confusion:

  $ git commit -amend
  error: did you mean `--amend` (with two dashes ?)

But it did not special-case the double-typo.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
