From: Brian Foster <brian.foster@innova-card.com>
Subject: Re: [Q] merging from one (kernel) stable to another?
Date: Mon, 30 Mar 2009 14:40:43 +0200
Message-ID: <200903301440.43601.brian.foster@innova-card.com>
References: <200903301024.08848.brian.foster@innova-card.com> <200903301358.48864.brian.foster@innova-card.com> <49D0B8BC.2010405@viscovery.net>
Reply-To: Brian Foster <brian.foster@innova-card.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Andreas Ericsson <ae@op5.se>,
	git mailing list <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon Mar 30 14:43:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LoGp9-0007sD-0Z
	for gcvg-git-2@gmane.org; Mon, 30 Mar 2009 14:42:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752088AbZC3MlM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 Mar 2009 08:41:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751732AbZC3MlL
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Mar 2009 08:41:11 -0400
Received: from ey-out-2122.google.com ([74.125.78.27]:36235 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750941AbZC3MlK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 Mar 2009 08:41:10 -0400
Received: by ey-out-2122.google.com with SMTP id 4so594053eyf.37
        for <git@vger.kernel.org>; Mon, 30 Mar 2009 05:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:reply-to:to
         :subject:date:user-agent:cc:references:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :message-id;
        bh=4Ee78UCAI68KgAUixXbVaoTHWmTEnoaNcSGzYBUfvUo=;
        b=GsdenPk9GtZIbOLgcBc8DdJqunLzyK1nUjNaQRcvKE3Yg7kiVYXEbthw+J9vtVkDNI
         Qr3WtMKO25BaZ1SJXBcwOUMcIZhcPFytLgO9VrB3eC2SdrFa3PaOAeMCxv2CyQZ3jy+O
         z/va3t12QJySZJmQ8xLW4VDeUsWeU3fTNRYU0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:reply-to:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=mscJI2ZUGpZV7D/eA7TUNMhyxwgJRV9+xNhhqx20iPz5vwXG+afJNnqjy6V4j0sw9A
         YvKLIAs3RWQ4ZRBQ9CfXFzKOfsrZeEU+bop5mq8fQC07D1uSFpbWj0QsD6vgRzqT1hSa
         T54vCGWMazLq+t+yqGFcNIpDg99ysYO0pF9ZQ=
Received: by 10.210.66.13 with SMTP id o13mr2573522eba.96.1238416866784;
        Mon, 30 Mar 2009 05:41:06 -0700 (PDT)
Received: from innova-card.com (LRouen-152-82-23-47.w80-13.abo.wanadoo.fr [80.13.118.47])
        by mx.google.com with ESMTPS id 7sm5370082ewy.82.2009.03.30.05.41.04
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 30 Mar 2009 05:41:06 -0700 (PDT)
User-Agent: KMail/1.10.4 (Linux/2.6.27-11-generic; KDE/4.1.4; x86_64; ; )
In-Reply-To: <49D0B8BC.2010405@viscovery.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115145>

On Monday 30 March 2009 14:19:08 Johannes Sixt wrote:
> Brian Foster schrieb:
>[ ... ]
> >   Thanks for the suggestion.  I'll have to experiment,
> >  but off-the-top-of-my-head, I think I do want a merge,
> >  so that it's easier to track the history of individual
> >  local changes.  Having said that, I'm not entirely sure
> >  I follow your suggestions.  What I think you mean is:
> >=20
> >   (1)  Create a patch which is all (local) changes
> >          (n=C3=A9e diffs) from linux-mips.21 to our.21;
> >   (2)  Checkout linux-mips.26.8 (e.g.);
> >   (3)  Apply the patch created in (1), above;
>=20
> format-patch creates a patch series.  You apply the whole series,
> e.g. with 'git am'. But for this workflow you could also just create
> a single patch and apply it to linux-mips.26.8, just as you wrote.

  Point taken.  I was being a bit sloppy there; I well know
 `git format-patch' (which we use in our internal workflow)
 generates a patch series, and that `git am' applies them.
 Apologies for the confusion.  Sorry!

> The important point is that you forge this tree into the shape that
> you finally want to have in the merge (that you will make later).
> At this point you only have to deal with conflicts and regressions
> that arise from your own changes, which makes your life much easier
> than if you also had to deal with conflicts that are outside your
> own changes.

  Gottcha.  Thanks for clarifying.

> >   (4)  Tag the result `like-this';
> >   (5)  Checkout our.21;  and
> >   (6)  Merge with `like-this'.
>=20
> No, you merge with linux-mips.26.8. This will again give you a lot
> of conflicts. But you do
>=20
>    (7) git checkout like-this -- .
>=20
> that is, you overwrite the merge result (that has conflicts) with
> your known-good tree called "like-this". This resolves all conflicts
> in the way that you wanted them.

  Ah!  Neat.  I think I get it (er, git it?) now ....
 Many thanks for your patient and very helpful replies!
cheers!
	-blf-

--=20
=E2=80=9CHow many surrealists does it take to   | Brian Foster
 change a lightbulb? Three. One calms   | somewhere in south of France
 the warthog, and two fill the bathtub  |   Stop E$$o (ExxonMobil)!
 with brightly-coloured machine tools.=E2=80=9D |      http://www.stope=
sso.com
