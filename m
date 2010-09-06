From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH v3 3/3] New send-email option smtpserveroption.
Date: Mon, 6 Sep 2010 09:27:17 +0000
Message-ID: <AANLkTi=gm6wZ_0Q5-0r+ZSFLMtCzgi0Ah7WFLBWfJer6@mail.gmail.com>
References: <1283708940-2172-1-git-send-email-pascal@obry.net>
	<1283708940-2172-4-git-send-email-pascal@obry.net>
	<m3lj7fn9oy.fsf@localhost.localdomain>
	<7vpqwrv0l2.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Pascal Obry <pascal@obry.net>, Jakub Narebski <jnareb@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 06 11:27:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OsXz2-0002on-7i
	for gcvg-git-2@lo.gmane.org; Mon, 06 Sep 2010 11:27:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751020Ab0IFJ1T convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Sep 2010 05:27:19 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:48074 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751007Ab0IFJ1S convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Sep 2010 05:27:18 -0400
Received: by iwn5 with SMTP id 5so4057793iwn.19
        for <git@vger.kernel.org>; Mon, 06 Sep 2010 02:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=/kLiLJFp9fMRzkKDVhZREt1VPMqIhxjjiiBFdAtJmjI=;
        b=ixbVRyaObCyb1LDwC2kcJPq+GLAs7zAQufijMDa3fbuEGqKkVr0omBPiiO61TsqMgX
         p1LD7cmMtQUWKECSZ3WscXjF3tsKKgY/15oeNN4AkqgE549qNGsb8m/1CDI/MW3hmDM2
         J/EuJ6BQ+NEIgdlykBpIIz/mNr5fSRKd4kfeo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=q4faLkIwFX1cra4m0J11HfMaCJUc1j/Y3tzuPYN2NiB8TJxmaYJpfmmvooFUU/RTwu
         MLFroH6WfQieSAtCm2n/k65Hq6iVko3Fpdy6Y6SFHAfBNjyhUCk5ZITqY3u8v/zW2mfm
         DXDBMycgb51YEAb0SWRObXzh4WV4r8YperElw=
Received: by 10.231.30.130 with SMTP id u2mr5722895ibc.111.1283765237405; Mon,
 06 Sep 2010 02:27:17 -0700 (PDT)
Received: by 10.231.171.145 with HTTP; Mon, 6 Sep 2010 02:27:17 -0700 (PDT)
In-Reply-To: <7vpqwrv0l2.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155546>

On Mon, Sep 6, 2010 at 06:38, Junio C Hamano <gitster@pobox.com> wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
>
>> Pascal Obry <pascal@obry.net> writes:
>>
>>> The new command line parameter --smtp-server-option or default
>>> configuration sendemail.smtpserveroption can be used to pass
>>> specific options to the SMTP server. Update the documentation
>>> accordingly.
>>
>> Sign-off? =C2=A0(See Documentation/SubmittingPatches).
>
> Thanks.
>
>>> ---
>>> =C2=A0Documentation/git-send-email.txt | =C2=A0 =C2=A08 ++++++++
>>> =C2=A0git-send-email.perl =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0| =C2=A0 =C2=A08 +++++++-
>>> =C2=A02 files changed, 15 insertions(+), 1 deletions(-)
>>
>> Needs update to Documentation/config.txt, adding line about
>> sendemail.smtpserveroption.
>
> And test if it is easy to arrange (otherwise I'll take a look myself,=
 so
> do not worry too much about it).
>
>>> diff --git a/Documentation/git-send-email.txt b/Documentation/git-s=
end-email.txt
>>> index c283084..5af05bc 100644
>>> --- a/Documentation/git-send-email.txt
>>> +++ b/Documentation/git-send-email.txt
>>> @@ -157,6 +157,14 @@ user is prompted for a password while the inpu=
t is masked for privacy.
>>> =C2=A0 =C2=A0 =C2=A0`/usr/lib/sendmail` if such program is availabl=
e, or
>>> =C2=A0 =C2=A0 =C2=A0`localhost` otherwise.
>>>
>>> +--smtp-server-option=3D<option>::
>>> + =C2=A0 =C2=A0If set, specifies the outgoing SMTP server option to=
 use.
>>> + =C2=A0 =C2=A0Default value can be specified by the 'sendemail.smt=
pserveroption'
>>> + =C2=A0 =C2=A0configuration option.
>>> ++
>>> +The --smtp-server-option option must be repeated for each option y=
ou want
>>> +to pass to the server.
>>
>> Just a nitpick.
>>
>> How do multiple options are supported with sendemail.smtpserveroptio=
n?
>> This also needs to be described, I think.
>
> That is a good and important point.
>
> We could
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0[sendemail]
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0smtpserveropti=
on =3D opt1
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0smtpserveropti=
on =3D opt2
>
> or if we choose to split at WS
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0[sendemail]
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0smtpserveropti=
on =3D "opt1 opt2"
>
> but with the second form there always is this nagging "how would you
> specify an option with WS in it" issue, so the former might be easier=
=2E
>
> If we take the latter route, we should take a single command line opt=
ion
> and split it, i.e. --smtp-server-option=3D'opt1 opt2', using the same=
 WS
> quoting mechanism, for consistency between command line and configura=
tion.
>
> I dunno. =C2=A0Have we solved a similar issue with other parts of the=
 system,
> and how?

I can tell you that I *didn't* solve a similar problem with t/harness:

         ? (test_args    =3D> [ split /\s+/, $ENV{GIT_TEST_OPTS} ])

That'll fail if the GIT_TEST_OPTS contains a space,
e.g. GIT_TEST_OPTS=3D'--root=3D"/tmp/a space"'. But I just ignored it a=
t
the time.

It would be useful for both of these if we had a str_to_options()
utility function in e.g. Git.pm. If nothing else it's probably more
user friendly to specify them in one smtpserveroption string, since
you can copy/paste an existing invocation then.

Maybe we can convince a POSIX shell (which we require anyway) to split
these up for us? Shelling out from Perl to split these up would be a
good solution if it can be done.

>>> @@ -1015,6 +1019,8 @@ X-Mailer: git-send-email $gitversion
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>>> =C2=A0 =C2=A0 =C2=A0}
>>>
>>> + =C2=A0 =C2=A0unshift (@sendmail_parameters, @smtp_server_options)=
;
>>> +
>>
>> I guess that you are following strange style that other 'unshift'
>> invocation uses, but there should be no space between function and
>> opening parentheses beginning its arguments, e.g.
>>
>> =C2=A0 join("\n", @xh)
>>
>> not
>>
>> =C2=A0 join ("\n", @xh)
>
> I tend to prefer shift/unshift/push/pop written without these
> parentheses. =C2=A0Is it just me?

It's not just you. The customary style in Perl is to avoid parentheses.
