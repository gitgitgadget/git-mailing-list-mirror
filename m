From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Invalid html output repo.or.cz (alt-git.git)
Date: Sat, 16 Feb 2008 11:52:42 -0800 (PST)
Message-ID: <m3lk5kbry3.fsf@localhost.localdomain>
References: <20080216130037.GA14571@auto.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org
To: mkoegler@auto.tuwien.ac.at (Martin Koegler)
X-From: git-owner@vger.kernel.org Sat Feb 16 20:53:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQT68-00028B-PL
	for gcvg-git-2@gmane.org; Sat, 16 Feb 2008 20:53:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752507AbYBPTwq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Feb 2008 14:52:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753041AbYBPTwq
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Feb 2008 14:52:46 -0500
Received: from fk-out-0910.google.com ([209.85.128.189]:64231 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752383AbYBPTwp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Feb 2008 14:52:45 -0500
Received: by fk-out-0910.google.com with SMTP id z23so1175644fkz.5
        for <git@vger.kernel.org>; Sat, 16 Feb 2008 11:52:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        bh=Atgxz3ukvf0QIltYsi0hFnf22rc8gd9iuEO/TGKSasI=;
        b=hcgWu7S6uAiJJZV6gPEYuF/UJMKZ1uqtUQxEfXMdAp1Xm968tVY6EvUp8FLBCPJQoZSSBFvbiRLhQaS6PYgafGPvfqwCJ6pSZffaoZtLrLop9B+4e/V+41PbB14K3ctp/qB60DOXirkSoO96XsVRpXd2M8xK4f0gsaieaJyRdCg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        b=oOOezTYNfpFR5/lyazd07V/tzi20Nb8GlbhQPpFUcoRwDo1cO2tFuNxE9e7/kVLFXk57LpcUggM70DyFbbfqwTY9Kv9HUJG04xi7f8V5F3QPBxEB/oZP4kn6pB6CveI0EWqLX78VWKhLXGbmascQkt3CC/Rm4Zal5Z+9avGwrlk=
Received: by 10.78.187.17 with SMTP id k17mr6080637huf.38.1203191563632;
        Sat, 16 Feb 2008 11:52:43 -0800 (PST)
Received: from localhost.localdomain ( [83.8.197.33])
        by mx.google.com with ESMTPS id 34sm2471124nfu.31.2008.02.16.11.52.36
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 16 Feb 2008 11:52:42 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m1GJptPg013708;
	Sat, 16 Feb 2008 20:52:06 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m1GJpXAm013704;
	Sat, 16 Feb 2008 20:51:33 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <20080216130037.GA14571@auto.tuwien.ac.at>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74071>

Martin Koegler <mkoegler@auto.tuwien.ac.at> writes:

> http://repo.or.cz/w/alt-git.git?a=shortlog
> 
> fails to load in my Seamonkey browser (Debian stable):
> 
> XML Parsing Error: not well-formed
> Location: http://repo.or.cz/w/alt-git.git?a=shortlog
> Line Number 561, Column 33:<td><i><span title="Uwe Kleine-K<span class="cntrl">\e</span>,Av<span class="cntrl">\e</span>(Bnig">Uwe Kleine ...</span></i></td>
> --------------------------------^

It looks like gitweb uses esc_html instead of esc_param (or leaving it
to CGI module) title attribute of span (?) element in a shortlog.

I'd try to fix this bug.
-- 
Jakub Narebski
Poland
ShadeHawk on #git
