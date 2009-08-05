From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: [PATCH 3/3] transport: don't show push status if --quiet is given
Date: Wed, 5 Aug 2009 20:29:13 +0000
Message-ID: <32541b130908051329w43882ca6ne0824b01da3948aa@mail.gmail.com>
References: <20090805201937.GB9004@coredump.intra.peff.net> 
	<20090805202326.GC23226@coredump.intra.peff.net> <fabb9a1e0908051327l74e06afdvf3b35b5abde2e140@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Nicolas Pitre <nico@cam.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Albert Astals Cid <aacid@kde.org>,
	Junio C Hamano <gitster@pobox.com>,
	Pau Garcia i Quiles <pgquiles@elpauer.org>,
	git@vger.kernel.org
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 05 22:29:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYn7E-0004fZ-LK
	for gcvg-git-2@gmane.org; Wed, 05 Aug 2009 22:29:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752635AbZHEU3d convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 5 Aug 2009 16:29:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752629AbZHEU3d
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Aug 2009 16:29:33 -0400
Received: from mail-yx0-f175.google.com ([209.85.210.175]:44662 "EHLO
	mail-yx0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752608AbZHEU3c convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 5 Aug 2009 16:29:32 -0400
Received: by yxe5 with SMTP id 5so455012yxe.33
        for <git@vger.kernel.org>; Wed, 05 Aug 2009 13:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=IfI2Xtmf4zHkWkadpCFlKZebLfAB+PxBekaccTMCxRo=;
        b=JTS1IHDTOk0t6oQwWGxhjScJCwMQjPNCsrHgHN38waoRbgOV6XNHLXRr07z1oavwCg
         DzwZR0dDs/35kwgfAmQ9hqajhR7NCNG9muNW7l0oDU6DGKDLsskxA9NSmwDOPVDGuf7u
         7CfbqdlyJrqkTq3fyhyyHgWu8qemmdPMiZ9iI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=i0KehmT5UxFwLOmZVVDPk9W5fWwSC4EEZkpbTFsc4kEKtVwnE58bY8y9y9KGS+KQsn
         ZWmVovzPbgvX/gihlaguAK/R9f9EReq8JaoDh2eAvdISl7qTgynosH86F2IlwYXPC6El
         4VHDSsQ68Gg+KotG6yPIiiv1SfpHHPV8itBAg=
Received: by 10.150.203.8 with SMTP id a8mr12345356ybg.134.1249504173087; Wed, 
	05 Aug 2009 13:29:33 -0700 (PDT)
In-Reply-To: <fabb9a1e0908051327l74e06afdvf3b35b5abde2e140@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124968>

On Wed, Aug 5, 2009 at 8:27 PM, Sverre Rabbelier<srabbelier@gmail.com> =
wrote:
> On Wed, Aug 5, 2009 at 13:23, Jeff King<peff@peff.net> wrote:
>> + =A0 =A0 =A0 for (; ref; ref =3D ref->next) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 switch (ref->status) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 case REF_STATUS_NONE:
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 case REF_STATUS_UPTODATE:
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 case REF_STATUS_OK:
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 default:
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 1;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 =A0 }
>
> Is my C getting sloppy or is this a non-looping loop? AFAICS it eithe=
r
> return 1's on the first run, or breaks?

The "break" in this case breaks out of the switch, not the for.

Avery
