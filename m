From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: nicer frontend to get rebased tree?
Date: Fri, 22 Aug 2008 12:34:00 -0700 (PDT)
Message-ID: <m37ia8sv49.fsf@localhost.localdomain>
References: <20080822174655.GP23334@one.firstfloor.org>
	<32541b130808221056l75a3fd6bsa6c7933a1c3da60f@mail.gmail.com>
	<20080822183129.GR23334@one.firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Avery Pennarun <apenwarr@gmail.com>, git@vger.kernel.org
To: Andi Kleen <andi@firstfloor.org>
X-From: git-owner@vger.kernel.org Fri Aug 22 21:35:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWcPf-0004Sz-Mw
	for gcvg-git-2@gmane.org; Fri, 22 Aug 2008 21:35:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753173AbYHVTeH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Aug 2008 15:34:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752149AbYHVTeG
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Aug 2008 15:34:06 -0400
Received: from ug-out-1314.google.com ([66.249.92.172]:61168 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751355AbYHVTeD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Aug 2008 15:34:03 -0400
Received: by ug-out-1314.google.com with SMTP id c2so215682ugf.37
        for <git@vger.kernel.org>; Fri, 22 Aug 2008 12:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=uf7KU3r2mwHW+dRYhdwxRkv86eerthhyz5RfEZ7lKzQ=;
        b=tLW9OQm/f+6Ux4k+eV1vJdqGCd4ttRRQtKH2XQhDyekC8h439beo8zXrkti0cIhzfd
         VPjH/XI82PK4Wsolz4zVQBpUKLH65/QvWodWUTwqTROciZrEB/OCM/rGcJQUvCGtGS3k
         r2rDlFJNik9ZbPOqkqgsIZZrIVi7owKTBfxL4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=w+4QCE1SGqEvVALAm017reZ+2+UEZJJG7MllUjQA2/5/qQdRKLqs5y+4gZ9lB0m5PC
         GgPAD7n2KIYxRL58m2GrBFqIFAxf8Tf7Ka26nxPEgSaGTcmZ2qQANRnGDfV17aIoPabs
         hyoWJNWVl0SEltqQB1/OtEM+sCU60kJyTGlOk=
Received: by 10.67.94.10 with SMTP id w10mr100020ugl.41.1219433641872;
        Fri, 22 Aug 2008 12:34:01 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.249.91])
        by mx.google.com with ESMTPS id g30sm220765ugd.61.2008.08.22.12.33.57
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 22 Aug 2008 12:34:00 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m7MJXTx4007531;
	Fri, 22 Aug 2008 21:33:30 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m7MJXBMW007526;
	Fri, 22 Aug 2008 21:33:11 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <20080822183129.GR23334@one.firstfloor.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93346>

Andi Kleen <andi@firstfloor.org> writes:

> On Fri, Aug 22, 2008 at 01:56:39PM -0400, Avery Pennarun wrote:
> > On Fri, Aug 22, 2008 at 1:46 PM, Andi Kleen <andi@firstfloor.org> wrote:

> > > But I presume that's a reasonable common usage. Would it
> > > make sense to have some standard git sub command that does that?
> > > ("get latest state of remote branch, doing what it takes to get it")
> > > Or is there already one that I missed?
> > 
> > Isn't that just
> > 
> >     git fetch somewhere branchname
> >     git reset --hard FETCH_HEAD
> > 
> > ?
> 
> My script right now does.
> 
> git fetch origin
> git fetch --tags origin
> git remote update
> git checkout master
> git reset --hard origin/master
> 
> Sure I can continue using the script (until some change breaks it %),
> but I was just asking if that was a common enough operation to deserve
> some better support in standard git. It personally (as a relatively
> inexperienced git user) took me some time to come up with
> this script and I found the original behaviour of git pull on rebased
> trees double-plus unintuitive.
> 
> Just an idea for improvement.

With new enough git it should be enough to do

  $ git fetch origin
  $ git checkout origin/master      # detaches HEAD

OR

  $ git remote update
  $ git reset --hard origin/master  # when on master

BTW. it is stated countless time in documentation that published
history should be not rebased, barring some extenuating circumstances
(liku Junio's 'pu' (proposed updates) branch in git repository).
-- 
Jakub Narebski
Poland
ShadeHawk on #git
