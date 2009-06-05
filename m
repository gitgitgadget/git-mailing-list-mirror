From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] daemon: Skip unknown "extra arg" information
Date: Fri, 05 Jun 2009 01:41:09 -0700 (PDT)
Message-ID: <m3iqjb6pk5.fsf@localhost.localdomain>
References: <20090604220824.GT3355@spearce.org>
	<7vbpp3tsg0.fsf@alter.siamese.dyndns.org>
	<20090605013332.GV3355@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Jun 05 10:41:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MCUzL-0001iu-38
	for gcvg-git-2@gmane.org; Fri, 05 Jun 2009 10:41:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753469AbZFEIlL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Jun 2009 04:41:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752843AbZFEIlK
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Jun 2009 04:41:10 -0400
Received: from fg-out-1718.google.com ([72.14.220.155]:63619 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750788AbZFEIlI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jun 2009 04:41:08 -0400
Received: by fg-out-1718.google.com with SMTP id 16so489379fgg.17
        for <git@vger.kernel.org>; Fri, 05 Jun 2009 01:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=001yZmdbAlmSyeMCIP3bG8rQpixikyiRMRphFMOiYr4=;
        b=LJIetqkg9mpONPUSNIueNn74wExk1Pcg/XkKFj8q1gQDZIdJg7wKNs5r5jAvMExL7B
         wac9Xgqml99zoReuThswhHAgPkVZRa66wYsuiEt5Rl87LOyejirRDjHAcniaVgr4xqVY
         HuylPQpMqzifLDksQ1WdQbvwTn7cFH23InUFQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=WdWv2m8xwxPH8zF06eSq/kqqvBuQQix1KbM0JDxj38m+xE9NrdDE9Rfw3QJwWEEx6Y
         eNb1+jgCk5NYEMCyVV3nUrpdHultJ6xcv9PcbT0DJeIMK/A/vbtrceprf1zzf0YLX1OE
         PmFazP4hOjKX/+X1Rkpu3GVHaA6TsRN4nDM4g=
Received: by 10.86.91.3 with SMTP id o3mr3647504fgb.29.1244191269903;
        Fri, 05 Jun 2009 01:41:09 -0700 (PDT)
Received: from localhost.localdomain (abvg76.neoplus.adsl.tpnet.pl [83.8.204.76])
        by mx.google.com with ESMTPS id e20sm1308466fga.15.2009.06.05.01.41.08
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 05 Jun 2009 01:41:09 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n558f5uq013818;
	Fri, 5 Jun 2009 10:41:06 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n558exk8013814;
	Fri, 5 Jun 2009 10:40:59 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <20090605013332.GV3355@spearce.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120762>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> Since 1.4.4.5 (49ba83fb67 "Add virtualization support to git-daemon")
> git daemon enters an infinite loop and never terminates if a client
> hides any extra arguments in the initial request line which is not
> exactly "\0host=blah\0".

When running

  $ git daemon --export-all --verbose ...

and connecting with dummy client / netcat which adds extra arguments,
it doesn't look as it never terminates; it still accepts new
connections.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
