X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: rda <rda@google.com>
Subject: Re: kernel.org mirroring (Re: [GIT PULL] MMC update)
Date: Sun, 10 Dec 2006 01:43:04 -0800
Message-ID: <87dcb0bd0612100143t21932358k42fe5044654e1981@mail.gmail.com>
References: <Pine.LNX.4.64.0612020835110.3476@woody.osdl.org>
	 <45785697.1060001@zytor.com>
	 <Pine.LNX.4.64.0612071052560.3615@woody.osdl.org>
	 <457868AA.2030605@zytor.com> <20061207193012.GA84678@dspnet.fr.eu.org>
	 <4578722E.9030402@zytor.com> <4579611F.5010303@dawes.za.net>
	 <45798FE2.9040502@zytor.com>
	 <Pine.LNX.4.64.0612080830380.3516@woody.osdl.org>
	 <457995F8.1080405@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sun, 10 Dec 2006 09:43:28 +0000 (UTC)
Cc: "Linus Torvalds" <torvalds@osdl.org>,
	"Rogan Dawes" <discard@dawes.za.net>,
	"Kernel Org Admin" <ftpadmin@kernel.org>,
	"Git Mailing List" <git@vger.kernel.org>,
	"Jakub Narebski" <jnareb@gmail.com>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:to:subject:cc:in-reply-to:
	mime-version:content-type:content-transfer-encoding:
	content-disposition:references;
	b=eU8LIeeoPgzVSJoEH5TUNkt5GW2zfyXrfBLBQlHNZLgE8qDiP5V+t1xl6lSpKfADm
	lH6eGVtQOAaXjDWYibG/A==
In-Reply-To: <457995F8.1080405@zytor.com>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33873>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GtLDL-00066V-H4 for gcvg-git@gmane.org; Sun, 10 Dec
 2006 10:43:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1760595AbWLJJnO (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 10 Dec 2006
 04:43:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760609AbWLJJnO
 (ORCPT <rfc822;git-outgoing>); Sun, 10 Dec 2006 04:43:14 -0500
Received: from smtp-out.google.com ([216.239.33.17]:33399 "EHLO
 smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1760595AbWLJJnN (ORCPT <rfc822;git@vger.kernel.org>); Sun, 10 Dec 2006
 04:43:13 -0500
Received: from spaceape8.eur.corp.google.com (spaceape8.eur.corp.google.com
 [172.28.16.142]) by smtp-out.google.com with ESMTP id kBA9h6dR008462 for
 <git@vger.kernel.org>; Sun, 10 Dec 2006 09:43:07 GMT
Received: from py-out-1112.google.com (pyhn24.prod.google.com [10.34.240.24])
 by spaceape8.eur.corp.google.com with ESMTP id kBA9h545002773 for
 <git@vger.kernel.org>; Sun, 10 Dec 2006 09:43:05 GMT
Received: by py-out-1112.google.com with SMTP id n24so783991pyh for
 <git@vger.kernel.org>; Sun, 10 Dec 2006 01:43:04 -0800 (PST)
Received: by 10.65.219.6 with SMTP id w6mr178470qbq.1165743784794; Sun, 10
 Dec 2006 01:43:04 -0800 (PST)
Received: by 10.64.83.3 with HTTP; Sun, 10 Dec 2006 01:43:04 -0800 (PST)
To: "H. Peter Anvin" <hpa@zytor.com>
Sender: git-owner@vger.kernel.org

On 12/8/06, H. Peter Anvin <hpa@zytor.com> wrote:
> Linus Torvalds wrote:
> > I could write a simple C caching thing that just hashes the CGI arguments
> > and uses a hash to create a cache (and proper lock-files etc to serialize
> > access to a particular cache object while it's being created) fairly
> > easily, but I'm pretty sure people would much prefer a mod_perl thing just
> > to avoid the fork/exec overhead with Apache (I think mod_perl allows
> > Apache to run perl scripts without it), and that means I'm not the right
> > person any more.
>
> True about mod_perl.  Haven't messed with that myself, either.
> fork/exec really is very cheap on Linux, so it's not a huge deal.

In the case of Perl scripts, it's not really the fork/exec overhead,
but the Perl startup overhead that you want to try to optimize.  But
given your later statement (lots of spare cpu), this ends up just
being a bit of a latency hit.   In general, I think mod_perl has a
