From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH 6/6] Teach core object handling functions about gitlinks
Date: Wed, 11 Apr 2007 10:49:18 +0200
Message-ID: <81b0412b0704110149g50426a5fh149fe8607f9c163a@mail.gmail.com>
References: <Pine.LNX.4.64.0704092100110.6730@woody.linux-foundation.org>
	 <Pine.LNX.4.64.0704092115350.6730@woody.linux-foundation.org>
	 <20070411080641.GF21701@admingilde.org>
	 <81b0412b0704110129q56ee0628jafe8fca808ef9ef8@mail.gmail.com>
	 <20070411083642.GH21701@admingilde.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Linus Torvalds" <torvalds@linux-foundation.org>,
	"Git Mailing List" <git@vger.kernel.org>,
	"Junio C Hamano" <junkio@cox.net>
To: "Martin Waitz" <tali@admingilde.org>
X-From: git-owner@vger.kernel.org Wed Apr 11 15:14:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HbYW3-00078b-F9
	for gcvg-git@gmane.org; Wed, 11 Apr 2007 10:49:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751276AbXDKItU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Apr 2007 04:49:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751399AbXDKItU
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Apr 2007 04:49:20 -0400
Received: from an-out-0708.google.com ([209.85.132.244]:40831 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751276AbXDKItT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Apr 2007 04:49:19 -0400
Received: by an-out-0708.google.com with SMTP id b33so117663ana
        for <git@vger.kernel.org>; Wed, 11 Apr 2007 01:49:18 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=kxomw11Xgz0FPtR11pOi7SptAkB1WhKqwscXtrZPtrYdEk4T23JxB62EsMwLFRncbgVbszYpfTVboNzZwvPak6UkP/O7ZwTnb1g6po0uKWuGn5QcCoNVUL7jmW4L+Vi2/PPLt7U9QonuhDblnq6UJqHvsc/EfrUj2OZF3Ee/ONI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=f/oSI0PgTITC2HdESYTS5gVpzrxXDr2p6Ke9pmM8A4s7WCJU9xtQrWLucppu5UTKTE++ad9CUNBpzu1qSAMaTcxn61qAoVy/64W+of7YAiXA0ufV23MwZh3Ld/bRUYk2YnUxDhSnK6k194ZwaMhVLqSJDnDX7wXDB3nDhjsJioM=
Received: by 10.100.9.19 with SMTP id 19mr247875ani.1176281358657;
        Wed, 11 Apr 2007 01:49:18 -0700 (PDT)
Received: by 10.100.86.14 with HTTP; Wed, 11 Apr 2007 01:49:18 -0700 (PDT)
In-Reply-To: <20070411083642.GH21701@admingilde.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44225>

On 4/11/07, Martin Waitz <tali@admingilde.org> wrote:
> > >Always read and write one dedicated branch (hardcoded "master" or
> > >configurable) when the supermodule wants to access a submodule.
> >
> > In this case it does not correspond to the working tree anymore.
> > HEAD is the "closest" to working tree of submodule.
>
> yes.

"Yes" what? It should _not_ correspond to HEAD?

> This has been discussed in length already.
> Please have a look at the archives.

I should. But at least a short summary of the reasons
would be nice.

> Your working tree now contains a complete git repository which has
> features which are not available for normal files.  Notable, you
> have the possibility to create branches in the submodule.
> If you insist in using HEAD you throw away those submodule capabilities.
>

In this (a very special, I believe) case, why not use git update-index
--cacheinfo?
