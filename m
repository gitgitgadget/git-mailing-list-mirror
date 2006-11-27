X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Some tips for doing a CVS importer
Date: Mon, 27 Nov 2006 10:20:09 -0500
Message-ID: <9e4733910611270720y39767623he59f919b94e70e16@mail.gmail.com>
References: <9e4733910611201349s4d08b984g772c64982f148bfa@mail.gmail.com>
	 <456ACAF3.1050608@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Mon, 27 Nov 2006 15:20:23 +0000 (UTC)
Cc: "Git Mailing List" <git@vger.kernel.org>, dev@cvs2svn.tigris.org,
	"Shawn Pearce" <spearce@spearce.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=FM8QrPRgvuchH/Z+Ztsd8RTAlJ06binAsAsR5KSJA5D/wqI6WfUjV8Av366KKqlo57w74JERGPMn5lbpZWrka2zjdU3Z/cI0GZa2RX2axn75gTkUzlvyAAtboNlZBZKlCUZffMU0ZZwM+abEK+zY3Usv4GRcxxukR+auARD1KQ4=
In-Reply-To: <456ACAF3.1050608@alum.mit.edu>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32418>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GoiHJ-0004Qg-VY for gcvg-git@gmane.org; Mon, 27 Nov
 2006 16:20:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1758262AbWK0PUO (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 27 Nov 2006
 10:20:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758272AbWK0PUO
 (ORCPT <rfc822;git-outgoing>); Mon, 27 Nov 2006 10:20:14 -0500
Received: from py-out-1112.google.com ([64.233.166.178]:18312 "EHLO
 py-out-1112.google.com") by vger.kernel.org with ESMTP id S1758262AbWK0PUM
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 27 Nov 2006 10:20:12 -0500
Received: by py-out-1112.google.com with SMTP id a29so1124225pyi for
 <git@vger.kernel.org>; Mon, 27 Nov 2006 07:20:09 -0800 (PST)
Received: by 10.35.70.17 with SMTP id x17mr13414418pyk.1164640809327; Mon, 27
 Nov 2006 07:20:09 -0800 (PST)
Received: by 10.35.72.13 with HTTP; Mon, 27 Nov 2006 07:20:09 -0800 (PST)
To: "Michael Haggerty" <mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org

On 11/27/06, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> I am currently the main (and pretty much the only) cvs2svn maintainer.
> Development has been proceeding more slowly lately because (1) I'm very
> busy with my day job, and (2) nobody has stepped forward to help.
>
> Jon Smirl wrote:
> > #1) There needs to be a tool that can accurately import the
> > repository. cvs2svn does not do this. The good programmers working on
> > git could probably whip this out in a week or two if they wanted to.
> > cvs2svn is very close but they refuse to solve the symbol dependency
> > problem.
>
> Jon, I wish you wouldn't portray as obstinacy what is simply a lack of
> resources.  I would like very much to support other cvs2svn output
> formats.  I think it would be great if other projects could benefit from
> our work.  Most of the work I've been doing on cvs2svn lately has been
> towards supporting other output SCMs.

cvs2avn is a nice piece of code, it is a worthy goal to have a
univeral conversion tool.

>
> Jon Smirl wrote:
> > I gave up on my cvs2git code, cvs2svn has been refactored so badly
> > that it was too much trouble tracking. It would be easier to write it
> > again. Most of the smarts from the import process is in the
> > git-fastimport code which Shawn has. cvs2svn underwent a major
> > algorithm change after I wrote the first version of git2svn.
>
> I hope that by "badly" you mean "extensively" and not "poorly" :-\  If
> you mean "poorly", then I'd like to hear your feedback/suggestions.

Extensively, the dependency rewrite changed things some much that my
patches were basically worthless. I tried merging them and gave up, it
would be more efficient to rewrite them or builld hooks in the right
places.

>
> A large amount of refactoring has been needed to make the change to
> dependency-based conversion possible, and a lot more to help support
> different output formats.  I understand that this causes difficulties
> for people trying to do parallel development, but most of the
> refactoring was done before your first appearance on the cvs2svn mailing
> lists.  If you had let us know what you were working on, I would have
> avoided making conflicting changes (as I did with Oswald Buddenhagen's
> commit-dependencies changes).
>
> Jon Smirl wrote:
> > I have tried all of the available CVS importers. None of them are
> > without problems. If anyone is interested in writing one for git here
> > are some ideas on how to structure it.
> >
> > 1) there is a working lex/yacc for CVS in the parsecvs source code
> > 2) The first time you parse a CVS file record everything and don't
> > parse it again.
> > 3) When the file is first parsed use the deltas to generate the
> > revisions and feed them to git-fastimport, just remember the SHA1 or
> > an id in the import code. This is a critical step to getting decent
> > performance.
> > 4) If you do #1 and #2 you don't need to store CVS revision numbers
> > and file names in memory. Because of that you can can easily do a
> > Mozilla import in 2GB, probably 1GB.
> > 5) When comparing CVS revisions only use the CVS timestamps as a last
> > resort, instead use the dependency information in the CVS file
> > 6) Match up commits by using an sha1 of the author and commit message
> > 7) After all files are loaded, match up the symbols and insert them
> > into the dependency chains, if any of the symbols depend on a branch
> > commit the symbol lies on the branch, otherwise the symbol is on the
> > trunk,
> > 8) Do a topological sort to build the change set commit tree
> > 9) when you hit a loop in the tree break up delta change sets until
> > the loop can be removed, don't break up symbol change sets.
> > 10) Mozilla has some large commits that were made over dial up. Commit
> > change sets can span hours. All of these commits need to be merged
> > into a single change set.
> > 11) An algorithm needs to be developed for detecting branches merging
> > back into the trunk
> > 12) cvs2svn has excellent test cases, use them to test the new
> > importer. The cvs2svn code is quite nice but it doesn't handle #7
>
> Most of this is possible now using cvs2svn, but it is not enough.
>
> But first there is a problem with your point #9.  It is in general not
> possible to avoid breaking up symbol changesets, even if you are willing
> to massacre the revision changesets.  CVS allows cases like this:

