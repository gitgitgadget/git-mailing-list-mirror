From: =?UTF-8?Q?Cl=C3=A9ment_Poulain?= <clement.poulain@ensimag.imag.fr>
Subject: Re: [PATCH v2 1/4] sha1_name: add get_sha1_with_context()
Date: Wed, 9 Jun 2010 00:30:31 +0200
Message-ID: <AANLkTinI_ghLE5U3tQ0JFmvuU8DySLFtdl03sv0uW-Ab@mail.gmail.com>
References: <1276004958-13540-1-git-send-email-clement.poulain@ensimag.imag.fr>
	<1276004958-13540-2-git-send-email-clement.poulain@ensimag.imag.fr>
	<vpqiq5t5rvd.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	Diane Gasselin <diane.gasselin@ensimag.imag.fr>,
	Axel Bonnet <axel.bonnet@ensimag.imag.fr>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Jun 09 00:30:40 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OM7Jf-0007P8-7o
	for gcvg-git-2@lo.gmane.org; Wed, 09 Jun 2010 00:30:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932201Ab0FHWae convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 Jun 2010 18:30:34 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:62385 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756499Ab0FHWad convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 Jun 2010 18:30:33 -0400
Received: by wyf28 with SMTP id 28so490142wyf.19
        for <git@vger.kernel.org>; Tue, 08 Jun 2010 15:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:sender:received
         :in-reply-to:references:date:x-google-sender-auth:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=NalFEYfiby+zeHODgqC+/1mIJJOVIWm8D+oH6IMqdWU=;
        b=eZGg34FqgmQjS3FC/9ieHrH8qZozxNPmRhJjOqox5MNH48+o9Bm+Hb0xGZ7+JepkJr
         rscyVTTk9/Vtt/0ycMssXGlEd1JyKEaiVD8ceo8H+KXbUNOTwOz6F702YBsgDsk2Oo77
         +BbWYXoJtz9pxPs6qtiIgWQS0jz+YCFYfIq2Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=DkVxW4C8Blyoyw191MT1Zd+Ll5lrPGnj/76KISBeAN1gTsMPQb/JojJtHu9MaNslKo
         +282CXGtZLAyB8NyrtMguEvlz68j06RCI6OochyokCEAWZ2Gg82qB/eK5v/RaxIVCErM
         Vdd9cxjAULlnvq6lPbDUKhsDdvykdLIk/Sq5M=
Received: by 10.216.154.74 with SMTP id g52mr4097127wek.106.1276036231577; 
	Tue, 08 Jun 2010 15:30:31 -0700 (PDT)
Received: by 10.216.90.149 with HTTP; Tue, 8 Jun 2010 15:30:31 -0700 (PDT)
In-Reply-To: <vpqiq5t5rvd.fsf@bauges.imag.fr>
X-Google-Sender-Auth: niXpquEKaCGsEqiL8ztCv5pi6ZU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148730>

Le 8 juin 2010 19:57, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> a =C3=
=A9crit :
> This patch produces uncompilable code for me:
>
> cc1: warnings being treated as errors
> In file included from builtin.h:6,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 from fast-imp=
ort.c:147:
> cache.h: In function =E2=80=98get_sha1_with_context=E2=80=99:
> cache.h:748: error: implicit declaration of function =E2=80=98get_sha=
1_with_context_1=E2=80=99
>
> Forgot to add get_sha1_with_context_1 to cache.h?

Uh, we compiled it almost ten times on both our pc and ensibm (our
school server), whithout any problems. Seems that we need to check our
compilation configurations.

> I'm not an expert in struct initializers, but after doing experiments
> with GCC, this raises a warning
>
> builtin/cat-file.c:90: error: missing braces around initializer
> builtin/cat-file.c:90: error: (near initialization for =E2=80=98obj_c=
ontext.tree=E2=80=99)
>
> and the behavior is to flatten the arrays contained inside the
> structure. So, your OBJECT_CONTEXT_INIT initializes the 3 first bytes
> of tree to 0, and leaves other fields uninitialized.
>
> You probably want something like this instead if you want to
> initialize the whole struct:
>
> {{0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
> =C2=A00, 0, 0, 0, 0, 0, 0, 0, 0, 0}, "", 0}

As you pointed out in your second answer, initialization is maybe no
required, we have to check it tomorrow.
Otherwise, an easy way to do it can be something like :
void object_context_init(struct object_context *oc)
{
	memset(oc, 0, sizeof(*oc));
}

>> --- a/sha1_name.c
>> +++ b/sha1_name.c
>> @@ -933,8 +933,8 @@ int interpret_branch_name(const char *name, stru=
ct strbuf *buf)
>> =C2=A0 */
>> =C2=A0int get_sha1(const char *name, unsigned char *sha1)
>> =C2=A0{
>> - =C2=A0 =C2=A0 unsigned unused;
>> - =C2=A0 =C2=A0 return get_sha1_with_mode(name, sha1, &unused);
>> + =C2=A0 =C2=A0 struct object_context unused;
>> + =C2=A0 =C2=A0 return get_sha1_with_context(name, sha1, &unused);
>> =C2=A0}
>
> This changes doesn't seem harmful, but it doesn't seem useful to me
> either: get_sha1_with_mode still exists, right?

Right. But the aim was to skip one function call (see the call-stack be=
low)
_with_mode =3D> _with_mode_1 =3D> _with_context_1
whereas:
 _with_context =3D> _with_context_1

> What does orc stand for? I understand "oc" for "object context", but
> I'm curious about the r ;-).

"orc" was for "object resolve context". This is an artifact of our
previous version. We'll change it, it won't bother you no more ;-)

>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 orc->path[sizeof(orc->pa=
th)] =3D '\0';
>> +
>
> Isn't this an off-by-one? The last element of an array of size N is
> array[N-1] ...
>
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 orc->path[sizeof(orc->path)] =3D '\0';
>
> Same here.

That's true. Stupid error, we copied this line without checking it.
