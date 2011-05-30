From: =?ISO-8859-1?Q?J=E9r=E9mie_NIKAES?= <jeremie.nikaes@gmail.com>
Subject: Re: Git fast-import : Warning duplicated ref: refs/remotes/origin/master
Date: Mon, 30 May 2011 21:55:35 +0200
Message-ID: <BANLkTi=t-TpbsWP2mhkDnRgMw8p2jJC=nw@mail.gmail.com>
References: <BANLkTinTuEppMGO16z2sMkjV8FveCbrwEQ@mail.gmail.com>
 <20110529232405.GA8369@elie> <BANLkTinhH7ksP8EZV+Sd4ryCT1_bhVhgaw@mail.gmail.com>
 <20110530173517.GA13539@elie> <vpqzkm4gef2.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Sylvain Boulme <Sylvain.Boulme@imag.fr>,
	Mike Hommey <mh@glandium.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon May 30 21:56:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QR8ZF-0001ci-P6
	for gcvg-git-2@lo.gmane.org; Mon, 30 May 2011 21:56:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757683Ab1E3Tz5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 May 2011 15:55:57 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:51750 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752196Ab1E3Tz4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 May 2011 15:55:56 -0400
Received: by pwi15 with SMTP id 15so1753509pwi.19
        for <git@vger.kernel.org>; Mon, 30 May 2011 12:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=w40MJxL4QZxyk4M0RKO/U5juH6wZE0MNL5/02R32ki8=;
        b=CZvjaQr3pSJs04FuXUfnVLCpaMXC8V+PDmNgrr+w+f8Fo9+9fFl2fYHTM4E1jPrnk4
         7NJ2SyRNMgjDxLDhVJfdckVEjoTJwrttT9Seu030hw3RkS5upF4joM9YputYWe2mZYqe
         DZCq9WRUdcq4Xw0CkMW1XDtsasYSgrBcDkOAc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=FOr8wv0+dXczUp/t0jqV1QS/GLABijSDDxzVkBfNot/Q4qUACnjUl03pse7s1vLlY5
         hoIfJgjGUFkvSl2EOwgMZm3esL6dyog43CdL5MXZA7XBcXiufxmLR2CqgGzcvIRBeBdP
         BZj5jgiX2mijB44+/4GXmEp7YlUjHxy6oJFKE=
Received: by 10.142.250.6 with SMTP id x6mr756567wfh.243.1306785355863; Mon,
 30 May 2011 12:55:55 -0700 (PDT)
Received: by 10.142.234.5 with HTTP; Mon, 30 May 2011 12:55:35 -0700 (PDT)
In-Reply-To: <vpqzkm4gef2.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174772>

2011/5/30 Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>:
> Jonathan Nieder <jrnieder@gmail.com> writes:
>
>> J=E9r=E9mie NIKAES wrote:
>>
>>> No, I actually still have the problem. The version commited on gith=
ub
>>> is pulling revisions straight to refs/heads/master which is gross
>>> After discussing this matter with our teacher Matthieu Moy, I wante=
d
>>> to change this to refs/remotes/origin/master but then this warning
>>> gets thrown.
>>
>> The following fixes it for me.
>
> It seems it does, thanks!
>
> clone does not give the warning anymore, and incremental pull work.
>

Yes ! It definitely does ! Works like a charm.

>> =A0sub mw_capabilities {
>> =A0# =A0 =A0print STDOUT "fetch\n";
>> + =A0 =A0 print STDOUT "refspec refs/heads/*:refs/mediawiki/$remoten=
ame/*\n";
>
> Is this "mediawiki" comming from the URL (mediawiki::...), or is it j=
ust
> a convention you've set?
>
> We've tried with refspec refs/heads/*:refs/remotes/origin/*, but with=
out
> success.
>
> Do I understand correctly that the "pull" is done in 3 stages:
>
> 1) import into refs/mediawiki/origin
>
> 2) fetch the imported ref into refs/remotes/origin
>
> 3) and merge as usual into the current branch
>
> ?
>
> If so, I don't understand why the distinction between 1) and 2) is
> necessary, and why not to fetch directly into refs/remotes/origin/. I=
OW,
> in which case is refs/remotes/origin/master different from
> refs/mediawiki/origin/master for example?
>
> Thanks,

We just committed this change to our master branch on github. We
actually have the same questions as Matthieu. We don't really
understand why we have to use another ref to make it work.

Huge thanks to you,

--=20
J=E9r=E9mie Nikaes
