From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Document clone of clone loosing branches?
Date: Sat, 14 Jun 2008 07:31:29 -0700 (PDT)
Message-ID: <m31w30qe9x.fsf@localhost.localdomain>
References: <20080614.150548.71104932.hanzl@noel.feld.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Vaclav Hanzl <hanzl@noel.feld.cvut.cz>
X-From: git-owner@vger.kernel.org Sat Jun 14 16:32:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K7WoE-0001NF-09
	for gcvg-git-2@gmane.org; Sat, 14 Jun 2008 16:32:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754894AbYFNOb4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Jun 2008 10:31:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754816AbYFNOb4
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Jun 2008 10:31:56 -0400
Received: from fk-out-0910.google.com ([209.85.128.187]:65335 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754812AbYFNObc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Jun 2008 10:31:32 -0400
Received: by fk-out-0910.google.com with SMTP id 18so2559542fkq.5
        for <git@vger.kernel.org>; Sat, 14 Jun 2008 07:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=2JwQWl0BIrbuXYC+HDspl7IUnEmHZUgqeibjyLGViho=;
        b=RLODnmUvgifOHMHqZPsXk20tbqBEEFY+lOvE5CevZ8SPMJrVN2P+Ko6FmFZIdFlyi7
         pt9ocgv5Zb4NCIzC8CSvQHaYsrR9Ids97KC7Y1S2s26w/JEy42fhLgmJd5e5x2a1OTrG
         CP+FFN9Tqvb4s2daiYkSDXh9v39luD9K2Ahts=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=isJuyZZluNUPeXGH/9ZwUzTtjNuUhNHaSDWC+tp6bRgj20grvbb+W23QyxKlwJI+6n
         qnwoV2B3IMZ67LM0nKu6WNFuMJAOwBMtoebE68u+EyPz2kAQCYIaGzJy2WuycCgJy7hR
         ZSmTpXtxJakQrjL7rv947OyzGrGbrs7W//2b8=
Received: by 10.78.203.20 with SMTP id a20mr1723411hug.21.1213453890186;
        Sat, 14 Jun 2008 07:31:30 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.239.84])
        by mx.google.com with ESMTPS id z28sm2626939hub.7.2008.06.14.07.31.27
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 14 Jun 2008 07:31:29 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m5EEVQnp023895;
	Sat, 14 Jun 2008 16:31:26 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m5EEVN3U023892;
	Sat, 14 Jun 2008 16:31:23 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <20080614.150548.71104932.hanzl@noel.feld.cvut.cz>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85016>

Vaclav Hanzl <hanzl@noel.feld.cvut.cz> writes:

> I wander whether man git-clone is correct when it says "creates
> remote-tracking branches for each branch in the cloned repository".
> 
> IMHO remote-tracking branches in the original repository _are_
> branches and they are _not_ cloned (when using git-clone with no
> options) - maybe this is worth noting very explicitly?
[...]

The idea is for git-clone to clone (by default) _your_ work, not sb
else work.  Think about two repositories, fetching from each other:
you don't want for branches to proliferate like mad, remote of remote,
then remote of remote of remote, and ad infinitum.

Besides there is I think implicit assumption that public repositories
one might want to clone are _bare_ repositories, 1:1 or mirror
refspecs, which simply do not contain remote tracking branches.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
