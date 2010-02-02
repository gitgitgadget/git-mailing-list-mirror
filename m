From: Eugene Sajine <euguess@gmail.com>
Subject: Re: [BUG] - "git commit --amend" commits, when exiting the editor 
	with no changes written
Date: Tue, 2 Feb 2010 18:02:51 -0500
Message-ID: <76c5b8581002021502i2bb34967y9a88d8b25ce7fa42@mail.gmail.com>
References: <76c5b8581002021207y3eccdc19i9a4abcc3d04315f0@mail.gmail.com>
	 <8c9a061002021214j673afbc8vfa5d941fba518648@mail.gmail.com>
	 <32541b131002021227o1ec9f369w6096e85382857b8a@mail.gmail.com>
	 <76c5b8581002021247j6df8f609ld9e5d87a060a5423@mail.gmail.com>
	 <394FB581-C9B9-40AB-AFB6-39B68ED5BEAD@wincent.com>
	 <76c5b8581002021356m52bb1817k9a4a29da0d4b681d@mail.gmail.com>
	 <77153A83-158D-4D36-A622-7AA3947C7D52@wincent.com>
	 <76c5b8581002021431o2b5073a0s42b273b6d61893db@mail.gmail.com>
	 <32541b131002021435kadb68ffge77ad5f4e1775418@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Wincent Colaiuta <win@wincent.com>,
	Jacob Helwig <jacob.helwig@gmail.com>, git@vger.kernel.org
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 03 00:03:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NcRlr-000823-F7
	for gcvg-git-2@lo.gmane.org; Wed, 03 Feb 2010 00:02:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756891Ab0BBXCy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 2 Feb 2010 18:02:54 -0500
Received: from mail-iw0-f201.google.com ([209.85.223.201]:34160 "EHLO
	mail-iw0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756626Ab0BBXCx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 2 Feb 2010 18:02:53 -0500
Received: by iwn39 with SMTP id 39so787071iwn.1
        for <git@vger.kernel.org>; Tue, 02 Feb 2010 15:02:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Ys9wZRjF5fxey2DR6yZnfvTRJ621zuIMHDuaBy5QgWU=;
        b=PV/4WqlOaGBYcjX29D7FGFdKaTUvJBXAhRvnuUjy27JTsLgyKN0TGAmCblTPIkyZad
         P36j0irEs9Nlr/j+tQnSXrF3rsUJqaxK/IM8YFPb4I869L7fcUZXnyh2haNSeUm6LVgn
         75eKnI4+gJMxQDxmwcCbfwTyuDDXdvLKZQY8A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=rRiq3MRQ7gybAdAY5QzaC0i1KgzFur3+ZEufhLCNN4oFV6gvhLZ62LiBGzyp7ci6sT
         7VuzOmq54SELGfHWrkd7cY9eyCH80nsWHK8Qt8e3HjnOa4HSYVPmMFvW14JRLUQ9pbwh
         gktK19TasuJIw1XEIVYqzoHqOIZvnh6a05GVw=
Received: by 10.231.145.132 with SMTP id d4mr3434743ibv.72.1265151771974; Tue, 
	02 Feb 2010 15:02:51 -0800 (PST)
In-Reply-To: <32541b131002021435kadb68ffge77ad5f4e1775418@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138778>

On Tue, Feb 2, 2010 at 5:35 PM, Avery Pennarun <apenwarr@gmail.com> wro=
te:
>> amend or rebase:
>> COMMIT_EDITMSG =3D "message from commit or rebase sequence";
>> $ git commit --amend
>>
>> in background:
>> $EDITOR .git/COMMIT_EDITMSG
>>
>> COMMIT_EDITMSG =3D NULL =C2=A0 =C2=A0<=3D=3D=3D=3D=3D=3D=3D=3D this =
i think is missing. We have to
>> clean it after it is populated in the editor.
>
> That's not going to work. =C2=A0Most editors will get quite angry at =
you if
> you modify the file while the editor has it open. =C2=A0Furthermore, =
how do
> you know how long to wait after launching the editor but before
> deleting the file?

I'm not insisting on this approach by any mean - i was trying to
explain what is the problem i consider to be a bug.


>
> Like I suggested earlier, monitoring the mtime of the file to see if
> it has changed after the editor exits, even if the file itself is
> identical to what it was, might work.

Anything that would work;)

>This feature would have to be
> optional in order to not confuse existing users, and not annoy users
> of editors (like my favourite, joe) which don't save-on-exit if the
> file hasn't changed. =C2=A0But I think it might be valuable to some p=
eople
> nevertheless. =C2=A0And if it became popular, perhaps it could become=
 the
> default in some future version of git (after giving people enough
> notice, etc, etc).

But here I totally disagree, because i don't understand what is so new
and confusing in the workflow I'm talking about?
Why you're not confused that you MUST save before exiting your EDITOR
in order to be able to commit (else it will fail), but the same
workflow suddenly becomes confusing when you doing "commit --amend" or
especially "rebase -i" ???

=46rankly, I think that "rebase -i" is the best example when exiting
without save should abort, not proceed.


>
> So you might want to submit a patch to implement an option like that.
>
> Avery
>

I wish i could - but, unfortunately, I'm as far from C as from the Sun
(star;)). I'm developing a little bit in Java, but can't do C.

Thanks,
Eugene
