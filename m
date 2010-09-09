From: Davi Reis <davi.reis@gmail.com>
Subject: Re: [PATCH 2/2] Added test from David Glasser.
Date: Thu, 9 Sep 2010 14:44:21 -0700
Message-ID: <AANLkTikrvX-BZFTDA3OyrNP7BZN99=Nb4i6=LMaBGX+-@mail.gmail.com>
References: <1284056514-4935-1-git-send-email-davi.reis@gmail.com>
	<1284056514-4935-2-git-send-email-davi.reis@gmail.com>
	<vpqk4muvbyt.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Sep 09 23:44:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Otouy-0006Cl-TR
	for gcvg-git-2@lo.gmane.org; Thu, 09 Sep 2010 23:44:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754728Ab0IIVoX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 9 Sep 2010 17:44:23 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:59768 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753792Ab0IIVoX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Sep 2010 17:44:23 -0400
Received: by bwz11 with SMTP id 11so1566896bwz.19
        for <git@vger.kernel.org>; Thu, 09 Sep 2010 14:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=zgRkoTSraJNMlvtYt1JiszUbG9SzIq6iPa2O93Bnn2Q=;
        b=KNVwQlACJRqu4ZXdzTbtlNtq0/B9DSsaeDDmIn+50ZTAeGaamn93IdT+OyYY/xFcAc
         R3baWeu3pYDVrq0Z9gTEUVAkGFRl2QDsQeybU8xB1L6GhO3ljTtE0lGmLwX+6MEQkj8I
         W5RDShngKqN7I6z1Q+N60FHJF0Bv+T9JPkNCc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=XmbNZC5s213KtcHQGmKkHt4XMnhbAeQpbmOumfSurWtpDdUjAKJE4eprc2b3Ss4CcO
         xWYQPlUj+O3HE8Dd7hLRJ9I9h+wITinZXLXjToBbZimrZizX0MbdmgbS8dNugW4MakNB
         rTB3ymBMSaJcUIWpf1BtCflQ4TXCZCqBoKOso=
Received: by 10.204.117.13 with SMTP id o13mr1489387bkq.48.1284068661374; Thu,
 09 Sep 2010 14:44:21 -0700 (PDT)
Received: by 10.204.76.20 with HTTP; Thu, 9 Sep 2010 14:44:21 -0700 (PDT)
In-Reply-To: <vpqk4muvbyt.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155906>

I will squash the patches and try again from scratch. Thanks Matthieu.

On Thu, Sep 9, 2010 at 2:33 PM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> davi.reis@gmail.com writes:
>
>> --- a/builtin/ls-tree.c
>> +++ b/builtin/ls-tree.c
>> @@ -52,7 +52,7 @@ static int show_recursive(const char *base, int ba=
selen, const char *pathname)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 speclen =3D strlen(spec);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (speclen <=3D len)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue;
>> - =A0 =A0 =A0 =A0 =A0 =A0 if (spec[len] !=3D 0 && spec[len] !=3D '/'=
)
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (spec[len] !=3D '/')
>
> This change is not the one advertized for in the title. If you didn't
> mean it, then
>
> =A0git send-email --annotate
>
> can be your friend, it gives you a last opportunity to check your
> patch before it is sent.
>
> If you did mean it, then it should be justified in the commit message=
=2E
>
>> --- a/t/t3100-ls-tree-restrict.sh
>> +++ b/t/t3100-ls-tree-restrict.sh
>> @@ -165,4 +165,13 @@ test_expect_success \
>> =A0EOF
>> =A0 =A0 =A0 test_output'
>>
>> +test_expect_success \
>> + =A0 =A0'ls-tree with one path a prefix of the other' \
>> + =A0 =A0'git ls-tree $tree path2/baz path2/bazbo >current &&
>> + =A0 =A0 make_expected <<\EOF &&
>> +040000 tree X =A0path2/baz
>> +120000 blob X =A0path2/bazbo
>> +EOF
>> + =A0 =A0 test_output'
>> +
>> =A0test_done
>
> Adding the test can help people to understand what the first patch is
> fixing, hence, I'd suggest either squashing both patches, or putting
> the test patch first (with a test_expect_failure), and having the
> second turn the test_expect_failure into a test_expect_success (hence=
,
> it's obvious reading the patch that it fixes the test).
>
> --
> Matthieu Moy
> http://www-verimag.imag.fr/~moy/
>



--=20
[]s
Davi de Castro Reis
