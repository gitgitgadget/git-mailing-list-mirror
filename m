From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Minor annoyance with 'git interpret-trailers'
Date: Thu, 20 Aug 2015 18:37:28 +0200
Message-ID: <vpqy4h5ud9z.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
To: git <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Thu Aug 20 18:37:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZSSqQ-0004VW-Lf
	for gcvg-git-2@plane.gmane.org; Thu, 20 Aug 2015 18:37:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751695AbbHTQhd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Aug 2015 12:37:33 -0400
Received: from mx1.imag.fr ([129.88.30.5]:45789 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751632AbbHTQhc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Aug 2015 12:37:32 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t7KGbQVM005412
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Thu, 20 Aug 2015 18:37:26 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t7KGbSx2007022;
	Thu, 20 Aug 2015 18:37:28 +0200
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 20 Aug 2015 18:37:26 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t7KGbQVM005412
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1440693448.05528@jARVrX5JL99r/uiCGBjzcw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276250>

Hi,

I use 'git interpret-trailers' as a commit-msg hook to add a
Signed-off-by in a repository.

When used in a one-line commit message formatted like
'foo: do something', the command interprets the one-line summary as a
trailer, and inserts my Signed-off-by after it, without a blank line:

    foo: do something
    Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>

This breaks the convention "One summary line, one blank line, and then
body", and shows my sign-off in the output of "git log --oneline" :-(.

I think the behavior "don't insert a newline if the last line looks like
a trailer" should be disabled when the message is a one-liner.

Cheers,

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
