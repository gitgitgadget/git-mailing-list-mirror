From: Sven Strickroth <sven.strickroth@tu-clausthal.de>
Subject: RFC: reflog for deleted branches
Date: Thu, 03 May 2012 23:25:46 +0200
Message-ID: <4FA2F7DA.6020108@tu-clausthal.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 03 23:25:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SQ3X3-0001it-O2
	for gcvg-git-2@plane.gmane.org; Thu, 03 May 2012 23:25:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754488Ab2ECVZp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 May 2012 17:25:45 -0400
Received: from mailrelay2.rz.tu-clausthal.de ([139.174.2.43]:34790 "EHLO
	mailrelay2.rz.tu-clausthal.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753382Ab2ECVZo (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 3 May 2012 17:25:44 -0400
Received: from poseidon.rz.tu-clausthal.de (poseidon.rz.tu-clausthal.de [139.174.2.21])
	by mailrelay2.rz.tu-clausthal.de (Postfix) with ESMTP id 780BB28BE3D
	for <git@vger.kernel.org>; Thu,  3 May 2012 23:25:42 +0200 (CEST)
Received: from poseidon.rz.tu-clausthal.de (localhost [127.0.0.1])
	by localhost (Postfix) with SMTP id 5D22729ACBB
	for <git@vger.kernel.org>; Thu,  3 May 2012 23:25:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=tu-clausthal.de; h=
	message-id:date:from:mime-version:to:subject:content-type
	:content-transfer-encoding; s=dkim1; bh=b9bTMEb5pcH19RurIbX43rR+
	FTg=; b=z6RWaeMxH9L1IsphLgXjPDG7dyUTd+Esb3Slp8d+LPbGF0dqXYUF6/B7
	LImTEX9kMvDdbY6LDWI338JIurTpwnrjo0To9Na4pEy4pNeqxUt56Y4JRSaeZ6Tf
	hMmfZXKsYad+WTYaQ6s9gLjFgRk4DSILlFEA6XSsk4fUwh3v2MU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=tu-clausthal.de; h=
	message-id:date:from:mime-version:to:subject:content-type
	:content-transfer-encoding; q=dns; s=dkim1; b=1baJ5kFEYFoSW7bZsJ
	XQQkeJREcxUBUlCU55E3naiTyyRCEMFiTi2e34Cw4GA3FKxrxtKHoF5jGpv9n6e6
	jJiB5NvlMC9J0B9DCJcIomSge8HyzbnWobEnEzRHtFPApbSVfUP+E4Vp1egwSDh5
	vKnfPzCEu3roemzT/aaBxuWgo=
Received: from tu-clausthal.de (hathor.rz.tu-clausthal.de [139.174.2.1])
	by poseidon.rz.tu-clausthal.de (Postfix) with ESMTP id 19B5C29ACB7
	for <git@vger.kernel.org>; Thu,  3 May 2012 23:25:42 +0200 (CEST)
Received: from [139.174.242.80] (account sstri@tu-clausthal.de [139.174.242.80] verified)
  by tu-clausthal.de (CommuniGate Pro SMTP 5.4.5)
  with ESMTPSA id 31628121 for git@vger.kernel.org; Thu, 03 May 2012 23:25:42 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
X-Enigmail-Version: 1.4.1
X-Virus-Scanned: by Sophos PureMessage V5.6 at tu-clausthal.de
X-Spam-Level: (8%, '
 HTML_00_01 0.05, HTML_00_10 0.05, BODYTEXTP_SIZE_3000_LESS 0, BODY_SIZE_1000_LESS 0, BODY_SIZE_2000_LESS 0, BODY_SIZE_5000_LESS 0, BODY_SIZE_500_599 0, BODY_SIZE_7000_LESS 0, __ANY_URI 0, __CP_URI_IN_BODY 0, __CT 0, __CTE 0, __CT_TEXT_PLAIN 0, __HAS_MSGID 0, __MIME_TEXT_ONLY 0, __MIME_VERSION 0, __MOZILLA_MSGID 0, __SANE_MSGID 0, __SUBJ_ALPHA_END 0, __TO_MALFORMED_2 0, __TO_NO_NAME 0, __URI_NO_MAILTO 0, __URI_NO_PATH 0, __URI_NS , __USER_AGENT 0')
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196962>

Hi,

an often heart question is how to restore deleted branches. Sometimes
those can be restored by using the reflog of the HEAD.

But why not create a special (ref)log for deleted branches (with SHA1,
date, name of the branch and maybe commit message of the last commit on
the deleted branch)? This way people could just look up the SHA1 of the
deleted branch and can recreate it (even if they moved the HEAD around a
lot).

-- 
Best regards,
 Sven Strickroth
 ClamAV, a GPL anti-virus toolkit   http://www.clamav.net
 PGP key id F5A9D4C4 @ any key-server
