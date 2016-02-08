From: Kazutoshi Satoda <k_satoda@f2.dion.ne.jp>
Subject: [PATCH 0/2] enable "svn.pathnameencoding" on dcommit
Date: Tue, 9 Feb 2016 00:19:06 +0900
Message-ID: <56B8B1EA.5020901@f2.dion.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: normalperson@yhbt.net, alex.crezoff@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 08 16:29:39 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aSnkv-0006Ge-Nf
	for gcvg-git-2@plane.gmane.org; Mon, 08 Feb 2016 16:29:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754786AbcBHP3c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Feb 2016 10:29:32 -0500
Received: from mail-ae2-f141.auone-net.jp ([111.87.219.141]:46793 "EHLO
	dmta02.auone-net.jp" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754495AbcBHP30 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Feb 2016 10:29:26 -0500
Received: from amlmta048.auone-net.jp (amlmta048-MM [10.188.23.63])
	by dmta02.auone-net.jp (au one net mail) with ESMTP id 7393340025C
	for <git@vger.kernel.org>; Tue,  9 Feb 2016 00:23:53 +0900 (JST)
Received: from [0.0.0.0] ([77.247.181.163])
	by amlmta048.auone-net.jp id 56b8b305000f2db900006fcb00007176200007fd3cf8;
	Tue, 09 Feb 2016 00:23:49 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
X-MXM-DELIVERY-TYPE: 3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285776>

These are small fixes to problems I encountered using git-svn with
svn.pathnameencoding configuration (cp932 in my case). The problems
happen only when sending changes on non-ASCII paths.

I'm sorry not coming with test scripts, but I couldn't figure out how to
write tests to reproduce problems happen only with non-UTF-8 paths while
the tests seems to be run on UTF-8 locale.

I just ran existing tests with these fixes and there was no breakage
(with UTF-8 locale).

I think sending these fixes as-is is better than not sending because of
my lack of ability to write such tests. I also expect that these fixes
can be applied as-is because there were some small fixes without tests
in the history of file perl/Git/SVN/Editor.pm.

The first one is an updated fix of an very old but not applied patch.
http://comments.gmane.org/gmane.comp.version-control.git/164166#o2

The second one can be seen as a separate fix, but it takes effect only
after the first one.

Kazutoshi SATODA (2):
  git-svn: enable "svn.pathnameencoding" on dcommit
  git-svn: apply "svn.pathnameencoding" before URL encoding

 perl/Git/SVN/Editor.pm | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

-- 
2.7.0
