From: Matthias Fechner <idefix@fechner.net>
Subject: Re: Switch from svn to git and modify repo completely
Date: Sun, 20 Nov 2011 23:21:06 +0100
Message-ID: <4EC97D52.1010308@fechner.net>
References: <4EC7E32A.9040903@fechner.net> <20111119225048.384189bc@zappedws>
Reply-To: Git@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 20 23:28:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RSFsT-0000bw-SW
	for gcvg-git-2@lo.gmane.org; Sun, 20 Nov 2011 23:28:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754121Ab1KTWVR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Nov 2011 17:21:17 -0500
Received: from anny.lostinspace.de ([80.190.182.2]:49015 "EHLO
	anny.lostinspace.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753588Ab1KTWVQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Nov 2011 17:21:16 -0500
Received: from server.idefix.lan (ppp-93-104-88-159.dynamic.mnet-online.de [93.104.88.159])
	(authenticated bits=0)
	by anny.lostinspace.de (8.14.5/8.14.5) with ESMTP id pAKML9A1007758
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Sun, 20 Nov 2011 23:21:13 +0100 (CET)
	(envelope-from idefix@fechner.net)
Received: from server.idefix.lan (localhost [IPv6:::1])
	by server.idefix.lan (Postfix) with ESMTP id 01F7B6BBD4
	for <git@vger.kernel.org>; Sun, 20 Nov 2011 23:22:10 +0100 (CET)
X-Virus-Scanned: amavisd-new at fechner.net
Received: from server.idefix.lan ([127.0.0.1])
	by server.idefix.lan (server.idefix.lan [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id XwBc2Crafx6x for <git@vger.kernel.org>;
	Sun, 20 Nov 2011 23:22:09 +0100 (CET)
Received: from [IPv6:2001:a60:f035:1:b5bf:a398:a55c:89dc] (unknown [IPv6:2001:a60:f035:1:b5bf:a398:a55c:89dc])
	(using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
	(No client certificate requested)
	by server.idefix.lan (Postfix) with ESMTPSA id 4ABFB6BBC8
	for <git@vger.kernel.org>; Sun, 20 Nov 2011 23:22:09 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:8.0) Gecko/20111105 Thunderbird/8.0
In-Reply-To: <20111119225048.384189bc@zappedws>
X-Enigmail-Version: 1.3.3
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.2.7 (anny.lostinspace.de [80.190.182.2]); Sun, 20 Nov 2011 23:21:13 +0100 (CET)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,UNPARSEABLE_RELAY
	autolearn=ham version=3.3.2
X-Spam-Checker-Version: SpamAssassin 3.3.2 (2011-06-06) on anny.lostinspace.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185727>

Am 19.11.2011 19:50, schrieb Alexey Shumkin:
> take a look at "git filter-branch"

thanks a lot for your answer. I checked the manual page, but it does not
work like I expected it or it is described. What I did:

1. I searched the path name with the command:
git show --pretty="format:" --name-only firstrev..endrev | sort | uniq
|grep sdcc

2. I tried to remove the file with the command:
git filter-branch -f --tree-filter 'rm -f
software/tools/net.sourceforge.eclipsesdcc-1.0.0-win32.x86.zip'
--prune-empty -- --all

git told me:
Ref 'refs/heads/master' was rewritten
Ref 'refs/remotes/origin/master' was rewritten
WARNING: Ref 'refs/remotes/origin/master' is unchanged

3. I cloned the repository with:
git clone --no-hardlinks repo-orig.git repo-filtered.git

4. After this I verified in the repo-filtered.git that the file was
really completely removed, but it was not the case. I was able to
checkout the revision which holds the file.

Regarding the manual page it should work... but reality is different.
Has here anyone an idea what I did wrong?

Bye
Matthias

-- 

"Programming today is a race between software engineers striving to
build bigger and better idiot-proof programs, and the universe trying to
produce bigger and better idiots. So far, the universe is winning." --
Rich Cook
