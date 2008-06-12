From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 0/2] Respecting core.autocrlf when showing objects
Date: Thu, 12 Jun 2008 13:27:15 -0700 (PDT)
Message-ID: <m3mylqqu05.fsf@localhost.localdomain>
References: <7vprqqdwh7.fsf@gitster.siamese.dyndns.org>
	<cover.1213084587.git.marius@trolltech.com>
	<alpine.DEB.1.00.0806101632570.1783@racer>
	<7vk5gxc4gz.fsf@gitster.siamese.dyndns.org>
	<484F6A27.1040602@trolltech.com>
	<alpine.DEB.1.00.0806112000400.1783@racer>
	<4850E647.7050602@trolltech.com>
	<7vtzfy8n4i.fsf@gitster.siamese.dyndns.org>
	<20080612195553.GK13626@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Marius Storm-Olsen <marius@trolltech.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j.sixt@viscovery.net>, git <git@vger.kernel.org>
To: "J. Bruce Fields" <bfields@fieldses.org>
X-From: git-owner@vger.kernel.org Thu Jun 12 22:28:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6tPF-0002GG-Kb
	for gcvg-git-2@gmane.org; Thu, 12 Jun 2008 22:28:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760575AbYFLU1V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jun 2008 16:27:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760565AbYFLU1U
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jun 2008 16:27:20 -0400
Received: from an-out-0708.google.com ([209.85.132.248]:62378 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760554AbYFLU1T (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jun 2008 16:27:19 -0400
Received: by an-out-0708.google.com with SMTP id d40so903760and.103
        for <git@vger.kernel.org>; Thu, 12 Jun 2008 13:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=R5O0bjNFYcpKtBxKLLmAHj60WC7D6jMwIh9bgvRUSMw=;
        b=HTBqG8kMb3PCjT1dV9NnLcGzCsmr29i/3adjFFDcD9gBbk2xVcD5UNc1SAqBNqC2Bn
         6leKOTmFLOGjwq4M+8MLYjDWxaEwwXW3Fibn4K0FSAq2/SIrBUSnc50oBLUotXaAwnrZ
         rV3tUFkzo+3aEDcC56yqk66Ie9/TneuKXl/Ac=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=lZ7eBYmzYLsanWe6ibEasBNUCn+d7ZV/FoXFzG3VcmzwTmuMutcHhMoQdkQbeNIrcl
         uXXvorzmAN6jBZO4MlaVsYurJ2rDx+gy3YLHabQ8A41W68biC/CbFip6QGCd89leWjAb
         xmW7rLUhxaZuhdaGdiCUR1wrEAu3f3sd/WzqQ=
Received: by 10.101.71.9 with SMTP id y9mr2748065ank.145.1213302437262;
        Thu, 12 Jun 2008 13:27:17 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.221.64])
        by mx.google.com with ESMTPS id c37sm3785823ana.11.2008.06.12.13.27.13
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 12 Jun 2008 13:27:15 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m5CKRAuv002848;
	Thu, 12 Jun 2008 22:27:11 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m5CKR6HP002845;
	Thu, 12 Jun 2008 22:27:06 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <20080612195553.GK13626@fieldses.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84785>

"J. Bruce Fields" <bfields@fieldses.org> writes:

> (Is there any advantage, then, to the :n:filename syntax to a user?
> Is it useful in any cases when they couldn't use HEAD or MERGE_HEAD
> instead?  If not I might be tempted to cut this bit entirely (or
> postpone it till later.)

I'm not sure, but I think that while HEAD and MERGE_HEAD vs :n:
differ in the tree represented (in the index trivial / tree conflicts
are resolved) they have the same file contents for conflicting files.

I think that :n: syntax is just shorter, especially for the ancestor
(c.f. $(git merge-base HEAD MERGE_HEAD)).

And of course there is octopus merge to be considered...
-- 
Jakub Narebski
Poland
ShadeHawk on #git
