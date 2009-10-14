From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH/RFC] builtin-checkout: suggest creating local branch when appropriate to do so
Date: Wed, 14 Oct 2009 03:46:01 -0700 (PDT)
Message-ID: <m3k4yyfe1z.fsf@localhost.localdomain>
References: <0016e68fd0123a175304754694b4@google.com>
	<7vljjf226t.fsf@alter.siamese.dyndns.org>
	<200910131051.47117.trast@student.ethz.ch>
	<200910141156.55536.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	<Euguess@gmail.com>, Mikael Magnusson <mikachu@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Jeff King <peff@peff.net>, Jay Soffian <jaysoffian@gmail.com>,
	<git@vger.kernel.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Wed Oct 14 12:50:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1My1Qk-0004AO-D1
	for gcvg-git-2@lo.gmane.org; Wed, 14 Oct 2009 12:50:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932830AbZJNKrv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Oct 2009 06:47:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932817AbZJNKrv
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Oct 2009 06:47:51 -0400
Received: from fg-out-1718.google.com ([72.14.220.155]:1910 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932809AbZJNKru (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Oct 2009 06:47:50 -0400
Received: by fg-out-1718.google.com with SMTP id 16so1306602fgg.1
        for <git@vger.kernel.org>; Wed, 14 Oct 2009 03:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=GHapJCAfh62++EISqT4vZBbKWWYV4rMaI8M53kJXfQQ=;
        b=tXW2qGZK11i2Bp9YKaWGamj/gHPTr713ewIqEeSjIaDAEhoZuIaetnuLAiMQYVyuLD
         /R6Tuvl4xmmJ4PmzmHy+hfk+iFHMa7HN7s55upxI+z+spm9yFlIip0sFw4mX8r+X8H7w
         bWn1C1iCHAaMKhxSK7tMbA51l3G4ZoKyk1dZY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=a4FbMHsqgbc/krORAJaTm5dBnrjuZy+JTWnpwF2p/DDE96JnPnULFJOqP3Q9yEGu0y
         FcrR7rhXeL0LfWwEf2LCzcGGki8lxpFXzedC997m89u03KURZx7IkhrfK7YCbQ4uY810
         RKZzSdGNlGvh7GB1HHAmuAc1XRbvUAxrXWwKE=
Received: by 10.86.174.2 with SMTP id w2mr7529650fge.0.1255517162775;
        Wed, 14 Oct 2009 03:46:02 -0700 (PDT)
Received: from localhost.localdomain (abvu196.neoplus.adsl.tpnet.pl [83.8.218.196])
        by mx.google.com with ESMTPS id 4sm2216147fge.27.2009.10.14.03.46.00
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 14 Oct 2009 03:46:01 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n9EAkvNC015712;
	Wed, 14 Oct 2009 12:46:59 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n9EAkn61015708;
	Wed, 14 Oct 2009 12:46:49 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <200910141156.55536.trast@student.ethz.ch>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130285>

Thomas Rast <trast@student.ethz.ch> writes:

> So I think we're now mixing up two different goals in this thread:
> a) Stopping the users from hurting themselves by inadvertent detaching
> b) Helping the users by DWIMming local branches for them
> 
> I'm all for (a), but (b) is much harder.

Perhaps (b) should be protected by branch.autocreatelocal (similar to
branch.autosetupmerge and branch.autosetuprebase).

Also we should always print a message if we DWIM creating or checking
out local branch equivalent to remote-tracking branch.


Also, why interactive checkout (checkout --interactive?) idea was
abandoned?

-- 
Jakub Narebski
Poland
ShadeHawk on #git
