From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] contrib/hooks/post-receive-email: get description from repo.git/config
Date: Tue, 07 May 2013 17:36:54 +0200
Message-ID: <vpq61yuol7t.fsf@grenoble-inp.fr>
References: <15tsj20cizd.fsf@tux.uio.no>
	<7vtxmgruhc.fsf@alter.siamese.dyndns.org>
	<vpq1u9kunba.fsf@grenoble-inp.fr>
	<7vwqrbmh4d.fsf@alter.siamese.dyndns.org>
	<5188B165.3050709@alum.mit.edu>
	<7vr4hilt28.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Trond Hasle Amundsen <t.h.amundsen@usit.uio.no>,
	git@vger.kernel.org, Marc Branchaud <mbranchaud@xiplink.com>,
	=?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
	Chris Hiestand <chiestand@salk.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 07 17:37:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UZjxG-0006s8-Of
	for gcvg-git-2@plane.gmane.org; Tue, 07 May 2013 17:37:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756893Ab3EGPhV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 May 2013 11:37:21 -0400
Received: from mx2.imag.fr ([129.88.30.17]:43992 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752781Ab3EGPhU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 May 2013 11:37:20 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r47Faqjf030301
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 7 May 2013 17:36:52 +0200
Received: from anie.imag.fr ([129.88.7.32] helo=anie)
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1UZjwk-0004b6-Cx; Tue, 07 May 2013 17:36:54 +0200
In-Reply-To: <7vr4hilt28.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Tue, 07 May 2013 08:15:43 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Tue, 07 May 2013 17:36:53 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r47Faqjf030301
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1368545815.18042@Qt+MJrZuifJjjqyaHbDRrA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223582>

Junio C Hamano <gitster@pobox.com> writes:

> I have a mildly strong suspicion that a better approach might be to:
>
>  - Copy the current stable snapshot to the contrib/ area, [...]
>
>  - Keep the development at your GitHub repository, [...]
>
>  - Update what is in contrib/ in my tree with a stable snapshot,
>    every once in a while [...]

I think this is not very different from

- merge the current version in the contrib/ area

- keep the development at the GitHub repository

- merge the GitHub repository into the git.git once in a while

(which is essentially what happens with gitk and git-gui as far as I
understood)

I tend to prefer the "merge" approach to the "copy files from one repo
to another", even if git_multimail is never edited directly from
git.git. I find it conceptually cleaner, and it gives a bit more
flexibility (e.g. if someone accidentally commits in git.git's
repository, the commit would also be valid wrt git_multimail's GitHub
repo, and can serve as a pull request).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
