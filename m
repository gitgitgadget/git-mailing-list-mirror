From: Jeremy Harris <jgh@wizmail.org>
Subject: utf-8 filename woes
Date: Wed, 22 Apr 2015 20:50:26 +0100
Message-ID: <5537FB82.4000302@wizmail.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 22 22:10:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yl0yi-00028V-Fc
	for gcvg-git-2@plane.gmane.org; Wed, 22 Apr 2015 22:10:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754056AbbDVUK1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Apr 2015 16:10:27 -0400
Received: from wizmail.org ([217.146.107.12]:40776 "EHLO wizmail.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752404AbbDVUKU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Apr 2015 16:10:20 -0400
X-Greylist: delayed 1192 seconds by postgrey-1.27 at vger.kernel.org; Wed, 22 Apr 2015 16:10:20 EDT
Received: from [46.33.133.68] (helo=lap.dom.ain)
	from_AS 51561 by wizmail.org
	with esmtpsa
	(TLSv1.2:DHE-RSA-AES128-SHA:128)
	(Exim 4.85_101-b3558d5)
	id 1Yl0fD-0001t8-I7
	for git@vger.kernel.org
	(return-path <jgh@wizmail.org>); Wed, 22 Apr 2015 19:50:27 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.6.0
X-Pcms-Received-Sender: [46.33.133.68] (helo=lap.dom.ain)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267633>

Hi,

  I have a git version 1.7.1 running on Scientific Linux 6.
When a filename with UTF-8 is present in a tree-ish the
"git archive" command crashes:

------------%%----------------
*** buffer overflow detected ***: git terminated
======= Backtrace: =========
/lib64/libc.so.6(__fortify_fail+0x37)[0x32c1502527]
/lib64/libc.so.6[0x32c1500410]
/lib64/libc.so.6[0x32c14ff869]
/lib64/libc.so.6(_IO_default_xsputn+0xc9)[0x32c1474639]
/lib64/libc.so.6(_IO_vfprintf+0x11d8)[0x32c14451a8]
/lib64/libc.so.6(__vsprintf_chk+0x9d)[0x32c14ff90d]
/lib64/libc.so.6(__sprintf_chk+0x7f)[0x32c14ff84f]
git[0x4620bc]
git[0x4616bc]
git[0x4bd832]
git[0x4bda79]
git[0x4bda79]
git[0x4613e1]
git[0x4623ed]
git[0x4612ed]
git[0x40caf3]
git[0x4041a1]
git[0x404382]
/lib64/libc.so.6(__libc_start_main+0xfd)[0x32c141ed5d]
git[0x403ba9]
======= Memory map: ========
00400000-00510000 r-xp 00000000 fd:00 4121
 /usr/bin/git
------------%%----------------

Installing the git-debuginfo package gave no additional
information.   The symptom does not show on a Fedora 21
system with git 2.1.0 (and I note that gitk properly
shows those filenames on f21, and does not on sl6).

Is this a known and fixed issue, or something my sl6
system needs installing?
-- 
Thanks,
  Jeremy
