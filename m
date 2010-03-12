From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 00/12] Support columinized output in tag/branch/ls-files/grep
Date: Fri, 12 Mar 2010 11:22:26 +0700
Message-ID: <fcaeb9bf1003112022md32ababv3e4ace04752f8f56@mail.gmail.com>
References: <1267963785-473-1-git-send-email-pclouds@gmail.com> 
	<4B9504C9.5000703@lsrfire.ath.cx> <fcaeb9bf1003080632o622c8c79x85b816edcf893bc3@mail.gmail.com> 
	<4B967C36.90309@lsrfire.ath.cx> <fcaeb9bf1003091627p65ad6e60u4bbae2eb4e859f13@mail.gmail.com> 
	<4B995D0C.2090000@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Fri Mar 12 05:22:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NpwOk-0000nm-7f
	for gcvg-git-2@lo.gmane.org; Fri, 12 Mar 2010 05:22:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753064Ab0CLEWs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 11 Mar 2010 23:22:48 -0500
Received: from mail-px0-f198.google.com ([209.85.216.198]:47669 "EHLO
	mail-px0-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752793Ab0CLEWr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 11 Mar 2010 23:22:47 -0500
Received: by pxi36 with SMTP id 36so312678pxi.21
        for <git@vger.kernel.org>; Thu, 11 Mar 2010 20:22:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=WAfBDkRPpiVXkYvQKtjvYt8jxPQwfMa3Uuaa0WjMreY=;
        b=YYP90tB9RByJx4gPLbcvn8ufhrBkdkEcHNbVrOM6RMOOzsVo2iCNFTXIHe4y8O9jl6
         LyOfjDZ4NJu0J1OakmUKyEEbZ9TWL5nPwS1QrWGKPbEHzxc5GsohWMaWh2I9wdz95plI
         noZ2rethZeVvDAQpGd9AIroERAvtjtr+XYK20=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=ZM83pM6iGbjT7mcqihPJqqIhCMD1Bqq2FEVs7SELhxQ4OfQSgIWv33WNY1bO57nb7R
         agRDW0oJShjhbGxWvKwgPoizQkKR/jHaVjCyW1XMIcK0oigvywiMMqkAr+VFj5PASDO2
         H550pBS5n2Ay6yZSOzAYe2Cr8LpXkLBOwVQws=
Received: by 10.115.64.21 with SMTP id r21mr2023322wak.23.1268367766521; Thu, 
	11 Mar 2010 20:22:46 -0800 (PST)
In-Reply-To: <4B995D0C.2090000@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142013>

On Fri, Mar 12, 2010 at 4:13 AM, Ren=C3=A9 Scharfe
<rene.scharfe@lsrfire.ath.cx> wrote:
> Am 10.03.2010 01:27, schrieb Nguyen Thai Ngoc Duy:
>> On 3/9/10, Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> wrote:
>>> =C2=A0With "more complicated", do you perhaps mean what GNU ls does=
, namely
>>> =C2=A0having non-uniform column widths? =C2=A0I never consciously n=
oticed that it
>>> =C2=A0actually goes out of its way to cram as may columns on the sc=
reen as
>>> =C2=A0possible, it just feels so natural. :)
>>
>> That. And aligned grep output like this
>>
>> pclouds@do ~/w/git/builtin $ git grep -n 38
>> count-objects.c =C2=A0| =C2=A035 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0if (cp - ent->d_name !=3D 38)
>> count-objects.c =C2=A0| =C2=A039 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0memcpy(path + len + 3,
>> ent->d_name, 38);
>> count-objects.c =C2=A0| =C2=A059 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0memcpy(hex+2, ent->d_name, 38);
>> fsck.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 405 | =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (strlen(de->d_name) =3D=3D 38) {
>> gc.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 112 | =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (strspn(ent->d_name,
>> "0123456789abcdef") !=3D 38 ||
>> gc.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 113 | =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ent->d_name[38]=
 !=3D '\0')
>> prune-packed.c =C2=A0 | =C2=A024 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0if (strlen(de->d_name) !=3D 38)
>> prune-packed.c =C2=A0 | =C2=A026 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0memcpy(hex+2, de->d_name, 38);
>> prune-packed.c =C2=A0 | =C2=A031 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0memcpy(pathname + len, de->d_name, 38);
>> prune.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A064 | =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (strlen(de->d_name) =3D=3D=
 38) {
>> receive-pack.c =C2=A0 | 588 | =C2=A0 =C2=A0 =C2=A0 =C2=A0char hdr_ar=
g[38];
>> upload-archive.c | =C2=A086 | =C2=A0 =C2=A0 =C2=A0 =C2=A0char buf[16=
384];
>
> Hmm, I'm not sure that this columnizing is very useful in this instan=
ce.
> =C2=A0You can more easily compare the line numbers and the indent lev=
el of
> the hits, but both pieces of information are only useful in the conte=
xt
> of the file, so this easier comparison doesn't buy you much.

It's useful when I need to look at the beginning of matched lines.
With current output, all lines are not aligned, so it's hard too see
where lines begin.

> Another possible use might be the list of untracked files shown by
> status and commit, by the way.

Thanks.

>>> I don't see any benefit of an environment variable over config opti=
ons.
>>
>> Currently we may pass --column=3D<foo> from a porcelain to "git colu=
mn
>> --mode=3D<foo>", <foo> could be column first, or row first, or eithe=
r
>> with non-uniform columns (not implemented yet). We can also pass oth=
er
>> things to "git column". Putting everything in "<foo>" is OK, althoug=
h
>> looks ugly. In my private tree, I also have "git column
>> --min-rows/--max-items" that forces the columnizer to one column mod=
e
>> if:
>> =C2=A0- there will be only one or two rows after columnized, too wid=
e
>> screen for example (--min-rows)
>
> Well, I can't imagine when I would want to use this option. =C2=A0If =
I'm OK
> with n + 100 items being displayed in x columns, I'd certainly be OK
> with n items being displayed the same way, even if they only take up =
a
> single row.

It's probably just me. With 279 character-wide terminal, I find it
much easier to look vertically than 16 items on a single row.

>> =C2=A0- too many lines and the layout has not been fixed, so nothing=
 gets
>> printed (--max-items). Forcing back to one column mode to stop wait
>> time.
>
> Interesting idea, but I'm not sure if I'd want to use it, too. =C2=A0=
Best
> effort pretty-printing combines fast output and optimized display at
> first glance. =C2=A0However, if there are lots of items then the user=
 would
> benefit the most from having them columnized.
>
> If it takes too long to show the first line of output (since the
> columnizer needs to wait for all items to be generated) then the comm=
and
> should only columnize on request.

Yeah. That's the idea of "core.columns =3D auto". If you specify
--[no-]columns on command line, then it must do as you wish. However,
if you set "core.columns =3D auto" without additional command line
arguments, then it only shows column layout when it's good to do.
--=20
Duy
