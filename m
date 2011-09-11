From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: How do I investigate apparently random git clone reports of "error: File ... has bad hash"?
Date: Sun, 11 Sep 2011 21:59:15 +0200
Message-ID: <m2r53metpo.fsf@igel.home>
References: <loom.20110911T210035-693@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Thorkil Naur <naur@post11.tele.dk>
X-From: git-owner@vger.kernel.org Sun Sep 11 22:04:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R2qGA-0002em-QI
	for gcvg-git-2@lo.gmane.org; Sun, 11 Sep 2011 22:04:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752525Ab1IKT7T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Sep 2011 15:59:19 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:40010 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751670Ab1IKT7T (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Sep 2011 15:59:19 -0400
Received: from frontend1.mail.m-online.net (frontend1.mail.intern.m-online.net [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 11180188B5BE;
	Sun, 11 Sep 2011 21:59:16 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.8.164])
	by mail.m-online.net (Postfix) with ESMTP id 3C56E1C001B3;
	Sun, 11 Sep 2011 21:59:17 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.180])
	by localhost (dynscan1.mail.m-online.net [192.168.8.164]) (amavisd-new, port 10024)
	with ESMTP id dXRAQdGeFRBO; Sun, 11 Sep 2011 21:59:16 +0200 (CEST)
Received: from igel.home (ppp-88-217-122-177.dynamic.mnet-online.de [88.217.122.177])
	by mail.mnet-online.de (Postfix) with ESMTP;
	Sun, 11 Sep 2011 21:59:16 +0200 (CEST)
Received: by igel.home (Postfix, from userid 501)
	id 12AD9CA296; Sun, 11 Sep 2011 21:59:15 +0200 (CEST)
X-Yow: Hey, I LIKE that POINT!!
In-Reply-To: <loom.20110911T210035-693@post.gmane.org> (Thorkil Naur's message
	of "Sun, 11 Sep 2011 19:03:03 +0000 (UTC)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181190>

Thorkil Naur <naur@post11.tele.dk> writes:

>> $ git clone http://darcs.haskell.org/ghc.git/ build8
>> Cloning into build8...
>> error: File 42988feeeb76f5cb92b541e9dac277e073bcb3ef has bad hash
>> error: Unable to find 42988feeeb76f5cb92b541e9dac277e073bcb3ef under
> http://darcs.haskell.org/ghc.git
>> Cannot obtain needed blob 42988feeeb76f5cb92b541e9dac277e073bcb3ef
>> while processing commit ffb2e81c03a01e74825b3a0223e214df59241fab.
>> error: Fetch failed.

I just tried to clone it and got this error:

$ git clone http://darcs.haskell.org/ghc.git
Cloning into ghc...
error: Recv failure: Connection reset by peer (curl_result = 56, http_code = 0, sha1 = be6810bb027643bf0697b3d237426110f064aba1)
error: Unable to find be6810bb027643bf0697b3d237426110f064aba1 under http://darcs.haskell.org/ghc.git
Cannot obtain needed commit be6810bb027643bf0697b3d237426110f064aba1
while processing commit 6942b112082fbcdff5c66f06f56fdd336861da47.
error: Fetch failed.

It looks like this is just a network problem.

Btw, the repo is rather strange.  It's not a bare repo, but does not
contain a .git directory.  Instead the files that are normally under
.git are placed directly in the working tree.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
