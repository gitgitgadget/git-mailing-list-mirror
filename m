From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: BUG? git log --no-merges shows grafted merges in shallow clones
Date: Fri, 26 Feb 2016 21:05:43 +0100
Message-ID: <vpqwpprqlt4.fsf@anie.imag.fr>
References: <vpq4mcvs146.fsf@anie.imag.fr>
	<xmqqfuwfjl8e.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 26 21:05:56 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZOeB-00019W-EL
	for gcvg-git-2@plane.gmane.org; Fri, 26 Feb 2016 21:05:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933304AbcBZUFw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Feb 2016 15:05:52 -0500
Received: from mx2.imag.fr ([129.88.30.17]:58197 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750915AbcBZUFv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Feb 2016 15:05:51 -0500
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id u1QK5eX4019299
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Fri, 26 Feb 2016 21:05:40 +0100
Received: from anie (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u1QK5h31012335;
	Fri, 26 Feb 2016 21:05:43 +0100
In-Reply-To: <xmqqfuwfjl8e.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Fri, 26 Feb 2016 12:00:01 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Fri, 26 Feb 2016 21:05:40 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u1QK5eX4019299
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1457121942.81448@o7opXlNbk9PIiDVxekpOjw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287617>

Junio C Hamano <gitster@pobox.com> writes:

> I do not think this is limited to shallow but for grafts in
> general.  

Probably yes. I happen to only use grafts in shallow clones ;-).

> cat-file is low-level to show the bare metal, but by using these
> facility you asked Git to give you an imaginary history where that
> commit is the root commit--and that is why it is shown, I think.
>
> What does it do if you say "git -c log.showRoot=false log -p"?

I get the commit without the patch:

commit c3c1cc25b27d448e9ef67b265a11be8735ff2df4 (grafted)
Author: Matthieu Moy <Matthieu.Moy@imag.fr>
Date:   Mon Aug 31 16:32:20 2015 +0200

    Merge remote-tracking branch 'edward/utf-8-email-support4'

Without "-c log.showRoot=false" I get a big patch (diff of the commit
against the empty tree).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
