From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: Ideas for qgit
Date: Fri, 23 Jun 2006 20:12:26 +0200
Message-ID: <e5bfff550606231112l6ca67799m7dddfabcee055045@mail.gmail.com>
References: <1151035711.25640.6.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 23 20:12:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ftq8t-00039e-ST
	for gcvg-git@gmane.org; Fri, 23 Jun 2006 20:12:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751862AbWFWSM2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Jun 2006 14:12:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751863AbWFWSM2
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Jun 2006 14:12:28 -0400
Received: from py-out-1112.google.com ([64.233.166.178]:55915 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751862AbWFWSM1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jun 2006 14:12:27 -0400
Received: by py-out-1112.google.com with SMTP id b36so583252pyb
        for <git@vger.kernel.org>; Fri, 23 Jun 2006 11:12:27 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=WQbys9CQOSChVI85uD+9QXJr0QcFByOz0uRMxN8yVFz3f3QjF/fetF5xSrIrf29JllYjg72LlRuum2Uxlww+2KnKKwtVOrfiw8+APaq8Me7Dx6kpvS5WLYAUyBB+HSbTt8uOky4Ln2My+fGbVFimfB++Z6CBnD1wgvfjyWIY5ik=
Received: by 10.35.89.10 with SMTP id r10mr2575724pyl;
        Fri, 23 Jun 2006 11:12:27 -0700 (PDT)
Received: by 10.35.95.9 with HTTP; Fri, 23 Jun 2006 11:12:26 -0700 (PDT)
To: "Pavel Roskin" <proski@gnu.org>
In-Reply-To: <1151035711.25640.6.camel@dv>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22433>

On 6/23/06, Pavel Roskin <proski@gnu.org> wrote:
> Hi, Marco!
>
> As promised, here's what I would like to see in qgit:
>
> 1) Bookmarks or quick tags (qtags).  It may be useful to mark some
> commits to make it easier to navigate qgit.  Yet I don't want them to
> mix with real tags.  Perhaps qgit could save them separately, e.g.
> in .git/refs/qtags to facilitate navigation.  qtags should appear
> separately in the popup menu.
>

Currently we have two types of tags, signed and simple. If it is
possible I would really like to stay with git tags, because bookmarks
seems to me like reinventing the (broken) wheel.

Git is very good in tagging and untagging and IMHO we should stay with
them, perhaps in the simple version. I really don't see any advantage
nor immediate and less in the long term to almost duplicate that
functionality and loosing proven git native tag handling features.

> 2) The "Patch" tab should be redesigned so that the diff can be shown
> against the parent or against head/tag/qtag.  Users are not supposed to
> enter SHA1.  If they have to, then it only confirms that qgit needs
> qtags.
>

Well, you can write also a ref name in SHA1 field. Try with
"v2.6.17-rc6" or "v1.4.0".
Perhaps this should be better documented and the SHA1 name is misleading.

> 3) It would be nice to have some minimal navigating capabilities on the
> Patch tab.  At least it should be possible to go up and down the
> revision list and go to any head/tag/qtag/stgit patch.  It would
> eliminate the need to switch to the "Rev list" too often.
>

This make me think of biting the bullet and append patch information
_also_ below revision description, yes, a la gitk. I think this is
really what you feel is missing.

> 4) Some bisect support would be nice, at least as good as in gitk.
> Actually, I'm not using bisect too much, but it's probably because I'm
> not debugging Wine these days.  Everything else is intelligible :-)
>

I don't use bisect and I don't know the gitk implementation.
I will investigate when I found some time. Not a top priority, at
least for my kind of workflow ;-)

> 5) Branch view based on reflog.  Probably there should be an interface
> allowing to limit the displayed revisions to one branch.  I think qgit
> should still load all revisions that it loads now, but if users start
> complaining about performance too much, maybe qgit should have an option
> to load only the logged branch.  The problem is that some parents will
> be unavailable in the view.
>

I think I didn't understand this. Isn't there command line arguments
for narrowing loaded revision set?

> 7) qgit command line should be documented.  "qgit --help" should display
> help on stdout.
>

All the stuff in command line is sent directly to git-rev-parse. I
think this is good because avoids any overlapping between qgit and git
options and guarantees future compatibility with _any_  git option.

Again, being qgit a GUI tool we could avoid some command line only
application's habits. In the latter case there's nothing better to do,
but we can run a nicely formatted handbook in an independent window
just pressing F1 and be sure to never mess with any current and future
possible git option.

        Marco
