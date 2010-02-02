From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: [BUG] - "git commit --amend" commits, when exiting the editor 
	with no changes written
Date: Tue, 2 Feb 2010 18:40:49 -0500
Message-ID: <32541b131002021540g7a2834c9hacf2be5962f66515@mail.gmail.com>
References: <76c5b8581002021207y3eccdc19i9a4abcc3d04315f0@mail.gmail.com> 
	<8c9a061002021214j673afbc8vfa5d941fba518648@mail.gmail.com> 
	<32541b131002021227o1ec9f369w6096e85382857b8a@mail.gmail.com> 
	<76c5b8581002021247j6df8f609ld9e5d87a060a5423@mail.gmail.com> 
	<394FB581-C9B9-40AB-AFB6-39B68ED5BEAD@wincent.com> <76c5b8581002021356m52bb1817k9a4a29da0d4b681d@mail.gmail.com> 
	<77153A83-158D-4D36-A622-7AA3947C7D52@wincent.com> <76c5b8581002021431o2b5073a0s42b273b6d61893db@mail.gmail.com> 
	<32541b131002021435kadb68ffge77ad5f4e1775418@mail.gmail.com> 
	<76c5b8581002021502i2bb34967y9a88d8b25ce7fa42@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Wincent Colaiuta <win@wincent.com>,
	Jacob Helwig <jacob.helwig@gmail.com>, git@vger.kernel.org
To: Eugene Sajine <euguess@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 03 00:41:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NcSMt-0001nt-Pd
	for gcvg-git-2@lo.gmane.org; Wed, 03 Feb 2010 00:41:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755460Ab0BBXlL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 2 Feb 2010 18:41:11 -0500
Received: from mail-yw0-f198.google.com ([209.85.211.198]:61674 "EHLO
	mail-yw0-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754537Ab0BBXlJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 2 Feb 2010 18:41:09 -0500
Received: by ywh36 with SMTP id 36so707108ywh.15
        for <git@vger.kernel.org>; Tue, 02 Feb 2010 15:41:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=fsAVCeznpOO1zXVkFgjsVqihRvRI2fNaFAq77TfQ+Hs=;
        b=vamHg8iPnj35B5lTPRZkPIOnmQSSBXv3rvSZX0sSeUkZs+NuoAvnKySMTMRVaMGZ1A
         RI1bMS2W+6K+VCWIybhHqlW/KeStm6XfURm/9QFReJayHOWIejx85At9SE0QBNaHge1Q
         cVa3oJyCUs6IWVX5+vzwvL5jRltQwJgernRiE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=H5H/h0Xh+bvjgaFdBYfxLKDEMYCg2q8hPtXWRq4rLrnmDTaEU86yg3RRBNC4fhBmiZ
         mbKXKhxXmqMwQH7uGEqXXCM2i11Ge/otqheEVrCiXLtRWuOYtbG7C4IzFqLQEXhQ01jj
         7oL/bkoaesB+0pYHmqbs7AumQoDoK3FDqO4CQ=
Received: by 10.150.251.42 with SMTP id y42mr9770821ybh.2.1265154069098; Tue, 
	02 Feb 2010 15:41:09 -0800 (PST)
In-Reply-To: <76c5b8581002021502i2bb34967y9a88d8b25ce7fa42@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138783>

On Tue, Feb 2, 2010 at 6:02 PM, Eugene Sajine <euguess@gmail.com> wrote=
:
> On Tue, Feb 2, 2010 at 5:35 PM, Avery Pennarun <apenwarr@gmail.com> w=
rote:
>>This feature would have to be
>> optional in order to not confuse existing users, and not annoy users
>> of editors (like my favourite, joe) which don't save-on-exit if the
>> file hasn't changed. =A0But I think it might be valuable to some peo=
ple
>> nevertheless. =A0And if it became popular, perhaps it could become t=
he
>> default in some future version of git (after giving people enough
>> notice, etc, etc).
>
> But here I totally disagree, because i don't understand what is so ne=
w
> and confusing in the workflow I'm talking about?
> Why you're not confused that you MUST save before exiting your EDITOR
> in order to be able to commit (else it will fail), but the same
> workflow suddenly becomes confusing when you doing "commit --amend" o=
r
> especially "rebase -i" ???

I think you're missing the point of people's objections.

It's pretty clear that the current behaviour is inconsistent and
confusing to new users:

- If you make a new commit and change your mind, abort your editor:
commit is aborted.

- If you amend a commit and change your mind, abort your editor:
commit gets *replaced* and newbies don't know how to get it back.
Argh!

However, whether it's inconsistent and confusing is unfortunately not
the question.  The question is what can you do to possibly improve
things while a) not making backwards-incompatible changes, b) not
making things even more inconsistent, and c) not annoying existing
long-term users who like it fine the way it is.  (I use the current
behaviour and I even kind of like it now that I understand it.  But I
still think it's confusing and admit there may be a better way.)

git development is kind of like working at Intel or Microsoft.  If you
want to achieve world domination, you don't make new versions that are
incompatible with old ones, no matter how stupid you think the old one
was.

You can however add *new* stuff.  That's why I suggested adding an
option.  You could even make it a config option so you only have to
set it once (just like setting your preferred editor).

> I wish i could - but, unfortunately, I'm as far from C as from the Su=
n
> (star;)). I'm developing a little bit in Java, but can't do C.

There's no better time to learn :)

Have fun,

Avery
