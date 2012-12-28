From: Woody Wu <narkewoody@gmail.com>
Subject: Re: Find the starting point of a local branch
Date: Fri, 28 Dec 2012 13:15:15 +0800
Message-ID: <20121228051514.GA4028@zuhnb712.ap.bm.net>
References: <20121224035825.GA17203@zuhnb712>
 <201212240409.qBO49wkV020768@no.baka.org>
 <20121224073103.GA10793@zuhnb712>
 <CANiSa6iSYvLbp1s8h9pwi=P1m0QdZPqf06hAm+4muChgJUuj=g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Seth Robertson <in-gitvger@baka.org>, git <git@vger.kernel.org>
To: Martin von Zweigbergk <martinvonz@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 28 06:17:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ToSJd-0008MG-L1
	for gcvg-git-2@plane.gmane.org; Fri, 28 Dec 2012 06:17:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750820Ab2L1FQr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Dec 2012 00:16:47 -0500
Received: from mail-pb0-f52.google.com ([209.85.160.52]:57586 "EHLO
	mail-pb0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750743Ab2L1FQq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Dec 2012 00:16:46 -0500
Received: by mail-pb0-f52.google.com with SMTP id ro2so5702299pbb.25
        for <git@vger.kernel.org>; Thu, 27 Dec 2012 21:16:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=A+de9jqH7luHzym47g+wkBgYqEyJbUTKzvM19IBoKos=;
        b=n8F51Nu/1TkpqahK82k7tJI6RR986Io3Rt3f4KRzRv2V5/VMgY6HruqNiUgV4JJAjW
         PArl85IueCxfKmgtUbmgAJuf/JWPgwQDJK8hFxcBmoecdoshpoxHvv8zPmYTR5OaZYpb
         ufAy93zXHPMn70+u1FfOkyPCpvNweie4AsS6fKLQeueGst/+ed0IYm7MpKheKq+T83rC
         2Y4eLmYfUBilP8xQLssXgROD+pJLy8Fz4OEpM4Eqggi4NdRa/kPgHW/8Z1DTCfGlwV3P
         14OFxliuKMBPdUNCLPPrSSKLTA9JEeabNiquyH6zSKdJp0eYavLnN4rvKmKnXLue6f0k
         yhlw==
X-Received: by 10.68.223.35 with SMTP id qr3mr102090192pbc.27.1356671805176;
        Thu, 27 Dec 2012 21:16:45 -0800 (PST)
Received: from localhost ([59.37.26.98])
        by mx.google.com with ESMTPS id f5sm19698643pav.22.2012.12.27.21.16.41
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 27 Dec 2012 21:16:44 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CANiSa6iSYvLbp1s8h9pwi=P1m0QdZPqf06hAm+4muChgJUuj=g@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212233>

On Mon, Dec 24, 2012 at 09:24:39AM -0800, Martin von Zweigbergk wrote:
> On Sun, Dec 23, 2012 at 11:31 PM, Woody Wu <narkewoody@gmail.com> wrote:
> > On Sun, Dec 23, 2012 at 11:09:58PM -0500, Seth Robertson wrote:
> >>
> >> In message <20121224035825.GA17203@zuhnb712>, Woody Wu writes:
> >>
> >>     How can I find out what's the staring reference point (a commit number
> >>     or tag name) of a locally created branch? I can use gitk to find out it
> >>     but this method is slow, I think there might be a command line to do it
> >>     quickly.
> >>
> >> The answer is more complex than you probably suspected.
> >>
> >> Technically, `git log --oneline mybranch | tail -n 1` will tell you
> >> the starting point of any branch.  But...I'm sure that isn't what you
> >> want to know.
> >>
> >> You want to know "what commit was I at when I typed `git branch
> >> mybranch`"?
> >
> > Yes, this is exactly I want to know.
> >
> >>The problem is git doesn't record this information and
> >> doesn't have the slightest clue.
> >>
> >> But, you say, I can use `gitk` and see it.  See?  Right there.  That
> >> isn't (necessarily) the "starting point" of the branch, it is the
> >> place where your branch diverged from some other branch.  Git is
> >> actually quite able to tell you when the last time your branch
> >> diverged from some other branch.  `git merge-base mybranch master`
> >> will tell you this, and is probably the answer you were looking for.
> >
> > This is not working to me since I have more than one local branch that
> > diverged from the master, and in fact, the branch I have in question was
> > diverged from another local branch.
> 
> As Jeff mentions in a later message, "git pull --rebase" would
> probably do what you want. It works with local branches too.
> 

I think what 'git pull --rebase' would do is to fetch from the origin
and do a 'git rebase'.  On one hand, I don't understand 'git rebase' so
much from the manual, ont the other hand, I did not get the point why
'git rebase' has something to do with the thing I want to do (what I
want is just query some kind of history information).

I know, my knowledge about git is still so limit. I will keep study from
the man pages.


> I once tried to add the same cleverness that "git pull --rebase"
> directly in "git rebase" [1], but there were several issues with those
> patches, one of was regarding the performance ("git pull --rebase" can
> be equally slow, but since it often involves network, users probably
> rarely notice). I think it would be nice to at least add it as an
> option to "git rebase" some day. Until then, "git pull --rebase" works
> fine.
> 
>  [1] http://thread.gmane.org/gmane.comp.version-control.git/166710

-- 
woody
I can't go back to yesterday - because I was a different person then.
