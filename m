From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 4/6] Squelch warning about an integer overflow
Date: Fri, 30 Oct 2015 19:18:57 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1510301918320.31610@s15462909.onlinehome-server.info>
References: <cover.1445865176.git.johannes.schindelin@gmx.de> <b0e4b6736cc2ec88e5f7cf587629d6a4d7e502d8.1445865176.git.johannes.schindelin@gmx.de> <xmqqpp01fkg5.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 30 19:19:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZsEGc-0006DO-8X
	for gcvg-git-2@plane.gmane.org; Fri, 30 Oct 2015 19:19:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760296AbbJ3STF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Oct 2015 14:19:05 -0400
Received: from mout.gmx.net ([212.227.15.18]:54838 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760275AbbJ3STD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Oct 2015 14:19:03 -0400
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx003) with ESMTPSA (Nemesis) id 0MFMEG-1Zg4ec1rxU-00ELvo;
 Fri, 30 Oct 2015 19:18:58 +0100
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <xmqqpp01fkg5.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:atmE+Ao3B94Omwy4oiVJ+AyD6BX1MWFI9Ac8WgcQcoGYZ3sXZxH
 nUDmwDeslNN9Ky75yjrFUjorMFS7H5ljoANVPsB9jqz5E4BTMrpI3n6jz3vYmVEiD6IH3fC
 L11GSXYTfDA49moE1ginr+EbX/IJEbNdlFh6WEOR3/YdtP9x2u6unDUfE9SGZ9jkFT6i6sk
 7xeWKeRQJvfVtUlgMf0aw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:EJHB0RuQDA0=:w9kJ/Sr+DmsBt91p0vy10L
 0jVHF/RgmhywieglBM0ph6AEB+l72750WemOfi4WJYgoZ2X/lHVMreXpxBvFb5O8vry5SA/cC
 vXdQq5WAPdUu/yieIsCHVdYR1QBJ7quTu0+/Z9QXrXuI0vY4jhLmSeZud6tEjeAyea6BB9MOg
 kVxVkfz7dkGe7IN/WSnlB07JsR2mpE+WG4esg17l9A1QqD0ULQolu9bJbrKn79i7i+ULiZWKR
 76xHKBElIBA4lmGG1+FVNUrt7gB9SqX/CadTuIZ3by87ASp6K1V0Lk02e97qijz7I2r6LtApt
 ix+lRZv1yOp0mngGBTIjAGDS/778iNSXR4wqPPuIQe2JUYXuEEXU2emGplJPFdaHqPBT3GuNK
 wTJ0M2+UtHmdJdvhRK3hPzPQToIVRaURXSGpTV8GmNEIwMlI6945hIqbTOjfzEp5l6b2qKnFX
 IV7uW9YUy8j5WI74zQPLmJ+nnz3nuVZHlQfNYXeu2XbCAGfNJ9URT1dc5APfBbp+syG4+rBN4
 DO+Jp1eU2MAuK0YS2oJl4ceVCCA5x/x8IcRFllvCYgDJVZZA+jAYiNH6P4+FzveJseVoPV5TR
 KobEcjS6Vds53QH1pknQOssXGfHbsFAsBNnJ3cjW/MEMZLMAr60oWgZ6OHmnG6Qnz6ALu8EDs
 +f48JSHISYNffUDVjeHVz3yGiAKbXoalBYcXq2S8Ij5t/zJ680y01fpWyfjFdqyVI87Bp/NxY
 PzFpYbZTTvtI0joNf5DN7KptECnR2hJK7dniKJ6x3ImgX8Y5gD6mhHckQpZZ0upxNO87wwV7 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280506>

Hi Junio,

On Mon, 26 Oct 2015, Junio C Hamano wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> > We cannot rely on long integers to have more than 32 bits...
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> 
> Interesting.  8192 * 1024 * 1024 does not fit within 32-bit long, of
> course.  Perhaps we can lose L after 1024 if we are explicitly
> saying that the result ought to be size_t (which may be larger than
> long)?

Sure. But it would make the patch harder to read.

Do you insist?

Ciao,
Dscho