We don't know how often this case occurs until more alogirthms are
tried. All I know is that 60% of the Mozilla symbols end up needing
copies. And for the few cases I decoded things by hand I was able to
rearrange things so that copies were not needed. It is likely that
some symbols in Mozilla will need copies to construct them, it is a
question of degree, I don't believe copies are required for 60% of the
symbols.

>
> file1:
>
>     1.1
>     1.2 ----> branch "A"
>               1.2.0.1
>               1.2.0.2 ----> branch "B"
>
> file2:
>
>     1.1
>     1.2 ----> branch "B"
>               1.2.0.1
>               1.2.0.2 ----> branch "A"
>
> Clearly there is no way to create symbols "A" and "B" both in a single
> changeset.
>
> But even disallowing cases like the one above, it is often very
> questionable whether you want to avoid breaking up symbol commits at all
> costs.  For example, CVS allows
>
>
> January:     file1<1.1>               file2<1.1>
> February:    file1<1.1> tagged "T"
> March:       file1<1.2>
> November:                             file2<1.2>
> December:                             file2<1.2> tagged "T"
>
> In such a case, the only way to avoid splitting up the creation of tag
> "T" would be to pretend that the commit file1<1.2> didn't occur in March
> but rather in November.
>
> The bottom line is that cvs2svn should do a better job of handling
> symbols, but even then the git importer will necessarily have to deal
> with some unusual CVS cases.

The unusal cases can be made into branches. If I remember correctly
Mozilla has about 300 symbols with "BRANCH" in the name. But the
converted repositories are ending up with over 2,000 branches. When
you load this into the git visualization tools it is obvious that the
bowl of spaghetti caused by 2,000 branches is not a repository a human
would have created.

>
> > Processing the symbols is integral to deciding how to build the change
> > sets. Right now cvs2svn ignores the symbol dependency information and
> > builds the change sets in a way that forces the mini-branches. That
> > causes 60% of the 2,000 symbols in Mozilla CVS to end up as little
> > branches. Look at the three commit example in the other thread to see
> > exactly what the problem is.
> >
> > SVN hides the mini branch by creating a symbol like this:
> >
> > Symbol XXX, change set 70
> > copy All from change set 50
> > copy file A from change set 55
> > copy file B,C from change set 60
> > copy file D from change set 61
> > copy file E,F,G from change set 63
> > copy file H from change set 67
> >
> > It has to do all of those copies because the change sets weren't
> > constructed while taking symbol dependency information into account.
> >
> > Symbol XXX can't copy from change set 69 because commits from after
> > the symbol was created are included in change sets 51-69.
>
> The vast majority of the mixed-source symbol creations have nothing to
> do with honoring symbol dependencies, but rather with the fact the
> cvs2svn is not so clever about deducing which branch should be used as
> the source for a symbol (CVS often does not record this information
> unambiguously).
>
> Changes needed for git import:
>
> The symbol dependency problem that Jon has focused on is IMO just the
> least significant of three main changes that have to be made to support
> git output from cvs2svn:
>
> 1. The symbol dependency problem.  Occasionally symbols are created in
> an order that is inconsistent with the CVS dependency graph.  We want to
> fix this in any case (even for SVN).  Work done so far: the symbol
> dependency graph is already generated and recorded when the repository
> is parsed, and the symbol dependencies are carried through the
> conversion (though not yet used).
>
> 2. Symbols are often created using multiple branches as sources, when
> they could be created from a single branch.  This happens because in
> many cases CVS doesn't record unambiguously which branch was tagged, and
> cvs2svn's heuristics are not especially clever.  A patch has been
> submitted to fix this problem, but unfortunately it doesn't apply to
> HEAD anymore.  See
>
> http://cvs2svn.tigris.org/servlets/ReadMsg?list=dev&msgNo=1441
>
> for a discussion.  (The main difficulty with picking better sources for
> symbols is that the obvious approaches all require tons of intermediate
> storage.)  I am currently trying to understand symbol handling in
> cvs2svn well enough that I can port the patch to trunk.

I'm happy to give new alogorithm a try as they are developed.

>
> 3. The default current output format of cvs2svn is a single dump file
> with file revisions in commit order.  For the distributed SCMs, it is
> usually far more efficient to generate the file revisions file-by-file
> (non-chronologically) during the initial parse of the CVS files, and
> refer to the revisions by hash for the rest of the conversion.  In
> October I added a bunch of hooks to cvs2svn to make this possible.  Work
> remaining: code to reconstruct file text from CVS text + deltas,
> including proper handling of line-end conventions and keyword
> expansion/unexpansion, and of course the code to output the
> reconstructed snapshots in a git-consumable format.

This is a major benefit for git conversion, but it hasn't been a big
issues with the cvs2svn code. Hooks will be helpful.

-- 
Jon Smirl
