From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: GSOC Proposal draft: git-remote-svn
Date: Tue, 10 Apr 2012 12:17:07 -0500
Message-ID: <20120410171707.GA3869@burratino>
References: <11292500.AVmZFUUvNi@flobuntu>
 <2148933.pnpYo0xMAP@flomedio>
 <2487557.B8qfnaixh3@flomedio>
 <1421035.yALBSXSHGd@flomedio>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	David Barr <davidbarr@google.com>,
	Andrew Sayers <andrew-git@pileofstuff.org>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Dmitry Ivankov <divanorama@gmail.com>
To: Florian Achleitner <florian.achleitner2.6.31@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 10 19:17:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SHeh8-0004kb-Tc
	for gcvg-git-2@plane.gmane.org; Tue, 10 Apr 2012 19:17:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753459Ab2DJRRZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 Apr 2012 13:17:25 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:38526 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751913Ab2DJRRY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Apr 2012 13:17:24 -0400
Received: by obbtb18 with SMTP id tb18so33990obb.19
        for <git@vger.kernel.org>; Tue, 10 Apr 2012 10:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=AQxy2EzOC1KAdQjFdjL+Os3Ge2EQMm4+XhySAmroj2s=;
        b=uCLJHxAlJy7wt5gyUWQuEpSu+HRtABiYroZzl9Wp9f7OMEQ+Q0xG1xCkhl54stkwla
         Q105/ZlQ/I+iBhaT9EIXwyXNJ4EecDpVHAOugfnH/3VOo76kEmYLFNX4UCfiTd0JoZje
         KkzDcVxmvGecfTOa5Ymon4sRtPcTu0PAV/H+PKd7zpge2dgv5Pq9ZMHTmfbY+anyT2EJ
         B/x5is91XZe95ZsGmxT6+dKyLYY3ANDTfgOBJ8BjEKyj85GQBmPMJgmAMOjgcrdDkZMC
         PacQ6RIN54jXNIx4g46b8UNovt57/olIfKMuTkV4BJU8cG7K/99dvzQMjuqZR84rRS+G
         5JqQ==
Received: by 10.182.110.102 with SMTP id hz6mr17017470obb.58.1334078244230;
        Tue, 10 Apr 2012 10:17:24 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id s8sm16081162oec.1.2012.04.10.10.17.13
        (version=SSLv3 cipher=OTHER);
        Tue, 10 Apr 2012 10:17:14 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1421035.yALBSXSHGd@flomedio>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195107>

Hi,

=46lorian Achleitner wrote:

> Thanks for your inputs. I've now submitted a slightly updated version=
 of my=20
> proposal to google. Additionally it's on github [1].
>
> Summary of diffs:
> I'll concentrate on the fetching from svn, writing a remote helper wi=
thout=20
> branch detection (like svn-fe) first, and then creating the branch ma=
pper.

Thanks for the update.

If I understand correctly, the remote helper from the first half would
do essentially the same thing as Dmitry's remote-svn-alpha script.
Since in shell script form it is very simple, I don't think it should
take more than a couple of days to write such a thing in C.

> Timeline
>
> GSoC timeline and summer holidays
> Summer holidays in Austria at 9th of July. So until the mid-term
> evaluations my git project will have co-exist with my regular
> university work and projects. But holidays extend until the beginning
> of October, so there=E2=80=99s some time left to catch up after the o=
fficial
> end of GSoC.

Another possibility that some people in similar situations have
followed is to start early.  That works a little better since it means
that by the time midterm evaluations come around we can have a
reasonable idea of whether a change in strategy is needed for the
project to finished on time.

> I plan to split the project in two parts:
>
> Writing the remote helper using existing functions in vcs-svn to
> import svn history without detecting branches, like svn-fe does.
> Milestone: 9th of July, GSoC mid-term
>
> Writing a branch mapper for the remote helper that reads the config
> language (SBL) and imports branches trying to deal as good as possibl=
e
> with all the little pitfalls that will occur. Milestone: 20th of
> August, GSoC end

Could you flesh out this timeline more?  Ideally it would be nice to
have a definite plan here, even to the point of listing what patches
would need to be written, so during the summer all that would need to
happen is to execute and deal with bugs as they come.

Given the goal described here of an import with support for
automatically detecting branches, here are some rough steps I imagine
would be involved:

 . baseline: remote helper in C

 . option to import starting with a particular numbered revision.
   This would be good practice for seeing how options passed to
   "git clone -c" can be read from the config file.

 . option or URL schema to import a single project from a large
   Subversion repository that houses several projects.  This would
   already be useful in practice since importing the entire Apache
   Software Foundation repository takes a while which is a waste
   when one only wants the history of the Subversion project.

   How should the importer handle Subversion copy commands that
   refer to other projects in this case?

 . automatically detecting trunk when importing a project with the
   standard layout.  The trunk usually is not branched from elsewhere
   so this does not require copyfrom info.  Some design questions
   come up here: should the remote helper import the entire project
   tree, too?  (I think "yes", since copy commands that copy from
   other branches are very common and that would ensure the relevant
   info is available to git.)  What should the mapping of git commit
   names to Subversion revision numbers that is stored in notes say
   in this case?

 . detecting trunk and branches and exposing them as different remote
   branches.  This is a small step that just involves understanding
   how remote helpers expose branches.

 . storing path properties and copyfrom information in the commits
   produced by the vcs-svn/ library.  How should these be stored?
   For example, there could be a parallel directory structure
   in the tree:

	foo/
		bar.c
	baz/
		qux.c
	.properties/
		foo.properties
		foo/
			bar.c.properties
		baz/
			qux.c.properties

   with properites for <path> stored at .properties/<path>.properties.
   This strawman scheme doesn't work if the repository being imported
   has any paths ending with ".properties", though.  Ideas?

 . tracing history past branch creation events, using the now-saved
   copyfrom information.

 . tracing second-parent history using svn:mergeinfo properties.

In other words, in the above list the strategy is:

 1. First convert the remote helper to C so it doesn't have to be
    translated again later.

 2. Teach the remote helper to import a single project from a
    repository that houses multiple projects (i.e., path limiting).

 3. Teach the remote helper to split an imported project that uses
    the standard layout into branches (an application of the code
    from (2)).  This complicates the scheme for mapping between
    Subversion revision numbers and git commit ids.

 4. Teach the SVN dumpfile to fast-import stream converter not to
    lose the information that is needed in order to get parenthood
    information.

 5. Use the information from step (4) to get parenthood right for a
    project split into branches.

 6. Getting the second parent right (i.e., merges).  I mentioned
    this for fun but I don't expect there to be time for it.

Does that seem right, or does it need tweaks?  How long would each
step take?  Can the steps be subdivided into smaller steps?

Another question is: what is the design for this?  With the existing
remote-svn-alpha script, there are a few different components with
well defined interfaces:

	commands like "git fetch"
	  |
	  | (1)
	  |
	transport-helper --- (2) --- git fast-import
	  |                               |
	  | (2, 3)                        |
	  |                               |
	remote-svn-alpha                  | (3)
	  |             ''..              |
	  | (2)             ''(2)..       |
	  |                        ''..   |
	svnrdump --------- (3) -------- svn-fe

 (1) communicates using function calls and shared data
 (2) launches
 (3) communicates over pipe

Once remote-svn-alpha is rewritten in C, the same structure is still
present, though it might be less obvious because some of the (2)
and (3) can change into (1).

Where does the functionality you are adding fit into this picture?
Are there any new components being added, and if so what do they take
as input and output?

Hope that helps,
Jonathan

> [1] https://github.com/flyingflo/git/wiki/
