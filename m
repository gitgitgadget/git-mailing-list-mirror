From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH 3/3] transport: don't show push status if --quiet is given
Date: Wed, 5 Aug 2009 13:27:20 -0700
Message-ID: <fabb9a1e0908051327l74e06afdvf3b35b5abde2e140@mail.gmail.com>
References: <20090805201937.GB9004@coredump.intra.peff.net> 
	<20090805202326.GC23226@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nicolas Pitre <nico@cam.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Albert Astals Cid <aacid@kde.org>,
	Junio C Hamano <gitster@pobox.com>,
	Pau Garcia i Quiles <pgquiles@elpauer.org>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Aug 05 22:27:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYn5S-0003ma-O7
	for gcvg-git-2@gmane.org; Wed, 05 Aug 2009 22:27:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752488AbZHEU1l convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 5 Aug 2009 16:27:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752446AbZHEU1l
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Aug 2009 16:27:41 -0400
Received: from mail-ew0-f214.google.com ([209.85.219.214]:34336 "EHLO
	mail-ew0-f214.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752265AbZHEU1k convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 5 Aug 2009 16:27:40 -0400
Received: by ewy10 with SMTP id 10so288010ewy.37
        for <git@vger.kernel.org>; Wed, 05 Aug 2009 13:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=Q6Vr6BI9b8bRISa9vPj7IiTYyhFVQz5XzDyqqrOLMG8=;
        b=Uh8gLxRORhtSHsvTm+k2RfaUX2F/5g48mpo6bwC+99cYbNc0Jv0bA0Et2h7mVJkQEP
         Nz3/F1CMjHtHzJe3dUQAI2oZZsbs7082SZ73BQolKJ7oQhkq15iBt4KkI4pX9CgW/ozR
         YN4sal97+xcmJWFOwOGlyPcPXleYRY4CAwB4k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=B8AXsyeok91b0lfjSzYJYSV8AokiQOM+l7i2Z23N3gh7F+Ai8f+lMkaHTPHrooOWRA
         hiGC+kVJuo0mTDPK9FeKfPFLsSiIQBQa47xGENNYf05rcZiFh1JsVH/M08/iK22Bl1+T
         yqHaDZsI7Y3geWm4uG8nkr/NLdMvsUDyW3yzU=
Received: by 10.216.91.15 with SMTP id g15mr1795925wef.24.1249504060152; Wed, 
	05 Aug 2009 13:27:40 -0700 (PDT)
In-Reply-To: <20090805202326.GC23226@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124967>

Heya,

On Wed, Aug 5, 2009 at 13:23, Jeff King<peff@peff.net> wrote:
> + =A0 =A0 =A0 for (; ref; ref =3D ref->next) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 switch (ref->status) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 case REF_STATUS_NONE:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 case REF_STATUS_UPTODATE:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 case REF_STATUS_OK:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 default:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 }

Is my C getting sloppy or is this a non-looping loop? AFAICS it either
return 1's on the first run, or breaks?

--=20
Cheers,

Sverre Rabbelier
