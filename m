From: Ryan <ryanphilips19@googlemail.com>
Subject: Re: names using git config
Date: Thu, 25 Jun 2009 15:39:11 +0530
Message-ID: <376636be0906250309h6eb99296r4b81cf22985b690a@mail.gmail.com>
References: <376636be0906240958l70c81b68g83340556f2bf4eca@mail.gmail.com>
	 <vpqljnhv9w0.fsf@bauges.imag.fr>
	 <376636be0906242146h1d4c3b1q8c2e9af26f124af4@mail.gmail.com>
	 <7veit8kidz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 25 12:15:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MJlzm-0006aX-DQ
	for gcvg-git-2@gmane.org; Thu, 25 Jun 2009 12:15:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755941AbZFYKPo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 25 Jun 2009 06:15:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754367AbZFYKPo
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Jun 2009 06:15:44 -0400
Received: from mail-gx0-f222.google.com ([209.85.217.222]:64916 "EHLO
	mail-gx0-f222.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755973AbZFYKPm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 Jun 2009 06:15:42 -0400
X-Greylist: delayed 394 seconds by postgrey-1.27 at vger.kernel.org; Thu, 25 Jun 2009 06:15:42 EDT
Received: by gxk22 with SMTP id 22so531867gxk.13
        for <git@vger.kernel.org>; Thu, 25 Jun 2009 03:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Uly6LgESllCCmnlsCK5CTL49RANhUydrb5esfxVfUWY=;
        b=Jmoe6hRdvTNXRrEOqUnNAXDriS+1lKPQgNan3pHPEyEXM3glxLBpeLrJ0BfFV90JpK
         6eAx34DYL3N+gqU6YHBoHX34/V04eblK64Ej0nkwrCjJmxuKupzjvv2/X5PpP7K5eVc5
         EukOypAnQgNw1rzPwH7ix5NPpbC/Rqcsqc5r0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=MWD+k1DfMiTwU5DDUTu2Hb9KFE7KyQHuEOzEvy8YkqRvtzCWNhxuxmGBKi/gnlwKKi
         JbXzxeeyYo6lfrCKqRj2ui+0uIBXzu7P+n4FTt0wnVLeBR3zZn6fmz8o8D5uUKBBROsh
         tNx1MmhbyqwaetQU4mLw2u77ZYFDcLyoQYO2k=
Received: by 10.231.16.134 with SMTP id o6mr809841iba.11.1245924551380; Thu, 
	25 Jun 2009 03:09:11 -0700 (PDT)
In-Reply-To: <7veit8kidz.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122193>

On Thu, Jun 25, 2009 at 10:41 AM, Junio C Hamano<gitster@pobox.com> wro=
te:
> Ryan <ryanphilips19@googlemail.com> writes:
>
>> Hi,
>> =A0 Thank you for your response.
>>
>> 1) git config user.name 'Matthieu M. Moy' Works
>> 2) git config user.name 'Matthieu M.' =A0does not
>>
>> Name cannot end in a '.' <dot>. in git config user.name
>
> That is correct, but I think we are a bit too strict in sanitizing na=
mes.
> The code is ident.c::copy() whose intent was to sanitize useless runs=
 of
> commas we slurp from GECOS field, but the sanitization is done also f=
or
> anything specified by the end user.
>


What are you suggesting me to do? Apply the below patch.
I may want to submit patches to the linux kernel. Is this okay? Or
will this (below patch)
on machine will later at some point of time cause trouble to people
applying the patches.

Does git am or git apply check if name ends in a "." and do something?


Thank you,

Ryan W.





> This patch loosens it, but I think it goes too far, in that it does n=
ot
> stop you from feeding total nonsense with GIT_AUTHOR_NAME environment=
 and
> user.name configuration.
>
> =A0ident.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A05 ++---
> =A0t/t1300-repo-config.sh | =A0 12 ++++++++++++
> =A02 files changed, 14 insertions(+), 3 deletions(-)
>
> diff --git a/ident.c b/ident.c
> index 99f1c85..07ec81d 100644
> --- a/ident.c
> +++ b/ident.c
> @@ -212,8 +212,7 @@ const char *fmt_ident(const char *name, const cha=
r *email,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pw =3D getpwuid(getuid());
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (!pw)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0die("You don't exist. =
Go away!");
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 strlcpy(git_default_name, pw->pw_name,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sizeof(git_default_name=
));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 copy(git_default_name, sizeof(git_defau=
lt_name), 0, pw->pw_name);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0name =3D git_default_name;
> =A0 =A0 =A0 =A0}
>
> @@ -221,7 +220,7 @@ const char *fmt_ident(const char *name, const cha=
r *email,
> =A0 =A0 =A0 =A0if (!name_addr_only && date_str)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0parse_date(date_str, date, sizeof(date=
));
>
> - =A0 =A0 =A0 i =3D copy(buffer, sizeof(buffer), 0, name);
> + =A0 =A0 =A0 i =3D add_raw(buffer, sizeof(buffer), 0, name);
> =A0 =A0 =A0 =A0i =3D add_raw(buffer, sizeof(buffer), i, " <");
> =A0 =A0 =A0 =A0i =3D copy(buffer, sizeof(buffer), i, email);
> =A0 =A0 =A0 =A0if (!name_addr_only) {
> diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
> index 43ea283..c1a913e 100755
> --- a/t/t1300-repo-config.sh
> +++ b/t/t1300-repo-config.sh
> @@ -758,4 +758,16 @@ test_expect_success 'check split_cmdline return'=
 "
> =A0 =A0 =A0 =A0test_must_fail git merge master
> =A0 =A0 =A0 =A0"
>
> +test_expect_success 'name ending in dot' '
> + =A0 =A0 =A0 foobar=3D"Foo Bar."
> + =A0 =A0 =A0 git config user.name "$foobar" &&
> + =A0 =A0 =A0 git config user.email "foo.bar@example.com" &&
> + =A0 =A0 =A0 test "$(git config user.name)" =3D "$foobar" &&
> + =A0 =A0 =A0 (
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 unset GIT_AUTHOR_NAME
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ident=3D$(git var GIT_AUTHOR_IDENT | se=
d -e "s/ *<.*//") &&
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 test "$ident" =3D "$foobar"
> + =A0 =A0 =A0 )
> +'
> +
> =A0test_done
>
