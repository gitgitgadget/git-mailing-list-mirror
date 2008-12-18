From: Francois Marier <francois@debian.org>
Subject: Suggestion: better error reporting when setting HEAD
Date: Thu, 18 Dec 2008 18:58:25 +1300
Message-ID: <20081218055825.GQ6708@isafjordur.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: sam.vilain@catalyst.net.nz
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 18 07:20:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LDCFW-0003rR-2F
	for gcvg-git-2@gmane.org; Thu, 18 Dec 2008 07:20:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752546AbYLRGTZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Dec 2008 01:19:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752551AbYLRGTZ
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Dec 2008 01:19:25 -0500
Received: from godel.catalyst.net.nz ([202.78.240.40]:45591 "EHLO
	mail1.catalyst.net.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751716AbYLRGTY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Dec 2008 01:19:24 -0500
X-Greylist: delayed 1030 seconds by postgrey-1.27 at vger.kernel.org; Thu, 18 Dec 2008 01:19:24 EST
Received: from [2404:130:0:1000:218:f3ff:fe82:f661] (helo=isafjordur)
	by mail1.catalyst.net.nz with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <fmarier@gmail.com>)
	id 1LDBxa-0007LK-73; Thu, 18 Dec 2008 19:02:10 +1300
Received: from francois by isafjordur with local (Exim 4.69)
	(envelope-from <fmarier@gmail.com>)
	id 1LDBtx-0000Py-T4; Thu, 18 Dec 2008 19:02:13 +1300
Received: by isafjordur (hashcash-sendmail, from uid 1000);
	Thu, 18 Dec 2008 18:58:25 +1300
Content-Disposition: inline
X-Request-PGP: http://people.debian.org/~francois/public_key.asc
X-Hashcash: 1:28:081218:git@vger.kernel.org::kCTtbqIXSyC3W4cM:000000000000000000
	00000000000000000000000GKqc3
X-Hashcash: 1:28:081218:sam.vilain@catalyst.net.nz::SaRCIReKPDiTkaK3:00000000000
	00000000000000000000000CEfNE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103436>

(Please CC me on your replies, thanks)

If you take any valid git repo and then do the following:

  git symbolic-ref HEAD master
  (instead of "git symbolic-ref HEAD refs/heads/master")

then other git commands (e.g. "git log") will return this error message:

  fatal: Not a git repository

I'd like to suggest two "usability" improvements:

1- changing the error message to explain why the directory is no longer
   considered a git repo. Maybe something along the lines of:

     fatal: Invalid reference in .git/HEAD

2- To prevent this error from happening in the first place, git-symbolic-ref
   could refuse to change HEAD to a non-existent ref.

Cheers,
Francois
