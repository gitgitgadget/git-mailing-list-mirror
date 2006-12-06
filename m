X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: bug: git-sh-setup should not be in $PATH
Date: Wed, 6 Dec 2006 16:56:55 +0100
Message-ID: <200612061656.55888.jnareb@gmail.com>
References: <el6c6o$oa7$1@sea.gmane.org> <200612061627.40359.jnareb@gmail.com> <4576E38F.1020404@xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Wed, 6 Dec 2006 15:54:58 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=BhvO5eBD350VU1P37iz1tzITr85oZf13wzgbVzLKVFwnPuhquGQe7OXRyw+7HpqULuk/1js4rREfXdm1D0sJq1RxwYPwhz59baClAEnLEv8sBoRcZX0u4SA9cqS834IPEajf3jZYDV++xiRq0vBCiPMAT73zDaNw72sqtZwoc7k=
User-Agent: KMail/1.9.3
In-Reply-To: <4576E38F.1020404@xs4all.nl>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33479>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Grz6l-000784-7q for gcvg-git@gmane.org; Wed, 06 Dec
 2006 16:54:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S936090AbWLFPyw convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Wed, 6 Dec 2006 10:54:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936099AbWLFPyw
 (ORCPT <rfc822;git-outgoing>); Wed, 6 Dec 2006 10:54:52 -0500
Received: from ug-out-1314.google.com ([66.249.92.168]:24909 "EHLO
 ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S936090AbWLFPyv (ORCPT <rfc822;git@vger.kernel.org>); Wed, 6 Dec
 2006 10:54:51 -0500
Received: by ug-out-1314.google.com with SMTP id 44so181230uga for
 <git@vger.kernel.org>; Wed, 06 Dec 2006 07:54:49 -0800 (PST)
Received: by 10.66.232.9 with SMTP id e9mr1020824ugh.1165420489534; Wed, 06
 Dec 2006 07:54:49 -0800 (PST)
Received: from host-81-190-24-209.torun.mm.pl ( [81.190.24.209]) by
 mx.google.com with ESMTP id m1sm14851794uge.2006.12.06.07.54.48; Wed, 06 Dec
 2006 07:54:48 -0800 (PST)
To: Han-Wen Nienhuys <hanwen@xs4all.nl>
Sender: git-owner@vger.kernel.org

Dnia =B6roda 6. grudnia 2006 16:36, Han-Wen Nienhuys napisa=B3:
> Jakub Narebski escreveu:
[...]
>>>>> +  if test -f $srcdir/$d/Makefile ; then
>   [..]
>>>>> +    echo creating $d/Makefile
>>>>> +    cat << EOF> $d/Makefile
>=20
>>>> This part IMHO has no sense, and has no place here.
>>=20
>> If you want to create or modify Makefiles, do that. Not generate
>> "minimal" Makefiles in every and each subdirectory.
>=20
> Look more closely at the patch. It only generates Makefiles in=20
> directories that have makefiles in the source dir. The makefiles are
> short because that is the easiest to do.

The fact that I didn't understood what this part of patch is meant
to do should be the big hint that this commit needs some longer commit
message explaining purpose of such mess.

I still don't understand what this part do (and how come it is
in configure.ac which should be _only_ about generating=20
config.mak.autogen Makefile configuration file and _not_ about
generating Makefiles). You want what sequence of commands to work?

  $ $srcdir/configure --srcdir=3D$srcdir
  $ make -D $srcdir
  $ make -D $srcdir DESTDIR=3D$DESTDIR install

or what? Why this part is needed?

Once again: git is NOT autotool'ed project. And shouldn't be.

> I'm happy to amend the patch, but I can't properly test
> it until the perl problem gets sorted out.=20

I'll be waiting.

--=20
Jakub Narebski
