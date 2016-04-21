From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: history damage in linux.git
Date: Thu, 21 Apr 2016 18:36:10 +0200
Message-ID: <vpqy486udfp.fsf@anie.imag.fr>
References: <20160421113004.GA3140@aepfle.de>
	<20160421131916.GB1589@serenity.lan> <20160421155408.GE3186@aepfle.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: John Keeping <john@keeping.me.uk>, git@vger.kernel.org
To: Olaf Hering <olaf@aepfle.de>
X-From: git-owner@vger.kernel.org Thu Apr 21 18:36:51 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1atHaz-00080h-WE
	for gcvg-git-2@plane.gmane.org; Thu, 21 Apr 2016 18:36:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752182AbcDUQgp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Apr 2016 12:36:45 -0400
Received: from mx2.imag.fr ([129.88.30.17]:53872 "EHLO mx2.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751897AbcDUQgo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Apr 2016 12:36:44 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by mx2.imag.fr (8.13.8/8.13.8) with ESMTP id u3LGa8gX026747
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Thu, 21 Apr 2016 18:36:08 +0200
Received: from anie (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u3LGaBWx014236;
	Thu, 21 Apr 2016 18:36:11 +0200
In-Reply-To: <20160421155408.GE3186@aepfle.de> (Olaf Hering's message of "Thu,
	21 Apr 2016 17:54:08 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (mx2.imag.fr [129.88.30.17]); Thu, 21 Apr 2016 18:36:09 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u3LGa8gX026747
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1461861372.77174@yL2AtnPf5w3CKKaxKza85Q
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292121>

Olaf Hering <olaf@aepfle.de> writes:

> On Thu, Apr 21, John Keeping wrote:
>
>> 	$ git tag --contains aed06b9cfcabf8644ac5f6f108c0b3d01522f88b
>
> Thanks for that, I did not know this variant.
>
> Unless git does not do it for me, I may hackup my script like that to
> find the earlierst tag:

"git tag" has a --sort key, so you can sort on dates, and "| head -n 1".
See also "git for-each-ref" which is essentially a superset of what "git
tag" does, and for-each-ref is plumbing, so safer to use in scripts (we
have a strong tradition of backward compatibility for plumbing).

This relies on the dates recorded in the commits, which may be wrong
(typically if someone commited on a machine with an incorrect clock).
But hopefully not.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
