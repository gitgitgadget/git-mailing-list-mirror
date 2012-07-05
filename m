From: Phil Hord <phil.hord@gmail.com>
Subject: Re: [PATCH] push: don't guess at qualifying remote refs on deletion
Date: Thu, 5 Jul 2012 11:32:55 -0400
Message-ID: <CABURp0r8EfShHVE-Vycz3g8-WPXFzs1-WOT7LRwh-XOuWVYG+Q@mail.gmail.com>
References: <CAKON4OwnUKQ6MT8HBNDyfhZLZS5xGKA2Ss1krY9OQGG1gaFhDw@mail.gmail.com>
 <7vsjd9wkek.fsf@alter.siamese.dyndns.org> <CAKON4OxBo7XiF5c60oyEUMR1xCh16n5BZCz-mmcUc0V9X7D32A@mail.gmail.com>
 <20120703180439.GC3294@sigill.intra.peff.net> <CAKON4Oy0YBVTAhZPU=1B=yYY4t2O_uRWDW1zOMaC5iCb=kRQ2w@mail.gmail.com>
 <20120703184018.GB5765@sigill.intra.peff.net> <1341386512.3871.4.camel@flaca.cmartin.tk>
 <CABURp0rVPAvxP1sp_nmoNYd+F+OsvWeHgUAeo7-VTnQhdebFeg@mail.gmail.com> <1341472926.10752.5.camel@flaca.cmartin.tk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jeff King <peff@peff.net>,
	"jonsmirl@gmail.com" <jonsmirl@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: =?ISO-8859-1?Q?Carlos_Mart=EDn_Nieto?= <cmn@elego.de>
X-From: git-owner@vger.kernel.org Thu Jul 05 17:33:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Smo3X-0006UA-Oo
	for gcvg-git-2@plane.gmane.org; Thu, 05 Jul 2012 17:33:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755909Ab2GEPdR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Jul 2012 11:33:17 -0400
Received: from mail-gg0-f174.google.com ([209.85.161.174]:63476 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752286Ab2GEPdQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jul 2012 11:33:16 -0400
Received: by gglu4 with SMTP id u4so7504506ggl.19
        for <git@vger.kernel.org>; Thu, 05 Jul 2012 08:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=CLNhDvA8fCkPXHdTf/UWJ+KIczb4wWnZO/wN188s3Tg=;
        b=AXByXuiMb9rRlxTj585AoEOZoXZgLudMDT02gRzi20V1BiQDb5yOwFfzG/wS14GkVL
         cm/U6vTIxnL7/N9xlylJ4BdLe4+qvCAEEaymNvuFhK1wwiZ+C4V7q3glm/EK6RGXe8eQ
         u1QgdcN8IV0EHEUBvy03EYE5I6c4VLCL7VVO73E11/CrxXGAMzFUr0BrpX+gn9CnR/CJ
         Gk2zpKKfd+iiREiRgJhfWAsJl2RKp2OtnWV9uLl8eFEQIm9DZoOorQeYhWIP60JxXq9Z
         eLZkPmCKGdhrrxoekitbTqptQXylWgdTWwD8nE76f+6+lkr3PLSk2vdC8KULTO9E1MRu
         D6Vg==
Received: by 10.236.79.67 with SMTP id h43mr30755204yhe.122.1341502396019;
 Thu, 05 Jul 2012 08:33:16 -0700 (PDT)
Received: by 10.146.150.18 with HTTP; Thu, 5 Jul 2012 08:32:55 -0700 (PDT)
In-Reply-To: <1341472926.10752.5.camel@flaca.cmartin.tk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201047>

>> > There is also a flag you can pass, which you can see a few
>> paragraphs
>> > under it which. It explains what it does underneath but removes the
>> need
>> > to know that an empty source will delete the ref.
>> >
>> >     --delete
>> >        All listed refs are deleted from the remote repository. This
>> is
>> >        the same as prefixing all refs with a colon.
>>
>>
>> I do like that, but I agree with OP that 'git push' is not an obvious
>> to look for delete branch functionality for new users.

s/obvious/obvious place/

> Like it? I don't get what you mean, it's a quote of what's already
> there.

Yes.  I didn't mean I like "the change".  I meant that I appreciate
this being in the documentation.   But it seems insufficient.

> The reason that it's in git-push is because that's the only git command
> that modifies another repository. There isn't another git command where
> it would fit.

Yes, and that's why I said, in the part of my email you did not quote:

"I do not have a good suggestion for improving the situation, however."

> You could try to put it somewhere under git-remote, but
> then you'd have a single subcommand that affects a remote among a lot of
> others that don't, introducing an inconsistency in the command.

git-remote is the wrong place for anything like this.  I think
git-push is really the correct place for it.  I do not think it should
be moved.

But this is a common problem in git for newbies, I think.  Features
are in "the right place" in the command structure, but it is difficult
to find where that right place is when you are new to the system,
especially when the feature is tucked neatly away as a switch on some
other feature.

The possible enhancements to cover this I can think of are mostly in
the form of enhanced help or advice.  For example, I could imagine
these:

1. Add a link to 'git push' on the 'git-branch' man page.   I suspect
this is where newbies would go to look for this feature, but I am only
guessing.  The git-branch help discusses deleting branches and even
deleting remote-tracking branches.  But it does not discuss deleting
branches on a remote repository, even to say "this is not the command
you want" for that action, but "see this other one instead".

2. Add 'apropos' behavior for git help.
   $ git apropos delete

Except I notice that the system 'apropos' does not turn up 'git-push'
for either of these:
   $ apropos delete
   $ apropos branch

3. Add a search feature for help.  Currently this feature is provided
instead by Google and StackOverflow.
   $ git help --find delete --and branch --and remote
Except I don't expect this "advanced" form of help, if it existed, to
be noticed by newbies early enough on the learning curve.

4. Add advice in appropriate locations.
Instead of this:
   $ git remote rm origin/foo
   error: Could not remove config section 'remote.origin/foo'
   $ git branch -d origin/foo
   error: branch 'origin/foo' not found.

Do this:
   $ git remote rm origin/foo
   error: There is no remote named 'origin/foo'
   hint: Did you mean to remove the remote tracking branch 'origin/foo'?
   hint: Try "git branch --delete --remotes origin/foo" instead.
   hint: Did you mean to remove the branch 'foo' on the remote
'origin' repository?
   hint: Try "git push --delete origin foo" instead.

   $ git branch -d origin/foo
   error: branch 'origin/foo' not found.
   hint: To delete the remote-tracking branch origin/foo,
   hint:  use git branch --delete --remotes origin/foo

   $ git branch -dr origin/foo
   Deleted remote branch origin/foo (was fadda12).
   hint: This deleted your remote-tracking branch but
   hint:  did not affect the branch on the remote server.
   hint:  To remove the branch from the remote server,
   hint:  use "git push".  See '--delete' in "git help push" .


I rather like this last bit.  I'll try to roll a patch later on.

Phil
