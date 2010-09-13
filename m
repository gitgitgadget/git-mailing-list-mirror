From: Tor Arvid Lund <torarvid@gmail.com>
Subject: Re: git-p4
Date: Mon, 13 Sep 2010 23:58:08 +0200
Message-ID: <AANLkTingvEFDygkKipBXfCHJr2=oMQrYv3FKpxpo+TkW@mail.gmail.com>
References: <4C8A8CE8.90600@borg.org>
	<20100910235323.773d2c5b@varda>
	<AANLkTinmG5BU+yswWQ8=cRKT5WL_h8vWuUCu2PjZYb87@mail.gmail.com>
	<4C8CF231.6090403@borg.org>
	<AANLkTi=yJ5kVA17+40xc6NpEczFjgmYh7=w5k=GL_U9w@mail.gmail.com>
	<4C8D14F9.90705@borg.org>
	<AANLkTi=NGsY3wDiTLwNLpw4TJMpiSY8A=az_=v2fYDLj@mail.gmail.com>
	<4C8D3303.1030302@borg.org>
	<AANLkTikrSt4djXep-o4Hr8EZAsiNXnqCHa2fLrys8T==@mail.gmail.com>
	<4C8E33DF.7010904@borg.org>
	<AANLkTimL3mB8LeUOANsJO7p9uwqDCN9wKnLVMTq_-=3H@mail.gmail.com>
	<4C8E511F.8000400@borg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Kent Borg <kentborg@borg.org>
X-From: git-owner@vger.kernel.org Mon Sep 13 23:58:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OvH2X-00035X-Hq
	for gcvg-git-2@lo.gmane.org; Mon, 13 Sep 2010 23:58:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752097Ab0IMV6K convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 13 Sep 2010 17:58:10 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:62008 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751805Ab0IMV6J convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 13 Sep 2010 17:58:09 -0400
Received: by mail-iw0-f174.google.com with SMTP id 5so5466082iwn.19
        for <git@vger.kernel.org>; Mon, 13 Sep 2010 14:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=8XgiDyjda0qbr8lnqoV3QguCUyVdJrkov+7B903i2jU=;
        b=XmHMBGFw/JtasVxeECgArlbuABGOT7uaCaLsOA6VbZO9KMD+/bLJj8Fwp1huB3JPyJ
         KdVv2clDBkGvDcyGL5/Y6/2+BzwxaCGeb7sBknTIjMXGrnBUC2BFHLL0QbLFmVsCgOCm
         stcp+6fgaaurC49+VZDPm5Rh7C0bHt80gE0yk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=sw67B94+EnCTSD0KrN4GLY80lOq/MzxEwTTvNomYoirytQpuHb0LoooRnf2XnF3+ak
         gvtrpOe5ymaqGl+LiT5ROKHtfy+N3ul6nPwkbN+imAdaUppttMaVtPhsTy7A8Rkz0dgK
         dC1Lg+L2oPNudGqbybWSga9Yriayn3M47Y0Vg=
Received: by 10.231.166.9 with SMTP id k9mr6701319iby.127.1284415088489; Mon,
 13 Sep 2010 14:58:08 -0700 (PDT)
Received: by 10.231.178.139 with HTTP; Mon, 13 Sep 2010 14:58:08 -0700 (PDT)
In-Reply-To: <4C8E511F.8000400@borg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156131>

On Mon, Sep 13, 2010 at 6:28 PM, Kent Borg <kentborg@borg.org> wrote:
> Tor Arvid Lund wrote:
>> git remote, shows remotes as defined in your .git/config file (the
>> [remote "someremotename"] sections). git-p4 does not need nor create
>> such entries.
>
> I am confused trying to understand what kind of beast the p4/master i=
s.
>
> I think my fundamental problem is that I need p4/master to point at a
> branch with a real git history, not a sync from Perforce (which has n=
o
> git history).

Well, then I think you are a bit confused ;)

The p4/master branch is git's view of your p4 history. So p4/master
points to the most recent git/perforce commit. An important side point
here, is that if you have another remote (which you do in your case)
that is a pure git remote that knows nothing about p4, then the
p4/master branch and the origin/master branch will be disjoint.

> How do I change where p4/master points? =C2=A0(Put another way, how c=
an I
> have a complete Linux history in git but only new work in Perforce?)

Ehm, thinking about this some more, I wonder if this whole endeavor
might be continually painful...

Say that you clone Linus' kernel tree with git, and that commit X is
the master where you will start your work.

You then import your tree at commit X into p4, and sync it back using
git-p4. That git-p4 sync will give you a commit X' - Such that
checking out X or X' will yield the same checkout tree, but they will
have differing commit IDs... Do you have a strategy if you:

1) Commit something, Y', on top of X' in git (and syncs with p4).
2) Someone else commits Z on top of X, which you get when you do git fe=
tch.

What do you do in p4? You can't be sure that it'll work to apply Z on
top of Y', nor the other way around...

It kind of seems like you want to have two different repositories, and
you want these to be equal (no one is the "one true repository"), and
this presents problems in the scenario I described above, right?

I think maybe draw a few branch trees for git and p4/git-p4 and your
own work on a good old piece of paper... It often helps to clear the
head and think freshly (is that a word?).

-Tor Arvid-
