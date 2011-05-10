From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: Separate default remotes for pulling and pushing
Date: Tue, 10 May 2011 08:47:53 -0400
Message-ID: <BANLkTimUn9e=5CfDcvQdgNYY4_pqbi8peQ@mail.gmail.com>
References: <1FDDE878-C81A-4318-836B-7F8BED51A981@gmail.com>
 <BANLkTinJDUa7sXjKHo81bG7KbnspxZ88oA@mail.gmail.com> <20110509081708.GA5871@sigill.intra.peff.net>
 <7viptjq0ua.fsf@alter.siamese.dyndns.org> <20110509220459.GA3719@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	David Lee <davidomundo@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue May 10 14:48:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJmMX-0000OZ-HP
	for gcvg-git-2@lo.gmane.org; Tue, 10 May 2011 14:48:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753617Ab1EJMsY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 May 2011 08:48:24 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:37243 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752930Ab1EJMsX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 May 2011 08:48:23 -0400
Received: by pvg12 with SMTP id 12so2804819pvg.19
        for <git@vger.kernel.org>; Tue, 10 May 2011 05:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=fhFzKewsDtBugYIrU0EDHDCPsWWVnzs/AbNVm+wh6E0=;
        b=vW4bh3/NXbN0Oawva44413Vh9oo7PBYJ6vN6CDYaZK7bAPNi2QMRVAlQ4ZpLqFY/QG
         +//ZvtKP2+7kw/5P/Ry2e23RN8IxohJvBLJpNX5pEDnfTk9N2548WKSZuO2F9SS6+Qox
         Gv0SIRIDHu1fWl4GSxeNnXkOEsMLV7oM6t/eE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=fc+1OwstUbAZ5/iGVGQd05YIdTmT9cgxyJq1Y2hRsMDqdag7CzweIWQhjhwbkGGASH
         3kp+ZbQ1D1vNCq/DYpo3XoK2l++scn5N/6oKPeGtDFZssKrr7vjC1fIEYS9mgIXOJWTg
         0G35gWnJznqlTAwvr5Ez3UfLH6Gi1va5YbrQE=
Received: by 10.142.135.8 with SMTP id i8mr3909757wfd.29.1305031703074; Tue,
 10 May 2011 05:48:23 -0700 (PDT)
Received: by 10.142.211.14 with HTTP; Tue, 10 May 2011 05:47:53 -0700 (PDT)
In-Reply-To: <20110509220459.GA3719@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173331>

On Mon, May 9, 2011 at 6:04 PM, Jeff King <peff@peff.net> wrote:
> I think it is important to note that calling them both "origin" is
> definitely the wrong thing. The proposal is instead that "git push"
> without a remote would default to something besides "origin". For people
> who publish multiple places, it might even make sense for it to be an
> iterative push to each place.

While developing in a particular repo, I constantly have to push to
two compile machines. I just dropped a Makefile into the top of my
working tree:

all: push
amend:
	git amend -a
	git --no-pager diff @{1}
	make push
push:
	make -j 2 mac win
mac:
	git push mac
win:
	git push win

j.
