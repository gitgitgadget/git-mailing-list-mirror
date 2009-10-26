From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: [PATCH 3/3] git checkout --nodwim
Date: Mon, 26 Oct 2009 18:28:51 -0400
Message-ID: <32541b130910261528s12cbe3c0gda163be6a906bdf6@mail.gmail.com>
References: <7v7huspjg0.fsf@alter.siamese.dyndns.org> <20091022062145.6117@nanako3.lavabit.com> 
	<alpine.DEB.1.00.0910220226270.4985@pacific.mpi-cbg.de> <7vzl7h8fjp.fsf@alter.siamese.dyndns.org> 
	<117f2cc80910240759oa9f57e7h67f06816d37e328c@mail.gmail.com> 
	<alpine.DEB.1.00.0910262111340.4985@pacific.mpi-cbg.de> <32541b130910261340g1988caednc17f3d159ec00d26@mail.gmail.com> 
	<20091026212628.GC27744@sigio.peff.net> <32541b130910261501n32046cc5s12283a8e3981d04e@mail.gmail.com> 
	<20091026221424.GA28184@sigio.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	David Roundy <roundyd@physics.oregonstate.edu>,
	Junio C Hamano <gitster@pobox.com>,
	Nanako Shiraishi <nanako3@lavabit.com>,
	Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org,
	Jay Soffian <jaysoffian@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Oct 26 23:29:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N2Y3z-00089B-KQ
	for gcvg-git-2@lo.gmane.org; Mon, 26 Oct 2009 23:29:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753772AbZJZW3J convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 26 Oct 2009 18:29:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753747AbZJZW3I
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Oct 2009 18:29:08 -0400
Received: from mail-yw0-f202.google.com ([209.85.211.202]:38039 "EHLO
	mail-yw0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753729AbZJZW3H convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 26 Oct 2009 18:29:07 -0400
Received: by ywh40 with SMTP id 40so8713699ywh.33
        for <git@vger.kernel.org>; Mon, 26 Oct 2009 15:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=eGwOwxqK+YgUysv84380syt8eA72QP/V0TJRF8HA7c8=;
        b=t7WcFqRen7LsRAUWinChrRsvKf3BphcNK/KXoNC+v2a9j7PsZ2UrxeG6LlI5HEsFkH
         QeIjyWBHpPKJ3AUtvauQfgwUR5gRvlRX7c6V5hff4xEcy6T/qbatY6sgoj63L0lXCO19
         TUQRYRCbzyriJAdhxG6m78zdL3qDBDcCYFRHg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=A5/dfaxOLxbNs8wygeLuTSxrRp7nwim1kBlJ5U/FVVKLr60slJx7ejBuJOu4I79c61
         wFApSReghKm5+3pNseEjZ77COPkah24Dp+iaZoWPF7NSwDvYDSX31ZoB59XXEKb+kokn
         FjRwFwYVToTnp65VqrbXPZ3eVhk//zagaj/iM=
Received: by 10.150.42.1 with SMTP id p1mr25055534ybp.15.1256596151052; Mon, 
	26 Oct 2009 15:29:11 -0700 (PDT)
In-Reply-To: <20091026221424.GA28184@sigio.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131281>

On Mon, Oct 26, 2009 at 6:14 PM, Jeff King <peff@peff.net> wrote:
> On Mon, Oct 26, 2009 at 06:01:29PM -0400, Avery Pennarun wrote:
>> > It's git-update-ref.
>>
>> That would be similar to git commit, not git checkout, right? =A0Oh
>> wait, I see the confusion: git checkout does two things. =A0It switc=
hes
>> branches, and it checks out files from the index into the work tree.
>> I meant the latter meaning.
>
> Er, sorry, yes. It should be "git symbolic-ref", of course, to change
> HEAD, and then probably read-tree and checkout-index. I was just not
> thinking when I wrote the other message (hopefully I am doing so now)=
=2E

Wow, I've browsed through the git manpages repeatedly and never found
checkout-index.  It was exactly the missing building block I was
looking for.  Thanks!

>> > Consider "git commit", for example. Does anyone
>> > actually script around "write-tree" and "commit-tree" these days, =
or do
>> > they just script around "git commit"?
>>
>> Oh, I use those all the time. =A0They're awesome! =A0It allows you t=
o
>> create commits without having a working tree, which lets me do very
>> interesting tricks. =A0git-subtree uses this heavily.
>>
>> I'm probably a weirdo, though.
>
> OK, I should have phrased my statement differently (see, I told you I
> wasn't thinking). Yes, there are reasons to script around low-level
> building blocks, when you don't want the assumptions associated with =
the
> higher level. But I'm sure there are tons of scripts that munge some
> files in a worktree, followed by "git add -A; git commit -m 'automagi=
c
> update'". And in that case, nobody would script around "commit-tree"
> because it's a lot more work.

Unfortunately this is pretty tricky to get perfect; perhaps there's no
way to do it.

In git-subtree, for example, I *mostly* use write-tree and
commit-tree, but when I do the final merge operation (to take the
synthetic history and merge it into your "real" history) I use commit.
 This is because I wanted the default merge handling, commit message,
etc for that part.  Unfortunately, it's possible that this dragged in
a bunch of stuff I *didn't* want.  It also makes git-subtree, which
otherwise could be used as plumbing, effectively into a porcelain.

I don't really know what to do about that.  You could introduce an
abstraction level somewhere between commit-tree and commit, but surely
someone would eventually find a case where that abstraction level is
still not right.  To bring this around to the original topic of this
thread, such an extra level of abstraction is equivalent to the
suggested --plumbing (or whatever) option, whether it's presented as
an option or a separate command.

Have fun,

Avery
