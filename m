From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 2/8] revert: use run_command_v_opt() instead of execv_git_cmd()
Date: Tue, 1 Jun 2010 06:33:08 +0200
Message-ID: <201006010633.08864.chriscool@tuxfamily.org>
References: <20100531193359.28729.55562.chriscool@tuxfamily.org> <20100531194240.28729.9964.chriscool@tuxfamily.org> <20100601040115.GA22401@progeny.tock>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 01 06:33:28 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OJJAJ-0000SA-SG
	for gcvg-git-2@lo.gmane.org; Tue, 01 Jun 2010 06:33:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751171Ab0FAEdT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 Jun 2010 00:33:19 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:33785 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751140Ab0FAEdS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 Jun 2010 00:33:18 -0400
Received: from style.localnet (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 3A05F81804E;
	Tue,  1 Jun 2010 06:33:10 +0200 (CEST)
User-Agent: KMail/1.12.2 (Linux/2.6.31-20-generic; KDE/4.3.2; x86_64; ; )
In-Reply-To: <20100601040115.GA22401@progeny.tock>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148076>

On Tuesday 01 June 2010 06:01:15 Jonathan Nieder wrote:
> Christian Couder wrote:
> > diff --git a/builtin/revert.c b/builtin/revert.c
> > index 5df0d69..9085894 100644
> > --- a/builtin/revert.c
> > +++ b/builtin/revert.c
> > @@ -530,7 +530,7 @@ static int revert_or_cherry_pick(int argc, cons=
t char
> > **argv) args[i++] =3D defmsg;
> >  		}
> >  		args[i] =3D NULL;
> > -		return execv_git_cmd(args);
> > +		return run_command_v_opt(args, RUN_GIT_CMD);
> >  	}
> >  	free_message(&msg);
> >  	free(defmsg);
>=20
> Doesn=E2=80=99t this leak msg and defmsg?  Maybe it would make sense =
to free
> the in-core copy of the commit message before the if (!no_commit)
> block.

Yes, I will have a look at it.

Thanks,
Christian.
