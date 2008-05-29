From: "John J. Franey" <jjfraney@gmail.com>
Subject: Re: [DOC-PATCH] Clarify description of <repository> argument to
	pull/fetch for naming remotes.
Date: Wed, 28 May 2008 21:43:43 -0400
Message-ID: <1212025423.9160.78.camel@isidore.myhome.westell.com>
References: <1211986774.9160.12.camel@isidore.myhome.westell.com>
	 <7vfxs2teua.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
To: Junio C Hamano <junio@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 29 03:44:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K1XC1-0007Vo-Jv
	for gcvg-git-2@gmane.org; Thu, 29 May 2008 03:44:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753643AbYE2Bno (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 May 2008 21:43:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753597AbYE2Bno
	(ORCPT <rfc822;git-outgoing>); Wed, 28 May 2008 21:43:44 -0400
Received: from an-out-0708.google.com ([209.85.132.245]:17126 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753401AbYE2Bnn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 May 2008 21:43:43 -0400
Received: by an-out-0708.google.com with SMTP id d40so17565and.103
        for <git@vger.kernel.org>; Wed, 28 May 2008 18:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:x-mailer:content-transfer-encoding;
        bh=zyYTOvAnd0Fke+JjbIr3ltpLh70/Jpfslrj/WzEaD9M=;
        b=TWDYAkOpqP2OjMGRF/MtP8modB66lhGWFylaU/VZY4ucW5PkLcfb08pBGCeranVIPMaUs/8YbkAYx7glEdoIP2fEkRgAtFdNyz18blXAplA2SQp44tmQF4WPE6RwWBHRZCcRDjp+eOLO+K9IHXr1W86J9GpEIxItN5G4q3VfgtQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:x-mailer:content-transfer-encoding;
        b=RSz3a6WeJ0axGVcQ4e5ZFP8Y8IwnRHqe374IyOZ5oppTvXH7K+glGgw92mrkY/hlk5pYR6I+dJlzFKu9+WJho7yXqiPGh3YLN8Vc4CcGJKTO1bqWPv7Ood7wnVhLG8VYS/em8TW48udfwB8VEvf4GUWroHuFI1n1NlPYP4Us0gE=
Received: by 10.100.41.9 with SMTP id o9mr5167495ano.84.1212025422495;
        Wed, 28 May 2008 18:43:42 -0700 (PDT)
Received: from ?192.168.2.102? ( [70.21.168.140])
        by mx.google.com with ESMTPS id c29sm97901anc.38.2008.05.28.18.43.41
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 28 May 2008 18:43:41 -0700 (PDT)
In-Reply-To: <7vfxs2teua.fsf@gitster.siamese.dyndns.org>
X-Mailer: Evolution 2.22.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83164>

On Wed, 2008-05-28 at 12:21 -0700, Junio C Hamano wrote:
> "John J. Franey" <jjfraney@gmail.com> writes:
> 
> > Signed-off-by: John J. Franey <jjfraney@gmail.com>
> > ---
> >  Here is proposal for the git-fetch(1) and git-pull(1)
> >  man pages.  As a newbie, I found the original a bit
> >  too awkward to understand readily.  I hope this is
> >  helpful.
> 
> While I do like making visual distinction to separate different things
> into different sections as a general rule (unless each section ends up
> with too little information), I think this is almost on the borderline.

> >  Alter description of <repository> in OPTIONS section to
> >  explicitly state that a 'remote name' is accepted.
> >
> >  Rewrite REMOTES section to more directly identify the
> >  different kinds of remotes permitted.
> 
> I think you meant to place these two paragraphs in the commit log message,
> so they should come before your Sign-off and three-dash lines.


I didn't mean to put these in the commit log message.  I will if that is
what you are recommending me to do.  These comments were only meant to
explain the changes to you and others on the mailing list.

> 
> >  Documentation/pull-fetch-param.txt |    4 ++-
> >  Documentation/urls-remotes.txt     |   65 ++++++++++++++++++++---------------
> >  2 files changed, 40 insertions(+), 29 deletions(-)
> >
> > diff --git a/Documentation/pull-fetch-param.txt b/Documentation/pull-fetch-param.txt
> > index b6eb7fc..cbee369 100644
> > --- a/Documentation/pull-fetch-param.txt
> > +++ b/Documentation/pull-fetch-param.txt
> > @@ -1,6 +1,8 @@
> >  <repository>::
> >  	The "remote" repository that is the source of a fetch
> > -	or pull operation.  See the section <<URLS,GIT URLS>> below.
> > +	or pull operation.  This parameter can be either a URL
> > +	(see the section <<URLS,GIT URLS>> below) or the name
> > +	of a remote (see the section <<REMOTES,REMOTES>> below).
> 
> Ok, I often see this referred to as "short-hand" or "nickname", but you
> chose to use "the name of a remote", which is more descriptive.

'name of a remote' is meant to draw connection with the parameter 'name'
of 'git-remote(1)', and the config variables 'remote.<name>.*' described
in 'git-config(1)'.  'short-hand' and 'nickname' are correct but didn't
lead me to recognize that its the same as git-remotes's <name>.  The
light came on when I finally saw that 'short-hand' wasn't actually an
abbreviation or alternate name, but really *the very* name of a file or
remote (which git reads/access to obtain a URL).

> 
> > diff --git a/Documentation/urls-remotes.txt b/Documentation/urls-remotes.txt
> > index 5dd1f83..31e542d 100644
> > --- a/Documentation/urls-remotes.txt
> > +++ b/Documentation/urls-remotes.txt
> > @@ -1,11 +1,21 @@
> >  include::urls.txt[]
> >  
> > -REMOTES
> > --------
> > +REMOTES[[REMOTES]]
> > +------------------
> >  
> > -In addition to the above, as a short-hand, the name of a
> > -file in `$GIT_DIR/remotes` directory can be given; the
> > -named file should be in the following format:
> > +The name of one of the following can be used instead of a URL as <repository> argument:
> > +
> > +* a file in the `$GIT_DIR/remotes` directory,
> > +* a remote in the git configuration file: `$GIT_DIR/config`, or
> > +* a file in the `$GIT_DIR/branches` directory.
> 
> Ok.  However, because a remote configured in the configuration file takes
> precedence (it is the youngest invention) over $GIT_DIR/remotes/ which in
> turn takes precedence over $GIT_DIR/branches/, we probably would want to
> move the bullet list and the sections around to talk about the config
> first, then remotes, and then finally branches, in this document.
> 

Will do.

> > +Named files in `$GIT_DIR/remotes`
> > +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > +
> > +If <repository> is the name of a file in the `$GIT_DIR/remotes` directory,
> > +the file should have the following format:
> 
> This also sounds somewhat awkward to me.  "If you do X, Y has to be Z" has
> a funny connotation that "On the other hand, if you don't, Y does not have
> to follow this rule", but that is not what is going on here.  We only want
> to say "You could choose to do X, and here are the rules..."  So how
> about...
> 
>         You can use a file in `$GIT_DIR/remotes/<remote>` to name the remote
>         repository <remote>.  The file should be in the following format:
> 
> Same comment applies to other two sections.

Ok.  I see what you mean.  I'm striving to retain the connection that
<repository> is in fact the name of the remote in config file, or the
name of a file (in either directory).  How about:

-- configured remotes section --

	You can provide the name of a remote which you had previously
	configured using git-remote(1), git-config(1) or even by an
	edit to the `$GIT_DIR/config` file.  See <link to man pages> for
	details.  The entry in the config file would appear like this:

--- remotes directory section --

	You can provide the name of a file in `$GIT_DIR/remotes`.  The
	file would contain the URL of the remote repository and should
	have the following format:

--- branches section --

	You can provide the name of a file in `$GID_DIR/branches`.  The
	file would contain the URL of the remote repository and
	should have the	following format:

> 
> > @@ -14,15 +24,16 @@ named file should be in the following format:
> >  
> >  ------------
> >  
> > -Then such a short-hand is specified in place of
> > -<repository> without <refspec> parameters on the command
> > -line, <refspec> specified on `Push:` lines or `Pull:`
> > -lines are used for `git-push` and `git-fetch`/`git-pull`,
> > -respectively.  Multiple `Push:` and `Pull:` lines may
> > +`Push:` lines are used by `git-push` and
> > +`Pull:` lines are used by `git-pull` and `git-fetch`.
> > +Multiple `Push:` and `Pull:` lines may
> >  be specified for additional branch mappings.
> 
> I see that the original has a typo "s/Then/When/".
> 
> The rewrite drops an important piece of information that these Push/Pull
> lines take effect _only when_ the nickname (eh, "the name of the remote")
> is given on the command line without explicit refspecs.
> 

ok; will restore that information.

> > +Named remote in configuration file
> > +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > +
> > +If <repository> is the name of a remote entry in the git configuration file,
> > +the entry might look like this:
> 
> Similarly...
> 
>         A `[remote "<remote>"]` section in the configuration file can be used to
>         name the remote.  The section will look like this:

> >  ------------
> >  	[remote "<remote>"]
> 
> In addition...
> 
>         Similar to the `$GIT_DIR/remotes/<repository>` push/fetch give the
>         default refspecs when none is given on the command line.
> 

OK.  Got it.

> > +Note the use of `fetch` instead of `Pull:` (a distinction from the format described above).
> > +See linkgit:git-remote[1] or linkgit:git-config[1] for details.
> 
> Iff you really need to stress mismatch, after reordering the sections, you
> could point out that `$GIT_DIR/remotes` file uses "Pull" instead of more
> natural "fetch", which is a historical accident.
>  

OK.  Will do.  If you don't think the mismatch needs to be stressed, I
can remove it altogether.  I don't think the emphasis is needed.


Thank you for taking the time to look at this.

Regards,
John
