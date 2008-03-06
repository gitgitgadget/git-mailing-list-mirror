From: "=?ISO-8859-1?Q?Santi_B=E9jar?=" <sbejar@gmail.com>
Subject: Re: [PATCH] user.default: New config to prevent using the default values for user.*
Date: Thu, 6 Mar 2008 09:08:09 +0100
Message-ID: <8aa486160803060008g4dc3cb8cg6bfce8d2f88461d3@mail.gmail.com>
References: <1204744684-2043-1-git-send-email-sbejar@gmail.com>
	 <7vr6eolv0r.fsf@gitster.siamese.dyndns.org>
	 <8aa486160803051433h2a5f0aeenaf473784198276f6@mail.gmail.com>
	 <7vwsogkckx.fsf@gitster.siamese.dyndns.org>
	 <8aa486160803051523t51a8294fwc55d9e41e61cc733@mail.gmail.com>
	 <7v7iggkavd.fsf@gitster.siamese.dyndns.org>
	 <8aa486160803051539v6813bf98kc0cd0408bb0c65a@mail.gmail.com>
	 <7v3ar4itk9.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 06 09:09:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JXB9x-0000dL-1r
	for gcvg-git-2@gmane.org; Thu, 06 Mar 2008 09:09:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751665AbYCFIIO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 6 Mar 2008 03:08:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751545AbYCFIIO
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Mar 2008 03:08:14 -0500
Received: from ti-out-0910.google.com ([209.85.142.185]:31347 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751553AbYCFIIN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 Mar 2008 03:08:13 -0500
Received: by ti-out-0910.google.com with SMTP id 28so2420816tif.23
        for <git@vger.kernel.org>; Thu, 06 Mar 2008 00:08:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=OiXRbyN5x1VXD+ft8CmyO1OEcfmypu23Lq+k2yw9Nxg=;
        b=keO4ZaiP9efFxgzcYmnzIKgCivS/QLfxpU6t+G6wZkEpWmLn0GudxkvraIo64jw7ky5xoyIh1YK20UuYWWdPQs7jcy5TGYQpRzmvKDHESjsmqbLk5rBmnNtdiob0xzXq8zNKoMjW7AYSVIJY05l+F9c4fiJ+Fwcwx6lsETnsUpE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=d2fLwSHWSp+NF6lUvi0Ja6k5KCJL36CODxxDwIyFrfPWCfSvCxvhxEWfCye8CT4DnBcVcz8yKji0FXSqIPfidZ/Ru8cXiEoM2DhQB5AnUep9UUOBBZtuv/WhxP6fSw8/5O3Vl9hueF2UlW0V45cdWLswy5KAKwe3bmze8YMdGRw=
Received: by 10.151.109.11 with SMTP id l11mr1743600ybm.171.1204790889607;
        Thu, 06 Mar 2008 00:08:09 -0800 (PST)
Received: by 10.150.199.9 with HTTP; Thu, 6 Mar 2008 00:08:09 -0800 (PST)
In-Reply-To: <7v3ar4itk9.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76353>

On Thu, Mar 6, 2008 at 1:29 AM, Junio C Hamano <gitster@pobox.com> wrot=
e:
>
> "Santi B=E9jar" <sbejar@gmail.com> writes:
>
>  > On Thu, Mar 6, 2008 at 12:29 AM, Junio C Hamano <gitster@pobox.com=
> wrote:
>  >> "Santi B=E9jar" <sbejar@gmail.com> writes:
>  >>
>  >> >>  > I would still need something to prevent doing a commit with=
out a
>  >>  >>  > locally specified name/email.
>  >>  >>
>  >>  >>  Yes, but that something could simply be "echo '[user] name'
>  >>  >>  >.git/config" in that hook, for example.
>  >>  >
>  >>  > But I want a different locally specified name in each reposito=
ry,
>  >>  > because I use different emails for different projects
>  >>  > (private/work/...).
>  >>
>  >>  You changed your mind then?  You said you wanted to have somethi=
ng that
>  >>  prevents a commit from being made immediately after git-init bef=
ore
>  >>  per-repo user.name is properly configured.  Doesn't that echo ac=
hieve that
>  >>  goal?
>  >
>  > But that was in the context of the initial patch where I said that=
 I
>  > wanted different name/emails in each repository.
>  >
>  > To summarize, the problem is that I work in different projects
>  > (private/work/git/...) using the same account, but I want differen=
t
>  > identifies (name/email) in each. So I set user.name and user.email=
 in
>  > each repository, but when I forget to set them git uses the defaul=
t
>  > ones (userid@hostname.(none)).
>  >
>  > Hope I have explained it well.
>
>  Try:
>
>         $ mkdir -p /var/tmp/junk && cd /var/tmp/junk
>         $ git init
>
>         $ echo '[user] name' >>.git/config
>         $ >foo
>         $ git add
>
>  and tell me what you see.

Every single command fails because it no longer a valid git repository.

>
>  That's why I gave you the example of setting "[user] name"
>  (notice I did not say [user] name =3D 'Santi's name for this project=
')
>  to force you to configure it to whatever you want.

But then I have to configure in all the repositories, even the ones I
do not develop.

Santi
