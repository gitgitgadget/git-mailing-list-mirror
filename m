From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [WIP-PATCH 0/2] send-email: refactor the email parser loop
Date: Mon, 30 May 2016 16:20:45 +0200
Message-ID: <vpqfuszaapu.fsf@anie.imag.fr>
References: <20160527140104.11192-1-samuel.groot@grenoble-inp.org>
	<20160527201436.GA16547@dcvr.yhbt.net> <vpq8tyujkb0.fsf@anie.imag.fr>
	<7423b133-cec4-e633-f1ef-70ccc6a6cc02@grenoble-inp.org>
	<vpq8tyshh8f.fsf@anie.imag.fr>
	<0abbc11b-5741-ee2e-292c-245c2b974f8e@grenoble-inp.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Eric Wong <e@80x24.org>, git@vger.kernel.org,
	erwan.mathoniere@grenoble-inp.org, jordan.de-gea@grenoble-inp.org,
	gitster@pobox.com, aaron@schrab.com
To: Samuel GROOT <samuel.groot@grenoble-inp.org>
X-From: git-owner@vger.kernel.org Mon May 30 16:21:21 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b7O4F-0005jj-4D
	for gcvg-git-2@plane.gmane.org; Mon, 30 May 2016 16:21:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754964AbcE3OVM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 May 2016 10:21:12 -0400
Received: from mx1.imag.fr ([129.88.30.5]:39364 "EHLO mx1.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933116AbcE3OU6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 May 2016 10:20:58 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by mx1.imag.fr (8.13.8/8.13.8) with ESMTP id u4UEKiun031125
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Mon, 30 May 2016 16:20:45 +0200
Received: from anie (anie.imag.fr [129.88.42.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u4UEKj9H005764;
	Mon, 30 May 2016 16:20:45 +0200
In-Reply-To: <0abbc11b-5741-ee2e-292c-245c2b974f8e@grenoble-inp.org> (Samuel
	GROOT's message of "Mon, 30 May 2016 16:01:29 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (mx1.imag.fr [129.88.30.5]); Mon, 30 May 2016 16:20:46 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u4UEKiun031125
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1465222846.46203@/ktBB+ZvAlll/H1i8ulZLw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295900>

Samuel GROOT <samuel.groot@grenoble-inp.org> writes:

> (mbox) prefix was introduced by Ryan Anderson in 2005 (can't find the
> exact commit though), in opposition with the (non-mbox) format ("lots
> of email") that was used before.

That is actually from the original commit introducing send-email:
83b2443 ([PATCH] Add git-send-email-script - tool to send emails from
git-format-patch-script, 2005-07-31), i.e. ~3 month after Git was born.

At that time, user-friendlyness was not really a priority ;-).

> Is the "lots of email" format still used?

AFAICT, it was initially supported for backward compatibility, and then
no one removed it, but I wouldn't be surprised if no one actually used
it.

I vaguely remember a message from Ryan Anderson being surprised to see
the old format still supported, but I can't find it in the archives.

In any case:

- git log --grep 'lots of email' => shows only 83b2443
- git log -S'lots of email' => likewise
- git grep 'lots of email' => just one answer in a comment

I'm not sure the feature is even tested.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
