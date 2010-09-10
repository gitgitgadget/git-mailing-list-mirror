From: Alejandro Riveira =?UTF-8?B?RmVybsOhbmRleg==?= 
	<ariveira@gmail.com>
Subject: Re: git-p4
Date: Fri, 10 Sep 2010 23:53:23 +0200
Message-ID: <20100910235323.773d2c5b@varda>
References: <4C8A8CE8.90600@borg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-kernel@vger.kernel.org, git@vger.kernel.org
To: Kent Borg <kentborg@borg.org>
X-From: git-owner@vger.kernel.org Fri Sep 10 23:54:07 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OuBXq-0007Vv-S0
	for gcvg-git-2@lo.gmane.org; Fri, 10 Sep 2010 23:54:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753160Ab0IJVxf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 10 Sep 2010 17:53:35 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:42242 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751504Ab0IJVxc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 10 Sep 2010 17:53:32 -0400
Received: by eyb6 with SMTP id 6so2095416eyb.19
        for <multiple recipients>; Fri, 10 Sep 2010 14:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:in-reply-to:references:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=trPW7HDfbOjnoLhzkB23c6gCNIPAndATOznDXrkJuWw=;
        b=wd48VgXpQLDGejK4LoxBAkA4DQQdhu4HPjhH7UxUTChmIf1BQH8AivBxZORCkDWqr8
         tBOVJn8HaFdrAIv99H9PwIH9ZXCRvJPbL6//MZcEnV3uW04TNN5znBoFpIUh2BR0OKCJ
         n9hU1dMcjrrXpQrMGQUpUUQDCVE4qvc7k+ZR0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer
         :mime-version:content-type:content-transfer-encoding;
        b=kij5Uf70MPHFFhCQQW2ekzo0qNcnrX4HYdArNcfgkLEanZPoViR3A14W1Jikp06lda
         oM3wsy5jUAj1xAnrXK5bWfblIfKBeoeC4b9E6ZDSLN5yNFoJ8qAFGx3HfOiwOJVf9rE9
         knoXzvb9Il7vkJoA33n/8QA9aE4WX+FUagwZ4=
Received: by 10.216.11.3 with SMTP id 3mr9465wew.89.1284155611144;
        Fri, 10 Sep 2010 14:53:31 -0700 (PDT)
Received: from varda ([83.44.220.95])
        by mx.google.com with ESMTPS id k46sm2057566weq.10.2010.09.10.14.53.28
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 10 Sep 2010 14:53:29 -0700 (PDT)
In-Reply-To: <4C8A8CE8.90600@borg.org>
X-Mailer: Claws Mail 3.7.6 (GTK+ 2.20.1; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155972>

El Fri, 10 Sep 2010 15:54:16 -0400
Kent Borg <kentborg@borg.org> escribi=C3=B3:

 [ CCing git mailing list. Looks like a better place to ask this questi=
on]

> I have a git-p4 question: I work in a Perforce shop and am doing Linu=
x
> kernel work, I need to share that work with colleagues who see the wo=
rld
> as a Perforce place.  The kernel I have came from Linus' tree and has=
 a
> lot of history.  When I try to do my first a "git p4 submit" it choke=
s
> as it looks back in the entire git history until it fails looking for
> the ancestor of the first commit (linux-2.6.12-rc2!), I think it is
> looking for the last time it did a git-p4 submit so it knows how far
> back to go--but it has never done a submit in this new relationship
> between p4 and git.  There is plenty of git history that is not
> reflected in p4, and I don't want it in p4, I just want new work in p=
4.
>=20
> I fear that git-p4 is for git people to contribute to bits natively
> p4-homed code, not this case where the code is natively git-homed cod=
e
> and it is the p4 people who will be contributing bits.=20
>=20
> My attempt at a work around was this:
>=20
>  - create a director on the p4 side, and from the p4 side submit the
> files that match my latest git submit.
>=20
>  - sync with git-p4
>=20
>  - try to submit a file with git-p4...and that fails as it runs all t=
he
> way back through the history.  (Thank goodness it didn't succeed in
> submitting kernel activity since 2005!)
>=20
>=20
> I was hoping I could merge the p4/master with master to force a stopp=
ing
> point in the git-p4 submit, but that doesn't work, it is searching
> through git history to find the stopping point.  What might I put in =
the
> git history to force the stop (or maybe make a change to git-p4 to he=
lp
> my plight along)?
>=20
>=20
> Thanks,
>=20
> -kb, the Kent who has always hated Perforce, alas.
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kerne=
l" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
