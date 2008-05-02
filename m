From: "Elijah Newren" <newren@gmail.com>
Subject: Re: EasyGit [Was: Re: my git problem]
Date: Fri, 2 May 2008 05:54:04 -0600
Message-ID: <51419b2c0805020454p144698e4l843e8edab00ddeb7@mail.gmail.com>
References: <51419b2c0805020441l7a52f9d2q6bfc8eb4e18e4e7e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Havoc Pennington" <hp@pobox.com>, "Carl Worth" <cworth@cworth.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 02 13:55:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jrtqq-0005Pi-Ru
	for gcvg-git-2@gmane.org; Fri, 02 May 2008 13:54:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758864AbYEBLyJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 May 2008 07:54:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757684AbYEBLyI
	(ORCPT <rfc822;git-outgoing>); Fri, 2 May 2008 07:54:08 -0400
Received: from wa-out-1112.google.com ([209.85.146.176]:54631 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754888AbYEBLyF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 May 2008 07:54:05 -0400
Received: by wa-out-1112.google.com with SMTP id j37so249006waf.23
        for <git@vger.kernel.org>; Fri, 02 May 2008 04:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=ao0eHbzylUm/4YRGqKRAdfEJAknbqrWcVe3iMG6PkzM=;
        b=vWuMo9S912BqwZP0Zc+PGKG35vweVXgTa3M9lmGoe9g6T0ZI09mFcPqpafs0ZkTHvGEGhEObX33nH/J9/uZ2oh/RyYrQZ1zVtdYYTitCCPzdcbocPjNnbE07iD1Hm0Scfd9VZqeNN7Wb8PeD8GrFvBsUHKvtlZdqGJIwow9mhss=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=JwhPvDFPqef/Wf8tgZcN9N9LXTqqfA9ipAjvorrtrk2PAYKP8Ps/ypFqE/4/Q0uQlpKPb30HCU4eqJRpgAjRYQvhSl1/Q4RF39aTc1IEWphtrgzZ2et0aDqZ8nAqGqmpGj+LQ2y5GA9/YA1BnputR/4lywrC2CbLqmsE21r9H+w=
Received: by 10.115.60.1 with SMTP id n1mr2940894wak.37.1209729245053;
        Fri, 02 May 2008 04:54:05 -0700 (PDT)
Received: by 10.114.73.10 with HTTP; Fri, 2 May 2008 04:54:04 -0700 (PDT)
In-Reply-To: <51419b2c0805020441l7a52f9d2q6bfc8eb4e18e4e7e@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80981>

On Fri, May 2, 2008 at 5:41 AM, Elijah Newren <newren@gmail.com> wrote:
> ... all I've really done so far in EasyGit is
>  * provide built-in tutorial-oriented documentation
>  * check for common user mistakes and warn about them
>  * add subcommand options in a way that breaks up the near cylic
>  knowledge dependence of git subcommands so that they can be learned in
>  a layered/hierarchical fashion
>  * add some gratuitous svn-compatibility commands to ease the
>  transition for svn users

I had typed up an explanation of what EasyGit is and does in more
detail and was going to wait to send it until I resolved some of the
issues Havoc brought up, but maybe it makes sense to send that out
now.  So, here it is:


EasyGit (eg) is a single-file script/porcelain that looks and feels like
core git.  In contrast to other simple-to-use porcelains, eg has all the
same capabilities as git (in particular, it does not remove the index) and
uses the same general syntax as core git.  Eg primarily reduces the
learning curve associated with git and prevents common user errors.

Changes:
  Most of the changes in eg relative to git boil down to:
    - plugging a large gap in git documentation (namely, providing a
      tutorial-oriented built-in help system)
    - warning about or preventing many common gotchas users run into with
      git
    - enabling users to learn in a layered fashion
  A detailed explanation of the differences, rationale for the changes in
  eg, and even arguments against some of the changes I made in eg can be
  found at
    http://www.gnome.org/~newren/eg/git-eg-differences.html

Saving cvs/svn users:
  EasyGit also looks and feels like svn on the most common subset of
  functionality used in the two systems, mostly due to the addition of a
  number of gratuitous svn-compatibility commands (such as cat, resolved,
  update).  cvs and svn users may be interested in the detailed comparison
  at
    http://www.gnome.org/~newren/eg/git-for-svn-users.html

Trying it:
  I believe new users will be able to learn git faster by first using eg,
  than by starting with git directly.  Switching between using eg and git
  on the same repositories is considered perfectly normal.  There are a
  couple aids to assist users in switching back and forth between eg and
  git:
    - Each help page has a section for listing any differences between eg
      and git.
    - Users can run
        eg --translate ARGS...
      to see what git command(s) would be run by
        eg ARGS...
      without actually running them.

Goals for eg:
  Git has obtained a reputation for being difficult to learn.  I wanted to
  prove that a porcelain could be written which
    1) was easy to learn
    2) retained all the functionality in git
    3) does not hinder the workflows of longtime git users and does not
       require them to relearn the UI
  Feedback from early adopters suggest that I have made good progress
  towards achieving the first two goals; I do not have enough feedback
  to determine whether I have done well with the last one.

  I would like to see the parts of eg that the community likes
  incorporated into git core.  I do not know which changes would be wanted
  or welcome, and it may turn out that some of my changes show ignorance
  of certain aspects of git (some such cases have previously been
  uncovered already...and fixed).  But the discussion can't hurt, and a
  number of the solutions I used in eg I have not found in searches of
  previous discussions in the archives.


Elijah
