From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [PATCH] Proof-of-concept patch to remember what the detached HEAD 
	was
Date: Wed, 14 Oct 2009 14:56:11 -0400
Message-ID: <76718490910141156g440ee455t2e1db72ad72b7049@mail.gmail.com>
References: <alpine.LNX.2.00.0910140037570.32515@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Wed Oct 14 21:05:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1My99S-0005bn-6X
	for gcvg-git-2@lo.gmane.org; Wed, 14 Oct 2009 21:04:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762021AbZJNS4u convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 14 Oct 2009 14:56:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762019AbZJNS4u
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Oct 2009 14:56:50 -0400
Received: from mail-iw0-f180.google.com ([209.85.223.180]:49810 "EHLO
	mail-iw0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757204AbZJNS4t convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Oct 2009 14:56:49 -0400
Received: by iwn10 with SMTP id 10so55815iwn.4
        for <git@vger.kernel.org>; Wed, 14 Oct 2009 11:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=C1HHeSIP4E1yRNmdbB3FPoSIRVJ3TllrRq7oP0dcEVk=;
        b=wJV5gh4mWGu6I4ikw4Zj4m6MKpYaeG2O3zK5RMiiYYVjY3qClWybnbBOxqW8jhj4ep
         wc0wVU45NFtEJocTdMWTAtgh0coVMLDn92nNmnyw97MtdWsTnLrT1Nx9DcDiuZ48Bkmm
         XaoaAojPwzSdymIqLPJTPx2jKXk2u1nFlwBwI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=sRZxGx2eFcnQNuAaLc/dXccCl5gOkHXmdNRWrEHQY4efBq517k0mFQSYZCKqraezA8
         wYTIDRQg7DIXt9E4TE3MpCo1yH6CAObmLw3lkUbb5BviF8iug1PK1OHKvF8VwQLUfoJd
         N3SBny4x6TPy76EG8+EYYp2mxNw45hGAF5CV4=
Received: by 10.231.6.87 with SMTP id 23mr4320043iby.19.1255546571571; Wed, 14 
	Oct 2009 11:56:11 -0700 (PDT)
In-Reply-To: <alpine.LNX.2.00.0910140037570.32515@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130323>

On Wed, Oct 14, 2009 at 12:44 AM, Daniel Barkalow <barkalow@iabervon.or=
g> wrote:
> =C2=A0$ git commit
> =C2=A0You've been sightseeing "origin/master". The commit can't chang=
e that
> =C2=A0value, so your commit isn't held in any branch. If you want to =
create
> =C2=A0a branch to hold it, here's how.
>
> "git checkout origin/master" should be similar in complexity to
> "svn checkout -r 8655"; the difference is that svn won't let you
> commit then and git will but you'll need to understand the
> implications if you do so. If you don't commit (because you don't wan=
t
> to make any changes, because you don't think it would be possible, or
> because you don't want to worry about what would happen), there's no
> meaningful difference, and you don't need to be told.

Huh, I hadn't seen this message before I wrote in a reply to
"builtin-checkout: suggest creating local branch" that we do the
following at commit, which I think is what you're suggesting:

$ git commit -m "blah"
Cannot commit while not on any branch. Please use git commit -b <branch=
> to
specify the name of a new branch to commit to, or use git commit -f to
force a detached commit.

I'm not sure that requires the complexity of remembering how the user
got detached though?

j.
