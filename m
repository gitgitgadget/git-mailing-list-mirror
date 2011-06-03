From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCHv4 2/4] Add infrastructure for ref namespaces
Date: Fri, 03 Jun 2011 01:35:34 -0700 (PDT)
Message-ID: <m3sjrrwbyp.fsf@localhost.localdomain>
References: <1306887870-3875-1-git-send-email-jamey@minilop.net>
	<1306887870-3875-2-git-send-email-jamey@minilop.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <johannes.sixt@telecom.at>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Josh Triplett <josh@joshtriplett.org>
To: Jamey Sharp <jamey@minilop.net>
X-From: git-owner@vger.kernel.org Fri Jun 03 10:35:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QSPr4-0004oL-UC
	for gcvg-git-2@lo.gmane.org; Fri, 03 Jun 2011 10:35:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753194Ab1FCIfh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jun 2011 04:35:37 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:63990 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752640Ab1FCIfg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jun 2011 04:35:36 -0400
Received: by wwa36 with SMTP id 36so1437411wwa.1
        for <git@vger.kernel.org>; Fri, 03 Jun 2011 01:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:x-authentication-warning:to:cc:subject
         :references:from:date:in-reply-to:message-id:lines:user-agent
         :mime-version:content-type;
        bh=Tnoa961yv7Owq4XrLzLT8GJxRLxy5Oa+A8CKuErMYTU=;
        b=A8OwIw+hYXsNEXH/lqQ/3fOtzEWivLkHtNOSCTCLt6vMtvJ6gH89khAMxDJEG7qoLJ
         rKfso5mTykvjjtIE3mmkPnqvZDVgOCfbOxwZ6C19ue71cWrRGtEt196xPivtmrS/6I4o
         WPl0c3JgPgqCP1Mo5NawcrLcY8lyMTEERyXrM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=rijiyUBxzVrQNy6jVYsg1T2+iuBKkTIw4gJJI3y0ieepWLm7MQXTiejl3moRMbvKTp
         IOCCdx6oSakYBlDg90vnBL+tlwQvh2fRpU0VSmSQhGtRgxx6uI6M2FRScFEay56yG+6K
         yd2NaShRDPqpLzsL0SwUuwlIXd/5q46hpHg5s=
Received: by 10.216.221.200 with SMTP id r50mr1623128wep.102.1307090135138;
        Fri, 03 Jun 2011 01:35:35 -0700 (PDT)
Received: from localhost.localdomain (abwo192.neoplus.adsl.tpnet.pl [83.8.238.192])
        by mx.google.com with ESMTPS id d7sm696296wek.45.2011.06.03.01.35.32
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 03 Jun 2011 01:35:34 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id p538YYd1014402;
	Fri, 3 Jun 2011 10:34:45 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id p538XpJu014383;
	Fri, 3 Jun 2011 10:33:51 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1306887870-3875-2-git-send-email-jamey@minilop.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175003>

Jamey Sharp <jamey@minilop.net> writes:

> From: Josh Triplett <josh@joshtriplett.org>
> 
> Add support for dividing the refs of a single repository into multiple
> namespaces, each of which can have its own branches, tags, and HEAD.
> Git can expose each namespace as an independent repository to pull from
> and push to, while sharing the object store, and exposing all the refs
> to operations such as git-gc.
[...]

By the way, after this feature is merged in, would you like for gitweb
to understand ref namespaces and offer browsing of separate namespaces
(sub-repositories)?

-- 
Jakub Narebski
Poland
ShadeHawk on #git
