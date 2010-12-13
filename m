From: Jakub Narebski <jnareb@gmail.com>
Subject: [RFC PATCH 0/2] gitweb: die_error (error handling) improvements
Date: Mon, 13 Dec 2010 01:46:20 +0100
Message-ID: <20101213004259.9475.87376.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: "J.H." <warthog9@eaglescrag.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 13 01:47:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PRwZK-0006Xo-6n
	for gcvg-git-2@lo.gmane.org; Mon, 13 Dec 2010 01:47:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752497Ab0LMAqw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Dec 2010 19:46:52 -0500
Received: from mail-fx0-f43.google.com ([209.85.161.43]:41409 "EHLO
	mail-fx0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751783Ab0LMAqv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Dec 2010 19:46:51 -0500
Received: by fxm18 with SMTP id 18so5720804fxm.2
        for <git@vger.kernel.org>; Sun, 12 Dec 2010 16:46:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:subject:to:cc
         :date:message-id:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=XLRC02VwRVOyFCEOAc7wrLtCEpaLR6Y98Z5uYsA+PDI=;
        b=apxerabq1GCkxQ2n9sQUKKG8ENxMK8mxt7mcQ4HHc4Vd7fUc9EJBZkoXMedG+0/A2l
         jJ9NigRwyVLS2KZ2e2WtcYaDG3cata12/7AcZEXcyJwCI+vlhoicrWNcKkk/Lj5/WGqM
         bFne5QtuHIhCRdJwUCjhZcrl1blADvOgIksl8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:subject:to:cc:date:message-id:user-agent:mime-version
         :content-type:content-transfer-encoding;
        b=vYkkVZ+NASqPn4XMIPd4EvdHJSQyWEOYUo4WHt5WyE6OvHCox9ca3g4iZGAwJs6Tv7
         O7nWUdUcnYPHp1mMh2kM2YZM5aImZwmvaMPQ2R3CWcxsiPavIptIQaryAYq/oaoJu61g
         b1sdnIEiu+UDoJfHcxVn9Sgz5oE+BH8OXVufo=
Received: by 10.223.97.75 with SMTP id k11mr3662265fan.85.1292201210064;
        Sun, 12 Dec 2010 16:46:50 -0800 (PST)
Received: from localhost.localdomain (abwq106.neoplus.adsl.tpnet.pl [83.8.240.106])
        by mx.google.com with ESMTPS id y1sm1504727fak.39.2010.12.12.16.46.48
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 12 Dec 2010 16:46:48 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id oBD0kLwQ009541;
	Mon, 13 Dec 2010 01:46:33 +0100
User-Agent: StGIT/0.14.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163500>

The following two patch series changes improve error / exception
handling in gitweb, preparing the way for gitweb output caching, but
useful even without it.

I'm sending this patch series early to gather feedback on possible
ways of improving error / exception handling in gitweb.


Shortlog:
~~~~~~~~~
Jakub Narebski (2):
      gitweb: use eval + die for error (exception) handling
      gitweb: Go to DONE_REQUEST rather than DONE_GITWEB in die_error

Diffstat:
~~~~~~~~~
 gitweb/gitweb.perl |   27 +++++++++------------------
 1 files changed, 9 insertions(+), 18 deletions(-)

-- 
Jakub Narebski
ShadeHawk on #git
Poland
