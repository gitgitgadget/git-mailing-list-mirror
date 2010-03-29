From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v7 1/2] Documentation/remote-helpers: Rewrite
 description
Date: Mon, 29 Mar 2010 01:39:53 -0500
Message-ID: <20100329063952.GA20360@progeny.tock>
References: <f3271551003281103x68812b3cj806d6235965f0a32@mail.gmail.com>
 <4BAFFFAB.4080808@gmail.com>
 <alpine.LNX.2.00.1003290055000.14365@iabervon.org>
 <f3271551003282318vc256d20j90bb83170b0a983@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Gabriel Filion <lelutin@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Git Mailing List <git@vger.kernel.org>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 29 08:40:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nw8dk-000837-VM
	for gcvg-git-2@lo.gmane.org; Mon, 29 Mar 2010 08:40:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752859Ab0C2Gj4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 29 Mar 2010 02:39:56 -0400
Received: from mail-gx0-f217.google.com ([209.85.217.217]:41270 "EHLO
	mail-gx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752633Ab0C2Gjz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Mar 2010 02:39:55 -0400
Received: by gxk9 with SMTP id 9so1384413gxk.8
        for <git@vger.kernel.org>; Sun, 28 Mar 2010 23:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=Qphbl9BMI6+p4ToqLNKakmbQxniQih7jSpkqw4KmeLE=;
        b=ZvWdEbESTckCOTpJvz+WSA2XSGpLMaG8LrFMnHqEufRc+0zl6I4UHu6+9t+T1/4nIE
         u0I0Wmugnf7p9nWkoEuAT5AGrVml5VOxobQwcR4uwjPChbIwF2WEIKnQ7VlRqeDvd0Cz
         t6i/oEjtn6CGkqxiAUCaHhke0kmpW5uUJFoG8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=nXK0WCbgtfMtNocYtjQOFoTWxBnRPk4tc0iK06y5maogTRNDNp9RFNeRyZ/Qhab77C
         z2A+YExYQjIEKEqKs1f2OPAOyQ8nlgQQWdvi0B/gdqZqFlLuotNQdgkLjYePEuxB5c1U
         CGW1+a7FBcY9xTiJjpESt9+sLxsS9F7Wig+Sw=
Received: by 10.150.179.9 with SMTP id b9mr2627978ybf.125.1269844794476;
        Sun, 28 Mar 2010 23:39:54 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 21sm3705489iwn.7.2010.03.28.23.39.53
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 28 Mar 2010 23:39:53 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <f3271551003282318vc256d20j90bb83170b0a983@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143444>

Ramkumar Ramachandra wrote:

>> I think it would be better to document that
>> part in the documentation of the code and programs that call the hel=
per,
>> not in the helper documentation.
[...]
> Unfortunately, I don't see where else this documentation can fit in:
> if it were to go into a specific remote helper's code, then it'll hav=
e
> to be duplicated for all the remote helpers, since all of them parse
> options similarly.

One possibility: new manpage, called giturl(7) or something, with:

 - the information from your patch, reformatted a little to be from
   the caller=E2=80=99s perspective;

 - the information currently in the GIT URLS and REMOTES sections=20
   of git-pull(1) and and other urls-remotes.txt includers;

 - pointers to appropriate high-level and low-level documentation
   for more information.

This would at least avoid some duplication of text in explaining how
the [remote "<name>"] setups work.

> It certainly cannot go into remote.c or
> transport-helper.c, because they have little/ nothing to do with the
> actual argument parsing.

One possibility would be to put it in Documentation/technical/transport=
=2Etxt
or some similarly named new file.  Later that file could expand to an
overview of the transport layer, which would be nice to have.

=46iles in Documentation/technical do not get installed as manpages,
which would make this less convenient when writing a new helper
without a full documentation tree available.

More importantly, the =E2=80=9Chow to configure access to a foreign
repository=E2=80=9D aspect of what you are writing is really more perti=
nent to
users than remote helper developers.  Remote helper developers only
need to know =E2=80=9Cfirst argument is a remote nickname or some nonse=
nse
with a colon; second argument is a transport-native address
identifying the remote repository; second argument can be omitted only
if a remote nickname was used=E2=80=9D.

HTH,
Jonathan
