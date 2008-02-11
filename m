From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC/PATCH] Implement git-cp.
Date: Mon, 11 Feb 2008 02:30:06 +0100
Message-ID: <200802110230.06808.jnareb@gmail.com>
References: <38b2ab8a0802031023y2ed7a5aax6d3c404b08757a4d@mail.gmail.com> <alpine.LSU.1.00.0802100125510.11591@racer.site> <7vzlu9uu7c.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Miklos Vajna <vmiklos@frugalware.org>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Francis Moreau <francis.moro@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 11 02:31:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JONVk-0001Vu-AF
	for gcvg-git-2@gmane.org; Mon, 11 Feb 2008 02:31:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750897AbYBKBaU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Feb 2008 20:30:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750874AbYBKBaU
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Feb 2008 20:30:20 -0500
Received: from ug-out-1314.google.com ([66.249.92.173]:11576 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750851AbYBKBaS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Feb 2008 20:30:18 -0500
Received: by ug-out-1314.google.com with SMTP id z38so209307ugc.16
        for <git@vger.kernel.org>; Sun, 10 Feb 2008 17:30:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=XOdQoY3ZN5OjkYseTgVcMt1LAg/dizhIpoD5dK+lit8=;
        b=AVVQk9gZMOK6CP7XIvFmq+SmJvf5sTh6ecOyzLai89vdQr3eO/d6q7F7FIYFAZN0ZwwQNfYGi4wEBxku2cRRE7AHaIa1OFHKfGwL2dwMUA1/SxVF5oXFBGFZkaJtzXwAPJdAjfhVYlesGbFkYjs9h2oaxoPJLDsHnjn2g7oQ8PY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=KdqCorE7V2f9WXPW8lHD/Izp7t/a+Dq7Y3nqVR84rOeOlyD/zajABtc1jhrcaYAqvQf58Bgug2dUlwwp0uam+XQdsx2/ngnBHNGA0ZkW0vIy7d6APqX40i9Ya89PWjDYKbbn+03Xq8JM/iq89WQGPvnZx0kg9SYAJib0gzfr2yA=
Received: by 10.66.251.3 with SMTP id y3mr8427472ugh.88.1202693417080;
        Sun, 10 Feb 2008 17:30:17 -0800 (PST)
Received: from ?192.168.1.11? ( [83.8.220.19])
        by mx.google.com with ESMTPS id y6sm1673707uge.36.2008.02.10.17.30.14
        (version=SSLv3 cipher=OTHER);
        Sun, 10 Feb 2008 17:30:16 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <7vzlu9uu7c.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73449>

Junio C Hamano wrote:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > If you touch builtin-mv.c already, why not just move cmd_cp() in there?  
> > It's not like it would be the first cmd_*() function living in the same 
> > file as other cmd_*() functions.
> 
> Why do we even want "git-cp", especially when git-mv and git-rm
> are already pretty much redundant commands?

git-rm is not redundant: without it how we could easily un-add
a file (without resorting to porcelain or tricks). I think it
is also safer that ordinary rm (check for being up-to-date, i.e.
for modified files).

The above also reflects git-mv, as half of it is git-rm (although
without some issues). Also git-mv could skip over non git-controlled
files.

> Especially, why do we even encourage copy-and-paste?

But git-cp would be IMHO a convenience only. The half of pros for
git-mv applies to this too; unfortunately the second part of pros
for git-mv does not apply for git-cp.

Would git-cp encourage copy'n'paste programming? I'm not sure...

-- 
Jakub Narebski
Poland
