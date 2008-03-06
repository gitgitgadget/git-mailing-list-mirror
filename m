From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] user.default: New config to prevent using the default
 values for user.*
Date: Wed, 05 Mar 2008 16:29:10 -0800
Message-ID: <7v3ar4itk9.fsf@gitster.siamese.dyndns.org>
References: <1204744684-2043-1-git-send-email-sbejar@gmail.com>
 <7vr6eolv0r.fsf@gitster.siamese.dyndns.org>
 <8aa486160803051433h2a5f0aeenaf473784198276f6@mail.gmail.com>
 <7vwsogkckx.fsf@gitster.siamese.dyndns.org>
 <8aa486160803051523t51a8294fwc55d9e41e61cc733@mail.gmail.com>
 <7v7iggkavd.fsf@gitster.siamese.dyndns.org>
 <8aa486160803051539v6813bf98kc0cd0408bb0c65a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?Q?Santi_B=C3=A9jar?= <sbejar@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 06 01:30:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JX40E-0005Gt-WE
	for gcvg-git-2@gmane.org; Thu, 06 Mar 2008 01:30:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763036AbYCFA3Z convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 5 Mar 2008 19:29:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763015AbYCFA3Y
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Mar 2008 19:29:24 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:63058 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759009AbYCFA3U convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 5 Mar 2008 19:29:20 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id D707532AF;
	Wed,  5 Mar 2008 19:29:18 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 1AD9B32AD; Wed,  5 Mar 2008 19:29:13 -0500 (EST)
In-Reply-To: <8aa486160803051539v6813bf98kc0cd0408bb0c65a@mail.gmail.com>
 (Santi =?utf-8?Q?B=C3=A9jar's?= message of "Thu, 6 Mar 2008 00:39:29 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76300>

"Santi B=C3=A9jar" <sbejar@gmail.com> writes:

> On Thu, Mar 6, 2008 at 12:29 AM, Junio C Hamano <gitster@pobox.com> w=
rote:
>> "Santi B=C3=A9jar" <sbejar@gmail.com> writes:
>>
>> >>  > I would still need something to prevent doing a commit without=
 a
>>  >>  > locally specified name/email.
>>  >>
>>  >>  Yes, but that something could simply be "echo '[user] name'
>>  >>  >.git/config" in that hook, for example.
>>  >
>>  > But I want a different locally specified name in each repository,
>>  > because I use different emails for different projects
>>  > (private/work/...).
>>
>>  You changed your mind then?  You said you wanted to have something =
that
>>  prevents a commit from being made immediately after git-init before
>>  per-repo user.name is properly configured.  Doesn't that echo achie=
ve that
>>  goal?
>
> But that was in the context of the initial patch where I said that I
> wanted different name/emails in each repository.
>
> To summarize, the problem is that I work in different projects
> (private/work/git/...) using the same account, but I want different
> identifies (name/email) in each. So I set user.name and user.email in
> each repository, but when I forget to set them git uses the default
> ones (userid@hostname.(none)).
>
> Hope I have explained it well.

Try:

        $ mkdir -p /var/tmp/junk && cd /var/tmp/junk
        $ git init
        $ echo '[user] name' >>.git/config
        $ >foo
        $ git add

and tell me what you see.

That's why I gave you the example of setting "[user] name"
(notice I did not say [user] name =3D 'Santi's name for this project')
to force you to configure it to whatever you want.
