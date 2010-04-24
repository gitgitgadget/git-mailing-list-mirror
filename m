From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 0/5] gitweb: Miscellaneous improvements,
	in preparation for caching support
Date: Sat, 24 Apr 2010 15:46:25 +0200
Message-ID: <20100424132255.30511.98829.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 24 15:47:14 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O5fhQ-0004Xn-Q6
	for gcvg-git-2@lo.gmane.org; Sat, 24 Apr 2010 15:47:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751586Ab0DXNqy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Apr 2010 09:46:54 -0400
Received: from mail-bw0-f219.google.com ([209.85.218.219]:34435 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751406Ab0DXNqx (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Apr 2010 09:46:53 -0400
Received: by bwz19 with SMTP id 19so254672bwz.21
        for <git@vger.kernel.org>; Sat, 24 Apr 2010 06:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:subject:to:cc
         :date:message-id:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=G1WmlGKX2B9xM/7VzA/gKJdEyrhzxfP3YEIKxfx7oKU=;
        b=NevpLRIBDmqrv0OKuAa8tzxfNfrojq4TNBxHoJofneoum3LI5GSgEmMmohJ9Yuq/IZ
         EnDKugNbTaRDXCfjOx/LgsRnn1+WJojtN84tDzdluk3l+tvkq+2F6VPA4IT8c4lAx50f
         9J4eVtv1BiG4/C4V91yqR3CZaAmZUjBSNPVA4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:subject:to:cc:date:message-id:user-agent:mime-version
         :content-type:content-transfer-encoding;
        b=N6NfxmiVccpRWESU/oP7nQsjx+jPHncQYEq1SEtxF/HNsCmdmDfystG9WOUzs4RbR4
         A9DTpHB86aOZ3u360fvOITrCW3qAnm4m0BolFruREBwAI/3um33gLWh/zgxCIMqXTWEk
         L/dvn/sieExkPSYjHUE9zzDpOGMv4ChFKEclw=
Received: by 10.103.81.38 with SMTP id i38mr757698mul.112.1272116812231;
        Sat, 24 Apr 2010 06:46:52 -0700 (PDT)
Received: from localhost.localdomain (abvk50.neoplus.adsl.tpnet.pl [83.8.208.50])
        by mx.google.com with ESMTPS id j2sm8545946mue.23.2010.04.24.06.46.51
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 24 Apr 2010 06:46:51 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o3ODkP6M030820;
	Sat, 24 Apr 2010 15:46:35 +0200
User-Agent: StGIT/0.14.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145675>

Those are miscellaneous improvements to gitweb, that were part of
series that adds output caching support to gitweb.  Nevertheless they
make sense even outside gitweb caching.

>From those "gitweb: Use nonlocal jump instead of 'exit' in die_error"
would be useful to add FastCGI (CGI::Fast or FCGI) support to gitweb.

"gitweb: Move generating page title to separate subroutine" is pure
refactoring currently, but it improves code quality by reducing indent
level (nesting) in git_header_html.

The patches are independent, beside "gitweb: Add custom error handler
using die_error" depending on changes introduced in "gitweb: Use
nonlocal jump instead of 'exit' in die_error".

---
Jakub Narebski (5):
      gitweb: Move generating page title to separate subroutine
      gitweb: Add custom error handler using die_error
      gitweb: Use nonlocal jump instead of 'exit' in die_error
      gitweb: href(..., -path_info => 0|1)
      Export more test-related variables when running external tests

 gitweb/gitweb.perl |   69 ++++++++++++++++++++++++++++++++++++++--------------
 t/test-lib.sh      |    3 ++
 2 files changed, 53 insertions(+), 19 deletions(-)
 mode change 100644 => 100755 t/test-lib.sh

-- 
Jakub Narebski
ShadeHawk on #git
Poland
