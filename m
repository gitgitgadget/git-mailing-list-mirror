From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH/RFC 05/17] gettext: make the simple parts of git-init localizable
Date: Tue, 31 Aug 2010 16:05:16 +0000
Message-ID: <AANLkTimPndcAu7RTnzpB0LZ1bHpFC5-QxNkPPAkoD5Hc@mail.gmail.com>
References: <1283203703-26923-1-git-send-email-avarab@gmail.com>
	<1283203703-26923-6-git-send-email-avarab@gmail.com>
	<20100831150301.GE2315@burratino>
	<AANLkTikd7mc4DjTVaKip_WFqVdezE13ZbL+Vmfqd8yCu@mail.gmail.com>
	<20100831154446.GJ2315@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Marcin Cieslak <saper@saper.info>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 31 18:05:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OqTKw-0005a3-69
	for gcvg-git-2@lo.gmane.org; Tue, 31 Aug 2010 18:05:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751125Ab0HaQFT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 31 Aug 2010 12:05:19 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:49105 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750721Ab0HaQFR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 31 Aug 2010 12:05:17 -0400
Received: by fxm13 with SMTP id 13so4024184fxm.19
        for <git@vger.kernel.org>; Tue, 31 Aug 2010 09:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=rRhMiA3X9cEy6OuzwKdCClMi+gw+MW+MoYntPjB+eO4=;
        b=N15iZ4Scbw3kaQJKVJQF9UwvkABUNcSkDNRaeUbWUY719rvS6aYIdgbjrIcvUFWnvZ
         7JWRtWddGFkxS7gFU8NnkgybvOj4wRM3CgQhHUlixyGUM9n0VM9d8Xarb30ij9O9FnmK
         UiPvRf/1osyH4DkhXaxZRAUNhfqrHpINvNw8o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=KNSk8GzZ3f9H3+t3lH/aFpis4wp0LvO5GAcnr4M2dw+Fr78WAwBB+bQUrEFfhURHT0
         fiROW22JZMudf3i2Hm6ecGad119H4vph6mZ9UN50TJEo9B5R7SNrkQEgFbBI6ivFIfTG
         3ndLTCW70IbpCKf59n63xckNVftkMKWLh2zKM=
Received: by 10.223.124.9 with SMTP id s9mr5595644far.91.1283270716425; Tue,
 31 Aug 2010 09:05:16 -0700 (PDT)
Received: by 10.223.109.195 with HTTP; Tue, 31 Aug 2010 09:05:16 -0700 (PDT)
In-Reply-To: <20100831154446.GJ2315@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154928>

On Tue, Aug 31, 2010 at 15:44, Jonathan Nieder <jrnieder@gmail.com> wro=
te:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>
>> The only way that could work is if I taught xgettext to extract
>> strings passed to die(), but then managing the false positives would
>> probably be more effort than just marking them manually, and it woul=
d
>> be a big load on the translators:
>>
>> =C2=A0 =C2=A0 $ ack 'die\("(.*?)"' --output '$1' *[ch] builtin/*[ch]=
 | sort -u | wc -l
>> =C2=A0 =C2=A0 1153
>
> To pursue this a little further: would there be any false positives?

Maybe I can see a few probable plumbing messages here, but probably
nothing that's unmanagable: http://gist.github.com/559255

> We could avoid overwhelming translators by waiting until a file has
> been fulling gettextized before allowing xgettext to scavenge it
> (i.e., temporarily using a hard-coded list of files in the xgettext
> invocation).

Yeah we could go this route. But I'm a bit uneasy about it. The way
I'm doing it now I have to manually look at every message to determine
if it's a porcelain error or not.

But it's easier to accidentally mark something with a filelist like
that, or to mark a future plumbing die message that gets introduced
after a file has made the OK list.

Maybe we should have die_plumbing() and die_porcelain() functions to
indicate the nature of the message, although we could get the same
thing with die() and die(_()) once I'm done.

>>> Will strerror() cope correctly without LC_CTYPE set up? =C2=A0(Not =
part
>>> of this series, just something I was reminded of.)
>>
>> My GNU/Linux strerror(3) claims to use LC_MESSAGES, but I didn't tes=
t
>> it.
>
> Sounds like no, then.
>
> $ cat foo.c
> #include <stdio.h>
> #include <locale.h>
> #include <errno.h>
>
> int main(void)
> {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0setlocale(LC_ALL, "");
> =C2=A0 =C2=A0 =C2=A0 =C2=A0setlocale(LC_CTYPE, "C");
> =C2=A0 =C2=A0 =C2=A0 =C2=A0errno =3D ENODEV;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0perror("test");
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;
> }
> $ make foo
> cc =C2=A0 =C2=A0 foo.c =C2=A0 -o foo
> $ ./foo
> test: No such device
> $ LANG=3Dde_DE.UTF-8 ./foo
> test: Kein passendes Ger?t gefunden

What about with MESSAGES instead of ALL, like we're doing?

    setlocale(LC_MESSAGES, "");
    setlocale(LC_CTYPE, "C");

I don't have a box here with a localized C library to test it on.
