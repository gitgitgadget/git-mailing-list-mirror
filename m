From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH 1/4] sha1-lookup: add new "sha1_pos" function to 
	efficiently lookup sha1
Date: Sun, 5 Apr 2009 16:42:30 +0200
Message-ID: <fabb9a1e0904050742t6b0d9d5s116539adf8434fc9@mail.gmail.com>
References: <20090404225926.a9ad50e0.chriscool@tuxfamily.org> 
	<fabb9a1e0904050317o1399118erb15ddf86d0fe6c3c@mail.gmail.com> 
	<20090405144111.GB2076@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Christian Couder <chriscool@tuxfamily.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Apr 05 16:44:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LqTaA-0000zw-RK
	for gcvg-git-2@gmane.org; Sun, 05 Apr 2009 16:44:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753199AbZDEOmt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Apr 2009 10:42:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753152AbZDEOms
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Apr 2009 10:42:48 -0400
Received: from mail-fx0-f158.google.com ([209.85.220.158]:59524 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753078AbZDEOms (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Apr 2009 10:42:48 -0400
Received: by fxm2 with SMTP id 2so1549232fxm.37
        for <git@vger.kernel.org>; Sun, 05 Apr 2009 07:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :received:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=myyXRnbJIgptGPaQSPTbPh1HDOH6s5t/mzHH6azNvFk=;
        b=b5d0vkG2P1OiD8cti0mF+i2L6BOwT0XOROiP1rsIs/t4C1Rw+QHOb33RUp7rkn/kwW
         9SnlOMyZSHWqaEQ31AVXC7LSL61eDlScdwDrrxS3ZY7gVp2S+nC9nhDNf/fdxe5eYd/T
         GXzuouwOJKbi5EpRT0Kxd2VcGtdhtnPUDZ398=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Uzo1g+LjJ7wCudnY5qMvK7f3maA/fpaMRJJAnV6oCobzCfVNOUenoHAEyTsLA1zud7
         G69IVx4/FJi0norgDG2bs+twlHxMFGM3HVyGON7wmAR2GQvekFjkGmBN0fZvMl3Ussrx
         zcKOiNEWdjGvN1qij1mrlp/hHfSurw+5pcNxk=
In-Reply-To: <20090405144111.GB2076@sigill.intra.peff.net>
Received: by 10.103.92.8 with SMTP id u8mr1497424mul.12.1238942565251; Sun, 05 
	Apr 2009 07:42:45 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115669>

Heya,

On Sun, Apr 5, 2009 at 16:41, Jeff King <peff@peff.net> wrote:
> some examples of which you can see via "git grep BUG:".
>
> Of course, "binary search on fire?" would probably work, too.

Right, I'm thinking anything that makes it easier to find out what
went wrong later on would be better than just "oops".

-- 
Cheers,

Sverre Rabbelier
