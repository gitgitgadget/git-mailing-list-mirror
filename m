From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Committing with past date?
Date: Tue, 2 Sep 2008 02:31:32 +0200
Message-ID: <200809020231.32780.jnareb@gmail.com>
References: <1220179469.5518.5.camel@magnus-desktop> <m34p51qvzv.fsf@localhost.localdomain> <1220286321.5474.6.camel@magnus-desktop>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Magnus Hjorth <magnus.hjorth@home.se>
X-From: git-owner@vger.kernel.org Tue Sep 02 02:33:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KaJpW-0001UQ-3O
	for gcvg-git-2@gmane.org; Tue, 02 Sep 2008 02:33:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751534AbYIBAbe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Sep 2008 20:31:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751517AbYIBAbe
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Sep 2008 20:31:34 -0400
Received: from fg-out-1718.google.com ([72.14.220.154]:8356 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751043AbYIBAbd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Sep 2008 20:31:33 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1726819fgg.17
        for <git@vger.kernel.org>; Mon, 01 Sep 2008 17:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=0SS6fWQ1xpkDTZGUr+M7SDC4YN3c36To/ZPcJZaHSZU=;
        b=GNrACpKgAE/FIsQ0jexkWWoBCKCfIqIi1GXT3kYy0m6IkqAtzBLotchwr15Yd5AxI4
         Z3P9QLHfg/AnAGV+2Rde3/NSfNJAK1LUch1vLp6YADYwcShb460jF8UhsrhEiLEoRROT
         d9UAqcnfM36f7g2gUYoc9DS1lz4vb5ZF8K5tk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=a/HAZ2VONBeN+P2ZXIM004I6OsUNmMpVTAa4z2k/ogbpBKFzi214VOksGqsmKWQSUg
         6/ypLQzlNNi2ZeUir5/ArEeVbfa1rT1j/phHsFZpQmG6zhTxhHoNIUe5U9uzISrZvwph
         pEl1bDTG4IfeePEeMvzofCLJhgRNk59qz4aEg=
Received: by 10.86.95.20 with SMTP id s20mr5063705fgb.65.1220315491683;
        Mon, 01 Sep 2008 17:31:31 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.218.210])
        by mx.google.com with ESMTPS id d4sm7402637fga.5.2008.09.01.17.31.30
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 01 Sep 2008 17:31:31 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <1220286321.5474.6.camel@magnus-desktop>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94633>

On Mon, 1 Sep 2008, Magnus Hjorth wrote:
> On Sun, 2008-08-31 at 04:12 -0700, Jakub Narebski wrote:
> > Magnus Hjorth <magnus.hjorth@home.se> writes:
> > 
> > > Can someone tell me how to make a git commit with a date other than the
> > > current. I hope there is some easier way than changing the system
> > > clock.. :)
> > 
> > See git(1), section "Environment Variables":
> >    git Commits
> >        GIT_AUTHOR_NAME, GIT_AUTHOR_EMAIL, GIT_AUTHOR_DATE,
> >        GIT_COMMITTER_NAME, GIT_COMMITTER_EMAIL, GIT_COMMITTER_DATE,
> >        EMAIL
> >               see git-commit-tree(1)
> > 
> > or you can use GIT_COMMITTER_IDENT, GIT_AUTHOR_IDENT.  See output
> > of "git var -l" to get form of it.
> >  
> > > I'm trying to port over old version history that I maintained manually
> > > (tarballs and changelogs) into a git repository. 
> > 
> > For that, I think it would be best to take a look at example
> > fast-import script: contrib/fast-import/import-tars.perl;
> > there is equivalent contrib/fast-import/import-zips.py if you
> > perfer either Pyhon over Perl, and/or zips over tarballs.


> Thank you Jakub! 
> 
> Forgot to look in the main git manpage, and that variable wasn't
> mentioned in the git-commit manpage or in any FAQ.. 

Using GIT_AUTHOR_DATE etc. is a bit hacky, so that is why it is not
mentioned in git-commit homepage, but only in git-commit-index(1)
plumbing homepage, and of course on git(1) which should include _all_
environment variables affecting git execution.

By the way, is there any reason _not_ to use import-tars.perl from
the contrib/fast-import in your case?
 
> Now I have a more tricky question.
> 
> The first part of my application history (the stone age) was maintained
> manually using tarballs, but the second part was maintained using CVS
> (the dark ages).
> 
> I have successfully imported the CVS history using git-cvsimport, but
> now I want to add these older revisions that were made with tarballs to
> the same tree, before the CVS revisions. The last tarball and the first
> CVS revision have identical content, and I would like to somehow "glue"
> the histories together.
> 
> Can this be done? 

It can be done for example using grafts. Search git mailing list for
graftshistory (or something like that) script, which was used to join
using grafts git "current work" Linux repository (started from "scratch").
Then you can check in gitk if everything is all right. If you truly
require connected histories, and not being able to locally turn on
and off the historical repository, you can always use git-filter-branch
which (among others) can turn grafts into true commits.

Linux kernel repo has current work repository, and legacy BitKeeper
repository, which one can join together if needed using grafts file
(see Documentation/gitrepository-layout.txt 

-- 
Jakub Narebski
ShadeHawk on #git
Poland

A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing on Wsenet and in e-mail?
