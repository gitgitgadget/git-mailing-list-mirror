From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Git on Windows, CRLF issues
Date: Mon, 21 Apr 2008 14:51:37 -0700 (PDT)
Message-ID: <m3bq42ri56.fsf@localhost.localdomain>
References: <alpine.DEB.1.00.0804212145570.21181@perkele.intern.softwolves.pp.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Peter Karlsson <peter@softwolves.pp.se>
X-From: git-owner@vger.kernel.org Mon Apr 21 23:52:45 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jo3wA-0001xe-Iy
	for gcvg-git-2@gmane.org; Mon, 21 Apr 2008 23:52:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758892AbYDUVvl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Apr 2008 17:51:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758840AbYDUVvl
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Apr 2008 17:51:41 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:11716 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758645AbYDUVvk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Apr 2008 17:51:40 -0400
Received: by ug-out-1314.google.com with SMTP id z38so819309ugc.16
        for <git@vger.kernel.org>; Mon, 21 Apr 2008 14:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        bh=DY+zveW5L+NuO8weeg7pa+UFP/qIQDfDad+yxDNR1g4=;
        b=f91oxu//A+IugYzz/SolzLbW+ccjRi0S2AaCfE66RkW7THGZ9qsfsyjOmj0Q830HCYNQWlq6a4f9HAU5bvOgeJ6OmEslGo9TDgIzwRiVnoZi7w+r+oW5xwr+g1WEpbpDrD89Ic9BJBb+yxdwxCjMPx8BzSn8sqykdQWqN9wEa/U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        b=EDxKpQBPKqDtiSQpR2UD5e2khCmcMs3pykFtbHmJzck3kKAnlTuXTPtRVOcaUrThXbyFnrdPqa64UBUqkHLuo5hlUVI6VtVD4MadfEpiCvTKvxpu06l8c92oyC0Krb2T3t8zK9WJP407toemTjIq+rvjHdNY78DNMHufPDPHgh8=
Received: by 10.66.221.18 with SMTP id t18mr5876232ugg.80.1208814698553;
        Mon, 21 Apr 2008 14:51:38 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.231.29])
        by mx.google.com with ESMTPS id m38sm2426156ugd.44.2008.04.21.14.51.36
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 21 Apr 2008 14:51:37 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m3LLpYcX031416;
	Mon, 21 Apr 2008 23:51:35 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m3LLpXpC031413;
	Mon, 21 Apr 2008 23:51:33 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <alpine.DEB.1.00.0804212145570.21181@perkele.intern.softwolves.pp.se>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80040>

Peter Karlsson <peter@softwolves.pp.se> writes:

> I have began moving old repositories for Windows-based software to
> Git. Since the tool I am moving from stores everything with CRLF line
> endings and have RCS-like keyword expansion, I'm treating it all as
> binary data when exporting to Git, i.e I have CRLF in the checked-in
> data (and I do want that, since this is Windows-only sources).
> 
> Now the latests msysgit comes along and (finally!) sets core.autocrlf
> to true by default.
> 
> How do I handle this without having everyone breaking check-ins? I
> can't require everyone to do unset core.autocrlf globally. Can I do
> that with gitattributes?

I think you can, by unsetting `crlf` attribute, i.e. putting the
following in .gitattributes:

   * -crlf

See gitattributes(5):

  `crlf`
  ^^^^^^

  This attribute controls the line-ending convention.

  [...]

  Unset::

        Unsetting the `crlf` attribute on a path is meant to
        mark the path as a "binary" file.  The path never goes
        through line endings conversion upon checkin/checkout.

Not tested!
-- 
Jakub Narebski
Poland
ShadeHawk on #git
