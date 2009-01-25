From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Heads up: major rebase -i -p rework coming up
Date: Sun, 25 Jan 2009 17:22:52 +0100
Message-ID: <200901251722.53392.jnareb@gmail.com>
References: <alpine.DEB.1.00.0901242056070.14855@racer> <glhqdi$tec$1@ger.gmane.org> <alpine.DEB.1.00.0901251509550.14855@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Thomas Rast <trast@student.ethz.ch>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Jan 25 17:23:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LR7lw-0007s4-OP
	for gcvg-git-2@gmane.org; Sun, 25 Jan 2009 17:23:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752904AbZAYQWV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 25 Jan 2009 11:22:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751286AbZAYQWT
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Jan 2009 11:22:19 -0500
Received: from ug-out-1314.google.com ([66.249.92.174]:56098 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750971AbZAYQWT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Jan 2009 11:22:19 -0500
Received: by ug-out-1314.google.com with SMTP id 39so87614ugf.37
        for <git@vger.kernel.org>; Sun, 25 Jan 2009 08:22:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=jQ+4QbpNnv+CNigAP/32wyma2S8Nf5XjiLagO4+B8Sk=;
        b=cf1HpnPdDCVm2qGNibGK9/NjbrKzv9zKctZ98le370TsFW8yZRrEgvqQ84OZAb8rzy
         CJuUERUaZhl/pO7beN9y+fSVbAdaAulWUBnhnN8XjWsUnsExDvsYnWIVOQ/XxwqkKZgP
         sz92Jsa5b6vxjBhj9V1AIU18UgoukPcPxpT/0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=AjQ7E6Kh0hD5e3CtN0tt7CH4zAuGsRGxlQCXimLOCt8/iNe2rejvcHzh1cuMjLmY0h
         CZrI4isr5pJcfFPLsRiphaLlXOSve+CWfZFnyqvWFvlB3O1y27vtuBShn/p9iNoN1xRx
         x2DmwuzIVKqUgyBgXbErWwl1WixVeH+1GRxgc=
Received: by 10.66.218.15 with SMTP id q15mr824720ugg.35.1232900537357;
        Sun, 25 Jan 2009 08:22:17 -0800 (PST)
Received: from ?192.168.1.11? (abxc190.neoplus.adsl.tpnet.pl [83.8.252.190])
        by mx.google.com with ESMTPS id s8sm2909390uge.18.2009.01.25.08.22.14
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 25 Jan 2009 08:22:15 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <alpine.DEB.1.00.0901251509550.14855@racer>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107065>

On Sun, 25 Jan 2009, Johannes Schindelin wrote:
> Hi,
>=20
> [please do not forget to Cc: me; today is a slow day, so I did not mi=
ss=20
>  your mail, but that is definitely not true on other days.]

This was spur of the moment idea, one that I wouldn't mind if you
would miss it.

But now that you have something interesting to say, I'll re-added
CC list for this thread.

> On Sun, 25 Jan 2009, Jakub Narebski wrote:
>> Johannes Schindelin wrote:
>>=20
>>>> Hmm. =A0You're right, that is not really intuitive. =A0How about
>>>>=20
>>>> =A0=A0=A0=A0=A0=A0merge (B) A # Merge...
>>>>=20
>>>> instead?
>>>=20
>>> Or even better:
>>>=20
>>> =A0=A0=A0=A0=A0=A0=A0=A0merge B parent A' # Merge...
>>=20
>> merge B with A' # Merge...=20
>=20
> No, that does not catch the meaning.

Errr... I didn't mean for 'with' to mean 'into'.
=20
> B is the _original_ merge commit.  So it actually knows what parents =
it=20
> has, but we want to give the user the freedom to change those parents=
=2E
>=20
> The first parent is easy: this will be HEAD at that stage.
>=20
> The other parents will be relatively easy: just replace A' by somethi=
ng=20
> else.
>=20
> _However_ now that the merge commit B will be _redone_, we _still_ wa=
nt to=20
> be able to refer to it later in the rebase script.  Therefore, rebase=
 has=20
> to know that we _redid_ B at this stage.
>=20
> Another idea:
>=20
> 	merge B Merge bla/blub
> 	parent A' bla/blub

It would be good idea... even better if 'p' shortcut was not taken
by 'pick'...

This is similar to your earlier idea:

        merge 9383af1' was f39d50a Merge branch 'mh/unify-color' into n=
ext
        #   \ 9383af1 Revert previous two commits


Or perhaps:

	merge A' D' into B Merge bla/blub

--=20
Jakub Narebski
Poland
