From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 00/23] http*: refactor (v6)
Date: Sat, 06 Jun 2009 11:23:17 -0700 (PDT)
Message-ID: <m3tz2t43xr.fsf@localhost.localdomain>
References: <20090606164253.65a945ba.rctay89@gmail.com>
	<7v8wk5dyrw.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tay Ray Chuan <rctay89@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Mike Hommey <mh@glandium.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 06 20:24:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MD0Yl-0008B6-Li
	for gcvg-git-2@gmane.org; Sat, 06 Jun 2009 20:24:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751276AbZFFSXT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Jun 2009 14:23:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751131AbZFFSXS
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Jun 2009 14:23:18 -0400
Received: from mail-fx0-f213.google.com ([209.85.220.213]:38047 "EHLO
	mail-fx0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751052AbZFFSXR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Jun 2009 14:23:17 -0400
Received: by fxm9 with SMTP id 9so1257302fxm.37
        for <git@vger.kernel.org>; Sat, 06 Jun 2009 11:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=QidtC+x22iglTgT1jNuP0IRzMF+mKz2OgQfrVoJQmeE=;
        b=c6zts5R8MTOZW8ByCOFQ0yqDO/UqrkK+sjPKLEDjfZA0RT5a8jxaygygVD3jYLaUTr
         0wCd5YE5egfzU308qkTqewxsgS0uo6YSO47qHd1o8QrZJ9tCHt3UwfLLgS9K1+HnVkCz
         lyMJw8mELDbtes+GjtYJVZjKEp/LeAFeVLJDA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=mHe+afOvXvCiS6aEfnsx/JFD4xtUNy4wyQdPSA/g4ht+7nzWu2NoLILccTdxLlHvcP
         ROrwQk7HFkg8qRH331ozoe/JvYuR6LRo7JofoW8MKA5LuGu2bhOkdsguJCW7pqjrLRf3
         pxoYfrBFkHNX00jPMDu9v4sBFmWozYpYjy1/A=
Received: by 10.86.98.10 with SMTP id v10mr5266531fgb.36.1244312598409;
        Sat, 06 Jun 2009 11:23:18 -0700 (PDT)
Received: from localhost.localdomain (abwg130.neoplus.adsl.tpnet.pl [83.8.230.130])
        by mx.google.com with ESMTPS id 4sm822139fge.23.2009.06.06.11.23.17
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 06 Jun 2009 11:23:17 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n56INGfp006123;
	Sat, 6 Jun 2009 20:23:16 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n56INDab006120;
	Sat, 6 Jun 2009 20:23:13 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <7v8wk5dyrw.fsf@alter.siamese.dyndns.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120930>

Junio C Hamano <gitster@pobox.com> writes:

> Tay Ray Chuan <rctay89@gmail.com> writes:

[...]
> By the way, this is not your fault at all, but for a patch series
> description, "shortlog" is a sucky way, as we can see below.  When you
> talk about "patch #15", the reader cannot find which one you are talking
> about but has to go back to the MUA, so the list is useless for that
> purpose.
> 
> The output of "shortlog" in an e-mail message is wonderful when you are a
> subsystem maintainer who bundles many people's work and are sending out a
> pull request (i.e.  you are transferring the whole graph in "take it or
> reject all" fashion, and you can refer to an individual changeset with its
> commit object name).
> 
> But I think a cover letter to a patch series should serve as an easy index
> from patch number to the title in some way, and "shortlog" is not suitable
> for that eapecially for a multi-author series.

Before git-send-email learned --cover option, I have used the
following commands to generate "Table of contents" for a patch series:
 * generate patches to some subdirectory using '-o' option 
   of git-format-patch
 * grep for subject and remove "Subject:" line:
   $ grep -h "Subject:" mdir/* | sed -e 's/Subject://' >> mdir/0000-cover.txt

This way I had list of patches in the series in actual order...

P.S. Tay Ray Chuan, this patch series is again not being replies to
     cover letter...
-- 
Jakub Narebski
Poland
ShadeHawk on #git
