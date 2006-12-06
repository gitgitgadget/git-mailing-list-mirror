X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Graham Percival <gpermus@gmail.com>
Subject: git newbie problems
Date: Tue, 05 Dec 2006 16:41:29 -0800
Message-ID: <457611B9.9020907@gmail.com>
References: <4574AC9E.3040506@gmail.com> <4574BF70.8070100@lilypond.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Wed, 6 Dec 2006 00:41:41 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=fNln4sCMT4kE7yEJ9/EfIqQQu7CAIpOjMH8Ycw3/bcSuUBNW9Bi9cgGIQunOs5F1wuO2Q7+fmiXP5ojLAg3cdOvwrPZulqeBCFnllVppSDCDjQ9oN8IbjMp9aRT/bNQO8gNGEROIIUpmdyaWpXoN70+CVVuO0mKeu59qjDNWJEw=
User-Agent: Thunderbird 1.5.0.8 (Macintosh/20061025)
In-Reply-To: <4574BF70.8070100@lilypond.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33395>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Grkqy-0006xK-N5 for gcvg-git@gmane.org; Wed, 06 Dec
 2006 01:41:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1758839AbWLFAli (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 5 Dec 2006
 19:41:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758862AbWLFAli
 (ORCPT <rfc822;git-outgoing>); Tue, 5 Dec 2006 19:41:38 -0500
Received: from nz-out-0506.google.com ([64.233.162.232]:27953 "EHLO
 nz-out-0102.google.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with
 ESMTP id S1758839AbWLFAlh (ORCPT <rfc822;git@vger.kernel.org>); Tue, 5 Dec
 2006 19:41:37 -0500
Received: by nz-out-0102.google.com with SMTP id s1so25463nze for
 <git@vger.kernel.org>; Tue, 05 Dec 2006 16:41:36 -0800 (PST)
Received: by 10.65.219.11 with SMTP id w11mr172335qbq.1165365696734; Tue, 05
 Dec 2006 16:41:36 -0800 (PST)
Received: from ?192.168.1.139? ( [207.216.3.102]) by mx.google.com with ESMTP
 id e19sm37468942qbe.2006.12.05.16.41.32; Tue, 05 Dec 2006 16:41:33 -0800
 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Greetings,

I'm posting these problems at Han-Wen and Dscho's insistence.  I'm the 
documentation editor for GNU/LilyPond, so I'm reluctant to criticize 
other project's documentation unless I spend an hour or more seriously 
reading it.  I'm quite willing to admit that I never seriously tried to 
read the docs on the overall theory of git (branches, repo, etc); I just 
flailed around looking for magic commands to make things work.  By "make 
things work", I mean imitating my work style with cvs:

cvs co blah blah  (which I simply copy and paste from savannah)
while (true) {
   cvs update          // get changes that happened overnight
   vi foo/bar/baz.txt  // or whatever editing commands you do
   make; make web      // or whatever testing commands you do
   cvs update          // get latest changes to prepare for
                       // uploading my changes.
   cvs ci foo/bar/baz.txt  // upload changes
}

Once or twice a year I'll do "cvs diff" or "cvs add", but all I really 
want are the above commands.  I figured that this should be really easy 
to do, so I kept on skimming through the docs, trying to find the 
equivalent of these really easy commands.  (note that I was reading the 
"tutorial introduction to git")

I should add that I've received help on the lilypond-devel list; I'm 
posting this in case it helps future development for git docs, not 
because I need more help to use git.

This case was particularly difficult because the very first time I tried
to commit... err... push... err... "make my doc changes available to
everybody else" (whatever the right term is), there was this merge problem.



MERGE PROBLEM

Two people (me and another person) edited the same line on
Documentation/user/advanced.itely at the same time.  (note that this 
file has existed for over a year; it's not a new file)  When I tried to 
get the most recent changes, I'm greeted with this:
...
Trying really trivial in-index merge...
Documentation/user/advanced-notation.itely: needs merge
fatal: you need to resolve your current index first
Nope.
Merging HEAD with c21d3f3e1c77722e50d994763442e6f994b03ac2
Merging:
038b7fc Misc small updates (trying to make git work).
c21d3f3 Merge branch 'master' of
ssh+git://hanwen@git.sv.gnu.org/srv/git/lilypond
found 1 common ancestor(s):
84219bb don't have input/templates/ any longer.
fatal: Entry '.gitignore' would be overwritten by merge. Cannot merge.
No merge strategy handled the merge.


As a git newbie, I'm quite confused.  OK, there's no merge strategy...
so what do I do now?  With cvs, the changes would be dumped into the
file.  I look at the file, found the conflict, and tried it again.  I
got the same error message, and then it occurred to me that although I
changed the files in my ~/usr/src/lilypond, git might be storing these
files somewhere else.  So I tried

$ git commit Documentation/user/advanced-notation.itely
Cannot do a partial commit during a merge.
You might have meant to say 'git commit -i paths...', perhaps?

... eh?  I'm trying to fix this so that you _can_ merge!  Regardless,
when I tried to update again, I get

$ git pull gnu master
...
Trying really trivial in-index merge...
fatal: Entry '.gitignore' would be overwritten by merge. Cannot merge.
Nope.
Merging HEAD with c21d3f3e1c77722e50d994763442e6f994b03ac2
Merging:
038b7fc Misc small updates (trying to make git work).
c21d3f3 Merge branch 'master' of
ssh+git://hanwen@git.sv.gnu.org/srv/git/lilypond
found 1 common ancestor(s):
84219bb don't have input/templates/ any longer.
fatal: Entry '.gitignore' would be overwritten by merge. Cannot merge.
No merge strategy handled the merge.


Now I'm totally confused, because I definitely haven't touched .gitignore.


SUGGESTIONS

The "tutorial introduction to git" looks like a nice document, but it
assumes that you are in control of the project.  For users who aren't in
control (ie me) this is a problem, because it starts me skimming.
"Importing a project"... nah, that's not me.  "Merging branches"... I
don't care; I'm going to shove everything into the main branch.  "Using
git for collaboration"... hmm, maybe this is the stuff I need to read.
But by this point, I've already skimmed through five screens of info, so
I'm not reading very carefully.

It would be nice to have an accompanying "tutorial introduction to
contributing with git" for users (like me) who are not in control of a 
project.

Finally, it would be really nice if there was some mention of "resolving
merge problems" in the tutorial (both in the current one and any new docs).

Cheers,
- Graham Percival

