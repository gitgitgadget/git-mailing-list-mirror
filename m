From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH 12/15] gettextize: git-revert mark the "me" variable for translation
Date: Mon, 6 Sep 2010 20:06:34 +0000
Message-ID: <AANLkTik2aEYxgpL6QuhbacMv6i2hTNjJ1+0bFdK4tph-@mail.gmail.com>
References: <1283638229-14199-1-git-send-email-avarab@gmail.com>
	<1283775704-29440-13-git-send-email-avarab@gmail.com>
	<20100906184536.GD25426@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?Q?Jan_Kr=C3=BCger?= <jk@jk.gs>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 06 22:06:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oshxh-0005ts-U9
	for gcvg-git-2@lo.gmane.org; Mon, 06 Sep 2010 22:06:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754091Ab0IFUGg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Sep 2010 16:06:36 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:46556 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751052Ab0IFUGf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Sep 2010 16:06:35 -0400
Received: by iwn5 with SMTP id 5so4542334iwn.19
        for <git@vger.kernel.org>; Mon, 06 Sep 2010 13:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=1HBvOuPDWmOx/FqxbhEWzO7w3c7EEg4IefR2lZn1f2Y=;
        b=vX/QmY3mg7E9VgaxU1CXJHGl6SdlB2c2dP9L2ogpolbqVaN21rIHij/hZyynDqNy4f
         hANEO03QnGd+Yrzq30vu3fkfN6z2ACZyq8OdwkeRFSrIuCfjPge0xm6DxvwjreOd4e6N
         urkrWsSoDBIfGS16mkQn4v2m8JdPkbewsN3zM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=HueX6EEIHYB97X0IBnjV0mKrTFhkwb4mpP7e3lLd6lM3L5x6hTYF4R0/iutnFzxj4/
         AGIIvBLfjkCvXnAEDAPvuClHNq3Gve4gYWaHYhybHRf+y2ZFKyUFPIHWQSawvmBANjv0
         Xn36d2uFzt4d+jeyZBcz8NfeiCWgrJZdkTxJc=
Received: by 10.231.36.134 with SMTP id t6mr6628661ibd.128.1283803594918; Mon,
 06 Sep 2010 13:06:34 -0700 (PDT)
Received: by 10.231.171.145 with HTTP; Mon, 6 Sep 2010 13:06:34 -0700 (PDT)
In-Reply-To: <20100906184536.GD25426@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155606>

On Mon, Sep 6, 2010 at 18:45, Jonathan Nieder <jrnieder@gmail.com> wrot=
e:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>
>> The "me" variable is used in many later messages to indicate whether
>> we're using revert or cherry-pick.
>
> What good does it do to translate it? =C2=A0The command name is the s=
ame
> even in Hindi git.

Not all uses of it are references to git-%s, e.g. in the next patch:

    die(_("Your local changes would be overwritten by %s.\n"), _(me));

But maybe it's used in enough contexts for it to be useless to
translate it like this, i.e. we'll have to fix it later, but we'll see
about that.

>> --- a/builtin/revert.c
>> +++ b/builtin/revert.c
>> @@ -552,7 +552,9 @@ static int revert_or_cherry_pick(int argc, const=
 char **argv)
>> =C2=A0 =C2=A0 =C2=A0 struct rev_info revs;
>>
>> =C2=A0 =C2=A0 =C2=A0 git_config(git_default_config, NULL);
>> - =C2=A0 =C2=A0 me =3D action =3D=3D REVERT ? "revert" : "cherry-pic=
k";
>> + =C2=A0 =C2=A0 /* TRANSLATORS: This is used in several error messag=
es indicating
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0the name of the current program */
>> + =C2=A0 =C2=A0 me =3D action =3D=3D REVERT ? N_("revert") : N_("che=
rry-pick");
>> =C2=A0 =C2=A0 =C2=A0 setenv(GIT_REFLOG_ACTION, me, 0);
>
> Unrelated question: Are reflog actions supposed to be translated? =C2=
=A0(I
> have not thought about that carefully.)

In this updated series I've explicitly reverted patches that
(accidentally) translated some of the reflog.

I'm only translating things which'll be viewed by human eyes, and
human eyes alone. That doesn't apply to the reflog, which I see as
plumbing.
