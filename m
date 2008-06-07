From: Pieter de Bie <pdebie@ai.rug.nl>
Subject: Re: [PATCH v2] builtin-fast-export: Add importing and exporting of revision marks
Date: Sat, 7 Jun 2008 15:06:01 +0200
Message-ID: <DB158BDE-70D1-4779-9B03-A85C60EB2FA7@ai.rug.nl>
References: <BEF1F17D-6F0F-4F09-9CC4-B193B8907901@ai.rug.nl> <1212663163-43064-1-git-send-email-pdebie@ai.rug.nl> <7v8wxirwi1.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v924)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailinglist <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 07 15:07:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4y8N-0002XZ-19
	for gcvg-git-2@gmane.org; Sat, 07 Jun 2008 15:07:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754519AbYFGNGK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 7 Jun 2008 09:06:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754179AbYFGNGJ
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Jun 2008 09:06:09 -0400
Received: from smtp-1.orange.nl ([193.252.22.241]:53962 "EHLO smtp-1.orange.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753314AbYFGNGI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 7 Jun 2008 09:06:08 -0400
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf6001.orange.nl (SMTP Server) with ESMTP id AD9E31C000A3;
	Sat,  7 Jun 2008 15:06:02 +0200 (CEST)
Received: from [192.168.1.11] (s5591931c.adsl.wanadoo.nl [85.145.147.28])
	by mwinf6001.orange.nl (SMTP Server) with ESMTP id 36EE11C0009F;
	Sat,  7 Jun 2008 15:06:02 +0200 (CEST)
X-ME-UUID: 20080607130602225.36EE11C0009F@mwinf6001.orange.nl
In-Reply-To: <7v8wxirwi1.fsf@gitster.siamese.dyndns.org>
X-Mailer: Apple Mail (2.924)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84200>


On 7 jun 2008, at 01:09, Junio C Hamano wrote:

> I am confused.
>
> The type of object_decoration.decorattion is a (void*).  Why isn't it
> sufficient to do it in a na=EFve and straightforward way?
>
> 	mark =3D (uint32_t)(deco->decoration);
>        add_decoration(&idnums, object, (void*) mark);
>
> Is this twisted pointer arithmetic done in order to avoid cast =20
> between int
> and pointer of different size in the code?

I'm not sure why this is done; I simply copied what the existing code =20
already
did.

>  Even if that is the case,
> doesn't "(uint32_t *)deco->decoration - (uint32_t *)NULL" mean the =20
> value
> range for deco->decoration is one-fourth of U32?

I'd imagine so, yes

- Pieter
