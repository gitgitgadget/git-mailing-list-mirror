From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v4 0/5] Disable "git status" comment prefix
Date: Fri, 06 Sep 2013 20:43:59 +0200
Message-ID: <vpqsixhrdsg.fsf@anie.imag.fr>
References: <1378374618-31439-1-git-send-email-Matthieu.Moy@imag.fr>
	<xmqqhadzhyjb.fsf@gitster.dls.corp.google.com>
	<vpqioyfukkw.fsf@anie.imag.fr>
	<20130905232322.GB29351@sigill.intra.peff.net>
	<20130906165330.GA6462@google.com> <vpq38phsvuc.fsf@anie.imag.fr>
	<xmqqk3ityg2x.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 06 20:45:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VI12T-0007yM-6u
	for gcvg-git-2@plane.gmane.org; Fri, 06 Sep 2013 20:45:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751326Ab3IFSpn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Sep 2013 14:45:43 -0400
Received: from mx1.imag.fr ([129.88.30.5]:46014 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751139Ab3IFSpn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Sep 2013 14:45:43 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r86IhvrD015741
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 6 Sep 2013 20:43:57 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1VI10h-0000xJ-V6; Fri, 06 Sep 2013 20:44:00 +0200
In-Reply-To: <xmqqk3ityg2x.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Fri, 06 Sep 2013 11:12:38 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Fri, 06 Sep 2013 20:43:58 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r86IhvrD015741
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1379097842.81157@g5EOwZ167YOAw/BUJdRbwQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234085>

Junio C Hamano <gitster@pobox.com> writes:

> Actually, "nothing added ..." is not a part of status proper; it
> will be clear if you run the command with comment prefix, whose
> output may end like so:
>
>     # Untracked files:
>     #   (use "git add <file>..." to include in what will be committed)
>     #
>     #       gomi
>     #       kuzu
>     nothing added to commit but untracked files present (use "git add" to track)
>
> But I agree that the output without comment prefix needs an extra
> blank before that line (if that line will be emitted, that is).

Even when the line is not emitted, we normally do:

# On branch master
# Changes to be committed:
#   (use "git reset HEAD <file>..." to unstage)
#
#	modified:   foo.txt
#

(with the last #-only line), so there's no reason to behave differently
when the last lines are "Untracked files".

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
