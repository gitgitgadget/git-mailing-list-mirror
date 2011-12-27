From: Sven Strickroth <sven.strickroth@tu-clausthal.de>
Subject: [PATCH 0/5] honour *_ASKPASS for querying user in git-svn
Date: Tue, 27 Dec 2011 17:01:56 +0100
Message-ID: <4EF9EBF4.7070200@tu-clausthal.de>
References: <4EC52508.9070907@tu-clausthal.de> <CABPQNSZ0iPAE+BnDU6Nz8_PkrAtPbjL4RoJuQS=Um2wxPt-2DQ@mail.gmail.com> <4EC65DE4.90005@tu-clausthal.de> <CABPQNSbfM0JRVPk3fxfSEq7QaO-fynHM8FBGpPribdgeRqpZKA@mail.gmail.com> <4ED0CE8B.70205@tu-clausthal.de> <20111130064401.GC5317@sigill.intra.peff.net> <4EF907F1.1030801@tu-clausthal.de> <m3d3baf5kd.fsf@localhost.localdomain> <4EF9D8B9.9060106@tu-clausthal.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>, Jeff King <peff@peff.net>,
	gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 27 17:02:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RfZTX-0006QV-2T
	for gcvg-git-2@lo.gmane.org; Tue, 27 Dec 2011 17:02:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754603Ab1L0QB7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Dec 2011 11:01:59 -0500
Received: from hades.rz.tu-clausthal.de ([139.174.2.20]:54270 "EHLO
	hades.rz.tu-clausthal.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754515Ab1L0QB6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Dec 2011 11:01:58 -0500
Received: from hades.rz.tu-clausthal.de (localhost [127.0.0.1])
	by localhost (Postfix) with SMTP id 4EFF8422105;
	Tue, 27 Dec 2011 17:01:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=tu-clausthal.de; h=
	message-id:date:from:mime-version:to:cc:subject:references
	:in-reply-to:content-type:content-transfer-encoding; s=dkim1;
	 bh=gLzJIS+brPoodYAIm370Z356kEI=; b=wLjByJKPUElqsYz0RZq6RWDEkJ8I
	brmbcFjse/cVCT7r3dCwFRJpvaFf67PGGMx5TOL8+b7cwRRPvwjtaUZ4nIRPt0a4
	niNOsfQ7RHwa8r4fAPU109jlZOc95TyX6UYSFBIS49iWZQx+yDJjMbiB1tW9bJRq
	Ohk9tumdXuLKTE4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=tu-clausthal.de; h=
	message-id:date:from:mime-version:to:cc:subject:references
	:in-reply-to:content-type:content-transfer-encoding; q=dns; s=
	dkim1; b=IMUuWosh7q9X57r8TOdJ1HFfe0ffnlAX6JxXQ2czcjo5PDsjLePdHyR
	sp9JrHg6E3rrChyjIDW+AuZPKrVUguEZoLj+phojUHzrgzKbxvCLLB+qAKjXt/XZ
	WWXemUHPpznUnfsoZF7ki7NRHL6G0CAMf2yTJkXWuH6SzQt0K9Xo=
Received: from tu-clausthal.de (hathor.rz.tu-clausthal.de [139.174.2.1])
	by hades.rz.tu-clausthal.de (Postfix) with ESMTP id 11DB34220F4;
	Tue, 27 Dec 2011 17:01:56 +0100 (CET)
Received: from [91.4.99.60] (account sstri@tu-clausthal.de HELO [192.168.178.20])
  by tu-clausthal.de (CommuniGate Pro SMTP 5.4.3)
  with ESMTPSA id 25242556; Tue, 27 Dec 2011 17:01:56 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:9.0) Gecko/20111222 Thunderbird/9.0.1
In-Reply-To: <4EF9D8B9.9060106@tu-clausthal.de>
X-Enigmail-Version: 1.3.4
X-Virus-Scanned: by Sophos PureMessage V5.6 at tu-clausthal.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187716>

Hi,

git-svn reads usernames (and other stuff) from an interactive terminal.
This behavior cause GUIs to hang waiting for git-svn to complete
(http://code.google.com/p/tortoisegit/issues/detail?id=967).

Again I honoured all your ideas. Hopefully the patches can be applied
now. The new patches follow in the next mails (you can also pull from
git://github.com/csware/git.git askpass-prompt).

The first four patches implement the raw functionality. The last and
fifth patch extends the prompt-method so that it can be used for all
purposes in order to query users.

-- 
Best regards,
 Sven Strickroth
 ClamAV, a GPL anti-virus toolkit   http://www.clamav.net
 PGP key id F5A9D4C4 @ any key-server
