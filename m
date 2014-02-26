From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [RFC 3/3] reset: Change the default behavior to use "--merge" during a merge
Date: Wed, 26 Feb 2014 19:21:54 +0100
Message-ID: <vpq8usxenul.fsf@anie.imag.fr>
References: <1393437985-31401-1-git-send-email-andrew.kw.w@gmail.com>
	<1393437985-31401-4-git-send-email-andrew.kw.w@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Andrew Wong <andrew.kw.w@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 26 19:22:07 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WIj7O-0000K6-Tg
	for gcvg-git-2@plane.gmane.org; Wed, 26 Feb 2014 19:22:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751941AbaBZSWB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Feb 2014 13:22:01 -0500
Received: from mx1.imag.fr ([129.88.30.5]:43522 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751720AbaBZSWA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Feb 2014 13:22:00 -0500
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id s1QILqPg028113
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 26 Feb 2014 19:21:52 +0100
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s1QILsdf022383;
	Wed, 26 Feb 2014 19:21:54 +0100
In-Reply-To: <1393437985-31401-4-git-send-email-andrew.kw.w@gmail.com> (Andrew
	Wong's message of "Wed, 26 Feb 2014 13:06:25 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 26 Feb 2014 19:21:52 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s1QILqPg028113
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1394043716.31569@/l9hJvAcq1lE9yzwWG3vPA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242744>

Andrew Wong <andrew.kw.w@gmail.com> writes:

> If the user wants to do "git reset" during a merge, the user most likely
> wants to do a "git reset --merge". This is especially true during a
> merge conflict and the user had local changes, because "git reset" would
> leave the merged changes mixed in with the local changes. This makes
> "git reset" a little more user-friendly during a merge.

But this breaks backward compatibility.

I sometimes run "git reset" during a merge to only reset the index and
then examine the changes introduced by the merge. With your changes,
someone doing so would abort the merge and discard the merge resolution.
I very rarely do this, but even rarely, I wouldn't like Git to start
droping data silently for me ;-).

I'm not really convinced that this is such a good change, and if we go
this way, there should be a transition to let users stop using
argumentless "git reset" to reset the index during a merge.

The other 2 patches look good to me.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
