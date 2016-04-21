From: Yaroslav Halchenko <yoh@onerussian.com>
Subject: 'next'ed --allow-unrelated-histories could cause lots of grief
Date: Thu, 21 Apr 2016 12:10:43 -0400
Message-ID: <20160421161043.GK7907@onerussian.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Benjamin Poldrack <benjaminpoldrack@gmail.com>,
	Joey Hess <id@joeyh.name>
To: Git Gurus hangout <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Apr 21 18:11:00 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1atHBz-0005Vm-Pq
	for gcvg-git-2@plane.gmane.org; Thu, 21 Apr 2016 18:11:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753564AbcDUQKr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Apr 2016 12:10:47 -0400
Received: from washoe.dartmouth.edu ([129.170.30.229]:50443 "EHLO
	smtp.onerussian.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751871AbcDUQKq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Apr 2016 12:10:46 -0400
Received: from smtp.onerussian.com ([192.168.100.6] helo=washoe.onerussian.com)
	by smtp.onerussian.com with esmtps (TLS1.2:RSA_AES_128_CBC_SHA1:128)
	(Exim 4.80)
	(envelope-from <yoh@onerussian.com>)
	id 1atHBj-0003px-Ra; Thu, 21 Apr 2016 12:10:43 -0400
Received: from yoh by washoe.onerussian.com with local (Exim 4.84)
	(envelope-from <yoh@onerussian.com>)
	id 1atHBj-0003ps-KV; Thu, 21 Apr 2016 12:10:43 -0400
Content-Disposition: inline
X-URL: http://www.onerussian.com
X-Image-Url: http://www.onerussian.com/img/yoh.png
X-PGP-Key: http://www.onerussian.com/gpg-yoh.asc
X-fingerprint: C5B9 05F0 E8D9 FD96 68FF  366F A2DE 2350 62DA 33FA
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: 192.168.100.6
X-SA-Exim-Rcpt-To: git@vger.kernel.org, benjaminpoldrack@gmail.com, id@joeyh.name
X-SA-Exim-Mail-From: yoh@onerussian.com
X-SA-Exim-Scanned: No (on smtp.onerussian.com); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292119>

Dear Git Gurus,

I guess whenever it rains it indeed pours, so it is me whining again.

I have decided to try 2.8.1.369.geae769a available from debian
experimental and through our (datalad) tests failing I became
aware of the 

    https://github.com/git/git/pull/158/commits/e379fdf34fee96cd205be83ff4e71699bdc32b18
    merge: refuse to create too cool a merge by default

which is planned for the next release.  I guess it is indeed a
worthwhile accident-prevention measure BUT not sure if it is so
important as to cause a change in behavior on which some projects using
git through the cmdline interface might have been relying upon for
years!

Given that git is quite 'self-healing', i.e. if someone has managed to
make a merge he didn't intend to, there is always a way back (e.g., as
simple as git reset --hard HEAD^), I am really not sure how valuable
such change of default behavior would be?  Could it may be made into a
warning instead? or reversed option "--dont-allow-unrelated-histories"?

Moreover, it was explicitly stated that "no configuration variable to
enable this by default exists and will not be added", which would cause
3rd party scripts/code/projects relying on previous behavior  to provide
version specific handling (either to add that
--allow-unrelated-histories or not)... very cumbersome!  If nothing else
remains, could there at least be a config option which we could
then use regardless of the version of git we are using for such merges?

P.S. Please maintain CC list

Thank you in advance for your consideration,
-- 
Yaroslav O. Halchenko
Center for Open Neuroscience     http://centerforopenneuroscience.org
Dartmouth College, 419 Moore Hall, Hinman Box 6207, Hanover, NH 03755
Phone: +1 (603) 646-9834                       Fax: +1 (603) 646-1419
WWW:   http://www.linkedin.com/in/yarik        
