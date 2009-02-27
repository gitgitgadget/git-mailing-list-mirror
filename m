From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH] rebase -i: avoid 'git reset' when possible
Date: Fri, 27 Feb 2009 14:03:21 +0100
Message-ID: <fabb9a1e0902270503p4b769a48xaef5978f0f05797@mail.gmail.com>
References: <fabb9a1e0902260655g53fa1e1fg7e4aa76b0f3a80fc@mail.gmail.com>
	 <alpine.DEB.1.00.0902261557300.6258@intel-tinevez-2-302>
	 <fabb9a1e0902260733k26e5c02i75a7866f9a67530b@mail.gmail.com>
	 <alpine.DEB.1.00.0902271146460.6600@intel-tinevez-2-302>
	 <alpine.DEB.1.00.0902271354130.6600@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Stephen Haberman <stephen@exigencecorp.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Thomas Rast <trast@student.ethz.ch>,
	Git Mailing List <git@vger.kernel.org>,
	Stephan Beyer <s-beyer@gmx.net>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Feb 27 14:06:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ld2Ob-0004Yh-Nv
	for gcvg-git-2@gmane.org; Fri, 27 Feb 2009 14:04:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752514AbZB0ND0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 27 Feb 2009 08:03:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751598AbZB0NDZ
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Feb 2009 08:03:25 -0500
Received: from mail-fx0-f176.google.com ([209.85.220.176]:54580 "EHLO
	mail-fx0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750831AbZB0NDZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 27 Feb 2009 08:03:25 -0500
Received: by fxm24 with SMTP id 24so1036812fxm.37
        for <git@vger.kernel.org>; Fri, 27 Feb 2009 05:03:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=usPBTQpQQ+3OFEundVY6NYX1g1l67bvNcLKI09g0OCs=;
        b=oB74cHapXHGZjJTMmuFn4BWH6QMr5nxlBZR9CzZsn1OT6uh7EV2/xHvK4dkECy/3yt
         QTw03Hm8XhYyKcJmTQp4TdPN6nONFBZ+NwGlLhDWwliTh+lUpsUwrFMubTcWvwfEPpEz
         sVUYGNWUJIhiX/RPJXOiLwWa01K54voV39LH0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=hVN71UzEXBLFKEhJzcNbi4hPS9qiXtModcUb+o9Qybl6VsydWt4fsRrAQl8gT5igUQ
         2sVHvtyrbVRGkY3rd5tWeQYqHrWXmC2RzMyap47QWrmPgy61qXYOQubo2F9d4g6Od5Yb
         gxZedx6gXEiUmMVj6rm3UExRUDId0NgO8YN0o=
Received: by 10.103.247.14 with SMTP id z14mr1287979mur.70.1235739801759; Fri, 
	27 Feb 2009 05:03:21 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.0902271354130.6600@intel-tinevez-2-302>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111669>

Heya,

On Fri, Feb 27, 2009 at 13:56, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> When picking commits whose parents have not changed, we do not need t=
o
> rewrite the commit. =A0We do not need to reset the working directory =
to
> the parent's state, either.

Awesome, I will give this a spin when I get home.

>> Having said that, I think yours might be such a common case that
>> it is worth optimizing for.
>
>=A0And so I did.

Very nice, I don't think I couldof done it anywhere near as fast ;).

--=20
Cheers,

Sverre Rabbelier
