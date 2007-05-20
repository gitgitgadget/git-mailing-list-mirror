From: "Fernando J. Pereda" <ferdy@ferdyx.org>
Subject: Re: [PATCH] Teach mailsplit about Maildir's
Date: Sun, 20 May 2007 21:18:21 +0200
Message-ID: <20070520191821.GF13197@ferdyx.org>
References: <20070520181447.GA10638@ferdyx.org> <7v7ir3mjfa.fsf@assigned-by-dhcp.cox.net> <200705202053.32291.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Sun May 20 21:18:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HpqvZ-00027y-8R
	for gcvg-git@gmane.org; Sun, 20 May 2007 21:18:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759230AbXETTSf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 20 May 2007 15:18:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759255AbXETTSf
	(ORCPT <rfc822;git-outgoing>); Sun, 20 May 2007 15:18:35 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:60042 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756938AbXETTSe (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 May 2007 15:18:34 -0400
Received: by ug-out-1314.google.com with SMTP id 44so986221uga
        for <git@vger.kernel.org>; Sun, 20 May 2007 12:18:30 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:date:from:to:cc:subject:message-id:mail-followup-to:references:mime-version:content-type:content-disposition:content-transfer-encoding:in-reply-to:user-agent:sender;
        b=hbhfUPyF4PwvwOoDAjj+bO2cM2s/JZwUD1AZtsXVM43UnF+UFmmbNGzPAqcb5De3x7cp+UYLefPVFvXqZ4j/CPgOuHOvINqj6fxNTHl5oTbd0DF4tc6RjubDz+KPxXciTEtRkMNgyi0XHeRfnw2VfptX7JESD7Dn/+706lWWBpA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:date:from:to:cc:subject:message-id:mail-followup-to:references:mime-version:content-type:content-disposition:content-transfer-encoding:in-reply-to:user-agent:sender;
        b=CtTjPBz37LBrVqkr/11vlROIX9yoojTZc8HT34JzKDpqC8/4GQEGxyXp0Q1KCJL0choiUI1XpOuanszPIhNJPUZDTEL5Z5IGPNimp6glVRZ1rHO7W3KI9vnQLBGcuAgY158ufKCd+8amGkpJjifh9redNE7zkDRds0Bs40oy8co=
Received: by 10.67.101.10 with SMTP id d10mr2833788ugm.1179688707332;
        Sun, 20 May 2007 12:18:27 -0700 (PDT)
Received: from posidon.ferdyx.org ( [213.96.222.170])
        by mx.google.com with ESMTP id k28sm6258355ugd.2007.05.20.12.18.23;
        Sun, 20 May 2007 12:18:26 -0700 (PDT)
Received: by posidon.ferdyx.org (nbSMTP-1.01-cvs) for uid 1000
	(using TLSv1/SSLv3 with cipher DES-CBC3-SHA (168/168 bits))
	ferdy@ferdyx.org; Sun, 20 May 2007 21:18:24 +0200 (CEST)
Mail-Followup-To: "Fernando J. Pereda" <ferdy@ferdyx.org>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org,
	Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <200705202053.32291.johan@herland.net>
User-Agent: Mutt/1.5.15 (2007-04-06)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47893>

On Sun, May 20, 2007 at 08:53:32PM +0200, Johan Herland wrote:
> I use KMail with Maildir for all my mail, except for my "patches" mai=
l folder=20
> where I copy patches to import into my repos (which is in mbox format=
).=20
> KMail makes it easy to mix mbox and Maildir folders, so it's not real=
ly a=20
> big deal for me, but I would of course prefer Maildir support if it's=
=20
> possible to get it right.
>=20
> Not sure how I feel about the usefulness of the patch if it requires =
correct=20
> sorting, and most mail clients turn out to _not_ sort correctly. Of c=
ourse=20
> I have no idea what most mail clients do, but KMail seems to get it a=
bout=20
> right, AFAICS (mail filename starts with timestamp, so they're at lea=
st=20
> sorted roughly on (arrival) date).

[ I sent this only to Johan, re-sending to the rest of the people now.
Sorry Johan for the dupe ]

I discussed this with a pine user in #git and we concluded (looking at
the respective code) that both Mutt and Pine generate correct filenames
based on when that mail arrived to the Maildir.

I use Mutt, and to test it I picked a thread that didn't arrive in
order, tagged and copied it to a different Maildir, patches were
splitted in correct order.

- ferdy

--=20
=46ernando J. Pereda Garcimart=EDn
20BB BDC3 761A 4781 E6ED  ED0B 0A48 5B0C 60BD 28D4
