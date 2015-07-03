From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v2 2/4] log: add --count option to git log
Date: Fri, 03 Jul 2015 11:16:35 +0200
Message-ID: <vpqfv5538jw.fsf@anie.imag.fr>
References: <1435881011-13879-1-git-send-email-lawrencesiebert@gmail.com>
	<1435881011-13879-3-git-send-email-lawrencesiebert@gmail.com>
	<vpqa8vd66ms.fsf@anie.imag.fr>
	<CAKDoJU5vHP8c+Cvk1vBjjMG3kHD_rN3XwmfVngMYLN2Tkcg-tQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org,
	Remi Galan Alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: Lawrence Siebert <lawrencesiebert@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 03 11:16:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZAx5X-0006uZ-O1
	for gcvg-git-2@plane.gmane.org; Fri, 03 Jul 2015 11:16:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754809AbbGCJQr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jul 2015 05:16:47 -0400
Received: from mx2.imag.fr ([129.88.30.17]:52992 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754257AbbGCJQm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jul 2015 05:16:42 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t639GYVq012624
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 3 Jul 2015 11:16:34 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t639GZ1S025479;
	Fri, 3 Jul 2015 11:16:35 +0200
In-Reply-To: <CAKDoJU5vHP8c+Cvk1vBjjMG3kHD_rN3XwmfVngMYLN2Tkcg-tQ@mail.gmail.com>
	(Lawrence Siebert's message of "Fri, 3 Jul 2015 01:05:50 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Fri, 03 Jul 2015 11:16:35 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t639GYVq012624
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1436519796.82276@WqbYMS4AR2lx35P8EG1NIQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273288>

Hi,

Please, don't top-post on this list. Quote the parts you're replying to
and reply below.

Lawrence Siebert <lawrencesiebert@gmail.com> writes:

> traverse_commit_list requires a function to be passed to it.  That
> said, after further review it can probably pass NULL and have it work
> fine.  If not, I'll use your naming convention.

If possible, passing NULL would be best.

> `git rev-list --count` (or actually `git rev-list --count HEAD`, which
> this borrows the code from, produces a single value, a numeric count.
> I think walking the entire list is necessary to get the final value,
> which is what we want with --count.

OK, that was me answering emails before coffee. I thought --count was
producing the count _in addition_ to the normal output. But then I don't
understand by looking at the code how you prevent the normal output. I
just tested, and indeed it does work (I guess all the magic is already
there from "rev-list --count", and it was more or less a bug that "log
--count" was not using it properly), but you may want to explain better
what's going on in the commit message.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
