From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [linux.conf.au] VCS Interoperability
Date: Thu, 26 Jan 2012 18:10:41 -0600
Message-ID: <20120127001041.GB6158@burratino>
References: <CAFfmPPMH2643JMMZdVbOQJL7DB-DiRYQS8x0TqEaSbGmhMdBNw@mail.gmail.com>
 <CALkWK0kMmDMZ4wiMSmOfwBLzd+xBEA+WKsviu9FVcvj9eZEahg@mail.gmail.com>
 <CAFfmPPOZfDdH+GF91Dxyy5yfX8TmGDmsbpHz=CVLcBY0c-pCsQ@mail.gmail.com>
 <CALkWK0nsO2EBLUrO_iWAdGYpULt=oug4yPDnczX9c44hzdwzqg@mail.gmail.com>
 <alpine.DEB.2.02.1201221310540.28747@asgard.lang.hm>
 <3BC64515-C4C0-4D32-97B0-8FFD14BB903C@silverinsanity.com>
 <CAP2yMaLHK2md=MHFmV--R6rmr4q3XuZxqsb2fUszMhssx3GDoA@mail.gmail.com>
 <CAFfmPPPvpbsYz9cjN6OspivCN3dbuPGOU7fyaVdnic3D4V855w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Scott Chacon <schacon@gmail.com>,
	Brian Gernhardt <benji@silverinsanity.com>, david@lang.hm,
	Ramkumar Ramachandra <artagnon@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Dmitry Ivankov <divanorama@gmail.com>
To: David Barr <davidbarr@google.com>
X-From: git-owner@vger.kernel.org Fri Jan 27 01:10:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RqZP2-0004r0-5n
	for gcvg-git-2@lo.gmane.org; Fri, 27 Jan 2012 01:10:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752185Ab2A0AKr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jan 2012 19:10:47 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:64823 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751491Ab2A0AKq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jan 2012 19:10:46 -0500
Received: by ghrr11 with SMTP id r11so557226ghr.19
        for <git@vger.kernel.org>; Thu, 26 Jan 2012 16:10:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=bnfwTgK8x7NlD0U+nXxg3n7oZdP3X3yuDH346dR50sQ=;
        b=KUloRhphDBsMUCEvw/s/tYGyUxHkcKsmt4MVSqBCSi2QbJwtaWgYuDxWiqoGFx+eNV
         ECmQDFvmDZZESlemKyk6enLFXNYjhH2I5Fs0ixkfmPUjryX+hNVbd6jJ7weNZ3kIR580
         UewWHOq5DmLkCdlaUs1LLRaO57CjJl5IMUtgA=
Received: by 10.236.79.202 with SMTP id i50mr6853427yhe.61.1327623046208;
        Thu, 26 Jan 2012 16:10:46 -0800 (PST)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id i6sm15263337and.3.2012.01.26.16.10.44
        (version=SSLv3 cipher=OTHER);
        Thu, 26 Jan 2012 16:10:45 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAFfmPPPvpbsYz9cjN6OspivCN3dbuPGOU7fyaVdnic3D4V855w@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189176>

Hi,

David Barr wrote:

> After giving my talk, I feel compelled to reroll the historic vcs-svn series.
> I'm pushing as I go to my GitHub account:
>
>   https://github.com/barrbrain/git/commits/svn-fe-reroll

Just some quick notes to save some time:

All the commits on the 

 git://repo.or.cz/git/jrn.git svn-fe

branch were known-good in the sense that they seemed sane enough to
build on and I do not think they need any reorganization or other
work.  Maybe that could help bootstrap your efforts?

The svn-fe-pu branch includes some other patches: some optimizations
which are probably safe, the demo helper that allows "git clone
svn-alpha::<url>", some transport-helper patches to support the
latter, and so on.  They are not vetted.  If anyone sends patches from
that branch, or any other patch for that matter, to the list and cc-s
me, I'll be happy to review them.  Here's a shortlog for convenience:

 David Barr (2):
       fast-import: allow object_table to grow dynamically
       fast-import: allow atom_table to grow dynamically
 
 Dmitry Ivankov (2):
       Arrange a backflow pipe from fast-importer to remote helper stdin
       Add alpha version of remote-svn helper
 
 Jonathan Nieder (12):
       work around ISO C incompatibility between data and function pointers
       ensure initializer elements are computable at load time
       enums: omit trailing comma for portability
       notes: avoid C99-style comment
       notes merge: eliminate OUTPUT macro
       make sure initializers are computable at load time
       fast-import: allow branch_table to grow dynamically
       fast-import: use DIV_ROUND_UP
       svn-fe: add a program that generates a notes-to-svn-revs mapping
       svn-fe: do not rely on /bin/env utility to launch remote helper
       svn-fe: use tabs to indent in remote helper script
       remaining warnings

Test results from the svn-fe branch would be interesting.  I am
particularly nervous about asking Junio to pull changes to
contrib/svn-fe that might break it at the same time as making the
interface changes needed for support of the "svnadmin dump
--incremental" format without much testing since it would be painful
to back them out.  But probably that's moot, since after this long
while there still hasn't been anyone testing it.

Jonathan
