From: "Anatol Pomozov" <anatol.pomozov@gmail.com>
Subject: Re: [RFC/PATCH] extend meaning of "--root" option to index comparisons
Date: Fri, 19 Sep 2008 09:54:15 -0700
Message-ID: <3665a1a00809190954q2473e164u5d80d3653d238a27@mail.gmail.com>
References: <3665a1a00809151301p7d8e6387g3cacfb879b45da2f@mail.gmail.com>
	 <48CECA42.1050209@drmicha.warpmail.net>
	 <bd6139dc0809151411p49f5adeaq4beff452574ca980@mail.gmail.com>
	 <20080915223442.GD20677@sigill.intra.peff.net>
	 <bd6139dc0809152319m31a79877h5dc1b701a8210802@mail.gmail.com>
	 <20080916062105.GA12708@coredump.intra.peff.net>
	 <20080918092152.GA18732@coredump.intra.peff.net>
	 <3665a1a00809180931t191b5a24wd58554cdb761535@mail.gmail.com>
	 <20080919142537.GA1287@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: sverre@rabbelier.nl, "Junio C Hamano" <gitster@pobox.com>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Jeff King" <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Sep 19 18:55:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KgjGR-0008Nk-9z
	for gcvg-git-2@gmane.org; Fri, 19 Sep 2008 18:55:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753198AbYISQyR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Sep 2008 12:54:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753073AbYISQyR
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Sep 2008 12:54:17 -0400
Received: from wf-out-1314.google.com ([209.85.200.169]:25357 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752660AbYISQyQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Sep 2008 12:54:16 -0400
Received: by wf-out-1314.google.com with SMTP id 27so554089wfd.4
        for <git@vger.kernel.org>; Fri, 19 Sep 2008 09:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=sHgZ8J7L/VS5W98NLkTp2dKR4hzTUMCiE84klamnrQc=;
        b=VWHrKGoJkrZv6GrTxL4W7p3k485j8t5pVLjVuvcuYdztv267lQNiHjkUouAlt5AX6d
         wk1n9S+ZBeEG1yjPve7Ka8SobKgzvMDF1Ti1A/z2IrYM7LWpb+4cKFSzkKVXXep2gfJR
         ACx7D/zWXRMifANEqRAPxHlYTUfqxzvG5yaIQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=nuv8onHEs5xjiX6JeWAF2slhJnmdS5utYZFd3k18TnhFPN6RbqQUSjDRuJ9N0bL3wX
         cUQowQCkNyL5IIMcuPxTwlGqb0nEh8HfZ3ZPElIJoQQe2YdD6gfH4ZU3FyaB8yerIDWv
         lXcKpUEk+qh3ZotiEkQr0CottYuq/PCBevmhk=
Received: by 10.114.102.20 with SMTP id z20mr439561wab.76.1221843256021;
        Fri, 19 Sep 2008 09:54:16 -0700 (PDT)
Received: by 10.115.78.6 with HTTP; Fri, 19 Sep 2008 09:54:15 -0700 (PDT)
In-Reply-To: <20080919142537.GA1287@coredump.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96301>

Hi, Jeff.

On Fri, Sep 19, 2008 at 7:25 AM, Jeff King <peff@peff.net> wrote:
> I'm not sure that's the same as "--root", though. In existing --root
> cases, we are saying "pretend that beyond the initial commit, there is a
> commit that contains the empty tree". The logical extension of git-log
> here would be to print out that commit.
Well yeah, agree. My proposal differs from --root meaning and what you
are doing in your patch. So let's continue this 'git log' discussion
without relation to your changes.

> Not to mention that "git log --root" _already_ has defined semantics
> (you just don't really need it since log.showroot defaults to true).
Hm..

anatol:opensource $ mkdir ex
anatol:opensource $ cd ex/
anatol:ex $ git init
Initialized empty Git repository in /personal/sources/opensource/ex/.git/
anatol:ex $ git log
fatal: bad default revision 'HEAD'
anatol:ex $ git config log.showroot true
anatol:ex $ git config log.showroot
true
anatol:ex $ git log
fatal: bad default revision 'HEAD'
anatol:ex $ git config core.showroot true
anatol:ex $ git config core.showroot
true
anatol:ex $ git log
fatal: bad default revision 'HEAD'

I dont see how does log.showroot or core.showroot affect 'git log'.
man git-log says nothing, git-config only mentions that initial commit
is "a big creation event".

> I wonder if my patch is actually confusing things more, and the right
> solution is an option that says "pretend that a non-existant HEAD is a
> commit with no log and the empty tree." But I think that may just be
> confusing things more, because the semantics of such a null commit
> wouldn't be clear (e.g., git log would actually produce a little bit of
> output).
Yeap - probably it would confuse even more, that is why I brought it
for discussion :)

But for me as for person that still actively works with Subversion it
was quite surprising that I have error messages right after I created
a fresh empty repo. I always thought that "Empty repo" -> "No history"
-> "No log output"

Subversion in the same situation.

anatol:2 $ svn info | grep Revision
Revision: 0
anatol:2 $ svn log
------------------------------------------------------------------------

So svn has the same notion of Initial commit which is "big creation
event" but not visible in "svn log"

The difference from git is that init git repo has no HEAD. HEAD is
undefined. Would it be better if absence of HEAD would mean the same
as "HEAD points to the initial commit".

> Maybe it really is better to just force the caller to check the initial
> commit condition. It's more work for them, but the semantics are simple
> and unambiguous.

What is the best way to check that repo has valid HEAD? Check that
file .git/HEAD exists?

-- 
anatol
