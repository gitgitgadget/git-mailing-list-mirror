From: hasen j <hasan.aljudy@gmail.com>
Subject: Re: [PATCH/RFC 0/3] Per-repository end-of-line normalization
Date: Sat, 8 May 2010 04:36:05 -0600
Message-ID: <q2q600158c31005080336u1d1b8b78n3dc7ad0055b99119@mail.gmail.com>
References: <x2s40aa078e1005061340vaf404ab3g30b2b98ca408205@mail.gmail.com> 
	<q2y600158c31005071647i80871db0z7a55ae77e738d0d4@mail.gmail.com> 
	<alpine.LFD.2.00.1005071648400.901@i5.linux-foundation.org> 
	<i2v600158c31005071719r23db385bpab9a971534b5d7c3@mail.gmail.com> 
	<alpine.LFD.2.00.1005071728250.901@i5.linux-foundation.org> 
	<i2g600158c31005071839wc5269ffqc88cb26e48c44748@mail.gmail.com> 
	<alpine.LFD.2.00.1005071847100.901@i5.linux-foundation.org> 
	<g2h600158c31005071949ve3397f18j3c38017be32dd591@mail.gmail.com> 
	<AANLkTikbIHfX5pUOn2Yk44IWzqTFDpyapC1V-C-br9jF@mail.gmail.com> 
	<k2q32541b131005072045jc1192392ke234b7b543aaca33@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Avery Pennarun <apenwarr@gmail.com>,
	Robert Buck <buck.robert.j@gmail.com>, git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Eyvind Bernhardsen <eyvind.bernhardsen
X-From: git-owner@vger.kernel.org Sat May 08 12:36:34 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OAhOb-0002q3-6r
	for gcvg-git-2@lo.gmane.org; Sat, 08 May 2010 12:36:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751636Ab0EHKg1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 8 May 2010 06:36:27 -0400
Received: from mail-yw0-f198.google.com ([209.85.211.198]:59927 "EHLO
	mail-yw0-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751445Ab0EHKg0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 8 May 2010 06:36:26 -0400
Received: by ywh36 with SMTP id 36so1114342ywh.4
        for <git@vger.kernel.org>; Sat, 08 May 2010 03:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:content-type
         :content-transfer-encoding;
        bh=H+ytYCQ2lxeCTIUJzNIW//NQgi0uT3QuGSRamwrmV9Y=;
        b=Ybr4x8thAHjErRSLmE+P8Z5ITU3Vhw3BKjY6SVNCXDaY8cE5iCFQ30q1aBCVy+3LjY
         SzTrdOEQphS8Bnu9Uf6ZD4MS+cZMJ0g+oghM2j5P2tdXKBVXBz/ssI80JLiEH4Juz5gw
         Ic5kO4mmosZnesKheGJbC8Veq3sXBe9HOFXWU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-type:content-transfer-encoding;
        b=vTaE0stug1MfCZ7JUfNszU3Nh2S/y1XX2NX+VwT47Ngoy/g7rHsd4lyAmq4jWbFXpo
         4TnzXuJQvnWTVrJ2++LaJGx6lQ1/KKbyH3O5brTg2lyn9NlsMQYr9rhXzXIeotv7mXCe
         lTdIjuILcWH+9EuVEgguGpE5fAMAFf2zRj3l4=
Received: by 10.91.4.29 with SMTP id g29mr828421agi.24.1273314985161; Sat, 08 
	May 2010 03:36:25 -0700 (PDT)
Received: by 10.90.79.17 with HTTP; Sat, 8 May 2010 03:36:05 -0700 (PDT)
In-Reply-To: <k2q32541b131005072045jc1192392ke234b7b543aaca33@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146654>

>
> It's that simple. You seem to totally miss the whole point of the who=
le
> feature in the first place.
>
>                        Linus

Sure, I won't deny, it always baffled me why it's built into git.

The only good reason I could think of is avoiding scenarios someone
saves a file with different line endings and then all merging hell
would break loose because all lines are changed. Although
theoretically I think that can be avoided if the merge algorithm
normalized line endings before the merge (but really, I don't know
anything about merging).

Under this assumption, the point of autocrlf is that windows users
should commit with LF endings even if they use CRLF in the working
directory (e.g. some stupid text editor resaves files with crlf).

If that's not the reason, then why the hell does git care about
converting line ending styles?

If the only reason is "LF is not a new line in Windows", then I'll go
back to my previous opinion that autocrlf is useless most of the time
and shouldn't be builtin; use smudge/clean filters instead if you
really need crlf files.



>> =C2=A0 ... [XML processors] MUST behave as if it normalized all line
>> breaks in external parsed entities (including the document entity) o=
n
>> input, before parsing, by translating both the two-character sequenc=
e
>> #xD #xA and any #xD that is not followed by #xA to a single #xA
>> character.
>
> Erm, this seems to be a counterexample to your point. =C2=A0It says v=
ery
> clearly that the files can use either LF or CRLF line endings, and
> will be parsed correctly either way, or your parser is broken. =C2=A0=
So
> pretty much any CRLF conversion rule (or none at all) will work with
> such files.

Agreed. This is an example where all line endings are valid on all plat=
forms.

>
> Hasen wrote:
>>> The way git handles crlf is just confusing; in fact it's so confusi=
ng
>>> that it's often better to just turn it off.
>
> True. =C2=A0This discussion is about fixing that, though, so it seems
> unnecessary to make that point.

It is necessary. It's broken because the assumptions it's built on are =
wrong.

>> Hasen makes a good point here. It is simply this, the LF issue does
>> not boil down to a single boolean switch. People who think of the
>> LF/CRLF issue as a boolean switch are not dealing with all the facts=
=2E
>> There's a lot of grey, not simply black and white.
>
> How on earth is anyone suggesting that it's a simple boolean switch?
> Linus posted an 8-cell truth table earlier, and he hadn't even
> included all the cases.

That's cool and all, but we need to simplify it; not make it more
confusing. The name autocrlf is confusing all by itself: what does it
mean? is it a two way conversion or a one way conversion? Where the
hell did "input" come from? I always have to pull up the man pages.

I'd rather be able to say:

- My over all preference is 'lf'
- For this repo, this file here is always 'lf' (takes precedence over
the above preference)
- And this other file here is always 'crlf' (ditto)

This model makes way more sense for me as a user and for the project.


>> Confusion, yes. The Git documentation is very confusing on this
>> point... Linus and Junio may want to lift a page from the Perforce
>> book ;)
>
> I've learned that git people never learn from anyone's book. =C2=A0sv=
n has
> also had this problem solved pretty much forever, and would be easy t=
o
> copy. =C2=A0For better or for worse, it all has to be hashed out from
> scratch or it won't happen.

No, I actually think git got source control right exactly because it
didn't bother copying other existing systems. The other system's
solutions don't necessarily fit with git's model.
