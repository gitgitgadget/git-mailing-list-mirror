From: "Avery Pennarun" <apenwarr@gmail.com>
Subject: Re: externals program, way to do svn:externals-like subproject management without git-submodule
Date: Sun, 14 Sep 2008 00:21:49 -0400
Message-ID: <32541b130809132121g53edc7b2k6b6b87c401bb704f@mail.gmail.com>
References: <853238710809131417v3818955sed4c0d3dd411a540@mail.gmail.com>
	 <32541b130809131517k6d1e5e4dsc5f72d54c7e71e55@mail.gmail.com>
	 <853238710809131806g327d41f9of307fcb29f5bc70c@mail.gmail.com>
	 <32541b130809132001s5eb79752y9d3a716490ae6c91@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Miles Georgi" <azimux@gmail.com>, "Git List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Sep 14 06:23:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kej8Z-0001Bx-VW
	for gcvg-git-2@gmane.org; Sun, 14 Sep 2008 06:23:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750866AbYINEVw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Sep 2008 00:21:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750813AbYINEVw
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Sep 2008 00:21:52 -0400
Received: from mail-gx0-f16.google.com ([209.85.217.16]:62788 "EHLO
	mail-gx0-f16.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750811AbYINEVv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Sep 2008 00:21:51 -0400
Received: by gxk9 with SMTP id 9so22131270gxk.13
        for <git@vger.kernel.org>; Sat, 13 Sep 2008 21:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=jBNFgKJAAGU1e+wRmXJY4XWZCbibkPsiM0spseCh7Xo=;
        b=PUFXp7Ocp0VgxmLmG0w6rzKpF8s5pW94shI53dkdooFW1pUfK/nfbak//+oByyRclE
         6z40RpHP1IDE6Ts8D6TzbNjvBU5PNzaI805dTcaRRlXYVClenvjaKD4UO/B6XFVIpUKI
         5kv7ouknQL2/VUibBTSf5YpUL0qWbTOtwwvtY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=cWWThAfx3IAInbXpmsh9m31g2GW9WY6vJvXuiAqSJS2Y3Y9mLwl1WFo3xe1QjBmdHw
         xUXcVJMHf4rX7WWC+wz6iPY0wEhP78URuQiiCLrktyiQKK1USCRWboQMFAxkdgUTXV2C
         gcM8FggCy/vBOhGn0/Lv5ML87KNA92YhoK+8w=
Received: by 10.150.51.2 with SMTP id y2mr8611040yby.42.1221366109999;
        Sat, 13 Sep 2008 21:21:49 -0700 (PDT)
Received: by 10.150.96.5 with HTTP; Sat, 13 Sep 2008 21:21:49 -0700 (PDT)
In-Reply-To: <32541b130809132001s5eb79752y9d3a716490ae6c91@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95820>

On Sat, Sep 13, 2008 at 9:06 PM, Miles Georgi <azimux@gmail.com> wrote:
> I'll just answer by numbers, I hope it's not too inconvenient to have
> to scroll between emails to see which point I'm talking about :/

In general, it's better to use inline quoting.  It's okay if the
quotes get long, because long messages are manageable, but messages
that require you to look at *other* messages at the same time are just
a PITA.  Luckily, however, I at least remember what we're talking
about :)

> 1.  Oh, I'm not really aware of what "cvs export" does.  I assumed it
> meant something very similar to "svn export"  Running "ext export URL"
> on a project manage by subversion with all the subprojects managed by
> subversion simply runs "svn export URL" followed by an "svn export"
> for each subproject, hence the name.  Calling it "shallow" makes sense
> for git since I'm using --depth 1, but since "svn export" doesn't
> create the .svn directories necessary to make it a working directory,
> I don't really know if I would call that shallow.  For git's
> implementation of export, I was thinking of just doing a clone and
> then deleting .git/ which also wouldn't be shallow.

Aha, sorry.  In that case, it does do exactly what cvs export and svn
export do, so I take it back.  I would never use it (because I always
deploy my .git directories along with the app itself... free
backups!).  But the name is correct.

> 3.  I am also bothered by the inconsistency of the meaning of [main]
> and [git/svn] along with everything you pointed out.
>
> Question?  Is it okay to have "/" characters in the ini section name?

Yes.  In general, a section name can have anything except a ] in it,
and a key can have anything but an = in it.  (Well, obviously we
should expect that there are no CR, LF, or NUL characters either.)

If you want to do it exactly like git, you would name your sections like

   [ext "libs/my/plugin"]

instead of my earlier suggestion of

  [libs/my/plugin]

This would be compatible with git-config.  Also, this method means
that the [main] section could never be confused with a particular ext
section.

> I wonder if it would be okay to just put the repository
> as the section name.  That way scm and path could be excluded for
> situations where the defaults are sufficient.  Although I guess this
> would have the implication of changing a projects repository
> (something that happens way more frequently than changing the path
> it's installed to) some what messy since it's being identified by its
> repository.

I think you answered your own question there :)  Personally, it feels
natural to me to index a submodule by its local path, and have the URL
be an attribute of that submodule, rather than the other way around.
This makes sense since every local path can only have one submodule on
it, while in insane situations, you can imagine having exactly the
same repo (perhaps different revisions or branches?) cloned into two
different locations.

> But yeah, if this feature makes somebody nervous, they can just always
> explicitly give the path (which they'll have to do if it's not a rails
> app.)  It also detects that it's a rails app so it will complain if
> you leave the path off in a non-rails app.  It won't try to put
> something in vendor/plugins of a non-rails app just because a path is
> missing.

