From: Eugene Sajine <euguess@gmail.com>
Subject: Re: [BUG] - "git commit --amend" commits, when exiting the editor 
	with no changes written
Date: Wed, 3 Feb 2010 14:27:16 -0500
Message-ID: <76c5b8581002031127m31c39dbbkc7c31d19e4d5874@mail.gmail.com>
References: <76c5b8581002021207y3eccdc19i9a4abcc3d04315f0@mail.gmail.com>
	 <alpine.DEB.1.00.1002022356460.4985@pacific.mpi-cbg.de>
	 <76c5b8581002021534i1f0dbd18y1b216233d282cd84@mail.gmail.com>
	 <40aa078e1002021540i13e35776xd733a4e40f34b477@mail.gmail.com>
	 <76c5b8581002021548n129b3997r48ee6f6df5a1a4eb@mail.gmail.com>
	 <vpqeil2kc6b.fsf@bauges.imag.fr>
	 <76c5b8581002030745g634d6ec1hb9e87b687e58e521@mail.gmail.com>
	 <1088CD70-9D6E-4B97-9A46-BDDE1535B703@wincent.com>
	 <76c5b8581002031049t5558a700qe2e05bb70d175305@mail.gmail.com>
	 <32541b131002031057q866d3q95d0e80a0adf6c52@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Wincent Colaiuta <win@wincent.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	kusmabite@gmail.com,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jacob Helwig <jacob.helwig@gmail.com>, git@vger.kernel.org
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 03 20:27:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ncksn-00047E-Lv
	for gcvg-git-2@lo.gmane.org; Wed, 03 Feb 2010 20:27:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757585Ab0BCT1U convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 3 Feb 2010 14:27:20 -0500
Received: from mail-iw0-f201.google.com ([209.85.223.201]:40622 "EHLO
	mail-iw0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756024Ab0BCT1T convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 Feb 2010 14:27:19 -0500
Received: by iwn39 with SMTP id 39so1969275iwn.1
        for <git@vger.kernel.org>; Wed, 03 Feb 2010 11:27:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=7u8Igbgp48Mi8SHWJ2QbPvEHSlicAL1fcgduIJySbbw=;
        b=VbqLMUohs2e8K9dbESjd/vgh7bE5wv4tgAdjQG/SUlcPzna2qxQ6uBaBCTe7PAi68e
         gho9qrEk3IAdpK/oXDldhXW2CuI8qmNwtdNEzQJG70WCoCJkJZhiVm/97l3+/9d9xZnn
         KS7XfO1NHA8uQXlDEASXtCnJ5oqk4iwoXAGac=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=FvITgNQS6rPAiYQHB5aiMIDX2IpjLe4VHIB4zfMfGbisrGUwqKU16H02kjmFMQhBxk
         ZTzqbm5q4VjSve0XY12kq7J7TzTgULrMwCc6MWIDEt1AMlUU1L+Fg2fP0YgD8tQdenet
         +XEfCVaA7Z3Uu09pdWaiks+YgQnQzOkpWAsNU=
Received: by 10.231.147.149 with SMTP id l21mr126762ibv.0.1265225236089; Wed, 
	03 Feb 2010 11:27:16 -0800 (PST)
In-Reply-To: <32541b131002031057q866d3q95d0e80a0adf6c52@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138868>

> Of course, in such editors you could just hit "space; backspace" and
> then save. =C2=A0Sounds annoying? =C2=A0Well, so does deleting all th=
e lines in
> the commit message just to make it *not* amend.

That was exactly the starting point of my thoughts.Currently it forces
user to be explicit if he wants to cancel the operation (rebase -i,
or amend), instead of forcing user to be explicit to proceed.

>
> To reiterate what I said earlier: the mtime idea isn't even
> automatically a bad one. =C2=A0It's about as good as what currently e=
xists,
> and the resulting rule (file content or mtime must be modified) is
> just as consistent as the current rule (file must be nonempty). =C2=A0=
It's
> also arguably easier for new users to understand.

OK. Agree on that.

>
> But you can't just blindly change the system to always work in a
> different way. =C2=A0People depend on the current behaviour.

I understand that pretty well. My logic is that the most used command
which is affecting the three is "git commit", therefore this command
workflow is pretty natural for all users, but the workflow of commit
--amend and rebase -i which are also affecting the three is
inconsistent with commit. The user interaction is not the same.

> Jeff King's script is a pretty cute solution that lets you have it yo=
ur way with
> no changes to git, though.

Thanks to Jeff, I'll try it.

>
> Of course, this does open up the question of how to do any global UI
> design at all if a decision made once gets locked in forever.

100% agree, there is such question.

> The reason git is hard for new users is that its UI is crazy and
> confusing, but a major reason it keeps gaining in popularity is that
> once you learn git, you stick with it, because you don't have to
> relearn it with every new version.

I just didn't realize that this can be such a drastic change for users
as well as technical difficulties related to the emacs and similar
editors.

Thanks,
Eugene
