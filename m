From: Leandro Lucarella <leandro.lucarella@sociomantic.com>
Subject: branch.<name>.pushremote not working with push.default simple or
 upstream
Date: Fri, 7 Jun 2013 14:41:47 +0200
Message-ID: <20130607124146.GF28668@sociomantic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 07 14:41:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UkvzO-0006qd-K9
	for gcvg-git-2@plane.gmane.org; Fri, 07 Jun 2013 14:41:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753082Ab3FGMlu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Jun 2013 08:41:50 -0400
Received: from moutng.kundenserver.de ([212.227.126.187]:51783 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752230Ab3FGMlt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jun 2013 08:41:49 -0400
Received: from labs09.localdomain (pD957613F.dip0.t-ipconnect.de [217.87.97.63])
	by mrelayeu.kundenserver.de (node=mreu4) with ESMTP (Nemesis)
	id 0MfNr4-1V0oBK16Hi-00OElG; Fri, 07 Jun 2013 14:41:48 +0200
Received: from luca by labs09.localdomain with local (Exim 4.76)
	(envelope-from <leandro.lucarella@sociomantic.com>)
	id 1UkvzH-0005iW-Aj; Fri, 07 Jun 2013 14:41:47 +0200
Content-Disposition: inline
X-Paranoid: Just because you're paranoid, don't mean they're not after you.
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Provags-ID: V02:K0:L343sA9VvpRhZ6/oxkrzOloschoGENtGr4HJmLqTDu6
 1v9EfjYWmUj4mBGduqA6PGkYFGd2d052fYcLYRk+kOIDMB6/Pm
 zObniJK2kwEIttStZFp4oKt2cxLwLdbREVlIAbwgYRbkF2yyUi
 xRKEcAkLMF2s/Z6Wx57CchGW7toMFqMmbVYL3lvvXtDOO0ne6L
 YERmZEN0MtDvTOIZ0/drGy+DE7D14+8BUE7Yv/0JWbYce9hOy3
 9o7E4m2g87Co4sj2XcMBq7nU42GZs2RwExayHswPgxksbFpGzC
 3LglOYjcMFrwh/bqpHeXUXoQTwny5I4X9rpHuCUHYNPoPb9/HF
 Z1r9L1BpVjSrlsRAUt6J4T7FY8JpGwumgKKTRq6c39fm3sJSxH
 ypVgujlpkrbQw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226624>

Hi, I tried to use the new Git feature to push by default to a different
remote you normally pull but I had some problems. I asked in the #git
IRC channel and been told it looks like a bug and to report it here.

I have 2 remotes, origin and upstream. origin is my private fork (and I
can push to it) while upstream is read-only for me. I have only one
branch, 'master' (present in all the remotes), originally tracking
origin/master.

I changed branch.master.remote to upstream and set
branch.master.pushremote to origin, but when I do I git push I get an
error:

$ git push --dry-run --verbose
fatal: You are pushing to remote 'origin', which is not the upstream of
your current branch 'master', without telling me what to push
to update which remote branch.

I'm using push.default 'simple' to stay forward compatible with Git 2.0.
In the IRC channel they suggested to try with other push.default
settings and I did. 'matching' and 'current' works, but 'simple' and
'upstream' fail with the error message above.

Thank you.

-- 
Leandro Lucarella
Senior R&D Developer
sociomantic labs GmbH <http://www.sociomantic.com>
