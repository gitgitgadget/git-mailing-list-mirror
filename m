From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: Trying to sync two svn repositories with git-svn (repost)
Date: Fri, 1 May 2009 15:17:14 -0400
Message-ID: <32541b130905011217x7f339d41x696fedee7298e3a4@mail.gmail.com>
References: <20090427201251.GC15420@raven.wolf.lan>
	 <20090428223728.GE15420@raven.wolf.lan>
	 <32541b130904282019n4b930f80g1ed22b2dde22510a@mail.gmail.com>
	 <20090429160129.GF15420@raven.wolf.lan>
	 <32541b130904291113p6f99a82ft824cd3c482447117@mail.gmail.com>
	 <20090429223747.GG15420@raven.wolf.lan>
	 <32541b130904291907q4003ad86v4728c5b2ba0aacb7@mail.gmail.com>
	 <20090430222808.GH15420@raven.wolf.lan>
	 <32541b130904301559w329bdd4bo6f2736a505b7235f@mail.gmail.com>
	 <20090501142811.GI15420@raven.wolf.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Josef Wolf <jw@raven.inka.de>, Avery Pennarun <apenwarr@gmail.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 01 21:17:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LzyEl-00072T-3U
	for gcvg-git-2@gmane.org; Fri, 01 May 2009 21:17:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756242AbZEATRR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 1 May 2009 15:17:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755756AbZEATRQ
	(ORCPT <rfc822;git-outgoing>); Fri, 1 May 2009 15:17:16 -0400
Received: from yx-out-2324.google.com ([74.125.44.30]:2664 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755649AbZEATRP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 1 May 2009 15:17:15 -0400
Received: by yx-out-2324.google.com with SMTP id 3so1476493yxj.1
        for <git@vger.kernel.org>; Fri, 01 May 2009 12:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=d8JPZhtNUsIpruBsZtHoCoD1cxrZlutLSHoHlXtRrKY=;
        b=cXR5cWTduJKna5jmeU1LKnR0VHr7DGDNXVqxWXFJf/lFjycZIlaqckPn0YdG4BaJ7j
         VMxzCNE1z/JjxOPKAxHDzPVIGxoC7SEvmoyUKJBPBK0KJnoVdQZZn9KqqyPe8uJD23aD
         iIOnlXpq+jCjR4UwzSCBtg83QdMSOXlrGmQXs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=iyad5rfSIukwb59+pm9VjsXe18Kad9ZF0wor3W0s2/a/8DG8XlpeuGfTKFuEFNXvIj
         F+Yu6mHlS0SByrg1tOJ+mUVwQHw4dIq5x5fn63yfNlKEiv0WZFMh3MpozgnWpP28VfPN
         /hGvYcEP5DxRFm5drUMvAUtgDHf38b1QF1n74=
Received: by 10.151.122.7 with SMTP id z7mr6127811ybm.140.1241205434704; Fri, 
	01 May 2009 12:17:14 -0700 (PDT)
In-Reply-To: <20090501142811.GI15420@raven.wolf.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118091>

On Fri, May 1, 2009 at 10:28 AM, Josef Wolf <jw@raven.inka.de> wrote:
> On Thu, Apr 30, 2009 at 06:59:50PM -0400, Avery Pennarun wrote:
>> "git log -1 first-svn" would give you the first cherry-pick. =A0But
>> remember, it's a completely different branch.
>
> I can see why this happens, but I still find it confusing. =A0Maybe I
> should help with the -m option?

I don't know what -m does.  Maybe try looking at the graph with gitk;
that might give some clues.

>> AFAIK, it will attempt to do "git svn rebase" first, and if that
>> succeeds, it will do the commit.
>>
>> In such a case, the rebase should be okay, because it's only changin=
g
>> commits (in fact, just one commit: the merge commit) that don't exis=
t
>> on any other branch. =A0Thus it won't mangle any other merges.
>
> Yeah, that's the simple case. =A0But what if the rebase don't succeed=
?

Then you'll get a conflict, and you'll have to fix it first before you
can dcommit.

>> Okay, if you want to end up with two different remote branches, it
>> makes sense to have two different local branches.
>
> Well, I _have_ two different remotes because I have two svn repositor=
ies.

Right.  I was just wondering whether you wanted the two branches'
contents to be *different* or identical.  I guess different.

> Then I have to keep both local branches. =A0But I still wonder why yo=
u
> suggested to go with _one_ local branch.

=46or my own purposes, I try not to create a 1:1 mapping between local
branches and remote branches; this just ends up being confusing,
because I can have commits in my local branch that aren't in the
remote one, and vice versa.  So it's not very useful to create a local
branch *just* because I have a corresponding remote branch.

In your case, you might want to have just a single local branch for
your "public" stuff.  You would then merge changes from the two svn
remote branches into your local branch, and you'd also merge from your
local branch into your remote branches (using a disconnected HEAD and
svn dcommit).

Have fun,

Avery
