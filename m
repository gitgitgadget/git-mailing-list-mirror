From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [RFC v2] git-multimail: a replacement for post-receive-email
Date: Wed, 20 Feb 2013 13:28:15 +0100
Message-ID: <vpqfw0rb25c.fsf@grenoble-inp.fr>
References: <5104E738.602@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git discussion list <git@vger.kernel.org>,
	Andy Parkins <andyparkins@gmail.com>,
	Sitaram Chamarty <sitaramc@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Marc Branchaud <mbranchaud@xiplink.com>,
	=?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
	Chris Hiestand <chiestand@salk.edu>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Feb 20 13:28:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U88nC-0002jG-C2
	for gcvg-git-2@plane.gmane.org; Wed, 20 Feb 2013 13:28:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935305Ab3BTM2a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Feb 2013 07:28:30 -0500
Received: from mx2.imag.fr ([129.88.30.17]:59021 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934845Ab3BTM22 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Feb 2013 07:28:28 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r1KCSEMR022751
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 20 Feb 2013 13:28:14 +0100
Received: from anie.imag.fr ([129.88.7.32] helo=anie)
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1U88mV-0006x5-Lo; Wed, 20 Feb 2013 13:28:15 +0100
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 20 Feb 2013 13:28:15 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r1KCSEMR022751
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1361968097.45048@R/gXr8PlxlYXO9Yu4TXjtQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216705>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> A while ago, I submitted an RFC for adding a new email notification
> script to "contrib" [1]. 

We've discussed offline with Michael, a few patches have been merged,
and there are still a few pending pull requests. I liked the script
already, but it's getting even cooler ;-).

A few more random thoughts (not on my personal todo-list):

* It may make sense to add the short sha1 of the new reference in email
  titles (branch foo updated -> branch foo updated to $sha1), so that
  gmail users do not get a single huge thread "branch foo updated".

  (Yes, I do know about the Reference field, but gmail uses Subject: for
  threading).

* Perhaps we should allow a per-branch configuration, like

  [multimailhook]
	mailingList = some@list.com
  [multimailhook "refs/heads/my-branch"]
        mailingList = some-other@list.com
        <whateverOtherConfig> = <whateverOtherValue>

  Branch specific would override value for Config.get(), and
  Config.get_all() should probably list both the branch-specific and the
  other keys.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
