From: Matthias Fechner <idefix@fechner.net>
Subject: Re: Cannot push a commit
Date: Wed, 18 Jan 2012 19:25:02 +0100
Message-ID: <4F170E7E.9000804@fechner.net>
References: <4F1297E0.1060703@fechner.net> <20120116212036.GA21132@sigill.intra.peff.net> <4F1524DB.2080009@fechner.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jan 18 19:25:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RnaCK-0005XS-Sl
	for gcvg-git-2@lo.gmane.org; Wed, 18 Jan 2012 19:25:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756055Ab2ARSZT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jan 2012 13:25:19 -0500
Received: from anny.lostinspace.de ([80.190.182.2]:57440 "EHLO
	anny.lostinspace.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755729Ab2ARSZS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jan 2012 13:25:18 -0500
Received: from server.idefix.lan (ppp-93-104-66-149.dynamic.mnet-online.de [93.104.66.149])
	(authenticated bits=0)
	by anny.lostinspace.de (8.14.5/8.14.5) with ESMTP id q0IIP6Tb011714
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256 verify=NO);
	Wed, 18 Jan 2012 19:25:10 +0100 (CET)
	(envelope-from idefix@fechner.net)
Received: from server.idefix.lan (localhost [IPv6:::1])
	by server.idefix.lan (Postfix) with ESMTP id D291F3C77;
	Wed, 18 Jan 2012 19:25:05 +0100 (CET)
X-Virus-Scanned: amavisd-new at fechner.net
Received: from server.idefix.lan ([127.0.0.1])
	by server.idefix.lan (server.idefix.lan [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id wBNc3_54bvAp; Wed, 18 Jan 2012 19:25:05 +0100 (CET)
Received: from [IPv6:2001:a60:f035:1:8847:3986:4ab1:bb77] (unknown [IPv6:2001:a60:f035:1:8847:3986:4ab1:bb77])
	(using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
	(No client certificate requested)
	by server.idefix.lan (Postfix) with ESMTPSA id 096CF3C70;
	Wed, 18 Jan 2012 19:25:05 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:9.0) Gecko/20111222 Thunderbird/9.0.1
In-Reply-To: <4F1524DB.2080009@fechner.net>
X-Enigmail-Version: 1.3.4
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.2.7 (anny.lostinspace.de [80.190.182.2]); Wed, 18 Jan 2012 19:25:11 +0100 (CET)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,UNPARSEABLE_RELAY
	autolearn=ham version=3.3.2
X-Spam-Checker-Version: SpamAssassin 3.3.2 (2011-06-06) on anny.lostinspace.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188753>

Am 17.01.2012 08:35, schrieb Matthias Fechner:
> So the problem has something to do with windows as client. I will do
> some additional test this evening.
> 
> Where can we continue to search?

the problem seems to be located in the ssh.exe which comes with git.
(location in the standard windows install is:
C:\Program Files (x86)\Git\bin
)

I downloaded plink.exe from the putty project and copied it into a
directory where the PATH variable points to.

Then I opened the git bash and inserted:
export GIT_SSH=plink.exe
git push
Counting objects: 4, done.
Delta compression using up to 4 threads.
Compressing objects: 100% (3/3), done.
Writing objects: 100% (3/3), 91.63 KiB | 123 KiB/s, done.
Total 3 (delta 0), reused 0 (delta 0)
To idefix@fechner.net:git-test
   8020989..6ea6180  master -> master

The currently installed version is OpenSSH_4.6p1, OpenSSL 0.9.8e 23 Feb
2007.
Maybe an updated openssh version in the git bin folder will solve the
problem?


Bye
Matthias

-- 

"Programming today is a race between software engineers striving to
build bigger and better idiot-proof programs, and the universe trying to
produce bigger and better idiots. So far, the universe is winning." --
Rich Cook
