From: Carlos =?ISO-8859-1?Q?Mart=EDn?= Nieto <cmn@elego.de>
Subject: Re: [PATCH] remote: filter out invalid remote configurations
Date: Fri, 30 Aug 2013 14:41:49 +0200
Message-ID: <1377866509.1714.0.camel@centaur.cmartin.tk>
References: <1377608796-13732-1-git-send-email-cmn@elego.de>
	 <xmqqr4dffarq.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 30 14:42:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VFO1d-0007zm-F0
	for gcvg-git-2@plane.gmane.org; Fri, 30 Aug 2013 14:42:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756514Ab3H3Mls convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 30 Aug 2013 08:41:48 -0400
Received: from mx0.elegosoft.com ([78.47.87.163]:57405 "EHLO mx0.elegosoft.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756459Ab3H3Mlp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Aug 2013 08:41:45 -0400
Received: from localhost (localhost [127.0.0.1])
	by mx0.elegosoft.com (Postfix) with ESMTP id 3C0B0DFA6E;
	Fri, 30 Aug 2013 14:41:44 +0200 (CEST)
Received: from mx0.elegosoft.com ([127.0.0.1])
	by localhost (mx0.elegosoft.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id p9nHGHDCCaQd; Fri, 30 Aug 2013 14:41:44 +0200 (CEST)
Received: from [192.168.1.4] (p57A1FC8F.dip0.t-ipconnect.de [87.161.252.143])
	by mx0.elegosoft.com (Postfix) with ESMTPSA id 0D440DFA6A;
	Fri, 30 Aug 2013 14:41:44 +0200 (CEST)
In-Reply-To: <xmqqr4dffarq.fsf@gitster.dls.corp.google.com>
X-Mailer: Evolution 3.4.4-4+b1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233439>

On Tue, 2013-08-27 at 07:50 -0700, Junio C Hamano wrote:
> Carlos Mart=C3=ADn Nieto <cmn@elego.de> writes:
>=20
> > In remote's configuration callback, anything that looks like
> > 'remote.<name>.*' creates a remote '<name>'. This remote may not en=
d
> > up having any configuration for a remote, but it's still in the lis=
t,
> > so 'git remote' shows it, which means something like
> >
> >     [remote "bogus"]
> >         hocus =3D pocus
> >
> > will show a remote 'bogus' in the listing, even though it won't wor=
k
> > as a remote name for either git-fetch or git-push.
>=20
> Isn't this something the user may want to be aware of, though?
> Hiding these would rob a chance for such an entry to be noticed from
> the user---is it a good change?

If we want to help the user know that there's something a bit odd in
their configuration, shouldn't we tell them instead of hoping they
stumble upon it? Otherwise IMO it's more confusing if git-remote does
show the remote when git-fetch is interpreting the argument as a path.

   cmn
