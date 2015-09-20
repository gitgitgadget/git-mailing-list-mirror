From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v5 5/8] branch: drop non-commit error reporting
Date: Sun, 20 Sep 2015 21:16:20 +0200
Message-ID: <vpq6134gauz.fsf@anie.imag.fr>
References: <1442772627-25421-1-git-send-email-Karthik.188@gmail.com>
	<1442772627-25421-6-git-send-email-Karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, christian.couder@gmail.com, gitster@pobox.com
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 20 21:16:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zdk6A-0005oy-8m
	for gcvg-git-2@plane.gmane.org; Sun, 20 Sep 2015 21:16:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755349AbbITTQZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Sep 2015 15:16:25 -0400
Received: from mx2.imag.fr ([129.88.30.17]:42547 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755253AbbITTQZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Sep 2015 15:16:25 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t8KJGHO0007274
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Sun, 20 Sep 2015 21:16:18 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t8KJGKhA009347;
	Sun, 20 Sep 2015 21:16:20 +0200
In-Reply-To: <1442772627-25421-6-git-send-email-Karthik.188@gmail.com>
	(Karthik Nayak's message of "Sun, 20 Sep 2015 23:40:24 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Sun, 20 Sep 2015 21:16:18 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t8KJGHO0007274
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1443381378.59295@xioyykSXnzWtqVl3GsqN4g
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278260>

Karthik Nayak <karthik.188@gmail.com> writes:

> Remove the error reporting variable to make the code easier to port
> over to using ref-filter APIs. This variable

(it's not just a variable, it's also a message on the output)

> is not required as in ref-filter we already check for possible errors
> and report them.

You should explain more why the check is redundant with the ones in
ref-filter. You discussed this with Junio on the last round. The
arguments you gave would deserve to appear in the commit message IMHO.
Pointing to the exact checks in ref-filter would help.

It may make sense to split the commit into several smaller ones, so that
you can give a precise commit message for each error reporting you
remove (error(_("branch '%s' does not point at a commit") and
error(_("some refs could not be read"))).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
