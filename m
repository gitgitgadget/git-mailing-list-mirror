From: Fredrik Gustafsson <iveqy@iveqy.com>
Subject: Re: GSOC proposal
Date: Fri, 25 Mar 2011 11:06:00 +0100
Message-ID: <20110325100600.GA30376@paksenarrion.iveqy.com>
References: <20110324220104.GA18721@paksenarrion.iveqy.com>
 <4D8BD358.1030603@web.de>
 <7vtyes6pya.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Fredrik Gustafsson <iveqy@iveqy.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 25 10:54:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q33it-0005bT-RZ
	for gcvg-git-2@lo.gmane.org; Fri, 25 Mar 2011 10:54:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754148Ab1CYJyW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 25 Mar 2011 05:54:22 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:55803 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753564Ab1CYJyV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Mar 2011 05:54:21 -0400
Received: by bwz15 with SMTP id 15so771018bwz.19
        for <git@vger.kernel.org>; Fri, 25 Mar 2011 02:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=/irYjkf5h0bUmOOyEyaMnefJVwu0ZKAXsfRlVWc45zQ=;
        b=CcBcX8MCSdNvUiDRv1XUKbHolqwDilpvB8Ii2mK89awoXF+d/vejn5DV0Zp3J2KjYe
         oCQR1QkQBr8//XtfLySSTgHjNTJjdmRqWQrmju70lDMR9LKtUo4pvrQ4sMwE1v61EDdD
         MRPkBfkH9oL0ivFqRHW2bEhCANy/CLvUUaDsw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=ADf1mFYtdz3jj0nMNfq7dT8LPotWUKm+xIRYNESIXmnXnh8xF7u7dL5uz+M4BDQhsY
         5rDB0j0cXKprFxZXqDW3RSh/C4X+iR9txBDn5h1d19XXYkyPTyIeEIZDNq+Fm6UylzkX
         FcjDutw8+3Tk8ZbpCVKG4nFrYH2trhbV+/YJw=
Received: by 10.204.133.91 with SMTP id e27mr544620bkt.23.1301046859770;
        Fri, 25 Mar 2011 02:54:19 -0700 (PDT)
Received: from paksenarrion.iveqy.com (h-185-240.A189.priv.bahnhof.se [85.24.185.240])
        by mx.google.com with ESMTPS id l1sm596962bkl.1.2011.03.25.02.54.17
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 25 Mar 2011 02:54:17 -0700 (PDT)
Received: from iveqy by paksenarrion.iveqy.com with local (Exim 4.72)
	(envelope-from <iveqy@paksenarrion.iveqy.com>)
	id 1Q33u4-00080g-7D; Fri, 25 Mar 2011 11:06:00 +0100
Content-Disposition: inline
In-Reply-To: <7vtyes6pya.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169975>

On Thu, Mar 24, 2011 at 04:47:41PM -0700, Junio C Hamano wrote:
> Jens Lehmann <Jens.Lehmann@web.de> writes:
>=20
> >> =3D=3D Preventing false "pointers" =3D=3D
> >> It's far too easy to push a gitrepo pointing to a submodule versio=
n that
> >> is not existing on the server. Prevent this by checking for availa=
ble
> >> submodule versions before acceptingt the push.
> >
> > Yes, requiring to force such a push is an issue raised quite often =
(I
> > think addressing this issue would be a good starting point for peop=
le
> > who want to get involved in enhancing the submodule experience).
>=20
> You need to be careful, though.
>=20
> That check can only be sanely done at a hosting site that hosts _both=
_ the
> superproject and the submodule repositories.  It might make more sens=
e to
> have this check on the side that pushes, which by definition should h=
ave
> both superprojet and the submodule.  Fail, or prompt to confirm, a pu=
sh
> from the superproject when it is detected that the submodule commits =
bound
> to the commits in the superproject have not been pushed out.

I can see three different ways of doing this:
1. the reciever (server) checks for available submodules before
accepting a commit

2. the sender checks for available submodules on the server before
sending a commit.

3. each submodule contains a flag that tells if the last command was a
commit or a push. The core-repository wont allow a push if one (or more=
)
submodules has a commit as "last command".

Although alternative 1 is the only one that is certain of preventing th=
e
problem with "false pointers", it has several other drawbacks. I believ=
e
that alt. 3 is the proper way of handling this in git. Although we
doesn't guarantee a sane server-repo we does prevent the client from
doing stupid things by mistake.

--=20
Med v=E4nliga h=E4lsningar
=46redrik Gustafsson

tel: 0733-608274
e-post: iveqy@iveqy.com
