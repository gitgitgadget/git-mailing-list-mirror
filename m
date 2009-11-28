From: Thomas Singer <thomas.singer@syntevo.com>
Subject: non-US-ASCII file names (e.g. Hiragana) on Windows
Date: Sat, 28 Nov 2009 19:15:48 +0100
Message-ID: <4B1168D4.5010902@syntevo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 28 19:15:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NERpt-0005zG-Mr
	for gcvg-git-2@lo.gmane.org; Sat, 28 Nov 2009 19:15:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752415AbZK1SPn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Nov 2009 13:15:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752340AbZK1SPm
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Nov 2009 13:15:42 -0500
Received: from syntevo.com ([85.214.39.145]:42400 "EHLO syntevo.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752120AbZK1SPm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Nov 2009 13:15:42 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1]) with ESMTP id E395937C7B4
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
X-Enigmail-Version: 0.96.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133963>

I've created a file with unicode characters in its name (using Java):

 new File(dir, "\u3041\u3042\u3043\u3044").createNewFile();

The file name is stored correctly on disk, because if invoking a

 dir.list()

the name is listed correctly.

When opening this directory in the Windows Explorer (German Windows XP SP3),
it shows 4 boxes - which most likely is a problem of the font not supporting
these characters.

When launching 'git status' from the git shell (msys 1.6.5.1.1367.gcd48 from
7zip-bundle) it only shows me 4 question marks. I would have expected to see
the non-displayable characters escaped like it did with the umlauts on OS X.

Even adding fails:

$ git add .
fatal: unable to stat '????': No such file or directory

What should I do to make Git recognize these characters?

-- 
Thanks in advance,
Tom
