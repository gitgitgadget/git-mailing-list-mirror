From: Chris Wright <chrisw@osdl.org>
Subject: Re: Cannot install git RPM
Date: Wed, 10 Aug 2005 09:23:07 -0700
Message-ID: <20050810162307.GE8041@shell0.pdx.osdl.net>
References: <20050810003012.GB22778@mythryan2.michonline.com> <20050810074607.30803353C46@atlas.denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ryan Anderson <ryan@michonline.com>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 10 18:24:38 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E2tMk-00080i-EL
	for gcvg-git@gmane.org; Wed, 10 Aug 2005 18:23:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965186AbVHJQXY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 10 Aug 2005 12:23:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965184AbVHJQXY
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Aug 2005 12:23:24 -0400
Received: from smtp.osdl.org ([65.172.181.4]:40895 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965173AbVHJQXX (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 10 Aug 2005 12:23:23 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j7AGN8jA007409
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 10 Aug 2005 09:23:09 -0700
Received: from shell0.pdx.osdl.net (localhost [127.0.0.1])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j7AGN8XX029625;
	Wed, 10 Aug 2005 09:23:08 -0700
Received: (from chrisw@localhost)
	by shell0.pdx.osdl.net (8.13.1/8.13.1/Submit) id j7AGN7f6029624;
	Wed, 10 Aug 2005 09:23:07 -0700
To: Wolfgang Denk <wd@denx.de>
Content-Disposition: inline
In-Reply-To: <20050810074607.30803353C46@atlas.denx.de>
User-Agent: Mutt/1.5.6i
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.41__
X-MIMEDefang-Filter: osdl$Revision: 1.113 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

* Wolfgang Denk (wd@denx.de) wrote:
> It's then the "perl(Email::Valid)" and "perl(Mail::Sendmail)"  depen-
> dencies  which  cause  problems.  I  installed  all perl packages and
> modules I was able to find in the standard FC places,  but  this  did
> not solve the problem. Maybe this is actually a bug in Fedora Core ?

No, you probably missed the earlier thread on this.  It's not a bug,
those are real dependencies which rpm automagically discovers (along
with things like shared library dependencies).  The issue is the
git-send-email-script uses Mail/Sendmail.pm and Email/Valid.pm which
aren't part of standard install.  Your choices are to grab the relevant
packages, do an install with --nodeps (and know that
git-send-email-script will not work), make a subpackage for that script
so it can have its own dependencies, or move that script to elsewhere
so it's not scanned for depenedency info.

thanks,
-chris
