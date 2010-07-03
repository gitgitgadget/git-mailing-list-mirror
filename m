From: =?ISO-8859-1?B?wXNoaW4gTOFzemzz?= <ashinlaszlo@gmail.com>
Subject: Re: [PATCH] git-cvsserver: pserver-auth-script
Date: Sat, 3 Jul 2010 11:28:40 +0200
Message-ID: <AANLkTinLgbrd-tOLntZt-FZkGVtTHXU2lteB-t7NAjSm@mail.gmail.com>
References: <20100702095406.7af15d20@ashinlaszlo.pta.neti.hu> 
	<AANLkTinGZsCLF8CFKgQJaB63Jh9anGfQK4ZSHFPl4R4N@mail.gmail.com> 
	<m31vbloa6m.fsf@localhost.localdomain> <AANLkTimts_MlrWGKaiu3frk7vOnK9B70RE7It2Wml3on@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>,
	=?ISO-8859-1?B?TOFzemzzIMFTSElO?= <laszlo.ashin@neti.hu>,
	git@vger.kernel.org
To: =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 03 11:29:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OUz25-00021e-PK
	for gcvg-git-2@lo.gmane.org; Sat, 03 Jul 2010 11:29:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753680Ab0GCJ3E convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 3 Jul 2010 05:29:04 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:43296 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751775Ab0GCJ3B convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 3 Jul 2010 05:29:01 -0400
Received: by fxm14 with SMTP id 14so2827413fxm.19
        for <git@vger.kernel.org>; Sat, 03 Jul 2010 02:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=gtmHebyQ4kRmDWL1XqunsfByjmPTs1bXYCjbkRH2/YY=;
        b=dj3UW+4n6q/opu3sUlXs1UkTVX/FjgU7uIoUnWj2IBlija6jEOtl5adQnkfp1OElUa
         0qYOCleag+FZc6dXHxGhZ+hlB13wyOvboOrwzvcLFQUDQu1Y1wYG3N/JjsUCmg3KBKNG
         1OI2thOacluFlo2BJSSPaOsbgSkkMP1orMWDc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=udT4eKzW6gQkKNDyFYVS+ox/6XiUtCtiLx2yQZMH+5mjUgBBOkAuiKcERAQ450hrkG
         BIfMNxtnKP9pTPRwpqokFerBQFVqXs+W83BvyNVAFzNvQiVtB60yd1z1T/UqQtR0J0Y7
         eGEStG8q5hCI1KmLjB6KJecsKW3hFI9FepAFM=
Received: by 10.103.218.4 with SMTP id v4mr11009muq.95.1278149340154; Sat, 03 
	Jul 2010 02:29:00 -0700 (PDT)
Received: by 10.103.225.9 with HTTP; Sat, 3 Jul 2010 02:28:40 -0700 (PDT)
In-Reply-To: <AANLkTimts_MlrWGKaiu3frk7vOnK9B70RE7It2Wml3on@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150185>

Hi,

On Fri, Jul 2, 2010 at 23:34, =C6var Arnfj=F6r=F0 Bjarmason <avarab@gma=
il.com> wrote:
> On Fri, Jul 2, 2010 at 21:31, Jakub Narebski <jnareb@gmail.com> wrote=
:
>> =C6var Arnfj=F6r=F0 Bjarmason <avarab@gmail.com> writes:
>>> On Fri, Jul 2, 2010 at 07:54, L=E1szl=F3 =C1SHIN <laszlo.ashin@neti=
=2Ehu> wrote:
>>>
>>> > +
>>> > + =A0 =A0 =A0 =A0 =A0 =A0open SCRIPTIN, '|' . $authscript or die =
$!;
>>> > + =A0 =A0 =A0 =A0 =A0 =A0print SCRIPTIN $user . "\n";
>>> > + =A0 =A0 =A0 =A0 =A0 =A0print SCRIPTIN descramble($password) . "=
\n";
>>> > + =A0 =A0 =A0 =A0 =A0 =A0close SCRIPTIN;
>>>
>>> Nit: Nice use of three-arg open, but you should use lexical
>>> filehandles instead. I.e.:
>>>
>>> =A0 =A0 open my $script, '|' . $authscript or die $!;
>>> =A0 =A0 ...
>>
>> This is two-argument open, not three-argument magic open. =A0There i=
s
>> string concatenation operator '.' there, not a comma ',' delimiting
>> arguments.
>
> Well spotted, I misread that.
>
>> It should be
>>
>> =A0 open my $script_fd, '|-', $authscript
>> =A0 =A0 =A0 =A0or die "Couldn't open authentication script '$authscr=
ipt': $!";
>>

It will be fixed, I will resend the patch.


>>> > + =A0 =A0 =A0 =A0} else {
>>> > + =A0 =A0 =A0 =A0 =A0 =A0if (not exists $cfg->{gitcvs}->{authdb})=
 {
>>
>> Why not elsif?

Because the else branch continues below. But good point, it can be
done that way too. Will be fixed.


>>
>>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0print "E the repo config file ne=
eds a [gitcvs] section with an 'authdb' parameter set to the filename o=
f the authentication database\n";
>>
>> Overly long line. =A0Perhaps it would be better to split it into
>> concatenated parts.
>>

OK. Next patch will be fixed from this point of view as well.


>>
>>> > + =A0 =A0 =A0 =A0 =A0 =A0my $auth_ok;
>>> > + =A0 =A0 =A0 =A0 =A0 =A0open my $passwd, "<", $authdb or die $!;
>>
>> And here you use three-argument form of (ordinary) open.
>
> This and the code below were already part of the code. But the patch
> would be better if it didn't move so much code around so that this
> would be obvious.
>

I wanted to keep the old functionality (authdb), so I moved all of its
code to this else branch. That move meant I had to increase
indentation level. But as far as I see now I could have solved it
somehow else to keep the indentation level. I will fix this too.


>>> > + =A0 =A0 =A0 =A0 =A0 =A0while (<$passwd>) {
>>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (m{^\Q$user\E:(.*)}) {
>>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (crypt($user, descram=
ble($password)) eq $1) {
>>
>> Why nested if, and not short-circuit &&?
>>
>> =A0 =A0+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (/^\Q$user\E:(.*)/ &&
>> =A0 =A0+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0crypt($user, descram=
ble($password)) eq $1) {
>>

Good point, but it is not my code.

So, I will resend this patch - the corrected one without the mistakes
I taken in the first version of it.
Should I make one patch for each of the code, doc, and test case, or
can they all go into one patch?

Regards,
L=E1szl=F3 =C1SHIN
