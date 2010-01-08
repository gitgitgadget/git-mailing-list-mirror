From: Jon Schewe <jpschewe@mtu.net>
Subject: Possible bug in git-completion.sh
Date: Fri, 08 Jan 2010 09:17:07 -0600
Message-ID: <4B474C73.8080100@mtu.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Fri Jan 08 16:28:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NTGl1-00081k-Cx
	for gcvg-git-2@lo.gmane.org; Fri, 08 Jan 2010 16:28:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753170Ab0AHP17 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Jan 2010 10:27:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752552Ab0AHP17
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jan 2010 10:27:59 -0500
Received: from mtu.net ([204.11.35.17]:37417 "EHLO mtu.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752091Ab0AHP16 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jan 2010 10:27:58 -0500
X-Greylist: delayed 642 seconds by postgrey-1.27 at vger.kernel.org; Fri, 08 Jan 2010 10:27:58 EST
Received: from localhost (localhost [127.0.0.1])
	by mtu.net (Postfix) with ESMTP id D5A97F02B8;
	Fri,  8 Jan 2010 10:17:13 -0500 (EST)
X-Virus-Scanned: Debian amavisd-new at mtu.net
Received: from mtu.net ([127.0.0.1])
	by localhost (mtu.net [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id y8ar8Hu-ApXd; Fri,  8 Jan 2010 10:17:08 -0500 (EST)
Received: from min-dhcp33-251-159.bbn.com (75-149-146-105-Minnesota.hfc.comcastbusiness.net [75.149.146.105])
	by mtu.net (Postfix) with ESMTPSA id B0313F01C1;
	Fri,  8 Jan 2010 10:17:08 -0500 (EST)
User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.6; en-US; rv:1.9.1.5) Gecko/20091204 Thunderbird/3.0
X-Enigmail-Version: 1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136443>

If I create a directory "build" at the top of my git repository and then
add it to .gitignore, git behaves as expected and ignores the build
directory when checking status. Now git-completion.sh has some issues. I
have GIT_PS1_SHOWUNTRACKEDFILES to "1", so that I will be notified when
there are untracked files in my working directory. When I'm in the
top-level directory my prompt looks like expected, no '%'. However if I
change to the build directory I get a '%', even though git status shows
no untracked files. I see that git-completion.sh is using git ls-files
to check this and that function does indeed show output when in my build
directory. So the question here: Is git-completion.sh using ls-files
improperly or is ls-files behaving improperly?

-- 
Jon Schewe | http://mtu.net/~jpschewe
If you see an attachment named signature.asc, this is my digital
signature. See http://www.gnupg.org for more information.

For I am convinced that neither death nor life, neither angels nor
demons, neither the present nor the future, nor any powers,
neither height nor depth, nor anything else in all creation, will
be able to separate us from the love of God that is in Christ
Jesus our Lord. - Romans 8:38-39
