From: John Tapsell <johnflux@gmail.com>
Subject: Re: git merge --abort
Date: Mon, 23 Feb 2009 12:41:03 +0000
Message-ID: <43d8ce650902230441n51c9e5a8h722682cda778aa7a@mail.gmail.com>
References: <43d8ce650902190205yc2274c5gb8e658c8608267ff@mail.gmail.com>
	 <m3ocwwrxtg.fsf@localhost.localdomain>
	 <7v3ae8rvvd.fsf@gitster.siamese.dyndns.org>
	 <200902211118.32185.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Bryan Donlan <bdonlan@gmail.com>,
	Jay Soffian <jaysoffian@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Nanako Shiraishi <nanako3@lavabit.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 23 13:42:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lba8q-0005yX-7S
	for gcvg-git-2@gmane.org; Mon, 23 Feb 2009 13:42:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753917AbZBWMlI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Feb 2009 07:41:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753725AbZBWMlG
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Feb 2009 07:41:06 -0500
Received: from mail-gx0-f174.google.com ([209.85.217.174]:56365 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753542AbZBWMlE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Feb 2009 07:41:04 -0500
Received: by gxk22 with SMTP id 22so5013252gxk.13
        for <git@vger.kernel.org>; Mon, 23 Feb 2009 04:41:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=90+rjB8J1QSNeMTSlBi0kW/pUwiDwt/86MTfwSmpGZE=;
        b=vsOrc9Dj22yvX4kIK8aYgWg8UMm0/noztnYXddeU1RUYkdmHPMZgaHucurx9djgcg4
         eNrAI3RX3mbZdc9aG8Y2FvfSZM1rWEjJsyNK3G/ARX4nz70jGD1hCx8AVhhirk8dDTBN
         LunsRSv9n6cSuhRd46cXf0qWMFCZTb+n7XalQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=xL9Anad7WjVJSZK4cdmN8/niqCJsrZSOSNFCgs7ve0W7ACxf5nsWla5dFG+DXqelyQ
         Knbah8f0XN9Dt6GMlmiJsbmWCefbCoVxew86SZq+ra+CBkMpECNepDmByMC/7p0Pk7hb
         QX+dnD/zdbHdGVjqf2PQK7G3txbVJLnIWXLRw=
Received: by 10.150.146.14 with SMTP id t14mr1739232ybd.106.1235392863550; 
	Mon, 23 Feb 2009 04:41:03 -0800 (PST)
In-Reply-To: <200902211118.32185.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111133>

2009/2/21 Jakub Narebski <jnareb@gmail.com>:
> On Sat, 21 Feb 2009, Junio C Hamano wrote:
>> Jakub Narebski <jnareb@gmail.com> writes:
>>
>> > Perhaps this is the case fo "feature that waits for a user", namely
>> > 'git stash --no-reset', which would save a state just in case, perhaps
>> > in a separate area and not refs/stash (ORIG_STASH perhaps?).
>>
>> Isn't that Nana's "git stash --keep" patch posted a few weeks ago sitting
>> in "pu"?
>
> Almost exactly.
>
> When using it as a safety measure (perhaps enabled via configuration
> variable, similarly to core.safecrlf or diff.autoRefreshIndex) we would
> probably want to not save it in 'refs/stash' stack, but in single-use
> ORIG_STATE (similar to HEAD reflog vs. ORIG_HEAD). And of course have
> "git merge --abort" (or even "git pull --abort") as a porcelain.

It sounds like we have some sort of plan then.  Will Nana's patch be
committed into mainline git?  Then we can add the --abort porcelain
