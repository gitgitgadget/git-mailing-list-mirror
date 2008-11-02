From: "Sverre Rabbelier" <alturin@gmail.com>
Subject: Re: Pull request for sub-tree merge into /contrib/gitstats
Date: Sun, 2 Nov 2008 20:24:08 +0100
Message-ID: <bd6139dc0811021124q5ba22d6bm6655f735aaeb379b@mail.gmail.com>
References: <bd6139dc0810291606o2efe4254me378335b76861340@mail.gmail.com>
	 <7vljw5evj5.fsf@gitster.siamese.dyndns.org>
Reply-To: sverre@rabbelier.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Git Mailinglist" <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Nov 02 20:25:26 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KwiZh-0003nq-B9
	for gcvg-git-2@gmane.org; Sun, 02 Nov 2008 20:25:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751801AbYKBTYM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Nov 2008 14:24:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751797AbYKBTYL
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Nov 2008 14:24:11 -0500
Received: from fk-out-0910.google.com ([209.85.128.189]:16379 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751600AbYKBTYK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Nov 2008 14:24:10 -0500
Received: by fk-out-0910.google.com with SMTP id 18so2470822fkq.5
        for <git@vger.kernel.org>; Sun, 02 Nov 2008 11:24:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=/BzGAwuD0K1coMmrpkRmWr/ZPb58sIzgHjec9UA++BQ=;
        b=D6fGShJsXnooff1/YtSRVE1qQSqzCet5fDND3SlVQxWoh223nYBCJU0bcOkCPcU0rG
         4UQA94TaQQKsItor4WNtKM8e2DonCHie0U/CbBHESZ8BvYnDwsgfB9iTOinjd/PAP0Mm
         /kOrtA6uyNys2TTC787MI9p6Ux/WqYQJ9KoKE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:cc:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:references;
        b=l7mZDQCn7JmUSVuCRCkqbWMJlzQIgLmx7rMqpzZCEI2EGRORYsGzlolX12ZRLwAnov
         n2zpts7mjajQvzhkU8y00rvAeNbLQ7j2/6Gje5N8PM+kK58xJAYv/xo1FCJPlz2fcuk4
         8f/ykKM4AwQMRJ50mHIuYYEJ6u1VeXDJ1yAUg=
Received: by 10.187.224.11 with SMTP id b11mr1793567far.81.1225653848887;
        Sun, 02 Nov 2008 11:24:08 -0800 (PST)
Received: by 10.187.213.8 with HTTP; Sun, 2 Nov 2008 11:24:08 -0800 (PST)
In-Reply-To: <7vljw5evj5.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99870>

[Sorry for the late reply, have been travelling, sleeping, and
catching up with family in the past few days]

On Thu, Oct 30, 2008 at 20:24, Junio C Hamano <gitster@pobox.com> wrote:
> I have a mixed feeling about this.  From a longer-term perspective, do you
> really want this to be a part of git.git repository?

My main reason for wanting to have it in git.git is getting additional
exposure, being in /contrib seems like a good way to do that.

> I do not mind having notes to endorse and advocate "stats" as one of the
> "Third party packages that may make your git life more pleasuable", just
> like tig, stgit, guilt and topgit, but I cannot convince myself that
> merging it as a subtree is the right thing to do at this point.

Heh, blame Johannes for that one; the main reason for not doing
something like this earlier was my uncertaincy as to -what- to do.
Dscho suggested to request-pull a subtree merge, which is what I did.

> The "stats" tool, at least at the conceptual level, shares one important
> property with tools like gitk and gitweb: it could be useful to people
> whose sources are not in git repositories but in say Hg or Bzr, with some
> effort.  The code may need refactoring to make it easier to plug in
> different backends and writing actual backends (aka "porting"), but that
> is something you can expect people with different backends to help you
> with.

This is true, it uses a python wrapper around git, but with some work
it could be make to use a more abstract wrapper instead, that allows
the use of different backends.

> However, it would be awkward for the contrib/ area in git.git to carry a
> lot of code that are only needed to produce stat data from non-git
> repositories, once such a porting effort begins.

I reckon it would not be a lot of code, but I agree, that would be awkward.

> It's perfectly fine if you are not interested in any of the other
> backends, and tell the people that they are welcome to fork it never to
> merge back.  But if this were my brainchild, I'd imagine I'd be wishing to
> be able to buy back the improvements to the "core stats" parts that are
> done by people with other backends.  I would imagine binding the current
> code as part of git.git would make such improvements harder to manage,
> both for you (who wants to buy back the changes made by others on
> different backends) and for others on different backends (who want to
> merge the changes made by you to their forks).

This is true, if there is indeed interest from other backends to use
this kind of functionality, I would welcome the patches. In such a
case being in git.git/contrib might not be a good thing.

> Perhaps pointing at your tree as a submodule would be the right thing to
> do; then git.git proper will be just one of the users of "stats" tool.

Would a subdir in git.git for such submodules be a good idea? That way
we don't have to worry about a conflict between (for example) git-gui
as a subdir, and git-gui as a submodule.

> How about making that as a mid-to-longer term goal?  When we eject git-gui
> and gitk from git.git and make them a submodule (wasn't that supposed to
> happen in 1.8 or 2.0 timeframe?), we may also add "stats" as a submodule?

I didn't know there was a timeframe for this, I thought your
suggestion tree to eject-and-make-into-submodule was somewhat ignored;
if there are indeed plans for this, I would be ok with having
git-stats as a submodule instead.

-- 
Cheers,

Sverre Rabbelier
