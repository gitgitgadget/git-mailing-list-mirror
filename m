From: Dov Grobgeld <dov.grobgeld@gmail.com>
Subject: Re: A basic question
Date: Thu, 11 Oct 2012 20:46:46 +0200
Message-ID: <CA++fsGFsNgNeRbd76OFnNhD2=hi6edz720u=m8ZK-eorir5dow@mail.gmail.com>
References: <001501cda711$8ab6f0a0$a024d1e0$@com>
	<1349897794.32696.15.camel@drew-northup.unet.maine.edu>
	<002801cda7d7$4792c260$d6b84720$@com>
	<CA++fsGFruWFauX3XkynwcRLqK9H16frW86of3Y3ScgzGFmz=dg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Drew Northup <drew.northup@maine.edu>,
	Skot Davis <skotd122@gmail.com>, git@vger.kernel.org
To: Jim Vahl <jv@wmdb.com>
X-From: git-owner@vger.kernel.org Thu Oct 11 20:47:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TMNmd-0003jw-Jn
	for gcvg-git-2@plane.gmane.org; Thu, 11 Oct 2012 20:46:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756551Ab2JKSqs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Oct 2012 14:46:48 -0400
Received: from mail-vc0-f174.google.com ([209.85.220.174]:64166 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754294Ab2JKSqr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Oct 2012 14:46:47 -0400
Received: by mail-vc0-f174.google.com with SMTP id fo13so2576966vcb.19
        for <git@vger.kernel.org>; Thu, 11 Oct 2012 11:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=RyLmGakQV77FjdOOcsoTqOwmQEFc8a560Hrl0keLQtE=;
        b=ncw43bojYw4N5VvijU41XhPED5ejUSjPu/eTnQ83ZhFbeoEX6fh6gOtQdJn5ygd+jG
         mGjXhxuRxJis1Q23au8ZiA4lMT//fQjb0ri6QmO7EoKWyu2Fd/V2Rb2fNWU0Ooj2I4wb
         Zr48BKJ+p8SobK6nc5D/FbgzDMKKuPEe/a/HirUqrOznzWnQIfa1CvjAtwc/UerCeb6m
         lLU+6krW/jBo3H3INUkFf7xDDYzuEk6f9Zzh2y77SIJ1G+D4KxGLXwTi4IrZwyZeLp3n
         bQjtR7SJK9Eyyl5MFFtyledh/OPds1yy5Q2s+NELNKhF0UFZsZ1nUAmwzLN24qpzocdt
         Y1Nw==
Received: by 10.52.33.130 with SMTP id r2mr825337vdi.43.1349981206792; Thu, 11
 Oct 2012 11:46:46 -0700 (PDT)
Received: by 10.58.146.73 with HTTP; Thu, 11 Oct 2012 11:46:46 -0700 (PDT)
In-Reply-To: <CA++fsGFruWFauX3XkynwcRLqK9H16frW86of3Y3ScgzGFmz=dg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207504>

The way you typically work with git (and with most other version
control systems) is that you have a fast changing trunk (in git often
called the master), where development is done. Once you want to
release you create a release branch off the trunk, and in that branch
you do regression testing and stability testing, and once you are
convinced that stability has been achieved, you make your release.

In parallel, and without in any way influencing your release branch,
your programmers happily commit to the trunk.

See e.g. the following excellent description of some workflow models:

http://nvie.com/posts/a-successful-git-branching-model/

Regards,
Dov

 On Thu, Oct 11, 2012 at 7:38 PM, Jim Vahl <jv@wmdb.com> wrote:
>
> Drew,
>
> Thanks for responding to my email!
>
> Yes, I did read most of the Book, although I admit that I skimmed over some
> of the more technical parts.  There is still a key part of how git is used
> in a commercial environment which I don't understand.
>
> When we release a new version of our product, it is comprised of over a
> hundred files.  Some of these files have not changed for years, and some
> have been revised/fixed/updated quite recently.  But what is key is that all
> of these components have passed a review and testing process.  A very
> important piece of information is what revision of each file made it into
> the release.
>
> I know that git takes snapshots of the repository as changes are made and
> that it is possible to reconstruct the file set at any point in time.  But
> unless rules or conventions are established, at any time the repository can
> contain files which are in the process of being modified and thus have not
> passed the testing process.  For the purpose of planning a release, we're
> interested only in the "most recently tested and approved" files.
>
> For the sake of argument, I'll assume that a committing a change implies
> that the file has passed the testing process.  So my questions are:
>
> 1) Does git have a built-in way to get a list of all of the "most recently
> committed" files only at a given point in time, thus automatically recording
> the revisions of all of the component files of a release?   This implies
> that for files which are being modified or which have been staged but not
> committed, that git would go back to find the "predecessor" file which had
> been committed.
>
>  2) Does git have a way of creating and exporting a list of the "most
> recently committed" files only?
>
> 3) If the answer to the above questions is "No", then what is the normal way
> for a programming shop which is using git to extract/assemble the list of
> approved files for building a release?
>
> Thank you.
>
> Jim Vahl
>
> -----Original Message-----
> From: Drew Northup [mailto:drew.northup@maine.edu]
> Sent: Wednesday, October 10, 2012 12:37 PM
> To: Jim Vahl
> Cc: git@vger.kernel.org; 'Skot Davis'
> Subject: Re: A basic question
>
> On Wed, 2012-10-10 at 11:03 -0700, Jim Vahl wrote:
> > All,
> >
> > Our company is researching version control software, something which
> > we have not used previously.  I have a very basic question about git
> > which I have not been able to answer from reading.  As I understand
> > it, a git repository can be a mixture of files which are under
> development, staged or committed.
> > If we make a new build of our product we will obviously only want to
> > include the committed (tested) files.
> >
> > The question is this: what is the usual procedure to retrieve a set of
> > committed  files only from the repository to place into a distribution
> > or "ready to build" folder.  The same question goes for tagging a
> > release: how does the user get the tag to reference the committed
> > files only and not the most recent files which may be under development or
> undergoing testing.
> >
> > Thanks,
> >
> > Jim Vahl
>
> Jim,
> Have you looked at http://git-scm.com/book yet? It sounds to me like you
> have some misconceptions about how Git works. (If so, did it leave you more
> or less confused?)
>
> --
> -Drew Northup
> ________________________________________________
> "As opposed to vegetable or mineral error?"
> -John Pescatore, SANS NewsBites Vol. 12 Num. 59
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
