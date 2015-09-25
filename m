From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v6b 5/8] branch: drop non-commit error reporting
Date: Fri, 25 Sep 2015 07:55:19 +0200
Message-ID: <vpqk2rfm4ag.fsf@grenoble-inp.fr>
References: <1443031873-25280-1-git-send-email-Karthik.188@gmail.com>
	<1443118148-3470-1-git-send-email-Karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, christian.couder@gmail.com, gitster@pobox.com
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 25 07:55:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZfLyo-000639-7F
	for gcvg-git-2@plane.gmane.org; Fri, 25 Sep 2015 07:55:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752379AbbIYFz3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Sep 2015 01:55:29 -0400
Received: from mx2.imag.fr ([129.88.30.17]:38794 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751206AbbIYFz2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Sep 2015 01:55:28 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t8P5tJQe009679
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Fri, 25 Sep 2015 07:55:19 +0200
Received: from anie (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t8P5tJo1003923;
	Fri, 25 Sep 2015 07:55:19 +0200
In-Reply-To: <1443118148-3470-1-git-send-email-Karthik.188@gmail.com> (Karthik
	Nayak's message of "Thu, 24 Sep 2015 23:39:08 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Fri, 25 Sep 2015 07:55:19 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t8P5tJQe009679
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1443765322.6443@tdLS9xutc8KLRuk2hhoJPg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278649>

Karthik Nayak <karthik.188@gmail.com> writes:

> Remove the error "branch '%s' does not point at a commit" in
> apppend_ref() which reports branch refs which do not point to
> commits. Also remove the error "some refs could not be read" in
> print_ref_list() which is triggered as a consequence of the first
> error.
>
> This seems to be the wrong codepath whose purpose is not to diagnose
> and report a repository corruption. If we care about such a repository
> corruption, we should report it from fsck instead.

(We actually already report it from fsck indeed)

> This also helps in a smooth port of branch.c to use ref-filter APIs
> over the following patches. On the other hand, ref-filter ignores refs
> which do not point at commits silently.

Seems much better. Thanks,

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
