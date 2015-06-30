From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 0/3] rebase -i: drop, missing commits and static checks
Date: Tue, 30 Jun 2015 19:03:46 +0200
Message-ID: <vpqy4j12knh.fsf@anie.imag.fr>
References: <1435609232-14232-1-git-send-email-remi.galan-alfonso@ensimag.grenoble-inp.fr>
	<1435655961-31263-1-git-send-email-Matthieu.Moy@imag.fr>
	<1849903896.89424.1435676774069.JavaMail.zimbra@ensimag.grenoble-inp.fr>
	<xmqq7fql8949.fsf@gitster.dls.corp.google.com>
	<70428267.93232.1435683724659.JavaMail.zimbra@ensimag.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	remi lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
	guillaume pages <guillaume.pages@ensimag.grenoble-inp.fr>,
	louis--alexandre stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	antoine delaite <antoine.delaite@ensimag.grenoble-inp.fr>,
	sunshine@sunshineco.com
To: Remi Galan Alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Jun 30 19:04:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z9yx4-0007dr-VZ
	for gcvg-git-2@plane.gmane.org; Tue, 30 Jun 2015 19:04:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753194AbbF3REC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Jun 2015 13:04:02 -0400
Received: from mx2.imag.fr ([129.88.30.17]:35699 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752810AbbF3REA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jun 2015 13:04:00 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t5UH3i0D013620
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 30 Jun 2015 19:03:44 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t5UH3kUP030171;
	Tue, 30 Jun 2015 19:03:46 +0200
In-Reply-To: <70428267.93232.1435683724659.JavaMail.zimbra@ensimag.grenoble-inp.fr>
	(Remi Galan Alfonso's message of "Tue, 30 Jun 2015 19:02:04 +0200
	(CEST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Tue, 30 Jun 2015 19:03:45 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t5UH3i0D013620
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1436288625.84664@3pou80x+zf4Az9Nh1oB2RA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273083>

Remi Galan Alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>> The place where an error can be introduced is (assuming that what
>> "rebase -i" writes out itself is perfect ;-) where we allow the user
>> to edit, so instead of checking before "--continue", I would expect
>> a sane design would check immediately after the editor we spawned
>> returns.
>
> Makes sense but we would have the problem mentioned by Matthieu:
>> Warning: the command isn't recognized ...
>>   
>> # Hmm, let's ignore that warning
>> $ git rebase --continue

There's an alternative:

$ git rebase --edit-todo
# Make mistakes, save and quit
Your todo-list has the following issues:
- ...
Do you want to edit again (no aborts the rebase) [Y/n]?

There's a precedent with the 'e' command of "git add -p". I have a
slight preference for non-interactive commands so I prefer not going
this way though.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
