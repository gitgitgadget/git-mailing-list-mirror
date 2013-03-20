From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Bug? git show behaves incorrectly when called on a stash object
Date: Wed, 20 Mar 2013 16:56:33 +0100
Message-ID: <vpqsj3qoyj2.fsf@grenoble-inp.fr>
References: <AF060B6D-27F7-45BE-9BC3-85FAF3487481@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Kirill Likhodedov <kirill.likhodedov@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 20 16:57:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UILNy-0007dV-Bo
	for gcvg-git-2@plane.gmane.org; Wed, 20 Mar 2013 16:57:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932227Ab3CTP4i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Mar 2013 11:56:38 -0400
Received: from mx2.imag.fr ([129.88.30.17]:45794 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757355Ab3CTP4h (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Mar 2013 11:56:37 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r2KFuVm9029305
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 20 Mar 2013 16:56:31 +0100
Received: from anie.imag.fr ([129.88.7.32] helo=anie)
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1UILNR-0000q4-Dr; Wed, 20 Mar 2013 16:56:33 +0100
In-Reply-To: <AF060B6D-27F7-45BE-9BC3-85FAF3487481@gmail.com> (Kirill
	Likhodedov's message of "Wed, 20 Mar 2013 19:08:58 +0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 20 Mar 2013 16:56:31 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r2KFuVm9029305
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1364399793.04359@So2566m2bDA3Wp2aMrau8g
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218615>

Kirill Likhodedov <kirill.likhodedov@gmail.com> writes:

> The first gives the correct result, while the second doesn't show the addition.
> Is it a bug, or I'm just missing something?

stash objects are commits with 2 parents (ie. merge commits). One commit
is the HEAD you stashed from, and the other is the saved state of the
index. I'm not sure from the doc what the semantics of --name-status is
for merge commits, but it seems it shows only files modified in both
parents.

Use git show --first-parent --name-status, it should do what you expect
(or -m instead of --first-parent).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
