From: Jon Loeliger <jdl@freescale.com>
Subject: Re: [PATCH 3/3] pretty=format: Avoid some expensive calculations
	when not needed
Date: Mon, 05 Nov 2007 14:25:51 -0600
Message-ID: <1194294351.7158.41.camel@ld0161-tx32>
References: <Pine.LNX.4.64.0711041912190.4362@racer.site>
	 <Pine.LNX.4.64.0711041915290.4362@racer.site>
	 <7v8x5cqxn0.fsf@gitster.siamese.dyndns.org>
	 <472F7B2F.4050608@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git List <git@vger.kernel.org>
To: =?ISO-8859-1?Q?Ren=E9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Mon Nov 05 21:27:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ip8XL-0007ba-JZ
	for gcvg-git-2@gmane.org; Mon, 05 Nov 2007 21:27:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753529AbXKEU0y convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 5 Nov 2007 15:26:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753009AbXKEU0y
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Nov 2007 15:26:54 -0500
Received: from az33egw02.freescale.net ([192.88.158.103]:57235 "EHLO
	az33egw02.freescale.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752860AbXKEU0x (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Nov 2007 15:26:53 -0500
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id lA5KPqVB003493;
	Mon, 5 Nov 2007 13:25:52 -0700 (MST)
Received: from ld0161-tx32 (ld0161-tx32.am.freescale.net [10.82.19.111])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id lA5KPpPn016880;
	Mon, 5 Nov 2007 14:25:51 -0600 (CST)
In-Reply-To: <472F7B2F.4050608@lsrfire.ath.cx>
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-17) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63548>

On Mon, 2007-11-05 at 14:21, Ren=C3=A9 Scharfe wrote:

> How about (ab)using the value field?  Let interp_find_active() mark
> unneeded entries with NULL, and the rest with some cookie.  All table
> entries with non-NULL values need to be initialized.  interp_set_entr=
y()
> needs to be aware of this cookie, as it mustn't free() it.  The cooki=
e
> could be the address of a static char* in interpolate.c.

Or adding a "flags/properties" field and having it
note things like static entries, active, etc...?

jdl