Okay, if it's not in rails mode, I guess it won't cause problems... as
long as the rails auto-detection is extremely reliable and can be
turned off somehow.

> 5.  Yeah that's a good idea.  I could create a command that adds an
> existing subproject to the .externals and updates the ignore properly.
>  To get this effect at the moment, one would manually add the
> subproject to .externals and run "ext update_ignore"  I personally
> don't usually find myself doing this though.  I almost always want the
> subproject to be added to the project.  I need to make an "ext
> uninstall" for backing out if you don't like it.  I personally would
> rather manually remove the item from .externals than have to issue two
> commands to install it.  But your idea of a save command is very
> powerful, especially with the branch switching ideas you have in #8
> below.

Right, it wouldn't matter which way you did it, but the other options
below fit really nicely into a 'git save' operation.

Also, I personally think it's more elegant to not have to do "undo"
operations as a normal part of your workflow.  Checkout work work work
save seems nicer to me than Checkout uninstall work work work.

[nested submodules]
> 6.  Hey that's a pretty interesting idea!  I hadn't even thought about
> that as I have not yet personally encountered that use case.  I've
> been hoping that rails plugins could have their own vendor/plugins
> directory because if they did I would also use something like that all
> the time.  This is definitely something that should be implemented at
> some point.

Well, like I said, I'm doing it right now in one of my projects :)
But it doesn't have to be a high priority.

> 7.  Agreed (for the most part.)  I almost never want to do this for my
> own projects as I almost always want the branch tip no matter what.
> I'd rather run tests and discover that something has broke before
> deploying than have to go to all my projects and advance the commit
> manually.

Ouch, I would never want to do it that way!  If my app has been
deployed for three months and someone reports a minor bug, I just want
to fix that one bug and redeploy safely and immediately. I certainly
don't want to risk breaking everything by upgrading a bunch of
unrelated modules.

> the way I
> currently have been handling this is by having my own rails repository
> at git://github.com/azimux/rails.git that I occaisionally will merge
> rails/rails.git with and run tests for my larger applications.  If I
> like how it behaves I push the merged tip back out to azimux/rails.git
> which is what all my projects reference in their .externals file.

This sounds like a convoluted way of just doing what I suggested. :)

Oh, that reminds me of another feature that would be awesome:
*alternate* repository URLs.  In your example above, let's say you've
made some rails customizations, anyone cloning your project will have
to get your version.  But one day, the rails developers merge in your
changes, so now their primary repo (probably with more bandwidth,
uptime, etc) will work again.  If the ext lists *all* the repositories
you might need, ext can just git fetch from all of them, then checkout
the commit in question, and it will always work.

> And I would definitely not
> have it disconnected from a branch if it can be avoided.  I guess it
> would checkout a specific commit but be on a branch, and then if the
> developer needed to edit the subproject, they would realize it was
> non-fastforward when they pushed and then do a rebase against the
> current tip?  I'm not 100% sure how this workflow would normally occur
> as I've not yet had to rebase anything, and when I was using
> git-submodule, I would always checkout a branch tip if I had to edit
> the subproject and then would do a git add submodule/path to point at
> the new commit when I was done.

It can be simpler than that.  Essentially, what you do is:

   git fetch origin
   git checkout COMMITID
   git branch -D BRANCHNAME
   git checkout -b BRANCHNAME

The first checkout puts you on a disconnected HEAD temporarily, just
in case you were previously on a branch called BRANCHNAME, which would
have prevented the "delete branch" operation from working.  Then we
delete the branch, and recreate it at the new location (COMMITID).

With that in place, git will know how to do everything else
automatically, but it's up to the user.  You can pull/merge the latest
changes from another branch, or rebase, etc.

Note that as a safety measure, you probably want to refuse to actually
do the above if either of:
a) The git filesystem or index shows uncommitted files
b) The current git commit != the commit ext thinks is checked out right now.

> 9.  I wasn't planning on having any sort of commit/push-type features
> since the workflows of the SCMs are different when it comes to
> commiting/pushing.  For example, if it's a subversion project it needs
> to do an "svn commit" requiring a log message.  And sometimes I really
> only want to push a subset of the subprojects that I've modified.

I think it would be really cool if ext could just figure this out.
For example, it's easy to tell that in svn, your changes have to be
committed (ie. no dirty tree) and in git, the upstream repo needs to
contain your commitid (it's been pushed).

If you only want to push a subset of projects, that's fine, but you
can do it in the individual subdirs by hand anyhow.  On the other
hand, I'd say you *don't* want to ever push the parent repo without
first pushing all your changes, particularly if you have the commitid
encoded in the .externals file, or you'll produce an un-checkout-able
repository.

> Maybe what I could do is have "ext status" also see if a subproject
> could be pushed and issue a warning like "<subproject> has commits
> that are missing from <remote name>.  Did you forget to push?"  This
> would be unnecessary for subversion managed subprojects as if it's up
> to date, then it's pushed and vice versa, but for git it would be very
> helpful for when the status is empty due to commits being performed,
> but is not yet pushed out to it's origin.

Yes, that would be almost as good.

>  I don't know if I would
> like it automatically doing the pushing though, but it could be
> doable, maybe with a command with the name "git" in it to specify it's
> scm specific, like "ext gitpush" or I could just have an "ext push"
> that does nothing for svn/cvs projects.

I don't think it should do nothing for svn/cvs projects: it should
either help you commit, or abort with a helpful message if your repo
is dirty, or something like that.

Hope this helps.

Have fun,

Avery
