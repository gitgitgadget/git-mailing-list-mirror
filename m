From: Tor Arntsen <tor@spacetec.no>
Subject: Re: Minimum Perl version?
Date: Fri, 24 Sep 2010 13:22:15 +0200
Message-ID: <AANLkTiknAw5DwEDHQVJs96gEShky3rLYjyqpQy3MY=8Z@mail.gmail.com>
References: <20100924100019.GT23563@ece.pdx.edu>
	<AANLkTi=3xNSV0y-i=0KUSDRBJ8HmfSfGO7TBHTPiv_KM@mail.gmail.com>
	<AANLkTimUE=hyJ-y_XzpvCokb77KvRGw3gnM+9Xxui9tG@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Tait <git.git@t41t.com>, git@vger.kernel.org
To: =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 24 13:22:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oz6MA-0005Mk-Pr
	for gcvg-git-2@lo.gmane.org; Fri, 24 Sep 2010 13:22:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755488Ab0IXLWR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 24 Sep 2010 07:22:17 -0400
Received: from mail-qy0-f181.google.com ([209.85.216.181]:36738 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751139Ab0IXLWQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Sep 2010 07:22:16 -0400
Received: by qyk33 with SMTP id 33so3831125qyk.19
        for <git@vger.kernel.org>; Fri, 24 Sep 2010 04:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:sender:received
         :in-reply-to:references:date:x-google-sender-auth:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=ONd8EqyaO/AavvyfCSd6RsGvR6Z3aohOMUm3MkMq53c=;
        b=svESCFfXiULZZ6JO4wJ/FLfw7eUVynNqf0GRmq2iXQvhrljpV+IBicaDx15ymUolF1
         zzkAfgWx8T4FHSlSsgpCn2L6TzRXBsZtnsPrju786Yo8yMGSQ/e6GgPYeevhknlMoef1
         lu2brsTkIZcENWfx7tzFm0NuKSMJLkC8Vgb7E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=Nzs9Di8bVExPLHauVqgN4eemklVI6jrsqQoBkc+TZO6rOblc907/fVerFV6Y3/CH1h
         rtQBkOIg+VNESpYrBeMKMPtET+RenSxl5kR/0LvI4mBzfiMU68UF9eoonGvCfpwe2jw5
         ywAMA2UNc8RTFDHZ7rU7cRgHm3kS1QRuIyvEc=
Received: by 10.229.251.79 with SMTP id mr15mr2418759qcb.140.1285327335148;
 Fri, 24 Sep 2010 04:22:15 -0700 (PDT)
Received: by 10.229.62.98 with HTTP; Fri, 24 Sep 2010 04:22:15 -0700 (PDT)
In-Reply-To: <AANLkTimUE=hyJ-y_XzpvCokb77KvRGw3gnM+9Xxui9tG@mail.gmail.com>
X-Google-Sender-Auth: -5mPpqZvAo_WVJpopVXZBI6U7bI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156975>

On Fri, Sep 24, 2010 at 13:05, =C6var Arnfj=F6r=F0 Bjarmason <avarab@gm=
ail.com> wrote:
> On Fri, Sep 24, 2010 at 10:27, Tor Arntsen <tor@spacetec.no> wrote:
[..]
>> I've found that for add -p you'll need 5.8.x or newer, due to stuff =
like
>>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0my $fh =3D undef;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0open($fh, '-|', @_) or die;
>>
>> which fails in e.g. perl 5.6.
>> There could be some other stuff (in addition to add -p) that also do=
es
>> this kind of thing.
>
> If that's the case (I don't have a 5.6 here to do archeology on) then
> git add -p never worked in 5.6. That was added in 5cde71d6 when it wa=
s
> introduced in 2006:
>
> =A0 =A0+sub run_cmd_pipe {
> =A0 =A0+ =A0 =A0 =A0 my $fh =3D undef;
> =A0 =A0+ =A0 =A0 =A0 open($fh, '-|', @_) or die;
> =A0 =A0+ =A0 =A0 =A0 return <$fh>;
> =A0 =A0+}
>
> Can you show us the specific error you're getting, and the output of
> your `perl -V` ?

I don't have that particular installation anymore (I installed perl
5.8 on the machine I had trouble with), and the only other system I
have left with perl 5.6 only has an old Git 1.5 version. But it's easy
enough to reproduce, Perl 5.6 simply doesn't support that notation.
Put the code above in a perl script and execute it:

Can't use an undefined value as filehandle reference at test-pl.pl line=
 5.
(that's the 'open' line)

I can provide the output of -V if you wish, but I don't think it
matters really, except for the version:

"Summary of my perl5 (revision 5.0 version 6 subversion 1) configuratio=
n:"..
I.e. perl 5.6.1. The above is from Irix, the original installation I
ran Git on was AIX with Perl 5.6.1.

-Tor
