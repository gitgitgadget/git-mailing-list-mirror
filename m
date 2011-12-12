From: Leif Gruenwoldt <leifer@gmail.com>
Subject: Re: [RFC/PATCH] add update to branch support for "floating submodules"
Date: Mon, 12 Dec 2011 13:04:42 -0500
Message-ID: <CALFF=ZRYB1LkAY5WSC4Eydu-N0KNnWLLM2CfbSXZji18yO82gw@mail.gmail.com>
References: <20111109174027.GA28825@book.fritz.box> <7vr51htbsy.fsf@alter.siamese.dyndns.org>
 <20111129220854.GB2812@sandbox-rc.fritz.box> <loom.20111210T062013-538@post.gmane.org>
 <7vborhaqgw.fsf@alter.siamese.dyndns.org> <CALFF=ZQKRgx_AodBQH17T9cSe_JFtoKie7DoMMfkTXCyCFospw@mail.gmail.com>
 <4EE61EED.50604@ursus.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "Andreas T.Auer" <andreas.t.auer_gtml_37453@ursus.ath.cx>
X-From: git-owner@vger.kernel.org Mon Dec 12 19:05:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RaAFe-0008PI-NS
	for gcvg-git-2@lo.gmane.org; Mon, 12 Dec 2011 19:05:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753804Ab1LLSFR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 12 Dec 2011 13:05:17 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:46594 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751373Ab1LLSFN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Dec 2011 13:05:13 -0500
Received: by iaeh11 with SMTP id h11so3511255iae.19
        for <git@vger.kernel.org>; Mon, 12 Dec 2011 10:05:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=zbJpBSt+xLTjjg+evr0WYqlAex0s7pG0Hi48tlIPsOI=;
        b=RsMlGsY7iIt3jjL0FusG2QMtOpxboQtec5bNlEvOgmLS7NGg64vwVEEQS/Kwn3iEzT
         CchGBCAlDARAW4SrSbAxs5vyLk87pCzBo3Uk+1xFxRjGDxBO7pE/YeVl8/QYtDMNsBz1
         cdAWwMEsFuzUkcWfvMlCdesuLxDrPmVSwQdvg=
Received: by 10.42.163.200 with SMTP id d8mr12807284icy.41.1323713113157; Mon,
 12 Dec 2011 10:05:13 -0800 (PST)
Received: by 10.231.1.32 with HTTP; Mon, 12 Dec 2011 10:04:42 -0800 (PST)
In-Reply-To: <4EE61EED.50604@ursus.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186921>

On Mon, Dec 12, 2011 at 10:34 AM, Andreas T.Auer
<andreas.t.auer_gtml_37453@ursus.ath.cx> wrote:

> So you don't want to have a stale submodule as Junio suggested, which=
 is
> older than the gitlinked commit in the superproject, but you want to =
have
> the newest stable version, which is not yet gitlinked in the superpro=
ject,
> right?

Right.

> Wouldn't =A0( cd commonlib ; git pull stable ) instead of
> git submodule update commonlib
> work as you want?

Yes that's how we perform business now.

> To be able to configure this update behavior in .gitmodules for _some=
_
> submodules, could be helpful in this case.

Yes my thoughts exactly.


> So you don't want to add a new commit to the products A, B and C repo=
s
> whenever the stable branch of the submodule changes, but on the other=
 hand
> when you commit changes to the products it would still make sense to =
update
> the gitlink to the current commonlib version together with your chang=
es,
> =A0too, right?

Hmm I supose that does make sense. If the commonlib version was auto re=
corded
during a commit of the product it would be nice. Then if/when the user
reconfigured
the submodule from "floating" to "strict" mode it would then have a
submodule sha1
reference. I like how this sounds.
