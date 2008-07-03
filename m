From: Jonathan Nieder <jrnieder@uchicago.edu>
Subject: Re: [PATCH 3/7] Documentation: complicate example of "man git-command"
Date: Wed, 2 Jul 2008 20:45:59 -0500 (CDT)
Message-ID: <Pine.GSO.4.62.0807022010280.10323@harper.uchicago.edu>
References: <Pine.GSO.4.62.0806301650530.7190@harper.uchicago.edu>
 <Pine.GSO.4.62.0806301706090.7190@harper.uchicago.edu> <20080701162358.GA18305@fieldses.org>
 <7vmyl1kvn6.fsf@gitster.siamese.dyndns.org> <20080702213148.GA26921@fieldses.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Christian Couder <chriscool@tuxfamily.org>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Jon Loeliger <jdl@jdl.com>
To: "J. Bruce Fields" <bfields@fieldses.org>
X-From: git-owner@vger.kernel.org Thu Jul 03 10:25:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KEK7d-0002yW-1H
	for gcvg-git-2@gmane.org; Thu, 03 Jul 2008 10:24:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755110AbYGCG7T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jul 2008 02:59:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753407AbYGCG5b
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Jul 2008 02:57:31 -0400
Received: from smtp02.uchicago.edu ([128.135.12.75]:41431 "EHLO
	smtp02.uchicago.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752247AbYGCBqu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jul 2008 21:46:50 -0400
Received: from harper.uchicago.edu (harper.uchicago.edu [128.135.12.7])
	by smtp02.uchicago.edu (8.13.8/8.13.8) with ESMTP id m631k4k9008194;
	Wed, 2 Jul 2008 20:46:04 -0500
Received: from localhost (jrnieder@localhost)
	by harper.uchicago.edu (8.12.10/8.12.10) with ESMTP id m631jxCt011505;
	Wed, 2 Jul 2008 20:45:59 -0500 (CDT)
X-Authentication-Warning: harper.uchicago.edu: jrnieder owned process doing -bs
In-Reply-To: <20080702213148.GA26921@fieldses.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87244>

J. Bruce Fields wrote:

> On Tue, Jul 01, 2008 at 04:54:53PM -0700, Junio C Hamano wrote:
>
>> We would want to mention the typesetting convention early in the manuals
>> (git(7), gittutorial(7) and user-manual.html) as well, so how about...
>> 
>> 	Conventions used in this document
>>         ---------------------------------
>> 
>> 	When talking about a git subcommand 'cmd', this documentation
>> 	typesets the name of it like 'git-cmd', and that is the name you
>> 	ask for its manual page.
>> 
>>         Examples are typeset like this: `$ git cmd` (`$` is your command
>> 	prompt, do not actually type it to your shell).  Note that a
>> 	subcommand is specified as the first parameter to the 'git'
>> 	program when you actually run it from the command line.
> 
> I'm not convinced this last sentence is necessary.

I agree, but I think it doesn't hurt. I think the point was to
establish the word and concept "subcommand".

> > [example showing typographical conventions]
> 
> Typographical conventions shouldn't need so much explanation.

Yes, I suppose. I'm used to printed manuals having a page on
the meaning of different typefaces inside, but that's a bit
of a different situation.

> I'm curious: Jonathan, was this the original patch the result of a
> real-life instance of confusion?  What happened?

No, I'm actually a bit ashamed to have sent the patch... I was just
changing `git subcommand` to `git-subcommand` wherever it was the name
of a command, rather than the command line to run it, that was in
question. Consistency would have made the old example awkward, so I
looked around for alternatives.

Why worry about whether the man pages have no consistent rule about
dashes? Since it is not obvious why the man pages use the dashed form
when they do, I think a fraction of people will naturally use the
dashed form by default. That means trouble once Git 1.6.0 comes out
(e.g. see Ingo's recent post
<http://thread.gmane.org/gmane.comp.version-control.git/87012/focus=87020>).

Here's a patch implementing Junio's suggestion, because I do like it.
Please let me know what you think (especially ideas for making it
shorter).

Thanks for all your thoughts so far. Sorry I took so long to get back.

--- %< --- %< --- %< ----
Subject: gittutorial(7): add "Conventions used in this document" section
    
The manual page for the git subcommand invoked as "git clone" is
named git-clone(1), and similarly for the rest of the git
subcommands. This patch should make the convention a little
clearer when it is introduced at the beginning of gittutorial(7).

Thanks to Junio C Hamano for the idea and wording.

It remains to make an analogous change for user-manual.html
and maybe git(1).

Signed-off-by: Jonathan Nieder <jrnieder@uchicago.edu>
---
 Documentation/gittutorial.txt |   35 ++++++++++++++++++++++++++++++-----
 1 files changed, 30 insertions(+), 5 deletions(-)

diff --git a/Documentation/gittutorial.txt
b/Documentation/gittutorial.txt
index 036a27c..51ad814 100644
--- a/Documentation/gittutorial.txt
+++ b/Documentation/gittutorial.txt
@@ -19,12 +19,37 @@ If you are instead primarily interested in using
git to fetch a project,
 for example, to test the latest version, you may prefer to start with
 the first two chapters of link:user-manual.html[The Git User's Manual].
 
-First, note that you can get documentation for a command such as
-`git log --graph` with:
+Conventions used in this document
+---------------------------------
 
-------------------------------------------------
-$ man git-log
-------------------------------------------------
+When discussing a git subcommand 'cmd', this documentation
+typesets the name of it like 'git-cmd', and that is the name you
+ask for its manual page by.
+
+Examples are typeset like this: `$ git cmd`. (`$` is your command
+prompt; do not actually type it to your shell.) A subcommand
+is specified as the first parameter to the 'git' program
+when you actually run it from the command line.
+
+So a typical command description may go like this:
+
+To propagate the changes you made back to the original subversion
+repository, you would use the 'git-svn dcommit' command. It does
+these things (long description here).  Some examples:
+
+------------
+$ ... some example command sequence ...
+$ git svn dcommit
+------------
+
+For full details, type:
+
+------------
+$ man git-svn
+------------
+
+Introducing yourself to git
+---------------------------
 
 It is a good idea to introduce yourself to git with your name and
 public email address before doing any operation.  The easiest
-- 
1.5.5.GIT
